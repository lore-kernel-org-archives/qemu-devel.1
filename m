Received: from eggs.gnu.org ([2001:4830:134:3::10]:48026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fEb1u-00084n-A8
	for qemu-devel@nongnu.org; Fri, 04 May 2018 09:45:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fEb1t-0005jK-6g
	for qemu-devel@nongnu.org; Fri, 04 May 2018 09:45:46 -0400
References: <20180420220913.27000-1-mreitz@redhat.com>
	<20180420220913.27000-3-mreitz@redhat.com>
	<20180427062221.GD4217@lemon.usersys.redhat.com>
	<9801ca35-b050-d482-f482-f1364bf07e1c@redhat.com>
	<20180503064552.GJ15438@lemon.usersys.redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <829af997-251b-d0e9-fb76-4ada1c3dd340@redhat.com>
Date: Fri, 4 May 2018 15:45:21 +0200
MIME-Version: 1.0
In-Reply-To: <20180503064552.GJ15438@lemon.usersys.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HZvhPmqxIDKiXKzO5x10lRGSvGSjuKcc6"
Subject: Re: [Qemu-devel] [PATCH 2/3] block/file-posix: File locking during
 creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HZvhPmqxIDKiXKzO5x10lRGSvGSjuKcc6
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <829af997-251b-d0e9-fb76-4ada1c3dd340@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] block/file-posix: File locking during
 creation
References: <20180420220913.27000-1-mreitz@redhat.com>
 <20180420220913.27000-3-mreitz@redhat.com>
 <20180427062221.GD4217@lemon.usersys.redhat.com>
 <9801ca35-b050-d482-f482-f1364bf07e1c@redhat.com>
 <20180503064552.GJ15438@lemon.usersys.redhat.com>
In-Reply-To: <20180503064552.GJ15438@lemon.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-03 08:45, Fam Zheng wrote:
> On Sat, 04/28 13:03, Max Reitz wrote:
>> On 2018-04-27 08:22, Fam Zheng wrote:
>>> On Sat, 04/21 00:09, Max Reitz wrote:
>>>> When creating a file, we should take the WRITE and RESIZE permission=
s.
>>>> We do not need either for the creation itself, but we do need them f=
or
>>>> clearing and resizing it.  So we can take the proper permissions by
>>>> replacing O_TRUNC with an explicit truncation to 0, and by taking th=
e
>>>> appropriate file locks between those two steps.
>>>>
>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>> ---
>>>>  block/file-posix.c | 41 +++++++++++++++++++++++++++++++++++++++--
>>>>  1 file changed, 39 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/block/file-posix.c b/block/file-posix.c
>>>> index c98a4a1556..ed7932d6e8 100644
>>>> --- a/block/file-posix.c
>>>> +++ b/block/file-posix.c
>>>> @@ -1992,6 +1992,7 @@ static int raw_co_create(BlockdevCreateOptions=
 *options, Error **errp)
>>>>  {
>>>>      BlockdevCreateOptionsFile *file_opts;
>>>>      int fd;
>>>> +    int perm, shared;
>>>>      int result =3D 0;
>>>> =20
>>>>      /* Validate options and set default values */
>>>> @@ -2006,14 +2007,48 @@ static int raw_co_create(BlockdevCreateOptio=
ns *options, Error **errp)
>>>>      }
>>>> =20
>>>>      /* Create file */
>>>> -    fd =3D qemu_open(file_opts->filename, O_RDWR | O_CREAT | O_TRUN=
C | O_BINARY,
>>>> -                   0644);
>>>> +    fd =3D qemu_open(file_opts->filename, O_RDWR | O_CREAT | O_BINA=
RY, 0644);
>>>>      if (fd < 0) {
>>>>          result =3D -errno;
>>>>          error_setg_errno(errp, -result, "Could not create file");
>>>>          goto out;
>>>>      }
>>>> =20
>>>> +    /* Take permissions: We want to discard everything, so we need
>>>> +     * BLK_PERM_WRITE; and truncation to the desired size requires
>>>> +     * BLK_PERM_RESIZE.
>>>> +     * On the other hand, we cannot share the RESIZE permission
>>>> +     * because we promise that after this function, the file has th=
e
>>>> +     * size given in the options.  If someone else were to resize i=
t
>>>> +     * concurrently, we could not guarantee that. */
>>>
>>> Strictly speaking, we do close(fd) before this function returns so th=
e lock is
>>> lost and race can happen.
>>
>> Right, but then creation from the perspective of file-posix is over.  =
We
>> are going to reopen the file for formatting, but that is just a normal=

