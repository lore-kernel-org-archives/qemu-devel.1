Received: from eggs.gnu.org ([209.51.188.92]:47033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <catherine.hecx@gmail.com>) id 1hDNZT-00074j-Hb
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 02:15:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <catherine.hecx@gmail.com>) id 1hDNZR-0000Gj-GW
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 02:15:55 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:35274)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <catherine.hecx@gmail.com>)
	id 1hDNZN-0000EY-Hd
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 02:15:51 -0400
Received: by mail-ot1-x344.google.com with SMTP id m10so10954081otp.2
	for <qemu-devel@nongnu.org>; Sun, 07 Apr 2019 23:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <1554689945-18619-1-git-send-email-catherine.hecx@gmail.com>
	<20190408032543.GE23212@xz-x1>
In-Reply-To: <20190408032543.GE23212@xz-x1>
From: Catherine Ho <catherine.hecx@gmail.com>
Date: Mon, 8 Apr 2019 14:15:36 +0800
Message-ID: <CAEn6zmE3tjtZrusqZptkgqi2CFaNndsVHekr9=uxS=YptcbQzQ@mail.gmail.com>
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
To: Peter Xu <peterx@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Hi Peter Xu

On Mon, 8 Apr 2019 at 11:25, Peter Xu <peterx@redhat.com> wrote:

> On Sun, Apr 07, 2019 at 10:19:05PM -0400, Catherine Ho wrote:
> > Currently it is not forbidden to use "-object
> memory-backend-file,share=on"
> > and together with "-incoming". But after incoming migration is finished,
> > the memory-backend-file will be definitely written if share=on. So the
> > memory-backend-file can only be used once, but failed in the 2nd time
> > incoming.
> >
> > Thus it gives a warning and the users can run the qemu if they really
> > want to do it.
> >
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
>
> I feel like this message wasn't really clear to me...  you want to
> warn people these data might not match with each other, right?  How
> about simply state it:
>
>   NOTE: Please make sure the data on the shared memory backend file
>   and the data from the incoming migration stream contains matching
>   contents, otherwise...
>

Sorry for my vague expression.
The background is [1]
I happened to use "-object memory-backend-file,share=on" and together with
"-incoming".
It worked fine in 1st incoming migration but failed in 2nd, 3rd incoming
migration.
Because qemu uses qemu_ram_mmap(..., MAP_SHARED,...) when share=on, the
memory-backend-file will be written after 1st incoming migration.
Finally I realized that this was caused by "share=on" flag, and after I
removed it,
the memory-backend-file will not be changed any more.

So do you think it will be better that qemu gives the user a clear warning
that
incoming migration will change the data in  memory-backend-file  with
"share=on" ?

[1] http://lists.nongnu.org/archive/html/qemu-devel/2019-04/msg00350.html


> Regards,
>
> --
> Peter Xu
>
