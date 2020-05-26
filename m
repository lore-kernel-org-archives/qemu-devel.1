Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99608C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 11:24:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63FD92053B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 11:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cdT9P8A4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63FD92053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdXha-0006Wc-Kc
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 07:24:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jdXgx-0005ea-2G
 for qemu-devel@nongnu.org; Tue, 26 May 2020 07:24:19 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:32984)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jdXgw-0008Ag-1v
 for qemu-devel@nongnu.org; Tue, 26 May 2020 07:24:18 -0400
Received: by mail-wr1-x441.google.com with SMTP id l11so20069599wru.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 04:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=G1tz3H9UslIN2vQOfqTcLPHXOJKJxfi+kMIxCToJtc8=;
 b=cdT9P8A471h1MHWwPMVhfvGYxrfUVftwvkG136QyWEYYVU609TVRxP/q+CCdXqRAcM
 8L4Kzepcytna3WGk7lQG1oQfRzxOzl9JCIi0tRjOohJtLL54/J+mH+1A44uBKispX866
 t52H8ZzvLtAruwWFp1fLtCZh3CSKEH8HN9atw/+alFOOlWoXCye4EW5ThxdZ0sVQfvzg
 XKUxe0WOZJzP7ptDS8K4lK7XqpkOnn5GzfWx7gYyzOBpfNr/VkfgvYOMY/tpbChe6mUZ
 Zn0JRJWCimLQaDUnw6ARgAGTAgYY9Onr5vuwFoVAWayoRjMAFz4xMu7XKDnt16G9bZ9H
 OgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=G1tz3H9UslIN2vQOfqTcLPHXOJKJxfi+kMIxCToJtc8=;
 b=dPOAoh7r0kBNjO3Qz9rsLqonPTMSFS2yEB2oKHDGD3ZCc7Oo3wa63H6DXp7uQPcuTT
 f9kcZtIoW9XZbVUgJhgN0c2/G+zuRm/cGH5QHqrNB9L+J0lPtmNKW+dEbUDjWpbSwHc4
 sQeb439Otu9AS4Q6Bv/wwGjG2GjaUAM3X7dnHpJw0nJh4Rf5/41atb2sIWZLqlrd34SS
 OMAfMrnEt2oEu4MI+odMD2ZMyLdFveWPQuq/dt43ZuBTS+8fyLzA0O8fXB/VYBj+nGSh
 5MpvhAtAxuWJRTDuAgHNOsj6ia0iwfVNQCu93IK0bmfCFdIZFtloZEgoSgzphw9UtP5l
 kibw==
X-Gm-Message-State: AOAM5339avVcHAX01j5qnXs7QjaK/04RKG/OXSW7Z3mXLJJIOjT7IHdF
 2CeYBoCsWsq2nVKDEbqqyLxiloeG1T0=
X-Google-Smtp-Source: ABdhPJxgODwEGVQeJTO4Wf8s8RPnX2Pqnlg5t1hzR0oymHYbkZpkhT8mMida+TMf0Vwa5WdHukQTZw==
X-Received: by 2002:a5d:4f0d:: with SMTP id c13mr20839313wru.357.1590492255978; 
 Tue, 26 May 2020 04:24:15 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p23sm21078595wma.17.2020.05.26.04.24.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2020 04:24:14 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5A3BD1FF7E;
 Tue, 26 May 2020 12:24:13 +0100 (BST)
References: <20200524202427.951784-1-cota@braap.org>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Emilio G. Cota" <cota@braap.org>
Subject: Re: [PATCH] qemu-plugin.h: add missing include <stddef.h> to define
 size_t
In-reply-to: <20200524202427.951784-1-cota@braap.org>
Date: Tue, 26 May 2020 12:24:13 +0100
Message-ID: <87imgj6isi.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Emilio G. Cota <cota@braap.org> writes:

> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  include/qemu/qemu-plugin.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> index 89ed579f55..bab8b0d4b3 100644
> --- a/include/qemu/qemu-plugin.h
> +++ b/include/qemu/qemu-plugin.h
> @@ -12,6 +12,7 @@
>=20=20
>  #include <inttypes.h>
>  #include <stdbool.h>
> +#include <stddef.h>
>=20=20
>  /*
>   * For best performance, build the plugin with -fvisibility=3Dhidden so =
that

Queued to plugins/next, thanks.

--=20
Alex Benn=C3=A9e

