Received: from eggs.gnu.org ([2001:4830:134:3::10]:57294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dKtaV-00063w-AH
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 17:43:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dKtaS-0002VK-7b
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 17:42:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33564
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dKtaS-0002Tq-1a
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 17:42:56 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5DLcmME064788
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 17:42:55 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2b2q9w21x4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 17:42:54 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 13 Jun 2017 17:42:54 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170609102733.0eb7293d@nial.brq.redhat.com>
References: <20170530160445.12810-1-lvivier@redhat.com>
	<20170531043557.GI12163@umbus.fritz.box>
	<149695205346.23353.3484869110998357783@loki>
	<20170609102733.0eb7293d@nial.brq.redhat.com>
Date: Tue, 13 Jun 2017 16:42:45 -0500
Message-Id: <149739016562.5725.6958577924052221756@loki>
Subject: Re: [Qemu-devel] [PATCH] spapr: manage hotplugged devices while the
 VM is not started
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

Quoting Igor Mammedov (2017-06-09 03:27:33)
> On Thu, 08 Jun 2017 15:00:53 -0500
> Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> =

> > Quoting David Gibson (2017-05-30 23:35:57)
> > > On Tue, May 30, 2017 at 06:04:45PM +0200, Laurent Vivier wrote:  =

> > > > For QEMU, a hotlugged device is a device added using the HMP/QMP
> > > > interface.
> > > > For SPAPR, a hotplugged device is a device added while the
> > > > machine is running. In this case QEMU doesn't update internal
> > > > state but relies on the OS for this part
> > > > =

> > > > In the case of migration, when we (libvirt) hotplug a device
> > > > on the source guest, we (libvirt) generally hotplug the same
> > > > device on the destination guest. But in this case, the machine
> > > > is stopped (RUN_STATE_INMIGRATE) and QEMU must not expect
> > > > the OS will manage it as an hotplugged device as it will
> > > > be "imported" by the migration.
> > > > =

> > > > This patch changes the meaning of "hotplugged" in spapr.c
> > > > to manage a QEMU hotplugged device like a "coldplugged" one
> > > > when the machine is awaiting an incoming migration.
> > > > =

> > > > Signed-off-by: Laurent Vivier <lvivier@redhat.com>  =

> > > =

> > > So, I think this is a reasonable concept, at least in terms of
> > > cleanliness and not doing unnecessary work.  However, if it's fixing
> > > bugs, I suspect that means we still have problems elsewhere.  =

> > =

> > I was hoping a lot of these issues would go away once we default
> > the initial/reset DRC states to "coldplugged". I think your pending
> > patch:
> > =

> >   "spapr: Make DRC reset force DRC into known state"
> > =

> > But I didn't consider the fact that libvirt will be issuing these
> > hotplugs *after* reset, so those states would indeed need to
> > be fixed up again to reflect boot-time,attached as opposed to
> > boot-time,unattached before starting the target.
> > =

> > So I do think this patch addresses a specific bug that isn't
> > obviously fixable elsewhere.
> > =

> > To me it seems like the only way to avoid doing something like
> > what this patch does is to migrate all attached DRCs from the
> > source in all cases.
> > =

> > This would break backward-migration though, unless we switch from
> > using subregions for DRCs to explicitly disabling DRC migration
> > based on machine type.
> we could leave old machines broken and fix only new machine types,
> then it would be easy ot migrate 'additional' DRC state as subsection
> only on new for new machines.

That's an option, but subsections were only really used for backward
compatibility. Not sure how much we have to gain from using both.

> =

> > =

> > That approach seems to similar to what x86 does, e.g.
> > hw/acpi/ich9.c and hw/acpi/piix.c migrate vmstate_memhp_state
> > (corresponding to all DIMMs' slot status) in all cases where
> > memory hotplug is enabled. If they were to do this using
> > subregions for DIMMs in a transitional state I think similar
> > issues would pop up in that code as well.
> > =

> > Even if we take this route, we still need to explicitly suppress
> > hotplug events during INMIGRATE to avoid extra events going on
> > the queue. *Unless* we similarly rely purely on the ones sent by
> > the source.
> pc/q35 might also lose events if device is hotplugged during migration,
> in addition migration would fail anyway since dst qemu
> should be launched with all devices that are present on src.
> =

> ex: consider if one hotplugs DIMM during migration, it creates
> RAM region mapped into guest and that region might be transferred
> as part of VMState (not sure if it even works)
> and considering dst qemu has no idea about hotplugged memory mapping,
> the migration would fail on receiving unknown VMState.
> =

> Hotplug generally doesn't work during migration, so it should be disabled
> in a generic way on migration start and re-enabled on target
> on migration completion. How about blocking device_add when
> INMIGRATE state and unblocking it when switching to runnig on dst?

Maybe I'm misunderstanding the intent of this patch, but in our own
testing we've seen that even for CPUs hotplugged *before* migration
starts, libvirt will add them to the dest via device_add instead of
via the command-line.

If the CPUs were all specified via command-line, I don't think these
patches would be needed, since the coldplug hooks would be executed
without the need to make any special considerations for INMIGRATE.

This libvirt commit seems to confirm that the CPUs are added via
device_add, and we've seen similar behavior in our testing:


commit 9eb9106ea51b43102ee51132f69780b2c86ccbca
Author: Peter Krempa <pkrempa@redhat.com>
Date:   Thu Aug 4 14:36:24 2016 +0200

    qemu: command: Add support for sparse vcpu topologies
    =

    Add support for using the new approach to hotplug vcpus using device_add
    during startup of qemu to allow sparse vcpu topologies.
    =

    There are a few limitations imposed by qemu on the supported
    configuration:
    - vcpu0 needs to be always present and not hotpluggable
    - non-hotpluggable cpus need to be ordered at the beginning
    - order of the vcpus needs to be unique for every single hotpluggable
      entity
    =

    Qemu also doesn't really allow to query the information necessary to
    start a VM with the vcpus directly on the commandline. Fortunately they
    can be hotplugged during startup.
    =

    The new hotplug code uses the following approach:
    - non-hotpluggable vcpus are counted and put to the -smp option
    - qemu is started
    - qemu is queried for the necessary information
    - the configuration is checked
    - the hotpluggable vcpus are hotplugged
    - vcpus are started
    =

    This patch adds a lot of checking code and enables the support to
    specify the individual vcpu element with qemu.


So I don't think disabling migration during inmigrate is a possible
alternative unless we rework how libvirt handles this. The only
alternative to this patch that I'm aware of would be to always
migrate DRCs when dev->hotplugged =3D=3D true.
