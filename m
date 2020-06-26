Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13793C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 07:43:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D470920775
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 07:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F9i85MZI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D470920775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joj1V-0007yQ-2w
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 03:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1joj0A-0006Pe-7b
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 03:42:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35820
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1joj08-00045r-Qo
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 03:42:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593157340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QeQygaVv5TiSkHunHE4fR17mn7pETjEbIo5uOpu9ynQ=;
 b=F9i85MZI9fxYMLpku/syGmwm6A/EWHtezpfcKX03O3J2HFpUU9DxFtbKUTnVssP4Spxntx
 xJWsz8vZR/qmbYiWfz2AJdD4l/E1y3CRZ7JdXUk7TmGgRQFvZsGgDdCKs7JDDJeP7FTzxT
 6LGcrHjbe6oge4WLVI4FF62sO41Uq5U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-HEj5nfD_NOG8OhWaElHn2w-1; Fri, 26 Jun 2020 03:42:16 -0400
X-MC-Unique: HEj5nfD_NOG8OhWaElHn2w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 525931005512;
 Fri, 26 Jun 2020 07:42:15 +0000 (UTC)
Received: from [10.36.114.197] (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3ABD25C541;
 Fri, 26 Jun 2020 07:42:06 +0000 (UTC)
Subject: Re: [PATCH v5 5/5] hw/arm/virt: Let the virtio-iommu bypass MSIs
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200624132625.27453-1-eric.auger@redhat.com>
 <20200624132625.27453-6-eric.auger@redhat.com>
 <CAFEAcA_gDTuW_13a6MgC1XBMtR1XMkxAY39iUWRePp2U6Ow6XA@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <88ddd9da-f3bd-a7b3-c8c0-d7dc082e32a5@redhat.com>
Date: Fri, 26 Jun 2020 09:42:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_gDTuW_13a6MgC1XBMtR1XMkxAY39iUWRePp2U6Ow6XA@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 01:49:42
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
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Xu <peterx@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 bbhushan2@marvell.com, Eric Auger <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 6/25/20 12:01 PM, Peter Maydell wrote:
> On Wed, 24 Jun 2020 at 14:27, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> At the moment the virtio-iommu translates MSI transactions.
>> This behavior is inherited from ARM SMMU. The virt machine
>> code knows where the guest MSI doorbells are so we can easily
>> declare those regions as VIRTIO_IOMMU_RESV_MEM_T_MSI. With that
>> setting the guest will not map MSIs through the IOMMU and those
>> transactions will be simply bypassed.
>>
>> Depending on which MSI controller is in use (ITS or GICV2M),
>> we declare either:
>> - the ITS interrupt translation space (ITS_base + 0x10000),
>>   containing the GITS_TRANSLATOR or
>> - The GICV2M single frame, containing the MSI_SETSP_NS register.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>
> 
>>  static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>>                                              DeviceState *dev, Error **errp)
>>  {
>> +    VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
>> +
>>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>>          virt_memory_pre_plug(hotplug_dev, dev, errp);
>> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
>> +        /* we declare a VIRTIO_IOMMU_RESV_MEM_T_MSI region */
>> +
>> +        if (vms->msi_controller == VIRT_MSI_CTRL_ITS) {
>> +            /* GITS_TRANSLATER page */
>> +            qdev_prop_set_uint32(dev, "len-reserved-regions", 1);
>> +            qdev_prop_set_string(dev, "reserved-regions[0]",
>> +                                 "0x8090000:0x809FFFF:1");
>> +        } else if (vms->msi_controller == VIRT_MSI_CTRL_GICV2M) {
>> +            /* MSI_SETSPI_NS page */
>> +            qdev_prop_set_uint32(dev, "len-reserved-regions", 1);
>> +            qdev_prop_set_string(dev, "reserved-regions[0]",
>> +                                 "0x8020000:0x8020FFF:1");
> 
> This hardcodes addresses and lengths that are in the
> base_memmap[] array for VIRT_GIC_ITS and VIRT_GIC_V2M,
> so it's setting up a bear trap if we ever decide to
> move those. Could we construct the string from the
> base_memmap[] array entry values instead, please ?
Sure

Eric
> 
> thanks
> -- PMM
> 


