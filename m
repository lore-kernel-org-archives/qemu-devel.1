Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276C1C352A3
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 00:50:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E42102082F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 00:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qMoLE8QR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E42102082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2PC6-0004H0-4S
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 19:50:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59398)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j2PBR-0003lw-Tk
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 19:50:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j2PBQ-0003NM-VK
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 19:50:17 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35515)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j2PBQ-0003MI-P1
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 19:50:16 -0500
Received: by mail-wr1-x442.google.com with SMTP id w12so8989274wrt.2
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 16:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NtKqjT6aSvp5kCi6tCkHXRL2gVoMNRFQWvPQOKWzEdw=;
 b=qMoLE8QRSCKYyEPBGOpHhoHIihiE2SRVkBKNa23npcIP4p9NoNNSAFnQ1wKIjJhul2
 dc78BqbgbgL5uh3Z7pHhxswFzLB7s1bL9h0mJFuoMPgphGxwvBCeWo2mOz1EBO8gcSIS
 fVvU3YH/L6JXguoFgJzKKn+8sJcV38TbNvRyKN0QHyY2WXmG7ukcrKjth1PAOxtVHG2G
 AFbEmcxJwgJcvlO/corrx5sIrpZne3J0qGak4kg0VkDfYtAlYv+3D8qsvyNw+zG64gPI
 zChUhwi366RSmKTqxFQw7W20ZJqv9pVNIMrhb6Giw9C3bC9IwnNBdymhFAbaGH84tWM0
 SSkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=NtKqjT6aSvp5kCi6tCkHXRL2gVoMNRFQWvPQOKWzEdw=;
 b=pgBOUJBfbK+HbOPSEEztkISWW6/9BUbu878RtltVZXKitYTsaIg+8hIsG1a2er4IHv
 1UzL548bAMlLEI+L4j3ufu63cY4y4V76+jFmIXrFsrFYX7F3fMAGufMCBCtEes1YK6Dr
 XeMwy6gkvkuU81CMQVI3au9DYGAXiwTM09HfVYF3vWDV5NZrCmr0loaSBlO+2erGXaPI
 9IAMGCtkTdSCeik/0GWdyZ1r5U20aZ6O8H5XqNH3Igh/J4YVFqRzRT78n19Hu8mfOSTd
 wgFe6xnepdFBdcqJBlNWdthHf3Jnuvh0PNGgvf33OFF1dF1e+p1KF3O+4FeLJTmziEUH
 qBew==
X-Gm-Message-State: APjAAAWC4RuJfIbuHMHhRGQJ7E48GxrNXIVLvSXQm+euv9N8y4L09ioW
 bhH71aGYopXjnD+nzbJrtXU=
X-Google-Smtp-Source: APXvYqyRQ4dNKi+omsrTQxYN3C0b9g0uo9hSP+oTrs0EQYf4VQqdTwdrscJGc2pMKzLwQ8ljLswhqA==
X-Received: by 2002:adf:fe50:: with SMTP id m16mr233983wrs.217.1581641415659; 
 Thu, 13 Feb 2020 16:50:15 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id t128sm5378658wmf.28.2020.02.13.16.50.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2020 16:50:14 -0800 (PST)
Subject: Re: [PATCH v2 18/19] tests/tcg: fix typo in configure.sh test for v8.3
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200213225109.13120-1-alex.bennee@linaro.org>
 <20200213225109.13120-19-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <ecb02b32-57df-a05f-2a3e-be858228f2ed@amsat.org>
Date: Fri, 14 Feb 2020 01:50:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200213225109.13120-19-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 pbonzini@redhat.com, stefanb@linux.vnet.ibm.com, richard.henderson@linaro.org,
 robhenry@microsoft.com, marcandre.lureau@redhat.com,
 aaron@os.amperecomputing.com, cota@braap.org, stefanha@redhat.com,
 kuhn.chenqun@huawei.com, peter.puhov@linaro.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/13/20 11:51 PM, Alex Bennée wrote:
> Although most people use the docker images this can trip up on
> developer systems with actual valid cross-compilers!
> 

Oops =)

Fixes: bb516dfc5b3
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/tcg/configure.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/tcg/configure.sh b/tests/tcg/configure.sh
> index 9eb6ba3b7ea..eaaaff6233a 100755
> --- a/tests/tcg/configure.sh
> +++ b/tests/tcg/configure.sh
> @@ -228,7 +228,7 @@ for target in $target_list; do
>                  echo "CROSS_CC_HAS_SVE=y" >> $config_target_mak
>              fi
>              if do_compiler "$target_compiler" $target_compiler_cflags \
> -               -march=-march=armv8.3-a -o $TMPE $TMPC; then
> +               -march=armv8.3-a -o $TMPE $TMPC; then
>                  echo "CROSS_CC_HAS_ARMV8_3=y" >> $config_target_mak
>              fi
>          ;;
> 

