Received: from eggs.gnu.org ([2001:4830:134:3::10]:41374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fW71x-0003Wo-Jm
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 17:22:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fW71w-0001FN-SO
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 17:22:13 -0400
References: <20180613020613.1343-1-jsnow@redhat.com>
	<20180613020613.1343-4-jsnow@redhat.com>
	<f3332ec8-5370-fecc-b0ae-4834d0eb28b7@virtuozzo.com>
	<8df85931-08ab-d89d-5e26-10f5054a9357@redhat.com>
	<81a2a867-4dc7-3843-88cd-fb1809f8d23b@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <08309bb1-191e-61a2-e070-113fc3745142@redhat.com>
Date: Thu, 21 Jun 2018 17:22:04 -0400
MIME-Version: 1.0
In-Reply-To: <81a2a867-4dc7-3843-88cd-fb1809f8d23b@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 03/10] qcow2/bitmap: cache bm_list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>



On 06/21/2018 06:25 AM, Vladimir Sementsov-Ogievskiy wrote:
>>
> 
> agree. and this is one more reason to not load bitmaps in inactive mode
> at all. and drop them (after storing) on inactivating.
> I'll make a patch.

Sure. I guess persistent bitmaps that exist when BDRV_O_INACTIVE is set
need to stay around -- it would be strange if they disappeared just
because the bitmap is inactive -- but we need to effectively overwrite
them on reload from disk.

And while the disk is inactive, these bitmaps definitely need to remain
in an enforced readonly state (can't be deleted, renamed, cleared, set,
reset, etc.)

(I guess it would also be an error to try to remove persistence from a
bitmap on an inactive disk too.)
