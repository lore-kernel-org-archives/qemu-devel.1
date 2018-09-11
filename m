Received: from eggs.gnu.org ([2001:4830:134:3::10]:56606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fzjLV-0001gW-3W
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 10:08:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fzjLS-0000i0-KV
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 10:08:48 -0400
References: <20180911083706.5378-1-mahaocong_work@163.com>
	<20180911083706.5378-2-mahaocong_work@163.com>
	<3a26f63a-f05b-186f-316c-9a91be752065@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a7a842bd-a2c3-c65c-f6a9-f16a1b97f9aa@redhat.com>
Date: Tue, 11 Sep 2018 09:08:34 -0500
MIME-Version: 1.0
In-Reply-To: <3a26f63a-f05b-186f-316c-9a91be752065@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 1/1] qemu-img: add new function to
 remove bitmap in image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ma Haocong <mahaocong_work@163.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On 9/11/18 8:56 AM, Eric Blake wrote:

>> +=C2=A0=C2=A0=C2=A0 bitmap =3D bdrv_find_dirty_bitmap(bs, bitmapname);
>> +
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Dirty bitmap may not be load if the 'IN_US=
E' flag is set (e.g.=20
>> the
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * qemu thread is corrupted and the 'IN_USE' =
flag is not be=20
>> cleared),
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * so the result of bdrv_find_dirty_bitmap is=
 null. In this case,
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * we delete bitmap in qcow2 file directly.
>> +=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 if (!bitmap) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_remove_persistent_dir=
ty_bitmap(bs, bitmapname, &local_err);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (local_err !=3D NULL) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
t =3D -1;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 go=
to out;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bdrv_dirty_bitmap_get_=
persistance(bitmap)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bd=
rv_remove_persistent_dirty_bitmap(bs, bitmapname,=20
>> &local_err);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (local_err !=3D NULL) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ret =3D -1;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 goto out;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_release_dirty_bitmap(=
bs, bitmap);
>> +=C2=A0=C2=A0=C2=A0 }
>=20
> Why aren't you calling bdrv_block_dirty_bitmap_remove()?=C2=A0 In gener=
al,=20

It helps if I ask my actual intended question: Why aren't you calling=20
qmp_block_dirty_bitmap_remove()?

> HMP commands that are mere wrappers around counterpart QMP commands are=
=20
> easier to maintain, rather than open-coding the same work in two places=
.
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
