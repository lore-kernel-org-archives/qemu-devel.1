Received: from eggs.gnu.org ([2001:4830:134:3::10]:43889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gFdHk-0006W9-Vw
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 06:54:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gFdDQ-0006HY-NS
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 06:50:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gFdDQ-0006H6-GU
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 06:50:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AFB84308624F
	for <qemu-devel@nongnu.org>; Thu, 25 Oct 2018 10:50:11 +0000 (UTC)
Date: Thu, 25 Oct 2018 16:20:00 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <20181025085256.20522-2-kraxel@redhat.com>
Message-ID: <nycvar.YSQ.7.76.1810251608550.11480@xnncv>
References: <20181025085256.20522-1-kraxel@redhat.com>
	<20181025085256.20522-2-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH 1/3] qdev: add deprecation_reason to
 DeviceClass
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com

+-- On Thu, 25 Oct 2018, Gerd Hoffmann wrote --+
| Simliar to deprecated machine types.
| Print a warning when creating a deprecated device.
| Add deprecation notice to -device help.
| 
| TODO: add to intospection.

 s/intospection/introspection ..?

| diff --git a/hw/core/qdev.c b/hw/core/qdev.c
| index 046d8f1..3b27a74 100644
| --- a/hw/core/qdev.c
| +++ b/hw/core/qdev.c
| @@ -133,11 +133,18 @@ DeviceState *qdev_create(BusState *bus, const char *name)
|  
|  DeviceState *qdev_try_create(BusState *bus, const char *type)
|  {
| +    DeviceClass *dc;
|      DeviceState *dev;
|  
| -    if (object_class_by_name(type) == NULL) {
| +    dc = DEVICE_CLASS(object_class_by_name(type));
| +    if (dc == NULL) {
|          return NULL;
|      }
| +    if (dc->deprecation_reason) {
| +        warn_report("device %s is deprecated (%s)",
| +                    type, dc->deprecation_reason);
| +    }
| +
|      dev = DEVICE(object_new(type));
|      if (!dev) {
|          return NULL;
| diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
| index a24d0dd..a352eaa 100644
| --- a/include/hw/qdev-core.h
| +++ b/include/hw/qdev-core.h
| @@ -105,6 +105,7 @@ typedef struct DeviceClass {
|       */
|      bool user_creatable;
|      bool hotpluggable;
| +    const char *deprecation_reason;
|  
|      /* callbacks */
|      DeviceReset reset;
| diff --git a/qdev-monitor.c b/qdev-monitor.c
| index 802c18a..bbba2bc 100644
| --- a/qdev-monitor.c
| +++ b/qdev-monitor.c
| @@ -128,6 +128,9 @@ static void qdev_print_devinfo(DeviceClass *dc)
|      if (!dc->user_creatable) {
|          out_printf(", no-user");
|      }
| +    if (!dc->deprecation_reason) {
| +        out_printf(", deprecated");
| +    }
|      out_printf("\n");
|  }
|  
| @@ -579,6 +582,10 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
|      if (!dc) {
|          return NULL;
|      }
| +    if (dc->deprecation_reason) {
| +        warn_report("device %s is deprecated (%s)",
| +                    driver, dc->deprecation_reason);
| +    }
|  
|      /* find bus */
|      path = qemu_opt_get(opts, "bus");
| 

Looks good. Should 'deprecation_reason' be listed in qdev_device_help()?

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
