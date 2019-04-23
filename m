Received: from eggs.gnu.org ([209.51.188.92]:37905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1hItiZ-0005Qj-UO
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:36:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1hItiY-0003rN-UF
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:36:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36304)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1hItiY-0003pH-OM
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:36:06 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 800C0319937F
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 11:36:04 +0000 (UTC)
Date: Tue, 23 Apr 2019 12:36:02 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20190423113602.GJ3926@redhat.com>
References: <20190423113028.GD30014@wheatley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423113028.GD30014@wheatley>
Subject: Re: [Qemu-devel] Possibly incorrect data sparsification by qemu-img
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Martin Kletzander <mkletzan@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

On Tue, Apr 23, 2019 at 01:30:28PM +0200, Martin Kletzander wrote:
> I am using qemu-img with nbdkit to transfer a disk image and the
> update it with extra data from newer snapshots.  The end image
> cannot be transferred because the snapshots will be created later
> than the first transfer and we want to save some time up front.  You
> might think of it as a continuous synchronisation.

It's important to note here that Martin is reading the data from a
VMware server, so this is not something that can be solved with qemu's
own snapshots.

[...]

I think the following is an even simpler demo which gets to the nub of
the problem as I understand it:

$ rm -f disk.img snap.img
$ dd if=/dev/urandom of=disk.img bs=2M count=1
$ dd if=/dev/zero of=snap.img bs=2M count=1
$ qemu-img convert -n -p snap.img disk.img
$ hexdump -C disk.img | head
00000000  18 30 e8 1f 09 f0 bb 2c  2f c7 b3 97 8f 12 fe 4b  |.0.....,/......K|
00000010  66 f7 28 cb 8e 72 2a 37  6b fa 98 2e a0 e6 d9 cf  |f.(..r*7k.......|
[etc] <- ie. not zeroes

Should we expect disk.img to contain zeroes at the end?

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
Fedora Windows cross-compiler. Compile Windows programs, test, and
build Windows installers. Over 100 libraries supported.
http://fedoraproject.org/wiki/MinGW
