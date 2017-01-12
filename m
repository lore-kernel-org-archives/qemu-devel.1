Received: from eggs.gnu.org ([2001:4830:134:3::10]:52983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cRici-0007V8-PZ
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:53:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cRice-0005uP-5A
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:53:12 -0500
Received: from mail-io0-x235.google.com ([2607:f8b0:4001:c06::235]:33885)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cRicd-0005u1-WA
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:53:08 -0500
Received: by mail-io0-x235.google.com with SMTP id l66so23045467ioi.1
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 08:53:07 -0800 (PST)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 12 Jan 2017 16:53:05 +0000
Message-ID: <CAJSP0QWu33aWRHnodcGy+OVQbMUoy4YG2gzNe4AaeCVns4NdMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] Volunteers for dmg block driver task?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>

I've added a task to the block todo list.  If anyone is interested in
tackling it please reply to this email.

The task is smaller than a Google Summer of Code project but larger
than a BiteSizedTasks item.  I guess it would take someone new to QEMU
and the dmg image file format about 2-3 weeks to complete it.

---

Summary: Refactor the block/dmg.c driver to read ranges within a chunk
instead of reading an entire chunk at a time.

Contact: Stefan Hajnoczi <stefanha@redhat.com> for questions

The dmg file format is Apple's disk image format. It is sometimes used
in place of an ISO file and also for software distribution. The file
format is not officially documented but information on how to
interpret it is available on Wikipedia and here.

QEMU's block/dmg.c block driver performs I/O in "chunk" units. Chunk
information (size, offset, etc) is read from file's metadata when it
is opened. Chunk size is variable so the block driver takes the
maximum chunk size as its I/O buffer size. That way the driver can
guarantee all data read from disk will fit into the buffer.

The problem with this approach is that chunks in some files are large.
QEMU must prevent corrupt or malicious image files from causing it to
allocate huge amounts of memory. This is important to prevent
denial-of-service in cases where untrusted files are being accessed by
the user.

Files seen in the wild have chunk sizes around ~250 MB. This exceeds
the hardcoded 64 MB limit and produces the following error message:

qemu-img: sector count 511952 for chunk 0 is larger than max (131072)

The task is to refactor the block driver to avoid reading an entire
chunk into a buffer for each read request. Instead it should seek to
the range within the chunk and only read bytes that are actually being
requested.

This is complicated by the fact that chunks may be deflate or bz2
compressed so special logic is needed to seek through compressed data.
Study the zlib and libbz2 APIs to find out how to achieve this.
