Received: from eggs.gnu.org ([2001:4830:134:3::10]:38655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1ciDwP-0004si-Ix
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 00:33:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1ciDwM-0002lv-F9
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 00:33:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58658)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1ciDwM-0002lk-5a
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 00:33:42 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1R5SVx3036910
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 00:33:40 -0500
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28u6xn6aw2-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 00:33:40 -0500
Received: from localhost
	by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Mon, 27 Feb 2017 11:03:37 +0530
Received: from d28relay09.in.ibm.com (d28relay09.in.ibm.com [9.184.220.160])
	by d28dlp02.in.ibm.com (Postfix) with ESMTP id 7B0523940033
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 11:03:27 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay09.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v1R5XRqJ10748150
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 11:03:27 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
	by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v1R5XQMC013867
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 11:03:27 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <CAFEAcA8X873FLQxF_n_KZ-jc0hrKcqAj_tjNm6SO0hpPxbF75w@mail.gmail.com>
References: <1486976352-549-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1486976352-549-2-git-send-email-nikunj@linux.vnet.ibm.com>
	<CAFEAcA8X873FLQxF_n_KZ-jc0hrKcqAj_tjNm6SO0hpPxbF75w@mail.gmail.com>
Date: Mon, 27 Feb 2017 11:03:19 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87d1e4p59c.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH 2/2] risu_ppc64le: distinguish real illegal
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, "bharata@linux.vnet.ibm.com" <bharata@linux.vnet.ibm.com>

Peter Maydell <peter.maydell@linaro.org> writes:

> On 13 February 2017 at 08:59, Nikunj A Dadhania
> <nikunj@linux.vnet.ibm.com> wrote:
>> While executing qemu_ppc64le, found an issue that the real illegal
>> instructions are handled as risu_op which results in wrong info at the
>> master end. Even the master needs to distinguish real illegal
>> instructions versus risu_op.
>>
>> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
>
> No, this is deliberate. Otherwise you can't test illegal
> instructions. What should happen is that both master and
> apprentice ends end up in the default case, which does
> a register info compare and continues having stepped the
> PC past the illegal insn.

One of the issue that I had was some of the instruction are implemented
in the master and not in apprentice. I think we could then disable them
in the ppc64.risu. And enable them only when we have that implemented it
in qemu tcg.

> (If only one end thinks the insn is illegal then there will
> be a register mismatch on the PC.)

Yeah, the issue here was it does not come out obviously that there was a
real illegal instruction. Maybe a error print at both the ends would
help in debugging.

Regards
Nikunj
