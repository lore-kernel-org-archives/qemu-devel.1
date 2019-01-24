Received: from eggs.gnu.org ([209.51.188.92]:57422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gmjoM-0006k0-0o
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 13:33:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gmjoJ-0001Cz-Fj
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 13:33:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gmjoJ-0001CS-6a
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 13:33:07 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7165C74F12
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 18:33:06 +0000 (UTC)
Date: Thu, 24 Jan 2019 18:32:58 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190124183257.GF2101@work-vm>
References: <20190121170434.13592-1-cfergeau@redhat.com>
	<87munqc9zf.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87munqc9zf.fsf@dusky.pond.sub.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5] log: Make glib logging go through QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Christophe Fergeau <cfergeau@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

* Markus Armbruster (armbru@redhat.com) wrote:
> Christophe Fergeau <cfergeau@redhat.com> writes:
>=20
> > This commit adds a qemu_init_logging() helper which calls
> > g_log_set_default_handler() so that glib logs (g_log, g_warning, ...)
> > are handled similarly to other QEMU logs. This means they will get a
> > timestamp if timestamps are enabled, and they will go through the
> > monitor if one is configured.
>=20
> s/monitor/HMP monitor/
>=20
> I see why one would like to extend the timestamp feature to GLib log
> messages.  Routing them through the HMP monitor is perhaps debatable.
> Cc: Dave in case he has an opinion.

Yes, it's a little odd; what's wrong with stderr for this type of thing?
My experience has been that things like spice errors are fairly
asynchronous rather than directly triggered by commands, so maybe less
suitable for interleaving in the monitor.

While stderr and hmp output are normally the same, if someone has
HMP wired to a script, I'd assume this is more likely to break it.

Dave

