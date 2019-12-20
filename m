Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1711EC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 17:44:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7176206EF
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 17:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nBEIvwSe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7176206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiMK8-0006Ye-21
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 12:44:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38240)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iiMJ2-0005gd-QY
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 12:43:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iiMJ1-0004UX-Nb
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 12:43:16 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36719)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iiMJ1-0004TG-HI
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 12:43:15 -0500
Received: by mail-wm1-x341.google.com with SMTP id p17so10087117wma.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 09:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=la/uZZ/pGKB8CVPfJKAbIpJ/lhDkVkHLZj4pQdlHYAs=;
 b=nBEIvwSeSB0GQbm4xRI9B9polb0cIUfsgW30G8o3xrO7LV/ZJc9FcooOFIP3Y58pC6
 E3OUorcvPwLf8ivPuO46u0b0UpYhNfINw7ReqMjWVL7f3nh2tU8qo8C/PzEdExoIgEEl
 EuVjoWDhZWeTptdFvsAnzx8suOsnwckJ0LZg+mR3uhC2N25yMcFzxNongd3OIfflDHxw
 jYlFFIFJH++1QOOXiasTpZ2s0ws0/8j+Z22aggjtjQFUmri4kSsnQANWiWss3I23WtpK
 qwg8jYpeKYgHujRuFud4MYyjzG1lsqG69LRCryU4ZT0GAFEBdAEBM/s+UHvgoVYb5OHc
 aJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=la/uZZ/pGKB8CVPfJKAbIpJ/lhDkVkHLZj4pQdlHYAs=;
 b=sB7yKwTd6AmhwlznGhfAlaqLLAHKORBX5nyXZ5qvGF2nuDxUK9gZqDhpyagjnrDA76
 5vr0G0132ER/okUB/nXKnK12owcmQg1wwiqOONNg5PzLQlgUVqmBv4r/QPIp71OttYXo
 lmKHCycL2FJ76VAWyxi/DmvcY7ylLxlmko1iu4dYnGX8d02cySYBrsHjo9kPNYaQb9V6
 4Mo+UhExVAfUI3hUn2OcswhiqEupzKjxc3cPQNmySM6lHJjXawfB21lNsXhIef9GsotB
 +3ubUqHXM+k6ddywbGQgqKTOs2UZmUCa65Sx1E8X9MEYm4w82D/XhHZ2H01Xmh4tY7qj
 miew==
X-Gm-Message-State: APjAAAW4lov079c7gMjixURp7hjKA5DXOByaM2+BmZNLXaI0hQvKNN0h
 r00ib/iaLC3z8vJJwc5sQ6tDOWMhldI=
X-Google-Smtp-Source: APXvYqxTuztkhsQ09NZB7gkuYayDq+U8l0HX/HROJDFyD6cGI0Hcmiu5dBAhPXOYlQvUem4l9ZpxfA==
X-Received: by 2002:a7b:c389:: with SMTP id s9mr17788200wmj.7.1576863793819;
 Fri, 20 Dec 2019 09:43:13 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k11sm10336168wmc.20.2019.12.20.09.43.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 09:43:12 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E06461FF87;
 Fri, 20 Dec 2019 17:43:11 +0000 (GMT)
References: <20191216221158.29572-1-richard.henderson@linaro.org>
 <20191216221158.29572-10-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 09/28] target/s390x: Include tcg.h in mem_helper.c
In-reply-to: <20191216221158.29572-10-richard.henderson@linaro.org>
Date: Fri, 20 Dec 2019 17:43:11 +0000
Message-ID: <87lfr6dhao.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Code movement in an upcoming patch will show that this file
> was implicitly depending on tcg.h being included indirectly.
>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/s390x/mem_helper.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
> index 2325767f17..57ce17c252 100644
> --- a/target/s390x/mem_helper.c
> +++ b/target/s390x/mem_helper.c
> @@ -27,6 +27,7 @@
>  #include "exec/cpu_ldst.h"
>  #include "qemu/int128.h"
>  #include "qemu/atomic128.h"
> +#include "tcg.h"
>=20=20
>  #if !defined(CONFIG_USER_ONLY)
>  #include "hw/s390x/storage-keys.h"


--=20
Alex Benn=C3=A9e

