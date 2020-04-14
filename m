Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C705C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 10:54:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25A8C2072D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 10:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rjF9iL7N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25A8C2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOJD9-0001fI-8r
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 06:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50559)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jOJBW-0000Vg-Bi
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 06:52:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jOJBV-0001M1-3M
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 06:52:54 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:33156)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jOJBU-0001LN-Rc
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 06:52:53 -0400
Received: by mail-ot1-x343.google.com with SMTP id 103so12332725otv.0
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 03:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=lDt9VI9Dnd04fVhIefsdFc1sEOdwVd9reAGSIgzTGFs=;
 b=rjF9iL7NYcf7se7p5xDSvfP6y5HKpv6lyjwfcEbb7laurEHMI6FdgcfeGc9AIKqj20
 DWE03Ra6JxIANn0IPKdiQ4xan8oWl1ODZ7FzEl5Fp8oNQj8XCkDtANIVFzLETyKFSM/b
 GP81RFy4/4rDAh3ZFq7i8hOVgGzRVeAn6aJENZEMHo55ZDZvGnpyx4pT1JnTEBifagHB
 YhVITsGjk4bVuu24nAWHVytA8rmj0tYIc53m4XisS9MoVrdnaIUgOeDjrTP2GyACFsPs
 XvoAuiAbcy2XJBfOOGqN0de5T/2LZL44EnN6q34Az+v9PnbuhlIBkbbRb8ZBdkrqOqfg
 8LBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lDt9VI9Dnd04fVhIefsdFc1sEOdwVd9reAGSIgzTGFs=;
 b=Lj2l/YwW0QpiW4uldYblm3+kkyqoFFb25CeqivpokHT4HWHuxWJtbVOU2TuXXKKYSE
 wrygNlPdnZtg9Pe7iZO21GNSr9x3vEdWtr/GhI1xXzOhcXL6GDuyh0BdzGP5VZWOUJaN
 s/VAOSqUEGh/DnuGm5tVs/LBYtvjUs+X0ZR4FBxE2iqprjWcxv8Kbv+s1NnULdWDJLWF
 /9Wz5mqTskLMhMS76Y1AbjkvEMso3Is/CpBL4GMhwaC53MSrCd5Aioj6a22Ft+I2Lv8Z
 0ota2hpUEU3cFdWatU1vOsEzGoCQqEFOFj6Qz+45Kg3PgqcqN+/xHnQzRl9GQ9ltRRgp
 He5g==
X-Gm-Message-State: AGi0PuZFHLQhD51UPjvycKbu1JjQAnRBtAVjUo5GklRnXPw3KPLWPcc0
 FhJWgc73P3agf/RtGViJFS+A2xseUZvVL0RzqRpBMg==
X-Google-Smtp-Source: APiQypLXe4Ajktdf9jjEoNIdi5D/8XbfVH/mGE4UnxTVzH2tQuVnxda/cJvv+dOxubXnsS1GL35pGfRbAo8Vxn2Qwpc=
X-Received: by 2002:a05:6830:1f39:: with SMTP id
 e25mr18413934oth.135.1586861572085; 
 Tue, 14 Apr 2020 03:52:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200414102427.7459-1-philmd@redhat.com>
In-Reply-To: <20200414102427.7459-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Apr 2020 11:52:41 +0100
Message-ID: <CAFEAcA-PyMisjC25CSGyU5-ASjaAd7gQMabzMCR=uvudSBk-Fw@mail.gmail.com>
Subject: Re: [PATCH-for-5.0] gdbstub: Do not use memset() on GByteArray
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Max Filippov <jcmvbkbc@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 14 Apr 2020 at 11:24, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Introduce gdb_get_zeroes() to fill a GByteArray with zeroes.
>
> Fixes: a010bdbe719 ("extend GByteArray to read register helpers")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  include/exec/gdbstub.h  | 9 +++++++++
>  target/arm/gdbstub.c    | 3 +--
>  target/xtensa/gdbstub.c | 6 ++----
>  3 files changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
> index 30b909ebd2..b52d9933ee 100644
> --- a/include/exec/gdbstub.h
> +++ b/include/exec/gdbstub.h
> @@ -125,6 +125,15 @@ static inline int gdb_get_reg128(GByteArray *buf, ui=
nt64_t val_hi,
>      return 16;
>  }
>
> +static inline int gdb_get_zeroes(GByteArray *array, size_t len)
> +{
> +    for (size_t i =3D 0; i < len; i++) {
> +        gdb_get_reg8(array, '\0');
> +    }
> +
> +    return len;
> +}

The other implementation option here would be

     guint oldlen =3D array->len;
     g_byte_array_set_size(array, oldlen + len);
     memset(array->data + oldlen, 0, len);

For length values < 16 my guess is the perf difference is
not going to be noticeable though.

thanks
-- PMM

