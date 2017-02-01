Received: from eggs.gnu.org ([2001:4830:134:3::10]:38824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cYshF-0002bd-Bv
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 06:03:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cYshB-0002ig-Iw
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 06:03:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cYshB-0002hh-Ap
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 06:03:25 -0500
Date: Wed, 1 Feb 2017 11:03:20 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170201110320.GD3232@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1485943606-13998-1-git-send-email-lprosek@redhat.com>
	<20170201102013.GC3232@redhat.com>
	<CABdb735fGM9r4tirfOTyK1Jv8oC868nW5rCsNk_X5acoiav1iA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABdb735fGM9r4tirfOTyK1Jv8oC868nW5rCsNk_X5acoiav1iA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] qga: implement guest-file-ioctl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, mdroth@linux.vnet.ibm.com

On Wed, Feb 01, 2017 at 11:50:43AM +0100, Ladi Prosek wrote:
> On Wed, Feb 1, 2017 at 11:20 AM, Daniel P. Berrange <berrange@redhat.com> wrote:
> > On Wed, Feb 01, 2017 at 11:06:46AM +0100, Ladi Prosek wrote:
> >> Analogous to guest-file-read and guest-file-write, this commit adds
> >> support for issuing IOCTLs to files in the guest. With the goal of
> >> abstracting away the differences between Posix ioctl() and Win32
> >> DeviceIoControl() to provide one unified API, the schema distinguishes
> >> between input and output buffer sizes (as required by Win32) and
> >> allows the caller to supply either a 'buffer', pointer to which will
> >> be passed to the Posix ioctl(), or an integer argument, passed to
> >> ioctl() directly.
> >
> > What is the intended usage scenario for this ?
> 
> My specific case is extracting a piece of data from Windows guests.
> Guest driver exposes a file object with a well-known IOCTL code to
> return a data structure from the kernel.

Please provide more information about what you're trying to do.

If we can understand the full details it might suggest a different
approach that exposing a generic ioctl passthrough facility.

> > The size of arguments that need to be provided to ioctl()s vary on
> > the architecture of the guest kernel that's running, which cannot be
> > assumed to be the same as the architecture of the QEMU binary. ie
> > you can be running i686 kernel in an x86_64 QEMU.  So it feels like
> > it is going to be hard for applications to reliably use this feature
> > unless they have more information about the guest OS, that is not
> > currently provided by QEMU guest agent. So it feels like this design
> > is not likely to be satisfactory to me.
> 
> I can turn this around and say that guest-file-read and
> guest-file-write shouldn't exist because applications can't reliably
> know what the format of files on the guest is.

No that's not the same thing at all. From the POV of the QEMU API, the
contents of the files do not matter - it is just a byte stream and the
guest agent API lets you read it in the same way no matter what is in
the files, or what OS is running. There's no need to know anything about
the guest OS in order to successfully read/write the entire file.

The ioctl design you've proposed here is different because you need to
know precise operating system details before you can use the API. I
think that's really flawed.

It would be possible to design a ioctl API that is more usable if you
didn't try to do generic passthrough of arbitrary ioctl commands. Instead
provide a QAPI schema that uses a union to provide strongly typed arguments
for the ioctl commands you care about using. Or completely separate QAPI
commands instead of multiplexing everything into an ioctl command.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
