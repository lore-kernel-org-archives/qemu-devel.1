Received: from eggs.gnu.org ([2001:4830:134:3::10]:51240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fPtQ2-0007RZ-EA
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 13:37:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fPtPy-0007lW-Su
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 13:37:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34890 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fPtPy-0007l6-Mf
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 13:37:18 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EB6F9402382B
	for <qemu-devel@nongnu.org>; Mon,  4 Jun 2018 17:37:17 +0000 (UTC)
Date: Mon, 4 Jun 2018 19:37:15 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180604193715.187c488b@redhat.com>
In-Reply-To: <20180604161157.GL19749@redhat.com>
References: <20180604120345.12955-1-berrange@redhat.com>
	<20180604120345.12955-2-berrange@redhat.com>
	<20180604174032.6962082d@redhat.com>
	<20180604161157.GL19749@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/2] vl: don't use RUN_STATE_PRECONFIG
 as initial state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Mon, 4 Jun 2018 17:11:57 +0100
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Mon, Jun 04, 2018 at 05:40:32PM +0200, Igor Mammedov wrote:
> > On Mon,  4 Jun 2018 13:03:44 +0100
> > Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> >  =20
> > > The RUN_STATE_PRECONFIG state is not supposed to be reachable unless =
the
> > > --preconfig argument is given to QEMU, but when it was introduced in:
> > >=20
> > >   commit 047f7038f586d2150f16c6d9ba9cfd0479f0f6ac
> > >   Author: Igor Mammedov <imammedo@redhat.com>
> > >   Date:   Fri May 11 19:24:43 2018 +0200
> > >=20
> > >     cli: add --preconfig option
> > >=20
> > > ...the global 'current_run_state' variable was changed to have an ini=
tial
> > > value of RUN_STATE_PRECONFIG regardless of whether --preconfig is giv=
en.
> > >=20
> > > A second invokation of main_loop() was added which then toggles it ba=
ck
> > > to RUN_STATE_PRELAUNCH when --preconfig is not given. This is racy
> > > because it leaves a window where QEMU is in RUN_STATE_PRECONFIG despi=
te
> > > --preconfig not being given. =20
> > Above statements isn't exactly correct, PRECONFIG were supposed to be
> > the new state of QEMU from start up till machine_run_board_init(),
> > that would separate stage of initial configuration out from all
> > encompassing PRELAUNCH state. So I'd scratch out above part. =20
>=20
> That doesn't really make sense, given that --preconfig is *not* the
> default and thus not supposed to be an active state unless the app
> has explicitly opted in.
>
> IMHO running PRECONFIG state for any period of time when the app
> has not requested --preconfig is simply broken, and a recipe for
> obscure bugs like the ones we've seen right now.
mgmt hasn't opted in for default PRELAUNCH either, for it default
PRECONFIG runstate is not visible unless it opts in so nothing
is broken in regards to this.
Default runstate selection is QEMU's internal impl. detail.

I don't think it's the reason for obscure bugs, it's rather
exposing so far hidden issues out there. The current startup
code is a mess and were blindly assuming PRELAUNCH state,
using globals to jump from one state to another depending on
CLI options combination.
So moving main_loop() earlier exposed a number of issues,
that should be fixed.
=20
> > >   $ echo | x86_64-softmmu/qemu-system-x86_64 -monitor stdio
> > >   QEMU 2.12.50 monitor - type 'help' for more information
> > >   (qemu)
> > >   HMP not available in preconfig state, use QMP instead =20
> > Michal's patch is much simpler and fixes that cleanly. =20
>=20
> It is incomplete IMHO as it still leaves the hang in main loop
> present - it merely avoids triggering it in one code path, and
> leaves the other code path broken.
It's new behavior which looses sync point on parent QEMU process exit,
hence it's not convenient for mgmt that currently expects parent
qemu process exit when it's demonized.

Since it's new option, there are 2 ways to deal with it:
  * make parent process exit earlier before main loop as you suggest in 2/2
    and teach mgmt to deal with initialization errors cleanly after
    sync point
  * teach mgmt to connect to QMP socket earlier if --preconfig were used,
    (benefit error handling works as it used to be)