> > This commit also adds a call to qemu_init_logging() to the binaries
> > installed by QEMU.
> > glib debug messages are enabled through G_MESSAGES_DEBUG similarly to
> > glib default log handler.
> >
> > At the moment, this change will mostly impact SPICE logging if your
> > spice version is >=3D 0.14.1. With older spice versions, this is not =
going
> > to work as expected, but will not have any ill effect, so this call i=
s
> > not conditional on the SPICE version.
> >
> > Signed-off-by: Christophe Fergeau <cfergeau@redhat.com>
> > Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> > One more iteration of the patch as it hit CI failures
> > (https://patchew.org/QEMU/20181214105642.673-1-cfergeau@redhat.com/ )
> > Only difference from v4 is the addition of #include "qemu/error-repor=
t.h"
> > in bsd-user and linux-user.
> >
> >
> >  bsd-user/main.c             |  2 ++
> >  include/qemu/error-report.h |  2 ++
> >  linux-user/main.c           |  2 ++
> >  qemu-img.c                  |  1 +
> >  qemu-io.c                   |  1 +
> >  qemu-nbd.c                  |  1 +
> >  scsi/qemu-pr-helper.c       |  1 +
> >  util/qemu-error.c           | 47 +++++++++++++++++++++++++++++++++++=
++
> >  vl.c                        |  1 +
> >  9 files changed, 58 insertions(+)
> >
> > diff --git a/bsd-user/main.c b/bsd-user/main.c
> > index 0d3156974c..0df5c853d3 100644
> > --- a/bsd-user/main.c
> > +++ b/bsd-user/main.c
> > @@ -24,6 +24,7 @@
> >  #include "qapi/error.h"
> >  #include "qemu.h"
> >  #include "qemu/config-file.h"
> > +#include "qemu/error-report.h"
> >  #include "qemu/path.h"
> >  #include "qemu/help_option.h"
> >  #include "cpu.h"
> > @@ -743,6 +744,7 @@ int main(int argc, char **argv)
> >      if (argc <=3D 1)
> >          usage();
> > =20
> > +    qemu_init_logging();
> >      module_call_init(MODULE_INIT_TRACE);
> >      qemu_init_cpu_list();
> >      module_call_init(MODULE_INIT_QOM);
> > diff --git a/include/qemu/error-report.h b/include/qemu/error-report.=
h
> > index 0a8d9cc9ea..2852e9df2a 100644
> > --- a/include/qemu/error-report.h
> > +++ b/include/qemu/error-report.h
> > @@ -49,6 +49,8 @@ bool error_report_once_cond(bool *printed, const ch=
ar *fmt, ...)
> >  bool warn_report_once_cond(bool *printed, const char *fmt, ...)
> >      GCC_FMT_ATTR(2, 3);
> > =20
> > +void qemu_init_logging(void);
> > +
> >  /*
> >   * Similar to error_report(), except it prints the message just once=
.
> >   * Return true when it prints, false otherwise.
> > diff --git a/linux-user/main.c b/linux-user/main.c
> > index a0aba9cb1e..d9b3ffd1f4 100644
> > --- a/linux-user/main.c
> > +++ b/linux-user/main.c
> > @@ -27,6 +27,7 @@
> >  #include "qemu/path.h"
> >  #include "qemu/config-file.h"
> >  #include "qemu/cutils.h"
> > +#include "qemu/error-report.h"
> >  #include "qemu/help_option.h"
> >  #include "cpu.h"
> >  #include "exec/exec-all.h"
> > @@ -600,6 +601,7 @@ int main(int argc, char **argv, char **envp)
> >      int ret;
> >      int execfd;
> > =20
> > +    qemu_init_logging();
> >      module_call_init(MODULE_INIT_TRACE);
> >      qemu_init_cpu_list();
> >      module_call_init(MODULE_INIT_QOM);
> > diff --git a/qemu-img.c b/qemu-img.c
> > index ad04f59565..9214392565 100644
> > --- a/qemu-img.c
> > +++ b/qemu-img.c
> > @@ -4912,6 +4912,7 @@ int main(int argc, char **argv)
> >      signal(SIGPIPE, SIG_IGN);
> >  #endif
> > =20
> > +    qemu_init_logging();
> >      module_call_init(MODULE_INIT_TRACE);
> >      error_set_progname(argv[0]);
> >      qemu_init_exec_dir(argv[0]);
> > diff --git a/qemu-io.c b/qemu-io.c
> > index 6df7731af4..ad38d12e68 100644
> > --- a/qemu-io.c
> > +++ b/qemu-io.c
> > @@ -524,6 +524,7 @@ int main(int argc, char **argv)
> >      signal(SIGPIPE, SIG_IGN);
> >  #endif
> > =20
> > +    qemu_init_logging();
> >      module_call_init(MODULE_INIT_TRACE);
> >      progname =3D g_path_get_basename(argv[0]);
> >      qemu_init_exec_dir(argv[0]);
> > diff --git a/qemu-nbd.c b/qemu-nbd.c
> > index 51b55f2e06..274b22d445 100644
> > --- a/qemu-nbd.c
> > +++ b/qemu-nbd.c
> > @@ -581,6 +581,7 @@ int main(int argc, char **argv)
> >      signal(SIGPIPE, SIG_IGN);
> >  #endif
> > =20
> > +    qemu_init_logging();
> >      module_call_init(MODULE_INIT_TRACE);
> >      error_set_progname(argv[0]);
> >      qcrypto_init(&error_fatal);
> > diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
> > index e7af637232..523f8b237c 100644
> > --- a/scsi/qemu-pr-helper.c
> > +++ b/scsi/qemu-pr-helper.c
> > @@ -895,6 +895,7 @@ int main(int argc, char **argv)
> > =20
> >      signal(SIGPIPE, SIG_IGN);
> > =20
> > +    qemu_init_logging();
> >      module_call_init(MODULE_INIT_TRACE);
> >      module_call_init(MODULE_INIT_QOM);
> >      qemu_add_opts(&qemu_trace_opts);
> > diff --git a/util/qemu-error.c b/util/qemu-error.c
> > index fcbe8a1f74..1118ed4695 100644
> > --- a/util/qemu-error.c
> > +++ b/util/qemu-error.c
> > @@ -345,3 +345,50 @@ bool warn_report_once_cond(bool *printed, const =
char *fmt, ...)
> >      va_end(ap);
> >      return true;
> >  }
> > +
> > +static char *qemu_glog_domains;
> > +
> > +static void qemu_log_func(const gchar *log_domain,
> > +                          GLogLevelFlags log_level,
> > +                          const gchar *message,
> > +                          gpointer user_data)
> > +{
> > +    switch (log_level & G_LOG_LEVEL_MASK) {
> > +    case G_LOG_LEVEL_DEBUG:
> > +        /* Use same G_MESSAGES_DEBUG logic as glib to enable/disable=
 debug
> > +         * messages
> > +         */
>=20
> Wing both ends of the comment, please.
>=20
> > +        if (qemu_glog_domains =3D=3D NULL) {
> > +            break;
> > +        }
> > +        if (strcmp(qemu_glog_domains, "all") !=3D 0 &&
> > +          (log_domain =3D=3D NULL || !strstr(qemu_glog_domains, log_=
domain))) {
> > +            break;
> > +        }
> > +        /* Fall through */
> > +    case G_LOG_LEVEL_INFO:
> > +        /* Fall through */
>=20
> g_log_default_handler() applies G_MESSAGES_DEBUG suppression logic to
> G_LOG_LEVEL_INFO messages, too.  Do you deviate intentionally?
>=20
> > +    case G_LOG_LEVEL_MESSAGE:
> > +        info_report("%s: %s", log_domain, message);
>=20
> @log_domain can be null.  You even check for that above.
>=20
> > +        break;
> > +    case G_LOG_LEVEL_WARNING:
> > +        warn_report("%s: %s", log_domain, message);
> > +        break;
> > +    case G_LOG_LEVEL_CRITICAL:
> > +        /* Fall through */
> > +    case G_LOG_LEVEL_ERROR:
> > +        error_report("%s: %s", log_domain, message);
> > +        break;
>=20
> Sure we don't need to check for G_LOG_FLAG_RECURSION?
> g_log_default_handler() has a conditional for that...
>=20
> Not sure it has anything for G_LOG_FLAG_FATAL; it's code is surprisingl=
y
> complex.
>=20
> > +    }
> > +}
> > +
> > +/*
> > + * Init QEMU logging subsystem. This sets up glib logging so librari=
es using it
> > + * also print their logs through {info,warn,error}_report.
> > + */
>=20
> Format like the other function comments:
>=20
>    /*
>     * Init QEMU logging subsystem.
>     * This sets up glib logging so libraries using it also print their =
logs
>     * through error_report(), warn_report(), info_report().
>     */
>=20
> Braces expanded for better grepability.
>=20
> > +void qemu_init_logging(void)
>=20
> Naming is hard...  Yes, this "initializes logging" in a sense: it
> installs a GLib default log handler that routes GLib log messages
> through this module.  But that's detail; the callers don't care what
> this function does, all they care for is "must call early".  If this
> module ever grows a need to initialize something else before it gets
> used, we'll regret naming its initialization function
> qemu_init_logging().
>=20
> Hmm, it has already grown such a need: initializing @progname.
> error_set_progname() does it.  Asking a module's users to call *two*
> initializtion functions is not nice.
>=20
> Fuse the two into error_init(const char *argv0)?
>=20
> > +{
> > +    g_log_set_default_handler(qemu_log_func, NULL);
> > +    g_warn_if_fail(qemu_glog_domains =3D=3D NULL);
> > +    qemu_glog_domains =3D g_strdup(g_getenv("G_MESSAGES_DEBUG"));
> > +}
> > diff --git a/vl.c b/vl.c
> > index bc9fbec654..f03f20e060 100644
> > --- a/vl.c
> > +++ b/vl.c
> > @@ -3039,6 +3039,7 @@ int main(int argc, char **argv, char **envp)
> >      QSIMPLEQ_HEAD(, BlockdevOptions_queue) bdo_queue
> >          =3D QSIMPLEQ_HEAD_INITIALIZER(bdo_queue);
> > =20
> > +    qemu_init_logging();
> >      module_call_init(MODULE_INIT_TRACE);
> > =20
> >      qemu_init_cpu_list();
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
