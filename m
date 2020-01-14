Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988B9C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 08:38:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6289D207FF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 08:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GFrMAqPA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6289D207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irHix-00049x-EK
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 03:38:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50133)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1irHiF-0003Vd-VB
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 03:38:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1irHiE-0001u7-Pj
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 03:38:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34149
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1irHiE-0001tq-LT
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 03:38:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578991089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vAfuzXcORhJGj7N7nwgX3YkYyibtDeg5vqOVloQ0W1I=;
 b=GFrMAqPAW6jwE2v+o8VtKXAuUVxuPHVj7oEf9R+v3LtdHsJQ3/WftYLuGof0hMj2rL0ghR
 xl88uNB/qQx6iSH0nrf+6M3N5NIdk8xRDkl0+KGQeU9t3sMQcWBSTv3g1hMNisegxm3DrU
 yZ96Npd/5AfnEzHOeOdAKT0urjXaXjE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-QtSltDaUPJa2129SIiahiw-1; Tue, 14 Jan 2020 03:38:03 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9AB95107ACC5;
 Tue, 14 Jan 2020 08:38:01 +0000 (UTC)
Received: from [10.36.117.108] (ovpn-117-108.ams2.redhat.com [10.36.117.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 757FA5DA32;
 Tue, 14 Jan 2020 08:37:53 +0000 (UTC)
Subject: Re: [PATCH v12 04/13] virtio-iommu: Add the iommu regions
To: Peter Xu <peterx@redhat.com>
References: <20200109144319.15912-1-eric.auger@redhat.com>
 <20200109144319.15912-5-eric.auger@redhat.com>
 <20200113195344.GA201624@xz-x1>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <779fc8b2-93c1-e3c2-9feb-b2552de2c5d3@redhat.com>
Date: Tue, 14 Jan 2020 09:37:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200113195344.GA201624@xz-x1>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: QtSltDaUPJa2129SIiahiw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, tnowicki@marvell.com,
 jean-philippe@linaro.org, quintela@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 mst@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 1/13/20 8:53 PM, Peter Xu wrote:
> On Thu, Jan 09, 2020 at 03:43:10PM +0100, Eric Auger wrote:
>> Implement a callback called on PCI bus enumeration that
>> initializes for a given device on the bus hierarchy
>> an IOMMU memory region. The PCI bus hierarchy is stored
>> locally in IOMMUPciBus and IOMMUDevice objects.
>>
>> At the time of the enumeration, the bus number may not be
>> computed yet.
>>
>> So operations that will need to retrieve the IOMMUdevice
>> and its IOMMU memory region from the bus number and devfn,
>> once the bus number is garanteed to be frozen,
>> use an array of IOMMUPciBus, lazily populated.
>>
>> virtio_iommu_mr() is the top helper that allows to retrieve
>> the IOMMU memory region from the requester ID.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>> v11 -> v12:
>> - add the iommu_find_iommu_pcibus() mechanics. Without it,
>>   when attaching t device to a domain we could not check
>>   the device is effectively protected by this IOMMU
> 
> Sorry I probably lost the context again after read the previous
> version...  Could you hint me what does this used for?
In v11 Jean pointed out that as_by_bus_num was not used in my series. I
first planned to remove it and then noticed that it could be useful to
test on "attach" whether the RID of the device effectively corresponds
to a device protected by the IOMMU and in the negative, return an error.

In https://patchwork.kernel.org/patch/11258269/#23067995

This is the same mechanics used in intel_iommu/smmu.


> 
> In all cases, I see that virtio_iommu_mr() is introduced but not used.
> Would be good to put it into the patch where it's firstly used.
OK fair enough, I will put the helper in the same patch as the user as
you have requested that since the beginning ;-) The resulting patch may
be huge. Just hope nobody will request me to split it back ;-)

Thanks

Eric
> 
> Thanks,
> 


