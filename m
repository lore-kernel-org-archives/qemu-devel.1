Received: from eggs.gnu.org ([2001:4830:134:3::10]:46255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cQZ7t-0001ud-D6
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 07:32:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cQZ7p-0002fo-3A
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 07:32:37 -0500
Received: from mail-yw0-x22d.google.com ([2607:f8b0:4002:c05::22d]:35415)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cQZ7o-0002f5-V6
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 07:32:33 -0500
Received: by mail-yw0-x22d.google.com with SMTP id v81so322197317ywb.2
	for <qemu-devel@nongnu.org>; Mon, 09 Jan 2017 04:32:31 -0800 (PST)
MIME-Version: 1.0
References: <20170105135957.12003-1-marcandre.lureau@redhat.com>
	<87zij0mno8.fsf@dusky.pond.sub.org>
In-Reply-To: <87zij0mno8.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 09 Jan 2017 12:32:19 +0000
Message-ID: <CAJ+F1CJzGCZt4pHmwOaDXMTg6V2t12Vt4WEcq2p+xbTZ9kCBdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] error: report hints on stderr when no
 monitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

Hi

On Mon, Jan 9, 2017 at 1:23 PM Markus Armbruster <armbru@redhat.com> wrote:

> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > Report the error hint when running from the command line and reaching a=
n
>
> Not just any hint, only the ones printed with error_printf_unless_qmp().
>
> > error, ex:
> >
> > $ qemu-system-x86_64 -m 1Z
> > qemu-system-x86_64: -m 1Z: Parameter 'size' expects a size
> > You may use k, M, G or T suffixes for kilobytes, megabytes, gigabytes
> and terabytes.
>
> The last line is due to this patch.
>
> Suggest to rephrase the commit message:
>
>     error: Report certain hints on stderr when no monitor
>
>     Hints printed with error_printf_unless_qmp() are suppressed outside
>     monitor context.  Reproducer:
>
>         $ qemu-system-x86_64 -m 1Z
>         qemu-system-x86_64: -m 1Z: Parameter 'size' expects a size
>
>     Print to stderr instead.  The reproducer now additionally prints:
>
>         You may use k, M, G or T suffixes for kilobytes, megabytes,
> gigabytes and terabytes.
>
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  monitor.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/monitor.c b/monitor.c
> > index a82f547488..e5cc11b5a5 100644
> > --- a/monitor.c
> > +++ b/monitor.c
> > @@ -3973,6 +3973,8 @@ void error_vprintf_unless_qmp(const char *fmt,
> va_list ap)
> >  {
> >      if (cur_mon && !monitor_cur_is_qmp()) {
> >          monitor_vprintf(cur_mon, fmt, ap);
> > +    } else if (!cur_mon) {
> > +        vfprintf(stderr, fmt, ap);
> >      }
> >  }
>
> Preferably with an improved commit message:
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>

Markus, as maintainer of monitor.c, could you take the patch with the
commit message modified?

thanks
--=20
Marc-Andr=C3=A9 Lureau
