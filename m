Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB78C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 14:10:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50252207D4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 14:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bejq+Ge0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50252207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbPQg-0007a1-GM
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 10:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55058)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jbPLe-0007xv-Sr
 for qemu-devel@nongnu.org; Wed, 20 May 2020 10:05:30 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38553
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jbPLd-0001fb-6k
 for qemu-devel@nongnu.org; Wed, 20 May 2020 10:05:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589983527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HW6+1idwnzLIjuN55Bz9021whtxViyodRLk3cZK/Qfc=;
 b=Bejq+Ge0YMarWlxvttEWWG1V1Pz21r4fE7sntyoe1mwNSfyu9Zrl6TckTx9+zqrGSFpL6+
 ftiMkpSneQ4mG3HTzKiiuQz8hPSxe20NseSH+Hbb5pFKA7pbXbuEfu+7LEeaCoZrwTMb2I
 gSECRBXgr1nhree0/pvH5zyqBHwIi60=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-6F6MqhE7MCuDBLMO1YVNJQ-1; Wed, 20 May 2020 10:05:25 -0400
X-MC-Unique: 6F6MqhE7MCuDBLMO1YVNJQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 740AC1085950;
 Wed, 20 May 2020 14:05:24 +0000 (UTC)
Received: from linux.fritz.box (ovpn-115-47.ams2.redhat.com [10.36.115.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D16085D9E4;
 Wed, 20 May 2020 14:05:01 +0000 (UTC)
Date: Wed, 20 May 2020 16:05:00 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v2] block: Factor out bdrv_run_co()
Message-ID: <20200520140500.GB5192@linux.fritz.box>
References: <20200519175650.31506-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200519175650.31506-1-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 02:22:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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
Cc: fam@euphon.net, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 19.05.2020 um 19:56 hat Vladimir Sementsov-Ogievskiy geschrieben:
> We have a few bdrv_*() functions that can either spawn a new coroutine
> and wait for it with BDRV_POLL_WHILE() or use a fastpath if they are
> alreeady running in a coroutine. All of them duplicate basically the
> same code.
> 
> Factor the common code into a new function bdrv_run_co().
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>    [Factor out bdrv_run_co_entry too]
> ---
> 
> Hi!
> 
> I'm a bit lost on rebasing "block/io: safer inc/dec in_flight sections"
> (is it needed or not?), so, I decided to send just this one patch:
> 
> I suggest to go a bit further, and refactor that bdrv_run_co don't need
> additional *ret argument neither NOT_DONE logic.

Hm, this approach adds another indirection and bdrv_pread/pwrite still
seems to be on some hot paths. But maybe this is just the right
motivation to clean up qcow2 a bit and use explicit bdrv_co_*() where it
is possible. I might take a look later.

>  block/io.c | 191 ++++++++++++++++++++---------------------------------
>  1 file changed, 70 insertions(+), 121 deletions(-)
> 
> diff --git a/block/io.c b/block/io.c
> index 121ce17a49..794eebbd0c 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -35,8 +35,6 @@
>  #include "qemu/main-loop.h"
>  #include "sysemu/replay.h"
>  
> -#define NOT_DONE 0x7fffffff /* used while emulated sync operation in progress */
> -
>  /* Maximum bounce buffer for copy-on-read and write zeroes, in bytes */
>  #define MAX_BOUNCE_BUFFER (32768 << BDRV_SECTOR_BITS)
>  
> @@ -891,29 +889,61 @@ static int bdrv_check_byte_request(BlockDriverState *bs, int64_t offset,
>      return 0;
>  }
>  
> +typedef int coroutine_fn BdrvRequestEntry(void *opaque);
> +typedef struct BdrvRunCo {
> +    BdrvRequestEntry *entry;
> +    void *opaque;
> +    int ret;
> +    bool done;
> +} BdrvRunCo;
> +
> +static void coroutine_fn bdrv_run_co_entry(void *opaque)
> +{
> +    BdrvRunCo *arg = opaque;
> +
> +    arg->ret = arg->entry(arg->opaque);
> +    arg->done = true;
> +    aio_wait_kick();
> +}
> +
> +static int bdrv_run_co(BlockDriverState *bs, BdrvRequestEntry *entry,
> +                       void *opaque)
> +{
> +    if (qemu_in_coroutine()) {
> +        /* Fast-path if already in coroutine context */
> +        return entry(opaque);
> +    } else {
> +        BdrvRunCo s = { .entry = entry, .opaque = opaque };
> +
> +        bdrv_coroutine_enter(bs, qemu_coroutine_create(bdrv_run_co_entry, &s));

Let's keep the coroutine in a separate variable, maybe inside BdrvRunCo.
It's important for debugging BDRV_POLL_WHILE() hangs in gdb.

> +
> +        BDRV_POLL_WHILE(bs, !s.done);
> +
> +        return s.ret;
> +    }
> +}

Kevin


