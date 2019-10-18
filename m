Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D5CCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 18:23:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E479420820
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 18:23:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E479420820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLWuE-0007By-WA
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 14:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34944)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iLWpJ-00089Y-Ry
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 14:18:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iLWpH-0001yN-LA
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 14:18:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46254)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1iLWpH-0001xT-Ax; Fri, 18 Oct 2019 14:18:11 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8D0FC18C8906;
 Fri, 18 Oct 2019 18:18:10 +0000 (UTC)
Received: from [10.36.116.69] (ovpn-116-69.ams2.redhat.com [10.36.116.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 13D6119C7F;
 Fri, 18 Oct 2019 18:18:08 +0000 (UTC)
Subject: Re: [PATCH v1 4/6] s390x/tcg: Fix VECTOR SUBTRACT COMPUTE BORROW
 INDICATION
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
References: <20191018161044.6983-1-david@redhat.com>
 <20191018161044.6983-5-david@redhat.com>
 <d12a5c30-1953-7586-97d4-883131ac0b40@redhat.com>
Organization: Red Hat GmbH
Message-ID: <be613a08-a62e-c10d-5c5d-8b334e8f0985@redhat.com>
Date: Fri, 18 Oct 2019 20:18:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <d12a5c30-1953-7586-97d4-883131ac0b40@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Fri, 18 Oct 2019 18:18:10 +0000 (UTC)
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
Cc: Ivan Warren <ivan@vmfacility.fr>, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18.10.19 19:41, David Hildenbrand wrote:
> On 18.10.19 18:10, David Hildenbrand wrote:
>> Looks like my idea of what a "borrow" is was wrong. We are dealing with
>> unsigned numbers. A subtraction is simply an addition with the bitwise
>> complement. If we get a carry during the addition, that's the borrow.
>> "The operands are treated as unsigned binary integers."
>>
>> This is nice, as we can reuse the VECTOR ADD COMPUTE CARRY functions
>> and avoid helpers, all we have to do is compute the bitwise complement.
>>
>> Fixes: 1ee2d7ba72f6 ("s390x/tcg: Implement VECTOR SUBTRACT COMPUTE BORROW INDICATION")
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>    target/s390x/helper.h           |  2 --
>>    target/s390x/translate_vx.inc.c | 45 ++++++++++++++++++++++++---------
>>    target/s390x/vec_int_helper.c   | 16 ------------
>>    3 files changed, 33 insertions(+), 30 deletions(-)
>>
>> diff --git a/target/s390x/helper.h b/target/s390x/helper.h
>> index 56e8149866..ca1e08100a 100644
>> --- a/target/s390x/helper.h
>> +++ b/target/s390x/helper.h
>> @@ -207,8 +207,6 @@ DEF_HELPER_FLAGS_4(gvec_verim16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, i32)
>>    DEF_HELPER_FLAGS_4(gvec_vsl, TCG_CALL_NO_RWG, void, ptr, cptr, i64, i32)
>>    DEF_HELPER_FLAGS_4(gvec_vsra, TCG_CALL_NO_RWG, void, ptr, cptr, i64, i32)
>>    DEF_HELPER_FLAGS_4(gvec_vsrl, TCG_CALL_NO_RWG, void, ptr, cptr, i64, i32)
>> -DEF_HELPER_FLAGS_4(gvec_vscbi8, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, i32)
>> -DEF_HELPER_FLAGS_4(gvec_vscbi16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, i32)
>>    DEF_HELPER_4(gvec_vtm, void, ptr, cptr, env, i32)
>>    
>>    /* === Vector String Instructions === */
>> diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc.c
>> index 5ce7bfb0af..40bcc1604e 100644
>> --- a/target/s390x/translate_vx.inc.c
>> +++ b/target/s390x/translate_vx.inc.c
>> @@ -2130,14 +2130,40 @@ static DisasJumpType op_vs(DisasContext *s, DisasOps *o)
>>        return DISAS_NEXT;
>>    }
>>    
>> +static void gen_scbi8_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
>> +{
>> +    TCGv_i64 t = tcg_temp_new_i64();
>> +
>> +    tcg_gen_not_i64(t, b);
>> +    gen_acc(d, a, t, ES_8);
>> +    tcg_temp_free_i64(t);
>> +}
> 
> BTW, I would have thought that we need the 2nd complement in all these
> cases. However, the description of the other functions confused me
> (VECTOR SUBTRACT WITH BORROW INDICATION) - add bitwise complement and
> add the borrow.
> 
> This passes my test cases (that are verified against real HW), but I am
> not sure if I check all the corner cases.
> 
> @Richard, do you have any idea how to do it the right way for this
> instruction?
> 

My impression was right. A simple "0-0" test makes this visible. The 
other two fixes seem to be correct, though.

Will rework.

-- 

Thanks,

David / dhildenb

