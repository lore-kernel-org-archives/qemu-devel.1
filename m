Received: from eggs.gnu.org ([2001:4830:134:3::10]:57987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eRr2k-00035V-Ni
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 21:57:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eRr2j-0008DI-L1
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 21:57:10 -0500
References: <151372207410.18061.3050483309114042068.malonedeb@chaenomeles.canonical.com>
	<151376591662.17755.1284403896485862270.malone@chaenomeles.canonical.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <1a65c254-64b7-5a41-1c15-823f5d30779d@redhat.com>
Date: Wed, 20 Dec 2017 21:57:00 -0500
MIME-Version: 1.0
In-Reply-To: <151376591662.17755.1284403896485862270.malone@chaenomeles.canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Bug 1739304] Re: Passing a directory to (eg.)
 -cdrom results in misleading error message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1739304 <1739304@bugs.launchpad.net>, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Qemu-block <qemu-block@nongnu.org>



On 12/20/2017 05:31 AM, Dr. David Alan Gilbert wrote:
> Yep, can repeat it here, it seems pretty random which error it gives:
> 
> [dgilbert@dgilbert-t530 try]$ ./x86_64-softmmu/qemu-system-x86_64 -cdrom /tmp
> qemu-system-x86_64: -cdrom /tmp: Could not refresh total sector count: Invalid argument
> [dgilbert@dgilbert-t530 try]$ ./x86_64-softmmu/qemu-system-x86_64 -cdrom /var
> qemu-system-x86_64: -cdrom /var: Could not read image for determining its format: File too large
> 
> 
> ** Changed in: qemu
>        Status: New => Confirmed
> 

Looks like directories play funny games.

Probably seems to be ultimately that bs->total_sectors gets set to a
very silly and large value, which later on will fail the format probing
because bdrv_getlength refuses to play nice with such a stupidly large
value:

    ret = ret > INT64_MAX / BDRV_SECTOR_SIZE ? -EFBIG : ret;
    return ret < 0 ? ret : ret * BDRV_SECTOR_SIZE;

but the real villain is down here, when we add the "file" to to a raw
posix file bs for the hopes of probing it.

#0  0x0000555555be7e2e in raw_getlength (bs=0x555556b23bb0) at
/home/bos/jhuston/src/qemu/block/file-posix.c:1964
#1  0x0000555555b81630 in refresh_total_sectors (bs=0x555556b23bb0,
hint=0) at /home/bos/jhuston/src/qemu/block.c:733
#2  0x0000555555b82490 in bdrv_open_driver (bs=0x555556b23bb0,
drv=0x555556541420 <bdrv_file>, node_name=0x0, options=0x555556b28090,
open_flags=16384, errp=0x7fffffffda80) at
/home/bos/jhuston/src/qemu/block.c:1162
#3  0x0000555555b82d67 in bdrv_open_common (bs=0x555556b23bb0, file=0x0,
options=0x555556b28090, errp=0x7fffffffda80)
    at /home/bos/jhuston/src/qemu/block.c:1404
#4  0x0000555555b8578f in bdrv_open_inherit (filename=0x555556b143a0
"/media/ext/", reference=0x0, options=0x555556b28090, flags=32768,
parent=0x555556b1d6b0, child_role=0x5555563b04a0 <child_file>,
errp=0x7fffffffdbe0) at /home/bos/jhuston/src/qemu/block.c:2628
#5  0x0000555555b84d10 in bdrv_open_child_bs (filename=0x555556b143a0
"/media/ext/", options=0x555556b21a60, bdref_key=0x555555e55712 "file",
parent=0x555556b1d6b0, child_role=0x5555563b04a0 <child_file>,
allow_none=true, errp=0x7fffffffdbe0) at
/home/bos/jhuston/src/qemu/block.c:2324
#6  0x0000555555b85594 in bdrv_open_inherit (filename=0x555556b143a0
"/media/ext/", reference=0x0, options=0x555556b21a60, flags=0,
parent=0x0, child_role=0x0, errp=0x7fffffffdef0) at
/home/bos/jhuston/src/qemu/block.c:2576
#7  0x0000555555b85b10 in bdrv_open (filename=0x555556b143a0
"/media/ext/", reference=0x0, options=0x555556b1b280, flags=0,
errp=0x7fffffffdef0)
    at /home/bos/jhuston/src/qemu/block.c:2710
#8  0x0000555555bdd428 in blk_new_open (filename=0x555556b143a0
"/media/ext/", reference=0x0, options=0x555556b1b280, flags=0,
errp=0x7fffffffdef0) at /home/bos/jhuston/src/qemu/block/block-backend.c:323
#9  0x0000555555911a60 in blockdev_init (file=0x555556b143a0
"/media/ext/", bs_opts=0x555556b1b280, errp=0x7fffffffdef0)
    at /home/bos/jhuston/src/qemu/blockdev.c:587


specifically:

(gdb) s
1963	    size = lseek(s->fd, 0, SEEK_END);
(gdb) s
1964	    if (size < 0) {
(gdb) print size
$37 = 9223372036854775807

cool, cool, cool. This value is 0x7fffffffffffffff and errno isn't set.
cool and good function.

so, lseek on a folder returns crazy nonsense. Perhaps we ought to
actually specifically disallow folders, we don't appear to.

Learned something today.

--js
