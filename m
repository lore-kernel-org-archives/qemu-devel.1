Received: from eggs.gnu.org ([2001:4830:134:3::10]:41733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gSJ5R-0000Tg-Vd
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 04:58:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gSJ5O-0000aC-RQ
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 04:58:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38880)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gSJ5O-0000Zr-Jx
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 04:58:18 -0500
References: <1543442171-24863-1-git-send-email-linux@roeck-us.net>
	<1543442171-24863-2-git-send-email-linux@roeck-us.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3d1287e7-29c1-dbb1-c0f9-273b7b31645c@redhat.com>
Date: Thu, 29 Nov 2018 10:58:12 +0100
MIME-Version: 1.0
In-Reply-To: <1543442171-24863-2-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] scsi: esp: Improve consistency of
 RSTAT, RSEQ, and RINTR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

On 28/11/18 22:56, Guenter Roeck wrote:
> The guest OS reads RSTAT, RSEQ, and RINTR, and expects those registers
> to reflect a consistent state. However, it is possible that the registe=
rs
> can change after RSTAT was read, but before RINTR is read.
>=20
> Guest OS		qemu
> --------		----
> Read RSTAT
> 			esp_command_complete()
> 			 RSTAT =3D STAT_ST
> 			 esp_dma_done()
> 			  RSTAT |=3D STAT_TC
> 			  RSEQ =3D 0
> 			  RINTR =3D INTR_BS
>=20
> Read RSEQ
> Read RINTR		RINTR =3D 0
> 			RSTAT &=3D ~STAT_TC
> 			RSEQ =3D SEQ_CD
>=20
> The guest OS would then try to handle INTR_BS combined with an old
> value of RSTAT. This sometimes resulted in lost events, spurious
> interrupts, guest OS confusion, and stalled SCSI operations.

The question is, why was the guest running the interrupt routine before
STAT_INT was set in RSTAT?  The code in esp_raise_irq seems good:

    if (!(s->rregs[ESP_RSTAT] & STAT_INT)) {
        s->rregs[ESP_RSTAT] |=3D STAT_INT;
        qemu_irq_raise(s->irq);
        trace_esp_raise_irq();
    }

Paolo

> A typical guest error log (observed with various versions of Linux)
> looks as follows.
>=20
> scsi host1: Spurious irq, sreg=3D13.
> ...
> scsi host1: Aborting command [84531f10:2a]
> scsi host1: Current command [f882eea8:35]
> scsi host1: Queued command [84531f10:2a]
> scsi host1:  Active command [f882eea8:35]
> scsi host1: Dumping command log
> scsi host1: ent[15] CMD val[44] sreg[90] seqreg[00] sreg2[00] ireg[20] =
ss[00] event[0c]
> scsi host1: ent[16] CMD val[01] sreg[90] seqreg[00] sreg2[00] ireg[20] =
ss[02] event[0c]
> scsi host1: ent[17] CMD val[43] sreg[90] seqreg[00] sreg2[00] ireg[20] =
ss[02] event[0c]
> scsi host1: ent[18] EVENT val[0d] sreg[92] seqreg[04] sreg2[00] ireg[18=
] ss[00] event[0c]
> ...
