Received: from eggs.gnu.org ([2001:4830:134:3::10]:57218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eFO02-0004Jp-SV
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 12:30:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eFO02-0006zQ-21
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 12:30:50 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:46642)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eFO01-0006yK-RJ
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 12:30:49 -0500
Received: by mail-wr0-x244.google.com with SMTP id y42so23551272wrd.3
	for <qemu-devel@nongnu.org>; Thu, 16 Nov 2017 09:30:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171116151031.GV2787@redhat.com>
References: <20171115115246.GA1955@redhat.com>
	<20171116144746.GE29106@stefanha-x1.localdomain>
	<20171116151031.GV2787@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 16 Nov 2017 17:30:48 +0000
Message-ID: <CAJSP0QWop2Xvjp5bObJ0yRoJ=W-6cH84fGHXj5b93Qb6TxCxDA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Effect of qemu-img convert -m and -W options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: libguestfs@redhat.com, Peter Lieven <pl@kamp.de>, qemu-devel <qemu-devel@nongnu.org>

On Thu, Nov 16, 2017 at 3:10 PM, Richard W.M. Jones <rjones@redhat.com> wrote:
> On Thu, Nov 16, 2017 at 02:47:46PM +0000, Stefan Hajnoczi wrote:
>> The threads you observed are the thread pool that performs
>> preadv(2)/pwritev(2) syscalls.  The Linux AIO API could be used instead
>> and does not use threads for read and write operations.
>
> I guess if I used AIO then I wouldn't get any parallelism at all since
> Linux doesn't block on local file access (at least, it never used to)?

Even assuming there is enough free page cache, file systems can
definitely block for metadata updates (e.g. space allocation as a file
grows).  I don't think it's possible to assume that pwritev(2) doesn't
block.

>> Are the source and target files on the same file system and host block
>> device?  The benefit of using multiple coroutines depends on the
>> performance characteristics of the source and target files.
>
> Both local filesystems, but on different SATA devices.

Okay.  I'm curious what the strace -f output looks like (only the
preadv(2)/pwritev(2) syscalls are interesting at the moment).

Stefan
