Received: from eggs.gnu.org ([2001:4830:134:3::10]:47234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1euEH6-0003Hh-Pd
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 04:25:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1euEH1-0001Cl-Rn
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 04:25:16 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45696 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1euEH1-0001Cb-Kn
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 04:25:11 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 39A1376FBA
	for <qemu-devel@nongnu.org>; Fri,  9 Mar 2018 09:25:01 +0000 (UTC)
Date: Fri, 9 Mar 2018 17:24:54 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180309092454.GC14854@lemon.usersys.redhat.com>
References: <20180308155145.19315-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180308155145.19315-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] scsi: support NDOB (no data-out buffer)
 for WRITE SAME commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

On Thu, 03/08 16:51, Paolo Bonzini wrote:
> A NDOB bit set to one specifies that the disk shall not transfer data
> from the data-out buffer and shall process the command as if the data-out
> buffer contained user data set to all zeroes.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/scsi/scsi-bus.c       | 2 +-
>  hw/scsi/scsi-disk.c      | 2 +-
>  tests/virtio-scsi-test.c | 6 ++++++
>  3 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
> index 1eaeffc830..9646743a7d 100644
> --- a/hw/scsi/scsi-bus.c
> +++ b/hw/scsi/scsi-bus.c
> @@ -944,7 +944,7 @@ static int scsi_req_xfer(SCSICommand *cmd, SCSIDevice *dev, uint8_t *buf)
>          break;
>      case WRITE_SAME_10:
>      case WRITE_SAME_16:
> -        cmd->xfer = dev->blocksize;
> +        cmd->xfer = buf[1] & 1 ? 0 : dev->blocksize;
>          break;
>      case READ_CAPACITY_10:
>          cmd->xfer = 8;
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index c65c1ce56d..5b7a48f5a5 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -1807,7 +1807,7 @@ static void scsi_disk_emulate_write_same(SCSIDiskReq *r, uint8_t *inbuf)
>          return;
>      }
>  
> -    if (buffer_is_zero(inbuf, s->qdev.blocksize)) {
> +    if ((req->cmd.buf[1] & 0x1) || buffer_is_zero(inbuf, s->qdev.blocksize)) {
>          int flags = (req->cmd.buf[1] & 0x8) ? BDRV_REQ_MAY_UNMAP : 0;

The standard says this bit is only allowed when UNMAP is set. Do we want to
check it here? I.e.

           if (!flags && (req->cmd.buf[1] & 0x1)) {
               scsi_check_condition(r, SENSE_CODE(INVALID_FIELD));
               return;
           }

>  
>          /* The request is used as the AIO opaque value, so add a ref.  */
> diff --git a/tests/virtio-scsi-test.c b/tests/virtio-scsi-test.c
> index 7393d69bb2..037872bb98 100644
> --- a/tests/virtio-scsi-test.c
> +++ b/tests/virtio-scsi-test.c
> @@ -216,6 +216,9 @@ static void test_unaligned_write_same(void)
>      const uint8_t write_same_cdb_2[VIRTIO_SCSI_CDB_SIZE] = {
>          0x41, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x33, 0x00, 0x00
>      };
> +    const uint8_t write_same_cdb_ndob[VIRTIO_SCSI_CDB_SIZE] = {
> +        0x41, 0x01, 0x00, 0x00, 0x00, 0x01, 0x00, 0x33, 0x00, 0x00
> +    };

If we add a check, maybe a test can be added to.

Fam

>  
>      vs = qvirtio_scsi_pci_init(PCI_SLOT);
>  
> @@ -225,6 +228,9 @@ static void test_unaligned_write_same(void)
>      g_assert_cmphex(0, ==,
>          virtio_scsi_do_command(vs, write_same_cdb_2, NULL, 0, buf2, 512, NULL));
>  
> +    g_assert_cmphex(0, ==,
> +        virtio_scsi_do_command(vs, write_same_cdb_ndob, NULL, 0, NULL, 0, NULL));
> +
>      qvirtio_scsi_pci_free(vs);
>  }
>  
> -- 
> 2.14.3
> 
