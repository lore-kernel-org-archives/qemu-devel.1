Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9C2C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 01:54:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44AD5206DB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 01:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RUCk2xCA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44AD5206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGBmh-0004Kf-Ee
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 21:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kGBm4-0003g4-MO
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 21:53:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39495)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kGBm1-0006rK-DY
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 21:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599702796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/zCACmsG1AwA1lpU1Q7z3mRtsX0JN7wyLYn5IRzkrdY=;
 b=RUCk2xCAKVjS8ji78sRua0LJdvB2q0XtcaI3I3gHul/dfIZrvfGZQtHphyNYOiFT9Uox3A
 lSPKWT7sEGEjPZE9gsf62hZTeShaYnS4sY06r5VCxFG+3iyr4kmgzXcOZEmyR5df10eXhL
 i1d4pmncg31UnbyPLL9HXpzTbmt5wz4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-VuffQOvKPm2BhyHjcEFJyA-1; Wed, 09 Sep 2020 21:53:13 -0400
X-MC-Unique: VuffQOvKPm2BhyHjcEFJyA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2EC1A801AB0;
 Thu, 10 Sep 2020 01:53:12 +0000 (UTC)
Received: from [10.72.13.124] (ovpn-13-124.pek2.redhat.com [10.72.13.124])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F0ADF838B4;
 Thu, 10 Sep 2020 01:53:04 +0000 (UTC)
Subject: Re: [PATCH] pci: advertise a page aligned ATS
To: Peter Xu <peterx@redhat.com>
References: <20200909081731.24688-1-jasowang@redhat.com>
 <20200909154329.GB247092@xz-x1>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b343fea6-ecf2-7605-9340-decdd1b95149@redhat.com>
Date: Thu, 10 Sep 2020 09:53:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200909154329.GB247092@xz-x1>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 21:53:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.576, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: eperezma@redhat.com, qemu-stable@nongnu.org, qemu-devel@nongnu.org,
 mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/9/9 下午11:43, Peter Xu wrote:
> On Wed, Sep 09, 2020 at 04:17:31PM +0800, Jason Wang wrote:
>> After Linux kernel commit 61363c1474b1 ("iommu/vt-d: Enable ATS only
>> if the device uses page aligned address."), ATS will be only enabled
>> if device advertises a page aligned request.
>>
>> Unfortunately, vhost-net is the only user and we don't advertise the
>> aligned request capability in the past since both vhost IOTLB and
>> address_space_get_iotlb_entry() can support non page aligned request.
>>
>> Though it's not clear that if the above kernel commit makes
>> sense. Let's advertise a page aligned ATS here to make vhost device
>> IOTLB work with Intel IOMMU again.
> IIUC the kernel commit should be needed because the VT-d Page Request
> Descriptor used the rest bits of the address for other use (bits 11-0), so
> logically an unaligned address can be mis-recognized with special meanings.


Yes but it looks to me the problem is that Page Request Descriptor is 
only used when PRI is enabled. And according to ATS spec 1.1, PRI 
request is always page aligned...


> I'd guess some other archs (with its own IOMMU) might support unaligned
> addresses and has different layout of page request descriptor, but not vt-d.


I guess so since I don't find any other IOMMU that does similar check.


>
>> Note that in the future we may extend pcie_ats_init() to accept
>> parameters like queue depth and page alignment.
>>
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
>
> Maybe it would be good too that vhost provides real 4k-aligned addresses (in
> vhost_iotlb_miss)?  My understanding is that PCI_ATS_CAP_PAGE_ALIGNED will be
> more compatible than without the bit set.


Yes, I've considered this. But the problem is that:

1) vhost itself can generate unaligned request (since its IOTLB doesn't 
have any alignment requirement)
2) the IOTLB miss processing in qemu doesn't do anything with ATS, we 
shortcut PCI by calling the address_space_get_iotlb_entry()

So I'm not quite sure it's worth to do that consider we don't emulate 
ATS via PCI actually :)


>    E.g., so far vt-d emulation always
> cut the address with 4k no matter what iova was passed in.  However not sure
> whether this will stop working with some new vIOMMUs joining.


Yes.

Thanks


>
> Thanks,
>


