Received: from eggs.gnu.org ([2001:4830:134:3::10]:58023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fECJl-0003HX-IP
	for qemu-devel@nongnu.org; Thu, 03 May 2018 07:22:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fECJi-00077O-6l
	for qemu-devel@nongnu.org; Thu, 03 May 2018 07:22:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36916 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fECJi-00076K-1T
	for qemu-devel@nongnu.org; Thu, 03 May 2018 07:22:30 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6BAA47CBBA
	for <qemu-devel@nongnu.org>; Thu,  3 May 2018 11:22:24 +0000 (UTC)
Date: Thu, 3 May 2018 13:22:18 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180503132218.0335c3a8@redhat.com>
In-Reply-To: <20180501152910.GG32129@redhat.com>
References: <1524841523-95513-1-git-send-email-imammedo@redhat.com>
	<1524841523-95513-6-git-send-email-imammedo@redhat.com>
	<20180501152910.GG32129@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 05/11] qapi: introduce new cmd option
 "allowed-in-preconfig"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, pkrempa@redhat.com, ehabkost@redhat.com, armbru@redhat.com

On Tue, 1 May 2018 16:29:10 +0100
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Fri, Apr 27, 2018 at 05:05:17PM +0200, Igor Mammedov wrote:
> > New option will be used to allow commands, which are prepared/need
> > to run, during preconfig state. Other commands that should be able
> > to run in preconfig state, should be ameded to not expect machine
> > in initialized state or deal with it.
> >=20
> > For compatibility reasons, commands that don't use new flag
> > 'allowed-in-preconfig' explicitly are not permitted to run in
> > preconfig state but allowed in all other states like they used
> > to be.
> >=20
> > Within this patch allow following commands in preconfig state:
> >    qmp_capabilities
> >    query-qmp-schema
> >    query-commands
> >    query-command-line-options
> >    query-status
> >    exit-preconfig
> > to allow qmp connection, basic introspection and moving to the next
> > state. =20
>=20
> Looking at what libvirt sends to QEMU before 'cont', when -S is used,
> we have a lot of differences. In order, libvirt does something like
> this on guest startup:
I took a quick look at these commands in QEMU

> "qmp_capabilities"
this is preconfig enabled within this series

> "query-migrate-capabilities"
> "migrate-set-capabilities"
it could be possible to make it work at preconfig time,
but we probably need to fix -incoming mess first
(as David pointed out it's possible to postpone switching to
inmigrate runstate but needs some work done to make it
actually happen)

> "query-chardev"
could be enabled at preconfig with some behavioral change,
namely, frontend-open field would report false at preconfig time

> "qom-list"
> "qom-get"
> "qom-get"
Above depends on whether being queried object exits at
preconfig time, so possibility of using commands should be
evaluated separately for each use case.
Could you point out to relevant objects that libvirt
uses with these commands and why it's needed?

> "query-hotpluggable-cpus"
preconfig enabled within this series, so that
libvirt could get cpus layout for configuring numa
(it should work for x86 and spapr, and later with AR
once CPU hotplug is enabled there)

> "query-iothreads"
both -object and monitor_init_globals() are done before machine_init
so it should be possible make it work at preconfig

> "balloon"
> "query-balloon"
These are depend on initialized machine and -device balloon processed
What's the reasons for libvirt to use it at -S pause instead of
using -device on CLI for adding balloon device?

> "query-cpus"
That one probably won't be possible as it needs initialized machine
or at least 'machine_init() + -device' processed first.
Why libvirt does need it to start VM?

Above 3 commands and possibly others could be made usable
with --preconfig in case we implement steps between
  machine_run_board_init() ... qdev_machine_creation_done()
as qmp commands like: qmp_initialize_board(), enable device_add,
etc. and move earlier the steps from there that don't really
depend on being created machine.=20

> "cont"
>=20
> So --preconfig looks like it cannot be used for anything libvirt currently
> does during guest startup. This would force us to use the new set-numa-no=
de
> command right at the start, even though this is possibly not a time when
> libvirt is actually ready to set the numa node in QEMU.
set_numa_node at preconfig time was made with libvirt in mind
so this should work, Peter is just waiting on it being merged
before he would coding libvirt support for it.

> This kind of code
> ordering constraint QEMU will put on libvirt is why I really don't like
> the idea of having multiple startup phases where you can only use certain
> commands in certain phases.
I've even implemented fixing up built machine at -S pause point
for the sake of experiment [1] at he cost of an extra machine reset
per every set-numa-node command, but even if it would work for numa,
is really not good approach, rather fragile and won't scale, we would
be just piling one hack on another.
Hopefully we would be able to make enough commands preconfig enabled
to start VM without need for -S.

> Regards,
> Daniel
[1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg502794.html
