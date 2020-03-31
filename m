Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E737C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 02:05:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C32302072D
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 02:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=apple.com header.i=@apple.com header.b="rUMDA4fT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C32302072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ6HN-0001bo-Uv
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 22:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51221)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty@apple.com>) id 1jJ6Gh-0001D3-HL
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 22:04:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty@apple.com>) id 1jJ6Gf-0004cC-Fi
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 22:04:43 -0400
Received: from ma1-aaemail-dr-lapp01.apple.com ([17.171.2.60]:39040)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dirty@apple.com>) id 1jJ6Ge-0004Yr-TX
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 22:04:41 -0400
Received: from pps.filterd (ma1-aaemail-dr-lapp01.apple.com [127.0.0.1])
 by ma1-aaemail-dr-lapp01.apple.com (8.16.0.27/8.16.0.27) with SMTP id
 02V22rkf019289; Mon, 30 Mar 2020 19:04:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=sender : content-type
 : mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=20180706;
 bh=S/Gi2UtCbvR2vWkZuR4ZiGne+S6k5ItrPJxzu2uTv7I=;
 b=rUMDA4fT7A1t5FBcQ1P4+Jk5DZ/a+CSnI9Mudszck+epY8b0YxfBWrqnCWKpMmiiTWie
 TY/uVvEpPyGsTJYs8kJ3XOQogDA9JdcoHSsa0gxu5wUqISUZcnMr1mYg94PQgl0qtSnn
 U+9+DxsMuhbefdkmj8u0y9EQ+S7M3PkfhQQ5fI2N9Y/FhInod2BvdqVOonY7G55kzdqg
 qOCEc+XdGx35UDQBpPD2rod9EESz5WNO6qNbXDNEAn8275s97HjByNR0KhquA+SMrRLf
 P2TwDj1KSxINtDPGHlp/rcbfZHnZ2x/B22kuVFYamV/kNHONC0Y446AuSqaRL+H6ySU7 tw== 
Received: from rn-mailsvcp-mta-lapp02.rno.apple.com
 (rn-mailsvcp-mta-lapp02.rno.apple.com [10.225.203.150])
 by ma1-aaemail-dr-lapp01.apple.com with ESMTP id 302582k6qg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Mon, 30 Mar 2020 19:04:38 -0700
Received: from rn-mailsvcp-mmp-lapp02.rno.apple.com
 (rn-mailsvcp-mmp-lapp02.rno.apple.com [17.179.253.15])
 by rn-mailsvcp-mta-lapp02.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020)) with ESMTPS id <0Q81003LZCFQM640@rn-mailsvcp-mta-lapp02.rno.apple.com>; 
 Mon, 30 Mar 2020 19:04:38 -0700 (PDT)
Received: from process_milters-daemon.rn-mailsvcp-mmp-lapp02.rno.apple.com by
 rn-mailsvcp-mmp-lapp02.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020)) id <0Q8100A00CCI0N00@rn-mailsvcp-mmp-lapp02.rno.apple.com>; Mon,
 30 Mar 2020 19:04:38 -0700 (PDT)
X-Va-A: 
X-Va-T-CD: 20c0c410705af0c5efefeb0380f25862
X-Va-E-CD: 2fde7b6a17f481efbdb3880150911029
X-Va-R-CD: 852e2779f424d6adcac7bda87edb4646
X-Va-CD: 0
X-Va-ID: 22ece592-74e7-4c03-b080-21e5713e4019
X-V-A: 
X-V-T-CD: 20c0c410705af0c5efefeb0380f25862
X-V-E-CD: 2fde7b6a17f481efbdb3880150911029
X-V-R-CD: 852e2779f424d6adcac7bda87edb4646
X-V-CD: 0
X-V-ID: ece5a85f-e059-4ab5-85f1-a93eb794b161
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-03-30_07:2020-03-30,
 2020-03-30 signatures=0
Received: from [17.234.84.168] (unknown [17.234.84.168])
 by rn-mailsvcp-mmp-lapp02.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020))
 with ESMTPSA id <0Q8100NW2CFPZR00@rn-mailsvcp-mmp-lapp02.rno.apple.com>; Mon,
 30 Mar 2020 19:04:37 -0700 (PDT)
Content-type: text/plain; charset=us-ascii
MIME-version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] i386: hvf: Reset IRQ inhibition after moving RIP
In-reply-to: <20200328174411.51491-1-r.bolshakov@yadro.com>
Date: Mon, 30 Mar 2020 19:04:37 -0700
Cc: Cameron Esfahani via <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Content-transfer-encoding: quoted-printable
Message-id: <E08111ED-C32B-4CAF-8302-BF82C9D05A63@apple.com>
References: <20200328174411.51491-1-r.bolshakov@yadro.com>
To: Roman Bolshakov <r.bolshakov@yadro.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-03-31_01:2020-03-30,
 2020-03-31 signatures=0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 17.171.2.60
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

Reviewed-by: Cameron Esfahani <dirty@apple.com>

LGTM.

Cameron Esfahani
dirty@apple.com

"There are times in the life of a nation when the only place a decent =
man can find himself is in prison."



> On Mar 28, 2020, at 10:44 AM, Roman Bolshakov <r.bolshakov@yadro.com> =
wrote:
>=20
> The sequence of instructions exposes an issue:
>  sti
>  hlt
>=20
> Interrupts cannot be delivered to hvf after hlt instruction cpu =
because
> HF_INHIBIT_IRQ_MASK is set just before hlt is handled and never reset
> after moving instruction pointer beyond hlt.
>=20
> So, after hvf_vcpu_exec() returns, CPU thread gets locked up forever =
in
> qemu_wait_io_event() (cpu_thread_is_idle() evaluates inhibition
> flag and considers the CPU idle if the flag is set).
>=20
> Cc: Cameron Esfahani <dirty@apple.com>
> Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
> ---
> target/i386/hvf/vmx.h | 3 +++
> 1 file changed, 3 insertions(+)
>=20
> diff --git a/target/i386/hvf/vmx.h b/target/i386/hvf/vmx.h
> index 03d2c79b9c..ce2a1532d5 100644
> --- a/target/i386/hvf/vmx.h
> +++ b/target/i386/hvf/vmx.h
> @@ -167,6 +167,8 @@ static inline void macvm_set_cr4(hv_vcpuid_t vcpu, =
uint64_t cr4)
>=20
> static inline void macvm_set_rip(CPUState *cpu, uint64_t rip)
> {
> +    X86CPU *x86_cpu =3D X86_CPU(cpu);
> +    CPUX86State *env =3D &x86_cpu->env;
>     uint64_t val;
>=20
>     /* BUG, should take considering overlap.. */
> @@ -176,6 +178,7 @@ static inline void macvm_set_rip(CPUState *cpu, =
uint64_t rip)
>    val =3D rvmcs(cpu->hvf_fd, VMCS_GUEST_INTERRUPTIBILITY);
>    if (val & (VMCS_INTERRUPTIBILITY_STI_BLOCKING |
>                VMCS_INTERRUPTIBILITY_MOVSS_BLOCKING)) {
> +        env->hflags &=3D ~HF_INHIBIT_IRQ_MASK;
>         wvmcs(cpu->hvf_fd, VMCS_GUEST_INTERRUPTIBILITY,
>                val & ~(VMCS_INTERRUPTIBILITY_STI_BLOCKING |
>                VMCS_INTERRUPTIBILITY_MOVSS_BLOCKING));
> --=20
> 2.24.1
>=20
>=20


