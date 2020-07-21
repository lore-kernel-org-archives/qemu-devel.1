Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2508BC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 08:23:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3F9620714
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 08:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tm0AKVcl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3F9620714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxnZ0-0004QK-7V
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 04:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jxnYH-0003Xs-Dw
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 04:23:05 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29501
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jxnYE-0006Lc-TU
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 04:23:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595319756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=g91Rxa083C1GwMKbigO+LsF/QYIvVbbQ2FOEA7Px1ks=;
 b=Tm0AKVclD3Gj8CfttyW5f5A6Q48BCGHzZam/Iw8cdx7u5HsgTnMfPNZPhOVnF0z6eZBs3c
 hrSOLXhAYwFjU3nfgbIRMqsPr8L9Yyd+zeEcmwo5Q3MtZHNdP+BHeiZZ0ltiNt2z8y2m6n
 FM7rA7X9v1URgI3PYVssGx9c6duwnVQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-_v3HQlHXO_O6V_L7DJy4ig-1; Tue, 21 Jul 2020 04:22:32 -0400
X-MC-Unique: _v3HQlHXO_O6V_L7DJy4ig-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 652F880183C;
 Tue, 21 Jul 2020 08:22:31 +0000 (UTC)
Received: from [10.36.113.158] (ovpn-113-158.ams2.redhat.com [10.36.113.158])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 890B05C1BD;
 Tue, 21 Jul 2020 08:22:26 +0000 (UTC)
Subject: Re: [PATCH 2/3] exec: posix_madvise usage on SunOS.
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, dhildenb@redhat.com
References: <CA+XhMqwtUrSpCqNGEETBijewzvmpno8OAX_PKSShDP_gUQ-3VQ@mail.gmail.com>
 <CAFEAcA96mh_4EkKz31HgzfPOEQvhta8VTcvMV=An8Us0+x=NfQ@mail.gmail.com>
 <20200720191318.GM2642@work-vm>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 WNyWQQ==
