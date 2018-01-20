Received: from eggs.gnu.org ([2001:4830:134:3::10]:58593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ecr0y-0004nc-Vp
	for qemu-devel@nongnu.org; Sat, 20 Jan 2018 06:08:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ecr0u-0006sd-5x
	for qemu-devel@nongnu.org; Sat, 20 Jan 2018 06:08:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42298)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ecr0t-0006sA-Sk
	for qemu-devel@nongnu.org; Sat, 20 Jan 2018 06:08:44 -0500
Date: Sat, 20 Jan 2018 09:08:33 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180120110833.GF5292@localhost.localdomain>
References: <20180119141105.29095-1-marcandre.lureau@redhat.com>
	<20180119141105.29095-5-marcandre.lureau@redhat.com>
	<f95bf39c-f989-0044-b072-954aa1fd5f13@linux.vnet.ibm.com>
	<20180119184216.GE5292@localhost.localdomain>
	<ddb9d984-03b8-9ae6-fb3e-e85dd648e9c5@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ddb9d984-03b8-9ae6-fb3e-e85dd648e9c5@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/5] tpm: add CRB device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Fri, Jan 19, 2018 at 04:56:31PM -0500, Stefan Berger wrote:
> On 01/19/2018 01:42 PM, Eduardo Habkost wrote:
> > On Fri, Jan 19, 2018 at 12:10:03PM -0500, Stefan Berger wrote:
> > > On 01/19/2018 09:11 AM, Marc-Andr=C3=A9 Lureau wrote:
> > > > tpm_crb is a device for TPM 2.0 Command Response Buffer (CRB)
> > > > Interface as defined in TCG PC Client Platform TPM Profile (PTP)
> > > > Specification Family =E2=80=9C2.0=E2=80=9D Level 00 Revision 01.0=
3 v22.
> > > >=20
> > > > The PTP allows device implementation to switch between TIS and CR=
B
> > > > model at run time, but given that CRB is a simpler device to
> > > > implement, I chose to implement it as a different device.
> > > >=20
> > > > The device doesn't implement other locality than 0 for now (my la=
ptop
> > > > TPM doesn't either, so I assume this isn't so bad)
> > > >=20
> > > > The command/reply memory region is statically allocated after the=
 CRB
> > > > registers address TPM_CRB_ADDR_BASE + sizeof(struct crb_regs) (I
> > > > wonder if the BIOS could or should allocate it instead, or what s=
ize
> > > > to use, again this seems to fit well expectations)
> > > I removed this last sentence now. It's at the right location.
> > >=20
> > > > The PTP doesn't specify a particular bus to put the device. So I =
added
> > > > it on the system bus directly, so it could hopefully be used easi=
ly on
> > > > a different platform than x86. Currently, it fails to init on pii=
x,
> > > > because error_on_sysbus_device() check. The check may be changed =
in a
> > > > near future, see discussion on the qemu-devel ML.
> > > I think this has to be solved. So I remove these last 2 sentences. =
I'll have
> > > to wait until that other patch series from Eduard is merged since i=
t doesn't
> > > start yet.
> > The series was just merged to master.  It's possible to make a
> > machine accept the new device using
> > machine_class_allow_dynamic_sysbus_dev(), now.
>=20
> I saw that.
> >=20
> > However, is it really necessary to make it a sysbus device?
> > Having bus-less devices was not possible in the past, but it is
> > possible today.
> >=20
> What I don't like about it is the fact that I would have to use q35 if =
we
> only extend that machine type to allow this sysbus device. What is the
> reason that dynamic sysbus devices have to explicitly be allowed? If we
> don't need to limit this device to a certain machine type that may be m=
ore
> user friendly.

Most sysbus devices don't work unless they have additional
supporting machine code to wire them at the right addresses.
Devices that work without extra machine code (like *-iommu) are
the exception.

I think the last time I saw an explanation for this was at:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg439549.html

--=20
Eduardo
