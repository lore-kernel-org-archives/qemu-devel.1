Received: from eggs.gnu.org ([2001:4830:134:3::10]:52455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1d36br-0006jU-J4
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 15:58:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1d36bo-0003tr-F0
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 15:58:51 -0400
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Wed, 26 Apr 2017 01:29:03 +0530
Message-Id: <1493150351-28918-1-git-send-email-ashijeetacharya@gmail.com>
Subject: [Qemu-devel] [PATCH v1 0/8] Refactor DMG driver to have chunk size
 independence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@gmail.com
Cc: kwolf@redhat.com, jsnow@redhat.com, mreitz@redhat.com, famz@redhat.com, peter@lekensteyn.nl, qemu-devel@nongnu.org, qemu-block@nongnu.org, Ashijeet Acharya <ashijeetacharya@gmail.com>

This series helps to provide chunk size independence for DMG driver to prevent
denial-of-service in cases where untrusted files are being accessed by the user.

This task is mentioned on the public block ToDo
Here -> http://wiki.qemu.org/ToDo/Block/DmgChunkSizeIndependence

Patch 1 introduces a new data structure to aid caching of random access points
within a compressed stream.

Patch 2 is an extension of patch 1 and introduces a new function to
initialize/update/reset our cached random access point.

Patch 3 limits the output buffer size to a max of 2MB to avoid QEMU allocate
huge amounts of memory.

Patch 4 is a simple preparatory patch to aid handling of various types of chunks.

Patches 5 & 6 help to handle various types of chunks.

Patch 7 simply refactors dmg_co_preadv() to read multiple sectors at once.

Patch 8 finally removes the error messages QEMU used to throw when an image with
chunk sizes above 64MB were accessed by the user.

->Testing procedure:
Convert a DMG file to raw format using the "qemu-img convert" tool present in
v2.9.0
Next convert the same image again after applying these patches.
Compare the two images using "qemu-img compare" tool to check if they are
identical.

You can pickup any DMG image from the collection present
Here -> https://lists.gnu.org/archive/html/qemu-devel/2014-12/msg03606.html

->Important note:
These patches assume that the terms "chunk" and "block" are synonyms of each other
when we talk about bz2 compressed streams. Thus according to the bz2 docs[1],
the max uncompressed size of a chunk/block can reach to 46MB which is less than
the previously allowed size of 64MB, so we can continue decompressing the whole
chunk/block at once instead of partial decompression just like we do now.

This limitation was forced by the fact that bz2 compressed streams do not allow
random access midway through a chunk/block as the BZ2_bzDecompress() API in bzlib
seeks for the magic key "BZh" before starting decompression.[2] This magic key is
present at the start of every chunk/block only and since our cached random access
points need not necessarily point to the start of a chunk/block, BZ2_bzDecompress()
fails with an error value BZ_DATA_ERROR_MAGIC[3]

[1] https://en.wikipedia.org/wiki/Bzip2#File_format
[2] https://blastedbio.blogspot.in/2011/11/random-access-to-bzip2.html
[3] http://linux.math.tifr.res.in/manuals/html/manual_3.html#SEC17

Special thanks to Peter Wu for helping me understand and tackle the bz2
compressed chunks.

Ashijeet Acharya (8):
  dmg: Introduce a new struct to cache random access points
  dmg: New function to help us cache random access point
  dmg: Limit the output buffer size to a max of 2MB
  dmg: Refactor and prepare dmg_read_chunk() to cache random access
    points
  dmg: Handle zlib compressed chunks
  dmg: Handle bz2 compressed/raw/zeroed chunks
  dmg: Refactor dmg_co_preadv() to start reading multiple sectors
  dmg: Remove the error messages to allow wild images

 block/dmg.c | 214 +++++++++++++++++++++++++++++++++++++++---------------------
 block/dmg.h |  10 +++
 2 files changed, 148 insertions(+), 76 deletions(-)

-- 
2.6.2
