Received: from eggs.gnu.org ([2001:4830:134:3::10]:48563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e20zg-0006kv-2V
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 16:19:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e20zc-0004xQ-Tz
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 16:19:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46934)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e20zc-0004x6-OG
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 16:19:08 -0400
Date: Tue, 10 Oct 2017 17:19:00 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171010201900.GL3246@localhost.localdomain>
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
	<20171009225623.29232-43-marcandre.lureau@redhat.com>
	<0480245b-4a0b-c3a4-5d73-831c4d05e777@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <0480245b-4a0b-c3a4-5d73-831c4d05e777@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 42/42] WIP: add TPM CRB device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, amarnath.valluri@intel.com, "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On Tue, Oct 10, 2017 at 02:28:19PM -0400, Stefan Berger wrote:
> On 10/09/2017 06:56 PM, Marc-Andr=E9 Lureau wrote:
> > +
> > +static void tpm_crb_realizefn(DeviceState *dev, Error **errp)
> > +{
> > +    CRBState *s =3D CRB(dev);
> > +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
> > +
> > +    if (!tpm_find()) {
> > +        error_setg(errp, "at most one TPM device is permitted");
>=20
>=20
> Shouldn't that be the case if tpm_find() !=3D NULL ?

It's tricky: due to the way it's implemented (using
object_resolve_path_type()) tpm_find() will be able to find @dev
itself, because it is already attached to the device tree, but it
will return NULL if there are multiple TPM devices.

You can see the same pattern being used at
find_vmgenid_dev()/vmgenid_realize() and
fw_cfg_find()/fw_cfg_common_realize().  The difference is that
find_vmgenid_dev() and fw_cfg_find() are explicitly documented
with a "returns NULL unless there is exactly one device" comment,
while tpm_find() is not.

--=20
Eduardo
