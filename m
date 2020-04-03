Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF0EC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 13:07:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14D602073B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 13:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYu/dduB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14D602073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKM2P-0003gc-7K
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 09:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58193)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jKM1T-0002mP-Tn
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 09:06:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1jKM1S-0007lD-Oz
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 09:06:11 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37608)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1jKM1S-0007jL-Hu
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 09:06:10 -0400
Received: by mail-wm1-x343.google.com with SMTP id j19so7623685wmi.2
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 06:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=tb1oWvzN9wET7o9z2c6XLdLnHfyk6PO4JWzH6NCaLWA=;
 b=nYu/dduBLzgAQhgXPeVlAACLsJbGL5wtou4qviJLylYD2sFO9I1jLq3Zdn0PqvKxmT
 N1unYZDmB9JBr1OBLDxa+L6B9LTES1eMZ7I46h+t48pF/6Lcrl3Gr8VJo37GI+YuJwox
 yz7E72l5tLOYSH2FKB4LLvV3fvh4yAOVZDbIiub17035FQrPXw7ye5w9+XWojWHeuqES
 RIF/PyOc79/QLBIqSGt/5IkKuIpM3CxMbrNojRtEZ0ebeUvsJYJaOOgk5/hkX7WceOfX
 ouJ6uiJaC8Q0TAqc58j2XQ/RmvlEgifzEO7Rkr3aAdcDH+69sxgNB5+tfhMY+CQf3Jhi
 4c+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tb1oWvzN9wET7o9z2c6XLdLnHfyk6PO4JWzH6NCaLWA=;
 b=KhMRPjOPAYgPhNV8qW26oTseAHdiyKc61ptnGX5v+BJb08gvKq88fBnmr8Qu//fFDA
 5yw3wTx4hGUmqmhD3AvqGoQrUFZ5xXqCP8dy6P9PehrznOAhRB/YrizfSqXnz5uX1uKh
 REO4dFA2PyVHgIKtRB7LCzC7EecPavmAWxE3WAIuyw7xNNylNzc9Xr9yGjphWtYwu8Wf
 Fm8gfPiSUhxgoCIHt+5lxUNzPQESFuiRpRoBs0F6KCaVEuVG45D9fleBYUltSovB2Lh4
 k+Z8TK7jyrJ54KramkJh8INfqOKi6tX7wAzAxa9BCQbLbinV0mkQYKv7WbV82LAj/Azi
 NNyg==
X-Gm-Message-State: AGi0PuajpF1NwVM0xajnEbiT0U+wRhMTRmqzbAYhcrL4C34O4EaNn5MB
 SlAThmvRecdIfcO3Tw969aw=
X-Google-Smtp-Source: APiQypL085Bvg87dkDq66BtyluQo6LdQrPdtT683s2F1gyFJCZAb+iWkGqgXvSU/t1xipm8tZJH6WQ==
X-Received: by 2002:a7b:c051:: with SMTP id u17mr8247416wmc.129.1585919169448; 
 Fri, 03 Apr 2020 06:06:09 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id 5sm12564782wrs.20.2020.04.03.06.06.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 06:06:08 -0700 (PDT)
Date: Fri, 3 Apr 2020 14:06:07 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Simran Singhal <singhalsimran0@gmail.com>
Subject: Re: [PATCH] lockable: Replace locks with lock guard macros
Message-ID: <20200403130607.GF146016@stefanha-x1.localdomain>
References: <20200401162023.GA15912@simran-Inspiron-5558>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NQTVMVnDVuULnIzU"
Content-Disposition: inline
In-Reply-To: <20200401162023.GA15912@simran-Inspiron-5558>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Julia Suvorova <jusual@mail.ru>, qemu-devel@nongnu.org,
 Yuval Shaia <yuval.shaia.ml@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--NQTVMVnDVuULnIzU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 01, 2020 at 09:50:23PM +0530, Simran Singhal wrote:
