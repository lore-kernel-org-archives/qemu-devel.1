Received: from eggs.gnu.org ([2001:4830:134:3::10]:46915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cwnJB-0000u5-8I
	for qemu-devel@nongnu.org; Sat, 08 Apr 2017 06:09:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cwnJA-0007dm-F4
	for qemu-devel@nongnu.org; Sat, 08 Apr 2017 06:09:29 -0400
References: <1491384478-12325-1-git-send-email-lidongchen@tencent.com>
	<20170406140255.GA31259@stefanha-x1.localdomain>
	<CAOGPPbfpN5QVxzvAkRv4MY7nE0YBxU0-UeMuJpVCe-wBB_9p8A@mail.gmail.com>
	<20170407113312.GN13602@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3565ef7f-97dd-4d7b-fbed-590e032819bf@redhat.com>
Date: Sat, 8 Apr 2017 18:09:16 +0800
MIME-Version: 1.0
In-Reply-To: <20170407113312.GN13602@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] migration/block:limit the time used for
 block migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, 858585 jemmy <jemmy858585@gmail.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, quintela@redhat.com, dgilbert@redhat.com, qemu-block@nongnu.org, Lidong Chen <lidongchen@tencent.com>, kwolf@redhat.com



On 07/04/2017 19:33, Stefan Hajnoczi wrote:
> The migration thread is holding the QEMU global mutex, the AioContext,
> and the qcow2 s->lock while the L2 table is read from disk.
>=20
> The QEMU global mutex is needed for block layer operations that touch
> the global drives list.  bdrv_is_allocated() can be called without the
> global mutex.

Hi Stefan,

only virtio-blk and virtio-scsi take the AioContext lock (because they
support dataplane).  For block migration to work with devices such as
IDE, it needs to take the iothread lock too.  I think there's a comment
about this in migration/block.c.

However, this will hopefully be fixed in 2.10 by making the block layer
thread safe.

Paolo
