Received: from eggs.gnu.org ([2001:4830:134:3::10]:49522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eorkP-0006BW-1n
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 09:21:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eorkL-0005Eq-2c
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 09:21:21 -0500
References: <20180221233953.5142-1-eblake@redhat.com>
	<20180221233953.5142-4-eblake@redhat.com>
	<w51h8q95mdf.fsf@maestria.local.igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <71e887af-9285-5abf-e932-34bad9d48184@redhat.com>
Date: Thu, 22 Feb 2018 08:21:10 -0600
MIME-Version: 1.0
In-Reply-To: <w51h8q95mdf.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/3] qcow2: Avoid memory over-allocation
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

On 02/22/2018 04:50 AM, Alberto Garcia wrote:
> On Thu 22 Feb 2018 12:39:53 AM CET, Eric Blake wrote:
>> +        assert(!!s->cluster_data == !!s->cluster_cache);
>> +        assert(csize < 2 * s->cluster_size + 512);
>>           if (!s->cluster_data) {
>> -            /* one more sector for decompressed data alignment */
>> -            s->cluster_data = qemu_try_blockalign(bs->file->bs,
>> -                    QCOW_MAX_CRYPT_CLUSTERS * s->cluster_size + 512);
>> +            s->cluster_data = g_try_malloc(2 * s->cluster_size + 512);
>>               if (!s->cluster_data) {
>>                   return -ENOMEM;
>>               }
> 
> Why the "+ 512" ?

I was thinking "number of sectors is up to two clusters, and we add one, 
PLUS we must read from the initial sector containing the offset".  But I 
was obviously not careful enough - the maximum value (all 1s) is 512 
bytes short of 2 full clusters, and we add at most 511 more bytes for 
the initial sector containing the offset (our +1 covers the leading 
sector).  So you are right, I can tighten this down for a slightly 
smaller allocation (and a nice power-of-2 allocation may be slightly 
more efficient as well).  v3 coming up.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
