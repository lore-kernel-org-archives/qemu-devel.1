Received: from eggs.gnu.org ([2001:4830:134:3::10]:33135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cta4z-0001i7-4J
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:25:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cta4v-0001F7-37
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:25:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cta4u-0001Ee-Qv
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:25:29 -0400
References: <1490876834-61392-1-git-send-email-liqiang6-s@360.cn>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c65ce78e-9a33-ee17-0a49-2a28390060f0@redhat.com>
Date: Thu, 30 Mar 2017 08:25:25 -0500
MIME-Version: 1.0
In-Reply-To: <1490876834-61392-1-git-send-email-liqiang6-s@360.cn>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0tcpXiuvMJVkFh1MIuS2Q1GiQixVUU8nh"
Subject: Re: [Qemu-devel] [PATCH for-2.9?] 9pfs: fix migration_block leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, groug@kaod.org
Cc: Li Qiang <liqiang6-s@360.cn>, qemu-devel@nongnu.org, ppandit@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0tcpXiuvMJVkFh1MIuS2Q1GiQixVUU8nh
From: Eric Blake <eblake@redhat.com>
To: Li Qiang <liq3ea@gmail.com>, groug@kaod.org
Cc: Li Qiang <liqiang6-s@360.cn>, qemu-devel@nongnu.org, ppandit@redhat.com
Message-ID: <c65ce78e-9a33-ee17-0a49-2a28390060f0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9?] 9pfs: fix migration_block leak
References: <1490876834-61392-1-git-send-email-liqiang6-s@360.cn>
In-Reply-To: <1490876834-61392-1-git-send-email-liqiang6-s@360.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/30/2017 07:27 AM, Li Qiang wrote:
> The guest can leave the pdu->s->migration_blocker exists by attach

s/exists/in place/
s/attach/attaching/

> but not remove a fid. Then if we hot unplug the 9pfs device, the

s/remove/removing/

> v9fs_reset() just free the fids, but not free the migration_blocker.
> This will leak a memory leak. This patch avoid this.

s/leak a/cause a/
s/avoid/avoids/

>=20
> Signed-off-by: Li Qiang <liqiang6-s@360.cn>
> ---
>  hw/9pfs/9p.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Probably worth including in 2.9 as a bug fix.

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 48babce..b55c02d 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -548,6 +548,12 @@ static void coroutine_fn virtfs_reset(V9fsPDU *pdu=
)
>              free_fid(pdu, fidp);
>          }
>      }
> +
> +    if (pdu->s->migration_blocker) {
> +        migrate_del_blocker(pdu->s->migration_blocker);
> +        error_free(pdu->s->migration_blocker);
> +        pdu->s->migration_blocker =3D NULL;
> +    }
>  }
> =20
>  #define P9_QID_TYPE_DIR         0x80
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--0tcpXiuvMJVkFh1MIuS2Q1GiQixVUU8nh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY3QdFAAoJEKeha0olJ0NqvqAH/AqNSZgUwJf3ews71CQRY6ca
9vXVH71TkKep8Tfa2onVj2UQrh++Vtze+42DFlvGk+iJTWFlHc0QDObeQ/LQQuXD
uqHrIxK3rb/oprDvdlcvALaAfQrvJI/pcGJczYKDUri5J9QFhtDpjbpssnzj5aET
w4nTcsNBjbRR/iODDdvavhEZuqxFHvnCeAC6ZFNsLNrLnoYtx23ULVoVr4Dmew0b
qrEtv5WjhYA/O4O0c5qGz8OqGgrKdw9+VczWlcAUAfvZZDgJquSNuggwQMzEykDs
6tIzlsWguhz7EhiovePmbn95oPNrmBgGNJ1GfC/e8IOu0zsK5XZxfjiEN8Khiyg=
=3lk1
-----END PGP SIGNATURE-----

--0tcpXiuvMJVkFh1MIuS2Q1GiQixVUU8nh--
