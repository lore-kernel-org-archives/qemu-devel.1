Received: from eggs.gnu.org ([2001:4830:134:3::10]:57747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dDRB9-0004Cg-7s
	for qemu-devel@nongnu.org; Wed, 24 May 2017 03:58:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dDRB8-00019n-11
	for qemu-devel@nongnu.org; Wed, 24 May 2017 03:57:59 -0400
Date: Wed, 24 May 2017 17:32:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170524073259.GZ30246@umbus.fritz.box>
References: <20170522193551.826-1-danielhb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XUd+PsnCfaVdInSg"
Content-Disposition: inline
In-Reply-To: <20170522193551.826-1-danielhb@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v11 0/5] migration/ppc: migrating DRC and
 ccs_list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com


--XUd+PsnCfaVdInSg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I've merged 1..4 with some minor changes for style and error
handling.  5/5 I still need to review in a bit more detail.

On Mon, May 22, 2017 at 04:35:46PM -0300, Daniel Henrique Barboza wrote:
> v11:
> - rebased with dgibson/ppc-for-2.10 branch
> - patch 1:
>     * use PCDIMMDevice* as index of pending_dimm_unplugs list instead of
> using its uint64_t address;
>     * spapr_del_lmbs() function was merged with spapr_memory_unplug_reque=
st();
>     * wherever applicable, retrieve the machine by using HotplugHandler;
>     * added more info about the sPAPRDIMMState cache in the comment of
> spapr.h.
>=20
> v10:
> - removed 'migrating pending_events' patch this series
> - patch 1:
>     * removed extra line between definitions;
>     * removed spapr_pending_dimms functions definitons from spapr.h
>     * turned spapr_pending_dimms functions into static
> - patch 2:
>     * fixed the switch() statement - PHB and VIO cases goes to default,
> default now executes assert()
> - patch 3:
>     * minor style changes/fixes
>     * changed switch default to execute assert() and now uses the same
> logic for both CPU and LMB DRCs=20
> - patch 4 (*new*):
>     * this new patch implements a new function to recover the pending DIMM
> unplug LMB state inside the spapr_lmb_release callback
>=20
> v9:
> - patch 1 (*new*): added a qtail in sPAPRMachineState called pending_dimm=
_unplugs
> that stores the DIMM LMB state during the unplug process.
> - patch 2 (*new*): merged v8-patch1 and v8-patch2: removing detach_cb and
> detach_cb_opaque.
> - patch 3:
>     * removed dk->vmsd entry. We're using vmstate_register instead
>     * added 'awaiting_allocation' flag in the DRC migration
> - patch 4 (*new*): migrating spapr->pending_dimm_unplugs qtailq to allow
> for an ongoing PCDIMM unplug to continue after a migration.
>=20
> v8:
> - new patch added: 'removing spapr_drc_detach_cb opaques'. This new patch=
 removes
> the need for the detach_cb_opaques inside the removal callback functions.=
 See
> the commit message of the patch for more info.
>=20
> v7:
> - removed the first patch. DRC registration is now done by vmstate_regist=
er
> in patch 2.
> - added a new patch that changes spapr_dr_connector_new to receive as arg=
ument
> the detach_cb.
> - removed the callback logic of patch 2 since there is no need to restore=
 the
> detach_cb on post-load due to the detach_cb on spapr_dr_connector_new cha=
nge.
> - added word separators in the VMSD names of patch 3 and 4.
>=20
> v6: - Rebased with QEMU master after 6+ months.
>     - Simplified the logic in patch 1.
>     - Reworked patch 2: added CPU DRC migration, removed a function point=
er from DRC
> class and minor improvements.
>     - Added clarifications from the previous v5 discussions in the commit=
 messages.
