Received: from eggs.gnu.org ([2001:4830:134:3::10]:50594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fIrAC-0006oi-IS
	for qemu-devel@nongnu.org; Wed, 16 May 2018 03:47:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fIrAB-0006ZB-QZ
	for qemu-devel@nongnu.org; Wed, 16 May 2018 03:47:56 -0400
References: <42ec7519-653d-09e2-abc6-78f04733ca47@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d5093823-76d8-6fd7-86f3-249d9d3518ae@redhat.com>
Date: Wed, 16 May 2018 09:47:42 +0200
MIME-Version: 1.0
In-Reply-To: <42ec7519-653d-09e2-abc6-78f04733ca47@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Problem with data miscompare using scsi-hd,
 cache=none and io=threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.ibm.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu-block@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On 15/05/2018 23:25, Daniel Henrique Barboza wrote:
> This is the current status of this investigation. I decided to start a
> discussion here, see if someone can point me something that I overlooke=
d
> or got it wrong, before I started changing the POSIX thread pool
> behavior to see if I can enforce one specific POSIX thread to do a
> read() if we had a write() done in the same fd. Any suggestions?

Copying from the bug:

> Unless we learn something new, my understanding is that we're dealing
> with a host side limitation/bug when calling pwritev() in a different
> thread than a following preadv(), using the same file descriptor
> opened with O_DIRECT and no WCE in the host side, the kernel can't
> grant data coherency, e.g:
>=20
> - thread A executes a pwritev() writing dataA in the disk
>=20
> - thread B executes a preadv() call to read the data, but this
> preadv() call isn't aware of the previous pwritev() call done in
> thread A, thus the guarantee of the preadv() call reading dataA isn't
> assured (as opposed to what is described in man 3 write)
>=20
> - the physical disk, due to the heavy load of the stress test, didn't
> finish writing up dataA. Since the disk itself doesn't have any
> internal cache to rely on, the preadv() call goes in and read an old
> data that differs from dataA.

There is a problem in the reasoning of the third point: if the physical
disk hasn't yet finished writing up dataA, pwritev() shouldn't have
returned.  This could be a bug in the kernel, or even in the disk.  I
suspect the kernel because SCSI passthrough doesn't show the bug; SCSI
passthrough uses ioctl() which completes exactly when the disk tells
QEMU that the command is done---it cannot report completion too early.

(Another small problem in the third point is that the disk actually does
have a cache.  But the cache should be transparent, if it weren't the
bug would be in the disk firmware).

It has to be debugged and fixed in the kernel.  The thread pool is
just... a thread pool, and shouldn't be working around bugs, especially
as serious as these.

A more likely possibility: maybe the disk has 4K sectors and QEMU is
doing read-modify-write cycles to emulate 512 byte sectors?  In this
case, mismatches are not expected, since QEMU serializes RMW cycles, but
at least we would know that the bug would be in QEMU, and where.

Paolo
