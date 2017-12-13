Received: from eggs.gnu.org ([2001:4830:134:3::10]:51269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ePEhD-0000dP-RB
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 16:36:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ePEhA-0001kj-NP
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 16:36:07 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32847)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ePEhA-0001jz-HF
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 16:36:04 -0500
Received: by mail-wm0-f65.google.com with SMTP id g130so23650607wme.0
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 13:36:04 -0800 (PST)
References: <1512733868-9009-1-git-send-email-pl@kamp.de>
	<1512733868-9009-2-git-send-email-pl@kamp.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <206a39c0-f2cb-b5e6-24ba-d9601991fdec@redhat.com>
Date: Wed, 13 Dec 2017 22:35:53 +0100
MIME-Version: 1.0
In-Reply-To: <1512733868-9009-2-git-send-email-pl@kamp.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] block/iscsi: dont leave allocmap in an
 invalid state on UNMAP failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-stable@nongnu.org, mreitz@redhat.com, ronniesahlberg@gmail.com

On 08/12/2017 12:51, Peter Lieven wrote:
> we forgot to set the allocmap to invalid if an UNMAP call fails.

This is only needed for "a power loss, a medium error, or hardware
error" according to the spec, but I guess this is the safe thing to do.

Paolo

> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Lieven <pl@kamp.de>
> ---
>  block/iscsi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/block/iscsi.c b/block/iscsi.c
> index 4683f3b..c532ec7 100644
> --- a/block/iscsi.c
> +++ b/block/iscsi.c
> @@ -2,7 +2,7 @@
>   * QEMU Block driver for iSCSI images
>   *
>   * Copyright (c) 2010-2011 Ronnie Sahlberg <ronniesahlberg@gmail.com>
> - * Copyright (c) 2012-2016 Peter Lieven <pl@kamp.de>
> + * Copyright (c) 2012-2017 Peter Lieven <pl@kamp.de>
>   *
>   * Permission is hereby granted, free of charge, to any person obtaining a copy
>   * of this software and associated documentation files (the "Software"), to deal
> @@ -1128,6 +1128,9 @@ retry:
>          goto retry;
>      }
>  
> +    iscsi_allocmap_set_invalid(iscsilun, offset >> BDRV_SECTOR_BITS,
> +                               bytes >> BDRV_SECTOR_BITS);
> +
>      if (iTask.status == SCSI_STATUS_CHECK_CONDITION) {
>          /* the target might fail with a check condition if it
>             is not happy with the alignment of the UNMAP request
> @@ -1140,9 +1143,6 @@ retry:
>          goto out_unlock;
>      }
>  
> -    iscsi_allocmap_set_invalid(iscsilun, offset >> BDRV_SECTOR_BITS,
> -                               bytes >> BDRV_SECTOR_BITS);
> -
>  out_unlock:
>      qemu_mutex_unlock(&iscsilun->mutex);
>      return r;
> 
