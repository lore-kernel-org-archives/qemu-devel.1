Received: from eggs.gnu.org ([2001:4830:134:3::10]:57878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gRuYQ-0000zA-4S
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 02:46:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gRuYM-0001Kd-6M
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 02:46:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34022)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1gRuYL-0001Dh-Kn
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 02:46:34 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8B8CF3086262
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 07:46:30 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20181127221219-mutt-send-email-mst@kernel.org> (Michael
	S. Tsirkin's message of "Tue, 27 Nov 2018 22:13:33 -0500")
References: <20181126200009.862-1-quintela@redhat.com>
	<20181127221219-mutt-send-email-mst@kernel.org>
Reply-To: quintela@redhat.com
Date: Wed, 28 Nov 2018 08:46:15 +0100
Message-ID: <874lc13arc.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 00/16] Virtio devices split from
 virtio-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

"Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Mon, Nov 26, 2018 at 08:59:53PM +0100, Juan Quintela wrote:
>> Hi
>> 
>> V2:
>> 
>> - Rebase on top of master
>> 
>> Please review.
>> 
>> Later, Juan.
>
> And just making sure the point is so that one
> can disable virtio-pci and still build virtio?
>
> And the point of that is mostly as a cleanup on
> generic principles, right? Or is there a project that
> actually wants to do it?

This allows "make check" to work with them disabled.  Without this
changes, introspection fails, because we have the "name" (kind of)
"virtio-pci-blk", but not the real virtio device, so it tries to use it
while it is not there.  See the equivalent change for virtio-ccw-*.

Thanks, Juan.

PD.  Without this change, you can build a qemu with virtio devices
     disabled (i.e. not compiled in), but it fails "make check".  With
     the changes, it also works for "make check".


>
>> 
>> [v1]
>> >From previous verision (in the middle of make check tests):
>> - split also the bits of virtio-pci.h (mst suggestion)
>> - add gpu, crypt and gpg bits
>> - more cleanups
>> - fix all the copyrights (the ones not changed have been there
>>   foverever)
>> - be consistent with naming, vhost-* or virtio-*
>> 
>> Please review, Juan.
>> 
>> Juan Quintela (16):
>>   virtio: split vhost vsock bits from virtio-pci
>>   virtio: split virtio input host bits from virtio-pci
>>   virtio: split virtio input bits from virtio-pci
>>   virtio: split virtio rng bits from virtio-pci
>>   virtio: split virtio balloon bits from virtio-pci
>>   virtio: split virtio 9p bits from virtio-pci
>>   virtio: split vhost user blk bits from virtio-pci
>>   virtio: split vhost user scsi bits from virtio-pci
>>   virtio: split vhost scsi bits from virtio-pci
>>   virtio: split virtio scsi bits from virtio-pci
>>   virtio: split virtio blk bits rom virtio-pci
>>   virtio: split virtio net bits rom virtio-pci
>>   virtio: split virtio serial bits rom virtio-pci
>>   virtio: split virtio gpu bits rom virtio-pci.h
>>   virtio: split virtio crypto bits rom virtio-pci.h
>>   virtio: virtio 9p really requires CONFIG_VIRTFS to work
>> 
>>  default-configs/virtio.mak        |   3 +-
>>  hw/display/virtio-gpu-pci.c       |  14 +
>>  hw/display/virtio-vga.c           |   1 +
>>  hw/virtio/Makefile.objs           |  14 +-
>>  hw/virtio/vhost-scsi-pci.c        |  95 ++++
>>  hw/virtio/vhost-user-blk-pci.c    | 101 ++++
>>  hw/virtio/vhost-user-scsi-pci.c   | 101 ++++
>>  hw/virtio/vhost-vsock-pci.c       |  82 ++++
>>  hw/virtio/virtio-9p-pci.c         |  86 ++++
>>  hw/virtio/virtio-balloon-pci.c    |  94 ++++
>>  hw/virtio/virtio-blk-pci.c        |  97 ++++
>>  hw/virtio/virtio-crypto-pci.c     |  14 +
>>  hw/virtio/virtio-input-host-pci.c |  45 ++
>>  hw/virtio/virtio-input-pci.c      | 154 ++++++
>>  hw/virtio/virtio-net-pci.c        |  96 ++++
>>  hw/virtio/virtio-pci.c            | 783 ------------------------------
>>  hw/virtio/virtio-pci.h            | 234 ---------
>>  hw/virtio/virtio-rng-pci.c        |  86 ++++
>>  hw/virtio/virtio-scsi-pci.c       | 106 ++++
>>  hw/virtio/virtio-serial-pci.c     | 112 +++++
>>  tests/Makefile.include            |  18 +-
>>  21 files changed, 1308 insertions(+), 1028 deletions(-)
>>  create mode 100644 hw/virtio/vhost-scsi-pci.c
>>  create mode 100644 hw/virtio/vhost-user-blk-pci.c
>>  create mode 100644 hw/virtio/vhost-user-scsi-pci.c
>>  create mode 100644 hw/virtio/vhost-vsock-pci.c
>>  create mode 100644 hw/virtio/virtio-9p-pci.c
>>  create mode 100644 hw/virtio/virtio-balloon-pci.c
>>  create mode 100644 hw/virtio/virtio-blk-pci.c
>>  create mode 100644 hw/virtio/virtio-input-host-pci.c
>>  create mode 100644 hw/virtio/virtio-input-pci.c
>>  create mode 100644 hw/virtio/virtio-net-pci.c
>>  create mode 100644 hw/virtio/virtio-rng-pci.c
>>  create mode 100644 hw/virtio/virtio-scsi-pci.c
>>  create mode 100644 hw/virtio/virtio-serial-pci.c
>> 
>> -- 
>> 2.19.1
>> 
