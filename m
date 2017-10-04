Received: from eggs.gnu.org ([2001:4830:134:3::10]:38063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dzlqh-0004Pk-CC
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 11:44:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dzlqc-0006Ha-PK
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 11:44:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dzlqc-0006GG-Et
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 11:44:34 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 97E5F820F9
	for <qemu-devel@nongnu.org>; Wed,  4 Oct 2017 15:44:32 +0000 (UTC)
References: <20171004114008.14849-1-berrange@redhat.com>
	<20171004114008.14849-2-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <88a37718-54ab-82d1-a215-0ab87047131e@redhat.com>
Date: Wed, 4 Oct 2017 10:44:27 -0500
MIME-Version: 1.0
In-Reply-To: <20171004114008.14849-2-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5k91sfGL9wkoPcxlHkniHRTBaNb6NHCNn"
Subject: Re: [Qemu-devel] [PATCH v1 1/2] scsi-disk: support reporting of
 rotation rate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5k91sfGL9wkoPcxlHkniHRTBaNb6NHCNn
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Message-ID: <88a37718-54ab-82d1-a215-0ab87047131e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 1/2] scsi-disk: support reporting of
 rotation rate
References: <20171004114008.14849-1-berrange@redhat.com>
 <20171004114008.14849-2-berrange@redhat.com>
In-Reply-To: <20171004114008.14849-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/04/2017 06:40 AM, Daniel P. Berrange wrote:
> The Linux kernel will query the SCSI "Block device characteristics"
> VPD to determine the rotations per minute of the disk. If this has
> the value 1, it is taken to be an SSD and so Linux sets the
> 'rotational' flag to 0 for the I/O queue and will stop using that
> disk as a source of random entropy. Other operating systems may
> also take into account rotation rate when setting up default
> behaviour.
>=20
> Mgmt apps should be able to set the rotation rate for virtualized
> block devices, based on characteristics of the host storage in use,
> so that the guest OS gets sensible behaviour out of the box. This
> patch thus adds a 'rotation-rate' parameter for 'scsi-hd' and
> 'scsi-block' device types. For the latter, this parameter will be
> ignored unless the host device has TYPE_DISK.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  hw/scsi/scsi-disk.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

>      bool tray_locked;
> +    /*
> +     * 0x0000        - rotation rate not reported
> +     * 0x0001        - non-rotating medium (SSD)
> +     * 0x0002-0x0400 - reserved
> +     * 0x0401-0xffe  - rotations per minute

s/0xffe/0xfffe/

> +     * 0xffff        - reserved
> +     */
> +    uint16_t rotation_rate;
>  } SCSIDiskState;
> =20
>  static bool scsi_handle_rw_error(SCSIDiskReq *r, int error, bool acct_=
failed);
> @@ -605,6 +613,7 @@ static int scsi_disk_emulate_inquiry(SCSIRequest *r=
eq, uint8_t *outbuf)
>              outbuf[buflen++] =3D 0x83; // device identification
>              if (s->qdev.type =3D=3D TYPE_DISK) {
>                  outbuf[buflen++] =3D 0xb0; // block limits
> +                outbuf[buflen++] =3D 0xb1; /* block device characteris=
tics */

This function is awkward - it is a non-local audit to see whether we are
 at risk of overflowing any buffers due to the new output.  But from
what I can see, I think you're safe.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--5k91sfGL9wkoPcxlHkniHRTBaNb6NHCNn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnVAdsACgkQp6FrSiUn
Q2piLgf/fuwUFVVa9uHMxn3rJNeDmow1ZeGXc6CvoUttKDfe04zqO29ATjnZLae+
aSL/okX3ebbxYC0XfasqDQ59hmifGNeBx0Vlulkxbn6O5rYYeWO3xx1EPP3hOrR8
tfmS4rbMl2cFDpSIqp4HBV8b7bPx+oUp/NwgZ/g8Db+r+n1Gh4oPqblWaUHYqQZk
I4eUj7Em5ao5ztCfFTzHD1NLmPBpWoDcyg0tsnxbrjQGYmLgvXoYLqaCb2zqwwFY
mCHwnef+R7ICaO6H0v2927Gl4bkbgV7LA6TurZKcqOpOA034MeaEdVP+qSF3kVL0
MrVvs0Qxwv2MBNmz7ob0+EhmkN8Ozg==
=59GL
-----END PGP SIGNATURE-----

--5k91sfGL9wkoPcxlHkniHRTBaNb6NHCNn--
