Received: from eggs.gnu.org ([2001:4830:134:3::10]:55821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fBI74-0005qR-Ea
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 06:57:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fBI73-0007yV-IP
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 06:57:26 -0400
Date: Wed, 25 Apr 2018 12:57:08 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180425105708.GB4652@localhost.localdomain>
References: <20180424192506.149089-1-eblake@redhat.com>
	<20180424192506.149089-3-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424192506.149089-3-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/6] file-win32: Switch to byte-based
 callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Weil <sw@weilnetz.de>

Am 24.04.2018 um 21:25 hat Eric Blake geschrieben:
> We are gradually moving away from sector-based interfaces, towards
> byte-based.  Make the change for the last few sector-based callbacks
> in the file-win32 driver.
> 
> Note that the driver was already using byte-based calls for
> performing actual I/O, so this just gets rid of a round trip
> of scaling; however, as I don't know if Windows is tolerant of
> non-sector AIO operations, I went with the conservative approach
> of modifying .bdrv_refresh_limits to override the block layer
> defaults back to the pre-patch value of 512.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> Compile-tested via 'make docker-test-mingw@fedora', but I don't
> have a sane way to test whether it actually works.

Tried to test it, and the only result is that something was broken even
before your patch:

$ ./qemu-img.exe create -f raw /tmp/test.raw 128M
Formatting '/tmp/test.raw', fmt=raw size=134217728
$ ./qemu-io.exe -f raw -c 'read 0 4k' /tmp/test.raw
read failed: Input/output error

For some reason, doing the same with qcow2 works fine. qemu-iotests
for qcow2 starts hanging in 013. Maybe someone should look into this,
qemu-iotests was working fairly well with mingw builds some time ago.
Nothing that will hold up this series, though.

Kevin
