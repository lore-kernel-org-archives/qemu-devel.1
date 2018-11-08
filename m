Received: from eggs.gnu.org ([2001:4830:134:3::10]:45584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gKopP-0001j3-Re
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 13:14:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gKopL-0003RP-HL
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 13:14:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gKopL-0003Ek-3f
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 13:14:47 -0500
References: <1541628287-11627-1-git-send-email-george.kennedy@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <94be96e7-cee8-a8d6-6dc5-61535461f3f8@redhat.com>
Date: Thu, 8 Nov 2018 19:14:11 +0100
MIME-Version: 1.0
In-Reply-To: <1541628287-11627-1-git-send-email-george.kennedy@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6] lsi: Reselection needed to remove
 pending commands from queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: George Kennedy <george.kennedy@oracle.com>, famz@redhat.com, qemu-devel@nongnu.org, boris.ostrovsky@oracle.com

On 07/11/2018 23:04, George Kennedy wrote:
> Your latest suggestion was the "missing link". Calling lsi_wait_reselec=
t()
> after a WAIT DISCONNECT Script instruction when there are commands on=20
> the pending queue is all the is needed. The patch has been greatly
> reduced in size and complexity.

Yeah, it's mixing initiator and target in slightly unhealthy ways, but
it's not something that you introduced.

(Can you also send, perhaps offlist, the other patch you were working on
which tried to introduce the right sequence of disconnect/reselect
before disk accesses and DMA respectively?  I'd like to keep it for
reference).

>  hw/scsi/lsi53c895a.c | 43 ++++++++++++++++++++++++++++++++-----------
>  1 file changed, 32 insertions(+), 11 deletions(-)
>=20
> diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
> index d1e6534..7f9ed2f 100644
> --- a/hw/scsi/lsi53c895a.c
> +++ b/hw/scsi/lsi53c895a.c
> @@ -219,6 +219,7 @@ typedef struct {
>      int command_complete;
>      QTAILQ_HEAD(, lsi_request) queue;
>      lsi_request *current;
> +    bool handle_pending;    /* handle queued pending commands */
> =20
>      uint32_t dsa;
>      uint32_t temp;
> @@ -298,6 +299,18 @@ static inline int lsi_irq_on_rsl(LSIState *s)
>      return (s->sien0 & LSI_SIST0_RSL) && (s->scid & LSI_SCID_RRE);
>  }
> =20
> +static lsi_request *get_pending_req(LSIState *s)
> +{
> +    lsi_request *p;
> +
> +    QTAILQ_FOREACH(p, &s->queue, next) {
> +        if (p->pending) {
> +            return p;
> +        }
> +    }
> +    return NULL;
> +}
> +
>  static void lsi_soft_reset(LSIState *s)
>  {
>      trace_lsi_reset();
> @@ -446,7 +459,6 @@ static void lsi_update_irq(LSIState *s)
>  {
>      int level;
>      static int last_level;
> -    lsi_request *p;
> =20
>      /* It's unclear whether the DIP/SIP bits should be cleared when th=
e
>         Interrupt Status Registers are cleared or when istat0 is read.
> @@ -477,12 +489,12 @@ static void lsi_update_irq(LSIState *s)
>      lsi_set_irq(s, level);
> =20
>      if (!level && lsi_irq_on_rsl(s) && !(s->scntl1 & LSI_SCNTL1_CON)) =
{
> +        lsi_request *p;
> +
>          trace_lsi_update_irq_disconnected();
> -        QTAILQ_FOREACH(p, &s->queue, next) {
> -            if (p->pending) {
> -                lsi_reselect(s, p);
> -                break;
> -            }
> +        p =3D get_pending_req(s);
> +        if (p) {
> +            lsi_reselect(s, p);
>          }
>      }
>  }
> @@ -759,6 +771,8 @@ static void lsi_command_complete(SCSIRequest *req, =
uint32_t status, size_t resid
>          lsi_request_free(s, s->current);
>          scsi_req_unref(req);
>      }
> +    s->handle_pending =3D get_pending_req(s) ? true : false;
> +
>      lsi_resume_script(s);
>  }
> =20
> @@ -1064,11 +1078,15 @@ static void lsi_wait_reselect(LSIState *s)
> =20
>      trace_lsi_wait_reselect();
> =20
> -    QTAILQ_FOREACH(p, &s->queue, next) {
> -        if (p->pending) {
> -            lsi_reselect(s, p);
> -            break;
> -        }
> +    s->handle_pending =3D false;
> +
> +    if (s->current) {
> +        return;
> +    }
> +
> +    p =3D get_pending_req(s);
> +    if (p) {
> +        lsi_reselect(s, p);
>      }
>      if (s->current =3D=3D NULL) {
>          s->waiting =3D 1;
> @@ -1258,6 +1276,9 @@ again:
>              case 1: /* Disconnect */
>                  trace_lsi_execute_script_io_disconnect();
>                  s->scntl1 &=3D ~LSI_SCNTL1_CON;
> +                if (s->handle_pending) {

Can you explain the if?  Is it to avoid that "s->waiting =3D 1" assignmen=
t?

Also, could the disconnect case check get_pending_req directly, and call
lsi_reselect?  That is, replacing this "if" with

	if (!s->current) {
	    p =3D get_pending_req(s);
	    if (p) {
	        lsi_reselect(s, p);
	    }
	}

instead of calling lsi_wait_reselect?

Thanks,

Paolo

> +                    lsi_wait_reselect(s);
> +                }
>                  break;
>              case 2: /* Wait Reselect */
>                  if (!lsi_irq_on_rsl(s)) {
>=20
