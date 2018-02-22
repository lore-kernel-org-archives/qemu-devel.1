Received: from eggs.gnu.org ([2001:4830:134:3::10]:48570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eorh4-0003wX-4G
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 09:17:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eorh3-0002Wo-B0
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 09:17:54 -0500
References: <20180221233953.5142-1-eblake@redhat.com>
	<20180221233953.5142-3-eblake@redhat.com>
	<w51k1v55ncp.fsf@maestria.local.igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3d6368b1-53b4-a954-a489-e3873652d9e6@redhat.com>
Date: Thu, 22 Feb 2018 08:17:35 -0600
MIME-Version: 1.0
In-Reply-To: <w51k1v55ncp.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/3] qcow2: Don't allow overflow during
 cluster allocation
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

On 02/22/2018 04:29 AM, Alberto Garcia wrote:
> On Thu 22 Feb 2018 12:39:52 AM CET, Eric Blake wrote:
>>       free_in_cluster = s->cluster_size - offset_into_cluster(s, offset);
>>       do {
>>           if (!offset || free_in_cluster < size) {
>> -            int64_t new_cluster = alloc_clusters_noref(bs, s->cluster_size);
>> +            int64_t new_cluster;
>> +
>> +            new_cluster = alloc_clusters_noref(bs, s->cluster_size,
>> +                                               (1ULL << s->csize_shift) - 1);
> 
> (1ULL << s->csize_shift) - 1) is the same as s->cluster_offset_mask, but
> I guess it's confusing to use that here, so your approach looks
> appropriate.

Actually, s->cluster_offset_mask fits better - we want to ensure that 
the allocated cluster fits within the mask!  I'll adjust on respin.

> 
> Reviewed-by: Alberto Garcia <berto@igalia.com>

Thanks for bearing with me.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