I'd happy with any of this as far as user won't be confused if something
goes wrong.

> > > Using RUN_STATE_PRECONFIG required adding a state transition from
> > > RUN_STATE_PRECONFIG to RUN_STATE_INMIGRATE, which is undesirable as
> > > it prevented automatic detection of --preconfig & --incoming being
> > > mutually exclusive.
> > >=20
> > > If we use RUN_STATE_PRELAUNCH as the initial value, however, we need =
to
> > > allow transitions between RUN_STATE_PRECONFIG & RUN_STATE_PRELAUNCH in
> > > both directions which is also undesirable, as RUN_STATE_PRECONFIG sho=
uld
> > > be a one-time-only state that can never be returned to.
> > >=20
> > > This change solves the confusion by introducing a further RUN_STATE_N=
ONE
> > > which is used as the initial state value. This can transition to any =
of
> > > RUN_STATE_PRELAUNCH, RUN_STATE_PRECONFIG or RUN_STATE_INMIGRATE. This
> > > avoids the need to allow any undesirable state transitions. =20
> > Ugly mutually exclusive code including related long comments are
> > intentional. The plan is to streamline runstate transitions in
> > following order
> >   PRECONFIG -> PRELAUNCH [-> INMIGRATE] =20
>=20
> This doesn't make any conceptual sense to me, given that --preconfig
> is an optional flag. We can't make --preconfig the default, because
> of back compat, so we'll always have
where is the back compat issue with preconfig default?
(it's not visible to mgmt unless --preconfig option is used)

>    $START ------------->  PRELAUNCH {-> INMIGRATE]
>      |              ^
>      |              |
>      +-- PRECONFIG -+
>=20
> By marking the current state as PRECONFIG by default, we've essentially
> given 2 meanings to  PRECONFIG - sometimes it means stuff  that can be
> unconditionally run in early startup, and sometimes it means stuff that
> can only be run if --preconfig is given. Introducing the separate NONE
> state clarifies that inherant contradiction in startup phases.
Yep, one can say it this way (as merged PRECONFIG was early
configuration stage regardless of if it's unconditional early
initialization or early CLI parsing/QMP configuration).

Maybe adding NONE state makes sense but I'm not quite sure,
that's why I'd not rush it in and discuss if we really need
fragment early configuration into more stages.
(we can do it later as both stages aren't visible to user by default).

> > i.e. postpone RUN_STATE_INMIGRATE transition to the later stage.
> > But that's requires some cleanup work to remove invariants=20
> > in initialization depending if INMIGRATE state is in effect or not.
> >=20
> > Hence I'd keep this part ugly as it is for now, and if we can do
> > without RUN_STATE_NONE it would be better, i.e. keep current
> > PRECONFIG runstate meaning where we would do initial configuration
> > either via CLI or via QMP and one less runstate to deal with.
> >=20
> > I'd go with Michal's version of fix and think some more on
> > introducing RUN_STATE_NONE.
> >  =20
> > > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > > ---
> > >  qapi/run-state.json |  6 +++++-
> > >  vl.c                | 42 ++++++++++++++++++++++++------------------
> > >  2 files changed, 29 insertions(+), 19 deletions(-)
> > >=20
> > > diff --git a/qapi/run-state.json b/qapi/run-state.json
> > > index 332e44897b..c3bd7b9b7a 100644
> > > --- a/qapi/run-state.json
> > > +++ b/qapi/run-state.json
> > > @@ -10,6 +10,10 @@
> > >  #
> > >  # An enumeration of VM run states.
> > >  #
> > > +# @none: QEMU is in early startup. This state should never be visible
> > > +# when querying state from the monitor, as QEMU will have already
> > > +# transitioned to another state. (Since 3.0)
> > > +#
> > >  # @debug: QEMU is running on a debugger
> > >  #
> > >  # @finish-migrate: guest is paused to finish the migration process
> > > @@ -54,7 +58,7 @@
> > >  #             (Since 3.0)
> > >  ##
> > >  { 'enum': 'RunState',
> > > -  'data': [ 'debug', 'inmigrate', 'internal-error', 'io-error', 'pau=
sed',
> > > +  'data': [ 'none', 'debug', 'inmigrate', 'internal-error', 'io-erro=
r', 'paused',
> > >              'postmigrate', 'prelaunch', 'finish-migrate', 'restore-v=
m',
> > >              'running', 'save-vm', 'shutdown', 'suspended', 'watchdog=
',
> > >              'guest-panicked', 'colo', 'preconfig' ] }
> > > diff --git a/vl.c b/vl.c
> > > index 06031715ac..30d0e985f0 100644
> > > --- a/vl.c
> > > +++ b/vl.c
> > > @@ -561,7 +561,7 @@ static int default_driver_check(void *opaque, Qem=
uOpts *opts, Error **errp)
> > >  /***********************************************************/
> > >  /* QEMU state */
> > > =20
> > > -static RunState current_run_state =3D RUN_STATE_PRECONFIG;
> > > +static RunState current_run_state =3D RUN_STATE_NONE;
> > > =20
> > >  /* We use RUN_STATE__MAX but any invalid value will do */
> > >  static RunState vmstop_requested =3D RUN_STATE__MAX;
> > > @@ -574,12 +574,11 @@ typedef struct {
> > > =20
> > >  static const RunStateTransition runstate_transitions_def[] =3D {
> > >      /*     from      ->     to      */
> > > +    { RUN_STATE_NONE, RUN_STATE_PRELAUNCH },
> > > +    { RUN_STATE_NONE, RUN_STATE_PRECONFIG },
> > > +    { RUN_STATE_NONE, RUN_STATE_INMIGRATE },
> > > +
> > >      { RUN_STATE_PRECONFIG, RUN_STATE_PRELAUNCH },
> > > -      /* Early switch to inmigrate state to allow  -incoming CLI opt=
ion work
> > > -       * as it used to. TODO: delay actual switching to inmigrate st=
ate to
> > > -       * the point after machine is built and remove this hack.
> > > -       */ =20
> > Since patch isn't postponing INMIGRATE, it's too early to remove TODO i=
tem comment. =20
>=20
> The switch to INMIGRATE happens with -incoming is processed, at
It's just evolved this way but that doesn't mean that switching
to INMIGRATE should happen when -incoming option is processed,.
More correct would be to switch to INMIGRATE state after
machine is initialized and apply incoming state on top of it,
but that needs cleanup (on my todo list) to make sure that
-incoming doesn't influence machine initialization.

> which time the current state is NONE. -preconfig is mutually
> exclusive with -incoming currently, so there's no way for there
> to be a valid PRECONFIG -> INMIGRATE transition.
>=20
> If we do figure out a way to make -incoming work with -preconfig,
> then, this transition could become valid once more, but today it
> simply shouldn't exist.
It's a hack as well as PRELAUNCH -> INMIGRATE and marked as
such with TODO note. Adding NONE -> INMIGRATE transition is
the same though. It's the hack to keep -incoming working without
refactoring -incoming parsing to postpone transition to point
where machine is initialized. So if we would add NONE runstate,
the TODO item still applies but this time to NONE state.

> >  =20
> > > -    { RUN_STATE_PRECONFIG, RUN_STATE_INMIGRATE },
> > > =20
> > >      { RUN_STATE_DEBUG, RUN_STATE_RUNNING },
> > >      { RUN_STATE_DEBUG, RUN_STATE_FINISH_MIGRATE },
> > > @@ -618,7 +617,6 @@ static const RunStateTransition runstate_transiti=
ons_def[] =3D {
> > > =20
> > >      { RUN_STATE_PRELAUNCH, RUN_STATE_RUNNING },
> > >      { RUN_STATE_PRELAUNCH, RUN_STATE_FINISH_MIGRATE },
> > > -    { RUN_STATE_PRELAUNCH, RUN_STATE_INMIGRATE },
> > > =20
> > >      { RUN_STATE_FINISH_MIGRATE, RUN_STATE_RUNNING },
> > >      { RUN_STATE_FINISH_MIGRATE, RUN_STATE_PAUSED },
[...]
