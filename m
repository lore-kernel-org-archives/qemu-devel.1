Received: from eggs.gnu.org ([2001:4830:134:3::10]:58574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dDT0r-00087D-5V
	for qemu-devel@nongnu.org; Wed, 24 May 2017 05:55:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dDT0m-0007R3-BG
	for qemu-devel@nongnu.org; Wed, 24 May 2017 05:55:29 -0400
Received: from 7.mo2.mail-out.ovh.net ([188.165.48.182]:48429)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dDT0m-0007QD-4n
	for qemu-devel@nongnu.org; Wed, 24 May 2017 05:55:24 -0400
Received: from player718.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 432D18D5B2
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 11:55:22 +0200 (CEST)
Date: Wed, 24 May 2017 11:55:13 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170524115513.71a014f2@bahia.ttt.fr.ibm.com>
In-Reply-To: <20170524045236.GU30246@umbus.fritz.box>
References: <20170523111812.13469-1-lvivier@redhat.com>
	<20170523111812.13469-2-lvivier@redhat.com>
	<20170523172842.1fce414e@bahia.ttt.fr.ibm.com>
	<bc9a69f9-eb7b-943a-a9bf-bb4a3b18f525@redhat.com>
	<20170524045236.GU30246@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/Tdv6VtLJsbJpPtVFGXm95LX";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 1/4] spapr: add pre_plug
 function for memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

--Sig_/Tdv6VtLJsbJpPtVFGXm95LX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 24 May 2017 14:52:36 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:
[...]
>=20
> This patch seems like a good idea regardless of the rest, so I've
> fixed the minor nits Greg pointed out and merged to ppc-for-2.10.
>=20

David,

Commit d2e4c6a1437fab2fbb4553b598f25e282c475199 in your ppc-for-2.10 branch
doesn't compile:

+static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState=
 *dev,
+                                  Error **errp)
+{
+    PCDIMMDevice *dimm =3D PC_DIMM(dev);
+    PCDIMMDeviceClass *ddc =3D PC_DIMM_GET_CLASS(dimm);
+    MemoryRegion *mr =3D ddc->get_memory_region(dimm);
+    uint64_t size =3D memory_region_size(mr);
+    char *mem_dev;
+
+    if (size % SPAPR_MEMORY_BLOCK_SIZE) {
+        error_setg(&local_err, "Hotplugged memory size must be a multiple =
of "

s/&local_err/errp/

+                      "%lld MB", SPAPR_MEMORY_BLOCK_SIZE / M_BYTE);
+        goto out;

s/goto out/return/

+    }
+
+    mem_dev =3D object_property_get_str(OBJECT(dimm), PC_DIMM_MEMDEV_PROP,=
 NULL);
+    if (mem_dev && !kvmppc_is_mem_backend_page_size_ok(mem_dev)) {
+        error_setg(errp, "Memory backend has bad page size. "
+                   "Use 'memory-backend-file' with correct mem-path.");
+    }
+}
+

--Sig_/Tdv6VtLJsbJpPtVFGXm95LX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlklWIEACgkQAvw66wEB28LxfgCfcEPIwk4syIkaiWELFnCTL8nn
1hEAnAhZPivuDrXOYRpqzfchpBM9bNBW
=lq2+
-----END PGP SIGNATURE-----

--Sig_/Tdv6VtLJsbJpPtVFGXm95LX--
