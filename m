Received: from eggs.gnu.org ([2001:4830:134:3::10]:56779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gFotZ-0001oc-Jx
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 19:18:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gFotX-0006cy-12
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 19:18:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:19234)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gFotW-0006bo-0N
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 19:18:26 -0400
References: <20181025200944.12113-1-ppandit@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9677a72a-612b-fe4d-cd19-bb5f2e803c58@redhat.com>
Date: Fri, 26 Oct 2018 01:18:15 +0200
MIME-Version: 1.0
In-Reply-To: <20181025200944.12113-1-ppandit@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] lsi53c895a: check message length value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>
Cc: Ameya More <ameya.more@oracle.com>, Fam Zheng <famz@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>

On 25/10/2018 22:09, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>=20
> While writing a message in 'lsi_do_msgin', message length value
> in msg_len could be invalid, add check to avoid OOB access issue.
>=20
> Reported-by: Ameya More <ameya.more@oracle.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/scsi/lsi53c895a.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
> index d1e6534311..a266c5a113 100644
> --- a/hw/scsi/lsi53c895a.c
> +++ b/hw/scsi/lsi53c895a.c
> @@ -205,7 +205,7 @@ typedef struct {
>      /* Action to take at the end of a MSG IN phase.
>         0 =3D COMMAND, 1 =3D disconnect, 2 =3D DATA OUT, 3 =3D DATA IN.=
  */
>      int msg_action;
> -    int msg_len;
> +    uint8_t msg_len;

Not wrong per se, but it's also not clear why it's needed.  I understand
that you want to switch from signed to unsigned, but it is not mentioned
in the commit message.

The switch to 8-bit, and below from VMSTATE_INT32 to VMSTATE_UINT8, is
wrong because it changes the format of the live migration stream.

>      uint8_t msg[LSI_MAX_MSGIN_LEN];
>      /* 0 if SCRIPTS are running or stopped.
>       * 1 if a Wait Reselect instruction has been issued.
> @@ -861,12 +861,15 @@ static void lsi_do_status(LSIState *s)
> =20
>  static void lsi_do_msgin(LSIState *s)
>  {
> -    int len;
> +    uint8_t len;
>      trace_lsi_do_msgin(s->dbc, s->msg_len);
>      s->sfbr =3D s->msg[0];
>      len =3D s->msg_len;
>      if (len > s->dbc)
>          len =3D s->dbc;
> +    if (len > LSI_MAX_MSGIN_LEN) {
> +        len =3D LSI_MAX_MSGIN_LEN;
> +    }

I'm not sure it's appropriate to check for out of bounds reads here,
because if s->msg_len is greater than LSI_MAX_MSGIN_LEN, then this test
doesn't exclude you've already had an out of bounds write before.
Indeed the msg_len is checked in lsi_add_msg_byte in order to avoid out
of bounds accesses in either lsi_add_msg_byte or lsi_do_msgin.  You
could assert here that the variable is in range, I guess.

However, the out of bounds s->msg_len can actually happen in one other
case: namely, if a malicious live migration stream includes a bogus
s->msg_len.  Such live migration stream should be rejected; the fix for
that is to add a lsi_post_load function, point to it in
vmstate_lsi_scsi, and check there for s->msg_len <=3D LSI_MAX_MSGIN_LEN.

Thanks,

Paolo

>      pci_dma_write(PCI_DEVICE(s), s->dnad, s->msg, len);
>      /* Linux drivers rely on the last byte being in the SIDL.  */
>      s->sidl =3D s->msg[len - 1];
> @@ -2114,7 +2117,7 @@ static const VMStateDescription vmstate_lsi_scsi =
=3D {
>          VMSTATE_INT32(carry, LSIState),
>          VMSTATE_INT32(status, LSIState),
>          VMSTATE_INT32(msg_action, LSIState),
> -        VMSTATE_INT32(msg_len, LSIState),
> +        VMSTATE_UINT8(msg_len, LSIState),
>          VMSTATE_BUFFER(msg, LSIState),
>          VMSTATE_INT32(waiting, LSIState),
> =20
>=20
