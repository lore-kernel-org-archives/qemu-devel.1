Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE3DC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 19:59:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1591A22200
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 19:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eb5gbbFT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1591A22200
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUxnO-0001o4-QX
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 15:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kUxmm-0001Os-TR
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 15:59:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22105)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kUxmh-0003gW-NP
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 15:59:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603223941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M1Upd50WXE8WYFEKHelvRB1UW3wtZcDDITW23fb8myc=;
 b=Eb5gbbFTDzbiDGh+elCBOzdU68ZAGdzdmyjv/K4S4byoBJUPv+kkYxddq7BFv//ZCoCTRC
 cwc1d7ZAdGJOHAxnfrxwDUv7gSahM79GiUWNnmklyFj9wqMQTc11ZAh/Yp4prKtq4Qvon5
 dgfvnQRwB27I2Zl1B5d94EfIspZo1f4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-SJ8hzu4wOH2QMPyEMJNcIw-1; Tue, 20 Oct 2020 15:58:57 -0400
X-MC-Unique: SJ8hzu4wOH2QMPyEMJNcIw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D7631084C8A;
 Tue, 20 Oct 2020 19:58:56 +0000 (UTC)
Received: from [10.36.114.141] (ovpn-114-141.ams2.redhat.com [10.36.114.141])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9CC295D9EF;
 Tue, 20 Oct 2020 19:58:35 +0000 (UTC)
Subject: Re: [PATCH PROTOTYPE 4/6] memory: Extend
 ram_block_discard_(require|disable) by two discard types
To: Peter Xu <peterx@redhat.com>
References: <20200924160423.106747-1-david@redhat.com>
 <20200924160423.106747-5-david@redhat.com> <20201020191706.GB200400@xz-x1>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <ea4d0acb-7ee5-7a4b-61aa-f139e0cbf585@redhat.com>
Date: Tue, 20 Oct 2020 21:58:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201020191706.GB200400@xz-x1>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:15:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Luiz Capitulino <lcapitulino@redhat.com>, Auger Eric <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Wei Yang <richardw.yang@linux.intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20.10.20 21:17, Peter Xu wrote:
> On Thu, Sep 24, 2020 at 06:04:21PM +0200, David Hildenbrand wrote:
>> We want to separate the two cases whereby
>> - balloning drivers do random discards on random guest memory (e.g.,
>>   virtio-balloon) - uncoordinated discards
>> - paravirtualized memory devices do discards in well-known granularity,
>>   and always know which block is currently accessible or inaccessible by
>>   a guest. - coordinated discards
>>
>> This will be required to get virtio_mem + vfio running - vfio still
>> wants to block random memory ballooning.
>>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Alex Williamson <alex.williamson@redhat.com>
>> Cc: Wei Yang <richardw.yang@linux.intel.com>
>> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> Cc: Igor Mammedov <imammedo@redhat.com>
>> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>> Cc: Peter Xu <peterx@redhat.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  exec.c                | 109 ++++++++++++++++++++++++++++++++++--------
>>  include/exec/memory.h |  36 ++++++++++++--
>>  2 files changed, 121 insertions(+), 24 deletions(-)
>>
>> diff --git a/exec.c b/exec.c
>> index e34b602bdf..83098e9230 100644
>> --- a/exec.c
>> +++ b/exec.c
>> @@ -4098,52 +4098,121 @@ void mtree_print_dispatch(AddressSpaceDispatch *d, MemoryRegion *root)
>>   * If positive, discarding RAM is disabled. If negative, discarding RAM is
>>   * required to work and cannot be disabled.
>>   */
>> -static int ram_block_discard_disabled;
>> +static int uncoordinated_discard_disabled;
>> +static int coordinated_discard_disabled;
> 
> Instead of duplicating the codes, how about start to make it an array?
> 
> Btw, iiuc these flags do not need atomic operations at all, because all callers
> should be with BQL and called majorly during machine start/reset.  Even not, I
> think we can also use a mutex, maybe it could make things simpler.  No strong
> opinion, though.
> 

I remember there were some !BQL users (but I might be confusing it with
postcopy code that once used to inhibit the balloon without BQL). Will
double-check. Simplifying it is certainly a good idea.

(we want to be able to check from virtio-balloon code repeatedly without
taking a mutex over and over again :) )

Thanks!

-- 
Thanks,

David / dhildenb


