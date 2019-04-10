Received: from eggs.gnu.org ([209.51.188.92]:34032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <catherine.hecx@gmail.com>) id 1hEFHh-0007CL-Ql
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 11:37:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <catherine.hecx@gmail.com>) id 1hEFHg-0001ox-6A
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 11:37:09 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:39396)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <catherine.hecx@gmail.com>)
	id 1hEFHf-0001mM-MP
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 11:37:08 -0400
Received: by mail-oi1-x243.google.com with SMTP id n187so2145067oih.6
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 08:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <1554689945-18619-1-git-send-email-catherine.hecx@gmail.com>
	<20190408123542.1a4de426@redhat.com>
	<CAEn6zmGHg_Tb1jsvurfrovQNB0R5WZT3mLT7r8R+BEt_4bPbhA@mail.gmail.com>
	<20190410145908.GF2980@work-vm>
In-Reply-To: <20190410145908.GF2980@work-vm>
From: Catherine Ho <catherine.hecx@gmail.com>
Date: Wed, 10 Apr 2019 23:36:55 +0800
Message-ID: <CAEn6zmGGLLJb_7JCZzz-yWYpzkoGN7Vxd4aQ5_pvsMM+Sz8vPw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hostmem-file: warn when
 memory-backend-file, share=on and in incoming migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>

Hi Dr. David

On Wed, 10 Apr 2019 at 22:59, Dr. David Alan Gilbert <dgilbert@redhat.com>
wrote:

> * Catherine Ho (catherine.hecx@gmail.com) wrote:
> > Hi Igor
> >
> >
> > On Mon, 8 Apr 2019 at 18:35, Igor Mammedov <imammedo@redhat.com> wrote:
> >
> > > On Sun,  7 Apr 2019 22:19:05 -0400
> > > Catherine Ho <catherine.hecx@gmail.com> wrote:
> > >
> > > > Currently it is not forbidden to use "-object
> > > memory-backend-file,share=on"
> > > > and together with "-incoming". But after incoming migration is
> finished,
> > > > the memory-backend-file will be definitely written if share=on. So
> the
> > > > memory-backend-file can only be used once, but failed in the 2nd time
> > > > incoming.
> > > >
> > > > Thus it gives a warning and the users can run the qemu if they really
> > > > want to do it.
> > >
> > > Shouldn't we add a migration blocker in such a case instead of warning
> > > and letting qemu run wild?
> > >
> >
> > IMO, it doesn't need to block this. With share=on and -incoming, the user
> > can
> > still save the device memory state into memory-backend file again if
> > ignore-shared
> > capability is on.
> >
> > If we block this, the user can't use the ignore-shared capability in
> > incoming
> > migration.
>
> -incomign with share=on is a perfectly normal thing to do - it just
> depends who you are sharing the file with and the lifetime of that
> shared file.
>
> For example; if you're just running a qemu with vhost-user then you
> use share=on - however wyou typically select the backend file as
> a new file from /dev/shm - it's not a file that you previously migrated
> to.
>
Thanks,
but using a new file from /dev/shm means kernel will start from
start_kernel or early? Is it different from the x-ignore-shared case?
If we remove the share=on in incoming migration, all the writting
of ram will not be flush into the memory backend file. Thus we
can use the base memory backend file for ever.
e.g.
1) save the vm like a snapshot, current ram state is "kernel
has been started, systemd has been started"
2) restore it with -incoming and *no* share=on flag
3) restore it with -incoming and *no* share=on again...
In contrary, if we use share=on, the base backend file will
be written at once after 1st time incoming.

So, IMO, no "share=on" is the proper usage of incoming migration
when ignore-shared is on.
Please correct me if sth is wrong, thanks:)

B.R.
Catherine


> QEMU has no way to know about the provenance of the shared file it's
> been given, so we can't really warn people about it.
>
> Dave
>
> > B.R.
> > Catherine
> >
> > >
> > >
> > > > Signed-off-by: Catherine Ho <catherine.hecx@gmail.com>
> > > > ---
> > > >  backends/hostmem-file.c | 11 +++++++++++
> > > >  1 file changed, 11 insertions(+)
> > > >
> > > > diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
> > > > index 37ac6445d2..59429ee0b4 100644
> > > > --- a/backends/hostmem-file.c
> > > > +++ b/backends/hostmem-file.c
> > > > @@ -16,6 +16,7 @@
> > > >  #include "sysemu/hostmem.h"
> > > >  #include "sysemu/sysemu.h"
> > > >  #include "qom/object_interfaces.h"
> > > > +#include "migration/migration.h"
> > > >
> > > >  /* hostmem-file.c */
> > > >  /**
> > > > @@ -79,6 +80,16 @@ file_backend_memory_alloc(HostMemoryBackend
> *backend,
> > > Error **errp)
> > > >          }
> > > >      }
> > > >
> > > > +    /*
> > > > +     * In ignore shared case, if share=on for host memory backend
> file,
> > > > +     * the ram might be written after incoming process is finished.
> Thus
> > > > +     * the memory backend can't be reused for 2nd/3rd... incoming
> > > > +     */
> > > > +    if (backend->share && migrate_ignore_shared()
> > > > +                       && runstate_check(RUN_STATE_INMIGRATE))
> > > > +        warn_report("share=on for memory backend file might be "
> > > > +                        "conflicted with incoming in ignore shared
> > > case");
> > > > +
> > > >      backend->force_prealloc = mem_prealloc;
> > > >      name = host_memory_backend_get_name(backend);
> > > >      memory_region_init_ram_from_file(&backend->mr, OBJECT(backend),
> > >
> > >
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
