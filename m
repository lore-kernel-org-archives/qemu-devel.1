Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772A3C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 07:27:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 406EC206F8
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 07:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jU0eRxzu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 406EC206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKGjN-00010c-Ck
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 03:27:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38492)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1jKGih-0000VV-0z
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 03:26:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1jKGif-0001FO-Vz
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 03:26:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35192
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1jKGif-0001EI-SQ
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 03:26:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585898785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ehEvQch35v+vmmZXUwVMeHs+fXrKtZpz96OIAdwMs40=;
 b=jU0eRxzuHuzGbYmUdHpbNUh11VHbbDfFXVtqpn4dal8fhv8eBc7i4aU+crX5Qamu6wTdSZ
 bqQHAY+pD77OUQnK7nN0KZFn8kSNk3sSqG7C9XyRmxiPFKgyuwncLCgOqAFQVHoGe6KXpC
 2eCH62tuPzKr9HwmPBgmshCIcNqkL+k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-2uny49DnPqW7sYcOH4u0OA-1; Fri, 03 Apr 2020 03:26:21 -0400
X-MC-Unique: 2uny49DnPqW7sYcOH4u0OA-1
Received: by mail-wr1-f72.google.com with SMTP id a10so118556wra.2
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 00:26:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=CjH2v81nieB/rc6O+FwfEuX/n9hjwek77sB6RdSXGb8=;
 b=qDrsT4xLBr87Zb5MwNbJHmCLDSWRM4bjWEWEmwvXUxhHv5ciz8KWlXgwrtveHUaAZ5
 GFNh2be0zz9FwP+wVM3OWljzhiDdSEMdvXKBihNXVVi84kXfKPvUcTDy3G0hHHXfUmGs
 5WRmX8YWTlfL4fYtRvU8qUEVvkg0hzMwKE0r+WBNGKcN/OwM+BaWokN/eXSRP3nfqK8D
 VBJ0/Myy35tX5EXlL+4kVErC+AjVKRFUuOvWM++duT2g0o5gc+x3/l5YrL2DOtl1pZ5e
 ik1ScoEhwuIBvEXalAK/IsEg5DCPi83t1iLrJT0+NjHRDlhbxtDgQAc66tLEiySVfcZb
 iDSg==
X-Gm-Message-State: AGi0PuZrMBsYSgJ90Bsc6MnIHdijiR8ZDvxrYcTpb1Oz6Z8fdGUo2vti
 Q18EnKSD81x3CK9JeQ/PRxb+CuBk8eayeNh3bdSYbHGxUjaWdGhj6QhbpFgwUobVZdZlR3XLKPB
 nrKiJRtA8c95u64Y=
X-Received: by 2002:a5d:4111:: with SMTP id l17mr7987673wrp.271.1585898780440; 
 Fri, 03 Apr 2020 00:26:20 -0700 (PDT)
X-Google-Smtp-Source: APiQypLzvQCm6AwskT/o5nGu4bOGmdGnIOT2Vz8JfjSMdJpLUBdY6VqHIxSvN9nByDhmt0SCOQ45Pw==
X-Received: by 2002:a5d:4111:: with SMTP id l17mr7987648wrp.271.1585898780193; 
 Fri, 03 Apr 2020 00:26:20 -0700 (PDT)
Received: from steredhat (host32-201-dynamic.27-79-r.retail.telecomitalia.it.
 [79.27.201.32])
 by smtp.gmail.com with ESMTPSA id y20sm1656432wmi.31.2020.04.03.00.26.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 00:26:19 -0700 (PDT)
Date: Fri, 3 Apr 2020 09:26:17 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH for-5.0] aio-posix: fix test-aio /aio/event/wait with
 fdmon-io_uring
Message-ID: <20200403072617.k45vkexc42shi7f3@steredhat>
References: <20200402145434.99349-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200402145434.99349-1-stefanha@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org,
 Julia Suvorova <jusual@redhat.com>, qemu-devel@nongnu.org,
 Cole Robinson <crobinso@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 02, 2020 at 03:54:34PM +0100, Stefan Hajnoczi wrote:
> When a file descriptor becomes ready we must re-arm POLL_ADD.  This is
> done by adding an sqe to the io_uring sq ring.  The ->need_wait()
> function wasn't taking pending sqes into account and therefore
> io_uring_submit_and_wait() was not being called.  Polling for cqes
> failed to detect fd readiness since we hadn't submitted the sqe to
> io_uring.
>=20
> This patch fixes the following tests/test-aio -p /aio/event/wait
> failure:
>=20
>   ok 11 /aio/event/wait
>   **
>   ERROR:tests/test-aio.c:374:test_flush_event_notifier: assertion failed:=
 (aio_poll(ctx, false))
>=20
> Reported-by: Cole Robinson <crobinso@redhat.com>
> Fixes: 73fd282e7b6dd4e4ea1c3bbb3d302c8db51e4ccf
>        ("aio-posix: add io_uring fd monitoring implementation")
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  util/fdmon-io_uring.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

>=20
> diff --git a/util/fdmon-io_uring.c b/util/fdmon-io_uring.c
> index 7e143ef515..b4d6109f20 100644
> --- a/util/fdmon-io_uring.c
> +++ b/util/fdmon-io_uring.c
> @@ -295,7 +295,12 @@ static bool fdmon_io_uring_need_wait(AioContext *ctx=
)
>          return true;
>      }
> =20
> -    /* Do we need to submit new io_uring sqes? */
> +    /* Are there pending sqes to submit? */
> +    if (io_uring_sq_ready(&ctx->fdmon_io_uring)) {
> +        return true;
> +    }
> +
> +    /* Do we need to process AioHandlers for io_uring changes? */
>      if (!QSLIST_EMPTY_RCU(&ctx->submit_list)) {
>          return true;
>      }
> --=20
> 2.25.1
>=20