>=20
> v5: - Rebased to David's ppc-for-2.8.
>=20
> v4: - Introduce a way to set customized instance_id in SaveStateEntry. Us=
e it
>       to set instance_id for DRC using its unique index to address David=
=20
>       Gibson's concern.
>     - Rename VMS_CSTM to VMS_LINKED based on Paolo Bonzini's suggestions.
>     - Clean up qjson stuff in put_qtailq.=20
>     - Add trace for put_qtailq and get_qtailq based on David Gilbert's=20
>       suggestion.
>=20
>     - Based on David's ppc-for-2.7.=20
>=20
> v3: - Simplify overall design followng discussion with Paolo. No longer n=
eed
>       metadata to migrate QTAILQ.
>     - Extend VMStateInfo instead of adding similar fields to VMStateField.
>     - Clean up macros in qemu/queue.h.
> (link: https://lists.nongnu.org/archive/html/qemu-devel/2016-05/msg05695.=
html)
>=20
> v2: - Introduce a general approach to migrate QTAILQ in qemu/queue.h.
>     - Migrate signalled field in the DRC state.
>     - Put the newly added migrating fields in subsections so that backwar=
d=20
>       migration is not broken. =20
>     - Set detach_cb field right after migration so that a migrated hot-un=
plug
>       event could finish its course.
> (link: https://lists.nongnu.org/archive/html/qemu-devel/2016-05/msg04188.=
html)
>=20
> v1: - Inital version.
> (link: https://lists.nongnu.org/archive/html/qemu-devel/2016-04/msg02601.=
html)
>=20
>=20
> To make guest devices (PCI, CPU and memory) hotplug work together=20
> with guest migration, spapr drc state needs be transmitted in
> migration. This patch defines the VMStateDescription struct for
> spapr drc state to enable it.
>=20
> To fix the potential racing between hotplug events on guest and=20
> guest migration and ccs_list of spapr state need be transmitted in
> migration. This patch set also takes care of it.
>=20
>=20
> Daniel Henrique Barboza (4):
>   hw/ppc/spapr.c: adding pending_dimm_unplugs to sPAPRMachineState
>   hw/ppc: removing drc->detach_cb and drc->detach_cb_opaque
>   hw/ppc: migrating the DRC state of hotplugged devices
>   hw/ppc/spapr.c: recover pending LMB unplug info in spapr_lmb_release
>=20
> Jianjun Duan (1):
>   migration: spapr: migrate ccs_list in spapr state
>=20
>  hw/ppc/spapr.c              | 175 +++++++++++++++++++++++++++++++++++---=
------
>  hw/ppc/spapr_drc.c          |  92 +++++++++++++++++++----
>  hw/ppc/spapr_pci.c          |   5 +-
>  include/hw/pci-host/spapr.h |   3 +
>  include/hw/ppc/spapr.h      |  10 +++
>  include/hw/ppc/spapr_drc.h  |   8 +-
>  6 files changed, 233 insertions(+), 60 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--XUd+PsnCfaVdInSg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIbBAEBCAAGBQJZJTcnAAoJEGw4ysog2bOSDZEP90GRe8utPleVmkjCSYIfsUdf
m+f2R6Wh0eg3B4Rj/gz/0dWMQs3GoywlU9XxF0h4sAujjg32OT/ZfxWbc63fhlps
QZ4bIo3J6uHO8MTaw6Uha0aiQVqh1mLJrEh+Q4mQSqIDKyW8xJNSeTNHG5w3mNo6
bYaC+e6HR8j1hXmbbm7bWylpEpZ4bFOFlDRBtQdgwpOFFA6ZZFELL9m802srZYS0
7sHpOxhk4dNc96aCYMVk+1GredN4hHpoa3HXezTh0zEJYx2kVQpNwak5FCVcBGeQ
koJfLZTAdRg/3A0CiaBFE7ThvdK/Mn2FK8flkyqjE/90iNxevGWHbmFICrL+dzi/
bqtgqg81xSXUTaZUruFQaSN8ChLeU89By7D8Qkyjxg07ToaBXFmbXDcqS3X4L3tH
JpQbTO9HkDkJdj6Gv/t+U1sLwK8MStFXviMsYGGVOQyghL3hmGs+1PSJKW6S1WnM
DouH8xTMD2JmT0lMVNjl7cBPq1Xj4eFIhK4NsEPSmNDMo8KhXPxz+wvL5M7ekJzv
txtVGHy3gNAsgEsesDg+gVP23v+r8HuIxDibiPPmEXx25/heohu8KDj7yvlEIfVR
xvhRyvoP1t1dL8dBzpIsO8ETSgmCXoDzozQUtrN3qDUSTxYXLbYQQ8guRFZ6WL0N
OH+nVxSFGLzySVAA1h8=
=MZWa
-----END PGP SIGNATURE-----

--XUd+PsnCfaVdInSg--
