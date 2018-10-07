Received: from eggs.gnu.org ([2001:4830:134:3::10]:34505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bishara@daynix.com>) id 1g95gJ-00016m-Ih
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 05:49:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bishara@daynix.com>) id 1g95XK-0008NC-V3
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 05:39:43 -0400
Received: from mail-it1-x12e.google.com ([2607:f8b0:4864:20::12e]:35063)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bishara@daynix.com>) id 1g95XK-0008MD-Np
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 05:39:42 -0400
Received: by mail-it1-x12e.google.com with SMTP id p64-v6so8242418itp.0
	for <qemu-devel@nongnu.org>; Sun, 07 Oct 2018 02:39:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180927073624.17163-1-bishara@daynix.com>
	<20180927073624.17163-4-bishara@daynix.com>
	<CAJ+F1C+AROSNmnX6OWJ+dF5LozLQ8Afz6YB+Gq9y+epKmjB+Wg@mail.gmail.com>
In-Reply-To: <CAJ+F1C+AROSNmnX6OWJ+dF5LozLQ8Afz6YB+Gq9y+epKmjB+Wg@mail.gmail.com>
From: Bishara AbuHattoum <bishara@daynix.com>
Date: Sun, 7 Oct 2018 12:39:36 +0300
Message-ID: <CADyT_0VWhyf_3OJkA8NrO4D_=oFbMcZgvLwmShwr3CGEHpu7dQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/7] qga: move w32 service handling out of
 run_agent()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@gmail.com
Cc: QEMU Developers <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Yan Vugenfirer <yan@daynix.com>

As I already clarified in the cover letter, I will fix the typo in the
commit message and drop the message ID from all the patches, changes will
be in the next version.

On Thu, Sep 27, 2018 at 2:45 PM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@gmail.com> wrote:

> Hi
>
> On Thu, Sep 27, 2018 at 11:39 AM Bishara AbuHattoum <bishara@daynix.com>
> wrote:
> >
> > From: Michael Roth <mdroth@linux.vnet.ibm.com>
> >
> > Eventually we want a w32 service to be able to restart the qga main
> > loop from within service_main(). To allow for this we move service
> > handling out of run_agent() such that service_main() calls
> > run_agent() instead of the reverse.
> >
> > Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> > Message-Id: <20171026233054.21133-4-mdroth@linux.vnet.ibm.com>
>
> Same remark about message-id
>
> > ---
> >  qga/main.c | 25 ++++++++++++++-----------
> >  1 file changed, 14 insertions(+), 11 deletions(-)
> >
> > diff --git a/qga/main.c b/qga/main.c
> > index 7381053a0f..d9888bff5f 100644
> > --- a/qga/main.c
> > +++ b/qga/main.c
> > @@ -136,6 +136,7 @@ DWORD WINAPI service_ctrl_handler(DWORD ctrl, DWORD
> type, LPVOID data,
> >                                    LPVOID ctx);
> >  VOID WINAPI service_main(DWORD argc, TCHAR *argv[]);
> >  #endif
> > +static int run_agent(GAState *s);
> >
> >  static void
> >  init_dfl_pathnames(void)
> > @@ -763,7 +764,7 @@ VOID WINAPI service_main(DWORD argc, TCHAR *argv[])
> >      service->status.dwWaitHint =3D 0;
> >      SetServiceStatus(service->status_handle, &service->status);
> >
> > -    g_main_loop_run(ga_state->main_loop);
> > +    run_agent(ga_state);
> >
> >      service->status.dwCurrentState =3D SERVICE_STOPPED;
> >      SetServiceStatus(service->status_handle, &service->status);
> > @@ -1372,17 +1373,8 @@ static int run_agent(GAState *s)
> >          g_critical("failed to initialize guest agent channel");
> >          return EXIT_FAILURE;
> >      }
> > -#ifndef _WIN32
> > +
> >      g_main_loop_run(ga_state->main_loop);
> > -#else
> > -    if (config->daemonize) {
> > -        SERVICE_TABLE_ENTRY service_table[] =3D {
> > -            { (char *)QGA_SERVICE_NAME, service_main }, { NULL, NULL }
> };
> > -        StartServiceCtrlDispatcher(service_table);
> > -    } else {
> > -        g_main_loop_run(ga_state->main_loop);
> > -    }
> > -#endif
> >
> >      return EXIT_SUCCESS;
> >  }
> > @@ -1468,7 +1460,18 @@ int main(int argc, char **argv)
> >          g_critical("error initializing guest agent");
> >          goto end;
> >      }
> > +
> > +#ifdef _WIN32
> > +    if (config->daemonize) {
> > +        SERVICE_TABLE_ENTRY service_table[] =3D {
> > +            { (char *)QGA_SERVICE_NAME, service_main }, { NULL, NULL }
> };
> > +        StartServiceCtrlDispatcher(service_table);
> > +    } else {
> > +        ret =3D run_agent(s);
> > +    }
> > +#endif
> >      ret =3D run_agent(s);
>
> run_agent() is called twice.
>
> > +
> >      cleanup_agent(s);
> >
> >  end:
> > --
> > 2.17.0
> >
> >
>
>
> --
> Marc-Andr=C3=A9 Lureau
>
