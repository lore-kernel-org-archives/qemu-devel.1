Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E970C2D0F7
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 21:07:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66E2620740
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 21:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqjGFxWF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66E2620740
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYc7o-0004Q8-IS
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 17:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomas.krcka@gmail.com>)
 id 1jYc6N-0001bx-Lv; Tue, 12 May 2020 17:06:11 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:46846)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomas.krcka@gmail.com>)
 id 1jYc6J-0001Xh-DO; Tue, 12 May 2020 17:06:11 -0400
Received: by mail-lj1-x243.google.com with SMTP id f18so15305900lja.13;
 Tue, 12 May 2020 14:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=V1ecv5+6sXzj/mqwJbJ0JF3Mm6pXa/xHekhGcfKP5cM=;
 b=EqjGFxWF9qp+7CCfZ8Y2aPo2NMWm55Crrc1nIqGOgU/oYdnUd25mvqzzlyl7PEKSO+
 5y8lpxW9E7bQ9J6Krey2x1Y2WyqftR9jNgr7HgOCXvUVJ4yZgDCssS0htI8fdt4kpHI2
 UbNSy2hifni0i28Jb6s9cF6IEkAWRIl8P4ZRjkgSABiMQ47LgYL5eRLbZms58fzno4EL
 YTkU9pnO218m/93fdzEMy92bL0i/8gnsUDxMU8eN3nYQPuDMGy3eXSISvUNXxuXQD2gA
 MKkf55hbNHNtNKPeEc/RKR8w28CYRmoChPwNYlmkWLa81/hgYpEBSEPyq7yfVzLC0pjX
 z2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=V1ecv5+6sXzj/mqwJbJ0JF3Mm6pXa/xHekhGcfKP5cM=;
 b=UTsnG2Q/tXlzaqr962kAG0YOlwf0ZRJkq+k/ure+6+/To5DlUS6m2nOpDLzBRUNBtK
 K287TnQkWzoIKdDBS5Grj/jjeUIuI21E7LG4cCz626MSydd7/+dXAHdw7T17cYshxq3w
 HtZ4MneNq9m+vdqdXCFpDkLap3QiMZHHqonlIw1nDLRD7IyPt95bu1/ZPpWh9Brc7Q5u
 /06ij2BJat2JZ/VmUj6P9OsqEazirPIa24QqRfBtSYrIEnxr2xSGDFw0gM27oCnfjIYI
 33LFJNNq4tK/yZi3XBzZEgLyjGPaJBdkhhG5xn9BBvkWi+YLcjp1EQJapsVNG5t8qfYY
 K7sQ==
X-Gm-Message-State: AOAM530W9JhoPVW7C3u9snnZ9wrDdh5IYoBEwTvBMKeQNEqKfKN/fUGg
 +vwOZKgGz5GaZrfjcXz6H8lrPvLP5oSxZwjuNmY=
X-Google-Smtp-Source: ABdhPJz5ifX+aQgZo2l6/P9Dsy80rLik0/9EZqBwyVq8tbmlO9bzbVQU0jNU++DIv2gbmN62Zy0pkpxLqumV2yLxGHc=
X-Received: by 2002:a05:651c:230:: with SMTP id
 z16mr14798789ljn.185.1589317564531; 
 Tue, 12 May 2020 14:06:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200506132114.76406-1-tomas.krcka@gmail.com>
 <5cf6dee4-7bfa-76b2-9f44-14bfc7f3d510@vivier.eu>
