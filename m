Received: from eggs.gnu.org ([2001:4830:134:3::10]:51813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1cZ4ec-00056E-PJ
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 18:49:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1cZ4eZ-0004M8-Lx
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 18:49:34 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33800
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sam.bobroff@au1.ibm.com>)
	id 1cZ4eZ-0004Lt-GF
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 18:49:31 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v11NmXsx128265
	for <qemu-devel@nongnu.org>; Wed, 1 Feb 2017 18:49:30 -0500
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28bmw9shpg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 01 Feb 2017 18:49:30 -0500
Received: from localhost
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sam.bobroff@au1.ibm.com>;
	Thu, 2 Feb 2017 09:49:26 +1000
Date: Thu, 2 Feb 2017 10:48:23 +1100
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
References: <587D4171.6@linux.intel.com> <587D4329.5020702@linux.intel.com>
	<20170130235210.GA4681@tungsten.ozlabs.ibm.com>
	<CAFEAcA-FPmqw0pt7kT=eHR_osfFbZNhrDdGAb87VxUWD_XXSNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAFEAcA-FPmqw0pt7kT=eHR_osfFbZNhrDdGAb87VxUWD_XXSNw@mail.gmail.com>
Message-Id: <20170201234823.GA4326@tungsten.ozlabs.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] qemu-pcc 2.8.0 linux-user segfaults
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?iso-8859-1?Q?An=EDbal_Lim=F3n?= <anibal.limon@linux.intel.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>

On Wed, Feb 01, 2017 at 03:25:05PM +0000, Peter Maydell wrote:
> On 30 January 2017 at 23:52, Sam Bobroff <sam.bobroff@au1.ibm.com> wrot=
e:
> >> On 01/16/2017 03:56 PM, An=EDbal Lim=F3n wrote:
> >> > I'm trying to upgrade qemu to 2.8.0 in Openembedded-core and segfa=
ults
> >> > in qemu-ppc when is executing:
>=20
> > I've recently encountered a similar problem and I've posted a fix. If
> > you'd like to try it, it's here:
> >
> > https://lists.gnu.org/archive/html/qemu-ppc/2017-01/msg00413.html
>=20
> Hmm, I missed that patch (it doesn't seem to have made it
> to the qemu-devel list), but it isn't correct, I'm afraid.

Oh, sorry I think I forgot to cross post it!

Thanks for taking a look at it :-)

> In the patch for handling TARGET_USER_ESIGRETURN you must
> not change the nip register, because we will have just
> set it from the signal context that the guest provided
> to the sigreturn syscall. (The patch as it stands will
> cause us to reexecute an instruction after return from
> a signal handler, which isn't going to go very well).

Ah, thank you. I think I understand what you mean: do_syscall() and the
TARGET_QEMU_ESIGRETURN case must both see the same value for env->nip().

I tried a test program that went through that case (which I obviously
should have done before) and you're definitely right, because userspace
gets stuck looping on the system call. Removing the NIP adjustment from
the case seems to fix it. Is that what you mean? (I'll post a v2 with
that change if so.)

It seems that the similar adjustment for the TARGET_ERESTARTSYS should
stay, as removing it causes signal restart to fail (userspace sees
-EINTR even when they've specified a signal handler with SA_RESTART).

> David, can you drop that patch from your ppc queue, please?
>
> (I think the change is good otherwise but I couldn't
> seem to find the bit in the ppc linux kernel that
> corresponds to moving the NIP value around.)

> thanks
> -- PMM

Thanks again for the help!
Sam.
