Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E235C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 18:42:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4155225AA
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 18:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yuYkYj7g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4155225AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvPt6-0003ct-RI
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 14:42:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jvPrw-00038q-Eb
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 14:41:32 -0400
Received: from mail-oo1-xc42.google.com ([2607:f8b0:4864:20::c42]:34625)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jvPru-0000CF-Ge
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 14:41:32 -0400
Received: by mail-oo1-xc42.google.com with SMTP id v26so1956158ood.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 11:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=1Ixh3zEGtJqRpOatyPr7j3zH/RqYUdFpRFMtj9RMD5I=;
 b=yuYkYj7g5epdWf+DEgOWavdzVfzjRjn02pDF8wcsrfEuwPXGY//xDjI19ftXo/R/2+
 kuASrdnRlQWhqEAMR15gfAyJ2L3eKy6lHZDVtKXfqbk6VfMyBDBoHs/BlfCgrJ7g4Y/k
 ysy89nRFSpTjTLmN0S00XnI5Jj+h4HV9nLhT0RTretjXOTDDlJrNEd93uxUyfL72ixG9
 KMaFBs/YYPVd6aJjydNDHBTLrvbWMzU55aHUnpyfbRBW0MlAMczZu+1bAGSdtdvdiaGk
 9wQ9C5LwrAnRt0/yl1vGOeiwGfzBrzPdDUv5NQ6rhK5xFihMSJS6Vzs1i5mWCIrvPyOw
 PMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=1Ixh3zEGtJqRpOatyPr7j3zH/RqYUdFpRFMtj9RMD5I=;
 b=UWt+8NhGB1UCssj/OWNWPA0xZD7TbAatr4zw77HVsIjFlSUn7QgOJPQymeFQ0ObqWT
 zAiIF1Qusf+SGhqKLE5ctbOwic3tFiJgbVh1V+xigtA7VWpA3YWUyLeEXcxfN182NlfM
 LNE43KQq+Sc562bxUgjkxJyn/XGgA/eQ4e2cSfZDHWH6YCHIEtHtBA+QPYvFlwruiEbz
 svaoYIZ9VHCSR5GUuwhpGq4uUhmbllyiEl2Izl8H77mHVSBJr/XPTzFU4aKzPu2/qP1J
 5AG8YPzAuShHmxk7TziBiKI2ijqX7KuNNUjML9otO7E1CEsY6B/yC2bBgIIZuQj3lLOr
 xhFQ==
X-Gm-Message-State: AOAM531X4pdsoAL+6cIQRMg9Ct86LO7Hl6d3S0Pof9AmYIKHb+sSC2SH
 JH7P9cKc88XX0/ghyUUFQ013cTPSV5+U+Pgf8UerrA==
X-Google-Smtp-Source: ABdhPJxLNcf9tFUPj7JYVMKjk5I1PN9UiQ6p0EXNrQGnrk70WLL4Xkl/WhAWUV7kD1bVJJn/kmbTDNfhMvTUQ/LGK5U=
X-Received: by 2002:a4a:9653:: with SMTP id r19mr5802395ooi.85.1594752089220; 
 Tue, 14 Jul 2020 11:41:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200714164257.23330-1-f4bug@amsat.org>
 <20200714164257.23330-4-f4bug@amsat.org>
In-Reply-To: <20200714164257.23330-4-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Jul 2020 19:41:18 +0100
Message-ID: <CAFEAcA__3FEbNwJ-JS6YMEjqPPoer8ADShN9SkbWBCaRSpYPVg@mail.gmail.com>
Subject: Re: [PATCH-for-5.1 3/4] qemu-common: Document qemu_find_file()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c42;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 Michael Rolnik <mrolnik@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Weil <sw@weilnetz.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 14 Jul 2020 at 17:43, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> Document qemu_find_file(), in particular the returned
> value which must be freed.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  include/qemu-common.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/include/qemu-common.h b/include/qemu-common.h
> index d0142f29ac..d6a08259d3 100644
> --- a/include/qemu-common.h
> +++ b/include/qemu-common.h
> @@ -110,6 +110,20 @@ const char *qemu_get_vm_name(void);
>
>  #define QEMU_FILE_TYPE_BIOS   0
>  #define QEMU_FILE_TYPE_KEYMAP 1
> +/**
> + * qemu_find_file:
> + * @type: QEMU_FILE_TYPE_BIOS (for BIOS, VGA BIOS)
> + *        or QEMU_FILE_TYPE_KEYMAP (for keymaps).
> + * @name: File name
> + *
> + * Search for @name file in the data directories, either configured at
> + * build time (DATADIR) or registered with the -L command line option.
> + *
> + * The caller must use g_free() to free the returned data when it is
> + * no longer required.
> + *
> + * Returns: absolute path to the file or NULL on error.
> + */
>  char *qemu_find_file(int type, const char *name);

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

