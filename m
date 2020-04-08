Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3F2C2D0EA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 06:14:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AB8020730
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 06:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=apple.com header.i=@apple.com header.b="pbSSTzyL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB8020730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jM3yl-0007mV-MG
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 02:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59015)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty@apple.com>) id 1jM3y0-00076A-BH
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 02:13:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty@apple.com>) id 1jM3xz-0002tY-7e
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 02:13:40 -0400
Received: from nwk-aaemail-lapp03.apple.com ([17.151.62.68]:46404)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dirty@apple.com>) id 1jM3xy-0002tH-UX
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 02:13:39 -0400
Received: from pps.filterd (nwk-aaemail-lapp03.apple.com [127.0.0.1])
 by nwk-aaemail-lapp03.apple.com (8.16.0.27/8.16.0.27) with SMTP id
 0386BwW8033579; Tue, 7 Apr 2020 23:13:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=sender : content-type
 : mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=20180706;
 bh=tYwPd7/9kGEzFTMdPUfuPd02l0/hQ/TzVGc4gL41Lik=;
 b=pbSSTzyL9FLBAd5kSskm/NiVsK6dJsVfMy1skTcdiRkmrAxBQ/SHEcAbFDfl51nCqrO/
 7m67yRL/RwFL5AtdNhgMpXLlhyzqUtBkCF/zFyQmxcCpNg7lZ1pauC5gezAlJV293DSp
 SGXjykOhkJGZQK4oPvd1cg8jwGe4OXfpCEiNWfIe4c+xmKw7WvuNtOxN4QN8lqDXU4C1
 33mjkMcauObhFzNv01nBdr5EJIP2L2++po9bpjDnk011C7bLN7KPmVnqMjaYj4s5v2sk
 yyGxFovkTkulaYPFYkvOMkyOapS/62cwNvNhEjX1EtAv175GTAfrhsLjNkpQl0bUVKVp Pg== 
Received: from rn-mailsvcp-mta-lapp04.rno.apple.com
 (rn-mailsvcp-mta-lapp04.rno.apple.com [10.225.203.152])
 by nwk-aaemail-lapp03.apple.com with ESMTP id 3091hnxm3t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Tue, 07 Apr 2020 23:13:37 -0700
Received: from rn-mailsvcp-mmp-lapp03.rno.apple.com
 (rn-mailsvcp-mmp-lapp03.rno.apple.com [17.179.253.16])
 by rn-mailsvcp-mta-lapp04.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020)) with ESMTPS id <0Q8G00K2KHAPH530@rn-mailsvcp-mta-lapp04.rno.apple.com>; 
 Tue, 07 Apr 2020 23:13:37 -0700 (PDT)
Received: from process_milters-daemon.rn-mailsvcp-mmp-lapp03.rno.apple.com by
 rn-mailsvcp-mmp-lapp03.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020)) id <0Q8G00A00H7TD500@rn-mailsvcp-mmp-lapp03.rno.apple.com>; Tue,
 07 Apr 2020 23:13:37 -0700 (PDT)
X-Va-A: 
X-Va-T-CD: 99f89d79671c95ffdbff058802d4710e
X-Va-E-CD: 34a278cb7c818dbc69944c99c536a0f2
X-Va-R-CD: 68f981851bdce5e823c6430bc244ff39
X-Va-CD: 0
X-Va-ID: 1b30282c-1aab-4c61-9c11-dffd3043099a
X-V-A: 
X-V-T-CD: 99f89d79671c95ffdbff058802d4710e
X-V-E-CD: 34a278cb7c818dbc69944c99c536a0f2
X-V-R-CD: 68f981851bdce5e823c6430bc244ff39
X-V-CD: 0
X-V-ID: 1e052a03-6a39-4fa1-ba76-74e177e02db6
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-07_10:2020-04-07,
 2020-04-07 signatures=0
Received: from [17.234.109.17] (unknown [17.234.109.17])
 by rn-mailsvcp-mmp-lapp03.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020))
 with ESMTPSA id <0Q8G00KP1HAPUK00@rn-mailsvcp-mmp-lapp03.rno.apple.com>; Tue,
 07 Apr 2020 23:13:37 -0700 (PDT)
