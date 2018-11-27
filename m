Received: from eggs.gnu.org ([2001:4830:134:3::10]:40009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gRg92-0003dK-BT
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 11:23:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gRg91-0000Fv-G8
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 11:23:28 -0500
Date: Tue, 27 Nov 2018 16:23:02 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181127162302.GM18381@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181123165511.416480-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181123165511.416480-1-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 00/11] qcow2: encryption threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, kwolf@redhat.com, berto@igalia.com, den@openvz.org

On Fri, Nov 23, 2018 at 07:55:00PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
> 
> The series brings threads to qcow2 encryption/decryption path,
> like it is already done for compression.
> 
> Based-on: Kevin's block-next branch [d3db1496c5]
> 
> Performance gain is illustrated by the following test:
> 
> ]# cat test.sh 
> #!/bin/bash
> 
> size=1G
> src=/ssd/src.raw
> dst=/ssd/dst.enc.qcow2
> 
> echo create source for tests
> ./qemu-img create -f raw "$src" $size
> ./qemu-io -f raw -c "write -P 0xa 0 $size" "$src"
> 
> for w in "" "-W"; do
>     echo -e "\n\nTest with additional paramter for qemu-img: '$w'\n"
> 
>     echo create target...
>     ./qemu-img create -f qcow2 --object secret,id=sec0,data=test -o encrypt.format=luks,encrypt.key-secret=sec0,encrypt.iter-time=10 "$dst" $size
>     echo
> 
>     echo test...
>     time ./qemu-img convert $w -f raw --object secret,id=sec0,data=test --target-image-opts -n "$src" "driver=qcow2,file.filename=$dst,encrypt.key-secret=sec0"
> done

Note that using  iter-time=10 is removing the time penalty for opening
the luks device. This is why you didn't see the significant negative
performance impact of creating many  QCryptoBlock instances, one for
each thread.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
