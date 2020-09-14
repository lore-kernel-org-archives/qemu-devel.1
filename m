Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872E9C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 10:41:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA5F42076C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 10:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AwJaCoHh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA5F42076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHlvc-0006Hf-S3
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 06:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1kHluy-0005l7-Ku
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 06:41:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41384
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1kHluv-0002bN-5Q
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 06:41:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600080059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j/CdZUzAGTHxG62LySAKqsu63pPMi28wEbjVM8eqKV4=;
 b=AwJaCoHhbE/DvCQUk4C/pM2iqsTx5rvNPZ8D7PvYa5DdKt0C/izvotAq7p4wWIOQcr6VTx
 3ksRslWZ2TeqHypZ6KAlFgHf3VCXP0nw0/ekr6lqXWxO45swRxCDJdZ1lMszqZ5YbybsJ6
 zpkxInzr9vQa9JpB5OsLcgAp9H1+1/Q=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-tZsB1bDuNk-W_EpfxTJuYg-1; Mon, 14 Sep 2020 06:40:58 -0400
X-MC-Unique: tZsB1bDuNk-W_EpfxTJuYg-1
Received: by mail-il1-f199.google.com with SMTP id d16so9134320ila.23
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 03:40:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=j/CdZUzAGTHxG62LySAKqsu63pPMi28wEbjVM8eqKV4=;
 b=RfNGWLnv+yHHj9Pf4rq6+lbAbtHV7/9SxuIIkudYFaDSYoyj0U+JZvN6nMqjFeprPI
 eKLLVLU5/UIJPR7imvOnaVeklOxYcPBDjruRJlsSVZeJwMTVpJdNDDYYiu0okjID4xLm
 gHyen+tm5ex1E4Gj/qiQGfcF9RCSJ+XS369pJenif1BPLSeg67ZS1UkcWHykfn1DA+nQ
 sayrvYBLH53Cnx98dQIiAeHhgw+OaHonRgFtHrmk1tbCG5hNrziGn8q2xszJgOw8vWcX
 RuPXeKorIE3jtwsKat6tzN3cR31ECZknX5DSEencNtJ6j2A41jMlZNV4LoBQrv1nywBv
 8L0w==
X-Gm-Message-State: AOAM533fM+02dsZo/4Y3ra5XERF8G1lQDbGT+wGI4CZKoCwLMNhHUL5m
 h7thWKhpJJ/730vDqTtvosuUU1x2OwZbP1mrUEWyETPeNPCgZkzU3VYPM3VRuUUmrttL26cgXRJ
 DPORatwvoJRHT6Z7fJsCuSXhSzqqvEKo=
X-Received: by 2002:a5d:984f:: with SMTP id p15mr10819610ios.70.1600080057679; 
 Mon, 14 Sep 2020 03:40:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTgV0KYvEYgq69zLhI2YoBdcajiIQUCyZ5/b/3kSLWIUIW/h5wUgnIIKZPb1ZAzREwLAb9ndrcjx8L/T9URWE=
X-Received: by 2002:a5d:984f:: with SMTP id p15mr10819599ios.70.1600080057482; 
 Mon, 14 Sep 2020 03:40:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200914103109.1327875-1-berrange@redhat.com>
In-Reply-To: <20200914103109.1327875-1-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 14 Sep 2020 14:40:46 +0400
Message-ID: <CAMxuvaxZKfhhoHpBRVukuUdQbSfb9ek+hcipp6hUY5o4LMRpuA@mail.gmail.com>
Subject: Re: [PATCH] char: fix logging when chardev write fails
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlureau@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mlureau@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 01:39:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 14, 2020 at 2:31 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>
> The qemu_chr_write_buffer() method sends data to the chardev backend for
> writing, and then also writes to the log file. In case the chardev
> backend only writes part of the data buffer, we need to make sure we
> only log the same subset. qemu_chr_write_buffer() will be invoked again
> later to write the rest of the buffer.
>
> In the case the chardev backend returns an error though, no further
> attempts to likely to be made to write the data. We must therefore write
> the entire buffer to the log immediately.
>
> An example where this is important is with the socket backend. This will
> return -1 for all writes if no client is currently connected. We still
> wish to write data to the log file when no client is present though.
> This used to work because the chardev would return "len" to pretend it
> had written all data when no client is connected, but this changed to
> return an error in
>
>   commit 271094474b65de1ad7aaf729938de3d9b9d0d36f
>   Author: Dima Stepanov <dimastep@yandex-team.ru>
>   Date: Thu May 28 12:11:18 2020 +0300
>
>     char-socket: return -1 in case of disconnect during tcp_chr_write
>
> and this broke the logging, resulting in all data being discarded when
> no client is present.
>
> Fixes: https://bugs.launchpad.net/qemu/+bug/1893691
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  chardev/char.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/chardev/char.c b/chardev/char.c
> index 77e7ec814f..e30cd025f5 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -138,7 +138,20 @@ static int qemu_chr_write_buffer(Chardev *s,
>          }
>      }
>      if (*offset > 0) {
> +        /*
> +         * If some data was written by backend, we should
> +         * only log what was actually written. This method
> +         * may be invoked again to write the remaining
> +         * method, thus we'll log the remainder at that time.
> +         */
>          qemu_chr_write_log(s, buf, *offset);
> +    } else if (res < 0) {
> +        /*
> +         * If a fatal error was reported by the backend,
> +         * assume this method won't be invoked again with
> +         * this buffer, so log it all right away.
> +         */
> +        qemu_chr_write_log(s, buf, len);
>      }
>      qemu_mutex_unlock(&s->chr_write_lock);
>
> --
> 2.26.2
>


