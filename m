Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F96C388F3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 08:26:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77F0021872
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 08:26:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77F0021872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFDUB-0000RL-NJ
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 04:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55492)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iFDSZ-0007DE-CP
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 04:24:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iFDSY-0002dq-7a
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 04:24:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33468)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1iFDSX-0002dc-Vj; Tue, 01 Oct 2019 04:24:38 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 347D03001BF1;
 Tue,  1 Oct 2019 08:24:37 +0000 (UTC)
Received: from [10.36.117.182] (ovpn-117-182.ams2.redhat.com [10.36.117.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8169819C6A;
 Tue,  1 Oct 2019 08:24:35 +0000 (UTC)
Subject: Re: [PATCH v3 7/7] s390x/mmu: Convert to non-recursive page table walk
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20190927095831.23543-1-david@redhat.com>
 <20190927095831.23543-8-david@redhat.com>
 <b6ad5c2a-bacc-9b41-d141-c8da2fb4ae8d@redhat.com>
 <efeaf2e2-2bb7-97a0-b76b-af21fa197b4d@redhat.com>
 <9a2111f7-6783-21e5-093e-b4cee30465a0@redhat.com>
From: David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <715fcc38-6a25-5242-047e-bdca598e9f92@redhat.com>
Date: Tue, 1 Oct 2019 10:24:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9a2111f7-6783-21e5-093e-b4cee30465a0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Tue, 01 Oct 2019 08:24:37 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01.10.19 10:23, Thomas Huth wrote:
> On 01/10/2019 10.17, David Hildenbrand wrote:
>>
>>>>          break;
>>>>      case ASCE_TYPE_SEGMENT:
>>>>          if (VADDR_REGION1_TX(vaddr) || VADDR_REGION2_TX(vaddr) ||
>>>> @@ -253,11 +164,112 @@ static int mmu_translate_asce(CPUS390XState *env, target_ulong vaddr,
>>>>          if (VADDR_SEGMENT_TL(vaddr) > asce_tl) {
>>>>              return PGM_SEGMENT_TRANS;
>>>>          }
>>>> +        gaddr += VADDR_SEGMENT_TX(vaddr) * 8;
>>>> +        break;
>>>> +    default:
>>>> +        g_assert_not_reached();
>>>
>>> As far as I can see, all four cases are handled above, so this default
>>> case should really not be necessary here.
>>
>> Yes, can drop.
>>
>>>
>>>> +    }
>>>> +
>>>> +    switch (asce & ASCE_TYPE_MASK) {
>>>> +    case ASCE_TYPE_REGION1:
>>>> +        if (!read_table_entry(env, gaddr, &entry)) {
>>>> +            return PGM_ADDRESSING;
>>>> +        }
>>>> +        if (entry & REGION_ENTRY_I) {
>>>> +            return PGM_REG_FIRST_TRANS;
>>>> +        }
>>>> +        if ((entry & REGION_ENTRY_TT) != REGION_ENTRY_TT_REGION1) {
>>>> +            return PGM_TRANS_SPEC;
>>>> +        }
>>>> +        if (VADDR_REGION2_TL(vaddr) < (entry & REGION_ENTRY_TF) >> 6 ||
>>>> +            VADDR_REGION2_TL(vaddr) > (entry & REGION_ENTRY_TL)) {
>>>> +            return PGM_REG_SEC_TRANS;
>>>> +        }
>>>> +        if (edat1 && (entry & REGION_ENTRY_P)) {
>>>> +            *flags &= ~PAGE_WRITE;
>>>> +        }
>>>> +        gaddr = (entry & REGION_ENTRY_ORIGIN) + VADDR_REGION2_TX(vaddr) * 8;
>>>> +        /* fall through */
>>>> +    case ASCE_TYPE_REGION2:
>>>> +        if (!read_table_entry(env, gaddr, &entry)) {
>>>> +            return PGM_ADDRESSING;
>>>> +        }
>>>> +        if (entry & REGION_ENTRY_I) {
>>>> +            return PGM_REG_SEC_TRANS;
>>>> +        }
>>>> +        if ((entry & REGION_ENTRY_TT) != REGION_ENTRY_TT_REGION2) {
>>>> +            return PGM_TRANS_SPEC;
>>>> +        }
>>>> +        if (VADDR_REGION3_TL(vaddr) < (entry & REGION_ENTRY_TF) >> 6 ||
>>>> +            VADDR_REGION3_TL(vaddr) > (entry & REGION_ENTRY_TL)) {
>>>> +            return PGM_REG_THIRD_TRANS;
>>>> +        }
>>>> +        if (edat1 && (entry & REGION_ENTRY_P)) {
>>>> +            *flags &= ~PAGE_WRITE;
>>>> +        }
>>>> +        gaddr = (entry & REGION_ENTRY_ORIGIN) + VADDR_REGION3_TX(vaddr) * 8;
>>>> +        /* fall through */
>>>> +    case ASCE_TYPE_REGION3:
>>>> +        if (!read_table_entry(env, gaddr, &entry)) {
>>>> +            return PGM_ADDRESSING;
>>>> +        }
>>>> +        if (entry & REGION_ENTRY_I) {
>>>> +            return PGM_REG_THIRD_TRANS;
>>>> +        }
>>>> +        if ((entry & REGION_ENTRY_TT) != REGION_ENTRY_TT_REGION3) {
>>>> +            return PGM_TRANS_SPEC;
>>>> +        }
>>>> +        if (edat1 && (entry & REGION_ENTRY_P)) {
>>>> +            *flags &= ~PAGE_WRITE;
>>>> +        }
>>>
>>> Shouldn't that check be done below the next if-statement?
>>
>> Does it matter? The flags are irrelevant in case we return an exception,
>> so the order shouldn't matter.
> 
> Hmm, it likely does not matter, but you've got it the other way round in
> all other cases, so I'd vote for doing it here this way, too, for
> consistency.

Oh, in this case, sure! Thanks!

> 
>  Thomas
> 


-- 

Thanks,

David / dhildenb

