Received: from eggs.gnu.org ([2001:4830:134:3::10]:35912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gXBKt-00084F-PQ
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 15:42:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gXBKq-0005ec-0b
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 15:42:26 -0500
References: <20180917145732.48590-1-vsementsov@virtuozzo.com>
	<504d170c-56ee-0cf5-78e0-47aded4c132f@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <43def1dd-732e-a358-d15f-492eefae0a80@redhat.com>
Date: Wed, 12 Dec 2018 15:41:58 -0500
MIME-Version: 1.0
In-Reply-To: <504d170c-56ee-0cf5-78e0-47aded4c132f@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] ping2 Re: [PATCH v4 0/8] dirty-bitmap: rewrite
 bdrv_dirty_iter_next_area
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "famz@redhat.com" <famz@redhat.com>, Denis Lunev <den@virtuozzo.com>, "jcody@redhat.com" <jcody@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>



On 12/12/18 4:27 AM, Vladimir Sementsov-Ogievskiy wrote:
> ping. No dependencies, apply to master.
>=20

Sure thing.

Staged to jsnow/bitmaps.

--js

> 17.09.2018 17:57, Vladimir Sementsov-Ogievskiy wrote:
>> Hi all.
>>
>> 1. bdrv_dirty_iter_next_area don't use hbitmap_next_zero and uses
>> inefficient loop instead. Let's improve it.
>>
>> 2. bdrv_dirty_iter_next_area don't handle unaligned offset and
>> max_offset correctly. I'm not sure that it is a real bug. But if it is=
,
>> we need these series in 3.0.
>>
>> Details are in 05 commit message.
>>
>> Note: "[PATCH] nbd/server: fix bitmap export" should be applied first:
>> Based-on: <20180914165116.23182-1-vsementsov@virtuozzo.com>
>>
>> v4:
>>
>> Rework: switch interface to start,count / offset,bytes style.
>> Fix wrong handling of the case when requested region end exceeds
>> overall bitmap end.
>> Some other changes.
>>
>> 06-08: add John's r-b.
>>
>> v3:
>> 01: - change interface to start/end, and -1 as special end-marker inst=
ead of 0
>>      - "not found" for invalid regions instead of assert
>> 02: rebase on 01 changes
>> 03: - fix mistake in hbitmap_iter_init arguments (mistake in
>>        hbitmap_next_zero arguments is fixed automatically due to 01 ch=
anges)
>> 04: new
>>
>>
>> v2:
>>
>> 01: - improve comment
>>      - s/bytes/count/
>>      - fix forgotten function call in test
>>      - introduce orig_size field here for HBitmap,
>>        make checking in hbitmap_next_zero more effective and safe
>> 02: new
>> 03: - orig_size already introduced in 01
>>      - fix hbitmap_next_dirty_area to not return value less than
>>        offset on unaligned requests
>>
>> Vladimir Sementsov-Ogievskiy (8):
>>    dirty-bitmap: improve bdrv_dirty_bitmap_next_zero
>>    tests: add tests for hbitmap_next_zero with specified end parameter
>>    dirty-bitmap: add bdrv_dirty_bitmap_next_dirty_area
>>    tests: add tests for hbitmap_next_dirty_area
>>    block/mirror: fix and improve do_sync_target_write
>>    Revert "block/dirty-bitmap: Add bdrv_dirty_iter_next_area"
>>    Revert "test-hbitmap: Add non-advancing iter_next tests"
>>    Revert "hbitmap: Add @advance param to hbitmap_iter_next()"
>>
>>   include/block/dirty-bitmap.h |   7 +-
>>   include/qemu/hbitmap.h       |  31 ++++--
>>   block/backup.c               |   5 +-
>>   block/dirty-bitmap.c         |  68 ++------------
>>   block/mirror.c               |  17 ++--
>>   nbd/server.c                 |   2 +-
>>   tests/test-hbitmap.c         | 177 +++++++++++++++++++++++++++++----=
--
>>   util/hbitmap.c               |  76 ++++++++++++---
>>   8 files changed, 262 insertions(+), 121 deletions(-)
>>
>=20
>=20

--=20
=E2=80=94js
