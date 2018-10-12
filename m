Received: from eggs.gnu.org ([2001:4830:134:3::10]:45787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gAwZA-00041O-Ib
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 08:29:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gAwZ3-0002bI-4g
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 08:29:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1gAwZ0-0002R2-VB
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 08:29:08 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 62362D7E6A
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 12:29:00 +0000 (UTC)
References: <20181008173125.19678-1-armbru@redhat.com>
	<20181008173125.19678-31-armbru@redhat.com>
	<a93edd67-8c1a-bb2d-7b52-db46b1e2abbd@redhat.com>
	<87in27vhwc.fsf@dusky.pond.sub.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5e5d426c-75f5-98ca-ddcf-729bc7656c99@redhat.com>
Date: Fri, 12 Oct 2018 14:28:53 +0200
MIME-Version: 1.0
In-Reply-To: <87in27vhwc.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="biFPPNmAV5eteAqiulJjMhoCnTwBKcBxp"
Subject: Re: [Qemu-devel] [PATCH 30/31] blockdev: Convert drive_new() to
 Error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--biFPPNmAV5eteAqiulJjMhoCnTwBKcBxp
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Message-ID: <5e5d426c-75f5-98ca-ddcf-729bc7656c99@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 30/31] blockdev: Convert drive_new() to Error
References: <20181008173125.19678-1-armbru@redhat.com>
 <20181008173125.19678-31-armbru@redhat.com>
 <a93edd67-8c1a-bb2d-7b52-db46b1e2abbd@redhat.com>
 <87in27vhwc.fsf@dusky.pond.sub.org>
In-Reply-To: <87in27vhwc.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12.10.18 07:44, Markus Armbruster wrote:
> Copying Marc-Andr=C3=A9 for a possible connection to his recent work on=

> improving help.  Marc-Andr=C3=A9, search for "format=3Dhelp".  Just in =
case you
> have further observations to offer.
>=20
> Max Reitz <mreitz@redhat.com> writes:
>=20
>> On 08.10.18 19:31, Markus Armbruster wrote:
>>> Calling error_report() from within a a function that takes an Error *=
*
>>> argument is suspicious.  drive_new() does that, and its caller
>>> drive_init_func() then exit()s.
>>
>> I'm afraid I don't quite follow you here.  There is no function here
>> that takes an Error ** already and then calls error_report().  There i=
s
>> however drive_new() that does not take an Error **, consequentially
>> calls error_report(), and there is its caller drive_init_func() which
>> does take an Error ** but does not set it.
>>
>> So while I fully agree with you to make drive_new() take an Error **
>> (and thus effectively fix drive_init_func()), I don't quite understand=

>> this explanation.
>>
>> (Furthermore, drive_init_func() does not exit().  It's main() that
>> exit()s after calling drive_init_func().)
>  =20
> You're right.
>=20
> There's about a dozen patches cleaning up pretty much the same thing,
> and I reused the same commit message with the appropriate variations.  =
I
> failed to vary this instance appropriately.  Sorry!
>=20
> I'll fix this for v2.
>=20
>>> Its caller main(), via
>>> qemu_opts_foreach(), is fine with it, but clean it up anyway:
>>>
>>> * Convert drive_new() to Error
>>>
>>> * Update add_init_drive() to report the error received from
>>>   drive_new().
>>>
>>> * Make main() pass &error_fatal through qemu_opts_foreach(),
>>>   drive_init_func() to drive_new()
>>>
>>> * Make default_drive() pass &error_abort through qemu_opts_foreach(),=

