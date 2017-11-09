Received: from eggs.gnu.org ([2001:4830:134:3::10]:44462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eCs6k-00068F-12
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 14:03:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eCs6g-00065u-Ro
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 14:03:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52624)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eCs6g-000650-IF
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 14:03:18 -0500
Date: Thu, 9 Nov 2017 17:03:08 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171109190308.GA31242@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] KVM Forum BoF session notes: QEMU
 configuration/command-line/QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, libvir-list@redhat.com
Cc: Peter Krempa <pkrempa@redhat.com>, Markus Armbruster <armbru@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Laine Stump <laine@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eduardo Otubo <otubo@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Kashyap Chamarthy <kchamart@redhat.com>, Max Reitz <mreitz@redhat.com>

Hi,

Below are the notes I collected during the BoF session about QEMU
configuration, command-line and QMP.  Sorry for taking so long to
send them.

All inaccuracies and mistakes below are my own fault.  (I learned
the hard way that trying to take notes while participating in the
discussion at the same time is not a good idea.)

--------------------------------

KVM Forum 2017 BoF session: configuration, command-line and QMP
2017-10-26

People: Jiri Denemark, Laine Stump, Peter Krempa,
        Markus Armbruster, Eduardo Habkost, Igor Mammedov,
        Kevin Wolf, Eduardo Otubo, Alistair Francis,
        Kashyap Chamarthy, Max Reitz

----------------

First topic: early QMP and -paused series by Igor

ehabkost tried to explain the original problem and Igor's proposal[1].

Markus: startup time is important, some things can make it slow.  Persona=
lly,
not so much concerned about querying stuff.  Just cache it!

Markus, about starting a monitor earlier: "it just makes sense".  One pro=
blem
is: command-line processing ordering mess in QEMU.  It's tempting but ver=
y
scary. very easy to screw up.  About command-line ordering, =E2=80=9CI'd =
just go
left-to-right=E2=80=9D.

ehabkost: is gradual change with NUMA stuff the right path?  (Markus: "wh=
at's the
right path?"; ehabkost: "I don't know").  If you are using CPU hotplug yo=
u still
might have some stuff not appearing in the command-line, because it uses
query-hotpluggable-cpus.  pkrempa: if you're using cpu hotplug you don't =
care
about startup time.  NUMA is not different.

Markus's objection to current -paused series: the need for another option=
/state.
We basically have 3 states/phases:
1: between exec and monitor available
2: between monitor and machines start to runs (in that phase a device_add=
 is/can be a cold plug)
3: then the machine actually runs, and all device_add is hotplug

ehabkost: that's how I understand it, too.

ehabkost: question for libvirt developers: is there an "expansion" operat=
ion
where libvirt could fill-up missing data on the XML based on info queried=
 from
QEMU? (Answer seems to be yes)

----------------

Some comments from Igor and Peter about query-hotpluggable-cpus and the n=
eed to
choose the right device type (sometimes TYPE_CPU is not appropriate for
device_add, but only CPU cores, like on Power).

ehabkost: that's probably another use case for query-device-slots: knowin=
g that
power machines can't device_add threads, but just cores.  Tricky part: pr=
oviding
slot information at qemu-probing time (with -machine none), before any ma=
chine
was built.

----------------

Some discussion about QEMU capability caching, why we need it, what we ne=
ed to
get rid of it (answer: early QMP?).

Markus: would --query-FOO for some FOOs help? libvirt developers seem to =
prefer
early QMP.

----------------

Now that libvirt queries QEMU for host CPUID capabilities, there are more
interesting ways the cache may need to be invalidated.

Markus: =E2=80=9Cthere's a it of a combinatorial explosion, i.e. query re=
sults can
depend on so much more than just the QEMU version and machine type.  Make=
s
invalidating the cache tricky, and possibly even finding something useful=
 in it
insufficiently likely to be worth the trouble.=E2=80=9D

----------------

Some discussion about libvirt/qemu versions compatibility.  Markus propos=
es that
we could choose to make newer QEMU require a more recent libvirt version.
OpenStack Nova re-evaluates every 6 months what next minimum libvirt and =
QEMU
versions to use (via constants: NEXT_MIN_LIBVIRT_VERSION, NEXT_MIN_QEMU_V=
ERSION)

Markus: =E2=80=9CThe version decoupling we have is really nice, but I thi=
nk an
occasional dependency would be tolerable.  Consider it when it saves lots=
 of
work.=E2=80=9D

Markus: =E2=80=9CAlso: drop support for old versions of QEMU.  Anything b=
efore 1.5?=E2=80=9D

----------------

References and notes:

[1] References for =E2=80=9CEarly QMP=E2=80=9D:

* Igor=E2=80=99s proposal at:
  Subject: [Qemu-devel] [RFC 0/6] enable numa configuration before  machi=
ne_init() from HMP/QMP
  https://www.mail-archive.com/qemu-devel@nongnu.org/msg488601.html
* And what Eduardo has suggested at:
  http://www.linux-kvm.org/images/4/46/03x06A-Eduardo_HabkostMachine-type=
_Introspection_and_Configuration_Where_Are_We_Going.pdf

Comments from Markus:

> Related: "Why /two/ config interfaces?" in my KVM Forum talk.  The two
> being CLI and QMP.
>
> We've long held the idea to support starting QEMU with a minimal comman=
d
> line, then do all configuration via QMP.  Not possible today, because
> lots of things can only be done via CLI.  In part because QMP becomes
> available only after quite a few config boats have sailed.
>
> Making QMP available earlier during startup ("early QMP") would be a
> stepping stone towards the "only QMP" goal.
>
> Related: rebasing CLI onto QAPI would make replicating CLI-only
> interfaces in QMP easier.

--=20
Eduardo
