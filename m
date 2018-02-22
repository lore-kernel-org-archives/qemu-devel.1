Received: from eggs.gnu.org ([2001:4830:134:3::10]:58514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eow8p-0007PF-1s
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 14:02:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eow8o-0000n2-D6
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 14:02:51 -0500
References: <20180222155922.9833-1-eblake@redhat.com>
	<20180222155922.9833-5-eblake@redhat.com>
	<w51371t56ys.fsf@maestria.local.igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <46083cc3-08b8-89ef-2b71-a6ecb9bbb594@redhat.com>
Date: Thu, 22 Feb 2018 13:02:44 -0600
MIME-Version: 1.0
In-Reply-To: <w51371t56ys.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 02/22/2018 10:23 AM, Alberto Garcia wrote:
> On Thu 22 Feb 2018 04:59:22 PM CET, Eric Blake wrote:
>>           sector_offset = coffset & 511;
>>           csize = nb_csectors * 512 - sector_offset;
>             [...]
>> +        assert(csize < 2 * s->cluster_size);
> 
> I think it should be <=
> 
> If sector_offset is 0 and nb_csector is the maximum allowed value then
> csize is exactly 2 * s->cluster_size bytes.

Sigh, yes you're right.  I was thinking that "qemu sets csize to a 
maximum of s->cluster_size, but only when sector_offset is not 0" - but 
as long as we're dealing with externally-produced images, sector_offset 
can be 0 at the same time as providing all 1s to the field.  So I did 
indeed have an off-by-one.

Perhaps the maintainer can fix it up, instead of me spinning a v4?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
