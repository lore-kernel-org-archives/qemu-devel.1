Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E719C2D0EA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 06:09:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0141B20692
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 06:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=apple.com header.i=@apple.com header.b="gBChRQYP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0141B20692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jM3uO-000695-6r
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 02:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58619)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty@apple.com>) id 1jM3tk-0005gy-4Y
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 02:09:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty@apple.com>) id 1jM3ti-0001Rd-Vs
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 02:09:16 -0400
Received: from ma1-aaemail-dr-lapp03.apple.com ([17.171.2.72]:51122)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dirty@apple.com>) id 1jM3ti-0001RP-QV
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 02:09:14 -0400
Received: from pps.filterd (ma1-aaemail-dr-lapp03.apple.com [127.0.0.1])
 by ma1-aaemail-dr-lapp03.apple.com (8.16.0.27/8.16.0.27) with SMTP id
 03866qex049398; Tue, 7 Apr 2020 23:09:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=sender : content-type
 : mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=20180706;
 bh=Xg1lqrZzQaW7O9sufhOnQgOlBJzym9ZdVK9SRR6ZyVo=;
 b=gBChRQYPLJE3879IcR0WmlnMpKg077FV+hhEq3G42+w8AQAJ08ajLc9sOj2huD3S+c09
 SSho0WFHrx42O9Z6GVWFHy+DXhs4bX94AFPMYljX76tL0FoQqcxdavLfdEQD+QxzpL/N
 HzBheUx6OxWU12QBWnyU2vZ+O3sWAMrvLlFN5S26lKfzK1EtNw4EeZ/6rqobt0xQdm5t
 8NqKeC26PQG0PzqXFe1lZeuzK4t4u8qp8ZzygBu/m+05NGv0Pp9EwRVNBeSwBnO6pC06
 EhqJrqEK6TO51iWPMVA55V80K8lgWN5Mtq9laU3sOMLcVzrIw/So2TBHFFJEgJT1/Xoh aQ== 
Received: from rn-mailsvcp-mta-lapp02.rno.apple.com
 (rn-mailsvcp-mta-lapp02.rno.apple.com [10.225.203.150])
 by ma1-aaemail-dr-lapp03.apple.com with ESMTP id 3091j7ek5v-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Tue, 07 Apr 2020 23:09:13 -0700
Received: from rn-mailsvcp-mmp-lapp03.rno.apple.com
 (rn-mailsvcp-mmp-lapp03.rno.apple.com [17.179.253.16])
 by rn-mailsvcp-mta-lapp02.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020)) with ESMTPS id <0Q8G00GWZH3DIZ50@rn-mailsvcp-mta-lapp02.rno.apple.com>; 
 Tue, 07 Apr 2020 23:09:13 -0700 (PDT)
Received: from process_milters-daemon.rn-mailsvcp-mmp-lapp03.rno.apple.com by
 rn-mailsvcp-mmp-lapp03.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020)) id <0Q8G00T00G7F6G00@rn-mailsvcp-mmp-lapp03.rno.apple.com>; Tue,
 07 Apr 2020 23:09:13 -0700 (PDT)
X-Va-A: 
X-Va-T-CD: 99f89d79671c95ffdbff058802d4710e
X-Va-E-CD: a26c18c053d496a6a99a5bbaebf7aa0f
X-Va-R-CD: 4418ea81e33bab463d2e18df7d3059df
X-Va-CD: 0
X-Va-ID: f479584f-8395-4ba6-a3b8-e62821c112a3
X-V-A: 
X-V-T-CD: 99f89d79671c95ffdbff058802d4710e
X-V-E-CD: a26c18c053d496a6a99a5bbaebf7aa0f
X-V-R-CD: 4418ea81e33bab463d2e18df7d3059df
X-V-CD: 0
X-V-ID: a81d6be4-fe0c-4373-8566-2fd994533c23
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-07_10:2020-04-07,
 2020-04-07 signatures=0
Received: from [17.234.109.17] (unknown [17.234.109.17])
 by rn-mailsvcp-mmp-lapp03.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020))
 with ESMTPSA id <0Q8G009VEH3CX510@rn-mailsvcp-mmp-lapp03.rno.apple.com>; Tue,
 07 Apr 2020 23:09:13 -0700 (PDT)
Content-type: text/plain; charset=us-ascii
MIME-version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v1 1/3] hvf: use standard CR0 and CR4 register definitions
In-reply-to: <20200405175845.GC74346@SPB-NB-133.local>
Date: Tue, 07 Apr 2020 23:09:12 -0700
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com
Content-transfer-encoding: quoted-printable
Message-id: <47A5AD5B-50BF-4E7B-BE64-64B97E820E8A@apple.com>
References: <cover.1585607927.git.dirty@apple.com>
 <9ba0495405a1cd1e6c272a1e67d54dfda09494e1.1585607927.git.dirty@apple.com>
 <20200405175845.GC74346@SPB-NB-133.local>
