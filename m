Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6293C4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 09:31:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70A6120409
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 09:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OWVq3nlm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70A6120409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFE0E-0002Lo-IP
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 05:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54251)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1jFDxd-0005SB-Rb
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 05:29:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1jFDxc-0006cL-KY
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 05:29:01 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:39026)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1jFDxc-0006bs-Fz
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 05:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584696540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8f0tTjuLrP1xwqSv6uEQKOt1oY8ubKzwhnJDViTbZxQ=;
 b=OWVq3nlmUIYvWGhfO02Seeg6681to+Pgv+wvyjNxTLyjp9dnmLLBOiWwk146J8rYaaR8OR
 BkcKvWrqpS8N0NYyeFUIDiWB7iaWEaqMHZvcG6e6cvxZM5WrdOXrNawweOZlieuHvrOjKC
 MuELEsHZF5FacbrdxzeWNIUKw9ncUAk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-rGhp-J_5NeiMJL27WzLgYg-1; Fri, 20 Mar 2020 05:28:58 -0400
X-MC-Unique: rGhp-J_5NeiMJL27WzLgYg-1
Received: by mail-wr1-f72.google.com with SMTP id e10so571270wru.6
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 02:28:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6kXI3tNvTFuaQ//HmPous45F3qjN5O4muJs+S3Kry1M=;
 b=NLua6cmBYObA5AZuHS3loweWTFMsR8Tt+mrGtDgONy/Losbjv/P91hHlrXJ1kydpUo
 fKJiITn45HyD6k8XEkYY4E3afQUVOPqmhWPM7XVI4wo5rBDs8jrFAAlb3q1sBU/0yJqX
 OG0pVHo1ZvZ+jeYbTr1AmPutDr9crfPqzJDwe+bD0yeLPhp9tvzCVm65rSZlUuc0KmMC
 jWhR8HuimdtiSLlu384bNeh3hWP/VjB0Gv77sk2jccpcGkiQbHyiFMBRvZwKxYawG2z/
 Vkkam07h4EUqhMC75nrzgWnpRFfeR2ifx7xB49/n6wzrNVF5Gt1L/QqzR/+4ExWGG8IA
 LUdg==
X-Gm-Message-State: ANhLgQ0qdPZDJ95YXJFuTwPPnVcBxE7pTXrdc40NRsvjbSWvC/xFoFQ8
 3fXOzhbkJxs49bLjVxou3NyxQ8Pckr/IDmjEg59UG8LjZdr9kklB+UjAmUzVLYwJLRjLak2JK/Y
 q4p1gZR+GmA+oY1I=
X-Received: by 2002:a5d:6287:: with SMTP id k7mr9167272wru.195.1584696537329; 
 Fri, 20 Mar 2020 02:28:57 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vueaN1N35PL7tDpohSRe1+ngjYFLDwaIevNS08GtRxC0isq+qHose9u7rDp1DVgf+OAQm15pw==
X-Received: by 2002:a5d:6287:: with SMTP id k7mr9167246wru.195.1584696537032; 
 Fri, 20 Mar 2020 02:28:57 -0700 (PDT)
Received: from steredhat (host32-201-dynamic.27-79-r.retail.telecomitalia.it.
 [79.27.201.32])
 by smtp.gmail.com with ESMTPSA id d18sm7371927wrq.22.2020.03.20.02.28.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 02:28:56 -0700 (PDT)
Date: Fri, 20 Mar 2020 10:28:53 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] aio-posix: fix io_uring with external events
Message-ID: <20200320092853.2nuafrle65eiegq3@steredhat>
References: <20200319163559.117903-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200319163559.117903-1-stefanha@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 19, 2020 at 04:35:59PM +0000, Stefan Hajnoczi wrote:
> When external event sources are disabled fdmon-io_uring falls back to
> fdmon-poll.  The ->need_wait() callback needs to watch for this so it
> can return true when external event sources are disabled.
>=20
> It is also necessary to call ->wait() when AioHandlers have changed
> because io_uring is asynchronous and we must submit new sqes.
>=20
> Both of these changes to ->need_wait() together fix tests/test-aio -p
> /aio/external-client, which failed with:
>=20
>   test-aio: tests/test-aio.c:404: test_aio_external_client: Assertion `ai=
o_poll(ctx, false)' failed.
>=20
> Reported-by: Julia Suvorova <jusual@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  util/fdmon-io_uring.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/util/fdmon-io_uring.c b/util/fdmon-io_uring.c
> index 893b79b622..7e143ef515 100644
> --- a/util/fdmon-io_uring.c
> +++ b/util/fdmon-io_uring.c
> @@ -290,7 +290,18 @@ static int fdmon_io_uring_wait(AioContext *ctx, AioH=
andlerList *ready_list,
> =20
>  static bool fdmon_io_uring_need_wait(AioContext *ctx)
>  {
> -    return io_uring_cq_ready(&ctx->fdmon_io_uring);
> +    /* Have io_uring events completed? */
> +    if (io_uring_cq_ready(&ctx->fdmon_io_uring)) {
> +        return true;
> +    }
> +
> +    /* Do we need to submit new io_uring sqes? */
> +    if (!QSLIST_EMPTY_RCU(&ctx->submit_list)) {
> +        return true;
> +    }
> +
> +    /* Are we falling back to fdmon-poll? */
> +    return atomic_read(&ctx->external_disable_cnt);
>  }
> =20
>  static const FDMonOps fdmon_io_uring_ops =3D {
> --=20
> 2.24.1
>=20

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


