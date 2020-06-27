Return-Path: <SRS0=GMHn=AI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C59C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 07:10:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF59C20707
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 07:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PDw5Aze7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF59C20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jp4yk-0006u6-4y
	for qemu-devel@archiver.kernel.org; Sat, 27 Jun 2020 03:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jp4xg-0005xo-9F
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 03:09:17 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28407
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jp4xe-0004ze-Ox
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 03:09:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593241754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NOn49XQbTNLqq1dBtdJeCbo7D1tw7r7WRbE2fG7w1ZA=;
 b=PDw5Aze76fYzhBeWAJkQil1pHfVmhTED2N39aRvhXz+uXlTiXT96TYyMzVTyS0VwhMltSX
 9s+McE5n3uuSJG2pchJvGGmDsFZpUEIijVux8U76zsBBfKCElMhuBC10ioqjOqbdrYH5Xp
 AjIbmZcq1onRf90qotiJJ+eV8gz5zoQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-hd-87jSuP5K1ND4nXhxiKw-1; Sat, 27 Jun 2020 03:09:10 -0400
X-MC-Unique: hd-87jSuP5K1ND4nXhxiKw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACF1918585A3;
 Sat, 27 Jun 2020 07:09:08 +0000 (UTC)
Received: from [10.36.114.197] (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F34CE121A2F;
 Sat, 27 Jun 2020 07:09:00 +0000 (UTC)
Subject: Re: [PATCH v6 4/5] virtio-iommu-pci: Add array of Interval properties
To: Markus Armbruster <armbru@redhat.com>
References: <20200626103057.11263-1-eric.auger@redhat.com>
 <20200626103057.11263-5-eric.auger@redhat.com>
 <87sgehrnws.fsf@dusky.pond.sub.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <28b42389-6abb-6ed4-c903-fbdca29ab7b1@redhat.com>
Date: Sat, 27 Jun 2020 09:08:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <87sgehrnws.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eric.auger@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/27 02:55:52
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
Cc: peter.maydell@linaro.org, jean-philippe@linaro.org, mst@redhat.com,
 qemu-devel@nongnu.org, peterx@redhat.com, qemu-arm@nongnu.org,
 pbonzini@redhat.com, bbhushan2@marvell.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Markus,

On 6/27/20 9:03 AM, Markus Armbruster wrote:
> Eric Auger <eric.auger@redhat.com> writes:
> 
>> The machine may need to pass reserved regions to the
>> virtio-iommu-pci device (such as the MSI window on x86
>> or the MSI doorbells on ARM).
>>
>> So let's add an array of Interval properties.
>>
>> Note: if some reserved regions are already set by the
>> machine code - which should be the case in general -,
>> the length of the property array is already set and
>> prevents the end-user from modifying them. For example,
>> attempting to use:
>>
>> -device virtio-iommu-pci,\
>>  len-reserved-regions=1,reserved-regions[0]=0xfee00000:0xfeefffff:1
>>
>> would result in the following error message:
>>
>> qemu-system-aarch64: -device virtio-iommu-pci,addr=0xa,
>> len-reserved-regions=1,reserved-regions[0]=0xfee00000:0xfeefffff:1:
>> array size property len-reserved-regions may not be set more than once
>>
>> Otherwise, for example, adding two reserved regions is achieved
>> using the following options:
>>
>> -device virtio-iommu-pci,addr=0xa,len-reserved-regions=2,\
>>  reserved-regions[0]=0xfee00000:0xfeefffff:1,\
>>  reserved-regions[1]=0x1000000:100ffff:1
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>> v5 -> v6:
>> - check the type value
>> - removed Jean's R-b
>>
>> v3 -> v4:
>> - added examples in the commit message as suggested by Markus
>> - added Jean's R-b
>> ---
>>  hw/virtio/virtio-iommu-pci.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/hw/virtio/virtio-iommu-pci.c b/hw/virtio/virtio-iommu-pci.c
>> index 632533abaf..9c9bda9490 100644
>> --- a/hw/virtio/virtio-iommu-pci.c
>> +++ b/hw/virtio/virtio-iommu-pci.c
>> @@ -33,6 +33,9 @@ struct VirtIOIOMMUPCI {
>>  
>>  static Property virtio_iommu_pci_properties[] = {
>>      DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
>> +    DEFINE_PROP_ARRAY("reserved-regions", VirtIOIOMMUPCI,
>> +                      vdev.nb_reserved_regions, vdev.reserved_regions,
>> +                      qdev_prop_reserved_region, ReservedRegion),
>>      DEFINE_PROP_END_OF_LIST(),
>>  };
>>  
>> @@ -40,6 +43,7 @@ static void virtio_iommu_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
>>  {
>>      VirtIOIOMMUPCI *dev = VIRTIO_IOMMU_PCI(vpci_dev);
>>      DeviceState *vdev = DEVICE(&dev->vdev);
>> +    VirtIOIOMMU *s = VIRTIO_IOMMU(vdev);
>>  
>>      if (!qdev_get_machine_hotplug_handler(DEVICE(vpci_dev))) {
>>          MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
>> @@ -54,6 +58,15 @@ static void virtio_iommu_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
>>                            "-no-acpi\n");
>>          return;
>>      }
>> +    for (int i = 0; i < s->nb_reserved_regions; i++) {
>> +        if (s->reserved_regions[i].type != VIRTIO_IOMMU_RESV_MEM_T_RESERVED &&
>> +            s->reserved_regions[i].type != VIRTIO_IOMMU_RESV_MEM_T_MSI) {
>> +            error_setg(errp, "reserved region %d has an invalid type", i);
>> +            error_append_hint(errp, "Valid values are "
>> +                              "VIRTIO_IOMMU_RESV_MEM_T_RESERVED and "
>> +                              "VIRTIO_IOMMU_RESV_MEM_T_SMI\n");
> 
> Actually, valid values are 0 and 1.  Something like
> 
>     -device virtio-iommu-pci,len-reserved-regions=1,reserved-regions[0]=0xfee00000:0xfeefffff:VIRTIO_IOMMU_RESV_MEM_T_SMI
> 
> will be rejected as invalid.

> 
>> +        }
>> +    }
>>      object_property_set_link(OBJECT(dev),
>>                               OBJECT(pci_get_bus(&vpci_dev->pci_dev)),
>>                               "primary-bus", errp);
> 
> Sorry for having to torture you this way!  Have a
Nah In french we say "when we have no head we have legs ". Anyway there
is a type s/SMI/MSI ...
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> with the error message touched up.

Than you for your patience!

Eric
> 
> 


