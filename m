Received: from eggs.gnu.org ([2001:4830:134:3::10]:54909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fdGwZ-0007FE-Vp
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 11:22:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fdGwW-0007yI-0t
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 11:22:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45554 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fdGwV-0007xn-Pt
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 11:22:11 -0400
Date: Wed, 11 Jul 2018 17:22:08 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180711172208.288fc0bb@redhat.com>
In-Reply-To: <20180710155037.16834-2-stefanha@redhat.com>
References: <20180710155037.16834-1-stefanha@redhat.com>
	<20180710155037.16834-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] qdev: add HotplugHandler->post_plug()
 callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, l00284672 <lizhengui@huawei.com>, Fam Zheng <famz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, 10 Jul 2018 16:50:36 +0100
Stefan Hajnoczi <stefanha@redhat.com> wrote:

> The ->pre_plug() callback is invoked before the device is realized.  The
> ->plug() callback is invoked when the device is being realized but  
> before it is reset.
> 
> This patch adds a ->post_plug() callback which is invoked after the
> device has been reset.  This callback is needed by HotplugHandlers that
> need to wait until after ->reset().
it seems other plug handlers would be also affected by this issue
if monitor lock wouldn't block them when guest tried to processes
hotplug notification and trapped back on MMIO happily waiting for
device_add to release lock before proceeding.

It also seems wrong to call _plug handler on maybe partially
initialized device so perhaps we should first finish devices/children
realization then do reset and only after that call _plug() handler

something like following should fix the issue:

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index cf0db4b..a80372d 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -830,6 +830,18 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
             goto fail;
         }
 
+        QLIST_FOREACH(bus, &dev->child_bus, sibling) {
+            object_property_set_bool(OBJECT(bus), true, "realized",
+                                         &local_err);
+            if (local_err != NULL) {
+                goto child_realize_fail;
+            }
+        }
+
+        if (dev->hotplugged) {
+            device_reset(dev);
+        }
+
         DEVICE_LISTENER_CALL(realize, Forward, dev);
 
         if (hotplug_ctrl) {
@@ -837,7 +849,7 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
         }
 
         if (local_err != NULL) {
-            goto post_realize_fail;
+            goto child_realize_fail;
         }
 
         /*
@@ -852,20 +864,9 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
                                                dev->instance_id_alias,
                                                dev->alias_required_for_version,
                                                &local_err) < 0) {
-                goto post_realize_fail;
-            }
-        }
-
-        QLIST_FOREACH(bus, &dev->child_bus, sibling) {
-            object_property_set_bool(OBJECT(bus), true, "realized",
-                                         &local_err);
-            if (local_err != NULL) {
                 goto child_realize_fail;
             }
         }
-        if (dev->hotplugged) {
-            device_reset(dev);
-        }
         dev->pending_deleted_event = false;
     } else if (!value && dev->realized) {
         Error **local_errp = NULL;
@@ -902,7 +903,6 @@ child_realize_fail:
         vmstate_unregister(dev, qdev_get_vmsd(dev), dev);
     }
 
-post_realize_fail:
     g_free(dev->canonical_path);
     dev->canonical_path = NULL;
     if (dc->unrealize) {


> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  include/hw/hotplug.h | 12 ++++++++++++
>  hw/core/hotplug.c    | 11 +++++++++++
>  hw/core/qdev.c       |  7 +++++++
>  3 files changed, 30 insertions(+)
> 
> diff --git a/include/hw/hotplug.h b/include/hw/hotplug.h
> index 1a0516a479..1e8b1053b6 100644
> --- a/include/hw/hotplug.h
> +++ b/include/hw/hotplug.h
> @@ -47,6 +47,8 @@ typedef void (*hotplug_fn)(HotplugHandler *plug_handler,
>   * @parent: Opaque parent interface.
>   * @pre_plug: pre plug callback called at start of device.realize(true)
>   * @plug: plug callback called at end of device.realize(true).
> + * @post_plug: post plug callback called after device.realize(true) and device
> + *             reset
>   * @unplug_request: unplug request callback.
>   *                  Used as a means to initiate device unplug for devices that
>   *                  require asynchronous unplug handling.
> @@ -61,6 +63,7 @@ typedef struct HotplugHandlerClass {
>      /* <public> */
>      hotplug_fn pre_plug;
>      hotplug_fn plug;
> +    hotplug_fn post_plug;
>      hotplug_fn unplug_request;
>      hotplug_fn unplug;
>  } HotplugHandlerClass;
> @@ -83,6 +86,15 @@ void hotplug_handler_pre_plug(HotplugHandler *plug_handler,
>                                DeviceState *plugged_dev,
>                                Error **errp);
>  
> +/**
> + * hotplug_handler_post_plug:
> + *
> + * Call #HotplugHandlerClass.post_plug callback of @plug_handler.
> + */
> +void hotplug_handler_post_plug(HotplugHandler *plug_handler,
> +                               DeviceState *plugged_dev,
> +                               Error **errp);
> +
>  /**
>   * hotplug_handler_unplug_request:
>   *
> diff --git a/hw/core/hotplug.c b/hw/core/hotplug.c
> index 17ac986685..ab34c19461 100644
> --- a/hw/core/hotplug.c
> +++ b/hw/core/hotplug.c
> @@ -35,6 +35,17 @@ void hotplug_handler_plug(HotplugHandler *plug_handler,
>      }
>  }
>  
> +void hotplug_handler_post_plug(HotplugHandler *plug_handler,
> +                               DeviceState *plugged_dev,
> +                               Error **errp)
> +{
> +    HotplugHandlerClass *hdc = HOTPLUG_HANDLER_GET_CLASS(plug_handler);
> +
> +    if (hdc->post_plug) {
> +        hdc->post_plug(plug_handler, plugged_dev, errp);
> +    }
> +}
> +
>  void hotplug_handler_unplug_request(HotplugHandler *plug_handler,
>                                      DeviceState *plugged_dev,
>                                      Error **errp)
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index cf0db4b6da..78c0e031ff 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -865,6 +865,13 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
>          }
>          if (dev->hotplugged) {
>              device_reset(dev);
> +
> +            if (hotplug_ctrl) {
> +                hotplug_handler_post_plug(hotplug_ctrl, dev, &local_err);
> +                if (local_err != NULL) {
> +                    goto child_realize_fail;
> +                }
> +            }
>          }
>          dev->pending_deleted_event = false;
>      } else if (!value && dev->realized) {
