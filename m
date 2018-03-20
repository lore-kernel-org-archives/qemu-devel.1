Received: from eggs.gnu.org ([2001:4830:134:3::10]:47562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eyKyS-0007Lb-K5
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:23:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eyKyP-0005oE-F0
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:23:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38938 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eyKyP-0005nr-8p
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:22:57 -0400
Date: Tue, 20 Mar 2018 19:22:40 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180320191945-mutt-send-email-mst@kernel.org>
References: <1521515720-612046-1-git-send-email-mst@redhat.com>
	<CAFEAcA_EbFC2qJvMGKj1gzTBnSgytLaJJfhDcn0FjEsjnvz1Sg@mail.gmail.com>
	<20180320170328-mutt-send-email-mst@kernel.org>
	<CAFEAcA8Dxs9u1KyzGmND9H7mPi9+KrBdKzkxTB4+hQYN54JPmg@mail.gmail.com>
	<20180320174957-mutt-send-email-mst@kernel.org>
	<CAFEAcA-FzKzh8HVC4oX8=g_gS5WDaf51_nBmNgOqX7HDNk3DqA@mail.gmail.com>
	<20180320175954-mutt-send-email-mst@kernel.org>
	<CAFEAcA9tcGkpmENksin1Pm6+gehU9BYevGZOb9Xp=spGFtgwRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9tcGkpmENksin1Pm6+gehU9BYevGZOb9Xp=spGFtgwRQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL v2 00/50] virtio, vhost, pci, pc: features,
 cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Tue, Mar 20, 2018 at 05:18:22PM +0000, Peter Maydell wrote:
> On 20 March 2018 at 16:02, Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Tue, Mar 20, 2018 at 03:54:47PM +0000, Peter Maydell wrote:
> >> > Let's update headers for arm and mips then?
> >>
> >> Shouldn't that happen automatically?
> 
> > And apparently it does for arm:
> > linux-headers/asm-arm/unistd-common.h has __NR_userfaultfd.
> >
> > What's the story for arm64 and mips?
> 
> arm64 uses the generic syscall numbering (as should pretty
> much any new architecture port for Linux). That means its
> unistd.h just #includes the asm-generic one. QEMU's script
> update-linux-headers.sh isn't syncing asm-generic/unistd.h,
> though. That means that the #include in linux-headers/asm-arm64/unistd.h
> picks up whatever the host system's asm-generic/unistd.h
> is. In this instance the build system had a version of that
> header that predated __NR_userfaultfd.
> 
> For mips, update-linux-headers.sh has it on a blacklist:
>     # Blacklist architectures which have KVM headers but are actually dead
>     if [ "$arch" = "ia64" -o "$arch" = "mips" ]; then
>         continue
>     fi
> 
> and has done since 1842bdfdbac2ec46 when we started syncing
> unistd.h. That means that any updates to linux-headers/mips
> would need to be done manually, but in fact we have not done
> any of those, so we still have 2015's headers, which predate
> __NR_userfaultfd.
> 
> So we should:
>  (1) make update-headers.sh sync asm-generic/unistd.h
>   -- looks like this will also require us to sync
>      bitsperlong.h for all archs and the asm-generic copy
> 
>  (2) reinvestigate whatever the "extra header inclusion"
>      issues are with mips so we can have the update script
>      properly sync the mips headers too
> 
> Incidentally we can drop the "blacklist ia64" code, because
> kernels these days don't have KVM headers for ia64 and
> so the generic "skip archs with no KVM support" code will
> make us skip ia64.
> PS: migration/postcopy-ram.c isn't KVM-specific, so it's
> a little odd of it to be relying on header files that we
> only copy for KVM-supporting host architectures. That
> means you need to cope with __NR_userfaultfd not being
> defined anyway, in case you're on a host which doesn't
> support KVM and we've ended up falling back to the system
> includes.
> 
> thanks
> -- PMM

I sent some patches to try to clean all that up.  I kept ia64
blacklisted from kvm for now as the patchset is already large,
but I limited the effect to kvm only. Would be
easy to drop that test as a patch on top.

-- 
MST
