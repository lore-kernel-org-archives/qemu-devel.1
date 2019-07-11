Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82DFC74A35
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 12:36:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 924EA20872
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 12:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AxWCHygY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 924EA20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlYJ9-00034r-TL
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 08:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55233)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hlYIZ-0002Ub-U3
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 08:35:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hlYIX-00008s-TE
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 08:35:43 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:37968)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hlYIW-00005s-Fn
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 08:35:41 -0400
Received: by mail-ot1-x336.google.com with SMTP id d17so5666786oth.5
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 05:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=gEBTSBvz5C6KKB3pE4TPeCXPwMHB8zHZ/GYxl/u1Yew=;
 b=AxWCHygYr/HBsZUX882tdqSui/ww6tBr+Ugn6pBEupadr1JYcbBVKm32ETYSeiGsr/
 KRyy7BYZ2i6ywXvbG9F21AipPJQ1jPi+5iojEf4MT6vRCu7KBP7W1l0vT2e/YgLYiSZJ
 ZGrhC0KZhCrtnyKkVvRVKHUS14Od8GB9P1PYtTpODxldO5kkNFZ/xRoswW1PZVoY0E9F
 DCrbdNE20HqJaMJlMjN991FDNRZgLzQmUayZHvCORyil70EycgMn5Rckv8vmmLRvtxEo
 Db0nukNXzV9Ccdbks6mejGbScs1S8vnNCSQ+cKjY31tb7XTxyfbaj9Cd0ZSZzCPQ4YSU
 7x+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=gEBTSBvz5C6KKB3pE4TPeCXPwMHB8zHZ/GYxl/u1Yew=;
 b=C4op8fZyLEP7olnoKl1LWx2LRLli7Fa9HOqnU2R9zU+MVu/XqArNzxYKvOH5SXJth5
 hJ8v3fUhP06V3Dbk2E0ClKV3Q4ciRB28yfnGiJo9bz2nndrwsbI4fbl91YzURLhgKyOZ
 r1CL4N67vZkuExUvEj9ta1sxTp7Zo4qQ850XdCWG4zr/YHNsD0pIhKuKYI9zQ5Mso4Pw
 QOds3RgDLkjvJW/q1830njeAiajDVHOkJKYDszUvOfQOhR+Ekone+d1iNEkzs6guvQSl
 ZPyGWo42URbsHOs1QMANRTDGfwOae0BgsIugeYtvh+mIqAgH1ZEqivEt2Rry+fS9iAWk
 Ym8g==
X-Gm-Message-State: APjAAAUJ3yRW2Ff8kFK9PMzN1VgZLkf0Ccksnpf4XAoKm2/4I6url3Sf
 Ft1Jcv6C0CpI9lxnLfx08vLZ0G8Fyd3QOVpaYAAO1w==
X-Google-Smtp-Source: APXvYqwwmbSLIywyz5NKSOYzp9cm9cyTuZ/1KjQbJv1KKK44mDvDZSjgdCFs8vCC6fJRUF3WH0i6QiSQLGXAFKtujBs=
X-Received: by 2002:a9d:711e:: with SMTP id n30mr3000615otj.97.1562848539184; 
 Thu, 11 Jul 2019 05:35:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190702005912.15905-1-philmd@redhat.com>
 <20190702005912.15905-25-philmd@redhat.com>
In-Reply-To: <20190702005912.15905-25-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jul 2019 13:35:28 +0100
Message-ID: <CAFEAcA9zUUjvfsmswwnTaKEp+NbB3u+zohD9cH8hufbZLRqGWQ@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::336
Subject: Re: [Qemu-devel] [PULL 24/27] hw/block/pflash_cfi02: Implement
 erase suspend/resume
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Stephen Checkoway <stephen.checkoway@oberlin.edu>,
 Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2 Jul 2019 at 04:29, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
>
> During a sector erase (but not a chip erase), the embeded erase program
> can be suspended. Once suspended, the sectors not selected for erasure
> may be read and programmed. Autoselect mode is allowed during erase
> suspend mode. Presumably, CFI queries are similarly allowed so this
> commit allows them as well.
>
> Since guest firmware can use status bits DQ7, DQ6, DQ3, and DQ2 to
> determine the current state of sector erasure, these bits are properly
> implemented.
>
> @@ -305,13 +364,16 @@ static uint64_t pflash_read(void *opaque, hwaddr of=
fset, unsigned int width)
>          }
>          DPRINTF("%s: ID " TARGET_FMT_plx " %" PRIx64 "\n", __func__, bof=
f, ret);
>          break;
> -    case 0xA0:
>      case 0x10:
>      case 0x30:
> +        /* Toggle bit 2 during erase, but not program. */
> +        toggle_dq2(pfl);
> +    case 0xA0:
> +        /* Toggle bit 6 */
> +        toggle_dq6(pfl);
>          /* Status register read */
>          ret =3D pfl->status;
>          DPRINTF("%s: status %" PRIx64 "\n", __func__, ret);
> -        toggle_dq6(pfl);
>          break;
>      case 0x98:
>          /* CFI query mode */

Hi; Coverity (CID 1403012) flags up the case 0x30 as an implicit
fallthrough. Should it have an explicit "break" or a "/* fall through */"
comment?

thanks
-- PMM

