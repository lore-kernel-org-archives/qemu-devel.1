Received: from eggs.gnu.org ([2001:4830:134:3::10]:44280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fQ7Nf-0003Ue-R5
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 04:31:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fQ7Nc-0000z8-LO
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 04:31:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38764 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fQ7Nc-0000z0-FY
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 04:31:48 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C8E5D4187E48
	for <qemu-devel@nongnu.org>; Tue,  5 Jun 2018 08:31:47 +0000 (UTC)
Date: Tue, 5 Jun 2018 10:31:45 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180605103145.656ef33d@redhat.com>
In-Reply-To: <20180605003546.GC3184@localhost.localdomain>
References: <20180604120345.12955-1-berrange@redhat.com>
	<20180604120345.12955-2-berrange@redhat.com>
	<20180604174032.6962082d@redhat.com>
	<20180604161157.GL19749@redhat.com>
	<20180604193715.187c488b@redhat.com>
	<20180605003546.GC3184@localhost.localdomain>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, qemu-devel@nongnu.org, Michal Privoznik <mprivozn@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, 4 Jun 2018 21:35:46 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Mon, Jun 04, 2018 at 07:37:15PM +0200, Igor Mammedov wrote:
> > On Mon, 4 Jun 2018 17:11:57 +0100
> > Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> >  =20
> > > On Mon, Jun 04, 2018 at 05:40:32PM +0200, Igor Mammedov wrote: =20
> > > > On Mon,  4 Jun 2018 13:03:44 +0100
> > > > Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> > > >    =20
> > > > > The RUN_STATE_PRECONFIG state is not supposed to be reachable unl=
ess the
> > > > > --preconfig argument is given to QEMU, but when it was introduced=
 in:
> > > > >=20
> > > > >   commit 047f7038f586d2150f16c6d9ba9cfd0479f0f6ac
> > > > >   Author: Igor Mammedov <imammedo@redhat.com>
> > > > >   Date:   Fri May 11 19:24:43 2018 +0200
> > > > >=20
> > > > >     cli: add --preconfig option
> > > > >=20
> > > > > ...the global 'current_run_state' variable was changed to have an=
 initial
> > > > > value of RUN_STATE_PRECONFIG regardless of whether --preconfig is=
 given.
> > > > >=20
> > > > > A second invokation of main_loop() was added which then toggles i=
t back
> > > > > to RUN_STATE_PRELAUNCH when --preconfig is not given. This is racy
> > > > > because it leaves a window where QEMU is in RUN_STATE_PRECONFIG d=
espite
> > > > > --preconfig not being given.   =20
> > > > Above statements isn't exactly correct, PRECONFIG were supposed to =
be
> > > > the new state of QEMU from start up till machine_run_board_init(),
> > > > that would separate stage of initial configuration out from all
> > > > encompassing PRELAUNCH state. So I'd scratch out above part.   =20
> > >=20
> > > That doesn't really make sense, given that --preconfig is *not* the
> > > default and thus not supposed to be an active state unless the app
> > > has explicitly opted in.
> > >
> > > IMHO running PRECONFIG state for any period of time when the app
> > > has not requested --preconfig is simply broken, and a recipe for
> > > obscure bugs like the ones we've seen right now. =20
> > mgmt hasn't opted in for default PRELAUNCH either, for it default
> > PRECONFIG runstate is not visible unless it opts in so nothing
> > is broken in regards to this.
> > Default runstate selection is QEMU's internal impl. detail. =20
>=20
> Daniel's description is how he expects it to work, but your
> description reflects the way the state machine actually works
> today (and how it worked befor the --preconfig series).
>=20
> However, I agree with Daniel that moving to PRECONFIG or
> PRELAUNCH if neither --preconfig or -S were specified is
> confusing, and I would prefer to change it the way he suggests.
>=20
> But:
>=20
> [...]
> > >    $START ------------->  PRELAUNCH {-> INMIGRATE]
> > >      |              ^
> > >      |              |
> > >      +-- PRECONFIG -+
> > >=20
> > > By marking the current state as PRECONFIG by default, we've essential=
ly
> > > given 2 meanings to  PRECONFIG - sometimes it means stuff  that can be
> > > unconditionally run in early startup, and sometimes it means stuff th=
at
> > > can only be run if --preconfig is given. Introducing the separate NONE
> > > state clarifies that inherant contradiction in startup phases. =20
> > Yep, one can say it this way (as merged PRECONFIG was early
> > configuration stage regardless of if it's unconditional early
> > initialization or early CLI parsing/QMP configuration).
> >=20
> > Maybe adding NONE state makes sense but I'm not quite sure,
> > that's why I'd not rush it in and discuss if we really need
> > fragment early configuration into more stages.
> > (we can do it later as both stages aren't visible to user by default). =
=20
>=20
> Is it possible to fix the bugs first, and discuss how to refactor
> the state machine later?
Agreed, we can discuss and settle this internal to QEMU implementation
detail independently on top of actual fix.

> In the meantime, we could even document preconfig more accurately
> to avoid additional confusion:
>=20
> # @preconfig: Board initialization was not run yet.  The state is
> #             visible to the outside only if the --preconfig CLI
> #             option is used.  (Since 3.0)

I'll post a proper patch with it.
