Received: from eggs.gnu.org ([2001:4830:134:3::10]:34276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f97TM-0002rR-Qj
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 07:11:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f97TL-0000qZ-NM
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 07:11:28 -0400
Date: Thu, 19 Apr 2018 12:11:08 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180419111108.GM10259@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <CAOuPqTF3nG157ShF-hW+poXbr25zODOz8pj+o9XdY=ZgU8qpFQ@mail.gmail.com>
	<CAFEAcA9d=oEKfnW0Jr2vrSD8mu0xPbUYk6PAk7dxUqXjJUTooQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9d=oEKfnW0Jr2vrSD8mu0xPbUYk6PAk7dxUqXjJUTooQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [Qemu-arm] getdents patch for 64-bit app on 32-bit
 host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Henry Wertz <hwertz10@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, Apr 19, 2018 at 12:00:00PM +0100, Peter Maydell wrote:
> On 17 April 2018 at 22:53, Henry Wertz <hwertz10@gmail.com> wrote:
> > Peter Maydell has raised a concern about possible buffer overflows in this
> > code (which was meant to handle 32-bit app on 64-bit system, not 64-bit on
> > 32-bit).  I must admit I haven't gone through the dirent-copying code with a
> > fine-toothed comb... it appeared to work for my use case.  That said, the
> > code seems to be careful about using offsetof() rather than making any
> > assumptions.  In addition, the dirent-copying code appears to have an assert
> > that would crash qemu if it was going to write past the end of the dirent
> > buffer -- always nice to have plenty of sanity checks!
> 
> If you build the attached test program for x86-64 (which is a
> minor tweak on the test program in the Linux getdents manpage):
>  gcc -g -Wall -o /tmp/getdents getdents.c -static
> 
> and then on a 32-bit Arm host take a qemu-x86_64 with your patch
> applied, and a test directory like this:
> 
> $ ls /tmp/testdir/
> abcd  abcde
> 
> and run it, QEMU will abort on the assert that we don't run off
> the end of the buffer:
> 
> $ ./build/all-a32/x86_64-linux-user/qemu-x86_64 ~/getdents /tmp/testdir
> linux_dirent struct size 24 bytes
> buffer space 32 bytes
> qemu-x86_64: /home/peter.maydell/qemu/linux-user/syscall.c:10197:
> do_syscall: Assertion `count1 + treclen <= count' failed.
> 
> This is because the guest linux_dirent is bigger than the host
> linux_dirent, and therefore just because the host syscall
> successfully fit the record into the buffer doesn't mean we
> can fit the guest record into the buffer.
> 
> I don't see any way to fix this, because the records are variable size.

If we can't even get something common like dirents working with 64-bit
guest on 32-bit host, should we refuse to even build 64-bit linux-user
emulation on a 32-bit host ?  There must be many other similar cases
where the 64-bit guest syscall is going have insufficient space in the
host 32-bit syscall structs.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
