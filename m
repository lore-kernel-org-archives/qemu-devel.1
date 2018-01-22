Received: from eggs.gnu.org ([2001:4830:134:3::10]:58029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1edb84-0002Mo-R2
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 07:23:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1edb83-0001aO-GE
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 07:23:12 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20180116125427.18540-1-vsementsov@virtuozzo.com>
	<8cb52056-e57c-ec72-60a1-adc41f21b9c3@redhat.com>
	<d64cd344-bbcb-a088-f74d-a3e5446085f4@virtuozzo.com>
Message-ID: <ea632dcf-28f5-5f33-e22f-db7e622da823@virtuozzo.com>
Date: Mon, 22 Jan 2018 15:22:50 +0300
MIME-Version: 1.0
In-Reply-To: <d64cd344-bbcb-a088-f74d-a3e5446085f4@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 0/6] qmp dirty bitmap API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com, mnestratov@virtuozzo.com, mreitz@redhat.com, nshirokovskiy@virtuozzo.com, den@openvz.org

22.01.2018 12:20, Vladimir Sementsov-Ogievskiy wrote:
> 20.01.2018 02:30, John Snow wrote:
>>
>> On 01/16/2018 07:54 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> Hi all.
>>>
>>> There are three qmp commands, needed to implement external backup API.
>>>
>>> Using these three commands, client may do all needed bitmap=20
>>> management by
>>> hand:
>>>
>>> on backup start we need to do a transaction:
>>> =C2=A0 {disable old bitmap, create new bitmap}
>>>
>>> on backup success:
>>> =C2=A0 drop old bitmap
>>>
>>> on backup fail:
>>> =C2=A0 enable old bitmap
>>> =C2=A0 merge new bitmap to old bitmap
>>> =C2=A0 drop new bitmap
>>>
>>> v2: fix merge command deadlock
>>> =C2=A0=C2=A0 add new patches: 1 and 6
>>>
>>> Vladimir Sementsov-Ogievskiy (6):
>>> =C2=A0=C2=A0 block: maintain persistent disabled bitmaps
>>> =C2=A0=C2=A0 block/dirty-bitmap: add lock to bdrv_enable/disable_dirty_=
bitmap
>>> =C2=A0=C2=A0 qapi: add block-dirty-bitmap-enable/disable
>>> =C2=A0=C2=A0 qmp: transaction support for block-dirty-bitmap-enable/dis=
able
>>> =C2=A0=C2=A0 qapi: add block-dirty-bitmap-merge
>>> =C2=A0=C2=A0 qapi: add disabled parameter to block-dirty-bitmap-add
>>>
>>> =C2=A0 qapi/block-core.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 92 ++++++++++++++++++++++-
>>> =C2=A0 qapi/transaction.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
|=C2=A0=C2=A0 4 +
>>> =C2=A0 block/qcow2.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
>>> =C2=A0 include/block/dirty-bitmap.h |=C2=A0=C2=A0 3 +-
>>> =C2=A0 block/dirty-bitmap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 42 ++++++-----
>>> =C2=A0 block/qcow2-bitmap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 12 +--
>>> =C2=A0 block/qcow2.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
>>> =C2=A0 blockdev.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 169=20
>>> +++++++++++++++++++++++++++++++++++++++++--
>>> =C2=A0 8 files changed, 287 insertions(+), 39 deletions(-)
>>>
>> Fails to apply to master (b384cd95) on patch four and five. Only
>> contextual problems, I've patched it up and I'll review that.
>>
>> (mirrored here if you want to check my rebase work:
>> https://github.com/jnsnow/qemu/tree/vlad-review)
>>
>> Since I was full of such bad and stupid ideas last time, I'd like
>> someone else to look over this one for design and I'll just review it
>> for accuracy.
>>
>> --js
>
> Thank you for review, John!
>
> Ok, so, I'll going to:
>
> - take patch 1 into migration and respin it today (I hope) with test=20
> about qcow2-based bitmap migration disabled.
> - separate fixes and refactoring from here (locking + _bitmap_clear=20
> transaction), send them separately
> - than, make test for external backup and respin these series with it
>

changed to:

1. send patch 1/6 separately with the whole reasoning[done], as it=20
blocks two series, wait for accepting
2. respin postcopy series
3. finish up discussion on bitmap locking under "[PATCH v9 03/13]=20
block/dirty-bitmap: add _locked version of bdrv_reclaim_dirty_bitmap"
4. separate fixes and refactoring from here (locking + _bitmap_clear=20
transaction), send them separately
5. make test for external backup and respin these series with it

2 depends on 1
4 depends on 3
5 depends on 1 and 4

--=20
Best regards,
Vladimir