>>>   drive_init_func() to drive_new()
>>>
>>> Cc: Kevin Wolf <kwolf@redhat.com>
>>> Cc: Max Reitz <mreitz@redhat.com>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>  blockdev.c                | 27 ++++++++++++++-------------
>>>  device-hotplug.c          |  5 ++++-
>>>  include/sysemu/blockdev.h |  3 ++-
>>>  vl.c                      | 11 ++++-------
>>>  4 files changed, 24 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/blockdev.c b/blockdev.c
>>> index a8755bd908..574adbcb7f 100644
>>> --- a/blockdev.c
>>> +++ b/blockdev.c
>>> @@ -759,7 +759,8 @@ QemuOptsList qemu_legacy_drive_opts =3D {
>>
>> [...]
>>
>>> @@ -991,7 +992,7 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInt=
erfaceType block_default_type)
>>>      bs_opts =3D NULL;
>>>      if (!blk) {
>>>          if (local_err) {
>>> -            error_report_err(local_err);
>>> +            error_propagate(errp, local_err);
>>>          }
>>
>> Wait, what would be the case where blockdev_init() returns NULL but
>> *errp remains unse=E2=80=94=E2=80=94=E2=80=94 oh no.
>>
>> There is only one case which is someone specified "format=3Dhelp".  Hm=
=2E  I
>> suppose you are as unhappy as me about the fact that because of this
>> drive_new() cannot guarantee that *errp is set in case of an error.
>=20
> That's an ugly interface wart we have in a few places.  In a nutshell, =
either
>=20
> * succeed and return a value indicating success
>=20
> * fail, set an error, and return a value indicating failure
>=20
> * print help, leave error alone, and return a value indicating failure
>=20
>> I think it's ""fine"" (*gnashing teeth*) to keep it this way, but it
>> means that callers need to continue to check the return value and not
>> *errp alone.
>=20
> Yes, they need to check both.
>=20
> Note that -device and -machine use a technique I consider cleaner:
> there's a separate function FOO_help_func() to deal with providing help=

> before we do the actual work.  If the user asked for help,
> FOO_help_func() prints some, and returns 1.  Else it returns 0.  This
> lets main() call exit(0) after help.

It is indeed cleaner.  I don't mind the current way too much, though, I
mostly just don't like effectively failing without setting the Error obje=
ct.

>>>          goto fail;
>>>      } else {
>>> diff --git a/device-hotplug.c b/device-hotplug.c
>>> index cd427e2c76..6090d5f1e9 100644
>>> --- a/device-hotplug.c
>>> +++ b/device-hotplug.c
>>> @@ -28,6 +28,7 @@
>>>  #include "sysemu/block-backend.h"
>>>  #include "sysemu/blockdev.h"
>>>  #include "qapi/qmp/qdict.h"
>>> +#include "qapi/error.h"
>>>  #include "qemu/config-file.h"
>>>  #include "qemu/option.h"
>>>  #include "sysemu/sysemu.h"
>>> @@ -36,6 +37,7 @@
>>> =20
>>>  static DriveInfo *add_init_drive(const char *optstr)
>>>  {
>>> +    Error *err =3D NULL;
>>>      DriveInfo *dinfo;
>>>      QemuOpts *opts;
>>>      MachineClass *mc;
>>> @@ -45,8 +47,9 @@ static DriveInfo *add_init_drive(const char *optstr=
)
>>>          return NULL;
>>> =20
>>>      mc =3D MACHINE_GET_CLASS(current_machine);
>>> -    dinfo =3D drive_new(opts, mc->block_default_type);
>>> +    dinfo =3D drive_new(opts, mc->block_default_type, &err);
>>>      if (!dinfo) {
>>> +        error_report_err(err);
>>>          qemu_opts_del(opts);
>>>          return NULL;
>>>      }
>>> diff --git a/include/sysemu/blockdev.h b/include/sysemu/blockdev.h
>>> index 24954b94e0..d34c4920dc 100644
>>> --- a/include/sysemu/blockdev.h
>>> +++ b/include/sysemu/blockdev.h
>>> @@ -54,7 +54,8 @@ DriveInfo *drive_get_next(BlockInterfaceType type);=

>>>  QemuOpts *drive_def(const char *optstr);
>>>  QemuOpts *drive_add(BlockInterfaceType type, int index, const char *=
file,
>>>                      const char *optstr);
>>> -DriveInfo *drive_new(QemuOpts *arg, BlockInterfaceType block_default=
_type);
>>> +DriveInfo *drive_new(QemuOpts *arg, BlockInterfaceType block_default=
_type,
>>> +                     Error **errp);
>>> =20
>>>  /* device-hotplug */
>>> =20
>>> diff --git a/vl.c b/vl.c
>>> index 0d25956b2f..101e0123d9 100644
>>> --- a/vl.c
>>> +++ b/vl.c
>>> @@ -1129,7 +1129,7 @@ static int drive_init_func(void *opaque, QemuOp=
ts *opts, Error **errp)
>>>  {
>>>      BlockInterfaceType *block_default_type =3D opaque;
>>> =20
>>> -    return drive_new(opts, *block_default_type) =3D=3D NULL;
>>> +    return drive_new(opts, *block_default_type, errp) =3D=3D NULL;
>>>  }
>>> =20
>>>  static int drive_enable_snapshot(void *opaque, QemuOpts *opts, Error=
 **errp)
>>> @@ -1155,8 +1155,7 @@ static void default_drive(int enable, int snaps=
hot, BlockInterfaceType type,
>>>          drive_enable_snapshot(NULL, opts, NULL);
>>>      }
>>> =20
>>> -    dinfo =3D drive_new(opts, type);
>>> -    assert(dinfo);
>>> +    dinfo =3D drive_new(opts, type, &error_abort);
>>
>> Which means the assertion is still necessary here.
>=20
> I see very little value in assert(p) right before *p.  Matter of taste,=

> I guess.  Do you want me to keep it?

True.  "An assertion looks better to the user" isn't an argument,
considering the user shouldn't ever see assertions either.

So feel free to drop it indeed.

>>>      dinfo->is_default =3D true;
>>> =20
>>>  }
>>> @@ -4348,10 +4347,8 @@ int main(int argc, char **argv, char **envp)
>>>          qemu_opts_foreach(qemu_find_opts("drive"), drive_enable_snap=
shot,
>>>                            NULL, NULL);
>>>      }
>>> -    if (qemu_opts_foreach(qemu_find_opts("drive"), drive_init_func,
>>> -                          &machine_class->block_default_type, NULL))=
 {
>>> -        exit(1);
>>> -    }
>>> +    qemu_opts_foreach(qemu_find_opts("drive"), drive_init_func,
>>> +                      &machine_class->block_default_type, &error_fat=
al);
>>
>> And we still have to keep an exit() here.
>=20
> You're right.  But it should become exit(0).

