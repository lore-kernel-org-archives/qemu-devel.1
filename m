Received: from eggs.gnu.org ([2001:4830:134:3::10]:40477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elliott@hpe.com>) id 1fJR2s-0006VF-6a
	for qemu-devel@nongnu.org; Thu, 17 May 2018 18:06:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elliott@hpe.com>) id 1fJR2o-0000Ta-Vi
	for qemu-devel@nongnu.org; Thu, 17 May 2018 18:06:46 -0400
Received: from g9t5008.houston.hpe.com ([15.241.48.72]:48812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <elliott@hpe.com>) id 1fJR2o-0000Sz-OM
	for qemu-devel@nongnu.org; Thu, 17 May 2018 18:06:42 -0400
From: "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>
Date: Thu, 17 May 2018 22:06:37 +0000
Message-ID: <AT5PR8401MB11697DD6A19AA3F499ACDDBAAB910@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
References: <20180517050024.20101-1-ross.zwisler@linux.intel.com>
	<20180517050024.20101-4-ross.zwisler@linux.intel.com>
In-Reply-To: <20180517050024.20101-4-ross.zwisler@linux.intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [qemu PATCH v2 3/4] nvdimm,
 acpi: support NFIT platform capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Ross Zwisler' <ross.zwisler@linux.intel.com>, Igor Mammedov <imammedo@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>



> -----Original Message-----
> From: Linux-nvdimm [mailto:linux-nvdimm-bounces@lists.01.org] On Behalf O=
f
> Ross Zwisler
> Sent: Thursday, May 17, 2018 12:00 AM
> Subject: [qemu PATCH v2 3/4] nvdimm, acpi: support NFIT platform
> capabilities
>=20
> Add a machine command line option to allow the user to control the
> Platform
> Capabilities Structure in the virtualized NFIT.  This Platform
> Capabilities
> Structure was added in ACPI 6.2 Errata A.
>=20
...
> +Platform Capabilities
> +---------------------
> +
> +ACPI 6.2 Errata A added support for a new Platform Capabilities Structur=
e
> +which allows the platform to communicate what features it supports
> related to
> +NVDIMM data durability.  Users can provide a capabilities value to a
> guest via
> +the optional "nvdimm-cap" machine command line option:
> +
> +    -machine pc,accel=3Dkvm,nvdimm,nvdimm-cap=3D2
> +
> +As of ACPI 6.2 Errata A, the following values are valid for the bottom
> two
> +bits:
> +
> +2 - Memory Controller Flush to NVDIMM Durability on Power Loss Capable.
> +3 - CPU Cache Flush to NVDIMM Durability on Power Loss Capable.

It's a bit unclear that those are decimal values for the field, not=20
bit numbers.

...
> -static GArray *nvdimm_build_device_structure(void)
> +/*
> + * ACPI 6.2 Errata A: 5.2.25.9 NVDIMM Platform Capabilities Structure
> + */
> +static void
> +nvdimm_build_structure_caps(GArray *structures, uint32_t capabilities)
> +{
> +    NvdimmNfitPlatformCaps *nfit_caps;
> +
> +    nfit_caps =3D acpi_data_push(structures, sizeof(*nfit_caps));
> +
> +    nfit_caps->type =3D cpu_to_le16(7 /* NVDIMM Platform Capabilities */=
);
> +    nfit_caps->length =3D cpu_to_le16(sizeof(*nfit_caps));
> +    nfit_caps->highest_cap =3D 2;
> +    nfit_caps->capabilities =3D cpu_to_le32(capabilities);

highest_cap needs to be set to a value that at least covers the highest=20
bit set to 1 used in capabilities.

As capabilities bits are added, there are three different meanings:
* 1: bit within highest_cap range, platform is claiming the 1 meaning
* 0: bit within highest_cap range, platform is claiming the 0 meaning
* not reported: bit not within highest_cap range, so the platform's
  implementation of this feature is unknown. Not necessarily the same=20
  as the 0 meaning.

So, there should be a way to specify a highest_cap value to convey that
some of the upper capabilities bits are valid and contain 0.

---
Robert Elliott, HPE Persistent Memory