In-Reply-To: <5cf6dee4-7bfa-76b2-9f44-14bfc7f3d510@vivier.eu>
From: Tomas Krcka <tomas.krcka@gmail.com>
Date: Tue, 12 May 2020 23:05:53 +0200
Message-ID: <CAOtnYZPj9h10OLYB0RoPASubNXQNwBfSY415i7FafXs0AgXOrQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] linux-user: add do_setsockopt SOL_CAN_RAW
 CAN_RAW_FILTER support
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=tomas.krcka@gmail.com; helo=mail-lj1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am Di., 12. Mai 2020 um 22:09 Uhr schrieb Laurent Vivier <laurent@vivier.eu=
>:
>
> Le 06/05/2020 =C3=A0 15:21, Tomas Krcka a =C3=A9crit :
> > Signed-off-by: Tomas Krcka <tomas.krcka@gmail.com>
> > ---
> >  linux-user/syscall.c | 34 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> >
> > diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> > index 05f03919ff..88d4c85b70 100644
> > --- a/linux-user/syscall.c
> > +++ b/linux-user/syscall.c
> > @@ -56,6 +56,7 @@
> >  #include <linux/wireless.h>
> >  #include <linux/icmp.h>
> >  #include <linux/icmpv6.h>
> > +#include <linux/can/raw.h>
> >  #include <linux/errqueue.h>
> >  #include <linux/random.h>
> >  #ifdef CONFIG_TIMERFD
> > @@ -2111,6 +2112,39 @@ static abi_long do_setsockopt(int sockfd, int le=
vel, int optname,
> >              goto unimplemented;
> >          }
> >          break;
> > +    case SOL_CAN_RAW:
> > +        switch (optname) {
> > +        case CAN_RAW_FILTER:
> > +        {
> > +            if (optlen % sizeof(struct can_filter) !=3D 0) {
> > +                return -TARGET_EINVAL;
> > +            }
> > +
> > +            struct can_filter  *can_filters =3D NULL;
>
> Move the declaration to the top of the block.
>
> > +            if (optlen !=3D 0) {
>
> If you check, like in kernel, "optlen > CAN_RAW_FILTER_MAX *
> sizeof(struct can_filter)", you can exit here (and no need to set
> can_filters to NULL).
>

The optlen can be 0 and then the can_filter shall be NULL, based on
the socketcan
documentation.
And an additional question, shall I check if optlen is 1 and then use
non-dynamic allocated
filters, as it's done in kernel?

> > +                can_filters =3D g_new0(struct can_filter, optlen);
> > +
> > +                if (!can_filters) {
>
> no need to check the result, g_new0() aborts in case of problem.
>
> > +                    return -TARGET_ENOMEM;
> > +                }
> > +                if (copy_from_user(can_filters, optval_addr, optlen)) =
{
> > +                    g_free(can_filters);
> > +                    return -TARGET_EFAULT;
> > +                }
>
> It would be cleaner not to use the copy_from_user() as we need to
> byte-swap all the fields in the loop below (I know it's done like that
> in SOL_ICMPV6...)
>
> > +                for (val =3D 0; val < optlen / sizeof(struct can_filte=
r); val++) {
> > +                    can_filters[val].can_id =3D tswap32(can_filters[va=
l].can_id);
> > +                    can_filters[val].can_mask =3D tswap32(can_filters[=
val].can_mask);
> > +                }
>
> So, something like:
>
> target_can_filters =3D lock_user(VERIFY_READ, optval_addr, optlen, 1);
> for (val =3D 0; val < optlen / sizeof(struct can_filter); val++) {
>     __get_user(can_filters[val].can_id, \
>                &target_can_filters[val].can_id);
>     __get_user(can_filters[val].can_mask, \
>                &target_can_filters[val].can_mask);
> }
> unlock_user(target_can_filters);
>
> > +            }
> > +            ret =3D get_errno(setsockopt(sockfd, level, optname,
> > +                                        can_filters, optlen));
> > +            g_free(can_filters);
> > +            break;
> > +        }
> > +        default:
> > +            goto unimplemented;
> > +        }
> > +        break;
> >      case SOL_RAW:
> >          switch (optname) {
> >          case ICMP_FILTER:
> >
>
> Could you also update getsockopt()?
Yes, I can.
>
> Thanks,
> Laurent
>
>

