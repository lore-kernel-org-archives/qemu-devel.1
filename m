Received: from eggs.gnu.org ([2001:4830:134:3::10]:48203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eRSqG-0002Jm-CR
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 20:06:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eRSqF-0000JX-7N
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 20:06:40 -0500
References: <20171113162053.58795-1-vsementsov@virtuozzo.com>
	<20171213041248.GB31040@lemon>
	<af98ffe7-71fb-0493-c4da-4b77a4c453f5@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <696c198b-e3d8-fab6-0128-de9ed34e4cff@redhat.com>
Date: Tue, 19 Dec 2017 20:06:24 -0500
MIME-Version: 1.0
In-Reply-To: <af98ffe7-71fb-0493-c4da-4b77a4c453f5@virtuozzo.com>
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
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, armbru@redhat.com, mnestratov@virtuozzo.com, mreitz@redhat.com, nshirokovskiy@virtuozzo.com, stefanha@redhat.com, den@openvz.org, pbonzini@redhat.com, dev@acronis.com



On 12/19/2017 11:07 AM, Vladimir Sementsov-Ogievskiy wrote:
> 13.12.2017 07:12, Fam Zheng wrote:
>> On Mon, 11/13 19:20, Vladimir Sementsov-Ogievskiy wrote:
>>> Hi all.
>>>
>>> There are three qmp commands, needed to implement external backup API=
.
>>>
>>> Using these three commands, client may do all needed bitmap
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
>>> Question: it may be better to make one command instead of two:
>>> block-dirty-bitmap-set-enabled(bool enabled)
>>>
>>> Vladimir Sementsov-Ogievskiy (4):
>>> =C2=A0=C2=A0 block/dirty-bitmap: add lock to bdrv_enable/disable_dirt=
y_bitmap
>>> =C2=A0=C2=A0 qapi: add block-dirty-bitmap-enable/disable
>>> =C2=A0=C2=A0 qmp: transaction support for block-dirty-bitmap-enable/d=
isable
>>> =C2=A0=C2=A0 qapi: add block-dirty-bitmap-merge
>>>
>>> =C2=A0 qapi/block-core.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 80 +++++++++++++++++++++++
>>> =C2=A0 qapi/transaction.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0 4 ++
>>> =C2=A0 include/block/dirty-bitmap.h |=C2=A0=C2=A0 2 +
>>> =C2=A0 block/dirty-bitmap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 21 ++++++
>>> =C2=A0 blockdev.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 151
>>> +++++++++++++++++++++++++++++++++++++++++++
>>> =C2=A0 5 files changed, 258 insertions(+)
>>>
>> I think tests are required to merge new features/commands.=C2=A0 Can w=
e
>> include tests
>> on these new code please?=C2=A0 We should cover error handling, and al=
so
>> write tests
>> that demonstrate the intended real world use cases.
>>
>> Also should we add new sections to docs/interop/bitmaps.rst?
>>
>> Meta: John started a long discussion about the API design but I think
>> after all
>> it turns out exposing dirty bitmap objects and the primitives is a
>> reasonable
>> approach to implement incremental backup functionalities. The comment
>> I have is
>> that we should ensure we have also reviewed it from a higher level
>> (e.g. all the
>> potential user requirements) to make sure this low level API is both
>> sound and
>> flexible. We shouldn't introduce a minimal set of low level commands
>> just to
>> support one particular use case, but look a bit further and broader
>> and come up
>> with a more complete design? Writing docs and tests might force us to
>> think in
>> this direction, which I think is a good thing to have for this series,
>> too.
>>
>> Fam
>=20
> Nikolay, please describe what do you plan in libvirt over qmp bitmap AP=
I.
>=20
> Kirill, what do you think about this all?
>=20
> (brief history:
> we are considering 3 new qmp commands for bitmap management, needed for
> external incremental backup support
> =C2=A0- enable (bitmap will track disk changes)
> =C2=A0- disable (bitmap will stop tracking changes)
> =C2=A0- merge (merge bitmap A to bitmap B)
> )
>=20

Yeah, it would be helpful to know what the full workflow for the API
will be ... before I get ahead of myself again (sorry) ...

but I'd like to see a quick writeup of your vision for the pull-mode
backups (which I assume this is for, right?) from start-to-finish, like
a mockup of annotated QMP output or something.

Nothing fancy, just something that lets me orient where we're headed,
since you're doing most of the work and I just want to get out of your
way, but having a roadmap helps me do that.

--js
