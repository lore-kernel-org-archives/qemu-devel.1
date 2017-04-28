Received: from eggs.gnu.org ([2001:4830:134:3::10]:35965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d42bl-0001iV-Ec
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 05:54:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d42bg-0006KM-JE
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 05:54:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36482)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d42bg-0006Fr-Cb
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 05:54:32 -0400
References: <20170424120634.12268-1-ppandit@redhat.com>
	<alpine.LFD.2.20.1704281403310.29240@wniryva>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5e640542-7e44-dac9-85af-e11f893dbd75@redhat.com>
Date: Fri, 28 Apr 2017 11:54:25 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.20.1704281403310.29240@wniryva>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
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
To: P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>
Cc: YY Z <bigbird475958471@gmail.com>



On 28/04/2017 10:35, P J P wrote:
> +-- On Mon, 24 Apr 2017, P J P wrote --+
> | While reading magic sequence(MFI_SEQ) in megasas_mmio_write,
> | an off-by-one error could occur as 's->adp_reset' index is not
> | reset after reading the last sequence.
> | 
> | --- a/hw/scsi/megasas.c
> | +++ b/hw/scsi/megasas.c
> | @@ -2138,15 +2138,15 @@ static void megasas_mmio_write(void *opaque, hwaddr addr,
> |      case MFI_SEQ:
> |          trace_megasas_mmio_writel("MFI_SEQ", val);
> |          /* Magic sequence to start ADP reset */
> | -        if (adp_reset_seq[s->adp_reset] == val) {
> | -            s->adp_reset++;
> | +        if (adp_reset_seq[s->adp_reset++] == val) {
> | +            if (s->adp_reset == 6) {
> | +                s->adp_reset = 0;
> | +                s->diag = MFI_DIAG_WRITE_ENABLE;
> | +            }
> |          } else {
> |              s->adp_reset = 0;
> |              s->diag = 0;
> |          }
> | -        if (s->adp_reset == 6) {
> | -            s->diag = MFI_DIAG_WRITE_ENABLE;
> | -        }
> |          break;
> 
> Ping...!
> --
> Prasad J Pandit / Red Hat Product Security Team
> 47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
> 

I've already queued this patch.

Paolo
