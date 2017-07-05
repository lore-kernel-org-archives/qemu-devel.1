Received: from eggs.gnu.org ([2001:4830:134:3::10]:40752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dSi6a-0005Qb-Ny
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 07:04:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dSi6Z-0000h7-CA
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 07:04:24 -0400
Date: Wed, 5 Jul 2017 21:04:14 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170705110414.GN2180@umbus.fritz.box>
References: <20170621091848.28256-1-david@gibson.dropbear.id.au>
	<f89c6897-9555-100a-7252-a705fcbc8ee6@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xTKfHyrFnSV9DG3y"
Content-Disposition: inline
In-Reply-To: <f89c6897-9555-100a-7252-a705fcbc8ee6@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 0/5] spapr: DRC cleanups (part
 VI)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: mdroth@linux.vnet.ibm.com, lvivier@redhat.com, sursingh@redhat.com, qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org, bharata@linux.vnet.ibm.com


--xTKfHyrFnSV9DG3y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 04, 2017 at 06:13:31PM -0300, Daniel Henrique Barboza wrote:
> I just tested this patch set on top of current ppc-for-2.10 branch (which
> contains
> the patches from part V). It applied cleanly but required a couple of
> trivial
> fixes to build probably because it was made on top of an older code base.

Right, I fixed that up locally already, but haven't gotten around to
reposting yet.  You can look at the 'drcVI' branch on my github tree,
if you're interested.

> The trivial migration test worked fine. The libvirt scenario (attaching a
> device on
> target before migration, try to unplug after migration) isn't working as
> expected
> but we have a different result with this series. Instead of silently fail=
ing
> to unplug
> with error messages on dmesg, the hot unplug works on QEMU level:

Thanks for testing.  Just to clarify what you're saying here, you
haven't spotted a regression with this series, but there is a case
which was broken and is still broken with slightly different
symptoms.  Yes?

>=20
> (qemu) device_del core1
> (qemu)
> (qemu) info cpus
> * CPU #0: nip=3D0xc0000000000a3e0c thread_id=3D86162
> (qemu) info hotpluggable-cpus
> Hotpluggable CPUs:
>   type: "host-spapr-cpu-core"
>   vcpus_count: "1"
>   CPUInstance Properties:
>     core-id: "3"
>   type: "host-spapr-cpu-core"
>   vcpus_count: "1"
>   CPUInstance Properties:
>     core-id: "2"
>   type: "host-spapr-cpu-core"
>   vcpus_count: "1"
>   CPUInstance Properties:
>     core-id: "1"
>   type: "host-spapr-cpu-core"
>   vcpus_count: "1"
>   qom_path: "/machine/unattached/device[0]"
>   CPUInstance Properties:
>     core-id: "0"
> (qemu)
>=20
>=20
> However, any operation on the guest afterwards (tried with lscpu and dmes=
g)
> seems
> to hung the guest. This is what I got when trying to do a dmesg after the
> hot unplug:

Ouch.  That's bad.  I'll have to look into it.

I have rather a lot on my plate at the moment - if you get a chance to
work out which of the patches in the series causes this behaviour,
that could be handy.

> danielhb@ubuntu1704:~$
> danielhb@ubuntu1704:~$
> danielhb@ubuntu1704:~$ dmesg | tail -n 5
> ^C
>=20
> [  362.749693] INFO: task kworker/u8:1:30 blocked for more than 120 secon=
ds.
> [  362.749819]       Not tainted 4.10.0-26-generic #30-Ubuntu
> [  362.749892] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
> this message.
> [  362.750224] INFO: task kworker/0:3:1887 blocked for more than 120
> seconds.
> [  362.750320]       Not tainted 4.10.0-26-generic #30-Ubuntu
> [  362.750394] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
> this message.
> [  483.568842] INFO: task kworker/u8:1:30 blocked for more than 120 secon=
ds.
> [  483.568997]       Not tainted 4.10.0-26-generic #30-Ubuntu
> [  483.569067] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
> this message.
> [  483.569364] INFO: task kworker/0:3:1887 blocked for more than 120
> seconds.
> (...)
>=20
>=20
> I am not sure if it was intended for this scenario to work with this patch
> set already. Figured
> it can serve as a FYI for the next series.

