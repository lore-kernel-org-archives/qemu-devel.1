Received: from eggs.gnu.org ([2001:4830:134:3::10]:48512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1cTm2O-0005j8-FU
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 03:56:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1cTm2L-00027J-Ce
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 03:56:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:48464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hare@suse.de>) id 1cTm2L-00026b-2l
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 03:56:09 -0500
References: <1484633936-25344-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<1484633936-25344-8-git-send-email-caoj.fnst@cn.fujitsu.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <6e360573-4e61-93aa-db16-3eddd1e87113@suse.de>
Date: Wed, 18 Jan 2017 09:56:04 +0100
MIME-Version: 1.0
In-Reply-To: <1484633936-25344-8-git-send-email-caoj.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v9 07/11] megasas: undo the overwrites of
 msi user configuration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cao jin <caoj.fnst@cn.fujitsu.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 01/17/2017 07:18 AM, Cao jin wrote:
> Commit afea4e14 seems forgetting to undo the overwrites, which is
> unsuitable.
>=20
> CC: Hannes Reinecke <hare@suse.de>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Markus Armbruster <armbru@redhat.com>
> CC: Marcel Apfelbaum <marcel@redhat.com>
> CC: Michael S. Tsirkin <mst@redhat.com>
>=20
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Acked-by: Marcel Apfelbaum <marcel@redhat.com>
> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> ---
>  hw/scsi/megasas.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
> index 14d6e0c6d565..c208d520c4df 100644
> --- a/hw/scsi/megasas.c
> +++ b/hw/scsi/megasas.c
> @@ -2350,11 +2350,10 @@ static void megasas_scsi_realize(PCIDevice *dev=
, Error **errp)
>                      "msi=3Doff with this machine type.\n");
>              error_propagate(errp, err);
>              return;
> -        } else if (ret) {
> -            /* With msi=3Dauto, we fall back to MSI off silently */
> -            s->msi =3D ON_OFF_AUTO_OFF;
> -            error_free(err);
>          }
> +        assert(!err || s->msix =3D=3D ON_OFF_AUTO_AUTO);
> +        /* With msi=3Dauto, we fall back to MSI off silently */
> +        error_free(err);
>      }
> =20
>      memory_region_init_io(&s->mmio_io, OBJECT(s), &megasas_mmio_ops, s=
,
>=20
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
--=20
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: F. Imend=F6rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N=FCrnberg)
