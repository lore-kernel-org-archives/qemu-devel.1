Received: from eggs.gnu.org ([209.51.188.92]:59283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gvrBL-0006GZ-FA
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 17:14:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gvrBJ-0001qV-CX
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 17:14:35 -0500
References: <20190213232356.21034-1-jsnow@redhat.com>
	<20190213232356.21034-5-jsnow@redhat.com>
	<957f3ab5-d5b7-b44d-9bc5-89a4ff78d87f@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <8a4a7f65-d538-f51d-83e6-927f3aff3c22@redhat.com>
Date: Mon, 18 Feb 2019 17:13:16 -0500
MIME-Version: 1.0
In-Reply-To: <957f3ab5-d5b7-b44d-9bc5-89a4ff78d87f@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 4/6] block/dirty-bitmap: explicitly lock
 bitmaps with successors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>, "libvir-list@redhat.com" <libvir-list@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>



On 2/18/19 11:52 AM, Vladimir Sementsov-Ogievskiy wrote:
> 14.02.2019 2:23, John Snow wrote:
>> Instead of implying a locked status, make it explicit.
> 
> locked interferes with bitmap mutex, so may be better "qmp_locked state", but not sure.
> 

I agree that "locked" has too many meanings, so in patch 5 I start using
the term "busy" instead.

>> Now, bitmaps in use by migration, NBD or backup operations
>> are all treated the same way with the same code paths.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 
> Hmm. Isn't it better to make successor-related staff unrelated to locking at all?

Maybe -- but it doesn't make sense to allow users to modify bitmaps that
have a successor because we know it's definitely busy. I'll take a
further cleanup patch if you think it's better -- just be careful to
make sure that any interface calls will work gracefully with a bitmap
with a successor.

> So, backup will call set_qmp_locked like others? And then do create_successor,
> abdicate, reclaim, whatever it wants, and finally set_qmp_locked(false) ?
> To make it work even more in the same path. But it may be done separately, if we
> want.
> 
