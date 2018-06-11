Received: from eggs.gnu.org ([2001:4830:134:3::10]:35538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSVQX-00030A-VN
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 18:36:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSVQU-0006Hn-RL
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 18:36:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46324)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fSVQU-0006HZ-GY
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 18:36:38 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 955F03086258
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 22:36:37 +0000 (UTC)
Date: Mon, 11 Jun 2018 19:36:33 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180611223633.GG7451@localhost.localdomain>
References: <20180606135051.GR7451@localhost.localdomain>
	<1528372809-175770-1-git-send-email-imammedo@redhat.com>
	<20180608132105.GA24764@localhost.localdomain>
	<20180611151625.4b2420b8@redhat.com>
	<20180611190607.GU7451@localhost.localdomain>
	<20180611232924.6e04b6f8@igors-macbook-pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180611232924.6e04b6f8@igors-macbook-pro.local>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 2/2] vl: fix use of --daemonize with
 --preconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, ldoktor@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, libvir-list@redhat.com

CCing libvir-list.

On Mon, Jun 11, 2018 at 11:29:24PM +0200, Igor Mammedov wrote:
> On Mon, 11 Jun 2018 16:06:07 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
>=20
> > On Mon, Jun 11, 2018 at 03:16:25PM +0200, Igor Mammedov wrote:
> > > On Fri, 8 Jun 2018 10:21:05 -0300
> > > Eduardo Habkost <ehabkost@redhat.com> wrote:
> > >=20
> > > > On Thu, Jun 07, 2018 at 02:00:09PM +0200, Igor Mammedov wrote:
> > > > > When using --daemonize, the initial lead process will fork a ch=
ild and
> > > > > then wait to be notified that setup is complete via a pipe, bef=
ore it
> > > > > exits.  When using --preconfig there is an extra call to main_l=
oop()
> > > > > before the notification is done from os_setup_post(). Thus the =
parent
> > > > > process won't exit until the mgmt application connects to the m=
onitor
> > > > > and tells QEMU to leave the RUN_STATE_PRECONFIG. The mgmt appli=
cation
> > > > > won't connect to the monitor until daemonizing has completed th=
ough.
> > > > >=20
> > > > > This is a chicken and egg problem, leading to deadlock at start=
up.
> > > > >=20
> > > > > The only viable way to fix this is to call os_setup_post() befo=
re
> > > > > the early main_loop() call when --preconfig is used. This has t=
he
> > > > > downside that any errors from this point onwards won't be handl=
ed
> > > > > well by the mgmt application, because it will think QEMU has st=
arted
> > > > > successfully, so not be expecting an abrupt exit. Moving as muc=
h user
> > > > > input validation as possible to before the main_loop() call mig=
ht help,
> > > > > but mgmt application should stop assuming that QEMU has started
> > > > > successfuly and use other means to collect errors from QEMU (lo=
gfile).
> > > > >=20
> > > > > Signed-off-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> > > > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > > > ---
> > > > > v5:
> > > > >   * use original Daniel's patch [1], but addapt it to apply on =
top of
> > > > >     "[PATCH v3 1/2] cli: Don't run early event loop if no  --pr=
econfig was specified"
> > > > >     with extra comment and massage commit message a little bit.
> > > > > v6:
> > > > >   * hide os_setup_post_done flag inside of os_setup_post() as i=
t was in v4
> > > > >=20
> > > > > CC: berrange@redhat.com
> > > > > CC: mreitz@redhat.com
> > > > > CC: pbonzini@redhat.com
> > > > > CC: ehabkost@redhat.com
> > > > > CC: ldoktor@redhat.com
> > > > > CC: eblake@redhat.com
> > > > > ---
> > > > >  os-posix.c | 6 ++++++
> > > > >  vl.c       | 6 ++++++
> > > > >  2 files changed, 12 insertions(+)
> > > > >=20
> > > > > diff --git a/os-posix.c b/os-posix.c
> > > > > index 9ce6f74..0246195 100644
> > > > > --- a/os-posix.c
> > > > > +++ b/os-posix.c
> > > > > @@ -309,8 +309,14 @@ void os_daemonize(void)
> > > > > =20
> > > > >  void os_setup_post(void)
> > > > >  {
> > > > > +    static bool os_setup_post_done;
> > > > >      int fd =3D 0;
> > > > > =20
> > > > > +    if (os_setup_post_done) {
> > > > > +        return;
> > > > > +    }
> > > > > +    os_setup_post_done =3D true;
> > > > > +
> > > > >      if (daemonize) {
> > > > >          if (chdir("/")) {
> > > > >              error_report("not able to chdir to /: %s", strerro=
r(errno));
> > > > > diff --git a/vl.c b/vl.c
> > > > > index fa44138..457ff2a 100644
> > > > > --- a/vl.c
> > > > > +++ b/vl.c
> > > > > @@ -4578,6 +4578,12 @@ int main(int argc, char **argv, char **e=
nvp)
> > > > >      parse_numa_opts(current_machine);
> > > > > =20
> > > > >      /* do monitor/qmp handling at preconfig state if requested=
 */
> > > > > +    if (!preconfig_exit_requested && is_daemonized()) {
> > > > > +        /* signal parent QEMU to exit, libvirt treats it as a =
sign
> > > > > +         * that monitor socket is ready to accept connections
> > > > > +         */
> > > > > +        os_setup_post();
> > > > > +    } =20
> > > >=20
> > > > I was looking at the daemonize logic, and noticed it we have a
> > > > huge amount of code between this line and the next
> > > > os_setup_post() call that could either:
> > > >=20
> > > > * call exit() and/or error_report(); or
> > > logging would work to the extent mentioned in commit message,
> > > i.e. it' would work fine when log file is used otherwise it
> > > errors will go to /dev/null
> > >=20
> > > so it should be more or less fine on this point
> >=20
> > My worry is that most users of error_report() involve an exit()
> > call too.
> >=20
> > Once we have an active monitor, we must never call exit()
> > directly.  Even qmp_quit() doesn't call exit() directly.
> Is there any reason why exit() can't be called?

QMP clients don't expect the QMP socket to be closed except when
using the 'quit' command.

>=20
> > > > * be unable to finish machine initialization because of
> > > >   chdir("/"), change_root(), or change_process_uid().
> > > this one really no go.
> > > I see 2 options here,
> > >=20
> > >  * move init code that opens files to early stage (before preconfig=
 monitor)
> > >    or split it to open files early.
> > >    (I've spotted several obvious places fwcfg/vnc/replay_start/migr=
ation)
> > >    but there might be code somewhere in callbacks that would do it =
too,
> > >    so it rather risky to go this route.
> > >    (I'd do this anyways one place at the time using sanitizing
> > >     initialization sequence pretext.)
> >=20
> > We might have QMP commands that take file paths as input, so is
> > this really an option?
> I'd think that in future we would want to enable object_add in preconfi=
g
> to create backends at runtime, so yes we can't do chroot at this point
> =20
>=20
> > >  * split out signaling part that tells parent process to exit into
> > >    separate helper that's called once before/from main_loop().
> > >    This option seems low risk and additionally error output to
> > >    stderr will work as it does currently (until os_setup_post())
> >=20
> > My assumption is that separating the chdir()/stdout/stderr logic
> > from the fork/daemonize/exit steps wouldn't be possible without
> > breaking expectations about -daemonize.
> it's already separated and that's what creates one side of problem.

Is it?  Right now '$QEMU -daemonize' will never call exit(0)
before the child process it spawned did the
chdir()/stdout/stderr/etc trick.


> What I suggest is to leave it as is and move out only
>   len =3D write(daemon_pipe, &status, 1);
> part of os_setup_post() to sync with parent process. That shouldn't
> affect daemonizing flow on QEMU side and would let libvirt reuse parent=
's
> exit as sync point to detect moment when monitor is available.
> (patch is in testing, I'll post it tomorrow if it doesn't break tests)

This will affect the daemonizing flow, won't it?  It will make
QEMU exit(0) before the child does the chdir()/stderr/stdout/etc
cleanup.  A well-behaved daemon shouldn't do this.

This is probably not a problem for libvirt (which only uses
-daemonize as a sync point for QMP), but possibly a problem for
other users of -daemonize.

>=20
> In worst case if we can't do the later in QEMU, mgmt would have to cope=
 with
> monitor in preconfig mode without relying on parent exit(0) sync point.
> (a typical daemon would fork/chroot and co in one place and clients wou=
ld use
> other means to detect socket availability other than watching parent pr=
ocess
> exiting)

Do we really need to make -daemonize and -preconfig work
together?  libvirt uses -daemonize only for its initial
capability probing, which shouldn't require -preconfig at all.

Even on that case, I wonder why libvirt doesn't simply create a
server socket and waits for QEMU to connect instead of using
-daemonize as a sync point.

--=20
Eduardo
