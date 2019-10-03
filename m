Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5DADC32792
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 11:12:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C08B7218DE
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 11:12:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C08B7218DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFz25-0000nA-VC
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 07:12:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33222)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefan.brankovic@rt-rk.com>) id 1iFz1J-0000Az-Sx
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 07:11:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefan.brankovic@rt-rk.com>) id 1iFz1I-0003eI-03
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 07:11:41 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:36587 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefan.brankovic@rt-rk.com>)
 id 1iFz1H-0003cn-LS; Thu, 03 Oct 2019 07:11:39 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 66EB91A2079;
 Thu,  3 Oct 2019 13:11:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from [10.10.13.132] (rtrkw870-lin.domain.local [10.10.13.132])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 4EA1C1A2022;
 Thu,  3 Oct 2019 13:11:35 +0200 (CEST)
Subject: Re: target/ppc: bug in optimised vsl/vsr implementation?
From: Stefan Brankovic <stefan.brankovic@rt-rk.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <bf30baf5-4d75-dc6f-c30a-57b80714999b@ilande.co.uk>
 <CAL1e-=gcK2mdtrt9vibHGpbm4_FZgQWTA91+p=9ouuMYmZwPqQ@mail.gmail.com>
 <c9679b01-91c3-3d69-fb38-dfef1602dcf4@ilande.co.uk>
 <16069cfc-66c6-0629-51de-6dfe39214e11@rt-rk.com>
Message-ID: <703facbe-a544-3185-30e7-1918af8dccdf@rt-rk.com>
Date: Thu, 3 Oct 2019 13:11:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <16069cfc-66c6-0629-51de-6dfe39214e11@rt-rk.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 89.216.37.149
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
Cc: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Paul Clarke <pc@us.ibm.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Please take a look at the following patch=20
https://lists.nongnu.org/archive/html/qemu-ppc/2019-10/msg00133.html and=20
let me know if problem is solved.

On 2.10.19. 16:08, Stefan Brankovic wrote:
> Hi Mark,
>
> Thank you for reporting this bug. I was away from office for couple of=20
> days, so that's why I am answering you a bit late, sorry about that. I=20
> will start working on a solution and try to fix this problem in next=20
> couple of days.
>
> On 1.10.19. 20:24, Mark Cave-Ayland wrote:
>> On 28/09/2019 18:45, Aleksandar Markovic wrote:
>>
>> Hi Aleksandar,
>>
>> Thanks for taking a look at this!
>>
>>> Mark and Paul (and Stefan),
>>>
>>> Thanks for spotting this and pinpointing the culprit commit. I guess=20
>>> Stefan is going
>>> to respond soon, but, in the meantime, I took a look at the commit=20
>>> in question:
>>>
>>> https://github.com/qemu/qemu/commit/4e6d0920e7547e6af4bbac5ffe9adfe6e=
a621822=20
>>>
>>>
>>> I don't have at the moment any dev/test environment handy, but I did=20
>>> manual
>>> inspection of the code, and here is what I found (in order of=20
>>> importance, perceived
>>> by me):
>>>
>>> 1. The code will not work correctly if the shift ammount (variable=20
>>> 'sh') is 0. This
>>> is because, in that case, one of succeeding invocations of TCG shift=20
>>> functions will
>>> be required to shift a 64-bit TCG variable by 64 bits, and the=20
>>> result of such TCG
>>> operation is undefined (shift amount must be 63 or less) - see
>>> https://github.com/qemu/qemu/blob/master/tcg/README.
>> Yes I think you're right here - the old helper got around this by=20
>> doing an explicit
>> copy from a to r if the shift value is zero. In fact the case that=20
>> Paul reported is
>> exactly this:
>>
>> =C2=A0=C2=A0=C2=A0 vsl VRT, VRA, VRB
>>
>> =3D> 0x100006e0 <vec_slq+132>: vsl v0,v0,v1
>> (gdb) p $vr0.uint128
>> $21 =3D 0x10111213141516172021222324252650
>> (gdb) p $vr1.uint128
>> $22 =3D 0x0
>> (gdb) stepi
>> 0x00000000100006e4 in vec_slq ()
>> 1: x/i $pc
>> =3D> 0x100006e4 <vec_slq+136>: xxlor vs0,vs32,vs32
>> (gdb) p $vr0.uint128
>> $23 =3D 0x10111213141516172021222324252650
>>
>> I guess the solution is check for sh =3D=3D 0 and if this is the case,=
=20
>> execute a copy
>> instead.
> I agree with you. This will be changed in upcoming patch.
>>
>>> 2. Variable naming is better in the old helper than in the new=20
>>> translator. In that
>>> light, I would advise Stefan to change 'sh' to 'shift', and=20
>>> 'shifted' to 'carry'.
>> It looks like the name "sh" comes from the ISA documentation, so=20
>> whilst it's a little
>> tricky to compare with the previous implementation it does make sense=20
>> when comparing
>> with the algorithm shown there. Note: this implementation also drops=20
>> the check for
>> each byte of VRB having the same shift value - should we care about=20
>> this?
>
> "sh" is taken from the ISA documentation, so I would leave that as it=20
> is now, but I can change some other variable names to be consistent=20
> with previous implementation (e.g. "shifted" -> "carry").
>
> I don't think that we should check each byte of VRB, because we care=20
> only about "defined" behavior. If shift values doesn't match, result=20
> is "undefined" so it doesn't matter what is inside resulting register.
>
>>> 3. Lines
>>>
>>> tcg_gen_andi_i64(shifted, shifted, 0x7fULL);
>>>
>>> and
>>>
>>> tcg_gen_andi_i64(shifted, shifted, 0xfe00000000000000ULL);
>>>
>>> appear to be spurious (albait in a harmless way). Therefore, they=20
>>> should be deleted,
>>> or, alternatevely, a justification for them should be provided.
>> I'm not sure why they are needed either - there's certainly no=20
>> mention of it in the
>> ISA documentation. Stefan?
> This will be removed in upcoming patch.
>>
>>> 4. In the commit message, variable names were used without quotation=20
>>> mark, resulting
>>> in puzzling and unclear wording.
>>>
>>> 5. (a question for Mark) After all recent changes, does=20
>>> get_avr64(..., ..., true)
>>> always (for any endian configuration) return the "high" half of an=20
>>> Altivec register,
>>> and get_avr64(..., ..., false) the "low" one?
>> Yes - the new functions always return the MSB (high) and LSB (low)=20
>> correctly
>> regardless of host endian.
>>
>>> Given all these circumstances, perhaps the most reasonable solution=20
>>> would be to
>>> revert the commit in question, and allow Stefan enough dev and test=20
>>> time to hopefully
>>> submit a new, better, version later on.
>> Given that it has been broken for 3 months now, I don't think we're=20
>> in any major rush
>> to revert ASAP. I'd prefer to give Stefan a bit more time first since=20
>> he does report
>> some substantial speed improvements from these new implementations.
>>
>>
>> ATB,
>>
>> Mark.
>
> Best Regards,
>
> Stefan
>

