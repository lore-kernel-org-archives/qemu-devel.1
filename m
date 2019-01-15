Received: from eggs.gnu.org ([209.51.188.92]:56974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gjOn7-0003j4-3Y
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 08:30:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gjOn6-0003xc-Bk
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 08:30:05 -0500
Date: Tue, 15 Jan 2019 15:29:42 +0200
From: Alberto Garcia <berto@igalia.com>
Message-ID: <20190115132942.b7xgq7dpwpkrmebb@perseus.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] Crash when deleting an iothread that is being used
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Here's how to reproduce the crash:

{ "execute": "qmp_capabilities" }
{ "execute": "blockdev-add", "arguments": {"driver": "null-co", "node-name": "hd0"}}
{ "execute": "object-add", "arguments": {"qom-type": "iothread", "id": "iothread0"}}
{ "execute": "x-blockdev-set-iothread", "arguments": {"node-name": "hd0", "iothread": "iothread0"}}
{ "execute": "object-del", "arguments": {"id": "iothread0"}}
{ "execute": "blockdev-del", "arguments": {"node-name": "hd0"}}

The problem is that bs->aio_context is the one that belonged to the
IOThread and was destroyed by the object-del call. One would need to
do x-blockdev-set-iothread(hd0, null) before deleting the thread.

The IOThread class does not have a can_be_deleted() method to prevent
threads from being deleted. One possible implementation would require
a reference count but that doesn't seem immediately trivial because
users don't use the IOThread itself but its AioContext, and not all
bdrv_set_aio_context() are related to IOThreads.

A quicker fix is of course to prevent the threads from being deleted
at all :-)

Berto
