Received: from eggs.gnu.org ([209.51.188.92]:58830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gmZ1Q-0003TY-SC
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 02:01:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gmZ1O-0001NU-VE
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 02:01:56 -0500
Date: Thu, 24 Jan 2019 12:26:20 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <20190111164506.15971-1-pbonzini@redhat.com>
Message-ID: <nycvar.YSQ.7.76.1901241215160.20220@xnncv>
References: <20190111164506.15971-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH] scsi-generic: avoid possible out-of-bounds
 access to r->buf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

+-- On Fri, 11 Jan 2019, Paolo Bonzini wrote --+
| diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
| index 7237b4162e..42700e8897 100644
| --- a/hw/scsi/scsi-generic.c
| +++ b/hw/scsi/scsi-generic.c
| @@ -182,7 +182,7 @@ static void scsi_handle_inquiry_reply(SCSIGenericReq *r, SCSIDevice *s)
|              /* Also take care of the opt xfer len. */
|              stl_be_p(&r->buf[12],
|                      MIN_NON_ZERO(max_transfer, ldl_be_p(&r->buf[12])));
| -        } else if (s->needs_vpd_bl_emulation && page == 0x00) {
| +        } else if (s->needs_vpd_bl_emulation && page == 0x00 && r->buflen >= 4) {

  Should it be r->buflen > 4?  page_idx > 4 in while()

| +             * right place with an in-place insert.  When the while loop
| +             * begins the device response is at r[0] to r[page_idx - 1].

  r->buf[0] to r->buf[page_idx - 1] ?


| -            for (page_idx = lduw_be_p(r->buf + 2) + 4;
| -                 page_idx > 4 && r->buf[page_idx - 1] >= 0xb0;
| -                 page_idx--) {
| +            page_idx = lduw_be_p(r->buf + 2) + 4;
| +            page_idx = MIN(page_idx, r->buflen);
| +            while (page_idx > 4 && r->buf[page_idx - 1] >= 0xb0) {
|                  if (page_idx < r->buflen) {
|                      r->buf[page_idx] = r->buf[page_idx - 1];
|                  }
| +                page_idx--;
| +            }
| +            if (page_idx < r->buflen) {
| +                r->buf[page_idx] = 0xb0;
|              }
| -            r->buf[page_idx] = 0xb0;
|              stw_be_p(r->buf + 2, lduw_be_p(r->buf + 2) + 1);
|          }


Looks okay. Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
