Received: from eggs.gnu.org ([2001:4830:134:3::10]:40475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fWKva-0004Zw-7H
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:12:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fWKvX-0004Iv-0n
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:12:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44624 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fWKvW-0004Ij-Rd
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:12:30 -0400
References: <20180621145749.191944-1-eblake@redhat.com>
	<CAFEAcA_6aJ705HdAD6b4m3fsGBGa6gEQXet5dkgc5aELxeknBw@mail.gmail.com>
	<CAFEAcA_0xjKVuSrUh5twc07=d-HPVoUc8JH9xunAapWCgpNreQ@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5db29b95-c79b-9766-81c8-360cdd0a5b94@redhat.com>
Date: Fri, 22 Jun 2018 07:12:29 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_0xjKVuSrUh5twc07=d-HPVoUc8JH9xunAapWCgpNreQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL v2 0/9] bitmap export over NBD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 06/22/2018 06:43 AM, Peter Maydell wrote:
> On 22 June 2018 at 10:57, Peter Maydell <peter.maydell@linaro.org> wrote:
>> On 21 June 2018 at 15:57, Eric Blake <eblake@redhat.com> wrote:
>>> ----------------------------------------------------------------
>>> nbd patches for 2018-06-20
>>>
>>> Add experimental x-nbd-server-add-bitmap to expose a disabled
>>> bitmap over NBD, in preparation for a pull model incremental
>>> backup scheme. Also fix a corner case protocol issue with
>>> NBD_CMD_BLOCK_STATUS, and add new NBD_CMD_CACHE.
>>>
>>> - Eric Blake: tests: Simplify .gitignore
>>> - Eric Blake: nbd/server: Reject 0-length block status request
>>> - Vladimir Sementsov-Ogievskiy: 0/6 NBD export bitmaps
>>> - Vladimir Sementsov-Ogievskiy: nbd/server: introduce NBD_CMD_CACHE
>>>
>> Applied, thanks.
> 
> ...patchew seems to be unhappy, though, eg
> https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg06559.html
> has an unrelated patchset failing with:
> 
> /tmp/qemu-test/src/nbd/server.c: In function 'nbd_trip':
> /tmp/qemu-test/src/nbd/server.c:1980:19: error: 'end' may be used uninitialized
> in this function [-Werror=maybe-uninitialized]
>       *length = end - offset;
>                 ~~~~^~~~~~~~

Uurgh. It's a false positive (the compiler is complaining that the 
variable is uninitialized, which can only happen if the while loop is 
not executed; but the preconditions guarantee the loop executes at least 
once).  The assert() that I added was enough to silence gcc 7.3.1 on my 
Fedora 27 system, but docker-mingw@fedora is using 
gcc-8.1.1-1.fc28.x86_64. This should silence things (another way to 
silence would be rewriting while{} into do{}while).  I'll submit this as 
a formal patch if I can reproduce the problem/fix on docker.

diff --git i/nbd/server.c w/nbd/server.c
index 94137fbfe8f..2379f82d5d4 100644
--- i/nbd/server.c
+++ w/nbd/server.c
@@ -1968,7 +1968,7 @@ static unsigned int 
bitmap_to_extents(BdrvDirtyBitmap *bitmap, uint64_t offset,
                                        unsigned int nb_extents,
                                        bool dont_fragment)
  {
-    uint64_t begin = offset, end;
+    uint64_t begin = offset, end = offset;
      uint64_t overall_end = offset + *length;
      unsigned int i = 0;
      BdrvDirtyBitmapIter *it;
@@ -2008,6 +2008,7 @@ static unsigned int 
bitmap_to_extents(BdrvDirtyBitmap *bitmap, uint64_t offset,

      bdrv_dirty_bitmap_unlock(bitmap);

+    assert(offset > end);
      *length = end - offset;
      return i;
  }


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
