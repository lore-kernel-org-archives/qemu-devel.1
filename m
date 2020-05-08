Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A651C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 17:44:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA4192063A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 17:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hpxfkrbx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA4192063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX737-00048e-4e
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 13:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jX72M-0003EA-Jp
 for qemu-devel@nongnu.org; Fri, 08 May 2020 13:43:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31475
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jX72K-0001Iv-AC
 for qemu-devel@nongnu.org; Fri, 08 May 2020 13:43:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588959826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QwqCc54WUdJ8IVQXs2aqqbwWsReBPOchijLtWuJi0cI=;
 b=HpxfkrbxqA1m6duttNhTp3hc1OplbRP3xxLZJJsbjUpdERtD6SEMw4rZRuoofAI404xoO9
 CRVC0l2yALd9zKlvM0vvP5RJ0TOsQBMuwrrkL/Kc5j6By8RyQvadMNp/HlGLEp/cOSFaNA
 ZFY223+OqEG42QNjMTCrAM3t3kLqJfo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-81JlH9euNw6q_xTm-u9__Q-1; Fri, 08 May 2020 13:43:45 -0400
X-MC-Unique: 81JlH9euNw6q_xTm-u9__Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15BF219200C0;
 Fri,  8 May 2020 17:43:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C11F42E188;
 Fri,  8 May 2020 17:43:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4D86C11358BC; Fri,  8 May 2020 19:43:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH] cpus: Fix botched configure_icount() error API violation
 fix
References: <20200508104933.19051-1-armbru@redhat.com>
Date: Fri, 08 May 2020 19:43:42 +0200
In-Reply-To: <20200508104933.19051-1-armbru@redhat.com> (Markus Armbruster's
 message of "Fri, 8 May 2020 12:49:33 +0200")
Message-ID: <87lfm2wcdt.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 11:31:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> writes:

> Fixes: abc9bf69a66a11499a801ff545b8fe7adbb3a04c
> Fixes: Coverity CID 1428754
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  cpus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/cpus.c b/cpus.c
> index 5670c96bcf..b9275c672d 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -813,7 +813,7 @@ void configure_icount(QemuOpts *opts, Error **errp)
>          return;
>      }
>  
> -    if (strcmp(option, "auto") != 0) {
> +    if (option && !strcmp(option, "auto")) {
>          if (qemu_strtol(option, NULL, 0, &time_shift) < 0
>              || time_shift < 0 || time_shift > MAX_ICOUNT_SHIFT) {
>              error_setg(errp, "icount: Invalid shift value");

Nonsense.  I shouldn't multi-task.


