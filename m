Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB92BC76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 11:47:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B77CE20873
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 11:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RGpPrTGr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B77CE20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoRMQ-000150-TH
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 07:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41616)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hoRME-0000aB-LJ
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 07:47:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hoRMC-00023c-EG
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 07:47:26 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a]:36333)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hoRMA-00021a-Ns
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 07:47:22 -0400
Received: by mail-ot1-x32a.google.com with SMTP id r6so32445577oti.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 04:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=z4iPOBzFhMTUPZoHyJ55VwwkuY8lGjxWl84caEjm7i0=;
 b=RGpPrTGrEXUHccK/w5sLwXWCwQ8BMpD0cwlhrg203G521YBccl9PiaxlfAj6pFFT9o
 tWJEsBaBOhLzum2Az0T2NVpwPyepuTAUr2iDOJrsLNqSz+sU3MY3mp6l1GnV9zdDHRvi
 XHi8v0kvZwChVzXO4UYpfA0R0D/WIu4/hyzaijYhksr+FtGNAJAH2HpKxzI2IJjW991Q
 jiNXQWGfxDWIPyXbUJMqaTwkYSVoQnkFGti9h5xNKHOkFZxB3ULgl4jHpzm76li7bQNb
 MPDYt338cGLl1GH84T5EJOY7EblPFqKe8RNLzw2cMgZWUduyUFI6S7uWHNdBt8H3cBxM
 PZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=z4iPOBzFhMTUPZoHyJ55VwwkuY8lGjxWl84caEjm7i0=;
 b=W+ocfPkG1hZWCRWQg00gEO1J8JuysNfm+jH0qi6bMbfT25YQBdb4GNc8Ut572kYA1c
 0pOehtjH4KMGyyYOGAah/OUc+EgS+eD3qZTp8mSpgF6+7qBmgyNBAXhKR5mZHYhyqWcH
 Dzr+yeD7P6w6Bt49cLe+4GjjHAVsP1PF7mV9ZlPvRe3WrZzZWM/j3I9vqts2JDeMfVJX
 KJSDTOMVSLPBWbqkxSZZzkUZeql39tASLp3ph8FFMMnlqJD/34EZVzZcSlN0tj6vMP11
 3yB71wnNlf8YwJxSt+mNBFbNSdziCIvdDv31GoFljgvAl50cS3Oby7kBLslZroyfUpE1
 mj9Q==
X-Gm-Message-State: APjAAAX19sxOxN2W3fc3mjHIqwJqd8iURR1eSaWNVOnTIraU3zXwF03m
 h+/9RUulshJPFPmSl6RG3qzxz1M2k/n2h4Iw4NFiWQ==
X-Google-Smtp-Source: APXvYqwuDsunn2jbmwPyHgAqu5/6vz6S9Q593Tu67Mb3PCuiojcNchYP7M+yIrT/hrv8+4nIiThycf6l8Cg/02xwvsA=
X-Received: by 2002:a05:6830:1653:: with SMTP id
 h19mr31665938otr.232.1563536840512; 
 Fri, 19 Jul 2019 04:47:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190719111451.12406-1-philmd@redhat.com>
In-Reply-To: <20190719111451.12406-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jul 2019 12:47:09 +0100
Message-ID: <CAFEAcA92mCp6WYb5wVEYbVNEFkPb9TwpedjNwj4SdS9Mb_rNtw@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32a
Subject: Re: [Qemu-devel] [PATCH-for-4.1] target/arm: Add missing break
 statement for Hypervisor Trap Exception
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 19 Jul 2019 at 12:15, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Reported by GCC9 when building with  -Wimplicit-fallthrough=3D2:
>
>   target/arm/helper.c: In function =E2=80=98arm_cpu_do_interrupt_aarch32_=
hyp=E2=80=99:
>   target/arm/helper.c:7958:14: error: this statement may fall through [-W=
error=3Dimplicit-fallthrough=3D]
>    7958 |         addr =3D 0x14;
>         |         ~~~~~^~~~~~
>   target/arm/helper.c:7959:5: note: here
>    7959 |     default:
>         |     ^~~~~~~
>   cc1: all warnings being treated as errors
>
> Fixes: b9bc21ff9f9
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  target/arm/helper.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 20f8728be1..b74c23a9bc 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -7956,6 +7956,7 @@ static void arm_cpu_do_interrupt_aarch32_hyp(CPUSta=
te *cs)
>          break;
>      case EXCP_HYP_TRAP:
>          addr =3D 0x14;
> +        break;
>      default:
>          cpu_abort(cs, "Unhandled exception 0x%x\n", cs->exception_index)=
;
>      }

I think this is right, but EXCP_HYP_TRAP is a bit odd -- we appear
to use this only for the case of "SMC instruction is trapped from
NS EL1 to EL2 by HCR.TSC". I was expecting more traps-to-EL2
to use this EXCP_ variable... Mostly we seem to use EXCP_UDEF,
eg for CP_ACCESS_TRAP_UNCATEGORIZED_EL2 coprocessor/sysreg accesses:
this has the same behaviour as EXCP_HYP_TRAP as long as we know
we are going from an EL below 2 to EL2. Which I think we could
also use in the one place we use EXCP_HYP_TRAP; or we could make
wider use of EXCP_HYP_TRAP, since feeding everything through
EXCP_UDEF is rather confusing.

Anyway, for 4.1 we should do this.
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

