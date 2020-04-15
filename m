Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F9FC2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 07:48:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F8F620768
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 07:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UA63V+wz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F8F620768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOcmR-0003Gs-Fl
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 03:48:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50388)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1jOckv-00024U-GR
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:46:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1jOcku-0006SJ-Gq
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:46:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53151
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1jOcku-0006SC-DK
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:46:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586936804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rkqFyYbNGd0sWy3ByMBllfvLMQekR0IzreXzdnt+MAU=;
 b=UA63V+wzI0jLSqAqTfduTkHs9zyIPL2He2+9DTi3c3bn85WPkCVJgRW+/0gwVtyoNLGcd0
 PnTUtqLm4W3oB+5zcmFRAZ4w97C6YWKaQLXLF0dVtCAYVM4jOj3QllvTmOfdOw++lT3xWx
 BN8ond86/M+03QDha81craih4eRDe7o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-ErsRNzH_P7e5p41NIdqbdg-1; Wed, 15 Apr 2020 03:46:42 -0400
X-MC-Unique: ErsRNzH_P7e5p41NIdqbdg-1
Received: by mail-wr1-f72.google.com with SMTP id r11so9100833wrx.21
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 00:46:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=D6uYMR0tGAilsHWOQKIz35tIJHoMSV6nKmckx/wUCrk=;
 b=M9cqJLT1D0noWvIjCXQoBqihuAuyE56aBynkIKpYvqvtKM9omEQVKUnTUojfeX4I9g
 bsfb42fHiDl126j0K6FXai3kqVgpc4cgNdq2xT7453b0SkuZUnPbETW757/bLBgZ/TXG
 Cn6J+/QboD4gTseqL1Rg+bCj5Nxs6SgjMzjbmMSQ89zUDdCYCjLPbZfAtmkPWWypsk4G
 9L86mw2jRlEeEGdanvS2s2mNfD3cRkP6Fs0RG6WFEVqbCFH8MJrbs/BCRv4qpIgMPabT
 lBNDBNS6+MX4F2WvNlIVgeR4nnExgWBarN9IImEPIJJOvalYJDxYNc8vM+Bxz4n6cPBH
 VCpw==
X-Gm-Message-State: AGi0PuawfwTzFbXr52ByEcAr75yUq30EtNYIwhxuEm0NlPBzkDYXPeSx
 6++C3RTyi4FtYIHJcyxjBnciE18RV83iYOncf8h83svAAMIMG5v+/lfQNmEhu51Rk+IgVFdaY8b
 Nuy7fjdK/OHe5mGw=
X-Received: by 2002:a7b:c118:: with SMTP id w24mr3682321wmi.173.1586936801314; 
 Wed, 15 Apr 2020 00:46:41 -0700 (PDT)
X-Google-Smtp-Source: APiQypIajXtnAzsTJSppd+9aCsT1VeTSCZH5Ne1j6yZCUCFDzg6LVHRi1NQ4fdK7UNcYs/4NydlTfQ==
X-Received: by 2002:a7b:c118:: with SMTP id w24mr3682303wmi.173.1586936801115; 
 Wed, 15 Apr 2020 00:46:41 -0700 (PDT)
Received: from steredhat (host32-201-dynamic.27-79-r.retail.telecomitalia.it.
 [79.27.201.32])
 by smtp.gmail.com with ESMTPSA id k9sm23214624wrd.17.2020.04.15.00.46.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2020 00:46:40 -0700 (PDT)
Date: Wed, 15 Apr 2020 09:46:36 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] block/nvme: Remove memory leak
Message-ID: <20200415074636.pu66tqyaqvecnqk7@steredhat>
References: <20200414151727.17012-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200414151727.17012-1-philmd@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Apr 14, 2020 at 05:17:26PM +0200, Philippe Mathieu-Daud=E9 wrote:
> Fixes: bdd6a90a9 ("Add VFIO based NVMe driver")
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  block/nvme.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/block/nvme.c b/block/nvme.c
> index 7b7c0cc5d6..9f3c7ab819 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -163,6 +163,7 @@ static void nvme_init_queue(BlockDriverState *bs, NVM=
eQueue *q,
>      }
>      r =3D qemu_vfio_dma_map(s->vfio, q->queue, bytes, false, &q->iova);
>      if (r) {
> +        qemu_vfree(q->queue);
>          error_setg(errp, "Cannot map queue");
>      }
>  }
> --=20
> 2.21.1
>=20
>=20

Are we adding a double free with this change?

IIUC when nvme_init_queue() fails in the nvme_create_queue_pair() we
already call the nvme_free_queue_pair() that frees sq.queue and
cq.queue.

I think your patch make the code cleaner, freeing the buffer near the
allocation during an error, maybe we can also set q->queue to NULL
after the qemu_vfree().

Thanks,
Stefano


