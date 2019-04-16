Received: from eggs.gnu.org ([209.51.188.92]:41963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hGJzh-0006kR-SZ
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 05:03:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hGJzg-0007bE-F7
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 05:03:09 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54132)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hGJzg-0007Zx-4e
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 05:03:08 -0400
Received: by mail-wm1-x343.google.com with SMTP id q16so24289029wmj.3
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 02:03:07 -0700 (PDT)
Date: Tue, 16 Apr 2019 10:03:04 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190416090304.GA32709@stefanha-x1.localdomain>
References: <20190321075545.14929-1-nir.weiner@oracle.com>
	<20190409142925.GG16944@stefanha-x1.localdomain>
	<AC01E2C2-1944-42C5-A944-220EE6F8A489@oracle.com>
	<20190415093725.GB29134@stefanha-x1.localdomain>
	<1A34D426-BE46-47A4-98C9-FF812567B67E@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <1A34D426-BE46-47A4-98C9-FF812567B67E@oracle.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] vhost-scsi: Support live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liran Alon <liran.alon@oracle.com>
Cc: Nir Weiner <nir.weiner@oracle.com>, qemu-devel@nongnu.org, bijan.mottahedeh@oracle.com


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2019 at 01:01:13PM +0300, Liran Alon wrote:
>=20
>=20
> > On 15 Apr 2019, at 12:37, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> >=20
> > On Thu, Apr 11, 2019 at 01:45:06AM +0300, Liran Alon wrote:
> >>=20
> >>=20
> >>> On 9 Apr 2019, at 17:29, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> >>>=20
> >>> On Thu, Mar 21, 2019 at 09:55:42AM +0200, Nir Weiner wrote:
> >>>> Originally migration was not possible with vhost-scsi because
> >>>> as part of migration, the source host target SCSI device state
> >>>> needs to be saved and loaded into the destination host target SCSI
> >>>> device. This cannot be done by QEMU.
> >>>>=20
> >>>> As this can be handled either by external orchestrator or by having
> >>>> shared-storage (i.e. iSCSI), there is no reason to limit the
> >>>> orchestrator from being able to explictly specify it wish to enable
> >>>> migration even when VM have a vhost-scsi device.
> >>>>=20
> >>>> Liran Alon (1):
> >>>> vhost-scsi: Allow user to enable migration
> >>>>=20
> >>>> Nir Weiner (2):
> >>>> vhost-scsi: The vhost device should be stopped when the VM is not
> >>>>   running
> >>>> vhost-scsi: Add vmstate descriptor
> >>>>=20
> >>>> hw/scsi/vhost-scsi.c                  | 57 ++++++++++++++++++++++---=
--
> >>>> include/hw/virtio/vhost-scsi-common.h |  1 +
> >>>> 2 files changed, 48 insertions(+), 10 deletions(-)
> >>>=20
> >>> What happens when migration is attempted while there is in-flight I/O=
 in
> >>> the vring?
> >>>=20
> >>> Stefan
> >>=20
> >> What do you define as =E2=80=9Cin-flight I/O=E2=80=9D? I think there i=
s a need to separate the discussion here to multiple cases:
> >>=20
> >> 1) The I/O request was written to vring but guest have not yet written=
 to doorbell:
> >> This is the simplest case. No state is lost as the vring is migrated f=
rom source host to dest host as part of guest memory migration.
> >> Also, the vring properties (E.g. Guest base address) is transferred fr=
om source host to dest host as part of vhost-scsi VMState.
> >> (See patch 2/3 of series which adds VMSTATE_VIRTIO_DEVICE to vhost-scs=
i VMState which will cause virtio_save() to save vring on migration stream).
> >>=20
> >> 2) The I/O request was written to vring and the guest have written to =
doorbell:
> >> The I/O request was submitted and processed by the vhost-scsi backend.=
 Therefore, the I/O request was sent to the remote TGT server.
