Received: from eggs.gnu.org ([2001:4830:134:3::10]:34585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bishara@daynix.com>) id 1g95gM-0001BR-7s
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 05:49:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bishara@daynix.com>) id 1g95Sw-0004cY-Sn
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 05:35:12 -0400
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141]:33195)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bishara@daynix.com>) id 1g95Sw-0004by-IW
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 05:35:10 -0400
Received: by mail-it1-x141.google.com with SMTP id h6-v6so8079711ith.0
	for <qemu-devel@nongnu.org>; Sun, 07 Oct 2018 02:35:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180927073624.17163-1-bishara@daynix.com>
	<20180927073624.17163-2-bishara@daynix.com>
	<CAJ+F1CJ6n41Sr2Tm4Fd+HQ0QBBCvrE1Jv4mZHXyo6OzJnRXULg@mail.gmail.com>
In-Reply-To: <CAJ+F1CJ6n41Sr2Tm4Fd+HQ0QBBCvrE1Jv4mZHXyo6OzJnRXULg@mail.gmail.com>
From: Bishara AbuHattoum <bishara@daynix.com>
Date: Sun, 7 Oct 2018 12:35:03 +0300
Message-ID: <CADyT_0V5gLNr0v9S2+hvM=8VPWUDUvhKsTH842eZ8OqPsUqYng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/7] qga: group agent init/cleanup init
 separate routines
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

On Thu, Sep 27, 2018 at 2:44 PM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@gmail.com> wrote:

