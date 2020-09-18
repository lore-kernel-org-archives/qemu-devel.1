Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED1EC43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 15:58:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C27B123787
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 15:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="U0n3vpYe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C27B123787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJImf-0003vm-T6
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 11:58:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kJIfn-0004qS-8R; Fri, 18 Sep 2020 11:51:43 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:48916)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kJIfi-0008Dx-55; Fri, 18 Sep 2020 11:51:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=vlGMkLik2fCGvhtsP6Ff4U66/4+/UlsPxO5PLsKGIwM=; 
 b=U0n3vpYeLFVzj2xYvcNJlAnH1P48wshmERUbiNxMvMBPzL+D3g/jsW62VkJUKZLz7XGFhZufaqenqYa/2HBKJDHX2zEqkAPWj06H1J/9n++Z7hSySpIovNcuTL0KP8jMKrwuf3iLojVDkEbiTJBGOxWczVoDNi+PtHWb8d+8vUZ0F+d9+XBOY/nA6O1E6mAkq5rleaGcE02zOhvOtxsKlnR3NuRWUsRyqUdI+FWAV5sR1q8Ox3B60K159EPg0SUJKQ8THcWcvfffyekgSrqWjoIx3VigmWF+QP+H3fte4GeWaND6ed2ce/zATfE9PSZ5adBim91FfeWXlY+FSHNNjw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1kJIfa-00057i-Fc; Fri, 18 Sep 2020 17:51:30 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1kJIfa-0000EF-5s; Fri, 18 Sep 2020 17:51:30 +0200
From: Alberto Garcia <berto@igalia.com>
To: Greg Kurz <groug@kaod.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v2 12/13] block/qcow2: simplify qcow2_co_invalidate_cache()
In-Reply-To: <20200918173006.5f49cb06@bahia.lan>
References: <20200917195519.19589-1-vsementsov@virtuozzo.com>
 <20200917195519.19589-13-vsementsov@virtuozzo.com>
 <20200918173006.5f49cb06@bahia.lan>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Fri, 18 Sep 2020 17:51:30 +0200
Message-ID: <w51k0wr2id9.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 10:54:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Cc: kwolf@redhat.com, pavel.dovgaluk@ispras.ru, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, armbru@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, mreitz@redhat.com, jsnow@redhat.com, ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri 18 Sep 2020 05:30:06 PM CEST, Greg Kurz wrote:
>> qcow2_do_open correctly sets errp on each failure path. So, we can
>> simplify code in qcow2_co_invalidate_cache() and drop explicit error
>> propagation. We should use ERRP_GUARD() (accordingly to comment in
>> include/qapi/error.h) together with error_append() call which we add to
>> avoid problems with error_fatal.
>> 
>
> The wording gives the impression that we add error_append() to avoid problems
> with error_fatal which is certainly not true. Also it isn't _append() but
> _prepend() :)
>
> What about ?
>
> "Add ERRP_GUARD() as mandated by the documentation in include/qapi/error.h
>  to avoid problems with the error_prepend() call if errp is
>  &error_fatal."

I had to go to the individual error functions to see what "it doesn't
work with &error_fatal" actually means.

So in a case like qcow2_do_open() which has:

   error_setg(errp, ...)
   error_append_hint(errp, ...)

As far as I can see this works just fine without ERRP_GUARD() and with
error_fatal, the difference is that if we don't use the guard then the
process exists during error_setg(), and if we use the guard it exists
during the implicit error_propagate() call triggered by its destruction
at the end of the function. In this latter case the printed error
message would include the hint.

Berto

