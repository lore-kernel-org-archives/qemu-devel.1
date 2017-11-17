Received: from eggs.gnu.org ([2001:4830:134:3::10]:48964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eFpcP-0005Mg-0z
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 18:00:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eFpcO-0003Wn-47
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 18:00:17 -0500
References: <20171117190422.23626-1-eblake@redhat.com>
	<6f4f6793-c3fc-6711-39af-971964adb37c@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <367da343-8031-56b4-a6d2-bf7191447bd5@redhat.com>
Date: Fri, 17 Nov 2017 17:59:58 -0500
MIME-Version: 1.0
In-Reply-To: <6f4f6793-c3fc-6711-39af-971964adb37c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.11] iotests: Fix 176 on
 32-bit host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com



On 11/17/2017 02:10 PM, Eric Blake wrote:
> On 11/17/2017 01:04 PM, Eric Blake wrote:
>> The contents of a qcow2 bitmap are rounded up to a size that
>> matches the number of bits available for the granularity, but
>> that granularity differs for 32-bit hosts (our default 64k
>> cluster allows for 2M bitmap coverage per 'long') and 64-bit
>> hosts (4M bitmap per 'long').  If the image is a multiple of
>> 2M but not 4M, then the number of bytes occupied by the array
>> of longs in memory differs between architecture, thus
>> resulting in different SHA256 hashes.
>>
>> Furthermore (but untested by me), if our computation of the
>> SHA256 hash is at all endian-dependent because of how we store
>> data in memory, that's another variable we'd have to account
>> for (ideally, we specified the bitmap stored in qcow2 as
>> fixed-endian on disk, because the same qcow2 file must be
>> usable across any architecture; but that says nothing about
>> how we represent things in memory).  But we already have test
>> 165 to validate that bitmaps are stored correctly on disk,
>> while this test is merely testing that the bitmap exists.
>>
>> So for this test, the easiest solution is to filter out the
>> actual hash value.  Broken in commit 4096974e.
> 
> Of course, if Kevin sends a v2 pull, it's probably better to just squash
> this in to my original testsuite change (since a v2 would probably
> invalidate that commit id).
> 

Whichever way you go,

Reviewed-by: John Snow <jsnow@redhat.com>

I don't know how important it is to nail this down, but the purpose of
this command is primarily for sanity testing and not necessarily between
architectures, so this might just be a limitation to document.

Also, don't use this for anything except testing.

:(