> Hi
>
> On Thu, Sep 27, 2018 at 11:37 AM Bishara AbuHattoum <bishara@daynix.com>
> wrote:
> >
> > From: Michael Roth <mdroth@linux.vnet.ibm.com>
> >
> > This patch better separates the init/cleanup routines out into
> > separate functions to make make the start-up procedure a bit easier
>
> "make make"
>
> > to follow. This will be useful when we eventually break out the
> > actual start/stop of the agent's main loop into separates routines
> > that can be called multiple times after the init phase.
> >
> > Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> > Message-Id: <20171026233054.21133-2-mdroth@linux.vnet.ibm.com>
>
> I don't know if it make sense to retain the original Message-Id.
>
> it is not as good as it used to wrt to cleaning up on error, but that
> may be acceptable..
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> > ---
> >  qga/main.c | 82 +++++++++++++++++++++++++++++++++---------------------
> >  1 file changed, 50 insertions(+), 32 deletions(-)
> >
> > diff --git a/qga/main.c b/qga/main.c
> > index 6d70242d05..7b7b837a14 100644
> > --- a/qga/main.c
> > +++ b/qga/main.c
> > @@ -1245,9 +1245,21 @@ static bool check_is_frozen(GAState *s)
> >      return false;
> >  }
> >
> > -static int run_agent(GAState *s, GAConfig *config, int
> socket_activation)
> > +static GAState *initialize_agent(GAConfig *config)
> >  {
> > -    ga_state =3D s;
> > +    GAState *s =3D g_new0(GAState, 1);
> > +
> > +    g_assert(ga_state =3D=3D NULL);
> > +
> > +    s->log_level =3D config->log_level;
> > +    s->log_file =3D stderr;
> > +#ifdef CONFIG_FSFREEZE
> > +    s->fsfreeze_hook =3D config->fsfreeze_hook;
> > +#endif
> > +    s->pstate_filepath =3D g_strdup_printf("%s/qga.state",
> config->state_dir);
> > +    s->state_filepath_isfrozen =3D
> g_strdup_printf("%s/qga.state.isfrozen",
> > +                                                 config->state_dir);
> > +    s->frozen =3D check_is_frozen(s);
> >
> >      g_log_set_default_handler(ga_log, s);
> >      g_log_set_fatal_mask(NULL, G_LOG_LEVEL_ERROR);
> > @@ -1263,7 +1275,7 @@ static int run_agent(GAState *s, GAConfig *config=
,
> int socket_activation)
> >      if (g_mkdir_with_parents(config->state_dir, S_IRWXU) =3D=3D -1) {
> >          g_critical("unable to create (an ancestor of) the state
> directory"
> >                     " '%s': %s", config->state_dir, strerror(errno));
> > -        return EXIT_FAILURE;
> > +        return NULL;
> >      }
> >  #endif
> >
> > @@ -1288,7 +1300,7 @@ static int run_agent(GAState *s, GAConfig *config=
,
> int socket_activation)
> >              if (!log_file) {
> >                  g_critical("unable to open specified log file: %s",
> >                             strerror(errno));
> > -                return EXIT_FAILURE;
> > +                return NULL;
> >              }
> >              s->log_file =3D log_file;
> >          }
> > @@ -1299,7 +1311,7 @@ static int run_agent(GAState *s, GAConfig *config=
,
> int socket_activation)
> >                                 s->pstate_filepath,
> >                                 ga_is_frozen(s))) {
> >          g_critical("failed to load persistent state");
> > -        return EXIT_FAILURE;
> > +        return NULL;
> >      }
> >
> >      config->blacklist =3D ga_command_blacklist_init(config->blacklist)=
;
> > @@ -1320,12 +1332,37 @@ static int run_agent(GAState *s, GAConfig
> *config, int socket_activation)
> >  #ifndef _WIN32
> >      if (!register_signal_handlers()) {
> >          g_critical("failed to register signal handlers");
> > -        return EXIT_FAILURE;
> > +        return NULL;
> >      }
> >  #endif
> >
> >      s->main_loop =3D g_main_loop_new(NULL, false);
> >
> > +    ga_state =3D s;
> > +    return s;
> > +}
> > +
> > +static void cleanup_agent(GAState *s)
> > +{
> > +    if (s->command_state) {
> > +        ga_command_state_cleanup_all(s->command_state);
> > +        ga_command_state_free(s->command_state);
> > +        json_message_parser_destroy(&s->parser);
> > +    }
> > +    if (s->channel) {
> > +        ga_channel_free(s->channel);
> > +    }
> > +    g_free(s->pstate_filepath);
> > +    g_free(s->state_filepath_isfrozen);
> > +    if (s->main_loop) {
> > +        g_main_loop_unref(s->main_loop);
> > +    }
> > +    g_free(s);
> > +    ga_state =3D NULL;
> > +}
> > +
> > +static int run_agent(GAState *s, GAConfig *config, int
> socket_activation)
> > +{
> >      if (!channel_init(ga_state, config->method, config->channel_path,
> >                        socket_activation ? FIRST_SOCKET_ACTIVATION_FD :
> -1)) {
> >          g_critical("failed to initialize guest agent channel");
> > @@ -1349,7 +1386,7 @@ static int run_agent(GAState *s, GAConfig *config=
,
> int socket_activation)
> >  int main(int argc, char **argv)
> >  {
> >      int ret =3D EXIT_SUCCESS;
> > -    GAState *s =3D g_new0(GAState, 1);
> > +    GAState *s;
> >      GAConfig *config =3D g_new0(GAConfig, 1);
> >      int socket_activation;
> >
> > @@ -1417,44 +1454,25 @@ int main(int argc, char **argv)
> >          }
> >      }
> >
> > -    s->log_level =3D config->log_level;
> > -    s->log_file =3D stderr;
> > -#ifdef CONFIG_FSFREEZE
> > -    s->fsfreeze_hook =3D config->fsfreeze_hook;
> > -#endif
> > -    s->pstate_filepath =3D g_strdup_printf("%s/qga.state",
> config->state_dir);
> > -    s->state_filepath_isfrozen =3D
> g_strdup_printf("%s/qga.state.isfrozen",
> > -                                                 config->state_dir);
> > -    s->frozen =3D check_is_frozen(s);
> > -
> >      if (config->dumpconf) {
> >          config_dump(config);
> >          goto end;
> >      }
> >
> > +    s =3D initialize_agent(config);
> > +    if (!s) {
> > +        g_critical("error initializing guest agent");
> > +        goto end;
> > +    }
> >      ret =3D run_agent(s, config, socket_activation);
> > +    cleanup_agent(s);
> >
> >  end:
> > -    if (s->command_state) {
> > -        ga_command_state_cleanup_all(s->command_state);
> > -        ga_command_state_free(s->command_state);
> > -        json_message_parser_destroy(&s->parser);
> > -    }
> > -    if (s->channel) {
> > -        ga_channel_free(s->channel);
> > -    }
> > -    g_free(s->pstate_filepath);
> > -    g_free(s->state_filepath_isfrozen);
> > -
> >      if (config->daemonize) {
> >          unlink(config->pid_filepath);
> >      }
> >
> >      config_free(config);
> > -    if (s->main_loop) {
> > -        g_main_loop_unref(s->main_loop);
> > -    }
> > -    g_free(s);
> >
> >      return ret;
> >  }
> > --
> > 2.17.0
> >
> >
>
>
> --
> Marc-Andr=C3=A9 Lureau
>
