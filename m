Received: from eggs.gnu.org ([2001:4830:134:3::10]:45731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fSicq-0000Nr-BA
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 08:42:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fSicl-0001sI-BI
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 08:42:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34212 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fSicl-0001rk-5v
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 08:42:11 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 87B904002249
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 12:42:10 +0000 (UTC)
Date: Tue, 12 Jun 2018 14:42:05 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180612144205.2169e7a2@redhat.com>
In-Reply-To: <5cef972d-250b-5464-7482-90fa24d36c80@redhat.com>
References: <20180606135051.GR7451@localhost.localdomain>
	<1528372809-175770-1-git-send-email-imammedo@redhat.com>
	<20180608132105.GA24764@localhost.localdomain>
	<20180611151625.4b2420b8@redhat.com>
	<20180611190607.GU7451@localhost.localdomain>
	<20180611232924.6e04b6f8@igors-macbook-pro.local>
	<20180611223633.GG7451@localhost.localdomain>
	<5cef972d-250b-5464-7482-90fa24d36c80@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [libvirt] [PATCH v6 2/2] vl: fix use of
 --daemonize with --preconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal Privoznik <mprivozn@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, ldoktor@redhat.com, libvir-list@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com, berrange@redhat.com, pkrempa@redhat.com

On Tue, 12 Jun 2018 11:17:15 +0200
Michal Privoznik <mprivozn@redhat.com> wrote:

> On 06/12/2018 12:36 AM, Eduardo Habkost wrote:
> > CCing libvir-list.
> >=20
> > On Mon, Jun 11, 2018 at 11:29:24PM +0200, Igor Mammedov wrote: =20
> >> On Mon, 11 Jun 2018 16:06:07 -0300
> >> Eduardo Habkost <ehabkost@redhat.com> wrote:
> >> =20
> >>> On Mon, Jun 11, 2018 at 03:16:25PM +0200, Igor Mammedov wrote: =20
> >>>> On Fri, 8 Jun 2018 10:21:05 -0300
> >>>> Eduardo Habkost <ehabkost@redhat.com> wrote:
> >>>> =20
> >>>>> On Thu, Jun 07, 2018 at 02:00:09PM +0200, Igor Mammedov wrote: =20
> >>>>>> When using --daemonize, the initial lead process will fork a child=
 and
> >>>>>> then wait to be notified that setup is complete via a pipe, before=
 it
> >>>>>> exits.  When using --preconfig there is an extra call to main_loop=
()
> >>>>>> before the notification is done from os_setup_post(). Thus the par=
ent
> >>>>>> process won't exit until the mgmt application connects to the moni=
tor
> >>>>>> and tells QEMU to leave the RUN_STATE_PRECONFIG. The mgmt applicat=
ion
> >>>>>> won't connect to the monitor until daemonizing has completed thoug=
h.
> >>>>>>
> >>>>>> This is a chicken and egg problem, leading to deadlock at startup.
> >>>>>>
> >>>>>> The only viable way to fix this is to call os_setup_post() before
> >>>>>> the early main_loop() call when --preconfig is used. This has the
> >>>>>> downside that any errors from this point onwards won't be handled
> >>>>>> well by the mgmt application, because it will think QEMU has start=
ed
> >>>>>> successfully, so not be expecting an abrupt exit. Moving as much u=
ser
> >>>>>> input validation as possible to before the main_loop() call might =
help,
> >>>>>> but mgmt application should stop assuming that QEMU has started
> >>>>>> successfuly and use other means to collect errors from QEMU (logfi=
le).
> >>>>>>
> >>>>>> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> >>>>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> >>>>>> ---
> >>>>>> v5:
> >>>>>>   * use original Daniel's patch [1], but addapt it to apply on top=
 of
> >>>>>>     "[PATCH v3 1/2] cli: Don't run early event loop if no  --preco=
nfig was specified"
> >>>>>>     with extra comment and massage commit message a little bit.
> >>>>>> v6:
> >>>>>>   * hide os_setup_post_done flag inside of os_setup_post() as it w=
as in v4
> >>>>>>
> >>>>>> CC: berrange@redhat.com
> >>>>>> CC: mreitz@redhat.com
> >>>>>> CC: pbonzini@redhat.com
> >>>>>> CC: ehabkost@redhat.com
> >>>>>> CC: ldoktor@redhat.com
> >>>>>> CC: eblake@redhat.com
> >>>>>> ---
> >>>>>>  os-posix.c | 6 ++++++
> >>>>>>  vl.c       | 6 ++++++
> >>>>>>  2 files changed, 12 insertions(+)
> >>>>>>
> >>>>>> diff --git a/os-posix.c b/os-posix.c
> >>>>>> index 9ce6f74..0246195 100644
> >>>>>> --- a/os-posix.c
> >>>>>> +++ b/os-posix.c
> >>>>>> @@ -309,8 +309,14 @@ void os_daemonize(void)
> >>>>>> =20
> >>>>>>  void os_setup_post(void)
> >>>>>>  {
> >>>>>> +    static bool os_setup_post_done;
> >>>>>>      int fd =3D 0;
> >>>>>> =20
> >>>>>> +    if (os_setup_post_done) {
> >>>>>> +        return;
> >>>>>> +    }
> >>>>>> +    os_setup_post_done =3D true;
> >>>>>> +
> >>>>>>      if (daemonize) {
> >>>>>>          if (chdir("/")) {
> >>>>>>              error_report("not able to chdir to /: %s", strerror(e=
rrno));
> >>>>>> diff --git a/vl.c b/vl.c
> >>>>>> index fa44138..457ff2a 100644
> >>>>>> --- a/vl.c
> >>>>>> +++ b/vl.c
> >>>>>> @@ -4578,6 +4578,12 @@ int main(int argc, char **argv, char **envp)
> >>>>>>      parse_numa_opts(current_machine);
> >>>>>> =20
> >>>>>>      /* do monitor/qmp handling at preconfig state if requested */
> >>>>>> +    if (!preconfig_exit_requested && is_daemonized()) {
> >>>>>> +        /* signal parent QEMU to exit, libvirt treats it as a sign
> >>>>>> +         * that monitor socket is ready to accept connections
> >>>>>> +         */
> >>>>>> +        os_setup_post();
> >>>>>> +    }   =20
> >>>>>
> >>>>> I was looking at the daemonize logic, and noticed it we have a
> >>>>> huge amount of code between this line and the next
> >>>>> os_setup_post() call that could either:
> >>>>>
> >>>>> * call exit() and/or error_report(); or =20
> >>>> logging would work to the extent mentioned in commit message,
> >>>> i.e. it' would work fine when log file is used otherwise it
> >>>> errors will go to /dev/null
> >>>>
> >>>> so it should be more or less fine on this point =20
> >>>
> >>> My worry is that most users of error_report() involve an exit()
> >>> call too.
> >>>
> >>> Once we have an active monitor, we must never call exit()
> >>> directly.  Even qmp_quit() doesn't call exit() directly. =20
> >> Is there any reason why exit() can't be called? =20
> >=20
> > QMP clients don't expect the QMP socket to be closed except when
> > using the 'quit' command. =20
>=20
> Libvirt views HANGUP on monitor socket as qemu process dying
> unexpectedly so it starts cleanup (which involves 'kill -9' of qemu).
So if we exit(1) there is a chance to get SIGKILL before exit(1) completes.
Do we care about it at this point?
(there are places when QEMU calls exit(1) at runtime on unrecoverable error)

> >>>>> * be unable to finish machine initialization because of
> >>>>>   chdir("/"), change_root(), or change_process_uid(). =20
> >>>> this one really no go.
> >>>> I see 2 options here,
> >>>>
> >>>>  * move init code that opens files to early stage (before preconfig =
monitor)
> >>>>    or split it to open files early.
> >>>>    (I've spotted several obvious places fwcfg/vnc/replay_start/migra=
tion)
> >>>>    but there might be code somewhere in callbacks that would do it t=
oo,
> >>>>    so it rather risky to go this route.
> >>>>    (I'd do this anyways one place at the time using sanitizing
> >>>>     initialization sequence pretext.) =20
> >>>
> >>> We might have QMP commands that take file paths as input, so is
> >>> this really an option? =20
> >> I'd think that in future we would want to enable object_add in preconf=
ig
> >> to create backends at runtime, so yes we can't do chroot at this point
> >> =20
> >> =20
> >>>>  * split out signaling part that tells parent process to exit into
> >>>>    separate helper that's called once before/from main_loop().
> >>>>    This option seems low risk and additionally error output to
> >>>>    stderr will work as it does currently (until os_setup_post()) =20
> >>>
> >>> My assumption is that separating the chdir()/stdout/stderr logic
> >>> from the fork/daemonize/exit steps wouldn't be possible without
> >>> breaking expectations about -daemonize. =20
> >> it's already separated and that's what creates one side of problem. =20
> >=20
> > Is it?  Right now '$QEMU -daemonize' will never call exit(0)
> > before the child process it spawned did the
> > chdir()/stdout/stderr/etc trick.
> >=20
> >  =20
> >> What I suggest is to leave it as is and move out only
> >>   len =3D write(daemon_pipe, &status, 1);
> >> part of os_setup_post() to sync with parent process. That shouldn't
> >> affect daemonizing flow on QEMU side and would let libvirt reuse paren=
t's
> >> exit as sync point to detect moment when monitor is available.
> >> (patch is in testing, I'll post it tomorrow if it doesn't break tests)=
 =20
> >=20
> > This will affect the daemonizing flow, won't it?  It will make
> > QEMU exit(0) before the child does the chdir()/stderr/stdout/etc
> > cleanup.  A well-behaved daemon shouldn't do this.
> >=20
> > This is probably not a problem for libvirt (which only uses
> > -daemonize as a sync point for QMP), but possibly a problem for
> > other users of -daemonize. =20
>=20
> I think the proper behaviour is to exit(0) after chdir()/stderr/... AND
> monitor is set up. Then, if any caller started qemu with -preconfig they
> know they can start talking on monitor, set up whatever it is they want
> and issue 'cont' finally (or what is the right command to exit preconfig
> state). This way nothing changes for callers not using -preconfig.
As pointed out earlier we need -preconfig stay before chdir/chroot/chuid/st=
derr/stdout
are called, so it would have the same access rights/permissions for configu=
ration
as CLI options.

> >> In worst case if we can't do the later in QEMU, mgmt would have to cop=
e with
> >> monitor in preconfig mode without relying on parent exit(0) sync point.
> >> (a typical daemon would fork/chroot and co in one place and clients wo=
uld use
> >> other means to detect socket availability other than watching parent p=
rocess
> >> exiting) =20
> >=20
> > Do we really need to make -daemonize and -preconfig work
> > together?  libvirt uses -daemonize only for its initial
> > capability probing, which shouldn't require -preconfig at all.
> >=20
> > Even on that case, I wonder why libvirt doesn't simply create a
> > server socket and waits for QEMU to connect instead of using
> > -daemonize as a sync point.
> >  =20
>=20
> because libvirt views qemu as well behaved daemon. Should anything go
> wrong libvirt reads qemu's stderr and reports error to upper layers.
We can keep daemonizing flow in QEMU as it's now.
But Eduardo's idea about libvirt created socked + letting QEMU connect to it
has a merit. It should fix current deadlock issue with as monitor
won't be depending on lead exit event.
Can we do this way on libvirt side when --preconfig is in use
(it might even be fine for normal flow without -preconfig)?

> Michal
