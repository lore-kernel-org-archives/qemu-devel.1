Received: from eggs.gnu.org ([2001:4830:134:3::10]:34101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cgSUM-0002FT-Ag
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 03:41:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cgSUL-0001te-Af
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 03:41:30 -0500
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:33018)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cgSUK-0001tU-Uc
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 03:41:29 -0500
Received: by mail-lf0-x242.google.com with SMTP id 97so406781lft.0
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 00:41:28 -0800 (PST)
MIME-Version: 1.0
References: <20170221141451.28305-1-marcandre.lureau@redhat.com>
	<20170221141451.28305-31-marcandre.lureau@redhat.com>
	<20170221141904.GI2377@work-vm>
	<99ff57ee-c61b-1884-9a82-1ee0b1c49523@amsat.org>
In-Reply-To: <99ff57ee-c61b-1884-9a82-1ee0b1c49523@amsat.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 22 Feb 2017 08:41:16 +0000
Message-ID: <CAJ+F1CJhae4SL7+AE6JsB+d62ehk86c_rk-mRjgHW9X=ONZ4pg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 30/30] migration: fix id leak regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org

Hi

On Tue, Feb 21, 2017 at 9:43 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g>
wrote:

> Hi Marc-Andr=C3=A9,
>
> There is no documentation in "hw/qdev-core.h" for qdev_get_dev_path()
> and his name doesn't suggest any Heap allocation (like many others).
> Is there a recommended way in Qemu codebase to give to the user/caller a
> hit to care about releasing memory? "Learn to Read the Source, Luke."
>

Not much hint, except that the returned value is not const. But I did
verify this when I wrote the patch.

thanks


> On 02/21/2017 11:19 AM, Dr. David Alan Gilbert wrote:
> > * Marc-Andr=C3=A9 Lureau (marcandre.lureau@redhat.com) wrote:
> >> This leak was introduced in commit
> >> 581f08bac22bdd5e081ae07f68071a0fc3c5c2c7.
> >>
> >> (it stands out quickly with ASAN once the rest of the leaks are also
> >> removed from make check with this series)
> >
> > Oops yes.
> >
> > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> >
> >>
> >> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >> Cc: Juan Quintela <quintela@redhat.com>
> >> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >> ---
> >>  migration/savevm.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/migration/savevm.c b/migration/savevm.c
> >> index 5ecd264134..87c7a00832 100644
> >> --- a/migration/savevm.c
> >> +++ b/migration/savevm.c
> >> @@ -688,6 +688,7 @@ int vmstate_register_with_alias_id(DeviceState
> *dev, int instance_id,
> >>
> >>                  return -1;
> >>              }
> >> +            g_free(id);
> >>
> >>              se->compat =3D g_new0(CompatEntry, 1);
> >>              pstrcpy(se->compat->idstr, sizeof(se->compat->idstr),
> vmsd->name);
> >> --
> >> 2.11.0.295.gd7dffce1c.dirty
> >>
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >
>
> --
Marc-Andr=C3=A9 Lureau
