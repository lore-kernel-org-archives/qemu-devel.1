Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4D4C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 19:23:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6FA02076E
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 19:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EucjbQSd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6FA02076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joXSs-0002do-29
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 15:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1joXSH-00025d-B8
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 15:22:37 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23313
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1joXSE-00058h-Tu
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 15:22:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593112953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0iShD19wp9YTTxv0x44Rvr6CqNGEC/8AUUFzp+JXOpc=;
 b=EucjbQSdaF3KoLf4ZXoHvbhtW1aTSYjRMNlMT07H3C1P3W6eFrICX+pqrl9b9cKt7Eq/Hm
 ZTJgdRam9GIyeEVNVyIhA+XlhcLoYMG1bAfG5SmayiUmhOSRDHt3RLGWZJ5W3VTxkJcEVi
 xE0y+stRK6GiO/2uGyjD7uR1cdsnzbQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-khy1ZqZDM7a9KYZg9rw-4w-1; Thu, 25 Jun 2020 15:22:31 -0400
X-MC-Unique: khy1ZqZDM7a9KYZg9rw-4w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42D678064BC;
 Thu, 25 Jun 2020 19:22:30 +0000 (UTC)
Received: from localhost (unknown [10.40.208.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B31785D9E7;
 Thu, 25 Jun 2020 19:22:19 +0000 (UTC)
Date: Thu, 25 Jun 2020 21:22:17 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v4] arm/virt: Add memory hot remove support
Message-ID: <20200625212217.554a3233@redhat.com>
In-Reply-To: <3375d8e35d3a481d8298ce3e6a4ce531@huawei.com>
References: <20200622124157.20360-1-shameerali.kolothum.thodi@huawei.com>
 <20200624160834.5191b73e@redhat.com>
 <3375d8e35d3a481d8298ce3e6a4ce531@huawei.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 02:30:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "Zengtao \(B\)" <prime.zeng@hisilicon.com>, "mst@redhat.com" <mst@redhat.com>,
 Linuxarm <linuxarm@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "xuwei \(O\)" <xuwei5@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 24 Jun 2020 16:50:11 +0000
Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com> wrote:

> > -----Original Message-----
> > From: Igor Mammedov [mailto:imammedo@redhat.com]
> > Sent: 24 June 2020 15:09
> > To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> > Cc: qemu-devel@nongnu.org; qemu-arm@nongnu.org;
> > peter.maydell@linaro.org; mst@redhat.com; Linuxarm
> > <linuxarm@huawei.com>; xuwei (O) <xuwei5@huawei.com>;
> > eric.auger@redhat.com; Zengtao (B) <prime.zeng@hisilicon.com>
> > Subject: Re: [PATCH v4] arm/virt: Add memory hot remove support
> > 
> > On Mon, 22 Jun 2020 13:41:57 +0100
> > Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:
> >   
> > > This adds support for memory(pc-dimm) hot remove on arm/virt that
> > > uses acpi ged device.
> > >
> > > NVDIMM hot removal is not yet supported.
> > >
> > > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> > > ---
> > > v2 --> v3
> > >   -Addressed Eric's comments on v3.
> > > v2 --> v3
> > >   -Addressed Eric's review comment and added check for NVDIMM.
> > > RFC v1 --> v2
> > >   -Rebased on top of latest Qemu master.
> > >   -Dropped "RFC" and tested with kernel 5.7-rc6
> > > ---
> > >  hw/acpi/generic_event_device.c | 29 ++++++++++++++++
> > >  hw/arm/virt.c                  | 62  
> > ++++++++++++++++++++++++++++++++--  
> > >  2 files changed, 89 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/hw/acpi/generic_event_device.c  
> > b/hw/acpi/generic_event_device.c  
> > > index 1cb34111e5..b8abdefa1c 100644
> > > --- a/hw/acpi/generic_event_device.c
> > > +++ b/hw/acpi/generic_event_device.c
> > > @@ -193,6 +193,33 @@ static void  
> 
> [...]
> 
> > > +static void virt_dimm_unplug(HotplugHandler *hotplug_dev,
> > > +                             DeviceState *dev, Error **errp)
> > > +{
> > > +    VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
> > > +    Error *local_err = NULL;
> > > +
> > > +    hotplug_handler_unplug(HOTPLUG_HANDLER(vms->acpi_dev), dev,  
> > &local_err);  
> > > +    if (local_err) {
> > > +        goto out;
> > > +    }
> > > +
> > > +    pc_dimm_unplug(PC_DIMM(dev), MACHINE(vms));
> > > +    qdev_unrealize(dev);  
> > 
> > doesn't pc_dimm_unplug() do unrealize already?
> > (/me wonders why it doesn't explode here,
> > are we leaking a refference somewhere so dimm is still alive?)  
> 
> Does it? From a quick look at the code it is not obvious.
> 
> pc_dimm_unplug()
>   memory_device_unplug()
>     memory_region_del_subregion()
>   vmstate_unregister_ram()
>     qemu_ram_unset_idstr()
>     qemu_ram_unset_migratable()
> 
> If it does, then we may need to fix x86/ppc as well.
you are right, it's correct.
I mixed it up with:
 pc_memory_unplug()
     pc_dimm_unplug(PC_DIMM(dev), MACHINE(pcms));
     object_property_set_bool(OBJECT(dev), false, "realized", &error_abort);


> 
> Thanks,
> Shameer
> 
> > > +
> > > +out:
> > > +    error_propagate(errp, local_err);
> > > +}
> > > +
> > >  static void virt_machine_device_unplug_request_cb(HotplugHandler  
> > *hotplug_dev,  
> > >                                            DeviceState *dev, Error  
> > **errp)  
> > >  {
> > > -    error_setg(errp, "device unplug request for unsupported device"
> > > -               " type: %s", object_get_typename(OBJECT(dev)));
> > > +    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> > > +        virt_dimm_unplug_request(hotplug_dev, dev, errp);
> > > +    } else {
> > > +        error_setg(errp, "device unplug request for unsupported device"
> > > +                   " type: %s", object_get_typename(OBJECT(dev)));
> > > +    }
> > > +}
> > > +
> > > +static void virt_machine_device_unplug_cb(HotplugHandler *hotplug_dev,
> > > +                                          DeviceState *dev, Error  
> > **errp)  
> > > +{
> > > +    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> > > +        virt_dimm_unplug(hotplug_dev, dev, errp);
> > > +    } else {
> > > +        error_setg(errp, "virt: device unplug for unsupported device"
> > > +                   " type: %s", object_get_typename(OBJECT(dev)));
> > > +    }
> > >  }
> > >
> > >  static HotplugHandler *virt_machine_get_hotplug_handler(MachineState  
> > *machine,  
> > > @@ -2262,6 +2319,7 @@ static void virt_machine_class_init(ObjectClass  
> > *oc, void *data)  
> > >      hc->pre_plug = virt_machine_device_pre_plug_cb;
> > >      hc->plug = virt_machine_device_plug_cb;
> > >      hc->unplug_request = virt_machine_device_unplug_request_cb;
> > > +    hc->unplug = virt_machine_device_unplug_cb;
> > >      mc->numa_mem_supported = true;
> > >      mc->nvdimm_supported = true;
> > >      mc->auto_enable_numa_with_memhp = true;  
> 


