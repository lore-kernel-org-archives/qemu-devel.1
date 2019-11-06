Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2210C5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 14:20:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFCFC217F5
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 14:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CYZH5Db8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFCFC217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSMAE-0002yx-LT
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 09:20:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56367)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iSM8U-0001We-2W
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:18:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iSM8T-0004QV-2i
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:18:13 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35710)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iSM8S-0004Om-SW
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:18:13 -0500
Received: by mail-wm1-x344.google.com with SMTP id 8so3572967wmo.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 06:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=7QUqv/QHC9r2ij6XTtgvw1Fz/nhpQYaacbhEy+nyKNI=;
 b=CYZH5Db8e3kfv+aZ+Haeks7bDYPaWdy+gMAO1nyW0WsrGhSwXPo3LF+xncOjMGqrhZ
 C5MGJG4vlgXAgAKdPPieQHjYnbeI0oRJ+JICAJLQA+EhYCMX/iyjyACTv5YrHEV3AH0C
 pfRjgTMh2yZnsP0ZSGLrEAHD7STt/QKObRrtAz/g2ExTIrMRUc6Ubb5ogDABSWbPSbSw
 A72c2CIbli4nu+c5XHqH9rx8xBAKUU2s7lJleQwvBBPishfA9dOOihdQ1Mc4f1UKbazf
 T6MIk5ZmbKy5T43A8tmrcimgEd+07gsPwbHuUtyu2pljfhz9pbdViLusL3ZHCWT6EiTr
 fVkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=7QUqv/QHC9r2ij6XTtgvw1Fz/nhpQYaacbhEy+nyKNI=;
 b=qftu+FQ4iUVBdNfLaj3uxgTl3TTuhoTqBhDVe21AS/ZBMseWqnEaB/eTOdtdMoS7oO
 PKdg7Pi1EcEuJaiVDxO4Y608OyR/Ne15iAngzF0rq6RiUb/5pu0+icFeCOm6SOHcZaSm
 rN8AM1Kui728Y2L+FQ8VebpROPe3YAjX/058f3VC3ywilGaJqjoay7XL2QfgkQzCr+18
 VXXMKKlW4OcB1UZMdIp9bAgaxFBDE8mKXpUUrTPoz902C0NLOq8z+Roq7+4oiR9Twq6J
 KvKN/3JxKF4Zf+78f5RYbitqXVoSgIKEUaywRrz9P7OCp2kYXuZEs2QDin5UTZX6xtrX
 ffXw==
X-Gm-Message-State: APjAAAVOO3q/clzZsrYMMWYEs/2TZSF8kQKfgQU1pVy8+8b3dKAVn3zk
 zibl3iS2TIOCH3c6l7vCSLnmGHLkjJA=
X-Google-Smtp-Source: APXvYqy6ZiiJ78/Dqw1M45VNA68fkpexfuMHygdKWR2wLoHwZiou4CJNpc2kZDoE610znM1sKa9y+g==
X-Received: by 2002:a7b:c75a:: with SMTP id w26mr2686622wmk.18.1573049891659; 
 Wed, 06 Nov 2019 06:18:11 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 189sm3864326wmc.7.2019.11.06.06.18.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2019 06:18:10 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2223F1FF87;
 Wed,  6 Nov 2019 14:18:10 +0000 (GMT)
References: <20191105234100.22052-1-beata.michalska@linaro.org>
 <20191105234100.22052-4-beata.michalska@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Beata Michalska <beata.michalska@linaro.org>
Subject: Re: [PATCH v2 3/4] migration: ram: Switch to ram block writeback
In-reply-to: <20191105234100.22052-4-beata.michalska@linaro.org>
Date: Wed, 06 Nov 2019 14:18:10 +0000
Message-ID: <87lfsthyvx.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: peter.maydell@linaro.org, quintela@redhat.com, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, shameerali.kolothum.thodi@huawei.com,
 dgilbert@redhat.com, eric.auger@redhat.com, qemu-arm@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Beata Michalska <beata.michalska@linaro.org> writes:

> Switch to ram block writeback for pmem migration.
>
> Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  migration/ram.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/migration/ram.c b/migration/ram.c
> index 5078f94..38070f1 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -33,7 +33,6 @@
>  #include "qemu/bitops.h"
>  #include "qemu/bitmap.h"
>  #include "qemu/main-loop.h"
> -#include "qemu/pmem.h"
>  #include "xbzrle.h"
>  #include "ram.h"
>  #include "migration.h"
> @@ -3981,9 +3980,7 @@ static int ram_load_cleanup(void *opaque)
>      RAMBlock *rb;
>
>      RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
> -        if (ramblock_is_pmem(rb)) {
> -            pmem_persist(rb->host, rb->used_length);
> -        }
> +        qemu_ram_block_writeback(rb);
>      }
>
>      xbzrle_load_cleanup();


--
Alex Benn=C3=A9e

