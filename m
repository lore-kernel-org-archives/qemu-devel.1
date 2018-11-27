Received: from eggs.gnu.org ([2001:4830:134:3::10]:34898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gRfuv-0006DL-Uf
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 11:08:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gRfuu-0002Rn-RV
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 11:08:53 -0500
Date: Tue, 27 Nov 2018 16:08:41 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181127160841.GJ18381@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1bc34791-6ae3-cbcd-222f-468b89205f64@virtuozzo.com>
	<50b00028-9f75-743b-cdec-58cd367a268a@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <50b00028-9f75-743b-cdec-58cd367a268a@virtuozzo.com>
Subject: Re: [Qemu-devel] encrypt in threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Thu, Nov 22, 2018 at 01:01:20PM +0000, Vladimir Sementsov-Ogievskiy wrote:
> 21.11.2018 20:30, Vladimir Sementsov-Ogievskiy wrote:
> > Hi Daniel!
> > 
> > After moving compression to threads in Qcow2 it's an obvious next step to
> > "threadyfy" encryption in Qcow2 too.
> > 
> > But it turned out to be not as simple as I assumed. If I call qcrypto_block_encrypt
> > in parallel threads with the same first argument (block), it just produce wrong
> > things (pattern verification fails in iotests)..
> > 
> > So, can you advise the way to parallelize encryption/decryption?
> > 
> 
> Hmm, just creating QCryptoBlock per each thread helped. Is it correct thing to do?

That's rather a heavy weight approach and would cause pain when we want
to support future options such as keyslot updates, and in the future,
LUKSv2 with master key changes.

Probably what's needed is change to QCryptoBlock struct so that there
can be multiple QCryptoCipher instances allocated - one per thread.

We might also need to introduce some locking around usage of the
QCryptoIVGen object, since that has a QCryptoCipher handle too.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
