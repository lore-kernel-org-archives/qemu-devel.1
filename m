Received: from eggs.gnu.org ([2001:4830:134:3::10]:41408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fpSn9-0006B0-GH
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 02:26:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fpSn8-000743-N2
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 02:26:55 -0400
References: <20180809114417.28718-1-marcandre.lureau@redhat.com>
	<20180809114417.28718-5-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1023b737-30e5-1193-92bf-870a5d5c4728@redhat.com>
Date: Tue, 14 Aug 2018 08:26:41 +0200
MIME-Version: 1.0
In-Reply-To: <20180809114417.28718-5-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/4] RFC: fix megasas leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Hannes Reinecke <hare@suse.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 09/08/2018 13:44, Marc-Andr=C3=A9 Lureau wrote:
>=20
> I suppose megasas_complete_command() should take care of destroying
> the sglist instead, so I leave that patch as RFC for now.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

megasas_complete_command() is already doing it, and it calls
megasas_unmap_frame, so it is okay to remove the qemu_sglist_destroy
from there and move it to megasas_unmap_frame.  Thanks!

Paolo

> ---
>  hw/scsi/megasas.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
> index ba1afa3c1e..2a16397b3b 100644
> --- a/hw/scsi/megasas.c
> +++ b/hw/scsi/megasas.c
> @@ -465,6 +465,7 @@ static void megasas_unmap_frame(MegasasState *s, Me=
gasasCmd *cmd)
>      cmd->pa =3D 0;
>      cmd->pa_size =3D 0;
>      clear_bit(cmd->index, s->frame_map);
> +    qemu_sglist_destroy(&cmd->qsg);
>  }
> =20
>  /*
> -- 2.18.0.547.g1d89318c48
