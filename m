Received: from eggs.gnu.org ([2001:4830:134:3::10]:54467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dV5S3-0008KY-5h
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 20:24:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dV5S0-0000jD-23
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 20:24:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:59000)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1dV5Rz-0000j1-Su
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 20:24:19 -0400
Date: Tue, 11 Jul 2017 17:24:08 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <CAFEAcA-vuPxc0GZc4Her1Trtak-RL9wcMR1L9SGRhzGg3wUGEA@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1707111718300.26679@sstabellini-ThinkPad-X260>
References: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
	<1499238885-26161-23-git-send-email-pbonzini@redhat.com>
	<CAFEAcA-B+aChqZBSnGws7RXheEyg+cutaqvXP8qVgNoUgzQAJA@mail.gmail.com>
	<4f304a14-572d-2835-cb0e-9d93c1c6dece@redhat.com>
	<CAFEAcA-vuPxc0GZc4Her1Trtak-RL9wcMR1L9SGRhzGg3wUGEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PULL 22/42] configure: factor out list of
 supported Xen/KVM/HAX targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, Anthony PERARD <anthony.perard@citrix.com>

On Mon, 10 Jul 2017, Peter Maydell wrote:
> On 10 July 2017 at 17:14, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > On 10/07/2017 17:49, Peter Maydell wrote:
> >> On 5 July 2017 at 08:14, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >>> This will be useful when the functions are called, early in the configure
> >>> process, to filter out targets that do not support hardware acceleration.
> >>>
> >>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> >>
> >>> +supported_xen_target() {
> >>> +    test "$xen" = "yes" || return 1
> >>> +    glob "$1" "*-softmmu" || return 1
> >>> +    case "${1%-softmmu}:$cpu" in
> >>> +        arm:arm | aarch64:aarch64 | \
> >>> +        i386:i386 | i386:x86_64 | x86_64:i386 | x86_64:x86_64)
> >>> +            return 0
> >>> +        ;;
> >>
> >> This says that arm-on-arm and aarch64-on-aarch64 are supported
> >> Xen targets...
> >
> > Hmm, this comes from my old patches.  IIRC the reason for the change,
> > when it wasn't a change (many conflicts ago) was that Xen folks were
> > using --disable-tcg because their device model for Xen PV on ARM was
> > actually an x86_64 QEMU.
> >
> > Stefano and Anthony, is this still true?  If so, would it make sense to
> > add the Xen PV machine type to qemu-system-arm---that is, is it
> > something you can whip up easily, or should I just remove that line?
> 
> I think you should just fix configure for the moment, because
> this patch wasn't supposed to change anything about what we
> build (AIUI). We can think about changing the Xen PV on ARM
> build setup as a separate thing if we want to, I suspect it
> is more invasive than a couple of lines changing in configure.

Let's leave the current build issue aside for a moment, given that it
seems to be solved now.

Today, we build qemu-system-i386 for Xen on ARM just for the xenpv
machine. Using qemu-system-i386 causes all sort of confusion in our
users and even distro packagers. Using qemu-system-aarch64 on ARM64
would be better. But the best solution I think it would be to build a
cpu-less arch-neutral xenpv machine. Something like qemu-system-null or
qemu-system-xen.
