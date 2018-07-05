Received: from eggs.gnu.org ([2001:4830:134:3::10]:36975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fb9Pm-0002c9-3y
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 14:55:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fb9Pl-0008Qo-Fp
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 14:55:38 -0400
References: <20180703105305.45398-1-vsementsov@virtuozzo.com>
	<20180703105305.45398-2-vsementsov@virtuozzo.com>
	<d7e510dc-c6f6-3d5b-b716-0df88759440c@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <41a9ce0d-fae5-1f6b-8492-0e64feda4d68@redhat.com>
Date: Thu, 5 Jul 2018 13:55:27 -0500
MIME-Version: 1.0
In-Reply-To: <d7e510dc-c6f6-3d5b-b716-0df88759440c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] drity-bitmap: refactor merge: separte
 can_merge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, famz@redhat.com, armbru@redhat.com, mreitz@redhat.com

On 07/05/2018 01:51 PM, John Snow wrote:

> 
>> -    assert(!bdrv_dirty_bitmap_readonly(dest));
>> -
>> -    if (!hbitmap_merge(dest->bitmap, src->bitmap)) {
>> -        error_setg(errp, "Bitmaps are incompatible and can't be merged");
>> +    if (bdrv_can_merge_dirty_bitmap(dest, src, errp)) {
>> +        bool ret = hbitmap_merge(dest->bitmap, src->bitmap);
>> +        assert(ret);
> 
> Might as well just assert(hbitmap_merge(...));

Except that side effects inside assert() are bad programming practice, 
even if in qemu assert()s are guaranteed to always be enabled by osdep.h.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