That makes sense, yes.

>> Alternative: You transform blockdev_init()'s format=3Dhelp into an err=
or
>> (or construct a new error in drive_new() if blockdev_init() returned
>> NULL but no error).
>=20
> Another alternative would be separating out help.  Since I'd prefer to
> keep this patch mostly mechanical, I'd rather do that on top if it's
> desired.

I'm not sure how much I desire it, so I won't push you to do so.  But
it's definitely fine to keep it out of this patch.

Max


--biFPPNmAV5eteAqiulJjMhoCnTwBKcBxp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvAk4UACgkQ9AfbAGHV
z0BmeAf/QRdu135daHdVFGRp2yIWELUSZBM4u1vW3BQiYOyPD63J1G7RfMQdqIk1
uPnnr0m/IewMMaPzUB+dHPb0LK+CKSD8o7uSIa6QnRTPvmxhWu+CsSajwGXdi+sK
b9ea73r3NSQavFF2FYG+yzJL4aMuc/c5vS38xGtyt+6OtLPyyE4eRmt8/cfzp+Fo
d0BlA0DWM5u+N3bkyr9/zXS7rdDHi+xeD/+6n5Gzq3I/HHVH+IrEVt7gclmXYHLM
17OVHLBYY2gpN8TUfUoJdh+MeoA34geg0Rcq7kXVjMH5OvuHM4vkQdPJW1NrOyST
j3hv9NsSfnHCTICcffZNH+pMV77JzQ==
=ShN8
-----END PGP SIGNATURE-----

--biFPPNmAV5eteAqiulJjMhoCnTwBKcBxp--
