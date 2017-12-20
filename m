Received: from eggs.gnu.org ([2001:4830:134:3::10]:48599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nshirokovskiy@virtuozzo.com>) id 1eRZNm-0005qy-Nq
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 03:05:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nshirokovskiy@virtuozzo.com>) id 1eRZNl-0008Je-DO
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 03:05:42 -0500
References: <20171113162053.58795-1-vsementsov@virtuozzo.com>
	<20171213041248.GB31040@lemon>
	<af98ffe7-71fb-0493-c4da-4b77a4c453f5@virtuozzo.com>
	<696c198b-e3d8-fab6-0128-de9ed34e4cff@redhat.com>
From: Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>
Message-ID: <0091975c-12b6-f0e3-b403-a6a238f4227e@virtuozzo.com>
Date: Wed, 20 Dec 2017 11:05:26 +0300
MIME-Version: 1.0
In-Reply-To: <696c198b-e3d8-fab6-0128-de9ed34e4cff@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12 0/4] qmp dirty bitmap API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, armbru@redhat.com, mnestratov@virtuozzo.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, pbonzini@redhat.com, dev@acronis.com



On 20.12.2017 04:06, John Snow wrote:
>=20
>=20
> On 12/19/2017 11:07 AM, Vladimir Sementsov-Ogievskiy wrote:
>> 13.12.2017 07:12, Fam Zheng wrote:
>>> On Mon, 11/13 19:20, Vladimir Sementsov-Ogievskiy wrote:
>>>> Hi all.
>>>>
>>>> There are three qmp commands, needed to implement external backup API.
>>>>
>>>> Using these three commands, client may do all needed bitmap
>>>> management by
>>>> hand:
>>>>
>>>> on backup start we need to do a transaction:
>>>> =C2=A0 {disable old bitmap, create new bitmap}
>>>>
>>>> on backup success:
>>>> =C2=A0 drop old bitmap
>>>>
>>>> on backup fail:
>>>> =C2=A0 enable old bitmap
>>>> =C2=A0 merge new bitmap to old bitmap
>>>> =C2=A0 drop new bitmap
>>>>
>>>> Question: it may be better to make one command instead of two:
>>>> block-dirty-bitmap-set-enabled(bool enabled)
>>>>
>>>> Vladimir Sementsov-Ogievskiy (4):
>>>> =C2=A0=C2=A0 block/dirty-bitmap: add lock to bdrv_enable/disable_dirty=
_bitmap
>>>> =C2=A0=C2=A0 qapi: add block-dirty-bitmap-enable/disable
>>>> =C2=A0=C2=A0 qmp: transaction support for block-dirty-bitmap-enable/di=
sable
>>>> =C2=A0=C2=A0 qapi: add block-dirty-bitmap-merge
>>>>
>>>> =C2=A0 qapi/block-core.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 80 +++++++++++++++++++++++
>>>> =C2=A0 qapi/transaction.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0 4 ++
>>>> =C2=A0 include/block/dirty-bitmap.h |=C2=A0=C2=A0 2 +
>>>> =C2=A0 block/dirty-bitmap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 21 ++++++
>>>> =C2=A0 blockdev.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 151
>>>> +++++++++++++++++++++++++++++++++++++++++++
>>>> =C2=A0 5 files changed, 258 insertions(+)
>>>>
>>> I think tests are required to merge new features/commands.=C2=A0 Can we
>>> include tests
>>> on these new code please?=C2=A0 We should cover error handling, and als=
o
>>> write tests
>>> that demonstrate the intended real world use cases.
>>>
>>> Also should we add new sections to docs/interop/bitmaps.rst?
>>>
>>> Meta: John started a long discussion about the API design but I think
>>> after all
>>> it turns out exposing dirty bitmap objects and the primitives is a
>>> reasonable
>>> approach to implement incremental backup functionalities. The comment
>>> I have is
>>> that we should ensure we have also reviewed it from a higher level
>>> (e.g. all the
>>> potential user requirements) to make sure this low level API is both
>>> sound and
>>> flexible. We shouldn't introduce a minimal set of low level commands
>>> just to
>>> support one particular use case, but look a bit further and broader
>>> and come up
>>> with a more complete design? Writing docs and tests might force us to
>>> think in
>>> this direction, which I think is a good thing to have for this series,
>>> too.
>>>
>>> Fam
>>
>> Nikolay, please describe what do you plan in libvirt over qmp bitmap API=
.
>>
>> Kirill, what do you think about this all?
>>
>> (brief history:
>> we are considering 3 new qmp commands for bitmap management, needed for
>> external incremental backup support
>> =C2=A0- enable (bitmap will track disk changes)
>> =C2=A0- disable (bitmap will stop tracking changes)
>> =C2=A0- merge (merge bitmap A to bitmap B)
>> )
>>
>=20
> Yeah, it would be helpful to know what the full workflow for the API
> will be ... before I get ahead of myself again (sorry) ...
>=20
> but I'd like to see a quick writeup of your vision for the pull-mode
> backups (which I assume this is for, right?) from start-to-finish, like
> a mockup of annotated QMP output or something.
>=20
> Nothing fancy, just something that lets me orient where we're headed,
> since you're doing most of the work and I just want to get out of your
> way, but having a roadmap helps me do that.
>=20
> --js
>=20

Hi, all.

In terms of API we want to be able to create an incremental backup
from any previous backup. But as in qemu it does cost a bitmap for every
point in time we want to do incremental backup from we plan to keep
only limited number of such checkpoints. Like last N checkpoints I guess.
So there will be an API to delete checkpoint as well.

In terms of implementations Vladimir already described usage of disable/ena=
ble/
merge commands in [1] for both creation and deletion API.=20

There is also a RFC [2] in libvirt list which described in more detail
libvirt API.

[1] http://lists.nongnu.org/archive/html/qemu-devel/2017-12/msg01099.html
[2] https://www.redhat.com/archives/libvir-list/2017-November/msg00514.html
