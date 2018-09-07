Received: from eggs.gnu.org ([2001:4830:134:3::10]:42289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fyLtT-0006u8-8Y
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 14:54:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fyLtS-0006aC-7Y
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 14:54:11 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:54891)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fyLtR-0006YI-U1
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 14:54:10 -0400
Received: by mail-wm0-x244.google.com with SMTP id c14-v6so15653960wmb.4
	for <qemu-devel@nongnu.org>; Fri, 07 Sep 2018 11:54:09 -0700 (PDT)
MIME-Version: 1.0
References: <20180907075948.26917-1-marcandre.lureau@redhat.com>
	<20180907075948.26917-2-marcandre.lureau@redhat.com>
	<de1f3585-6201-789d-721d-04707caad93e@redhat.com>
In-Reply-To: <de1f3585-6201-789d-721d-04707caad93e@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 7 Sep 2018 22:53:56 +0400
Message-ID: <CAJ+F1C+P6Lh-gX60rMkvgMfmqmnQVdb1dm=DHE7Fn6ZzykYb-A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 01/12] qdev-monitor: print help to stdout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>

Hi

On Fri, Sep 7, 2018 at 5:49 PM Eric Blake <eblake@redhat.com> wrote:
>
> On 09/07/2018 02:59 AM, Marc-Andr=C3=A9 Lureau wrote:
> > qdev_device_help() is used from command line "-device help", or from
> > HMP "device_add". If used from command line, print help to stdout
> > (it is only printed on explicit demand).
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   include/monitor/monitor.h |  2 ++
> >   monitor.c                 | 16 +++++++++++++---
> >   qdev-monitor.c            | 32 +++++++++++++++++++-------------
> >   3 files changed, 34 insertions(+), 16 deletions(-)
> >
> > diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
> > index 2ef5e04b37..e7667fda35 100644
> > --- a/include/monitor/monitor.h
> > +++ b/include/monitor/monitor.h
> > @@ -47,4 +47,6 @@ int monitor_fdset_dup_fd_add(int64_t fdset_id, int du=
p_fd);
> >   void monitor_fdset_dup_fd_remove(int dup_fd);
> >   int monitor_fdset_dup_fd_find(int dup_fd);
> >
> > +void out_vprintf(FILE *stream, const char *fmt, va_list ap) GCC_FMT_AT=
TR(2, 0);
>
> Perhaps name this monitor_vfprintf()?  (That would match the fact that
> you are using it like normal vfprintf).
>
> > +++ b/qdev-monitor.c
> > @@ -104,22 +104,31 @@ static bool qdev_class_has_alias(DeviceClass *dc)
> >       return (qdev_class_get_alias(dc) !=3D NULL);
> >   }
> >
> > +static void out_printf(const char *fmt, ...)
> > +{
> > +    va_list ap;
> > +
> > +    va_start(ap, fmt);
> > +    out_vprintf(stdout, fmt, ap);
> > +    va_end(ap);
> > +}
>
> But this name seems reasonable.
>
> And I just now see that Thomas also complained about the monitor.h
> naming, but I like 'monitor_vfprintf' better than his 'mon_file_vprintf'.
>
> If an improved name is your only change,
> Reviewed-by: Eric Blake <eblake@redhat.com>

I'll change it to monitor_vfprintf,
thanks

>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>


--=20
Marc-Andr=C3=A9 Lureau