> >> If the the TGT server has performed the write and returned ACK but the=
 ACK was not received by guest, then guest is expected to initiate the writ=
e again.
> >> (Similar to what happens for a momentary TGT server downtime / network=
 downtime). So this isn=E2=80=99t suppose to be an issue.
> >=20
> > This scenario doesn't fit into the virtio-scsi model since each
> > virtio-scsi request requires a response.  Otherwise there is a vring
> > descriptor leak.
> >=20
> > If the migration scheme can leak vring descriptors then it is incorrect.
> > Especially repeated migrations could cause the vring to become totally
> > filled with leaked descriptors.
> >=20
> > I think the case you've described cannot happen based on the
> > drivers/vhost/scsi.c code.  It seems that clearing the endpoint flushes
> > and waits for inflight requests to complete.  The
> > VHOST_SCSI_CLEAR_ENDPOINT ioctl blocks until the remote target has
> > returned an ACK for all in-flight requests.
>=20
> Hmm interesting. I missed this part and it seems that you are right.
> (vhost_scsi_ioctl() -> vhost_scsi_clear_endpoint() -> vhost_scsi_flush()
> which is called by QEMU=E2=80=99s vhost_scsi_set_status() -> vhost_scsi_s=
top() -> vhost_scsi_clear_endpoint() -> vhost_ops->vhost_scsi_clear_endpoin=
t()).
>=20
> >=20
> > This patch series needs a clear explanation of how the running
> > vhost_scsi.ko instance is quiesced such that:
> >=20
> > 1. Requests in-flight to the remote target are completed before
> >   migration handover.  (Fancier approaches to live migration are
> >   possible but this patch series doesn't seem to implement them, so we
> >   need at least this basic guarantee for correctness.)
>=20
> From what I understand, this is guaranteed by the code-path mentioned abo=
ve.=20
>=20
> > 2. No further I/O requests are submitted to the remote target after the
> >   vm stops running.
>=20
> This is true because the VM at this point is stopped and the vhost-backen=
d was also stopped.
> See QEMU=E2=80=99s vhost_scsi_set_status() -> vhost_scsi_stop() -> vhost_=
scsi_common_stop() -> vhost_dev_stop().
>=20
> > 3. No further guest memory access takes place after the vm stops runnin=
g.
>=20
> As the vhost-backend is stopped at this point, there cannot be further gu=
est memory accesses.
>=20
> >=20
> > These properties are critical for correct vhost live migration and I'm
> > not confident yet based on this patch series.  Please review the code
> > (including kernel vhost code) and include an explanation in code
> > comments (if possible) or commit descriptions.
>=20
> I agree and we can submit a v2 patch series with better comments describi=
ng the above.
> But do you think there is something missing from the above description? I=
 think it should cover all your points.

Thanks for confirming.  This covers it and will be useful as code
comments so that anyone reading or modifying the code understands the
migration safety properties.

The only other issue I can think of is that some SCSI features might not
work across migration, like persistent reservations.  This is a
limitation but not a blocker in my opinion.

Looking forward to v2!

Stefan

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJctZpHAAoJEJykq7OBq3PIfrgH/j6pMSsCQmJPXS2KDe642n7K
xMx4drTnkYDWL/X+NV42G4bv1vaEpMbWxVynihK+Db6oxxuCUVJLaVcIcautZuTm
D76KqZRPWqwzR02Q+kUhD+UPB0rb9lgVgSqD15DcbDc4fptR9gTnWaHlG8OqBz89
un4kT1lbuebgNB0d4ZKXvusvAeRr1r90WiOWp/PwqIK6Dl9oVUe4WR5oxjONJ8sb
FjLZkWTdP2P+ABzJZnSL+sQVxkAQF521WzXoABESsVkjeBl77OTGzELvdLIlsxfK
FYb3WD/UTX6Kmv/YW5YI3PvC6e7TIdgGSqq5XMJxPdZpsc1vqxZHlOnBm+ZvntQ=
=ov5n
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
