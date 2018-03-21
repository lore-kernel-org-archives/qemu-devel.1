Received: from eggs.gnu.org ([2001:4830:134:3::10]:54493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1eycgB-0003Ye-Vj
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 08:17:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1eycgA-0004tK-NV
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 08:17:19 -0400
References: <20180321105830.22412-1-pbonzini@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <0b772d6c-d0df-f466-053e-29f0304ad52a@redhat.com>
Date: Wed, 21 Mar 2018 13:17:08 +0100
MIME-Version: 1.0
In-Reply-To: <20180321105830.22412-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] scsi: turn "is this a SCSI device?" into a
 conditional hint
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org

On 21/03/2018 11:58, Paolo Bonzini wrote:
> If the user does not have permissions to send ioctls to the device (due to
> SELinux or cgroups, for example), the output can look like
> 
> qemu-kvm: -device scsi-block,drive=disk: cannot get SG_IO version number:
>   Operation not permitted.  Is this a SCSI device?
> 
> but this is confusing because the ioctl was blocked _before_ the device
> even received the SG_GET_VERSION_NUM ioctl.  Therefore, for EPERM errors
> the suggestion should be eliminated.  To make that simpler, change the
> code to use error_append_hint.
> 
> Reported-by: Ala Hino <ahino@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/scsi/scsi-disk.c    | 7 ++++---
>  hw/scsi/scsi-generic.c | 7 ++++---
>  2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index 94043ed024..ccc245589a 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -2637,9 +2637,10 @@ static void scsi_block_realize(SCSIDevice *dev, Error **errp)
>      /* check we are using a driver managing SG_IO (version 3 and after) */
>      rc = blk_ioctl(s->qdev.conf.blk, SG_GET_VERSION_NUM, &sg_version);
>      if (rc < 0) {
> -        error_setg(errp, "cannot get SG_IO version number: %s.  "
> -                     "Is this a SCSI device?",
> -                     strerror(-rc));
> +        error_setg(errp, "cannot get SG_IO version number: %s", strerror(-rc));


You could use:

  error_setg_errno(errp, -rc, "cannot get SG_IO version number");

Thanks,
Laurent
