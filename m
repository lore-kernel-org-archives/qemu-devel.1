Received: from eggs.gnu.org ([2001:4830:134:3::10]:45498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1gZY62-0005tK-Nz
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 04:24:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1gZY5y-0005a5-E1
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 04:24:54 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36518)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1gZY5y-0005Ya-2A
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 04:24:50 -0500
Received: by mail-wr1-f66.google.com with SMTP id u4so17742944wrp.3
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 01:24:49 -0800 (PST)
MIME-Version: 1.0
References: <20181218175122.3229-1-philmd@redhat.com>
	<20181218175122.3229-6-philmd@redhat.com>
	<20181218181004-mutt-send-email-mst@kernel.org>
In-Reply-To: <20181218181004-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Wed, 19 Dec 2018 10:24:37 +0100
Message-ID: <CAP+75-Vc9GEnu4e6OOpjwVyY6N_JULFYg+wbSvUO5DaTyvh1Dw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 5/5] migration: Use strnlen() for
 fixed-size string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, qemu-block@nongnu.org, 1803872@bugs.launchpad.net, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Howard Spoelstra <hsp.cat7@gmail.com>, Jeff Cody <jcody@redhat.com>, David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Ben Pye <ben@curlybracket.co.uk>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Liu Yuan <namei.unix@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Max Reitz <mreitz@redhat.com>

Le mer. 19 d=C3=A9c. 2018 00:16, Michael S. Tsirkin <mst@redhat.com> a =C3=
=A9crit :

> On Tue, Dec 18, 2018 at 06:51:22PM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > GCC 8 introduced the -Wstringop-overflow, which detect buffer overflow
> > by string-modifying functions declared in <string.h>, such strncpy(),
> > used in global_state_store_running().
> >
> > Since the global_state.runstate does not necessarily contains a
> > terminating NUL character, We had to use the QEMU_NONSTRING attribute.
> >
> > The GCC manual says about the nonstring attribute:
> >
> >   However, when the array is declared with the attribute the call to
> >   strlen is diagnosed because when the array doesn=E2=80=99t contain a
> >   NUL-terminated string the call is undefined. [...]
> >   In addition, calling strnlen and strndup with such arrays is safe
> >   provided a suitable bound is specified, and not diagnosed.
> >
> > GCC indeed found an incorrect use of strlen(), because this array
> > is loaded by VMSTATE_BUFFER(runstate, GlobalState) then parsed
> > using qapi_enum_parse which does not get the buffer length.
> >
> > Use strnlen() which returns sizeof(s->runstate) if the array is not
> > NUL-terminated.
> >
> > This fixes:
> >
> >     CC      migration/global_state.o
> >   qemu/migration/global_state.c: In function 'global_state_pre_save':
> >   qemu/migration/global_state.c:109:15: error: 'strlen' argument 1
> declared attribute 'nonstring' [-Werror=3Dstringop-overflow=3D]
> >        s->size =3D strlen((char *)s->runstate) + 1;
> >                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> >   qemu/migration/global_state.c:24:13: note: argument 'runstate'
> declared here
> >        uint8_t runstate[100] QEMU_NONSTRING;
> >                ^~~~~~~~
> >   cc1: all warnings being treated as errors
> >   make: *** [qemu/rules.mak:69: migration/global_state.o] Error 1
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > ---
> >  migration/global_state.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/migration/global_state.c b/migration/global_state.c
> > index 6e19333422..c19030ef62 100644
> > --- a/migration/global_state.c
> > +++ b/migration/global_state.c
> > @@ -106,7 +106,7 @@ static int global_state_pre_save(void *opaque)
> >      GlobalState *s =3D opaque;
> >
> >      trace_migrate_global_state_pre_save((char *)s->runstate);
> > -    s->size =3D strlen((char *)s->runstate) + 1;
> > +    s->size =3D strnlen((char *)s->runstate, sizeof(s->runstate)) + 1;
> >
> >      return 0;
>
> I don't think this works correctly if strnlen returns
> sizeof(s->runstate). Which never happens so we probably should
> jus add
>
>         assert(e->size is <=3D sizeof(s->runstate));
>

OK I'll resend Marc-Andr=C3=A9 previous patch.


> But also I think this is not enough, there's a problem in post-load
> in the call to qapi_enum_parse. You probably want to force
> the last character to 0 there.
>

OK, I'll have a look there.


>
> >  }
> > --
> > 2.17.2
>
