Received: from eggs.gnu.org ([2001:4830:134:3::10]:45311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1ceC0r-0005p9-Vq
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 21:41:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1ceC0o-0002LO-SM
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 21:41:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53645)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1ceC0o-0002Ks-IT
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 21:41:38 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1G2d6gt026042
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 21:41:36 -0500
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28mxq3sw9h-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 21:41:35 -0500
Received: from localhost
	by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Thu, 16 Feb 2017 08:11:33 +0530
Date: Thu, 16 Feb 2017 08:11:26 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Reply-To: bharata@linux.vnet.ibm.com
References: <1487140636-19955-1-git-send-email-bharata@linux.vnet.ibm.com>
	<44595100-389c-18ee-6355-2d1355577187@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44595100-389c-18ee-6355-2d1355577187@twiddle.net>
Message-Id: <20170216024126.GA17196@in.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] target-ppc: Add quad precision muladd
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, nikunj@linux.vnet.ibm.com, david@gibson.dropbear.id.au

On Thu, Feb 16, 2017 at 09:13:31AM +1100, Richard Henderson wrote:
> On 02/15/2017 05:37 PM, Bharata B Rao wrote:
> > + *
> > + * TODO: When float128_muladd() becomes available, switch this
> > + * implementation to use that instead of separate float128_mul()
> > + * followed by float128_add().
> 
> Let's just do that, rather than add something that can't pass tests.
> 
> You should be able to copy float64_muladd and, for the most part, s/128/256/
> and s/64/128/.  Other of the magic numbers, like the implicit bit and the
> exponent bias, you get from float128_mul.

I started like that but got lost somewhere down that path...

It needs at least the following new functions to be implemented:

propagateFloat128MulAddNaN
shortShift256Left
shift256RightJamming
add256
sub256

It all looked doable, but the magic numbers used around the code that
does eventual multiplication looked difficult to understand and I couldn't
deduce that from float128_mul. For some reason float128_mul implements
multipliction via multiplication and addition (mul128To256 & add128). There
is no equivalent to this in float64_muladd.

Let me make another attempt at this.

Regards,
Bharata.
