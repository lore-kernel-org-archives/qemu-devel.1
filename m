Return-Path: <SRS0=M+f9=AC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16824C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 12:36:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D571422571
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 12:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E/v+hxnJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D571422571
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmzD6-0000Ir-48
	for qemu-devel@archiver.kernel.org; Sun, 21 Jun 2020 08:36:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1jmzCB-0008JX-LI
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 08:35:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50673
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1jmzC9-0001KN-94
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 08:35:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592742931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X9RbkFSHVYbeLIhcMGL9xSSd6Ub8tORuOiXIzDm14ek=;
 b=E/v+hxnJPjWM/gIdNKVNdlOsRFgYZRE0B6oFk3OXU2j4cSvqC0KYzOG3eVDz92mBPih4HK
 6Jq8AXu/gLyMJi3gYETOwn+BfnCa8rMJVht2Z4RwCjrXasbmu/bn3fnS3Jgnp+DvejNzxA
 LnNPDm4dl7yEr434v4ctHQiBez6XzAc=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-l9-8t1nwNZ2mGl2AHWlKUw-1; Sun, 21 Jun 2020 08:35:27 -0400
X-MC-Unique: l9-8t1nwNZ2mGl2AHWlKUw-1
Received: by mail-il1-f197.google.com with SMTP id i7so10019218ilq.16
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2020 05:35:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=X9RbkFSHVYbeLIhcMGL9xSSd6Ub8tORuOiXIzDm14ek=;
 b=H//3PYzRhfDDzxnkyvHRZV0wI+etYhwE8OeQbvp0cmK9ACyQh0x90BS778MC9zfbPq
 njCy/Cf4Y5g7Zg5HDQLPPDcjzBJ820R3nUypvBxw5HA8dKRcYSYJ1ivvEm8+tSi+0SCf
 DXjlsYlN0wEjVmf/C5aO5M95zmBXI46+kO2MPgcNa7nlqHQxw1tm+aLZrL0W5zJlcdL5
 jy8Ng106nbCVo04vgmOAL9w9JvH+cbNSeUIXIqP3M67KYr+m7Q3nka0GOkYs42B/Kyln
 imLvfeK53f5zWgMiyTeNpfp3IlwGE+u0q/Zfu0CMM3DIIwu/trEGF6yoaG3Nsv76lQlm
 2fGA==
X-Gm-Message-State: AOAM530748T2fyl0s5TvkBhKyYMISOsJMLOjjZxuX7fzQU6qflQOKzn8
 T6mOIxtAC3u3ZFMZBfisM6p7RNv+YWeEteTXH1JEDp4cPLtTSfjUSlkif3hj1X7uIZfMV8GYA5z
 SIGereGnZ/qghmsn+3TEjGM9e0+noFkM=
X-Received: by 2002:a05:6602:2295:: with SMTP id
 d21mr14255465iod.0.1592742926370; 
 Sun, 21 Jun 2020 05:35:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwEdE2XP5He/3VQUyCrC7g6AON/xlYQvHjeYJRz15SzeNUpk92mAsO6orq1e2vwvnR+qsI1e8WHVZER3skyS1Q=
X-Received: by 2002:a05:6602:2295:: with SMTP id
 d21mr14255454iod.0.1592742926202; 
 Sun, 21 Jun 2020 05:35:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200621145303.13068-1-lichun@ruijie.com.cn>
In-Reply-To: <20200621145303.13068-1-lichun@ruijie.com.cn>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sun, 21 Jun 2020 16:35:15 +0400
Message-ID: <CAMxuvaxiUtxSMK+93OYfUg-6RuzZkeZtzXxFvb_L=MNDGa-owA@mail.gmail.com>
Subject: Re: [PATCH] chardev/tcp: fix error message double free error
To: lichun <lichun@ruijie.com.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mlureau@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/21 08:35:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "Bonzini, Paolo" <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 706701795@qq.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Sun, Jun 21, 2020 at 10:54 AM lichun <lichun@ruijie.com.cn> wrote:
>
> Signed-off-by: lichun <lichun@ruijie.com.cn>
> ---
>  chardev/char-socket.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index afebeec5c3..3b6c1c5848 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -1086,7 +1086,10 @@ static void qemu_chr_socket_connected(QIOTask *task, void *opaque)
>      if (qio_task_propagate_error(task, &err)) {
>          tcp_chr_change_state(s, TCP_CHARDEV_STATE_DISCONNECTED);
>          check_report_connect_error(chr, err);
> -        error_free(err);
> +        /* If connect_err_reported is true, it means err is already freed */
> +        if (!s->connect_err_reported) {
> +            error_free(err);
> +        }

Good catch (did you find it with a static analysis tool?).

Instead of checking connect_err_reported here, I would rather let
check_report_connect_error() handle error_free(). Can you update the
patch?

thanks

>          goto cleanup;
>      }
>
> --
> 2.18.4
>


