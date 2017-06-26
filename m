Received: from eggs.gnu.org ([2001:4830:134:3::10]:44147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dPTTC-0006uP-12
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 08:50:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dPTTB-0007G8-7h
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 08:50:22 -0400
Date: Mon, 26 Jun 2017 14:50:09 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170626125009.GD4348@noname.redhat.com>
References: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
	<CAFEAcA9dam54FXEK+7RjnxfO=zBuTat7sMe8yUgZD3AEbAtigg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9dam54FXEK+7RjnxfO=zBuTat7sMe8yUgZD3AEbAtigg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/61] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>

Am 26.06.2017 um 12:23 hat Peter Maydell geschrieben:
> On 23 June 2017 at 17:20, Kevin Wolf <kwolf@redhat.com> wrote:
> > The following changes since commit 4c8c1cc544dbd5e2564868e61c5037258e393832:
> >
> >   Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.10-pull-request' into staging (2017-06-22 19:01:58 +0100)
> >
> > are available in the git repository at:
> >
> >
> >   git://repo.or.cz/qemu/kevin.git tags/for-upstream
> >
> > for you to fetch changes up to 1512008812410ca4054506a7c44343088abdd977:
> >
> >   Merge remote-tracking branch 'mreitz/tags/pull-block-2017-06-23' into queue-block (2017-06-23 14:09:12 +0200)
> >
> > ----------------------------------------------------------------
> >
> > Block layer patches
> >
> 
> This fails 'make check' on ppc64be Linux, x86-64 FreeBSD, aarch64 Linux:
> 
> TEST: tests/virtio-scsi-test... (pid=63911)
>   /i386/virtio/scsi/pci/nop:                                           OK
>   /i386/virtio/scsi/pci/hotplug:                                       OK
>   /i386/virtio/scsi/pci/scsi-disk/unaligned-write-same:                **
> ERROR:/home/pm215/qemu/tests/virtio-scsi-test.c:243:test_unaligned_write_same:
> assertion failed (0 == vi
> rtio_scsi_do_command(vs, write_same_cdb_2, NULL, 0, buf2, 512, NULL)):
> (0x00000000 == 0x000000ff)
> FAIL
> GTester: last random seed: R02Sb24e7d8beec7f0a53a97a610aa09a2b0
> (pid=63934)
> FAIL: tests/virtio-scsi-test

Stefan, this seems to be caused by your patch "virtio-pci: use ioeventfd
even when KVM is disabled". I can reproduce it on x86_64 under valgrind.

QTEST_QEMU_BINARY="valgrind x86_64-softmmu/qemu-system-x86_64" \
tests/virtio-scsi-test -p /x86_64/virtio/scsi/pci/scsi-disk/unaligned-write-same

I'll drop the patch from my queue for a v2 pull request.

Kevin
