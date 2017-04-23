Received: from eggs.gnu.org ([2001:4830:134:3::10]:56425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d2Ec4-0004kh-2H
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 06:19:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d2Ec2-00074g-U8
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 06:19:28 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:37706)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d2Ec2-00074P-N1
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 06:19:26 -0400
Received: by mail-wm0-x234.google.com with SMTP id m123so46219893wma.0
	for <qemu-devel@nongnu.org>; Sun, 23 Apr 2017 03:19:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <e1b08f20-77e6-83c8-85e6-b73c645c44c1@gmx.com>
References: <e1b08f20-77e6-83c8-85e6-b73c645c44c1@gmx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 23 Apr 2017 11:19:04 +0100
Message-ID: <CAFEAcA-ycgLSU9aX1Ywd1Pky2bquqefJbsRpNvo4DuaXOyL3SQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] NetBSD maintenance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 23 April 2017 at 00:27, Kamil Rytarowski <n54@gmx.com> wrote:
> I noted a call for NetBSD maintainers in the 2.9.0 release notes.
>
> I'm willing to attach a NetBSD machine to CI cluster and volunteer basic
> maintenance. I'm mostly interested in NetBSD as host & as guest as this
> is my daily and work driver on my desktop and development machines.

Thanks for the offer of assistance. At the moment I have a
NetBSD VM set up so I can run the usual make/make check
tests that I run on other hosts. So the most immediate
requirement is for somebody to investigate and send patches
for the bugs which mean it doesn't build at all.
My initial investigation suggests that at least one bug is that
ivshmem-server uses shm_open but doesn't link -lrt, so
some fixes to the build machinery are needed.

> As of today NetBSD patches for qemu are maintained in pkgsrc. There are
> also at least DragonFly and SunOS (SmartOS) diffs available.
> https://github.com/NetBSD/pkgsrc/tree/trunk/emulators/qemu/patches

Accumulating patches downstream like this is I think
a big part of the problem -- if QEMU has bugs on NetBSD
then we need NetBSD users to report the problems and
provide us with fixes. Otherwise you get what's happened:
we try to build NetBSD with upstream QEMU, find it doesn't
even compile, and conclude that obviously nobody's using
QEMU on NetBSD because nobody's complained that it doesn't
work, so we might as well drop it.

(I recall hitting that "ssp/unistd.h defines macros for read, etc"
bug a few years back when I last tried NetBSD as a host;
it looks like it's fixed in the headers on newer NetBSD, though,
so maybe those patches could just be dropped if we're lucky.)

> Qemu is one of the core tools in NetBSD development and it's used in our
> release engineering infrastructure:
>
> http://releng.netbsd.org/test-results.html

Do you use/test the bsd-user code, or just system emulation?
I know the FreeBSD folks have extensive patches to the usermode
code, but does it work OK on NetBSD hosts, or is it just unused?

> I will start with upstreaming local diffs and move on to running tests.

Thanks, I think that is the right place to start.

-- PMM
