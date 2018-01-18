Received: from eggs.gnu.org ([2001:4830:134:3::10]:53675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ec5Rf-0002OO-KT
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 03:21:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ec5RZ-0003Eu-CI
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 03:21:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ec5RY-0003Dq-Un
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 03:21:05 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0426683F44
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 08:21:04 +0000 (UTC)
References: <20180118025245.13042-1-famz@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d1dd1750-c487-be35-05eb-ffb12f18e805@redhat.com>
Date: Thu, 18 Jan 2018 09:20:54 +0100
MIME-Version: 1.0
In-Reply-To: <20180118025245.13042-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] scsi-generic: Simplify error handling code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On 18/01/2018 03:52, Fam Zheng wrote:
> Coverity doesn't like the ignored return value introduced in
> 9d3b155186c278 (hw/block: Fix the return type), and other callers are
> converted already in ceff3e1f01.
> 
> This one was added lately in d9bcd6f7f23a and missed the train. Do it
> now.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  hw/scsi/scsi-generic.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
> index ba70c0dc19..7414fe2d67 100644
> --- a/hw/scsi/scsi-generic.c
> +++ b/hw/scsi/scsi-generic.c
> @@ -482,7 +482,6 @@ static void scsi_generic_realize(SCSIDevice *s, Error **errp)
>      int rc;
>      int sg_version;
>      struct sg_scsi_id scsiid;
> -    Error *local_err = NULL;
>  
>      if (!s->conf.blk) {
>          error_setg(errp, "drive property not set");
> @@ -516,11 +515,9 @@ static void scsi_generic_realize(SCSIDevice *s, Error **errp)
>          error_setg(errp, "SG_GET_SCSI_ID ioctl failed");
>          return;
>      }
> -    blkconf_apply_backend_options(&s->conf,
> -                                  blk_is_read_only(s->conf.blk),
> -                                  true, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> +    if (!blkconf_apply_backend_options(&s->conf,
> +                                       blk_is_read_only(s->conf.blk),
> +                                       true, errp)) {
>          return;
>      }
>  
> 

I'm not a fan of bool return types, in general (because "!" is often
success while "< 0" is failure) and especially when there is an Error**;
I disagree with commit 9d3b155186.  But the function is not in an area I
maintain so I'm queuing this, thanks.

Paolo
