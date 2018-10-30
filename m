Received: from eggs.gnu.org ([2001:4830:134:3::10]:36748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gHNdT-0007GG-Ng
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 02:36:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gHNdQ-0003Nv-EN
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 02:36:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gHNdQ-0003Kp-6P
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 02:36:16 -0400
Date: Tue, 30 Oct 2018 12:06:05 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <2dd73225-1e25-423e-5284-8f6fc60d47e3@redhat.com>
Message-ID: <nycvar.YSQ.7.76.1810301204510.30516@xnncv>
References: <20181026194314.18663-1-ppandit@redhat.com>
	<CAFEAcA8auV_NMER=nfrMnHOQ8oSSAupCt8ap2W+XJ4ypsR5uDA@mail.gmail.com>
	<1b9136bd-47b8-4a39-59c1-5831498a2578@redhat.com>
	<2dd73225-1e25-423e-5284-8f6fc60d47e3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v1] lsi53c895a: check message length value
 is valid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Ameya More <ameya.more@oracle.com>, Thomas Huth <thuth@redhat.com>, Fam Zheng <famz@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>

+-- On Mon, 29 Oct 2018, Paolo Bonzini wrote --+
| On 29/10/2018 18:56, Paolo Bonzini wrote:
| > On 26/10/2018 22:55, Peter Maydell wrote:
| >>> +    assert(len <= LSI_MAX_MSGIN_LEN);
| >>>      pci_dma_write(PCI_DEVICE(s), s->dnad, s->msg, len);
| >>>      /* Linux drivers rely on the last byte being in the SIDL.  */
| >>>      s->sidl = s->msg[len - 1];
| >> Is it possible to get here with len == 0 ?
| > 
| > No, all calls to
| > 
| >     lsi_set_phase(s, PHASE_MI);
| > 
| > are followed or preceded by lsi_add_msg_byte.  But an assertion is good
| > to add.  What do you think of squashing this on top:
| > 
| > diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
| > index 3a40e62853..72d85c42dd 100644
| > --- a/hw/scsi/lsi53c895a.c
| > +++ b/hw/scsi/lsi53c895a.c
| > @@ -865,9 +865,9 @@ static void lsi_do_msgin(LSIState *s)
| >      trace_lsi_do_msgin(s->dbc, s->msg_len);
| >      s->sfbr = s->msg[0];
| >      len = s->msg_len;
| > +    assert(len >= 0 && len <= LSI_MAX_MSGIN_LEN);
| 
| Ahem, len > 0.  Is there a CVE number?

Sent revised patch v2. I'll request CVE once patch is reviewed/approved here.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
