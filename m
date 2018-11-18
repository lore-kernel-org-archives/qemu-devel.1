Received: from eggs.gnu.org ([2001:4830:134:3::10]:34029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gOOxg-0004hu-EE
	for qemu-devel@nongnu.org; Sun, 18 Nov 2018 10:26:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gOOxb-0008Tq-PS
	for qemu-devel@nongnu.org; Sun, 18 Nov 2018 10:26:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1gOOxb-0008TL-JU
	for qemu-devel@nongnu.org; Sun, 18 Nov 2018 10:26:07 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B22FE3083394
	for <qemu-devel@nongnu.org>; Sun, 18 Nov 2018 15:26:06 +0000 (UTC)
Date: Sun, 18 Nov 2018 15:26:00 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20181118152600.GA6861@redhat.com>
References: <1539424403-2884-1-git-send-email-pbonzini@redhat.com>
	<1539424403-2884-3-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539424403-2884-3-git-send-email-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] scsi-disk: fix rerror/werror=ignore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com

On Sat, Oct 13, 2018 at 11:53:23AM +0200, Paolo Bonzini wrote:
> rerror=ignore was returning true from scsi_handle_rw_error but the callers were not
> calling scsi_req_complete when rerror=ignore returns true (this is the correct thing
> to do when true is returned after executing a passthrough command).  Fix this by
> calling it in scsi_handle_rw_error.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/scsi/scsi-disk.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index 4074d7c..e2c5408 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -473,10 +473,15 @@ static bool scsi_handle_rw_error(SCSIDiskReq *r, int error, bool acct_failed)
>      }
>  
>      blk_error_action(s->qdev.conf.blk, action, is_read, error);
> +    if (action == BLOCK_ERROR_ACTION_IGNORE) {
> +        scsi_req_complete(&r->req, 0);
> +        return true;
> +    }
> +
>      if (action == BLOCK_ERROR_ACTION_STOP) {
>          scsi_req_retry(&r->req);
>      }
> -    return action != BLOCK_ERROR_ACTION_IGNORE;
> +    return false;
>  }

This commit seems to cause an assertion failure in qemu which is
trivial to reproduce:

(1) Create an NBD disk which returns EIO for every request:

  $ nbdkit -f -v --filter=error memory size=64M error-rate=100%

(2) Attach the disk to qemu as a virtio-scsi device:

  $ x86_64-softmmu/qemu-system-x86_64 -device virtio-scsi,id=scsi -drive file=nbd:localhost:10809,format=raw,id=hd0,if=none -device scsi-hd,drive=hd0
  qemu-system-x86_64: hw/scsi/scsi-bus.c:1374: scsi_req_complete: Assertion `req->status == -1' failed.

More details including a stack trace here:

  https://bugzilla.redhat.com/show_bug.cgi?id=1650975

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-builder quickly builds VMs from scratch
http://libguestfs.org/virt-builder.1.html
