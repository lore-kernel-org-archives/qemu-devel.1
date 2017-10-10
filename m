Received: from eggs.gnu.org ([2001:4830:134:3::10]:57005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1e1yZq-0000Uf-1l
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:44:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1e1yZm-0005kN-4C
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:44:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44760
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1e1yZl-0005jz-Uq
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:44:18 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9AHhjOE063678
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 13:44:07 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dh0dr9d13-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 13:44:06 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 10 Oct 2017 13:44:06 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <96a6584b-ee29-13a2-622a-b07788ffcf79@linaro.org>
References: <CAFEAcA-KNF0Q2HisqN8s0zhm1dyPxFrKri6tYNpUai_=OnAppw@mail.gmail.com>
	<96a6584b-ee29-13a2-622a-b07788ffcf79@linaro.org>
Date: Tue, 10 Oct 2017 12:43:59 -0500
Message-Id: <150765743910.11829.11218016346709035274@sif>
Subject: Re: [Qemu-devel] updating to a u-boot without the case-sensitive
 filename clash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@suse.de>

Quoting Richard Henderson (2017-10-10 11:32:22)
> On 10/10/2017 07:22 AM, Peter Maydell wrote:
> > I can see a couple of options:
> >  (1) wait for next u-boot release (scheduled for Nov 13, 2017),
> >      and move to that
> >      [downsides: would be in the middle of QEMU's own release cycle,
> >       pretty late to fix any problems with the new version;
> >       rather a big change to put into stable]
> >  (2) move to u-boot current head-of-unstable
> >      [downsides: would mean running some random git commit version,
> >       also not really very suitable for stable]
> =

> It's always difficult to sync the release cycles of disjoint projects.
> =

> You had nothing particularly good to say about using a non-released u-boo=
t, so
> really you have two options:
> =

>   (a) Update u-boot for 2.12 and not 2.11,
>   (b) Track u-boot during its release process, noticing and reporting pro=
blems,
>       and updating to the final release when it appears.  If you go this =
route,
>       you may well have to slip our release if theirs slips.
> =

> The second option is not particularly appealing.
> =

> Is there another possibility in which we split the packaging to cope with=
 the
> current u-boot?  Normally no one builds u-boot; we simply package it for
> licensing.  If the packaging were in two parts, one could unpack the firs=
t part
> only and not encounter the problem.

Would something like this be sufficient?

diff --git a/scripts/make-release b/scripts/make-release
index fa6323fda8..96c21e7a74 100755
--- a/scripts/make-release
+++ b/scripts/make-release
@@ -20,6 +20,7 @@ git checkout "v${version}"
 git submodule update --init
 (cd roms/seabios && git describe --tags --long --dirty > .version)
 rm -rf .git roms/*/.git dtc/.git pixman/.git
+tar cfj roms/u-boot.tar.bz2 roms/u-boot && rm -rf roms/u-boot
 popd
 tar cfj ${destination}.tar.bz2 ${destination}
 rm -rf ${destination}

And then we can optionally just revert it once we move to a fixed
u-boot? Although we'd need to take care in that case to make sure
we don't use the wrong version of make-release for a particular
point release.

> =

> =

> r~
>=20
