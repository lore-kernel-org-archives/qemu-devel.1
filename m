Received: from eggs.gnu.org ([2001:4830:134:3::10]:55316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dn4YC-00076y-I0
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 11:05:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dn4Y8-0005z2-A1
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 11:05:04 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:43130)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1dn4Y7-0005yX-Tt
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 11:05:00 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <9b24c28f-f891-1046-f09f-bffded9e316f@huawei.com>
References: <1504016587-39779-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<w51fuc98di8.fsf@maestria.local.igalia.com>
	<9b24c28f-f891-1046-f09f-bffded9e316f@huawei.com>
Date: Wed, 30 Aug 2017 16:54:31 +0200
Message-ID: <w51bmmx85so.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v8 0/6] fsdev: qmp interface for io
 throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, eric blake <eblake@redhat.com>, greg kurz <groug@kaod.org>
Cc: Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

On Wed 30 Aug 2017 02:10:53 PM CEST, Pradeep Jagadeesh wrote:

>> I'm trying to read from an 9p share that has limits set with hmp
>> fsdev_set_io_throttle and I'm having some problems.

Here's one simple way to reproduce it:

1) Launch qemu with

   -fsdev local,security_model=none,id=fs0,path=/some/files
   -device virtio-9p-pci,fsdev=fs0,mount_tag=fs0

2) In the guest, mount the fs0 share in /mnt

3) Run this hmp command

   fsdev_set_io_throttle fs0 0 4096 0 0 0 0

4) In the guest, start reading some large file from the 9p share:

   dd if=/mnt/large_file of=/dev/null bs=4k iflag=direct status=progress

5) Check the progress, reading speed should be around 4k per second.

6) While dd is still running, change the I/O limits:

   fsdev_set_io_throttle fs0 0 8192 0 0 0 0

7) If you check the status of the dd command, reading should be faster
   now. Instead, it is stalled.

Berto
