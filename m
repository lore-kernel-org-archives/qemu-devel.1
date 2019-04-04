Received: from eggs.gnu.org ([209.51.188.92]:54914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1hBxjG-0001xe-IE
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 04:28:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1hBxYj-00011I-FL
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 04:17:19 -0400
Received: from mga06.intel.com ([134.134.136.31]:7719)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chen.zhang@intel.com>)
	id 1hBxYi-0000xx-Ub
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 04:17:17 -0400
From: "Zhang, Chen" <chen.zhang@intel.com>
Date: Thu, 4 Apr 2019 08:17:09 +0000
Message-ID: <9CFF81C0F6B98A43A459C9EDAD400D78060B8B4C@shsmsx102.ccr.corp.intel.com>
References: <20190329222951.28945-1-chen.zhang@intel.com>
	<5CA1D5CE.6040400@intel.com>
In-Reply-To: <5CA1D5CE.6040400@intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] migration/ram.c: Fix codes conflict about
 bitmap_mutex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Wang, Wei W" <wei.w.wang@intel.com>, Zhang Chen <zhangckid@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-dev <qemu-devel@nongnu.org>

Ping~  Anyone have comments about this patch?

Thanks
Zhang Chen


> -----Original Message-----
> From: Wang, Wei W
> Sent: Monday, April 1, 2019 5:12 PM
> To: Zhang, Chen <chen.zhang@intel.com>; Zhang Chen
> <zhangckid@gmail.com>; Dr. David Alan Gilbert <dgilbert@redhat.com>; Juan
> Quintela <quintela@redhat.com>; qemu-dev <qemu-devel@nongnu.org>
> Subject: Re: [PATCH] migration/ram.c: Fix codes conflict about bitmap_mut=
ex
>=20
> On 03/30/2019 06:29 AM, Zhang Chen wrote:
> > From: Zhang Chen <chen.zhang@intel.com>
> >
> > I found upstream codes conflict with COLO and lead to crash, and I
> > located to this patch:
> >
> > commit 386a907b37a9321bc5d699bc37104d6ffba1b34d
> > Author: Wei Wang <wei.w.wang@intel.com>
> > Date:   Tue Dec 11 16:24:49 2018 +0800
> >
> > migration: use bitmap_mutex in migration_bitmap_clear_dirty
> >
> > My colleague Wei's patch add bitmap_mutex in
> > migration_bitmap_clear_dirty, but COLO didn't initialize the
> > bitmap_mutex. So we always get an error when COLO start up. like that:
> > qemu-system-x86_64: util/qemu-thread-posix.c:64: qemu_mutex_lock_impl:
> Assertion `mutex->initialized' failed.
> >
> > This patch add the bitmap_mutex initialize and destroy in COLO
> > lifecycle.
> >
> > Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> > ---
> >   migration/ram.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/migration/ram.c b/migration/ram.c index
> > d7f8fe45a8..f68beeeeff 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -3918,6 +3918,7 @@ int colo_init_ram_cache(void)
> >       }
> >       ram_state =3D g_new0(RAMState, 1);
> >       ram_state->migration_dirty_pages =3D 0;
> > +    qemu_mutex_init(&ram_state->bitmap_mutex);
> >       memory_global_dirty_log_start();
> >
> >       return 0;
> > @@ -3956,6 +3957,7 @@ void colo_release_ram_cache(void)
> >       }
> >
> >       rcu_read_unlock();
> > +    qemu_mutex_destroy(&ram_state->bitmap_mutex);
> >       g_free(ram_state);
> >       ram_state =3D NULL;
> >   }
>=20
> Reviewed-by: Wei Wang <wei.w.wang@intel.com>
>=20
> Best,
> Wei
