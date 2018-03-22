Received: from eggs.gnu.org ([2001:4830:134:3::10]:59628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eypiW-00041q-8j
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 22:12:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eypiV-0000hW-Bq
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 22:12:36 -0400
Date: Thu, 22 Mar 2018 10:12:10 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180322021210.GC26618@lemon.usersys.redhat.com>
References: <20180321105830.22412-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321105830.22412-1-pbonzini@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

On Wed, 03/21 11:58, Paolo Bonzini wrote:
> diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
> index 7414fe2d67..b3de5df324 100644
> --- a/hw/scsi/scsi-generic.c
> +++ b/hw/scsi/scsi-generic.c
> @@ -500,9 +500,10 @@ static void scsi_generic_realize(SCSIDevice *s, Error **errp)
>      /* check we are using a driver managing SG_IO (version 3 and after */
>      rc = blk_ioctl(s->conf.blk, SG_GET_VERSION_NUM, &sg_version);
>      if (rc < 0) {
> -        error_setg(errp, "cannot get SG_IO version number: %s.  "
> -                         "Is this a SCSI device?",
> -                         strerror(-rc));
> +        error_setg(errp, "cannot get SG_IO version number: %s", strerror(-rc));
> +        if (rc != -EPERM) {
> +            error_append_hint(errp, "Is this a SCSI device?");
> +        }

Out of the scope of this patch but I find it a bit annoying that hints are not
propagated up in QMP. So that if you hot plug from virsh, the user friendliness
of the old message is lost. Not sure if that is a problem or not.

Fam
