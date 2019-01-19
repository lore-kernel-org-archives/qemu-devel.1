Received: from eggs.gnu.org ([209.51.188.92]:34634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gklfK-0002IW-71
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 03:07:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gklfJ-0004FD-7Y
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 03:07:42 -0500
Date: Sat, 19 Jan 2019 08:07:12 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20190119080712.GY27120@redhat.com>
References: <20190117193658.16413-1-eblake@redhat.com>
	<f10654ba-04d3-3212-94ca-e72c511d51c2@virtuozzo.com>
	<38eca33c-cbea-6948-0e05-86a5e0bbeb00@virtuozzo.com>
	<928553ea-9694-acc6-1c5f-5a09afc2c64c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <928553ea-9694-acc6-1c5f-5a09afc2c64c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 00/21] nbd: add qemu-nbd --list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "nsoffer@redhat.com" <nsoffer@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>

On Fri, Jan 18, 2019 at 04:47:42PM -0600, Eric Blake wrote:
> It matches the code, but I just learned the code is buggy for anything
> larger than 5.  According to
> http://tldp.org/HOWTO/Large-Disk-HOWTO-13.html, MBR Extended/Logical
> partitions form a linked-list, something like:
> 
> MBR:              EBR1              EBR2
> +----------+      +----------+      +----------+
> + Part 1   +   |->+ Part 5   +   |->+ Part 6   +
> + Part 2   +   |  + Next --------|  + 0        +
> + Part 3   +   |  + 0        +      + 0        +
> + Part 4 -------  + 0        +      + 0        +
> +----------+      +----------+      +----------+

Wikipedia's description is a bit better:

https://en.wikipedia.org/wiki/Extended_boot_record

In fact it's not strictly a linked list because the start record of
each entry is relative to the extended partition start.  It's all a
bit weird.

But you're right, nbdkit can neither read (nbdkit-partition-filter)
nor write (nbdkit-partitioning-plugin) MBR logical partitions so we
can't test interop or tell people to use nbdkit for this corner case.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
Fedora Windows cross-compiler. Compile Windows programs, test, and
build Windows installers. Over 100 libraries supported.
http://fedoraproject.org/wiki/MinGW
