Received: from eggs.gnu.org ([2001:4830:134:3::10]:48984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1cngHD-0001zE-AB
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 02:49:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1cngHC-0004h6-DQ
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 02:49:47 -0400
References: <20170313195547.21466-1-eblake@redhat.com>
	<20170313195547.21466-3-eblake@redhat.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <b2c75809-d339-4821-d28b-27504ff640b7@suse.de>
Date: Tue, 14 Mar 2017 07:49:38 +0100
MIME-Version: 1.0
In-Reply-To: <20170313195547.21466-3-eblake@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 02/30] trace: Fix incorrect megasas
 trace parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, "open list:megasas" <qemu-block@nongnu.org>

On 03/13/2017 08:55 PM, Eric Blake wrote:
> hw/scsi/trace-events lists cmd as the first parameter for both
> megasas_iovec_overflow and megasas_iovec_underflow, but the caller
> was mistakenly passing cmd->iov_size twice instead of the command
> index.  Also, trace_megasas_abort_invalid is called with parameters
> in the wrong order.  Broken since its introduction in commit
> e8f943c3.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  hw/scsi/megasas.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
> index e3d59b7..84b8caf 100644
> --- a/hw/scsi/megasas.c
> +++ b/hw/scsi/megasas.c
> @@ -291,7 +291,7 @@ static int megasas_map_sgl(MegasasState *s, Megasas=
Cmd *cmd, union mfi_sgl *sgl)
>      if (cmd->iov_size > iov_size) {
>          trace_megasas_iovec_overflow(cmd->index, iov_size, cmd->iov_si=
ze);
>      } else if (cmd->iov_size < iov_size) {
> -        trace_megasas_iovec_underflow(cmd->iov_size, iov_size, cmd->io=
v_size);
> +        trace_megasas_iovec_underflow(cmd->index, iov_size, cmd->iov_s=
ize);
>      }
>      cmd->iov_offset =3D 0;
>      return 0;
> @@ -1924,8 +1924,8 @@ static int megasas_handle_abort(MegasasState *s, =
MegasasCmd *cmd)
>          abort_ctx &=3D (uint64_t)0xFFFFFFFF;
>      }
>      if (abort_cmd->context !=3D abort_ctx) {
> -        trace_megasas_abort_invalid_context(cmd->index, abort_cmd->ind=
ex,
> -                                            abort_cmd->context);
> +        trace_megasas_abort_invalid_context(cmd->index, abort_cmd->con=
text,
> +                                            abort_cmd->index);
>          s->event_count++;
>          return MFI_STAT_ABORT_NOT_POSSIBLE;
>      }
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
