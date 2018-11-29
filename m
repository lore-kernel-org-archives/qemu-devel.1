Received: from eggs.gnu.org ([2001:4830:134:3::10]:34247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1gSNlm-0000g4-NK
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:58:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1gSNgO-0000dg-Qf
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:52:53 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51115)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1gSNgO-0000cu-KS
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:52:48 -0500
Received: by mail-wm1-f68.google.com with SMTP id 125so2577894wmh.0
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 06:52:47 -0800 (PST)
MIME-Version: 1.0
References: <20181129100340.13823-1-fli@suse.com>
	<20181129100340.13823-5-fli@suse.com>
	<35413c93-dd69-83bd-e144-444a7e94c001@redhat.com>
In-Reply-To: <35413c93-dd69-83bd-e144-444a7e94c001@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Thu, 29 Nov 2018 15:52:34 +0100
Message-ID: <CAP+75-Xk1NBoqneXE15iv6z1+OKt-WZXgH_DsD7w9-Z+-r0Xdw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v2 4/5] migration: remove unused
 &local_err parameter in multifd_save_cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fei Li <fli@suse.com>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, Nov 29, 2018 at 3:50 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
> On 29/11/18 11:03, Fei Li wrote:
> > Always call migrate_set_error() to set the error state without relying
> > on whether multifd_save_cleanup() succeeds.  As the passed &local_err
> > is never used in multifd_save_cleanup(), remove it. And make the
> > function be: void multifd_save_cleanup(void).
>
> Reading this after your patch 1/5, maybe multifd_save_cleanup() lacks

I wanted to write "2/5: qemu_thread_join: fix segmentation fault"

> error reporting on failure. So the actual prototype is correct, we just
> need to use **errp in that function (like reporting invalid thread
> instead of calling qemu_thread_join()).
>
> >
> > Signed-off-by: Fei Li <fli@suse.com>
> > Reviewed-by: Juan Quintela <quintela@redhat.com>
> > ---
> >  migration/migration.c |  5 +----
> >  migration/ram.c       | 11 ++++-------
> >  migration/ram.h       |  2 +-
> >  3 files changed, 6 insertions(+), 12 deletions(-)
> >
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 72106bddf0..0537fc0c26 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -1386,7 +1386,6 @@ static void migrate_fd_cleanup(void *opaque)
> >      qemu_savevm_state_cleanup();
> >
> >      if (s->to_dst_file) {
> > -        Error *local_err =3D NULL;
> >          QEMUFile *tmp;
> >
> >          trace_migrate_fd_cleanup();
> > @@ -1397,9 +1396,7 @@ static void migrate_fd_cleanup(void *opaque)
> >          }
> >          qemu_mutex_lock_iothread();
> >
> > -        if (multifd_save_cleanup(&local_err) !=3D 0) {
> > -            error_report_err(local_err);
> > -        }
> > +        multifd_save_cleanup();
> >          qemu_mutex_lock(&s->qemu_file_lock);
> >          tmp =3D s->to_dst_file;
> >          s->to_dst_file =3D NULL;
> > diff --git a/migration/ram.c b/migration/ram.c
> > index e13b9349d0..c44cb6f56d 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -917,13 +917,12 @@ static void multifd_send_terminate_threads(Error =
*err)
> >      }
> >  }
> >
> > -int multifd_save_cleanup(Error **errp)
> > +void multifd_save_cleanup(void)
> >  {
> >      int i;
> > -    int ret =3D 0;
> >
> >      if (!migrate_use_multifd()) {
> > -        return 0;
> > +        return;
> >      }
> >      multifd_send_terminate_threads(NULL);
> >      for (i =3D 0; i < migrate_multifd_channels(); i++) {
> > @@ -953,7 +952,6 @@ int multifd_save_cleanup(Error **errp)
> >      multifd_send_state->pages =3D NULL;
> >      g_free(multifd_send_state);
> >      multifd_send_state =3D NULL;
> > -    return ret;
> >  }
> >
> >  static void multifd_send_sync_main(void)
> > @@ -1071,9 +1069,8 @@ static void multifd_new_send_channel_async(QIOTas=
k *task, gpointer opaque)
> >      Error *local_err =3D NULL;
> >
> >      if (qio_task_propagate_error(task, &local_err)) {
> > -        if (multifd_save_cleanup(&local_err) !=3D 0) {
> > -            migrate_set_error(migrate_get_current(), local_err);
> > -        }
> > +        migrate_set_error(migrate_get_current(), local_err);
> > +        multifd_save_cleanup();
> >      } else {
> >          p->c =3D QIO_CHANNEL(sioc);
> >          qio_channel_set_delay(p->c, false);
> > diff --git a/migration/ram.h b/migration/ram.h
> > index 046d3074be..936177b3e9 100644
> > --- a/migration/ram.h
> > +++ b/migration/ram.h
> > @@ -43,7 +43,7 @@ uint64_t ram_bytes_remaining(void);
> >  uint64_t ram_bytes_total(void);
> >
> >  int multifd_save_setup(void);
> > -int multifd_save_cleanup(Error **errp);
> > +void multifd_save_cleanup(void);
> >  int multifd_load_setup(void);
> >  int multifd_load_cleanup(Error **errp);
> >  bool multifd_recv_all_channels_created(void);
> >
