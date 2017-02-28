Received: from eggs.gnu.org ([2001:4830:134:3::10]:56653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1ciaAS-0006XR-QJ
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 00:17:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1ciaAP-0002OQ-Kb
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 00:17:44 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49172
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1ciaAP-0002NH-E3
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 00:17:41 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1S5A9Hs094212
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 00:17:39 -0500
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28w28k9dfa-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 00:17:38 -0500
Received: from localhost
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Tue, 28 Feb 2017 15:17:26 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id C37FE3578057
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 16:17:24 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v1S5HGu248627782
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 16:17:24 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v1S5Gq03027866
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 16:16:52 +1100
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <1488224492-20316-2-git-send-email-joserz@linux.vnet.ibm.com>
References: <1488224492-20316-1-git-send-email-joserz@linux.vnet.ibm.com>
	<1488224492-20316-2-git-send-email-joserz@linux.vnet.ibm.com>
Date: Tue, 28 Feb 2017 10:45:35 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87tw7eew08.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH Risu 1/5] risugen_ppc64: Load random
 128-bit data to VSX registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com> writes:

> Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> ---
>  risugen_ppc64.pm | 40 +++++++++++++++++++++++++++++-----------
>  1 file changed, 29 insertions(+), 11 deletions(-)
>
> diff --git a/risugen_ppc64.pm b/risugen_ppc64.pm
> index cb75300..28b6792 100644
> --- a/risugen_ppc64.pm
> +++ b/risugen_ppc64.pm
> @@ -99,6 +99,29 @@ sub write_mov_ri64($$)
>      insn32((0x3e << 26) | (20 << 21) | (1 << 16) | 0x10);
>  }
>
> +sub write_mov_ri128($$$$)
> +{
> +    my ($imhh, $imh, $iml, $imll) = @_;
> +
> +    # store the lowest 32 bits
> +    write_mov_ri32(20, $imll);
> +    # stw r20, 16(r1)
> +    insn32((0x24 << 26) | (20 << 21) | (1 << 16) | 0x10);
> +    # store the lower 32 bits
> +    write_mov_ri32(20, $iml);
> +    # stw r20, 20(r1)
> +    insn32((0x24 << 26) | (20 << 21) | (1 << 16) | 0x14);
> +    # store the higher 32 bits
> +    write_mov_ri32(20, $imh);
> +    # stw r20, 24(r1)
> +    insn32((0x24 << 26) | (20 << 21) | (1 << 16) | 0x18);
> +    # store the highest 32 bits
> +    write_mov_ri32(20, $imhh);
> +    # stw r20, 28(r1)
> +    insn32((0x24 << 26) | (20 << 21) | (1 << 16) | 0x1c);
> +
> +}
> +
>  sub write_random_ppc64_fpdata()
>  {
>      for (my $i = 0; $i < 32; $i++) {
> @@ -106,22 +129,16 @@ sub write_random_ppc64_fpdata()
>          write_mov_ri64(rand(0xfffff), rand(0xfffff));
>          # since the EA is r1+16, load such value in FP reg
>          insn32((0x32 << 26) | ($i << 21) | (0x1 << 16) | 0x10);
> -        insn32((0x39 << 26) | ($i << 21) | (0x1 << 16) | 0x12);
> -
>      }
>  }
>
> -sub write_random_ppc64_fpdata_i()
> +sub write_random_ppc64_vsxdata()
>  {
> -    # get an space from the stack
> -    insn32(0x3ac10020); # addi r22, r1, 32
> -    insn32(0x3ee03ff0); # lis r23, 0x3ff0
> -    insn32(0x3af70000); # addi r23, r23, 0
> -    insn32(0xfaf60000); # std r23, 0(r22)
> -
>      for (my $i = 0; $i < 32; $i++) {
> -        # lfd f$i, 0(r22)
> -        insn32((0x32 << 26 | $i << 21 | 0x16 << 16));
> +        # load a random doubleword value at r0
> +        write_mov_ri128(rand(0xffff), rand(0xffff), rand(0xfffff), rand(0xfffff));
> +        # load the 128-bit data in a vector register
> +        insn32((0x39 << 26) | ($i << 21) | (0x1 << 16) | 0x12);

I think thats lxsd(ISA 3.0), and that only loads a doubleword and not a
quad word. Can't we use "lxv" (ISA 2.03) or "mtvsrdd" (ISA 3.0)

I would suggest lxv, as it will enable us to test older machines.

Regards
Nikunj