> Replace manual lock()/unlock() calls with lock guard macros
> (QEMU_LOCK_GUARD/WITH_QEMU_LOCK_GUARD).
>=20
> Signed-off-by: Simran Singhal <singhalsimran0@gmail.com>
> ---
>  hw/hyperv/hyperv.c     | 15 ++++++-------
>  hw/rdma/rdma_backend.c | 50 +++++++++++++++++++++---------------------
>  hw/rdma/rdma_rm.c      |  3 +--
>  hw/rdma/rdma_utils.c   | 15 +++++--------
>  4 files changed, 39 insertions(+), 44 deletions(-)
>=20
> diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
> index 8ca3706f5b..4ddafe1de1 100644
> --- a/hw/hyperv/hyperv.c
> +++ b/hw/hyperv/hyperv.c
> @@ -15,6 +15,7 @@
>  #include "sysemu/kvm.h"
>  #include "qemu/bitops.h"
>  #include "qemu/error-report.h"
> +#include "qemu/lockable.h"
>  #include "qemu/queue.h"
>  #include "qemu/rcu.h"
>  #include "qemu/rcu_queue.h"
> @@ -491,7 +492,7 @@ int hyperv_set_msg_handler(uint32_t conn_id, HvMsgHan=
dler handler, void *data)
>      int ret;
>      MsgHandler *mh;
> =20
> -    qemu_mutex_lock(&handlers_mutex);
> +    QEMU_LOCK_GUARD(&handlers_mutex);
>      QLIST_FOREACH(mh, &msg_handlers, link) {
>          if (mh->conn_id =3D=3D conn_id) {
>              if (handler) {
> @@ -501,7 +502,7 @@ int hyperv_set_msg_handler(uint32_t conn_id, HvMsgHan=
dler handler, void *data)
>                  g_free_rcu(mh, rcu);
>                  ret =3D 0;
>              }
> -            goto unlock;
> +            return ret;
>          }
>      }
> =20
> @@ -515,8 +516,7 @@ int hyperv_set_msg_handler(uint32_t conn_id, HvMsgHan=
dler handler, void *data)
>      } else {
>          ret =3D -ENOENT;
>      }
> -unlock:
> -    qemu_mutex_unlock(&handlers_mutex);
> +
>      return ret;
>  }
> =20

If you respin this patch this function could be further simplified by
removing ret and using "return 0", "return -EEXIST", or "return -ENOENT"
directly instead.

> @@ -565,7 +565,7 @@ static int set_event_flag_handler(uint32_t conn_id, E=
ventNotifier *notifier)
>      int ret;
>      EventFlagHandler *handler;
> =20
> -    qemu_mutex_lock(&handlers_mutex);
> +    QEMU_LOCK_GUARD(&handlers_mutex);
>      QLIST_FOREACH(handler, &event_flag_handlers, link) {
>          if (handler->conn_id =3D=3D conn_id) {
>              if (notifier) {
> @@ -575,7 +575,7 @@ static int set_event_flag_handler(uint32_t conn_id, E=
ventNotifier *notifier)
>                  g_free_rcu(handler, rcu);
>                  ret =3D 0;
>              }
> -            goto unlock;
> +            return ret;
>          }
>      }
> =20
> @@ -588,8 +588,7 @@ static int set_event_flag_handler(uint32_t conn_id, E=
ventNotifier *notifier)
>      } else {
>          ret =3D -ENOENT;
>      }
> -unlock:
> -    qemu_mutex_unlock(&handlers_mutex);
> +
>      return ret;
>  }

Same in this function.

Otherwise:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--NQTVMVnDVuULnIzU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6HNL8ACgkQnKSrs4Gr
c8g7LwgAwTHTmlhmtagvTv1nBlv7JNMkh9Ndu+Jgn96pfvddzOD4tZrp8tKHQbV9
05KfB4FHsTfIDYtEsvJXZoT6gfGHqWXpapNCFjthgDgLdokGV3MBCOj0h9e+/5zj
EWGVYK/devX+1V+wtBrJwUlpzx5zWcFDJ9302+2iC0trCHOOIG236OVTPVEXxFHZ
uardUXs4UByny/2fn/+GbCxB02DL1J7dbZM9jw5IF2ZMwe5WI2DlIERV/0zlx58T
KtUhsPTF8/nehunPpankDCDj6JDxPP0gUdRo8kKgzvUuJ3FjjSYURI6ZkNS7AZh/
oPYZUIXUxTKpi+fhRQ1YeKWXUgoigw==
=ny5H
-----END PGP SIGNATURE-----

--NQTVMVnDVuULnIzU--

