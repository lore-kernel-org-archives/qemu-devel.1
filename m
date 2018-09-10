Received: from eggs.gnu.org ([208.118.235.92]:43588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fzPE0-0004jR-4j
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 12:39:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fzPDw-00060o-Qr
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 12:39:43 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <7d9487b1-53d6-547b-8c28-f9a1fad4991b@redhat.com>
References: <20180910092924.23403-1-berto@igalia.com>
	<20180910095748.GD4901@dhcp-200-186.str.redhat.com>
	<7d9487b1-53d6-547b-8c28-f9a1fad4991b@redhat.com>
Date: Mon, 10 Sep 2018 18:39:37 +0200
Message-ID: <w51h8ixtigm.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] qemu-iotests: Test snapshot=on with
 nonexistent TMPDIR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

On Mon 10 Sep 2018 05:55:15 PM CEST, Eric Blake wrote:
>> Hm, it actually doesn't crash for me even without the fix. Anyway, I
>> don't have a good idea to make it more likely to crash and it's
>> certainly better than nothing.
>
> Does running the test under valgrind reliably see the use-after-free?

Good question! :-)

Unfortunately valgrind also needs a valid TMPDIR, so if you change it in
order to reproduce the bug then valgrind won't run.

I don't know if there's a way to tell valgrind to run the specified
program with its own environment variables, but you can simply edit
QEMU's get_tmp_filename() to always return an invalid directory, and
then you get the expected result:

 Invalid read of size 8 
    at 0x859914: qobject_unref_impl (qobject.h:98)
    by 0x85F8EA: bdrv_open_inherit (block.c:2831)
    by 0x85F963: bdrv_open (block.c:2839)
    by 0x8BDD19: blk_new_open (block-backend.c:375)
    by 0x58A88A: blockdev_init (blockdev.c:599)
    by 0x58B6C4: drive_new (blockdev.c:990)
    by 0x59C004: drive_init_func (vl.c:1143)
    by 0x9A0CE3: qemu_opts_foreach (qemu-option.c:1106)
    by 0x5A4692: main (vl.c:4454)
  Address 0x1df67458 is 8 bytes inside a block of size 4,120 free'd
    at 0x4C2CDDB: free (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
    by 0x97AD5F: qdict_destroy_obj (qdict.c:459)
    by 0x97CC04: qobject_destroy (qobject.c:41)
    by 0x85996F: qobject_unref_impl (qobject.h:100)
    by 0x85F6D4: bdrv_open_inherit (block.c:2794)
    by 0x85F963: bdrv_open (block.c:2839)
      [...]

Berto
