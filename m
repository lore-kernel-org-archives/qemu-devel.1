Received: from eggs.gnu.org ([209.51.188.92]:56460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1hMfmh-0004x3-3i
	for qemu-devel@nongnu.org; Fri, 03 May 2019 17:32:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1hMfmf-0007jS-Oo
	for qemu-devel@nongnu.org; Fri, 03 May 2019 17:31:59 -0400
MIME-Version: 1.0
References: <68cc5bbc-ed6f-e001-e376-ccd986683b88@redhat.com>
	<f1dfe2c3-2d61-e477-ac3d-37ad26d9236d@redhat.com>
	<61685a48-b84e-c379-7193-f456e82635ba@redhat.com>
	<67a38513-89af-7f54-2fc8-05b5777983ca@redhat.com>
In-Reply-To: <67a38513-89af-7f54-2fc8-05b5777983ca@redhat.com>
From: Nir Soffer <nirsof@gmail.com>
Date: Sat, 4 May 2019 00:31:38 +0300
Message-ID: <CAMr-obv28mp9bABmm906tnwfkBp93ATeEsuaUt-o=Ti75N_1DQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Failing QEMU iotest 175
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Fri, May 3, 2019, 23:21 Eric Blake <eblake@redhat.com> wrote:

> On 5/2/19 11:37 PM, Thomas Huth wrote:
> > On 02/05/2019 23.56, Eric Blake wrote:
> >> On 4/28/19 10:18 AM, Thomas Huth wrote:
> >>> QEMU iotest 175 is failing for me when I run it with -raw:
> >>>
> >>
> >>>  == creating image with default preallocation ==
> >>>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
> >>> -size=1048576, blocks=0
> >>> +size=1048576, blocks=2
> >>
> >> What filesystem?
> >
> > ext4
> >
>
> Hmm, it's passing for me on ext4, but that probably means we have
> different configuration parameters. I'm not sure how to easily show what
> parameters a particular ext4 partition uses to compare the differences
> between your setup and mine (mine is tuned to whatever defaults Fedora's
> installer chose on my behalf), so maybe someone else can chime in.
>
> >> It should be fairly obvious that 'stat -c blocks=%b' is
> >> file-system dependent (some allocate slightly more or less space, based
> >> on granularities and on predictions of future use), so we may need to
> >> update the test to apply a filter or otherwise allow a bit of fuzz in
> >> the answer. But 0/2 is definitely different than...
> >>>
> >>>  == creating image with preallocation off ==
> >>>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
> preallocation=off
> >>> -size=1048576, blocks=0
> >>> +size=1048576, blocks=2
> >>>
> >>>  == creating image with preallocation full ==
> >>>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
> preallocation=full
> >>> -size=1048576, blocks=2048
> >>> +size=1048576, blocks=2050
> >>
> >> 2048/2050, so we DO have some indication of whether the file is sparse
> >> or fully allocated.
> >
> > Maybe we could check that the value after "blocks=" is a single digit in
> > the first case, and matches "blocks=20.." in the second case?
>
> I wonder if 'qemu-img map --output=json $TEST_IMG' might be any more
> reliable (at least for ignoring any extra block allocations associated
> with the file, if it is some journaling option or xattr or other reason
> why your files seem to occupy more disk sectors than just the size of
> the file would imply).
>

I think it should work better and is more correct, testing actual sparsness
instead of underlying file system implementation.

I can send a fix next week.

Nir


> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>
>
