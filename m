Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9F1C4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 15:22:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB22821D7D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 15:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="edK1Wq29"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB22821D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL6b0-0006w2-0l
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 11:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kL6Wl-0001vk-EK
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 11:17:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51664
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kL6Wj-0004n8-KD
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 11:17:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600874268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xZshAITi4RwDDUuPWQtcntCyu4f8bvCIdpnugaHYuRg=;
 b=edK1Wq293qYN6bSx9mfBrYofEfGRKRdkKEvSPBuX9NgrJVroDI3gUjYH4U0ypqPUQRfrle
 NtsB3YdRiJNHxwcCQoCUC1ioDZTQQtgolTLMpUpTcoSzmCkdQwxY2lr8JS00wAukTT2C7u
 VdDmfjLgewAHhWmWxZCH4gRPTwBfd7w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-I8hjjp5DPSSI9tE20gG3wQ-1; Wed, 23 Sep 2020 11:17:46 -0400
X-MC-Unique: I8hjjp5DPSSI9tE20gG3wQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0954210BBED9;
 Wed, 23 Sep 2020 15:17:45 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9FA147368A;
 Wed, 23 Sep 2020 15:17:44 +0000 (UTC)
Date: Wed, 23 Sep 2020 11:17:43 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 24/38] qapi/gen.py: Fix edge-case of _is_user_module
Message-ID: <20200923151743.GK3312949@habkost.net>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-25-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922210101.4081073-25-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 11:17:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 22, 2020 at 05:00:47PM -0400, John Snow wrote:
> The edge case is that if the name is '', this expression returns a
> string instead of a bool, which violates our declared type.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/gen.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
> index 9898d513ae..cb2b2655c3 100644
> --- a/scripts/qapi/gen.py
> +++ b/scripts/qapi/gen.py
> @@ -251,7 +251,7 @@ def __init__(self, prefix, what, user_blurb, builtin_blurb, pydoc):
>  
>      @staticmethod
>      def _is_user_module(name):
> -        return name and not name.startswith('./')
> +        return name is not None and not name.startswith('./')

This changes behavior if name=='', and I guess this is OK, but
I'm not sure.  I miss documentation on `visit_module()`,
`visit_include()`, and `_is_user_module()`.  I don't know what
`name` means here, and what is a "user module".

>  
>      @staticmethod
>      def _is_builtin_module(name):
> -- 
> 2.26.2
> 

-- 
Eduardo


