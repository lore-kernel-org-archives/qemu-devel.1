Received: from eggs.gnu.org ([2001:4830:134:3::10]:52365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ermHw-0002dt-JQ
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 10:08:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ermHv-0006zi-FS
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 10:08:00 -0500
References: <1518702707-7077-1-git-send-email-vsementsov@virtuozzo.com>
	<1518702707-7077-4-git-send-email-vsementsov@virtuozzo.com>
	<5b1f16df-0ee8-7453-9d82-fd85c1a17f5e@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <ffbb80c2-04ed-6cca-a29f-14a3e4fe5f6c@virtuozzo.com>
Date: Fri, 2 Mar 2018 18:07:43 +0300
MIME-Version: 1.0
In-Reply-To: <5b1f16df-0ee8-7453-9d82-fd85c1a17f5e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 3/9] nbd: BLOCK_STATUS for standard
 get_block_status function: server part
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

16.02.2018 16:21, Eric Blake wrote:
> On 02/15/2018 07:51 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Minimal realization: only one extent in server answer is supported.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>
>

[...]

>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 meta =3D &local_meta;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 memset(meta, 0, sizeof(*meta));
>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D nbd_read_size_string(client, meta->export_na=
me,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NBD_MAX_NAME_SIZE, errp);
>
> Revisiting a question I raised in my first half review - you saved the=20
> name as part of the struct because we have to later compare that the=20
> final OPT_SET export name matches the request during OPT_GO (if they=20
> don't match, then we have no contexts to serve after all).=C2=A0 So a=20
> 'const char *' won't work, but maybe the struct could use a 'char *'=20
> pointing to malloc'd storage rather than char[MAX_NAME] that reserves=20
> array space that is mostly unused for the typical name that is much=20
> shorter than the maximum name length.

Do these 256 bytes worth creating nbd_clear_meta function, to call it=20
from client_put and on NBD_OPT_SET_META_CONTEXT, to clear previous meta?=20
If yes, I'd prefer to postpone it to continuation about BLOCKSTATUS for=20
dirty bitmaps, when I'll have to upgrade meta structure, to maintain=20
dirty bitmaps.

>
>> +=C2=A0=C2=A0=C2=A0 if (ret <=3D 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 exp =3D nbd_export_find(meta->export_name);
>> +=C2=A0=C2=A0=C2=A0 if (exp =3D=3D NULL) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return nbd_opt_invalid(clien=
t, errp,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "export '%s' not present",=20
>> meta->export_name);
>


--=20
Best regards,
Vladimir