To: Roman Bolshakov <r.bolshakov@yadro.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-07_10:2020-04-07,
 2020-04-07 signatures=0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 17.171.2.72
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Cameron Esfahani <dirty@apple.com>
From: Cameron Esfahani via <qemu-devel@nongnu.org>

Responses inline

Cameron Esfahani
dirty@apple.com

"We do what we must because we can."

Aperture Science



> On Apr 5, 2020, at 10:58 AM, Roman Bolshakov <r.bolshakov@yadro.com> =
wrote:
>=20
> On Mon, Mar 30, 2020 at 05:16:04PM -0700, Cameron Esfahani wrote:
>> Signed-off-by: Cameron Esfahani <dirty@apple.com>
>> ---
>> target/i386/cpu.h          |  2 ++
>> target/i386/hvf/hvf.c      |  1 +
>> target/i386/hvf/vmx.h      | 15 ++++++++-------
>> target/i386/hvf/x86.c      |  6 +++---
>> target/i386/hvf/x86.h      | 34 ----------------------------------
>> target/i386/hvf/x86_mmu.c  |  2 +-
>> target/i386/hvf/x86_task.c |  3 ++-
>> 7 files changed, 17 insertions(+), 46 deletions(-)
>>=20
>=20
> Hi Cameron,
>=20
> I'm sorry for delay.
>=20
> This is fun, I had very similar changeset I forgot to send quite a =
while
> ago:
> https://github.com/roolebo/qemu/commits/hvf-common-cr-constants
>=20
>> diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
>> index d72543dc31..fef1ee7d70 100644
>> --- a/target/i386/hvf/hvf.c
>> +++ b/target/i386/hvf/hvf.c
>> @@ -455,6 +455,7 @@ void hvf_reset_vcpu(CPUState *cpu) {
>>         wvmcs(cpu->hvf_fd, VMCS_GUEST_PDPTE0 + i * 2, pdpte[i]);
>>     }
>>=20
>> +    macvm_set_cr0(cpu->hvf_fd, CR0_CD_MASK | CR0_NW_MASK | =
CR0_ET_MASK);
>>     macvm_set_cr0(cpu->hvf_fd, 0x60000010);
>=20
> The second macvm_set_cr0() is a duplicate of the first one and should =
be
> dropped.
>=20

I'll fix it in next patch update, pending feedback from next issue.

>>=20
>>     wvmcs(cpu->hvf_fd, VMCS_CR4_MASK, CR4_VMXE_MASK);
>> diff --git a/target/i386/hvf/vmx.h b/target/i386/hvf/vmx.h
>> index 03d2c79b9c..8ec2e6414e 100644
>> --- a/target/i386/hvf/vmx.h
>> +++ b/target/i386/hvf/vmx.h
>> @@ -138,17 +139,17 @@ static inline void macvm_set_cr0(hv_vcpuid_t =
vcpu, uint64_t cr0)
>>     wvmcs(vcpu, VMCS_CR0_SHADOW, cr0);
>>=20
>>     if (efer & MSR_EFER_LME) {
>> -        if (!(old_cr0 & CR0_PG) && (cr0 & CR0_PG)) {
>> +        if (!(old_cr0 & CR0_PG_MASK) && (cr0 & CR0_PG_MASK)) {
>>             enter_long_mode(vcpu, cr0, efer);
>>         }
>> -        if (/*(old_cr0 & CR0_PG) &&*/ !(cr0 & CR0_PG)) {
>> +        if (!(cr0 & CR0_PG_MASK)) {
>=20
> IMO the patch should only change CR0_PG to CR0_PG_MASK without removal
> of the commented condition.
>=20
> In the next patch you're improving how long mode exit is done and
> replacement of the comment with an implementation fits better there.
>=20

The reason I removed that code was because checkpatch.pl scolded me for =
a patch with code commented out.

I assumed that I'd get a similar warning from patchew.org about some =
erroneous coding styles.

So I thought the easiest thing would be to remove that code as well.

But I'll defer to you or Paolo: should I remove that commented code with =
this patch?

>>             exit_long_mode(vcpu, cr0, efer);
>>         }
>>     }
>>=20
>>     /* Filter new CR0 after we are finished examining it above. */
>> -    cr0 =3D (cr0 & ~(mask & ~CR0_PG));
>> -    wvmcs(vcpu, VMCS_GUEST_CR0, cr0 | CR0_NE | CR0_ET);
>> +    cr0 =3D (cr0 & ~(mask & ~CR0_PG_MASK));
>> +    wvmcs(vcpu, VMCS_GUEST_CR0, cr0 | CR0_NE_MASK | CR0_ET_MASK);
>>=20
>>     hv_vcpu_invalidate_tlb(vcpu);
>>     hv_vcpu_flush(vcpu);
>> --=20
>> 2.24.0
>>=20
>=20
> Best regards,
> Roman


