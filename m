Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF05C433E7
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 20:52:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2861C20674
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 20:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FTv6Qrtk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2861C20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRiKD-00036g-BJ
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 16:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1kRi6R-0003Fv-If
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 16:37:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51482)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1kRi6P-0005cO-UK
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 16:37:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602448676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O99RZR/LeArbwxfDPdRIWx3Sw5cvxAOTgciJHtLY78w=;
 b=FTv6QrtkMODNmXuvQPOxK/Tl8DGKuO1P2psN3zA7/vn2WVwGIc6jXleqfGeAWTKGddokX3
 OwlDr57mdQg+MWbrgl6ofDQsA3SG2cLsXQPwgrUP9LsmaPmBW5eRTqYSMx85FbXXBiRgg/
 9SO3MziWu/YKgy0HLwtPRd9gIdxDIj8=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-Jq4jw6MtPGmm8EW2pnL6NQ-1; Sun, 11 Oct 2020 16:37:54 -0400
X-MC-Unique: Jq4jw6MtPGmm8EW2pnL6NQ-1
Received: by mail-io1-f69.google.com with SMTP id j21so9319097iog.8
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2020 13:37:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=O99RZR/LeArbwxfDPdRIWx3Sw5cvxAOTgciJHtLY78w=;
 b=o5oKM5tUJQrs6x3xQGJ7f59+/DkINHuCkfjSrall56HSAcYHzGhCbCMb6rh9RR5JOy
 TBzshQaoxkHnSZGIom5SlNF7WRoXJa+PofpGMTsD/IEcGGCNGIEgEg0+zOimJ+RABshN
 zcf+My2UxYn3IAPSG0R3xl0Yg4+TfbqJEFgKquY+Jsfqbo6uVQxcQMUa5H900s+uTMg7
 LV3RJAk83pJkYksv1g45h9qsdtNNobkJbFNJVpATUQjWCPIj+AsJymscDRwHZB9lgJiG
 I7Ldbg+TsBO2CWzV2wGBXcpHRWWH5BO6o/B5utng7+uK4uF/u8QvypOYdA5qozSrn1pj
 Jq/w==
X-Gm-Message-State: AOAM533FKSsI9wGtBbgZJX5fE6pSywPueDt4zvIHFheazkD+6U8rvkTL
 x/X3ROfG6kJy/nXhOM2dNDMcRfEmNRl0fNuM/vYwAr4qITbOkMtIoUqaPLQoccGDG/mUWYeeyQr
 /2dNDQvgIHI9ODz8nZKsUP/inmcgcPcc=
X-Received: by 2002:a92:d742:: with SMTP id e2mr16205104ilq.11.1602448674029; 
 Sun, 11 Oct 2020 13:37:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyg45Q8suwDx1gD0e7aAQEoSif5K1VTmh8skkxku2SQE7JN/vUHbmA4LchEG5UG4CAA+hP7aWhLp+QrlgMpTLM=
X-Received: by 2002:a92:d742:: with SMTP id e2mr16205091ilq.11.1602448673808; 
 Sun, 11 Oct 2020 13:37:53 -0700 (PDT)
MIME-Version: 1.0
References: <20201011203513.1621355-1-marcandre.lureau@redhat.com>
 <20201011203513.1621355-2-marcandre.lureau@redhat.com>
In-Reply-To: <20201011203513.1621355-2-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 12 Oct 2020 00:37:43 +0400
Message-ID: <CAMxuvaxLnNH7KFyj1hni=RpwDffQoFL7FkiuBMiJBNF8_OYQEQ@mail.gmail.com>
Subject: Re: [PoCv2 01/15] mingw: fix error __USE_MINGW_ANSI_STDIO redefined
To: qemu-devel <qemu-devel@nongnu.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlureau@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 16:23:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Bonzini, Paolo" <pbonzini@redhat.com>, "P. Berrange,
 Daniel" <berrange@redhat.com>, "Armbruster, Markus" <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Mon, Oct 12, 2020 at 12:35 AM <marcandre.lureau@redhat.com> wrote:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Always put osdep.h first, and remove redundant stdlib.h include.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

(ignore this patch, which was already sent earlier)

> ---
>  migration/dirtyrate.c | 3 ++-
>  tests/test-bitmap.c   | 1 -
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index 68577ef250..47f761e67a 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -10,8 +10,9 @@
>   * See the COPYING file in the top-level directory.
>   */
>
> -#include <zlib.h>
>  #include "qemu/osdep.h"
> +
> +#include <zlib.h>
>  #include "qapi/error.h"
>  #include "cpu.h"
>  #include "qemu/config-file.h"
> diff --git a/tests/test-bitmap.c b/tests/test-bitmap.c
> index 2f5b71458a..8db4f67883 100644
> --- a/tests/test-bitmap.c
> +++ b/tests/test-bitmap.c
> @@ -8,7 +8,6 @@
>   * Author: Peter Xu <peterx@redhat.com>
>   */
>
> -#include <stdlib.h>
>  #include "qemu/osdep.h"
>  #include "qemu/bitmap.h"
>
> --
> 2.28.0
>


