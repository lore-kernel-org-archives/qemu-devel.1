Received: from eggs.gnu.org ([2001:4830:134:3::10]:60025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eqLk5-0001ZJ-96
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 11:35:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eqLk1-0003Ll-Bj
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 11:35:09 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <46083cc3-08b8-89ef-2b71-a6ecb9bbb594@redhat.com>
References: <20180222155922.9833-1-eblake@redhat.com>
	<20180222155922.9833-5-eblake@redhat.com>
	<w51371t56ys.fsf@maestria.local.igalia.com>
	<46083cc3-08b8-89ef-2b71-a6ecb9bbb594@redhat.com>
Date: Mon, 26 Feb 2018 17:35:02 +0100
Message-ID: <w51606jd809.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 4/4] qcow2: Avoid memory over-allocation
 on compressed images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Thu 22 Feb 2018 08:02:44 PM CET, Eric Blake wrote:
> On 02/22/2018 10:23 AM, Alberto Garcia wrote:
>> On Thu 22 Feb 2018 04:59:22 PM CET, Eric Blake wrote:
>>>           sector_offset = coffset & 511;
>>>           csize = nb_csectors * 512 - sector_offset;
>>             [...]
>>> +        assert(csize < 2 * s->cluster_size);
>> 
>> I think it should be <=
>> 
>> If sector_offset is 0 and nb_csector is the maximum allowed value then
>> csize is exactly 2 * s->cluster_size bytes.
>
> Sigh, yes you're right.  I was thinking that "qemu sets csize to a 
> maximum of s->cluster_size, but only when sector_offset is not 0" - but 
> as long as we're dealing with externally-produced images, sector_offset 
> can be 0 at the same time as providing all 1s to the field.  So I did 
> indeed have an off-by-one.
>
> Perhaps the maintainer can fix it up, instead of me spinning a v4?

That would work for me, but note that this part of the commit message
also needs to be updated:

   In fact, the qcow2 spec permits an all-ones sector count, plus 511
   bytes from the sector containing the initial offset, for a maximum
   read of nearly 2 full clusters;

With those two things corrected,

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
