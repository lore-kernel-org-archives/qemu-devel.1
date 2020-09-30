Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF42C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 14:28:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8A672076B
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 14:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hXhiJNK8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8A672076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNd6G-0002JL-VC
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 10:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kNd5M-0001ez-Bt
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 10:28:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21851)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kNd5I-0001vA-Uv
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 10:27:59 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601476075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HWRFTUfu0pQXvAci2PAevJS8pFxLgFOdc2xqb9Tvvho=;
 b=hXhiJNK8FsxXAT8D733sbAzpmL30B/ksIdVyLb0Vi7EjX82v1N9WKjdvmpu0Xt4cSjPLGm
 fJjKPfxsNQDV8pOVZ5Hh4vCvPIrFflBVp0NsMqW2F9X5KuWKnPaSBXQlDtZfCN1FET4TDt
 01/JxtnyOIQM8zd0cRkAzN9hQ3SUdH8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232--Fr0RDaNNHi7Mshvfl9m9A-1; Wed, 30 Sep 2020 10:27:53 -0400
X-MC-Unique: -Fr0RDaNNHi7Mshvfl9m9A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36451425DF
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 14:27:52 +0000 (UTC)
Received: from starship (unknown [10.35.206.29])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0F3D87838A;
 Wed, 30 Sep 2020 14:27:46 +0000 (UTC)
Message-ID: <0ce8035d631324768ff0f2914499740c8ba992c1.camel@redhat.com>
Subject: Re: [PATCH 01/10] qdev: add "check if address free" callback for buses
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Date: Wed, 30 Sep 2020 17:27:45 +0300
In-Reply-To: <20200925172604.2142227-2-pbonzini@redhat.com>
References: <20200925172604.2142227-1-pbonzini@redhat.com>
 <20200925172604.2142227-2-pbonzini@redhat.com>
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlevitsk@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:31:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2020-09-25 at 13:25 -0400, Paolo Bonzini wrote:
> Check if an address is free on the bus before plugging in the
> device.  This makes it possible to do the check without any
> side effects, and to detect the problem early without having
> to do it in the realize callback.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/core/qdev.c         | 17 +++++++++++++++--
>  hw/net/virtio-net.c    |  2 +-
>  hw/sd/core.c           |  3 ++-
>  include/hw/qdev-core.h |  3 ++-
>  4 files changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 96772a15bd..74db78df36 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -94,13 +94,23 @@ static void bus_add_child(BusState *bus, DeviceState *child)
>                               0);
>  }
>  
> -void qdev_set_parent_bus(DeviceState *dev, BusState *bus)
> +static bool bus_check_address(BusState *bus, DeviceState *child, Error **errp)
> +{
> +    BusClass *bc = BUS_GET_CLASS(bus);
> +    return !bc->check_address || bc->check_address(bus, child, errp);
> +}
> +
> +bool qdev_set_parent_bus(DeviceState *dev, BusState *bus, Error **errp)
>  {
>      BusState *old_parent_bus = dev->parent_bus;
>      DeviceClass *dc = DEVICE_GET_CLASS(dev);
>  
>      assert(dc->bus_type && object_dynamic_cast(OBJECT(bus), dc->bus_type));
>  
> +    if (!bus_check_address(bus, dev, errp)) {
> +        return false;
> +    }
> +
>      if (old_parent_bus) {
>          trace_qdev_update_parent_bus(dev, object_get_typename(OBJECT(dev)),
>              old_parent_bus, object_get_typename(OBJECT(old_parent_bus)),
> @@ -126,6 +136,7 @@ void qdev_set_parent_bus(DeviceState *dev, BusState *bus)
>          object_unref(OBJECT(old_parent_bus));
>          object_unref(OBJECT(dev));
>      }
> +    return true;
>  }
>  
>  DeviceState *qdev_new(const char *name)
> @@ -371,7 +382,9 @@ bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp)
>      assert(!dev->realized && !dev->parent_bus);
>  
>      if (bus) {
> -        qdev_set_parent_bus(dev, bus);
> +        if (!qdev_set_parent_bus(dev, bus, errp)) {
> +            return false;
> +        }
>      } else {
>          assert(!DEVICE_GET_CLASS(dev)->bus_type);
>      }
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 7bf27b9db7..268cecc498 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -3142,7 +3142,7 @@ static bool failover_replug_primary(VirtIONet *n, Error **errp)
>          error_setg(errp, "virtio_net: couldn't find primary bus");
>          return false;
>      }
> -    qdev_set_parent_bus(n->primary_dev, n->primary_bus);
> +    qdev_set_parent_bus(n->primary_dev, n->primary_bus, &error_abort);
>      n->primary_should_be_hidden = false;
>      if (!qemu_opt_set_bool(n->primary_device_opts,
>                             "partially_hotplugged", true, errp)) {
> diff --git a/hw/sd/core.c b/hw/sd/core.c
> index 957d116f1a..08c93b5903 100644
> --- a/hw/sd/core.c
> +++ b/hw/sd/core.c
> @@ -23,6 +23,7 @@
>  #include "hw/qdev-core.h"
>  #include "hw/sd/sd.h"
>  #include "qemu/module.h"
> +#include "qapi/error.h"
>  #include "trace.h"
>  
>  static inline const char *sdbus_name(SDBus *sdbus)
> @@ -240,7 +241,7 @@ void sdbus_reparent_card(SDBus *from, SDBus *to)
>      readonly = sc->get_readonly(card);
>  
>      sdbus_set_inserted(from, false);
> -    qdev_set_parent_bus(DEVICE(card), &to->qbus);
> +    qdev_set_parent_bus(DEVICE(card), &to->qbus, &error_abort);
>      sdbus_set_inserted(to, true);
>      sdbus_set_readonly(to, readonly);
>  }
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index 72064f4dd4..e62da68a26 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -217,6 +217,7 @@ struct BusClass {
>       */
>      char *(*get_fw_dev_path)(DeviceState *dev);
>      void (*reset)(BusState *bus);
> +    bool (*check_address)(BusState *bus, DeviceState *dev, Error **errp);
>      BusRealize realize;
>      BusUnrealize unrealize;
>  
> @@ -788,7 +789,7 @@ const char *qdev_fw_name(DeviceState *dev);
>  Object *qdev_get_machine(void);
>  
>  /* FIXME: make this a link<> */
> -void qdev_set_parent_bus(DeviceState *dev, BusState *bus);
> +bool qdev_set_parent_bus(DeviceState *dev, BusState *bus, Error **errp);
>  
>  extern bool qdev_hotplug;
>  extern bool qdev_hot_removed;


I like that idea, however I wonder why this was needed.
My patch that switches the direction in scsi_device_find, is supposed to be completely equavalent, 
based on the following train of thought:

If scsi_device_find finds an exact match it returns only it, as before.

Otherwise scsi_device_find were to scan from end of the list to the start, and every time,
it finds a device with same channel/id it would update the target_dev
and return it when it reaches the end of the list. 

If I am not mistaken this means that it would return _first_ device in the 
list that matches the channel/id.
This is exactly what new version of scsi_device_find does.

Anyway, since I don't see anything wrong with doing what this patch does other
than adding a documentation to the function as Stefan pointed out,

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky



