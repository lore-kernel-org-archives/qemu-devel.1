Received: from eggs.gnu.org ([2001:4830:134:3::10]:52316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gAqF9-0006tr-Mx
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 01:44:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gAqF6-0007LC-Gc
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 01:44:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gAqF6-0007KE-8k
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 01:44:08 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 786CE86674
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 05:44:07 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181008173125.19678-1-armbru@redhat.com>
	<20181008173125.19678-31-armbru@redhat.com>
	<a93edd67-8c1a-bb2d-7b52-db46b1e2abbd@redhat.com>
Date: Fri, 12 Oct 2018 07:44:03 +0200
In-Reply-To: <a93edd67-8c1a-bb2d-7b52-db46b1e2abbd@redhat.com> (Max Reitz's
	message of "Mon, 8 Oct 2018 23:22:19 +0200")
Message-ID: <87in27vhwc.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>

Copying Marc-Andr=C3=A9 for a possible connection to his recent work on
improving help.  Marc-Andr=C3=A9, search for "format=3Dhelp".  Just in case=
 you
have further observations to offer.

Max Reitz <mreitz@redhat.com> writes:

> On 08.10.18 19:31, Markus Armbruster wrote:
>> Calling error_report() from within a a function that takes an Error **
>> argument is suspicious.  drive_new() does that, and its caller
>> drive_init_func() then exit()s.
>
> I'm afraid I don't quite follow you here.  There is no function here
> that takes an Error ** already and then calls error_report().  There is
> however drive_new() that does not take an Error **, consequentially
> calls error_report(), and there is its caller drive_init_func() which
> does take an Error ** but does not set it.
>
> So while I fully agree with you to make drive_new() take an Error **
> (and thus effectively fix drive_init_func()), I don't quite understand
> this explanation.
>
> (Furthermore, drive_init_func() does not exit().  It's main() that
> exit()s after calling drive_init_func().)
=20=20
You're right.

There's about a dozen patches cleaning up pretty much the same thing,
and I reused the same commit message with the appropriate variations.  I
failed to vary this instance appropriately.  Sorry!

I'll fix this for v2.

>> Its caller main(), via
>> qemu_opts_foreach(), is fine with it, but clean it up anyway:
>>=20
>> * Convert drive_new() to Error
>>=20
>> * Update add_init_drive() to report the error received from
>>   drive_new().
>>=20
>> * Make main() pass &error_fatal through qemu_opts_foreach(),
>>   drive_init_func() to drive_new()
>>=20
>> * Make default_drive() pass &error_abort through qemu_opts_foreach(),
>>   drive_init_func() to drive_new()
>>=20
>> Cc: Kevin Wolf <kwolf@redhat.com>
>> Cc: Max Reitz <mreitz@redhat.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  blockdev.c                | 27 ++++++++++++++-------------
>>  device-hotplug.c          |  5 ++++-
>>  include/sysemu/blockdev.h |  3 ++-
>>  vl.c                      | 11 ++++-------
>>  4 files changed, 24 insertions(+), 22 deletions(-)
>>=20
>> diff --git a/blockdev.c b/blockdev.c
>> index a8755bd908..574adbcb7f 100644
>> --- a/blockdev.c
>> +++ b/blockdev.c
>> @@ -759,7 +759,8 @@ QemuOptsList qemu_legacy_drive_opts =3D {
>
> [...]
>
>> @@ -991,7 +992,7 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterf=
aceType block_default_type)
>>      bs_opts =3D NULL;
>>      if (!blk) {
>>          if (local_err) {
>> -            error_report_err(local_err);
>> +            error_propagate(errp, local_err);
>>          }
>
> Wait, what would be the case where blockdev_init() returns NULL but
> *errp remains unse=E2=80=94=E2=80=94=E2=80=94 oh no.
>
> There is only one case which is someone specified "format=3Dhelp".  Hm.  I
> suppose you are as unhappy as me about the fact that because of this
> drive_new() cannot guarantee that *errp is set in case of an error.

That's an ugly interface wart we have in a few places.  In a nutshell, eith=
er

* succeed and return a value indicating success

* fail, set an error, and return a value indicating failure

* print help, leave error alone, and return a value indicating failure

> I think it's ""fine"" (*gnashing teeth*) to keep it this way, but it
> means that callers need to continue to check the return value and not
> *errp alone.

Yes, they need to check both.

Note that -device and -machine use a technique I consider cleaner:
there's a separate function FOO_help_func() to deal with providing help
before we do the actual work.  If the user asked for help,
FOO_help_func() prints some, and returns 1.  Else it returns 0.  This
lets main() call exit(0) after help.

>>          goto fail;
>>      } else {
>> diff --git a/device-hotplug.c b/device-hotplug.c
>> index cd427e2c76..6090d5f1e9 100644
>> --- a/device-hotplug.c
>> +++ b/device-hotplug.c
>> @@ -28,6 +28,7 @@
>>  #include "sysemu/block-backend.h"
>>  #include "sysemu/blockdev.h"
>>  #include "qapi/qmp/qdict.h"
>> +#include "qapi/error.h"
>>  #include "qemu/config-file.h"
>>  #include "qemu/option.h"
>>  #include "sysemu/sysemu.h"
>> @@ -36,6 +37,7 @@
>>=20=20
>>  static DriveInfo *add_init_drive(const char *optstr)
>>  {
>> +    Error *err =3D NULL;
>>      DriveInfo *dinfo;
>>      QemuOpts *opts;
>>      MachineClass *mc;
>> @@ -45,8 +47,9 @@ static DriveInfo *add_init_drive(const char *optstr)
>>          return NULL;
>>=20=20
>>      mc =3D MACHINE_GET_CLASS(current_machine);
>> -    dinfo =3D drive_new(opts, mc->block_default_type);
>> +    dinfo =3D drive_new(opts, mc->block_default_type, &err);
>>      if (!dinfo) {
>> +        error_report_err(err);
>>          qemu_opts_del(opts);
>>          return NULL;
>>      }
>> diff --git a/include/sysemu/blockdev.h b/include/sysemu/blockdev.h
>> index 24954b94e0..d34c4920dc 100644
>> --- a/include/sysemu/blockdev.h
>> +++ b/include/sysemu/blockdev.h
>> @@ -54,7 +54,8 @@ DriveInfo *drive_get_next(BlockInterfaceType type);
>>  QemuOpts *drive_def(const char *optstr);
>>  QemuOpts *drive_add(BlockInterfaceType type, int index, const char *fil=
e,
>>                      const char *optstr);
>> -DriveInfo *drive_new(QemuOpts *arg, BlockInterfaceType block_default_ty=
pe);
>> +DriveInfo *drive_new(QemuOpts *arg, BlockInterfaceType block_default_ty=
pe,
>> +                     Error **errp);
>>=20=20
>>  /* device-hotplug */
>>=20=20
>> diff --git a/vl.c b/vl.c
>> index 0d25956b2f..101e0123d9 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -1129,7 +1129,7 @@ static int drive_init_func(void *opaque, QemuOpts =
*opts, Error **errp)
>>  {
>>      BlockInterfaceType *block_default_type =3D opaque;
>>=20=20
>> -    return drive_new(opts, *block_default_type) =3D=3D NULL;
>> +    return drive_new(opts, *block_default_type, errp) =3D=3D NULL;
>>  }
>>=20=20
>>  static int drive_enable_snapshot(void *opaque, QemuOpts *opts, Error **=
errp)
>> @@ -1155,8 +1155,7 @@ static void default_drive(int enable, int snapshot=
, BlockInterfaceType type,
>>          drive_enable_snapshot(NULL, opts, NULL);
>>      }
>>=20=20
>> -    dinfo =3D drive_new(opts, type);
>> -    assert(dinfo);
>> +    dinfo =3D drive_new(opts, type, &error_abort);
>
> Which means the assertion is still necessary here.

I see very little value in assert(p) right before *p.  Matter of taste,
I guess.  Do you want me to keep it?

>>      dinfo->is_default =3D true;
>>=20=20
>>  }
>> @@ -4348,10 +4347,8 @@ int main(int argc, char **argv, char **envp)
>>          qemu_opts_foreach(qemu_find_opts("drive"), drive_enable_snapsho=
t,
>>                            NULL, NULL);
>>      }
>> -    if (qemu_opts_foreach(qemu_find_opts("drive"), drive_init_func,
>> -                          &machine_class->block_default_type, NULL)) {
>> -        exit(1);
>> -    }
>> +    qemu_opts_foreach(qemu_find_opts("drive"), drive_init_func,
>> +                      &machine_class->block_default_type, &error_fatal);
>
> And we still have to keep an exit() here.

You're right.  But it should become exit(0).

> Alternative: You transform blockdev_init()'s format=3Dhelp into an error
> (or construct a new error in drive_new() if blockdev_init() returned
> NULL but no error).

Another alternative would be separating out help.  Since I'd prefer to
keep this patch mostly mechanical, I'd rather do that on top if it's
desired.

>
> Max
>
>>=20=20
>>      default_drive(default_cdrom, snapshot, machine_class->block_default=
_type, 2,
>>                    CDROM_OPTS);
>>=20
