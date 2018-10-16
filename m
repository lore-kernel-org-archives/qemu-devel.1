Received: from eggs.gnu.org ([2001:4830:134:3::10]:53238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gCMeB-0005Bc-Va
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:32:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gCMe8-0001ZX-Pi
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:32:18 -0400
Date: Tue, 16 Oct 2018 11:32:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181016103205.GC7995@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181011105802.22665-1-berto@igalia.com>
	<cfedbf5d-1399-6d21-b686-1dedfaf5f7d9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cfedbf5d-1399-6d21-b686-1dedfaf5f7d9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qcow2: Get the request alignment for
 encrypted images from QCryptoBlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On Mon, Oct 15, 2018 at 06:38:14PM +0200, Max Reitz wrote:
> On 11.10.18 12:58, Alberto Garcia wrote:
> > This doesn't have any practical effect at the moment because the
> > values of BDRV_SECTOR_SIZE, QCRYPTO_BLOCK_LUKS_SECTOR_SIZE and
> > QCRYPTO_BLOCK_QCOW_SECTOR_SIZE are all the same (512 bytes), but
> > future encryption methods could have different requirements.
> > 
> > Signed-off-by: Alberto Garcia <berto@igalia.com>
> > ---
> >  block/qcow2.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> This breaks non-LUKS encryption:
> 
> $ ./qemu-img create -f qcow2 -o encryption=on,encrypt.key-secret=secret
> --object secret,id=secret,data=foo foo.qcow2 64M
> Formatting 'foo.qcow2', fmt=qcow2 size=67108864 encryption=on
> encrypt.key-secret=secret cluster_size=65536 lazy_refcounts=off
> refcount_bits=16
> qemu-img: block.c:1248: bdrv_open_driver: Assertion
> `is_power_of_2(bs->bl.request_alignment)' failed.
> [1]    13589 abort (core dumped)  ./qemu-img create -f qcow2 -o
> encryption=on,encrypt.key-secret=secret --objec
> 
> (As seen in iotests 049, 087, 134, and 158.)

We failed to set sector size in the crypto backend when opening with
the NO_IO flag set. I just sent a fix for that. Feel free to queue it
as part of the block layer rather than waiting for my next crypto layer
pull request.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
