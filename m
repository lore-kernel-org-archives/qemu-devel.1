Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F1BC433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 10:45:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90FE5208C2
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 10:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q1M3JOmH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90FE5208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxqmp-0003df-JR
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 06:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59939)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1hxqlk-0002Sl-72
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 06:44:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hxqlh-0000Kx-Py
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 06:44:39 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33345)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hxqlh-0000K8-Cg
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 06:44:37 -0400
Received: by mail-wm1-x341.google.com with SMTP id p77so3040745wme.0
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 03:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=2/0YLaLk0wpFVTLgfippfTC8i2Y0BB9jns3G5uGmtCg=;
 b=Q1M3JOmH1fnFI1QHKag/jnPwzoMBBO2ETvqxIY6ZlI9s1x9UaP+k8Pdr8oOm5FEQmd
 lNQf3UkyDadjJ6qP2L88czsVHt1Tu/IGNO4kl6xhxcMBhRZeJh7T1Xx/U2ysWaqZAD+6
 qTt781gJzbUFfTOj6ngrFdmrjRiUvNm763KxIIP2RxwShrX7453UzWe+BRNvd/BXCA9F
 TtAhyko9HM6IjZoUFHgR374mLwQwEsL1qaT+YXQoA+kkBjlMM3sQ66AgY2em1Mxzq9Jv
 NzOBYgPrK2BXU66dOugK3NTB/Mj+/kMLZU0ezpvRtdygBBR4HJm2VngYquihLOWQa1BB
 KdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=2/0YLaLk0wpFVTLgfippfTC8i2Y0BB9jns3G5uGmtCg=;
 b=KOa3qLYEAVKceEngVAXB38i94NcBELCKmKII/tHP8ytBzGryNcjPTCYJV7xB2nBlBA
 Sya5qVi0bHGeaBqxW0D+IDRuCSM/nrp4gaxZPnu5jRtUaMA/aI2m2nq4JNZlNToDdNZM
 uDpegmC+o/5+OhHtgtAyv4FWZjdCYF29aNZelY4nj9lXOIKYubiKMI+O6FkWitt4PPmQ
 rwnqUoauUw1N2LuGnRxoTxdeZGuTI88ejWYVjQr/gRvAumEHXJ9jb3T4ro8Pm+hrfX15
 q+ZPeDlueQ/g4qFJ8F8QOisxdwERoYt09JxgPNfcOAvVH7BPSP2iAqCg9xAdnQkPp/ls
 XPXA==
X-Gm-Message-State: APjAAAXaM/5qyhWbV6iN6DrtaRie1IPg/Dv4Aj8m1uOlLbXYh5/XEZWA
 p4OVQunoZAUVVWbPkIgU0jW3tw==
X-Google-Smtp-Source: APXvYqwNhjaaSCrtHgwAXjRhgjxrfnRlFkdYWaIRKtZL8XVAOqg8CN/lbUORL5cbvUl456kNPr3M1g==
X-Received: by 2002:a1c:24c3:: with SMTP id k186mr7823210wmk.126.1565779475671; 
 Wed, 14 Aug 2019 03:44:35 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id k124sm9406422wmk.47.2019.08.14.03.44.31
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 14 Aug 2019 03:44:31 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E40BA1FF87;
 Wed, 14 Aug 2019 11:44:30 +0100 (BST)
References: <20190814072355.15333-1-david@redhat.com>
 <20190814072355.15333-4-david@redhat.com> <87wofgm56o.fsf@linaro.org>
 <866fea8f-ff61-f704-d0ee-37a12e968fb5@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: David Hildenbrand <david@redhat.com>
In-reply-to: <866fea8f-ff61-f704-d0ee-37a12e968fb5@redhat.com>
Date: Wed, 14 Aug 2019 11:44:30 +0100
Message-ID: <87v9v0m3g1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH-for-4.2 v2 3/6] s390x/tcg: Flush the TLB of
 all CPUs on SSKE and RRBE
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


David Hildenbrand <david@redhat.com> writes:

> On 14.08.19 12:06, Alex Benn=C3=A9e wrote:
>>
>> David Hildenbrand <david@redhat.com> writes:
>>
>>> Whenever we modify a storage key, we shuld flush the TLBs of all CPUs,
>>> so the MMU fault handling code can properly consider the changed storage
>>> key (to e.g., properly set the reference and change bit on the next
>>> accesses).
>>>
>>> These functions are barely used in modern Linux guests, so the performa=
nce
>>> implications are neglectable for now.
>>>
>>> This is a preparation for better reference and change bit handling for
>>> TCG, which will require more MMU changes.
>>>
>>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>  target/s390x/mem_helper.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
>>> index 29d9eaa5b7..ed54265e03 100644
>>> --- a/target/s390x/mem_helper.c
>>> +++ b/target/s390x/mem_helper.c
>>> @@ -1815,6 +1815,8 @@ void HELPER(sske)(CPUS390XState *env, uint64_t r1=
, uint64_t r2)
>>>
>>>      key =3D (uint8_t) r1;
>>>      skeyclass->set_skeys(ss, addr / TARGET_PAGE_SIZE, 1, &key);
>>> +    /* TODO: Flush only entries with this target address */
>>> +    tlb_flush_all_cpus_synced(env_cpu(env));
>>
>> Doesn't:
>>
>>   tlb_flush_page_all_cpus_synced(env_cpu(env), addr & TARGET_PAGE_MASK);
>>
>> do what you want here?
>
> I would have to flush all TLB entries that target this physical page,
> not the entry of the single virtual page. So that does, unfortunately,
> not work.

Ahh I see. Well maybe that should be the comment instead:

  /*
   * As we can only flush by virtual address and not all the entries
   * that point to a physical address we have to flush the whole TLB
   * here.
   */
   tlb_flush_all_cpus_synced(env_cpu(env));

?


--
Alex Benn=C3=A9e

