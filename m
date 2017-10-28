Received: from eggs.gnu.org ([2001:4830:134:3::10]:33474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e8L3i-0007jN-IB
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 02:57:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e8L3f-00012D-Gr
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 02:57:30 -0400
Received: from mail-io0-x233.google.com ([2607:f8b0:4001:c06::233]:55809)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1e8L3f-0000za-B0
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 02:57:27 -0400
Received: by mail-io0-x233.google.com with SMTP id p186so17066284ioe.12
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 23:57:24 -0700 (PDT)
References: <f512ef4b-11ac-0cd2-0037-4608f2059669@ozlabs.ru>
	<d80a7e33-f055-d59e-8aff-2ed1f9a79c83@ozlabs.ru>
	<20171027071241.GA30326@localhost.localdomain>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <12b21c38-3d03-929b-aea0-7de5efe55d56@ozlabs.ru>
Date: Sat, 28 Oct 2017 17:57:18 +1100
MIME-Version: 1.0
In-Reply-To: <20171027071241.GA30326@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] iotest 194 fails on vhdx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On 27/10/17 18:12, Jeff Cody wrote:
> On Wed, Oct 25, 2017 at 05:06:37PM +1100, Alexey Kardashevskiy wrote:
>> On 25/10/17 15:29, Alexey Kardashevskiy wrote:
>>> Hi!
>>>
>>> The latest QEMU fails on:
>>> tests/qemu-iotests/check -vhdx 194
>>
>>
>> Bit more details:
>>
>> 1. the assert started appearing from
>> https://git.qemu.org/?p=qemu.git;a=commit;h=09e0c771e47 - this one just
>> added the assert;
>>
>> 2. if removed, then another assert alerts:
>> qemu-system-ppc64: /home/aik/p/qemu/block/io.c:1423: bdrv_aligned_pwritev:
>> Assertion `child->perm & BLK_PERM_WRITE' failed.
>>
>> child->perm == 1 when this happens.
>>
>> Any clues?
>>
> 
> Yes - what is happening is that if the VHDX image file is open RDWR, we
> update the VHDX header.  However, since we are INMIGRATE, the
> underlying file bs is marked as INACTIVE, and we are caught by the assert.
> 
> 
> However, per the spec the header file and data guids only need to be updated
> before the first modification is made.  We already have a latching call to
> update the headers on the first write to the VHDX image (in vhdx_co_writev),
> so the call to vhdx_update_headers() in vhdx_open() is a bug, and can be
> removed.
> 
> Once that is fixed, 194 still fails for VHDX, but it doesn't crash.  The
> failure is expected, because VHDX does not support migration (VMDK fails the
> same way). 

Probably a very ignorant question but how can an image format not support
migration at all? Is not it simple writing blocks, one-by-one? Thanks.


> So test 194 should also be updated to exclude image formats that
> set migration blockers.
> 
> (Patches sent)
-- 
Alexey
