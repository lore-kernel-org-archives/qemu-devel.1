Received: from eggs.gnu.org ([2001:4830:134:3::10]:36457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eRZbs-00020Z-8d
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 03:20:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eRZbn-0002zS-Uc
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 03:20:16 -0500
References: <20171113162053.58795-1-vsementsov@virtuozzo.com>
	<20171213041248.GB31040@lemon>
	<af98ffe7-71fb-0493-c4da-4b77a4c453f5@virtuozzo.com>
	<696c198b-e3d8-fab6-0128-de9ed34e4cff@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <d5df7e51-fe6b-da89-9bf1-9b03c1afdd67@virtuozzo.com>
Date: Wed, 20 Dec 2017 11:20:00 +0300
MIME-Version: 1.0
In-Reply-To: <696c198b-e3d8-fab6-0128-de9ed34e4cff@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH for-2.12 0/4] qmp dirty bitmap API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, armbru@redhat.com, mnestratov@virtuozzo.com, mreitz@redhat.com, nshirokovskiy@virtuozzo.com, stefanha@redhat.com, den@openvz.org, pbonzini@redhat.com, dev@acronis.com

20.12.2017 04:06, John Snow wrote:
>
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
>>>>  =C2=A0 {disable old bitmap, create new bitmap}
>>>>
>>>> on backup success:
>>>>  =C2=A0 drop old bitmap
>>>>
>>>> on backup fail:
>>>>  =C2=A0 enable old bitmap
>>>>  =C2=A0 merge new bitmap to old bitmap
>>>>  =C2=A0 drop new bitmap
>>>>
>>>> Question: it may be better to make one command instead of two:
>>>> block-dirty-bitmap-set-enabled(bool enabled)
>>>>
>>>> Vladimir Sementsov-Ogievskiy (4):
>>>>  =C2=A0=C2=A0 block/dirty-bitmap: add lock to bdrv_enable/disable_dirt=
y_bitmap
>>>>  =C2=A0=C2=A0 qapi: add block-dirty-bitmap-enable/disable
>>>>  =C2=A0=C2=A0 qmp: transaction support for block-dirty-bitmap-enable/d=
isable
>>>>  =C2=A0=C2=A0 qapi: add block-dirty-bitmap-merge
>>>>
>>>>  =C2=A0 qapi/block-core.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 80 +++++++++++++++++++++++
>>>>  =C2=A0 qapi/transaction.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 4 ++
>>>>  =C2=A0 include/block/dirty-bitmap.h |=C2=A0=C2=A0 2 +
>>>>  =C2=A0 block/dirty-bitmap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 21 ++++++
>>>>  =C2=A0 blockdev.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 151
>>>> +++++++++++++++++++++++++++++++++++++++++++
>>>>  =C2=A0 5 files changed, 258 insertions(+)
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
>> Nikolay, please describe what do you plan in libvirt over qmp bitmap API=
.
>>
>> Kirill, what do you think about this all?
>>
>> (brief history:
>> we are considering 3 new qmp commands for bitmap management, needed for
>> external incremental backup support
>>  =C2=A0- enable (bitmap will track disk changes)
>>  =C2=A0- disable (bitmap will stop tracking changes)
>>  =C2=A0- merge (merge bitmap A to bitmap B)
>> )
>>
> Yeah, it would be helpful to know what the full workflow for the API
> will be ... before I get ahead of myself again (sorry) ...
>
> but I'd like to see a quick writeup of your vision for the pull-mode
> backups (which I assume this is for, right?) from start-to-finish, like
> a mockup of annotated QMP output or something.
>
> Nothing fancy, just something that lets me orient where we're headed,
> since you're doing most of the work and I just want to get out of your
> way, but having a roadmap helps me do that.
>
> --js

external backup:

0. we have active_disk and attached to it dirty bitmap bitmap0
1. qmp blockdev-add tmp_disk (backing=3Dactive_disk)
2. guest fsfreeze
3. qmp transaction:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - block-dirty-bitmap-add node=
=3Dactive_disk name=3Dbitmap1
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - block-dirty-bitmap-disable no=
de=3Dactive_disk name=3Dbitmap0
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - blockdev-backup drive=3Dactiv=
e_disk target=3Dtmp_disk sync=3Dnone
4. guest fsthaw
5. (? not designed yet) qmp blockdev-add filter_node - special filter=20
node over tmp_disk for synchronization of nbd-reads and=20
backup(sync=3Dnone) cow requests (like it is done in block/replication)
6. qmp nbd-server-start
7. qmp nbd-server-add filter_node (there should be possibility of=20
exporting bitmap of child node filter_node->tmp_disk->active_disk->bitmap0)

then, external tool can connect to nbd server and get exported bitmap=20
and read data (including bitmap0) accordingly to nbd specification.
(also, external tool may get a merge of several bitmaps, if we already=20
have a sequence of them)
then, after backup finish, what can be done:

1. qmp block-job-cancel device=3Dactive_disk (stop our backup(sync=3Dnone))
2. qmp nbd-server-stop (or qmp nbd-server-remove filter_node)
3. qmp blockdev-remove filter_node
4. qmp blockdev-remove tmp_disk

on successful backup, you can drop old bitmap if you want (or do not=20
drop it, if you need to keep sequence of disabled bitmaps):
1. block-dirty-bitmap-remove node=3Dactive_disk name=3Dbitmap0

on failed backup, you can merge bitmaps, to make it look like nothing=20
happened:
1. qmp transaction:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - block-dirty-bitmap-merge node=3Dact=
ive_disk name-source=3Dbitmap1=20
name-target=3Dbitmap0
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - block-dirty-bitmap-remove node=3Dac=
tive_disk name=3Dbitmap1
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - block-dirty-bitmap-enable node=3Dac=
tive_disk name=3Dbitmap0

--=20
Best regards,
Vladimir
