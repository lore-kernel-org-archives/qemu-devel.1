Received: from eggs.gnu.org ([2001:4830:134:3::10]:55501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elliott@hpe.com>) id 1fJiNo-0002bg-0i
	for qemu-devel@nongnu.org; Fri, 18 May 2018 12:37:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elliott@hpe.com>) id 1fJiNk-0004l3-Lu
	for qemu-devel@nongnu.org; Fri, 18 May 2018 12:37:32 -0400
Received: from g9t5009.houston.hpe.com ([15.241.48.73]:57352)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <elliott@hpe.com>) id 1fJiNk-0004kc-EI
	for qemu-devel@nongnu.org; Fri, 18 May 2018 12:37:28 -0400
From: "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>
Date: Fri, 18 May 2018 16:37:10 +0000
Message-ID: <AT5PR8401MB11694A7F7825A488105AEFADAB900@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
References: <20180517050024.20101-1-ross.zwisler@linux.intel.com>
	<20180517050024.20101-4-ross.zwisler@linux.intel.com>
	<AT5PR8401MB11697DD6A19AA3F499ACDDBAAB910@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
	<20180518152306.GA3413@linux.intel.com>
In-Reply-To: <20180518152306.GA3413@linux.intel.com>
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
To: 'Ross Zwisler' <ross.zwisler@linux.intel.com>
Cc: Igor Mammedov <imammedo@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>



...
> Would it help to show them in hex?
>=20
>   As of ACPI 6.2 Errata A, the following values are valid for the bottom
>   two bits:
>=20
>   0x2 - Memory Controller Flush to NVDIMM Durability on Power Loss Capabl=
e.
>   0x3 - CPU Cache Flush to NVDIMM Durability on Power Loss Capable.

Yes, that helps (unless the parser for that command-line does not=20
accept hex values).

It would also help to make the text be:
	"CPU Cache and Memory Controller Flush"

...
> > So, there should be a way to specify a highest_cap value to convey that
> > some of the upper capabilities bits are valid and contain 0.
>=20
> Right, I'll make this dynamic based on the capabilities value passed in b=
y
> the user.  That's a much better solution, thanks.  This should cover all =
the
> same cases as you have outlined above, without burdening the user with ye=
t
> another input value.

Automatically determining the highest bit that the user wants to set to 1
should be easy, and will probably be the most common case.

It's harder to let the user set some upper bits to 0 but also have them
within the highest_cap range.  Since this will be less common, the syntax
could be more convoluted, like an optional highest_cap argument
to override the automatically generated value.

For example, to report bits 7, 1 and 0 are all set to 1:
	-machine pc,accel=3Dkvm,nvdimm,nvdimm-cap=3D0x83
would automatically set highest_cap to 7.

To report bit 7 set to 0 while bits 1 and 0 are set to 1:
	-machine pc,accel=3Dkvm,nvdimm,nvdimm-cap=3D0x3,nvdimm-highest-cap=3D7



=20
