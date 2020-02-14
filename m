Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE96C352A3
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 00:51:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EF4D20848
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 00:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3/BC9nP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EF4D20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2PD3-00059M-Mk
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 19:51:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59765)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j2PC3-0004P1-Qj
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 19:50:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j2PC2-000454-Ps
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 19:50:55 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35486)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j2PC2-00044I-Ji
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 19:50:54 -0500
Received: by mail-wm1-x343.google.com with SMTP id b17so8852623wmb.0
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 16:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6Ise6SocA2O+IvBQ8h6eGeVoz+j/zg7AO2g+HTkNjBQ=;
 b=C3/BC9nPNn90ih9yr+xtV6HjIHGK2okTzSQWVpCIc9Xd1K64y3DbVlS2MEdppoWZBh
 57nGwNM5Q8oI9M03Ec4nolXNi1Hra+ETkFSweKGnHLwYF4xr2M+fVqZFIZxms674PdgF
 dB494uw1narEvUsk86Ps0jAouvx7TsoTV01kzDD5JuNGIwGa78Mx/+vdHyaoHP1Eq2q5
 hva7HqhqiHWv9FNJIKbXDWpJ9hVW/RRqR3FRWxoz4DcP+ICyjeVRlgoYMUxrb1oKroD8
 70eRmoyfLTq+2CS8lSqmZiUpMAkAgrdYmwsXE9vnVJbmDfaEarQQethQv+xAKsVX82F9
 uvAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=6Ise6SocA2O+IvBQ8h6eGeVoz+j/zg7AO2g+HTkNjBQ=;
 b=otedeKngI04F1TSuVBPoxzVvMOneKvRXJEWusH2z1Y6Al/qsyWNvYy08IGHHSDmytR
 YnFPotUXmZF/X+7v/F/A3f/IHRZYiraw2ntbJAYEBlzKg72G05HqquUVsmuUKQFVpov4
 G7xOaAQxINyZrjVXR/D5LnDFBgQVx0wAuMIUv5KoDON6SQa1qbsdlClPOGiv2bxd0VzY
 rKGHwjZB91Cf/ERwADiEp/mgBkF16SXp0AiN0H33XTKfjlEgrPQygZKl++dZCehAVPhM
 w6xyc492C41LaW64zdljd8rloRGGyLek5X2y6haW/HeV+zLfjMBZoSZQU/5e9r77kz4i
 ztvw==
X-Gm-Message-State: APjAAAVICN35XN+bKdJ/zRl+BNTU6tKSxSG8AyE/+gutXN5oDFnVyO/e
 myJf4ZQG39DwLvv3PgQe6xY=
X-Google-Smtp-Source: APXvYqyAKIHsujUeZAJXQ+ZsUhZfj7uoSkJ1MQh5nOfeddSUg96HEqVkLysBLN7168Moei2jsVQ7wQ==
X-Received: by 2002:a1c:4c8:: with SMTP id 191mr825477wme.148.1581641453713;
 Thu, 13 Feb 2020 16:50:53 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id w19sm4965256wmc.22.2020.02.13.16.50.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2020 16:50:53 -0800 (PST)
Subject: Re: [PATCH v2 16/19] tests/tcg: give debug builds a little bit longer
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200213225109.13120-1-alex.bennee@linaro.org>
 <20200213225109.13120-17-alex.bennee@linaro.org>
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
Message-ID: <9583439c-0608-2729-e942-c9ee8a788253@amsat.org>
Date: Fri, 14 Feb 2020 01:50:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200213225109.13120-17-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
 pbonzini@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, robhenry@microsoft.com,
 marcandre.lureau@redhat.com, aaron@os.amperecomputing.com, cota@braap.org,
 stefanha@redhat.com, kuhn.chenqun@huawei.com, peter.puhov@linaro.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/13/20 11:51 PM, Alex Bennée wrote:
> When combined with heavy plugins we occasionally hit the timeouts.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/tcg/Makefile.target | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
> index 3c7421a356e..b3cff3cad1a 100644
> --- a/tests/tcg/Makefile.target
> +++ b/tests/tcg/Makefile.target
> @@ -79,7 +79,7 @@ QEMU_OPTS=
>  
>  # If TCG debugging is enabled things are a lot slower
>  ifeq ($(CONFIG_DEBUG_TCG),y)
> -TIMEOUT=45
> +TIMEOUT=60
>  else
>  TIMEOUT=15
>  endif
> @@ -137,7 +137,7 @@ PLUGINS=$(notdir $(wildcard $(PLUGIN_DIR)/*.so))
>  $(foreach p,$(PLUGINS), \
>  	$(foreach t,$(TESTS),\
>  		$(eval run-plugin-$(t)-with-$(p): $t $p) \
> -		$(eval run-plugin-$(t)-with-$(p): TIMEOUT=30) \
> +		$(eval run-plugin-$(t)-with-$(p): TIMEOUT=60) \
>  		$(eval RUN_TESTS+=run-plugin-$(t)-with-$(p))))
>  endif
>  
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

