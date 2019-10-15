Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C0AC10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 04:20:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7330520872
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 04:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqVXOu0k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7330520872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKEJq-0002mJ-Id
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 00:20:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58465)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrew.smirnov@gmail.com>) id 1iKEIm-0002EI-BC
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 00:19:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrew.smirnov@gmail.com>) id 1iKEIl-0006xe-7r
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 00:19:16 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:42958)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <andrew.smirnov@gmail.com>)
 id 1iKEIk-0006xJ-TR
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 00:19:15 -0400
Received: by mail-io1-xd43.google.com with SMTP id n197so42799871iod.9
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 21:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=yZXAfSVvh7J8NtfAlypGQndRUapO18VXzlUge5o0PYs=;
 b=KqVXOu0kJ0eYOr3W7+pgWdFzKw/XQ8aW5B+0wv5HONtOLFEedFSTlIdl6JmYCBuwvC
 bMJ20NlKj6zOtvb4tp2g7cHxiiWnskZQ34zTTHmtfBNTrhka+7bz9my+UkyTmUa5bWnd
 hzugQPehlNOxEzYYqiCZnRZQf26dqBUA3ZcvR7lr7ozdoclt99NdZGy0qHDc41wsMrOB
 gcuZQTPZjZM14Lwt2EjI/Xi/w/t2ZwaUWK+oEdmMWdMwdUYdgs52352B/G910U8HqsND
 kxLeEbT/EZpZleyt+ZTZdQ3ZEbZ+oc9NzAMi8X24so2LkTZaYRRTfXIFin57RTRbZ0CS
 QHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=yZXAfSVvh7J8NtfAlypGQndRUapO18VXzlUge5o0PYs=;
 b=OEfPtsOu/PBcwKQfnASSVdVLG31XqUKvcxTqNgwv+SAmUlNcjQwZbMB/kQu4JupsSM
 zDQhWRSqaxnNDZWWSgLbIg5bZ2PKVbbsy0DIWAAC76reOJT9uuNaIgxfVOXLgp52axGK
 KO6HnpoGi20rRaLH0ueqgDxswKKuHJ78AM3zIg4xb3CkS81s28Gqw2JM9iT0yp2tS38M
 N4YanjecJJkVI5VqFpuQE8QHaqSf1lxLKPLW086QR5D3n4/UB2UuqF1Gx9nEmvuaSe8h
 /5Zlbm75MQJZLLwop5HhYzjjIXImi9uopanC0a9IUIlxp8Zljok06irqahmznMS8lJFe
 1fMQ==
X-Gm-Message-State: APjAAAUZUeCE7SVeb5wdZc7ippyykqsOuhXYce9JWEHC0UfG8eXvvZ9y
 5pXosowG2gTkkrxBGl1Obl2VfTpJr+K95gvpWQg=
X-Google-Smtp-Source: APXvYqwe216pCOJ3yOsjMPF4yXJF/xAvkSmvp5toqAXI6rmwQjXN++979xWt7p4fNj+UcnTwYSIUSH3Z8V+l3WEVTgw=
X-Received: by 2002:a92:1d5c:: with SMTP id d89mr3888225ild.94.1571113153842; 
 Mon, 14 Oct 2019 21:19:13 -0700 (PDT)
MIME-Version: 1.0
References: <20191014135905.24364-1-alex.bennee@linaro.org>
 <20191014135905.24364-4-alex.bennee@linaro.org>
In-Reply-To: <20191014135905.24364-4-alex.bennee@linaro.org>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Mon, 14 Oct 2019 21:19:01 -0700
Message-ID: <CAHQ1cqETm5UCL76nxLVOG=M7qZTSgo4mGNrzNRdV4RULWjRGzQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/5] contrib/gitdm: add Andrey to the individual group
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, dirty.ice.hu@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 14, 2019 at 6:59 AM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>
> Please confirm this is the correct section for you.
>

I think this is. Here's

Acked-by: Andrey Smirnov <andrew.smirnov@gmail.com>

in case that's needed.

> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  contrib/gitdm/group-map-individuals | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/contrib/gitdm/group-map-individuals b/contrib/gitdm/group-ma=
p-individuals
> index 301071b98b..624e27fc83 100644
> --- a/contrib/gitdm/group-map-individuals
> +++ b/contrib/gitdm/group-map-individuals
> @@ -18,3 +18,4 @@ e.emanuelegiuseppe@gmail.com
>  dirty.ice.hu@gmail.com
>  liq3ea@163.com
>  liq3ea@gmail.com
> +andrew.smirnov@gmail.com
> --
> 2.20.1
>

