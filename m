Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC14C3A59B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 15:13:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4396C23405
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 15:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iB70I3rN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4396C23405
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3ib6-000080-7d
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 11:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51130)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i3iYX-0007pk-F2
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 11:11:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i3iYT-0003t4-4K
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 11:11:16 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55987)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i3iYL-0003eM-J4
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 11:11:07 -0400
Received: by mail-wm1-x341.google.com with SMTP id g207so3742197wmg.5
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2019 08:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=KVC/hb7g6XiKc2dH7ZBAp5SBOk4q6ThVkUo4iRKxflo=;
 b=iB70I3rNg8EoSo3qyPucfWG7xyDuYcf+/em5PVeZK+QaCnCQUph33AEM+1rr/kLhvi
 /GZzMFNlstz5NETzLPS8ZEFVF+XVDLmezEXQ9nPU0JJ7HL/4abKluhJ+f8UsFL38yEFF
 ju76K98YOxcYDfiQlSkMbJmCjpKru++9LgAWFHjY6xiFqnMH4KK875WLC7ZtPXVbuehW
 aPmLYZm+J0BsYEzlLUtmu76EIQTb7JHx7fb0bLZFxaZysmYjyNG5sD7NNd2jMeedLdyH
 vhD94NdCVdAImmyh4+/dYd2G1gH74ve+oZL5XBISMre1ycEC3ijj6/5TCZeD7P4dlue1
 uVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=KVC/hb7g6XiKc2dH7ZBAp5SBOk4q6ThVkUo4iRKxflo=;
 b=WVAHL867mhkSYB0PAmCYeNblJWoL83ivyqnD0OKnRjEZXL6FOUZwH9ZJm0zUG6w0TJ
 TyBwrILQ7D+6yJrTuh7Bz3GVqeRyL//ajcEA3wL697zldjkuOoy4VHkWb8Vd2kEwc9km
 kWhrFrXeA5kutvQkfU+jOezibYuNmItKzqNWrcgiJUO0tnBY7oj+Ki4ssvZv/lOWDNpT
 XkD/IVMsqjpXmgU3OcApJQEabHJgneBio7dpk/ezCyRDGd2v1rjYVNps0whPyvbpfqeB
 c6SVm+rOUrnj8dpD3W9UrZpCgOchk0piWg68JvXmdn9pyZERWVikePbHQ2GS43BtJr63
 3Jkg==
X-Gm-Message-State: APjAAAUHz8Thi4lAjiNk/tl85PafZdLoRnZqapr1iU2ranlGT7eb6LFg
 OvFIfpKIKuIvGs9KVvRGTTmHyQ==
X-Google-Smtp-Source: APXvYqylU5QaHAqZp3WlGPetTjnqiNzJGbbCJYXVGuqIknyI3wh1KRp/M2U+ZCZ4CZ9BDCVRNt3DAA==
X-Received: by 2002:a1c:cf4e:: with SMTP id f75mr11440827wmg.49.1567177862147; 
 Fri, 30 Aug 2019 08:11:02 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e6sm5936313wrw.35.2019.08.30.08.11.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2019 08:11:01 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BA5351FF87;
 Fri, 30 Aug 2019 16:11:00 +0100 (BST)
References: <20190829173437.5926-1-vandersonmr2@gmail.com>
 <20190829173437.5926-8-vandersonmr2@gmail.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190829173437.5926-8-vandersonmr2@gmail.com>
Date: Fri, 30 Aug 2019 16:11:00 +0100
Message-ID: <87tv9y7kor.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v8 07/11] monitor: adding tb_stats hmp
 command
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 vandersonmr <vandersonmr2@gmail.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


vandersonmr <vandersonmr2@gmail.com> writes:

> Adding tb_stats [start|pause|stop|filter] command to hmp.
> This allows controlling the collection of statistics.
> It is also possible to set the level of collection:
> all, jit, or exec.
>
> tb_stats filter allow to only collect statistics for the TB
> in the last_search list.
>
> The goal of this command is to allow the dynamic exploration
> of the TCG behavior and quality. Therefore, for now, a
> corresponding QMP command is not worthwhile.
>
> Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
<snip>
> index 4203cc728c..dcb30eea8a 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1796,11 +1796,17 @@ static bool main_loop_should_exit(void)
>
>  static void main_loop(void)
>  {
> +#ifdef CONFIG_TCG
>      uint64_t ti;
> +#endif
>      while (!main_loop_should_exit()) {
> +#ifdef CONFIG_TCG
>          ti =3D profile_getclock();
> +#endif
>          main_loop_wait(false);
> +#ifdef CONFIG_TCG
>          dev_time +=3D profile_getclock() - ti;
> +#endif

Shouldn't this have been s/CONFIG_PROFILER/CONFIG_TCG/ in the last
patch? Otherwise we might have a broken build half way through.

TBH I'm not even sure what dev_time is meant to represent. As we spend
all our time in the main_loop until we quit is seems to be more a less
wall clock time.


>      }
>  }


--
Alex Benn=C3=A9e

