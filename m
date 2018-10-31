Received: from eggs.gnu.org ([2001:4830:134:3::10]:49368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gHmhW-0008Ii-8v
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 05:22:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gHmhS-0003jJ-9G
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 05:22:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:7576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gHmhQ-0003i8-FE
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 05:22:05 -0400
References: <1540935767-21467-1-git-send-email-george.kennedy@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <580389b2-4462-ca99-6f80-752c49f603b6@redhat.com>
Date: Wed, 31 Oct 2018 10:21:55 +0100
MIME-Version: 1.0
In-Reply-To: <1540935767-21467-1-git-send-email-george.kennedy@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] lsi_scsi: Reselection needed to remove
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

On 30/10/2018 22:42, George Kennedy wrote:
> Under heavy IO (e.g. fio) the queue is not checked frequently enough fo=
r
> pending commands. As a result some pending commands are timed out by th=
e
> linux sym53c8xx driver, which sends SCSI Abort messages for the timed o=
ut
> commands. The SCSI Abort messages result in linux errors, which show up
> on the console and in /var/log/messages.
>=20
> e.g.
> sd 0:0:3:0: [sdd] tag#33 ABORT operation started
> scsi target0:0:3: control msgout:
> 80 20 47 d
> sd 0:0:3:0: ABORT operation complete.
> scsi target0:0:4: message d sent on bad reselection
>=20
> When the current command completes, check if there is a pending command
> on the queue and if a pending command exists, set a flag indicating
> that a Wait Reselect command is needed to handle a queued pending comma=
nd.
>=20
> When a Wait Reselect is needed, intercept and save the current DMA Scri=
pts
> Ptr (DSP) contents and load it instead with the pointer to the Reselect=
ion
> Scripts.  When Reselection has completed, restore the original DSP cont=
ents.
>=20
> Signed-off-by: George Kennedy <george.kennedy@oracle.com>
> ---
>  hw/scsi/lsi53c895a.c | 51 ++++++++++++++++++++++++++++++++++++++++----=
-------
>  1 file changed, 40 insertions(+), 11 deletions(-)
>=20
> diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
> index d1e6534..b783d72 100644
> --- a/hw/scsi/lsi53c895a.c
> +++ b/hw/scsi/lsi53c895a.c
> @@ -219,6 +219,8 @@ typedef struct {
>      int command_complete;
>      QTAILQ_HEAD(, lsi_request) queue;
>      lsi_request *current;
> +    bool want_resel;    /* need resel to handle queued completed cmds =
*/
> +    uint32_t resel_dsp; /* DMA Scripts Ptr (DSP) of reselection scsi s=
cripts */
> =20
>      uint32_t dsa;
>      uint32_t temp;
> @@ -298,6 +300,18 @@ static inline int lsi_irq_on_rsl(LSIState *s)
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
> @@ -446,7 +460,6 @@ static void lsi_update_irq(LSIState *s)
>  {
>      int level;
>      static int last_level;
> -    lsi_request *p;
> =20
>      /* It's unclear whether the DIP/SIP bits should be cleared when th=
e
>         Interrupt Status Registers are cleared or when istat0 is read.
> @@ -477,12 +490,12 @@ static void lsi_update_irq(LSIState *s)
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
> @@ -759,6 +772,8 @@ static void lsi_command_complete(SCSIRequest *req, =
uint32_t status, size_t resid
>          lsi_request_free(s, s->current);
>          scsi_req_unref(req);
>      }
> +    s->want_resel =3D get_pending_req(s) ? true : false;
> +
>      lsi_resume_script(s);
>  }
> =20
> @@ -1064,11 +1079,13 @@ static void lsi_wait_reselect(LSIState *s)
> =20
>      trace_lsi_wait_reselect();
> =20
> -    QTAILQ_FOREACH(p, &s->queue, next) {
> -        if (p->pending) {
> -            lsi_reselect(s, p);
> -            break;
> -        }
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
> @@ -1082,6 +1099,7 @@ static void lsi_execute_script(LSIState *s)
>      uint32_t addr, addr_high;
>      int opcode;
>      int insn_processed =3D 0;
> +    uint32_t save_dsp =3D 0;
> =20
>      s->istat1 |=3D LSI_ISTAT1_SRUN;
>  again:
> @@ -1260,7 +1278,14 @@ again:
>                  s->scntl1 &=3D ~LSI_SCNTL1_CON;
>                  break;
>              case 2: /* Wait Reselect */
> +                if (!s->resel_dsp) {
> +                    s->resel_dsp =3D s->dsp - 8;
> +                }

What is the reason for the "if"?

>                  if (!lsi_irq_on_rsl(s)) {
> +                    if (save_dsp) {
> +                        s->dsp =3D save_dsp;
> +                        save_dsp =3D 0;
> +                    }
>                      lsi_wait_reselect(s);
>                  }
>                  break;
> @@ -1476,6 +1501,10 @@ again:
> =20
>              if (insn & (1 << 28)) {
>                  addr =3D s->dsa + sextract32(addr, 0, 24);
> +            } else if (s->want_resel && s->resel_dsp && !(insn & (1 <<=
 24))) {
> +                save_dsp =3D s->dsp;
> +                s->dsp =3D s->resel_dsp;
> +                s->want_resel =3D false;
>              }

Can you explain why this is placed under the LOAD AND STORE instruction?

Your previous patch has, more specifically, a store from the scratch
register into memory.  In the Linux scripts this occurs twice, both
after a DISCONNECT instruction.  Is that the place where you want to hook=
?

(All this is a bit of a hack of course, and I would rather have the
actual solution that adds the appropriate RESELECTION and MESSAGE IN
phases whenever the device has finished the data transfer.  But with a
FIXME comment I guess it might be okay).

Paolo