Organization: Red Hat GmbH
Message-ID: <7b38e1a1-12a2-0158-45ab-8e5d7e287f2f@redhat.com>
Date: Tue, 21 Jul 2020 10:22:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200720191318.GM2642@work-vm>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 01:26:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 David CARLIER <devnexen@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20.07.20 21:13, Dr. David Alan Gilbert wrote:
> (Copies in Dave Hildenbrand)
> 
> * Peter Maydell (peter.maydell@linaro.org) wrote:
>> On Sat, 18 Jul 2020 at 14:21, David CARLIER <devnexen@gmail.com> wrote:
>>>
>>> From a9e3cced279ae55a59847ba232f7828bc2479367 Mon Sep 17 00:00:00 2001
>>> From: David Carlier <devnexen@gmail.com>
>>> Date: Sat, 18 Jul 2020 13:29:44 +0100
>>> Subject: [PATCH 2/3] exec: posix_madvise usage on SunOS.
>>>
>>> with _XOPEN_SOURCE set, the older mman.h API based on caddr_t handling
>>> is not accessible thus using posix_madvise here.
>>>
>>> Signed-off-by: David Carlier <devnexen@gmail.com>
>>> ---
>>>  exec.c | 8 ++++++++
>>>  1 file changed, 8 insertions(+)
>>>
>>> diff --git a/exec.c b/exec.c
>>> index 6f381f98e2..0466a75b89 100644
>>> --- a/exec.c
>>> +++ b/exec.c
>>> @@ -3964,7 +3964,15 @@ int ram_block_discard_range(RAMBlock *rb,
>>> uint64_t start, size_t length)
>>>               * fallocate'd away).
>>>               */
>>>  #if defined(CONFIG_MADVISE)
>>> +#if !defined(CONFIG_SOLARIS)
>>>              ret =  madvise(host_startaddr, length, MADV_DONTNEED);
>>> +#else
>>> +        /*
>>> +         * mmap and its caddr_t based api is not accessible
>>> +         * with _XOPEN_SOURCE set on illumos
>>> +         */
>>> +            ret =  posix_madvise(host_startaddr, length, POSIX_MADV_DONTNEED);
>>> +#endif
>>
>> Hi. I'm not sure this patch will do the right thing, because
>> I don't think that Solaris's POSIX_MADV_DONTNEED provides
>> the semantics that this QEMU function says it needs. The
>> comment at the top of the function says:
>>
>>  * Unmap pages of memory from start to start+length such that
>>  * they a) read as 0, b) Trigger whatever fault mechanism
>>  * the OS provides for postcopy.
>>  * The pages must be unmapped by the end of the function.
> 
> This code has moved around a bit over it's life; joining the case
> needed by balloon and the case needed by postcopy.
> 
>> (Aside: the use of 'unmap' in this comment is a bit confusing,
>> because it clearly doesn't mean 'unmap' if it wants read-as-0.
>> And the reference to faults on postcopy is incomprehensible
>> to me: if memory is read-as-0 it isn't going to fault.)
> 
> I think because internally to Linux the behaviour is the same;
> this causes the mapping to disappear from the TLB so it faults;
> normally when reading the kernel resolves the fault and puts
> a read-as-zero page there, except if userfault was enabled
> for postcopy, in which case it gives us a kick and we service it.
> 
>> Linux's madvise(MADV_DONTNEED) does guarantee us this
>> read-as-zero behaviour. (It's a silly API choice that Linux
>> put this behaviour behind madvise, which is supposed to be
>> merely advisory, but that's how it is.)
> 
> Yes, I don't think there's any equivalent to madvise
> that guarantees anything.
> 
>> The Solaris
>> posix_madvise() manpage says it is merely advisory and
>> doesn't affect the behaviour of accesses to the memory.
>>
>> If posix_madvise() behaviour was OK in this function, the
>> right way to fix this would be to use qemu_madvise()
>> instead, which already provides this "if host has
>> madvise(), use it, otherwise use posix_madvise()" logic.
>> But I suspect that the direct madvise() here is deliberate.
> 
> Yes, but I can't remember the semantics fully - I think it was because
> we needed the guarantee at this point (and even Linux's
> posix madvise did something different??)
> 
> I've got a note saying we didn't want to use
> qemu_madvise because we wanted to be sure we didn't get
> posix_madvise.
> 
>> Side note: not sure the current code is correct for the
>> BSDs either -- they have madvise() but don't provide
>> Linux's really-read-as-zero guarantee for MADV_DONTNEED.
>> So we should probably be doing something else there, and
>> whatever that something-else is is probably also what
>> Solaris wants.
>>
>> We use ram_block_discard_range() only in migration and
>> in virtio-balloon and virtio-mem; I've cc'd some people
>> who hopefully understand what the requirements on this
>> function are and might have a view on what the not-Linux
>> implementation should look like. (David Gilbert: git
>> blame says you wrote this code :-))

virtio-mem depends on Linux (hw/virtio/Kconfig). I guess
userfaultfd/postcopy is also not relevant in the context of SunOS. So
what remains is virtio-balloon.

virito-balloon ideally wants to discard the actual mapped pages to free
up memory. When memory is re-accessed, a fresh page is faulted in (->
zero-page under Linux). Now, we already have other cases where it looks
like "the balloon works" but it really doesn't. One example is using
vfio+virtio-balloon under Linux - inflating the balloon is simply a NOP,
no memory is actually discarded.

I agree that POSIX_MADV_DONTNEED is not a proper match - different
guarantees. If SunOS cannot implement ram_block_discard_range() as
documented, we should disable it.

I would suggest using ram_block_discard_disable(true) when under SunOS
early during QEMU startup. In addition, we might want to return directly
in ram_block_dicard_range(). We might also want to make virito-balloon
depend on !SubOS.

-- 
Thanks,

David / dhildenb


