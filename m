Received: from eggs.gnu.org ([2001:4830:134:3::10]:38492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1d41N4-0003oM-9d
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 04:35:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1d41N1-00044i-58
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 04:35:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1d41N0-00044Y-VS
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 04:35:19 -0400
Date: Fri, 28 Apr 2017 14:05:01 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <20170424120634.12268-1-ppandit@redhat.com>
Message-ID: <alpine.LFD.2.20.1704281403310.29240@wniryva>
References: <20170424120634.12268-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH] scsi: avoid an off-by-one error in
 megasas_mmio_write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, YY Z <bigbird475958471@gmail.com>

+-- On Mon, 24 Apr 2017, P J P wrote --+
| While reading magic sequence(MFI_SEQ) in megasas_mmio_write,
| an off-by-one error could occur as 's->adp_reset' index is not
| reset after reading the last sequence.
| 
| --- a/hw/scsi/megasas.c
| +++ b/hw/scsi/megasas.c
| @@ -2138,15 +2138,15 @@ static void megasas_mmio_write(void *opaque, hwaddr addr,
|      case MFI_SEQ:
|          trace_megasas_mmio_writel("MFI_SEQ", val);
|          /* Magic sequence to start ADP reset */
| -        if (adp_reset_seq[s->adp_reset] == val) {
| -            s->adp_reset++;
| +        if (adp_reset_seq[s->adp_reset++] == val) {
| +            if (s->adp_reset == 6) {
| +                s->adp_reset = 0;
| +                s->diag = MFI_DIAG_WRITE_ENABLE;
| +            }
|          } else {
|              s->adp_reset = 0;
|              s->diag = 0;
|          }
| -        if (s->adp_reset == 6) {
| -            s->diag = MFI_DIAG_WRITE_ENABLE;
| -        }
|          break;

Ping...!
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
