Received: from eggs.gnu.org ([2001:4830:134:3::10]:52578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cjTU8-0002uw-65
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 11:21:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cjTU7-0006wx-2x
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 11:21:44 -0500
References: <20170302130422.81380-1-pasic@linux.vnet.ibm.com>
	<20170302154935.7b8ec875.cornelia.huck@de.ibm.com>
	<b12c69aa-67ee-ffbc-cd89-716c24889167@redhat.com>
	<9a67d492-5bda-4b2a-0732-4034176d0d28@linux.vnet.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7b6ff676-bf57-d9ab-def7-fe894f821f03@redhat.com>
Date: Thu, 2 Mar 2017 17:21:39 +0100
MIME-Version: 1.0
In-Reply-To: <9a67d492-5bda-4b2a-0732-4034176d0d28@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/1] virtio-blk: fix race on guest notifiers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-stable@nongnu.org



On 02/03/2017 16:55, Halil Pasic wrote:
>>>>      blk_set_aio_context(s->conf->conf.blk, qemu_get_aio_context());
> I'm wondering if synchronization is needed for batch_notify_vqs. I thin=
k
> the set_bit can be from the iothread, but the notify_guest_bh below is =
main
> event loop. Is it OK like this (could we miss bits set in other thread)=
?
> Does blk_set_aio_context include a barrier?

Another good question---yes, it does (via bdrv_set_aio_context's call to
aio_context_acquire).

But it's something to remember for when I get round to removing
aio_context_acquire!

Paolo
