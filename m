Received: from eggs.gnu.org ([2001:4830:134:3::10]:57633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gP9lg-0005GX-Qe
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 12:24:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gP9lc-0004j1-3F
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 12:24:56 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34961)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gP9lb-0004iM-TG
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 12:24:51 -0500
Received: by mail-qt1-f195.google.com with SMTP id v11so848925qtc.2
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 09:24:51 -0800 (PST)
MIME-Version: 1.0
References: <20181120152753.10463-1-marcandre.lureau@redhat.com>
	<20181120152753.10463-3-marcandre.lureau@redhat.com>
	<03454b5c-f889-9401-f502-5b14eaab40c8@redhat.com>
	<20181120172241.GC5072@work-vm>
In-Reply-To: <20181120172241.GC5072@work-vm>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Nov 2018 21:24:39 +0400
Message-ID: <CAMxuvax0K1BH3gCXeJ2=0G7EBvpTgHV1TefK8Yp8XzyXaFyieQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.1? 2/3] migration: fix
 stringop-truncation warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: "Blake, Eric" <eblake@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, "Wolf, Kevin" <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>, Jeff Cody <jcody@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Max Reitz <mreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "unix, namei" <namei.unix@gmail.com>

Hi

On Tue, Nov 20, 2018 at 9:22 PM Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
>
> * Eric Blake (eblake@redhat.com) wrote:
> > On 11/20/18 9:27 AM, Marc-Andr=C3=A9 Lureau wrote:
> > > Adding an assert is enough to silence GCC.
> > >
> > > ~/src/qemu/migration/global_state.c: In function 'global_state_store_=
running':
> > > ~/src/qemu/migration/global_state.c:45:5: error: 'strncpy' specified =
bound 100 equals destination size [-Werror=3Dstringop-truncation]
> > >       strncpy((char *)global_state.runstate,
> > >       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >              state, sizeof(global_state.runstate));
> > >              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > cc1: all warnings being treated as errors
> > >
> > > (alternatively, we could hard-code "running")
> > >
> > > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > ---
> > >   migration/global_state.c | 1 +
> > >   1 file changed, 1 insertion(+)
> >
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> >
> > I think this is safe for 3.1, but I know the migration code is particul=
arly
> > wary of assert()s, even when they are non-triggerable (a 100-byte buffe=
r at
> > global_state.runstate is big enough for ALL of the run states, not just
> > RUN_STATE_RUNNING).
>
> That's OK; the universe would have to be particularly broken to trigger
> that one, and it's in no way connected with any state, so it would
> trigger on even the most basic tests.
>
> However, I wonder if this fixes the problem on mingw builds - windows
> asserts are not marked as noreturn.

On f29, with mingw64-gcc-8.2.0-3.fc29.x86_64, it fixes the warning.

>
> Dave
>
> > >
> > > diff --git a/migration/global_state.c b/migration/global_state.c
> > > index 8e8ab5c51e..01805c567a 100644
> > > --- a/migration/global_state.c
> > > +++ b/migration/global_state.c
> > > @@ -42,6 +42,7 @@ int global_state_store(void)
> > >   void global_state_store_running(void)
> > >   {
> > >       const char *state =3D RunState_str(RUN_STATE_RUNNING);
> > > +    assert(strlen(state) < sizeof(global_state.runstate));
> > >       strncpy((char *)global_state.runstate,
> > >              state, sizeof(global_state.runstate));
> > >   }
> > >
> >
> > --
> > Eric Blake, Principal Software Engineer
> > Red Hat, Inc.           +1-919-301-3266
> > Virtualization:  qemu.org | libvirt.org
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
