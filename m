Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBDDC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 09:46:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67C5220721
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 09:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRrR9YWN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67C5220721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbhm6-0000MC-J8
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 05:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jbhkH-0005wg-5k
 for qemu-devel@nongnu.org; Thu, 21 May 2020 05:44:09 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36870)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jbhkG-0003AW-7U
 for qemu-devel@nongnu.org; Thu, 21 May 2020 05:44:08 -0400
Received: by mail-wr1-x442.google.com with SMTP id l17so6029835wrr.4
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 02:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ooQ0IakLwGcvkfeLgdBFetBZbd8U1Ew9bZ5JYb0DkVI=;
 b=IRrR9YWNVp+9+WaRhZYRWkT/9yRpV1v4Qll+/F12R8RImpffGKb5Nv1NEVDX3TUn3I
 /UJzAJcgbfNbjMxPuQ3LE0+HCLWuiTZxUnTfyVddmmqfj48tXG40odiYF3G281eSBUfm
 3X7ZWtTtcZK0jfrvv3JeQ/VusEsIHBT1HgSkxw6x6li4oR1kJkWIKFPuCT1k6g67+MY1
 58AvDlObTRH+b/eQmgLZAgBSKZe/2kwP9v6oWOmGiULJRyuwBIrPRZoua+o7h/mnoXUa
 KjYVh06UCpPM89jF1k8lsoZlX/wmvO9VCS7WkyFRm0Ii0brJxad3ZDmu+qMAPgVl0hdS
 NCng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ooQ0IakLwGcvkfeLgdBFetBZbd8U1Ew9bZ5JYb0DkVI=;
 b=rAMW+K7+DXZOa5SA8QBgjfVBHefXNzKyqBK3d9RyE3F6RC9xdnxE7ulT8D00JUdALx
 b0uIxI0yODElEGfT2dCqeFCoUyv1+Lk4dx30F9NJtFbHPOVWvp270vPtmumqpm1ieStK
 8gqZCAUXfzxVN7g5YcyzySHJYdRGHCfD1Ce8n56RvCSBYqe528QU4yuvc5EhPFZzNdVe
 3C5G2K8TiGvPG6sen3tKwOpP70RaQPSNY/T1HEzWugRlSSdw3Cie/DUz4Y7tLISHxaSQ
 9X3Qv9zDLHZVVOFkkqPLuFF0udEx5blysRsfqiZqZ3jg/KAH61nGjpKQQKFePyvBER4q
 yv/A==
X-Gm-Message-State: AOAM532p3Z0kgC+gFrXbXxp9aQyBFkcdJy5QZTPPPkWrB4vFjmzi+Tf7
 wRhJa9eFbW4BBkhKafU43wY=
X-Google-Smtp-Source: ABdhPJxvylgy49IHe7/pr2kwtMhDk6PB09UUbgMTLuwcYn4qr6/0thg9/gbGtv6DR1t1ofve3Vcchw==
X-Received: by 2002:a5d:5092:: with SMTP id a18mr3098403wrt.42.1590054246504; 
 Thu, 21 May 2020 02:44:06 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id l9sm4706739wrv.32.2020.05.21.02.44.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 02:44:04 -0700 (PDT)
Date: Thu, 21 May 2020 10:44:02 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Daniele Buono <dbuono@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/4] coroutine: support SafeStack in ucontext backend
Message-ID: <20200521094402.GA251811@stefanha-x1.localdomain>
References: <20200429194420.21147-1-dbuono@linux.vnet.ibm.com>
 <20200429194420.21147-2-dbuono@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <20200429194420.21147-2-dbuono@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Tobin Feldman-Fitzthum <tobin@ibm.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2020 at 03:44:17PM -0400, Daniele Buono wrote:
> diff --git a/include/qemu/coroutine_int.h b/include/qemu/coroutine_int.h
> index bd6b0468e1..2ffd75ddbe 100644
> --- a/include/qemu/coroutine_int.h
> +++ b/include/qemu/coroutine_int.h
> @@ -28,6 +28,12 @@
>  #include "qemu/queue.h"
>  #include "qemu/coroutine.h"
> =20
> +#if defined(__has_feature) && __has_feature(safe_stack)
> +#define CONFIG_SAFESTACK 1

Please perform this feature check in ./configure. That way
CONFIG_SAFESTACK will be defined alongside all the other CONFIG_* values
and be available to C and Makefiles via config-host.h and
config-host.mak.

> @@ -160,6 +169,19 @@ Coroutine *qemu_coroutine_new(void)
>      /* swapcontext() in, siglongjmp() back out */
>      if (!sigsetjmp(old_env, 0)) {
>          start_switch_fiber(&fake_stack_save, co->stack, co->stack_size);
> +#ifdef CONFIG_SAFESTACK
> +        /*
> +         * Before we swap the context, set the new unsafe stack
> +         * The unsafe stack grows just like the normal stack, so start f=
rom
> +         * the last usable location of the memory area.
> +         * NOTE: we don't have to re-set it afterwards because sigsetjmp=
 was
> +         * called with the original usp. Since we are not coming back wi=
th a
> +         * swapcontext, but with a siglongjmp, when we are back here we
> +         * already have usp restored to the valid one for this function

I don't understand this comment. __safestack_unsafe_stack_ptr is a
thread-local variable, not a CPU register. How will siglongjmp()
automatically restore it?

> +         */
> +        void *usp =3D co->unsafe_stack + co->unsafe_stack_size;
> +        __safestack_unsafe_stack_ptr =3D usp;
> +#endif
>          swapcontext(&old_uc, &uc);
>      }
> =20

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7GTWIACgkQnKSrs4Gr
c8h3IQgAuS80v3EEz1v9yAs8jROXblcYz3l5FRzJHhGBMkaly3eN72+0lLKEAlaV
Mvkhqhwf4P/1JB6BuuVe+2lH3VToz5SaZgh2X5jQhj4q6Sgxd8GYpndwbZHGo4kY
/G3NTDTNNn8BoKU4x7WaHkZX40UEcxU5UQoS27K+40ZmNDobBMI6LMmKuVZVYvVf
hA35CoNZptgRpSoTncfv+HW8G5EoGP8RI6wB3vTuXCj19btlO9WffspI8looMNOm
0lNfxcGRrVnlM1amk7n0+s3wrOhZCkuMAU5DcZamUccSwf2kA24raB4pz39gfEHZ
CjvFT2jjL/JqNNom1tCaAu8p+WUsbA==
=G4UC
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--