This might be due to a problem I've discussed previously with
Laurent.  libvirt uses device_add on the destination's monitor before
sending the migration stream, rather than starting the destination
with already-hotplugged devices as -device.

To my surprise, there doesn't seem to be a system reset between that
device_add phase and processing the incoming stream, which means DRCs
for those devices might be in the wrong state.

I might need to explicitly trigger a reset of DRC state at incoming
migration time to handle this.

> Given that hotplug/unplug without migration still works and on the
> assumption that
> we'll look more into this libvirt scenario in the next spins, +1.
>=20
>=20
> Tested-by: Daniel Barboza <danielhb@linux.vnet.ibm.com>
>=20
>=20
>=20
> On 06/21/2017 06:18 AM, David Gibson wrote:
> > This sixth set of DRC cleanup patches (to be applied on top of the
> > patches from part V) is a complete rework of DRC state management.  We
> > stop tracking some unnecessary things, and change the basic state
> > representation to a simpler and more robust model.
> >=20
> > Most of the patches in this set "break" migration from earlier git
> > snapshots, but not from any released qemu version.  The previous
> > migration stream format had multiple problems, so better to fix them
> > now, before 2.10 is out.
> >=20
> > David Gibson (5):
> >    spapr: Remove 'awaiting_allocation' DRC flag
> >    spapr: Refactor spapr_drc_detach()
> >    spapr: Cleanups relating to DRC awaiting_release field
> >    spapr: Consolidate DRC state variables
> >    spapr: Remove sPAPRConfigureConnectorState sub-structure
> >=20
> >   hw/ppc/spapr.c             |   9 +-
> >   hw/ppc/spapr_drc.c         | 321 +++++++++++++++++++++---------------=
---------
> >   hw/ppc/spapr_pci.c         |  13 +-
> >   hw/ppc/trace-events        |   3 +-
> >   include/hw/ppc/spapr_drc.h |  53 +++++---
> >   5 files changed, 187 insertions(+), 212 deletions(-)
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--xTKfHyrFnSV9DG3y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZXMesAAoJEGw4ysog2bOSiH8P/31lYQZbvYBsxlvfGbq1eZT2
ylSprcQJ8RCOB737G6bmSbzHsy2/sU4S3wA5XFOJ/ysiLpabWde6/H4fRjy1vMWW
w+gsvf48/m3ewz0dwGoiJszJhjEAxqQUZX5x8xodTPOwIxOEKYoh4QYOZIRhR2Rf
XeCyum3mTBHXXLv7OiYBi6EJjCRSfYhdWUD+KJkcjcCKHeGch1lEstokhsK3vDuI
S+4Jf1jIgX5inTh9yZh4lmLec8djdYc83dArx6XyCOCbehogZMa9/h6SYAdcBmPL
UrVwr31bSJbgl9KvlBz4gyREMrmSakRW/x04GsVhn7/2snfu536XiuMlyt5CQGAe
lNtNEIvz/fC1DqOQMjOcWLximG9uLkwHeoRw/NzI0qRb9PUN57sNKM83ojokSh46
kczbGlN1kPLCdjqP0bk53WN9lbtg9W3hHVUakczeTVKCCLRs9TmbU7JCk/MAkczS
g1gCqDt+g7MBLukCvdoclfyq/eSDdJpHablH+9fu8d7pfqXSHFvHtzj6Vjl5+V7a
z9QzQnCDJsT3+4d34/sOsQLmBTk+8FyijT6sFg8LS6mQN2Tu650P33IfR7USDpbB
YNTZ0EDkTunmy4epLu7R9KjRip+3NZqgAESUlqz+TT+lmFDw4G+ZdTT5sYUqEX68
2af/qJZbdiNjQi8IusiN
=wA0P
-----END PGP SIGNATURE-----

--xTKfHyrFnSV9DG3y--
