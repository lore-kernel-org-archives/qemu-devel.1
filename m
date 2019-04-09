Received: from eggs.gnu.org ([209.51.188.92]:58491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <catherine.hecx@gmail.com>) id 1hDgOa-0002qz-Tk
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 22:21:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <catherine.hecx@gmail.com>) id 1hDgOX-00059f-GM
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 22:21:55 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:44476)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <catherine.hecx@gmail.com>)
	id 1hDgOT-000562-L3
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 22:21:51 -0400
Received: by mail-oi1-x244.google.com with SMTP id i21so12218574oib.11
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 19:21:48 -0700 (PDT)
MIME-Version: 1.0
References: <1554689945-18619-1-git-send-email-catherine.hecx@gmail.com>
	<20190408123542.1a4de426@redhat.com>
In-Reply-To: <20190408123542.1a4de426@redhat.com>
From: Catherine Ho <catherine.hecx@gmail.com>
Date: Tue, 9 Apr 2019 10:21:36 +0800
Message-ID: <CAEn6zmGHg_Tb1jsvurfrovQNB0R5WZT3mLT7r8R+BEt_4bPbhA@mail.gmail.com>
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
To: Igor Mammedov <imammedo@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>

Hi Igor


On Mon, 8 Apr 2019 at 18:35, Igor Mammedov <imammedo@redhat.com> wrote:

> On Sun,  7 Apr 2019 22:19:05 -0400
> Catherine Ho <catherine.hecx@gmail.com> wrote:
>
> > Currently it is not forbidden to use "-object
> memory-backend-file,share=on"
> > and together with "-incoming". But after incoming migration is finished,
> > the memory-backend-file will be definitely written if share=on. So the
> > memory-backend-file can only be used once, but failed in the 2nd time
> > incoming.
> >
> > Thus it gives a warning and the users can run the qemu if they really
> > want to do it.
>
> Shouldn't we add a migration blocker in such a case instead of warning
> and letting qemu run wild?
>

IMO, it doesn't need to block this. With share=on and -incoming, the user
can
still save the device memory state into memory-backend file again if
ignore-shared
capability is on.

If we block this, the user can't use the ignore-shared capability in
incoming
migration.

B.R.
Catherine

>
>
> > Signed-off-by: Catherine Ho <catherine.hecx@gmail.com>
> > ---
> >  backends/hostmem-file.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
> > index 37ac6445d2..59429ee0b4 100644
> > --- a/backends/hostmem-file.c
> > +++ b/backends/hostmem-file.c
> > @@ -16,6 +16,7 @@
> >  #include "sysemu/hostmem.h"
> >  #include "sysemu/sysemu.h"
> >  #include "qom/object_interfaces.h"
> > +#include "migration/migration.h"
> >
> >  /* hostmem-file.c */
> >  /**
> > @@ -79,6 +80,16 @@ file_backend_memory_alloc(HostMemoryBackend *backend,
> Error **errp)
> >          }
> >      }
> >
> > +    /*
> > +     * In ignore shared case, if share=on for host memory backend file,
> > +     * the ram might be written after incoming process is finished. Thus
> > +     * the memory backend can't be reused for 2nd/3rd... incoming
> > +     */
> > +    if (backend->share && migrate_ignore_shared()
> > +                       && runstate_check(RUN_STATE_INMIGRATE))
> > +        warn_report("share=on for memory backend file might be "
> > +                        "conflicted with incoming in ignore shared
> case");
> > +
> >      backend->force_prealloc = mem_prealloc;
> >      name = host_memory_backend_get_name(backend);
> >      memory_region_init_ram_from_file(&backend->mr, OBJECT(backend),
>
>