Content-type: text/plain; charset=us-ascii
MIME-version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v1 2/3] hvf: Make long mode enter and exit code clearer.
In-reply-to: <20200405185125.GD74346@SPB-NB-133.local>
Date: Tue, 07 Apr 2020 23:13:37 -0700
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com
Content-transfer-encoding: quoted-printable
Message-id: <82DAC78F-C970-4CF7-871F-5E96C4F0C75F@apple.com>
References: <cover.1585607927.git.dirty@apple.com>
 <17777cc82122d29903bad7268b4c33e83b27d9a6.1585607927.git.dirty@apple.com>
 <20200405185125.GD74346@SPB-NB-133.local>
To: Roman Bolshakov <r.bolshakov@yadro.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-07_10:2020-04-07,
 2020-04-07 signatures=0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 17.151.62.68
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

I'll update with your feedback.

Cameron Esfahani
dirty@apple.com

"We do what we must because we can."

Aperture Science



> On Apr 5, 2020, at 11:51 AM, Roman Bolshakov <r.bolshakov@yadro.com> =
wrote:
>=20
> On Mon, Mar 30, 2020 at 05:16:05PM -0700, Cameron Esfahani wrote:
>> Signed-off-by: Cameron Esfahani <dirty@apple.com>
>> ---
>> target/i386/hvf/vmx.h | 12 +++++++-----
>> 1 file changed, 7 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/target/i386/hvf/vmx.h b/target/i386/hvf/vmx.h
>> index 8ec2e6414e..1a1b150c97 100644
>> --- a/target/i386/hvf/vmx.h
>> +++ b/target/i386/hvf/vmx.h
>> @@ -121,6 +121,7 @@ static inline void macvm_set_cr0(hv_vcpuid_t =
vcpu, uint64_t cr0)
>>     uint64_t pdpte[4] =3D {0, 0, 0, 0};
>>     uint64_t efer =3D rvmcs(vcpu, VMCS_GUEST_IA32_EFER);
>>     uint64_t old_cr0 =3D rvmcs(vcpu, VMCS_GUEST_CR0);
>> +    uint64_t changed_cr0 =3D old_cr0 ^ cr0;
>>     uint64_t mask =3D CR0_PG_MASK | CR0_CD_MASK | CR0_NW_MASK |
>>                     CR0_NE_MASK | CR0_ET_MASK;
>>=20
>> @@ -139,11 +140,12 @@ static inline void macvm_set_cr0(hv_vcpuid_t =
vcpu, uint64_t cr0)
>>     wvmcs(vcpu, VMCS_CR0_SHADOW, cr0);
>>=20
>>     if (efer & MSR_EFER_LME) {
>> -        if (!(old_cr0 & CR0_PG_MASK) && (cr0 & CR0_PG_MASK)) {
>> -            enter_long_mode(vcpu, cr0, efer);
>> -        }
>> -        if (!(cr0 & CR0_PG_MASK)) {
>> -            exit_long_mode(vcpu, cr0, efer);
>> +        if (changed_cr0 & CR0_PG_MASK) {
>> +            if (cr0 & CR0_PG_MASK) {
>> +                enter_long_mode(vcpu, cr0, efer);
>> +            } else {
>> +                exit_long_mode(vcpu, cr0, efer);
>> +            }
>>         }
>>     }
>>=20
>> --=20
>> 2.24.0
>>=20
>=20
> The changes look good but I have a few nitpicks.
>=20
> The summary line should not have "." at the end, please see
> =
(https://wiki.qemu.org/Contribute/SubmitAPatch#Write_a_meaningful_commit_m=
essage):
>> Whether the "single line summary of change" starts with a capital is =
a
>> matter of taste, but we prefer that the summary does not end in "."
>=20
> Also, it would be good to mention in the title/commit message that =
with the
> change QEMU is skipping unconditional writes to the guest =
IA32_EFER.LMA
> and VMCS Entry Controls in compatibility mode, instead it does so only
> when the actual switch out of long mode happens. (It's worth to =
mention
> any other issues the patch helps to address, if any).
>=20
> The comment in the previous patch may be dropped here IMO.
>=20
> Besides that,
> Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>
>=20
> Thanks,
> Roman


