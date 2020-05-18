Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABDBDC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:38:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8256620657
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:38:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8256620657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=digitalsignallabs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jahqu-00081c-Oo
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 11:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yates@digitalsignallabs.com>)
 id 1jahpz-0007Ah-Tm
 for qemu-devel@nongnu.org; Mon, 18 May 2020 11:37:55 -0400
Received: from mail.onyx.syn-alias.com ([206.152.134.66]:15060
 helo=smtp.centurylink.net)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yates@digitalsignallabs.com>)
 id 1jahpy-0004YY-Ud
 for qemu-devel@nongnu.org; Mon, 18 May 2020 11:37:55 -0400
X_CMAE_Category: , ,
X-CNFS-Analysis: v=2.3 cv=UcYvt5aN c=1 sm=1 tr=0
 a=/DUmtE38f4iOwNXrSUBayA==:117 a=/DUmtE38f4iOwNXrSUBayA==:17
 a=KGjhK52YXX0A:10 a=IkcTkHD0fZMA:10 a=sTwFKg_x9MkA:10 a=PPsO2EghCewA:10
 a=eQrCS-SpgXYA:10 a=Ixn1CAxRAAAA:8 a=KKAkSRfTAAAA:8 a=o83nqyVRAAAA:8
 a=yrnTiy7_AAAA:8 a=f8P1XVG16obXfP6Dja8A:9 a=F_KZppjTv5wU1dKm:21
 a=vfVfDnR6hk7UIB99:21 a=QEXdDO2ut3YA:10 a=_0vDLAJOulx5KDpLVjVP:22
 a=cvBusfyB2V15izCimMoJ:22 a=d2wp0cl8BqqoVUBAGsA6:22
X-CM-Score: 0
X-Scanned-by: Cloudmark Authority Engine
Feedback-ID: dfw:ctl:res:onyx
X-Authed-Username: eWF0ZXNmcmVlZGFyYW5keUBjZW50dXJ5bGluay5uZXQ=
Authentication-Results: smtp02.onyx.dfw.sync.lan
 smtp.user=yatesfreedarandy@centurylink.net; auth=pass (LOGIN)
Received: from [71.217.96.46] ([71.217.96.46:47022]
 helo=galois.digitalsignallabs.com)
 by smtp.centurylink.net (envelope-from <yates@digitalsignallabs.com>)
 (ecelerity 3.6.25.56547 r(Core:3.6.25.0)) with ESMTPA
 id 77/47-19512-ECBA2CE5; Mon, 18 May 2020 11:37:50 -0400
Received: from localhost.localdomain (unknown [71.217.96.46])
 by galois.digitalsignallabs.com (Postfix) with ESMTPA id 7C0D62E019C;
 Mon, 18 May 2020 11:37:49 -0400 (EDT)
From: Randy Yates <yates@digitalsignallabs.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH] target/arm: Allow user-mode code to write CPSR.E via MSR
Organization: Digital Signal Labs
References: <20200515185026.30080-1-peter.maydell@linaro.org>
 <327074ea-2c2f-ad45-b53f-1c4dcb69f9bf@linaro.org>
 <8c049fb3-7122-3ac5-e7bd-0c905bd459e4@amsat.org>
Date: Mon, 18 May 2020 11:37:49 -0400
In-Reply-To: <8c049fb3-7122-3ac5-e7bd-0c905bd459e4@amsat.org> ("Philippe
 \=\?utf-8\?Q\?Mathieu-Daud\=C3\=A9\=22's\?\= message of "Sat,
 16 May 2020 07:19:14 +0200")
Message-ID: <87k119i78y.fsf@digitalsignallabs.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=206.152.134.66;
 envelope-from=yates@digitalsignallabs.com; helo=smtp.centurylink.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 11:37:51
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Randy Yates <yates@ieee.org>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thank you Philippe and the QEMU team!

--Randy

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> On 5/15/20 11:26 PM, Richard Henderson wrote:
>> On 5/15/20 11:50 AM, Peter Maydell wrote:
>>> Using the MSR instruction to write to CPSR.E is deprecated, but it is
>>> required to work from any mode including unprivileged code.  We were
>>> incorrectly forbidding usermode code from writing it because
>>> CPSR_USER did not include the CPSR_E bit.
>>>
>>> We use CPSR_USER in only three places:
>>>   * as the mask of what to allow userspace MSR to write to CPSR
>>>   * when deciding what bits a linux-user signal-return should be
>>>     able to write from the sigcontext structure
>>>   * in target_user_copy_regs() when we set up the initial
>>>     registers for the linux-user process
>>>
>>> In the first two cases not being able to update CPSR.E is a
>>> bug, and in the third case it doesn't matter because CPSR.E
>>> is always 0 there. So we can fix both bugs by adding CPSR_E
>>> to CPSR_EXEC.
>>
>> Wrong variable in description here.
>
> Indeed CPSR_EXEC -> CPSR_USER typo.
>
>>
>> Otherwise,
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>
>>
>> r~
>>
>>>
>>> (The recommended way to change CPSR.E is to use the 'SETEND'
>>> instruction, which we do correctly allow from usermode code.)
>>>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>> Bug reported on IRC.
>
> Similar to commit a1ecb4381829d7:
>
> Reported-by: Randy Yates <yates@ieee.org>
>
>> Quick-and-dirty test case at:
>>>   https://people.linaro.org/~peter.maydell/msr-setend.c
>>>
>>>   target/arm/cpu.h | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>>> index 5d995368d4f..677584e5da0 100644
>>> --- a/target/arm/cpu.h
>>> +++ b/target/arm/cpu.h
>>> @@ -1230,7 +1230,7 @@ void pmu_init(ARMCPU *cpu);
>>>   #define CACHED_CPSR_BITS (CPSR_T | CPSR_AIF | CPSR_GE | CPSR_IT | CPS=
R_Q \
>>>       | CPSR_NZCV)
>>>   /* Bits writable in user mode.  */
>>> -#define CPSR_USER (CPSR_NZCV | CPSR_Q | CPSR_GE)
>>> +#define CPSR_USER (CPSR_NZCV | CPSR_Q | CPSR_GE | CPSR_E)
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
>>>   /* Execution state bits.  MRS read as zero, MSR writes ignored.  */
>>>   #define CPSR_EXEC (CPSR_T | CPSR_IT | CPSR_J | CPSR_IL)
>>>=20=20=20
>>>
>>
>>
>

--=20
Randy Yates, DSP/Embedded Firmware Developer
Digital Signal Labs
http://www.digitalsignallabs.com

