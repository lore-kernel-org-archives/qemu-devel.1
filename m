Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACF6C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 08:41:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A66A5208CA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 08:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PnKI7+oc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A66A5208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWyZL-00025o-Tz
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 04:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jWyYW-00011B-LS
 for qemu-devel@nongnu.org; Fri, 08 May 2020 04:40:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25810
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jWyYV-0004mZ-Ty
 for qemu-devel@nongnu.org; Fri, 08 May 2020 04:40:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588927227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m96N1ub4rqpr7e9ldrA0YZBN9NxfM9Q9/XvkEFY0I+Y=;
 b=PnKI7+ocWooYNX4R40K5zfHGxvn9ip+l/reyHept3fBlcTl87vzxzITi+oas5iY3qCe9jy
 sRkjR03+HbgEx3Tltiny09T1l/pk5MriCbCMsV3v6xxzS9fB3oGtrqkpqTkpnMc0n65Y0H
 RLfwcgIdc1SkD+GFQfBGfiVWHwauLvM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-OCDBLXvQPTadTi9-vnFS-Q-1; Fri, 08 May 2020 04:40:23 -0400
X-MC-Unique: OCDBLXvQPTadTi9-vnFS-Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC606100960F;
 Fri,  8 May 2020 08:40:21 +0000 (UTC)
Received: from [10.36.114.214] (ovpn-114-214.ams2.redhat.com [10.36.114.214])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C347B10013BD;
 Fri,  8 May 2020 08:40:13 +0000 (UTC)
Subject: Re: [PATCH 5/5] hw/arm/virt: Let the virtio-iommu bypass MSIs
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20200507143201.31080-1-eric.auger@redhat.com>
 <20200507143201.31080-6-eric.auger@redhat.com>
 <20200508082126.GA1770804@myrica>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <9147445d-b87b-1326-b437-012dbd57d33d@redhat.com>
Date: Fri, 8 May 2020 10:40:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200508082126.GA1770804@myrica>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 02:23:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, mst@redhat.com, qemu-devel@nongnu.org,
 peterx@redhat.com, armbru@redhat.com, qemu-arm@nongnu.org,
 bbhushan2@marvell.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Jean-Philippe,

On 5/8/20 10:21 AM, Jean-Philippe Brucker wrote:
> On Thu, May 07, 2020 at 04:32:01PM +0200, Eric Auger wrote:
>> At the moment the virtio-iommu translates MSI transactions.
>> This behavior is inherited from ARM SMMU. The virt machine
>> code knows where the guest MSI doorbells are so we can easily
>> declare those regions as VIRTIO_IOMMU_RESV_MEM_T_MSI. With that
>> setting the guest will not map MSIs through the IOMMU and those
>> transactions will be simply bypassed. The ITS does MSI translation
>> anyway.
> 
> Makes sense. I think we have to check that the ITS is used before
> declaring the resv region, though. 

When using gicv2m, the guest will see
> this MSI region and deduce that it doesn't need to create a SW mapping for
> MSIs (might be wrong, I haven't tested it yet).

Yes you're right. I think any MSI region hides the SW MSI one. So I will
test the GIC type beforehand.

Also I will extend the series to handle the GICv2M backdoor

To me the problem is similar and the iommu subsystem will map the GICV2M
MSI doorbell as well. From a security pov, there is no difference
inbetween the 2 solutions. Anyway the doorbell is reachable by any
assigned device, would it be mapped or not. And given the GICv2M does
not perform any interrupt translation, an assigned device can trigger
MSIs on another userspace driver.

Thanks

Eric
> 
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  hw/arm/virt.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 171e6908ec..6a041e97a5 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -2138,6 +2138,11 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>>  {
>>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>>          virt_memory_pre_plug(hotplug_dev, dev, errp);
>> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
>> +        /* we declare a VIRTIO_IOMMU_RESV_MEM_T_MSI region */
>> +        qdev_prop_set_uint32(dev, "len-reserved-regions", 1);
>> +        qdev_prop_set_string(dev, "reserved-regions[0]",
>> +                             "0x8090000, 0x809FFFF, 1");
> 
> Maybe worth adding a comment saying this is the GITS_TRANSLATER page?
> 
> Thanks,
> Jean
> 


