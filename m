Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB9AC32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 16:38:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBF232073A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 16:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yq2k3pk7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBF232073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irlgX-0004Q5-LB
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 11:38:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36407)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1irlfJ-0002rJ-Tp
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 11:37:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1irlfF-0005sw-2o
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 11:37:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25234
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1irlfD-0005pi-IK
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 11:37:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579106222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z0oQQH6PN0MtqXMirGfjHodXNGCxvcpzxeHJl6pTavA=;
 b=Yq2k3pk7h67Fmq5Xwzg9rK1eKkZExZKNphASwdS9pQpuqmlL/dRxa6fHZycwnJjYGAkmMR
 WUnqux6pZW/Ljc2zJiSpeoyPUgBAbN6XaqDrf66IWT+ZSwuhNnlEF0D89egBsJeODkO5q+
 rukaLj5Zgt/tgVBf6KyfUgjpV8dF05k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-hx0XVEXmNOuBxTCPbaEu8g-1; Wed, 15 Jan 2020 11:37:01 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A494A1800D48;
 Wed, 15 Jan 2020 16:36:59 +0000 (UTC)
Received: from [10.36.117.108] (ovpn-117-108.ams2.redhat.com [10.36.117.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8037B5C651;
 Wed, 15 Jan 2020 16:36:52 +0000 (UTC)
Subject: Re: [PATCH v12 09/13] virtio-iommu: Implement fault reporting
To: Peter Xu <peterx@redhat.com>
References: <20200109144319.15912-1-eric.auger@redhat.com>
 <20200109144319.15912-10-eric.auger@redhat.com>
 <20200114190433.GE225163@xz-x1>
 <2a060fcf-f9d6-c6bf-d444-018df532e475@redhat.com>
 <20200115150442.GD233443@xz-x1>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <ece76aa3-f9fd-2834-0313-9c27a3c71f36@redhat.com>
Date: Wed, 15 Jan 2020 17:36:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200115150442.GD233443@xz-x1>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: hx0XVEXmNOuBxTCPbaEu8g-1
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
 quintela@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 jean-philippe@linaro.org, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,
On 1/15/20 4:04 PM, Peter Xu wrote:
> On Wed, Jan 15, 2020 at 02:12:20PM +0100, Auger Eric wrote:
>>>> +static void virtio_iommu_report_fault(VirtIOIOMMU *viommu, uint8_t reason,
>>>> +                                      int flags, uint32_t endpoint,
>>>> +                                      uint64_t address)
>>>> +{
> 
> [...]
> 
>>>> +        if (iov_size(elem->in_sg, elem->in_num) < sizeof(fault)) {
>>>> +            virtio_error(vdev, "error buffer of wrong size");
>>>> +            virtqueue_detach_element(vq, elem, 0);
>>>> +            g_free(elem);
>>>> +            continue;
>>>
>>> If virtio_error(), should we stop rather than continue?
>> My understanding is the buffer just popped had a wrong size so it is not
>> usable. We skip it we try to use another one if any. Does it make sense?
> 
> I'm not very familiar to virtio, but I see that virtio_error marks
> vdev->broken to true.  If with that iiuc the next virtqueue_pop() will
> fail directly (see the first call to virtio_device_disabled in
> virtqueue_pop).  Then I don't see why retry any more...
You're right. I will fix it.

Thanks

Eric
> 
> Thanks,
> 


