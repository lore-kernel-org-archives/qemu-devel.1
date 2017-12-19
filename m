Received: from eggs.gnu.org ([2001:4830:134:3::10]:56747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eRKQh-0004ud-0u
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 11:07:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eRKQf-0003KM-Ts
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 11:07:43 -0500
References: <20171113162053.58795-1-vsementsov@virtuozzo.com>
	<20171213041248.GB31040@lemon>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <af98ffe7-71fb-0493-c4da-4b77a4c453f5@virtuozzo.com>
Date: Tue, 19 Dec 2017 19:07:29 +0300
MIME-Version: 1.0
In-Reply-To: <20171213041248.GB31040@lemon>
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
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, armbru@redhat.com, mnestratov@virtuozzo.com, mreitz@redhat.com, nshirokovskiy@virtuozzo.com, stefanha@redhat.com, den@openvz.org, pbonzini@redhat.com, jsnow@redhat.com, dev@acronis.com

13.12.2017 07:12, Fam Zheng wrote:
> On Mon, 11/13 19:20, Vladimir Sementsov-Ogievskiy wrote:
>> Hi all.
>>
>> There are three qmp commands, needed to implement external backup API.
>>
>> Using these three commands, client may do all needed bitmap management b=
y
>> hand:
>>
>> on backup start we need to do a transaction:
>>   {disable old bitmap, create new bitmap}
>>
>> on backup success:
>>   drop old bitmap
>>
>> on backup fail:
>>   enable old bitmap
>>   merge new bitmap to old bitmap
>>   drop new bitmap
>>
>> Question: it may be better to make one command instead of two:
>> block-dirty-bitmap-set-enabled(bool enabled)
>>
>> Vladimir Sementsov-Ogievskiy (4):
>>    block/dirty-bitmap: add lock to bdrv_enable/disable_dirty_bitmap
>>    qapi: add block-dirty-bitmap-enable/disable
>>    qmp: transaction support for block-dirty-bitmap-enable/disable
>>    qapi: add block-dirty-bitmap-merge
>>
>>   qapi/block-core.json         |  80 +++++++++++++++++++++++
>>   qapi/transaction.json        |   4 ++
>>   include/block/dirty-bitmap.h |   2 +
>>   block/dirty-bitmap.c         |  21 ++++++
>>   blockdev.c                   | 151 +++++++++++++++++++++++++++++++++++=
++++++++
>>   5 files changed, 258 insertions(+)
>>
> I think tests are required to merge new features/commands.  Can we includ=
e tests
> on these new code please?  We should cover error handling, and also write=
 tests
> that demonstrate the intended real world use cases.
>
> Also should we add new sections to docs/interop/bitmaps.rst?
>
> Meta: John started a long discussion about the API design but I think aft=
er all
> it turns out exposing dirty bitmap objects and the primitives is a reason=
able
> approach to implement incremental backup functionalities. The comment I h=
ave is
> that we should ensure we have also reviewed it from a higher level (e.g. =
all the
> potential user requirements) to make sure this low level API is both soun=
d and
> flexible. We shouldn't introduce a minimal set of low level commands just=
 to
> support one particular use case, but look a bit further and broader and c=
ome up
> with a more complete design? Writing docs and tests might force us to thi=
nk in
> this direction, which I think is a good thing to have for this series, to=
o.
>
> Fam

Nikolay, please describe what do you plan in libvirt over qmp bitmap API.

Kirill, what do you think about this all?

(brief history:
we are considering 3 new qmp commands for bitmap management, needed for
external incremental backup support
 =C2=A0- enable (bitmap will track disk changes)
 =C2=A0- disable (bitmap will stop tracking changes)
 =C2=A0- merge (merge bitmap A to bitmap B)
)

--=20
Best regards,
Vladimir