>> bdrv_open() so it will automatically be locked, no?
>=20
> After this function close() but before the following bdrv_open(), anoth=
er
> process can sneak in and steal the lock. So we cannot guarantee the RES=
IZE lock
> does what we really want.

Right, but I'd argue that is not the purpose of the lock.  If someone
wants the file (or then rather the node) to be a certain size, they'd
have to call bdrv_getlength() on it to check.

But indeed you're right in that not sharing the RESIZE is hypocritical
considering it actually doesn't promise anything.

Anyway, let's consider the issues.  For formatting the file, this
behavior is OK because since Kevin's x-blockdev-create series format
drivers always truncate the file during formatting (that is, once they
have opened the file), and not during creation, so that part is secured.

But we do have issues with e.g. drive-mirror, where we create an image
and then open it.  The opened image may have a different size than what
we wanted to create.  Now in this case I wouldn't consider this a big
problem because drive-mirror is basically deprecated anyway, so there is
no reason to waste resources here; and this applies to all of the QMP
commands that create images and then open them automatically.

In the future, we want users to use blockdev-create and then
blockdev-add in two separate steps.  Then it's up to the user to realize
that the blockdev-add'ed node may have a different length then what they
wanted to achieve in blockdev-create.  Actually, it may just differ
altogether, I don't think qemu is going to make any promises on the
state of the image in the interim.

So...  I suppose there aren't any real issues with not being able to
promise that the image has the intended length immediately after
creating it.  So I guess we can indeed share RESIZE.

But OTOH, it definitely does not feel right to me to share RESIZE.  We
definitely do not want other parties to resize the image while we create =
it.

So I guess what I would like to do is keep RESIZE not shared and add a
note after the comment:

> Note that after this function, we can no longer guarantee that the
> file is not touched by a third party, so it may be resized then.

Ideally, we'd want the lock to stay active until blockdev-create or
qemu-img create returns, but I don't think that is really worth it.  If
there is a race condition between raw_co_create() returning and those
commands returning (and we don't have a format layer to correct things),
then I can't imagine that it couldn't bite you after those commands have
returned.  (And after those commands, it isn't our problem anymore anyway=
=2E)

Max


--HZvhPmqxIDKiXKzO5x10lRGSvGSjuKcc6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlrsY/IACgkQ9AfbAGHV
z0AdmAgAuVl5/wYip1vEanRlKOTS6X8vQao38bY7CRX5nvdHKnE+KKDALtZI0rQC
Q1snECkg6i9k06sQv1vTXvkYLw4t6zIfCU149xDXI/vF18N8Eqj4OulSSqucyX8V
Xkyr5VMCLDpLEW2fq0/Wpd1Z0vwuxyjuy2F7QXSMjErBiB4KHutFQpdc+Qs00Exy
wDtA8tEHYOe5tdnSofVEgIYAnMXUpaNBYyCVfENZuv8wQtmuYA/v2XloSEZYEJxn
RC8Pwfw48JANYOIBBY70k0HW+AAu/wzi4i7Dz2AZTc2Kr4egkuOvsA3Oiv/TU6R8
ZqfsUnP6D7xHMK8LGBAvvd3Q6csx7g==
=I5bS
-----END PGP SIGNATURE-----

--HZvhPmqxIDKiXKzO5x10lRGSvGSjuKcc6--
