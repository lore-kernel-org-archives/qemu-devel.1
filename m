Received: from eggs.gnu.org ([2001:4830:134:3::10]:33672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gRfrb-0003h4-11
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 11:05:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gRfrW-0006Y0-2I
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 11:05:26 -0500
Date: Tue, 27 Nov 2018 16:05:02 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181127160502.GI18381@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1bc34791-6ae3-cbcd-222f-468b89205f64@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1bc34791-6ae3-cbcd-222f-468b89205f64@virtuozzo.com>
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

On Wed, Nov 21, 2018 at 05:30:53PM +0000, Vladimir Sementsov-Ogievskiy wrote:
> Hi Daniel!
> 
> After moving compression to threads in Qcow2 it's an obvious next step to
> "threadyfy" encryption in Qcow2 too.
> 
> But it turned out to be not as simple as I assumed. If I call qcrypto_block_encrypt
> in parallel threads with the same first argument (block), it just produce wrong
> things (pattern verification fails in iotests)..

Yes, this makes sense, because the underlying crypto impls all require
that their state is only used from a single thread at any time. What's
likely happening is that the IV is being scrambled so we're encrypting
with the wrong tweak.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
