Received: from eggs.gnu.org ([2001:4830:134:3::10]:59399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gWLJM-00050J-4s
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 08:09:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gWLJG-0007Uh-Qd
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 08:09:24 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1544176849-899477-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<5c525644-cc38-9d0b-c591-6d75315e25cc@redhat.com>
	<49356a26-c25a-2159-de5d-48fccba6af33@virtuozzo.com>
Date: Mon, 10 Dec 2018 14:08:58 +0100
In-Reply-To: <49356a26-c25a-2159-de5d-48fccba6af33@virtuozzo.com> (Andrey
	Shinkevich's message of "Mon, 10 Dec 2018 12:12:38 +0000")
Message-ID: <8736r5h6l1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4] qemu-img info lists bitmap directory
 entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Cc: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "kwolf@redhat.com" <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Denis Lunev <den@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>, John Snow <jsnow@redhat.com>

Please don't use "Content-Transfer-Encoding: base64".

Andrey Shinkevich <andrey.shinkevich@virtuozzo.com> writes:

> On 07.12.2018 19:20, Eric Blake wrote:
>
>> On 12/7/18 4:00 AM, Andrey Shinkevich wrote:
[...]
>>> +++ b/block/qcow2.c
>>> @@ -4270,6 +4270,12 @@ static ImageInfoSpecific=20
>>> *qcow2_get_specific_info(BlockDriverState *bs)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 .refcount_bits=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D s->refcount_bits,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (s->qcow_version =3D=3D 3) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Qcow2BitmapInfoList *bitmap=
s;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error *local_err =3D NULL;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bitmaps =3D qcow2_get_bitma=
p_info_list(bs, &local_err);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (local_err !=3D NULL) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err=
or_report_err(local_err);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> Ouch. Calling error_report_err() doesn't always work in QMP context;=20
>> better would be to plumb Error **errp back up to the caller, if=20
>> getting this specific information can fail and we want the overall=20
>> query-block to fail.=C2=A0 Or, we could decide that failure to get bitma=
p=20
>> info is non-fatal, and that it was just a best-effort attempt to get=20
>> more info, where we then ignore the failure, rather than trying to=20
>> report it incorrectly.
> In my test environment, error_report_err() and warn_report_err() both=20
> cause printing an error message as the only output of 'qemu-img info'=20
> command.

Eric is right, using error_report() & friends in QMP context is almost
always wrong.  Here's the issue in a bit more detail.  Consider QMP
command query-block.  Reverse call stack:

    qmp_query_block()
    bdrv_query_info()
    bdrv_block_device_info()
    bdrv_query_image_info()
    bdrv_get_specific_info()
    qcow2_get_specific_info()

The error you report in qcow2_get_specific_info() gets reported to
stderr.  It is *not* reported to the QMP client.  Why is that a good
idea?

[...]
