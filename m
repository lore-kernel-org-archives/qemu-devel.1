Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CEFC433FF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 11:27:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D16F20818
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 11:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="elJWiBGr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D16F20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huxd7-0007hT-Co
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 07:27:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53110)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1huxcR-0007HV-1f
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 07:27:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1huxcQ-0001hR-0N
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 07:27:06 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40985)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1huxcN-0001fM-V7
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 07:27:05 -0400
Received: by mail-wr1-x444.google.com with SMTP id c2so84300495wrm.8
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2019 04:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=SL7zhuvsw8fEbSuSSXNVEZcQOzlkEse95M7OAX8sVlw=;
 b=elJWiBGryZXeXmuaMDk3q6tZP92hnCvrL6a3345lsiOhM/jbuDYFph/h8CavoV+92o
 rPtggQf/PGuj8ESrG6TvcMa/y4yF4yJUk4GOGpYqoUeIAc1gwG2tSbYNo+jCaYYHVzxp
 ahzqu2F8vOMCOehAE0zKdVtyhdi2lfnF7QAGilgWtuBvluzN00OjVHUBYihM8bZh/xen
 JjMafMYhgVIQRcOmdDuB3lr56GQXfbqyCw2+SsqH8AFkuCMGX1LmofgSFfFydKvgGQFa
 I56Req/3EYqyQLrOSw+o6P0+a7PKQiLjel/xRFSy99zezueR1KRzuZrBhq7exYCH0w2s
 kbiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=SL7zhuvsw8fEbSuSSXNVEZcQOzlkEse95M7OAX8sVlw=;
 b=jW3zQxOrkn71P8N7Zt7BDH9PA4wnbD0s9+93medRih0dl/X0sOt0Ul+9cD9nO5WvGi
 d2dY8AXicY4T71N3E+OfJzVpTn9NWupAn4xodxqhFjL1s87AHFOxoJgPtUypb0I8ExHf
 JyVScUmFOff7uQlpIvwpwTPCTi9Et61+Jia10Hc2ZDMhJPQxkobi1IY3zdzlXEKlSEW7
 G8dZVaLRygcEKz75aVajgRrIw9Lj3xfZWtaBP2lxgnEklG3NrL9sgdVgXTEqMmJya1G9
 J5KAWm7gVQpLaB1TJW3ojqU7/zHqwhFbDUzluSmD10v2rU+G99jgEflwyN223WAjCrAk
 yKgg==
X-Gm-Message-State: APjAAAXnqHZxzZquQYof51mBR7wW3twDp6qIBycuzlbHy/tkiBtlS7oB
 jBbrZ++u2ytpeh3vgaN8LmLozQ==
X-Google-Smtp-Source: APXvYqzL5EepZKb2+A2YYesq0rsqZIDxS0TYcqsf7QI0BSxh574y21vWdlBH8yPx6SZ10KY45QMdGQ==
X-Received: by 2002:a5d:4949:: with SMTP id r9mr4127486wrs.289.1565090819729; 
 Tue, 06 Aug 2019 04:26:59 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id y6sm72071586wrp.12.2019.08.06.04.26.58
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 06 Aug 2019 04:26:59 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A7A081FF87;
 Tue,  6 Aug 2019 12:26:58 +0100 (BST)
References: <20190805190901.14072-1-ramiro.polla@gmail.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ramiro Polla <ramiro.polla@gmail.com>
In-reply-to: <20190805190901.14072-1-ramiro.polla@gmail.com>
Date: Tue, 06 Aug 2019 12:26:58 +0100
Message-ID: <87wofqilfh.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH] gdbstub: Fix handling of '!' packet with
 new infra
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
Cc: philmd@redhat.com, qemu-devel@nongnu.org, arilou@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Ramiro Polla <ramiro.polla@gmail.com> writes:

> Since the '!' packet is not handled by the new infrastructure,
> gdb_handle_packet() would call run_cmd_parser() with a NULL cmd_parser
> value, which would lead to an unsupported packet ("$#00") being sent,
> which could confuse the gdb client.
>
> This also has a side-effect of speeding up the initial connection with
> gdb.
>
> Fixes: 3e2c12615b52 ("gdbstub: Implement deatch (D pkt) with new infra")
> Signed-off-by: Ramiro Polla <ramiro.polla@gmail.com>

Queued to gdbstub/next, thanks.

> ---
>  gdbstub.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index b470aec8ea..d051344488 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -2587,7 +2587,9 @@ static int gdb_handle_packet(GDBState *s, const cha=
r *line_buf)
>          break;
>      }
>
> -    run_cmd_parser(s, line_buf, cmd_parser);
> +    if (cmd_parser) {
> +        run_cmd_parser(s, line_buf, cmd_parser);
> +    }
>
>      return RS_IDLE;
>  }


--
Alex Benn=C3=A9e

