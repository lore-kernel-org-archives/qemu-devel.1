Received: from eggs.gnu.org ([2001:4830:134:3::10]:37439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cegzQ-0000VI-MD
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 06:46:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cegzP-00084R-VA
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 06:46:16 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:21963 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cegzP-00083N-Je
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 06:46:15 -0500
References: <1487153430-17260-1-git-send-email-vsementsov@virtuozzo.com>
	<1487153430-17260-9-git-send-email-vsementsov@virtuozzo.com>
	<20170216112506.GB4869@noname.redhat.com>
	<20170216114944.GD4869@noname.redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <8d7a5d17-7b1b-578a-67fc-c79beb196a4c@virtuozzo.com>
Date: Fri, 17 Feb 2017 14:46:03 +0300
MIME-Version: 1.0
In-Reply-To: <20170216114944.GD4869@noname.redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v15 08/25] block: introduce auto-loading
 bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

16.02.2017 14:49, Kevin Wolf wrote:
> Am 16.02.2017 um 12:25 hat Kevin Wolf geschrieben:
>> Am 15.02.2017 um 11:10 hat Vladimir Sementsov-Ogievskiy geschrieben:
>>> Auto loading bitmaps are bitmaps stored in the disk image, which should
>>> be loaded when the image is opened and become BdrvDirtyBitmaps for the
>>> corresponding drive.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> Reviewed-by: John Snow <jsnow@redhat.com>
>>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>> Why do we need a new BlockDriver callback and special code for it in
>> bdrv_open_common()? The callback is only ever called immediately after
>> .bdrv_open/.bdrv_file_open, so can't the drivers just do this internally
>> in their .bdrv_open implementation? Even more so because qcow2 is the
>> only driver that supports this callback.
> Actually, don't we have to call this in qcow2_invalidate_cache()?
> Currently, I think, after a migration, the autoload bitmaps aren't
> loaded.
>
> By moving the qcow2_load_autoloading_dirty_bitmaps() call to
> qcow2_open(), this would be fixed.
>
> Kevin

Bitmap should not be reloaded on any intermediate qcow2-open's, reopens, 
etc. It should be loaded once, on bdrv_open, to not create extra 
collisions (between in-memory bitmap and it's stored version). That was 
the idea.

For bitmaps migration there are separate series, we shouldn't load 
bitmap from file on migration, as it's version in the file is outdated.

,

-- 
Best regards,
Vladimir
