Received: from eggs.gnu.org ([2001:4830:134:3::10]:41319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eFUdk-0001Hp-Ro
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 19:36:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eFUdk-00058l-7P
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 19:36:16 -0500
References: <20171030163309.75770-1-vsementsov@virtuozzo.com>
	<20171030163309.75770-11-vsementsov@virtuozzo.com>
	<97084802-ba48-4bc0-f106-dbeb906fd6e4@redhat.com>
	<8d68daea-955b-21e6-3f14-1daef683651d@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <661343f3-3971-ae6f-670d-3c07cdaf34eb@redhat.com>
Date: Thu, 16 Nov 2017 19:36:07 -0500
MIME-Version: 1.0
In-Reply-To: <8d68daea-955b-21e6-3f14-1daef683651d@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 10/14] migration: add postcopy migration
 of dirty bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Peter Lieven <pl@kamp.de>



On 11/16/2017 05:24 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> +=C2=A0=C2=A0=C2=A0 /* if a block is zero we need to flush here since=
 the network
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * bandwidth is now a lot higher than the st=
orage device bandwidth.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * thus if we queue zero blocks we slow down=
 the migration. */
>> Can you elaborate on this for me?
>=20
> it comes from migration/block.c, as it was a prototype for dirty bitmap=
s
> migration.
> May be the original thought was to give destination storage more time t=
o
> handle
> write-zeros? It may make sense if it can't do it fast but really writes
> zeros.
>=20
>>
>>> +=C2=A0=C2=A0=C2=A0 if (flags & DIRTY_BITMAP_MIG_FLAG_ZEROES) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_fflush(f);
>>> +=C2=A0=C2=A0=C2=A0 } else {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_put_be64(f, buf_size=
);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_put_buffer(f, buf, b=
uf_size);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 g_free(buf);
>>> +}=20

Peter, Stefan; do you have any insight on the reason for this blurb's
appearance in migration/block.c? Looks like it showed up in
323004a39d4d8d33c744a5b108f80bfe6402fca3

I'm not sure I understand what the concern was that lead to this, unless
it's simply that without a flush() we can't guarantee progress.
