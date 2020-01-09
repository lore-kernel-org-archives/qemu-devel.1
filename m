Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD30C32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 11:03:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1178620656
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 11:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZJFJpobF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1178620656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipVah-0008VN-0W
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 06:03:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50199)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1ipVZU-00072u-G5
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:01:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1ipVZR-0001rS-1t
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:01:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47766
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1ipVZQ-0001nS-HP
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:01:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578567702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uj00TCtceP/iSWxizMpIEbaPDQmECQMmE7uRo4PaN4U=;
 b=ZJFJpobF1Lk4PVvXayhbucAgF1ZdW8Z48AoPqn5q54uVBU4Kzzr58sQL6ityuVebmLLBYA
 UXcuw+OZj3pncFsKUWKcqqOvARcSEDfV48uGeJe6DdtBRMbMNb+l4XqvD9qbS7CUP92K2G
 95JHyyWO27d9FROY7JLxR+hccSmfZEM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-l2CcCSRyO8K9kTXT8J2CWw-1; Thu, 09 Jan 2020 06:01:41 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68449DB22;
 Thu,  9 Jan 2020 11:01:39 +0000 (UTC)
Received: from [10.36.117.108] (ovpn-117-108.ams2.redhat.com [10.36.117.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 796BA7C3B3;
 Thu,  9 Jan 2020 11:01:28 +0000 (UTC)
Subject: Re: [PATCH for-5.0 v11 08/20] virtio-iommu: Implement translate
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20191219144936.GB50561@xz-x1>
 <9ec9d0d5-062b-f96b-c72c-4d15865ff9a1@redhat.com>
 <20191220162642.GA2626852@myrica> <20191220165100.GA3780@xz-x1>
 <20200106170634.GF2062@myrica> <20200106175850.GC219677@xz-x1>
 <20200107101024.GB832497@myrica>
 <aa5fa9e6-6efd-e1a3-96c6-d02ba8eab4c8@redhat.com>
 <20200109084700.GA934975@myrica>
 <0beb9d61-05b8-3152-e967-64413def6ab7@redhat.com>
 <20200109104032.GA937123@myrica>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <bcb585ef-f617-e870-72a2-f4028682547b@redhat.com>
Date: Thu, 9 Jan 2020 12:01:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200109104032.GA937123@myrica>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: l2CcCSRyO8K9kTXT8J2CWw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, kevin.tian@intel.com,
 tnowicki@marvell.com, mst@redhat.com, jean-philippe.brucker@arm.com,
 quintela@redhat.com, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 armbru@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 dgilbert@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On 1/9/20 11:40 AM, Jean-Philippe Brucker wrote:
> On Thu, Jan 09, 2020 at 09:58:49AM +0100, Auger Eric wrote:
>>>> I share Peter's concern about having a different default policy than x86.
>>>
>>> Yes I'd say just align with whatever policy is already in place. Do you
>>> think we could add a command-line option to let people disable
>>> default-bypass, though?  That would be a convenient way to make the IOMMU
>>> protection airtight for those who need it.
>> Yes I could easily add a device option to disable the default bypass.
>>
>> Shall we change the meaning of the F_BYPASS feature then? If exposed by
>> the device, the device does bypass by default, otherwise it doesn't.
>> This would be controlled by the device option.
> 
> For a device that doesn't do bypass by default, the driver wouldn't have
> the ability to enable bypass (feature bit not offered, not negotiable).
> 
>> The driver then could have means to overwrite this behavior once loaded?
> 
> Let's keep the bypass feature bit for this. If the bit is offered, the
> driver chooses to enable or disable it. If the bit is not offered or not
> negotiated, then the behavior is deny. If the bit is offered and
> negotiated then the behavior is allow.
> 
> We can say that before features negotiation (latched at features register
> write, I think, in practice?) the behavior is platform dependent. The
> current wording about bypass intends to discourage unsafe choices but
> makes a strong statement only about the device behavior after features
> negotiation. 
OK. May be worth adding in the spec later.

By the way what is the plan for the vote?

Thanks

Eric
> 
> We could add a second feature bit specifically for the boot bypass
> behavior. It wouldn't be useful to the OS (the driver doesn't have a
> choice) but could present a bit in config space that allows a firmware to
> disable boot-bypass in a way that is sticky across reset. So when the OS
> resets the device after taking it over, it doesn't accidentally enable
> bypass. I wouldn't bother though. If a FW/bootloader is able to support
> virtio-iommu, the user might as well instantiate the device with the
> default-deny option.
> 
> Thanks,
> Jean
> 
> 


