Received: from eggs.gnu.org ([209.51.188.92]:55220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gmQsU-0004zB-PJ
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 17:20:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gmQqv-00082v-7M
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 17:18:34 -0500
References: <20190123211953.28578-1-eblake@redhat.com>
	<20190123215521.GD12500@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5bd946ae-0f88-375b-072f-40b0aa850ab2@redhat.com>
Date: Wed, 23 Jan 2019 16:18:16 -0600
MIME-Version: 1.0
In-Reply-To: <20190123215521.GD12500@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JrdoxdRsWZcrJjTbRupskr2ADuo25iHvD"
Subject: Re: [Qemu-devel] [PATCH] qemu-nbd: Deprecate qemu-nbd --partition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, qemu-block@nongnu.org, thuth@redhat.com, "reviewer:Incompatible changes" <libvir-list@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JrdoxdRsWZcrJjTbRupskr2ADuo25iHvD
From: Eric Blake <eblake@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 thuth@redhat.com, "reviewer:Incompatible changes" <libvir-list@redhat.com>
Message-ID: <5bd946ae-0f88-375b-072f-40b0aa850ab2@redhat.com>
Subject: Re: [PATCH] qemu-nbd: Deprecate qemu-nbd --partition
References: <20190123211953.28578-1-eblake@redhat.com>
 <20190123215521.GD12500@redhat.com>
In-Reply-To: <20190123215521.GD12500@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/23/19 3:55 PM, Richard W.M. Jones wrote:
> On Wed, Jan 23, 2019 at 03:19:53PM -0600, Eric Blake wrote:
>> The existing qemu-nbd --partition code claims to handle logical
>> partitions up to 8, since its introduction in 2008 (commit 7a5ca86).
>> However, the implementation is bogus (actual MBR logical partitions
>> form a sort of linked list, with one partition per extended table
>> entry, rather than four logical partitions in a single extended
>> table), making the code unlikely to work for anything beyond -P5 on
>> actual guest images. What's more, the code does not support GPT
>> partitions, which are becoming more popular, and maintaining device
>> subsetting in both NBD and the raw device is unnecessary maintenance
>> burden.  And nbdkit has just added code to properly handle an
>> arbitrary number of MBR partitions, along with its existing code
>> for handling GPT partitions.
>>
>> Note that obtaining the offsets of a partition can be learned by
>> using 'qemu-nbd -c /dev/nbd0 file.qcow2 && sfdisk --dump /dev/nbd0',
>> but by the time you've done that, you might as well just mount
>> /dev/nbd0p1 that the kernel creates for you.
>>
>> Start the clock on the deprecation cycle, with an example of how
>> to write device subsetting without using -P.
>>

>> +For example, if partition 1 is 100MiB starting at 1MiB, the old comma=
nd
>> +
>> +@example{qemu-nbd -P 1 -f qcow2 file.qcow2}
>> +
>> +can be rewritten as:
>> +
>> +@example{qemu-nbd --image-opts driver=3Draw,offset=3D1M,size=3D100M,f=
ile.driver=3Dqcow2,file.backing.driver=3Dfile,file.backing.filename=3Dfil=
e.qcow2}
>> +
>> +Alternatively, the @code{nbdkit} project provides a more powerful
>> +partition filter on top of its nbd plugin, which can be used to selec=
t
>> +an arbitrary MBR or GPT partition on top of any other full-image NBD
>> +export.
>=20
> You might want to add the actual command here.

Good idea - as long as we are deprecating something, telling the user
how to get the same functionality (in this case, user-space partition
detection, without involving /dev/nbd) is worth the extra effort.

>  Unfortunately nbdkit
> cannot read qcow2 files meaning (as you note already) that you have to
> forward the connection through the nbdkit-nbd-plugin to qemu-nbd.
> This worked for me:
>=20
>   qemu-nbd -t -k /tmp/sock -f qcow2 file.qcow2 &
>   nbdkit -f --filter=3Dpartition nbd socket=3D/tmp/sock partition=3D1 &=


Is the -f necessary? Otherwise, yes, this looks reasonable.  I'll add it
for v2.

> If you drop the requirement to demonstrate this with qcow2 then the
> command would be just this:
>=20
>   nbdkit --filter=3Dpartition file disk.raw partition=3D1
>=20


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--JrdoxdRsWZcrJjTbRupskr2ADuo25iHvD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxI6CgACgkQp6FrSiUn
Q2o93gf/bPIB8O7KnaPhZrcv9aTFfen3ySioJSPCk+lMsBUFjr7hT+hoyZ/0Mf24
DpnnovjNPQT7mx5f+NXQoZLYNeTJfMlvxM3OBZRtYu2t7v0NzzzRAoxuKhVeOcvq
rYgpYRuihNL+Bu3Num2eTxrFOqLecRJOfbk+xk3VrFDaff7tiUD7HT72HgnoPKkT
QmGTlroqJFV+nnyN/DrNlfshQoYk3i8t5Wb9+Zzv2HXnaAuS9xcSSMkUFH+eTLpF
g8N5FQ7ctRIrNPw3+eYiju12ORjq4/6NOAVO2MA5DOb8x/hP5FyoJZ+o6jL0WnF/
lqmdVmsrtyTVUwLMAuR/tujhYpJ8Pg==
=Px0h
-----END PGP SIGNATURE-----

--JrdoxdRsWZcrJjTbRupskr2ADuo25iHvD--
