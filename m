Received: from eggs.gnu.org ([2001:4830:134:3::10]:52974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fT76z-0004l4-42
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:51:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fT76w-0005nj-Dj
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:51:01 -0400
From: David Hildenbrand <david@redhat.com>
References: <20180611121655.19616-1-david@redhat.com>
	<20180611121655.19616-8-david@redhat.com>
	<20180613150320.3d6d11ca@redhat.com>
	<430ef63d-0e9b-5925-5d5a-b6804ec7d988@redhat.com>
Message-ID: <045b1a53-fdf2-36db-2898-cfee0849232a@redhat.com>
Date: Wed, 13 Jun 2018 16:50:54 +0200
MIME-Version: 1.0
In-Reply-To: <430ef63d-0e9b-5925-5d5a-b6804ec7d988@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 07/11] pc-dimm: get_memory_region() can
 never fail
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On 13.06.2018 16:07, David Hildenbrand wrote:
> On 13.06.2018 15:03, Igor Mammedov wrote:
>> On Mon, 11 Jun 2018 14:16:51 +0200
>> David Hildenbrand <david@redhat.com> wrote:
>>
>>> We already verify when realizing that the memdev property has been
>>> set. We have no more accesses to get_memory_region() before the device
>>> is realized.
>> this stems from assumption that get_memory_region shouldn't be called
>> before devices realize is executed, which I don't agree to begin with.
>>
>> However wrt error handling, we should probably leave device internal error
>> up to devices and make check for error only in pre_plug handler
>> (since pre_plug was successful, the rest machine helpers would have
>> access to the same region until device is removed.
>>
> 
> Something like a generic Device "validate()"/"pre_realize()" function,
> that can be called before realize() and validates all properties
> (+initializes derived properties) would be something I could agree to.
> 
> Then we could drop all error handling from access functions (as they
> have been validated early during pre_plug())
> 
> Moving all checks out of realize into pre_plug() looks ugly, because we
> have implementation details split across c-files.
> 

I am thinking about something like this

>From ee8da4f5774ff5fa190466674e36ee99020033c4 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Wed, 13 Jun 2018 16:41:12 +0200
Subject: [PATCH RFC] device: add "prepare()" function

The realize() function usually does several things. It validates
properties, inititalizes state based on properties and performs
e.g. registrations in the system that require "unrealize()" to be called
when removing the device.

In a pre_plug hotplug handler, we usually want to access certain
properties or derived properties, e.g. to perform advanced checks
(for resource asignment). Now we have the problem, that realize() was
not called yet once we reach pre_plug(). So we theoretically have to
duplicate checks and add error paths for cases that can
theoretically never happen.

Let's add the "prepare()" callback, which can be used to validate
properties and inititalize some state based on these. It will be called
once all static properties have been inititalized, but before the
pre_plug hotplug handler is activated. The pre_plug handler can than
rely on the fact that basic checks already were performed.

In contrast to "realize()", "prepare()" should not perform any actions
that would have to be rolled back in case e.g. pre_plug fails.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/core/qdev.c         |  7 +++++++
 include/hw/qdev-core.h | 14 ++++++++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index ffec461791..3bfc7e0d54 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -814,6 +814,13 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
             g_free(name);
         }
 
+        if (dc->prepare) {
+            dc->prepare(dev, &local_err);
+            if (local_err != NULL) {
+                goto fail;
+            }
+        }
+
         hotplug_ctrl = qdev_get_hotplug_handler(dev);
         if (hotplug_ctrl) {
             hotplug_handler_pre_plug(hotplug_ctrl, dev, &local_err);
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index f1fd0f8736..63520c1a55 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -29,6 +29,7 @@ typedef enum DeviceCategory {
     DEVICE_CATEGORY_MAX
 } DeviceCategory;
 
+typedef void (*DevicePrepare)(DeviceState *dev, Error **errp);
 typedef void (*DeviceRealize)(DeviceState *dev, Error **errp);
 typedef void (*DeviceUnrealize)(DeviceState *dev, Error **errp);
 typedef void (*DeviceReset)(DeviceState *dev);
@@ -40,8 +41,11 @@ struct VMStateDescription;
 /**
  * DeviceClass:
  * @props: Properties accessing state fields.
+ * @prepare: Callback function invoked when the #DeviceState:realized
+ * property is changed to %true, before invoking the pre_plug hotplug handler.
  * @realize: Callback function invoked when the #DeviceState:realized
- * property is changed to %true.
+ * property is changed to %true, after invoking the pre_plug hotplug handler
+ * but before invoking the plug handler.
  * @unrealize: Callback function invoked when the #DeviceState:realized
  * property is changed to %false.
  * @hotpluggable: indicates if #DeviceClass is hotpluggable, available
@@ -54,7 +58,8 @@ struct VMStateDescription;
  * The former may not fail (it might assert or exit), the latter may return
  * error information to the caller and must be re-entrant.
  * Trivial field initializations should go into #TypeInfo.instance_init.
- * Operations depending on @props static properties should go into @realize.
+ * Operations depending on @props static properties should go into @prepare
+ * or @realize.
  * After successful realization, setting static properties will fail.
  *
  * As an interim step, the #DeviceState:realized property can also be
@@ -73,8 +78,8 @@ struct VMStateDescription;
  *
  * <note>
  *   <para>
- * Since TYPE_DEVICE doesn't implement @realize and @unrealize, types
- * derived directly from it need not call their parent's @realize and
+ * Since TYPE_DEVICE doesn't implement @prepare, @realize and @unrealize, types
+ * derived directly from it need not call their parent's @prepare, @realize and
  * @unrealize.
  * For other types consult the documentation and implementation of the
  * respective parent types.
@@ -107,6 +112,7 @@ typedef struct DeviceClass {
 
     /* callbacks */
     DeviceReset reset;
+    DevicePrepare prepare;
     DeviceRealize realize;
     DeviceUnrealize unrealize;
 
-- 
2.17.1


-- 

Thanks,

David / dhildenb
