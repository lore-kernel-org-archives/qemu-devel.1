Received: from eggs.gnu.org ([2001:4830:134:3::10]:40383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eg8DE-0004Lr-4p
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 07:07:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eg8D9-00071S-FG
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 07:07:00 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1e32b96c-b65a-eba3-9d8e-7d0ec9bad741@redhat.com>
References: <cover.1516978645.git.berto@igalia.com>
	<7d8d80bfde60d29e8a0abe04db8241b754714329.1516978645.git.berto@igalia.com>
	<1e32b96c-b65a-eba3-9d8e-7d0ec9bad741@redhat.com>
Date: Mon, 29 Jan 2018 13:06:16 +0100
Message-ID: <w51d11syimf.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 30/39] qcow2: Update
 expand_zero_clusters_in_l1() to support L2 slices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

On Fri 26 Jan 2018 08:46:19 PM CET, Eric Blake wrote:
>> -                ret = qcow2_cache_get(bs, s->l2_table_cache, l2_offset,
>> -                                      (void **)&l2_table);
>> +                ret = qcow2_cache_get(bs, s->l2_table_cache, slice_offset,
>> +                                      (void **)&l2_slice);
>
> The (void **) cast is probably still necessary (anything can go to
> void*, but C gets pickier when going to void**), but...
>
>>              } else {
>>                  /* load inactive L2 tables from disk */
>> -                ret = bdrv_read(bs->file, l2_offset / BDRV_SECTOR_SIZE,
>> -                                (void *)l2_table, s->cluster_sectors);
>> +                ret = bdrv_pread(bs->file, slice_offset,
>> +                                 (void *)l2_slice, slice_size2);
>
> ...do we still need this cast to void*?
>
>
>>  
>> -                    ret = bdrv_write(bs->file, l2_offset / BDRV_SECTOR_SIZE,
>> -                                     (void *)l2_table, s->cluster_sectors);
>> +                    ret = bdrv_pwrite(bs->file, slice_offset,
>> +                                      (void *)l2_slice, slice_size2);
>
> and again here

Good idea, I'll remove the void * casts.

Berto
