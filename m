Received: from eggs.gnu.org ([2001:4830:134:3::10]:59919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1fSIRK-0000Yf-TM
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 04:44:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1fSIRJ-0000eR-SA
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 04:44:38 -0400
Date: Mon, 11 Jun 2018 09:44:23 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20180611084423.GL1455@redhat.com>
References: <20180528183058.GG2209@redhat.com>
	<20180528183833.GJ4580@localhost.localdomain>
	<20180528212054.GH2209@redhat.com>
	<20180528212510.GC4660@redhat.com>
	<20180529064415.GA4756@localhost.localdomain>
	<2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
	<20180606123237.2235ae4a@kitsune.suse.cz>
	<bc97cdc3-85ba-e053-0816-b6bc431064fb@redhat.com>
	<20180606131929.44d0fd6b@kitsune.suse.cz>
	<93233bff-604b-c891-90ce-64fe1eaaaab5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93233bff-604b-c891-90ce-64fe1eaaaab5@redhat.com>
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com, ehabkost@redhat.com, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

On Wed, Jun 06, 2018 at 01:32:47PM +0200, Max Reitz wrote:
> ext2?

I wrote an nbdkit plugin for ext2/ext3/ext4 last week.

  https://github.com/libguestfs/nbdkit/tree/master/plugins/ext2

It uses libext2fs from e2fsprogs and I think there are some lessons
for anyone who wants to use ext2 to store disk images.

(1) You cannot have more than one host process accessing a single
filesystem image, even read-only.  This is because opening an ext2+
filesystem even read-only causes writes, replaying the journal (for
ext3+) or writing to the superblock.

I'm sure there are some common use-cases such as overlays sharing a
common backing store which are excluded by this restriction.

(2) Within a single process you cannot have more than one libext2fs
handle open on the filesystem image.  This could make qemu block
drivers a bit awkward (although not impossible) because if two
instances of an ext2 qemu block driver both opened different disks in
the same filesystem they'd need to share a handle.

(3) You can resize files in the filesystem, although because we're
waiting for the NBD resize extension to be finalized my plugin does
not do that.

(4) Trim/discard appears to be possible (and it should be possible to
punch holes in the filesystem image) but I couldn't actually
understand how to make it work.  Also fast zeroing.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org
