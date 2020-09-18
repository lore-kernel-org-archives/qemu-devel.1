Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DC4C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 15:37:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30FFD208DB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 15:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30FFD208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJIRg-0006yM-Bl
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 11:37:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kJIL1-00008B-81; Fri, 18 Sep 2020 11:30:15 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:50959)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kJIKy-0004dZ-Vj; Fri, 18 Sep 2020 11:30:14 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.20.240])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 95FA25C8D9DF;
 Fri, 18 Sep 2020 17:30:08 +0200 (CEST)
Received: from kaod.org (37.59.142.105) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Fri, 18 Sep
 2020 17:30:07 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G0063bcf624c-e6cc-4855-9397-331c7f3422d0,
 26E73787F9CAC9185D3FF732CC8AC9B997D690EB) smtp.auth=groug@kaod.org
Date: Fri, 18 Sep 2020 17:30:06 +0200
From: Greg Kurz <groug@kaod.org>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v2 12/13] block/qcow2: simplify qcow2_co_invalidate_cache()
Message-ID: <20200918173006.5f49cb06@bahia.lan>
In-Reply-To: <20200917195519.19589-13-vsementsov@virtuozzo.com>
References: <20200917195519.19589-1-vsementsov@virtuozzo.com>
 <20200917195519.19589-13-vsementsov@virtuozzo.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.105]
X-ClientProxiedBy: DAG7EX1.mxp5.local (172.16.2.61) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: b063285c-32d4-4c44-bc91-251037a5f43d
X-Ovh-Tracer-Id: 15168123547993938363
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrtdeigdeltdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgihesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepfedutdeijeejveehkeeileetgfelteekteehtedtieefffevhffflefftdefleejnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehkfiholhhfsehrvgguhhgrthdrtghomh
Received-SPF: pass client-ip=178.32.125.2; envelope-from=groug@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 11:30:09
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, berto@igalia.com, pavel.dovgaluk@ispras.ru,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, mreitz@redhat.com, jsnow@redhat.com,
 ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 17 Sep 2020 22:55:18 +0300
Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:

> qcow2_do_open correctly sets errp on each failure path. So, we can
> simplify code in qcow2_co_invalidate_cache() and drop explicit error
> propagation. We should use ERRP_GUARD() (accordingly to comment in
> include/qapi/error.h) together with error_append() call which we add to
> avoid problems with error_fatal.
> 

The wording gives the impression that we add error_append() to avoid problems
with error_fatal which is certainly not true. Also it isn't _append() but
_prepend() :)

What about ?

"Add ERRP_GUARD() as mandated by the documentation in include/qapi/error.h
 to avoid problems with the error_prepend() call if errp is &error_fatal."

With that fixed,

Reviewed-by: Greg Kurz <groug@kaod.org>

> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 2b6ec4b757..cd5f48d3fb 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -2702,11 +2702,11 @@ static void qcow2_close(BlockDriverState *bs)
>  static void coroutine_fn qcow2_co_invalidate_cache(BlockDriverState *bs,
>                                                     Error **errp)
>  {
> +    ERRP_GUARD();
>      BDRVQcow2State *s = bs->opaque;
>      int flags = s->flags;
>      QCryptoBlock *crypto = NULL;
>      QDict *options;
> -    Error *local_err = NULL;
>      int ret;
>  
>      /*
> @@ -2724,16 +2724,11 @@ static void coroutine_fn qcow2_co_invalidate_cache(BlockDriverState *bs,
>  
>      flags &= ~BDRV_O_INACTIVE;
>      qemu_co_mutex_lock(&s->lock);
> -    ret = qcow2_do_open(bs, options, flags, &local_err);
> +    ret = qcow2_do_open(bs, options, flags, errp);
>      qemu_co_mutex_unlock(&s->lock);
>      qobject_unref(options);
> -    if (local_err) {
> -        error_propagate_prepend(errp, local_err,
> -                                "Could not reopen qcow2 layer: ");
> -        bs->drv = NULL;
> -        return;
> -    } else if (ret < 0) {
> -        error_setg_errno(errp, -ret, "Could not reopen qcow2 layer");
> +    if (ret < 0) {
> +        error_prepend(errp, "Could not reopen qcow2 layer: ");
>          bs->drv = NULL;
>          return;
>      }


