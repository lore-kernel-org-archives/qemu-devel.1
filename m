Received: from eggs.gnu.org ([2001:4830:134:3::10]:50981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <deepa.srinivasan@oracle.com>) id 1eJOP0-0004It-Vm
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 13:45:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <deepa.srinivasan@oracle.com>) id 1eJOP0-0003Dq-5Y
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 13:45:11 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Deepa Srinivasan <deepa.srinivasan@oracle.com>
In-Reply-To: <20171123172927.GD4375@localhost.localdomain>
Date: Mon, 27 Nov 2017 10:45:22 -0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <DEF51D90-1B45-4DDF-B059-4BF4785BE556@oracle.com>
References: <c4532ef7-6e05-d14a-21de-1b8381aa2112@redhat.com>
	<1511456107-7081-1-git-send-email-deepa.srinivasan@oracle.com>
	<3DFDA265-8685-4601-B981-1BB0007C44B4@oracle.com>
	<20171123172927.GD4375@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH] block: Fix qemu crash when using scsi-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: mark.kanda@oracle.com, qemu-block@nongnu.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com


> On Nov 23, 2017, at 9:29 AM, Kevin Wolf <kwolf@redhat.com> wrote:
>=20
> Am 23.11.2017 um 18:05 hat Deepa Srinivasan geschrieben:
>> blk_aio_prwv() now takes a void pointer and the coroutine functions
>> have been modified to cast it into QEMUIOVector if needed. It does =
not
>> use an union in BlkRwCo since this leads to code - blk_aio_prwv()
>> would have to write to the void pointer member, but coroutines would
>> sometimes read the QEMUIOVector member. Paolo also suggested not =
using
>> a union.
>=20
> I don't particularly like void pointers, but I guess it's fair enough.

Agreed, but if a union were to hold QEMUIOVector* and void* in BlkRwCo, =
blk_aio_prwv() would always write to void* but some coroutine functions =
would read from the QEMUIOVector* member. Keeping it as a void pointer =
is a safer option.

>=20
>> Note that a similar issue exists in
>> blk_ioctl()/blk_ioctl_entry()/blk_prw() where blk_prw() always =
creates
>> the QEMUIOVector even if blk_ioctl()/blk_ioctl_entry() does not need =
a
>> QEMUIOVector. This will need to be fixed separately to keep it
>> consistent with the AIO path.
>=20
> I don't think there is an actual problem in the blk_ioctl() path =
because
> the iov on the stack stays valid as long as the coroutine runs. AIO is
> different because it returns before the coroutine has terminated.
>=20

The problem in blk_ioctl() is not a crash, because blk_prwv() waits for =
the coroutine completion, as you say.

The issue is that it unnecessarily creates a QEMUIOVector for the ioctl =
case. I was saying, if this is to be kept consistent with the AIO patch, =
then it could be done in a separate patch.

> Kevin
>=20
