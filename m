Received: from eggs.gnu.org ([2001:4830:134:3::10]:48369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1emNJn-0000Ru-L8
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:27:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1emNJk-000499-HX
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:27:35 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36140 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1emNJk-000493-Aw
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:27:32 -0500
Date: Thu, 15 Feb 2018 17:27:14 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180215172714.GD8367@stefanha-x1.localdomain>
References: <20180215111526.2464-1-stefanha@redhat.com>
	<ecc44671-4f09-5c52-57ea-4818b351795d@kamp.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AbQceqfdZEv+FvjW"
Content-Disposition: inline
In-Reply-To: <ecc44671-4f09-5c52-57ea-4818b351795d@kamp.de>
Subject: Re: [Qemu-devel] [PATCH] block/iscsi: cancel libiscsi task when
 ABORT TASK TMF completes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Felipe Franciosi <felipe@nutanix.com>


--AbQceqfdZEv+FvjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2018 at 03:24:54PM +0100, Peter Lieven wrote:
> Am 15.02.2018 um 12:15 schrieb Stefan Hajnoczi:
> > The libiscsi iscsi_task_mgmt_async() API documentation says:
> >=20
> >    abort_task will also cancel the scsi task. The callback for the scsi
> >    task will be invoked with SCSI_STATUS_CANCELLED
> >=20
> > The libiscsi implementation does not fulfil this promise.  The task's
> > callback is not invoked and its struct iscsi_pdu remains in the internal
> > list (effectively leaked).
>=20
> If that contract is fixed in libiscsi, will the Qemu iSCSI driver still w=
ork?

In

+    /* If the command callback hasn't been called yet, drop the task */
+    if (!acb->bh) {

and

+    if (status =3D=3D SCSI_STATUS_CANCELLED) {
+        if (!acb->bh) {

we're mindful of the fact that the callback may have been invoked by
libiscsi already.  There is no risk of double-completion.

Stefan

--AbQceqfdZEv+FvjW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJahcLyAAoJEJykq7OBq3PIWAkIAIQ3i2yItRuGj3bbXY1lN/PY
3mf7bft+CS87TOsTzDFQTTcxasp0+6HcnfotoCxJE9HN6++764B1zdapJYS06INz
Bht955ZZmvQox2HIeJ4PK1+g0xCtkRqxAx036BBcKQj/hnzoBJ6WmuINlPhxH4Yo
PrPtNCTEjp7BDYxeCbH90fSO5QImooJQZRuXFsI06g6Suyn8Og8XP0x4YWGXX3kk
l5z0YDRlsPHtx19py5jjXZaPiiIhj6oEqidkg0vRpIRNis1EDizQom5m4IuDL6ha
F0IH/2LVZnEQ/AJatLQRv0ycW7A2Hez+4kurgvOgmlde4Sz/AG/h95kcc3PugZg=
=lXKk
-----END PGP SIGNATURE-----

--AbQceqfdZEv+FvjW--
