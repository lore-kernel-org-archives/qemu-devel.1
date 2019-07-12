Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9B7C742AA
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 05:48:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBE3A21530
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 05:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A5jgbkp0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBE3A21530
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hloQN-0004ou-PP
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 01:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37987)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hloQC-0004Qh-BV
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 01:48:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hloQB-00076v-Do
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 01:48:40 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36443)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hloQB-000766-4M
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 01:48:39 -0400
Received: by mail-wr1-x442.google.com with SMTP id n4so8593506wrs.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 22:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=eijxjCGoAZrOHMeGr9uKvb6mL2DnGlCK93HNEZnPTN8=;
 b=A5jgbkp0y/R2l/ige5+NxPrkchnQ1tPeUilPqgvrak2gjsDMSspOfc2T9bcdJrUnLo
 w8zO5kr0kDItJ0/NCBSbgsHZ6CfJ8gXqoQXveXErMa7Gum2IG35tv+cUCEOyhevQm/Ab
 DoIhTdyDqFuv/JAKhwpFWn6jcaAtnwC0bHCwPe0WCq7enLFclE1kozBoTcczYc0Vd4h1
 wEJzeTVnSLSw/Q+vVgQL4WmLz53XNi+SlIpm3P2pl7GMzGtjmULrpqsN26ty8MOCnc+C
 jb92mbeHBkB9p3SgWgJAU1S5KtMsBuN3I7c3wWzWq8Eg9X8Gm8/zra4weSv/zAmHhmXi
 rX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eijxjCGoAZrOHMeGr9uKvb6mL2DnGlCK93HNEZnPTN8=;
 b=RFzDnKBG67s28+sQXLgsmyOQCjGaHvtZB7rDwcqzaw1+1VaHHQPVMkja3bGAUL1m7U
 m4VwEEjgnl2ZQaOsSRhSrRgf6ngaYjvVKB8DY/vOEyP83RQWjkmZhTJjMqngIIvVF1XI
 zfhfL7bSQOBUOJcgnuNJdpFxbY2YybWjnuff54W8qojJSzYAny+19q+Dj4q/mSWIzr98
 wqprXTfP2Gm/xfuAWvFpe5p9GbtqhZ3djfekIb92jiH3PpwjLWLmBpwiNYejORe2ybJG
 wl4FfGOT50trJD6cW3l6UvRmB8Ya9d+3j+sjyya7IP1OGmfW6ynD6GpqlhcQ4IpkZT6e
 CbFQ==
X-Gm-Message-State: APjAAAXhDn7eWLbd9wz95KTyLO+J+inmu7FmMeNBcAxZEPffii/pybV4
 BKnhywTOBJzL9kDkwS5sdFfGrQ==
X-Google-Smtp-Source: APXvYqzSJdsLCj7E8XM1OepxbudIo8ocZaX9dxV4L12Bzu0s/MPSTmyPnaXwqsmo6YpR0/KkYKKf2Q==
X-Received: by 2002:adf:8bd1:: with SMTP id w17mr9717766wra.50.1562910517692; 
 Thu, 11 Jul 2019 22:48:37 -0700 (PDT)
Received: from [192.168.12.133] (93-46-166-5.ip108.fastwebnet.it.
 [93.46.166.5])
 by smtp.gmail.com with ESMTPSA id i66sm11426730wmi.11.2019.07.11.22.48.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 11 Jul 2019 22:48:37 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
References: <20190711223300.6061-1-jan.bobek@gmail.com>
 <20190711223300.6061-2-jan.bobek@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <bc5b92ff-cc62-103c-7216-ced33bf72114@linaro.org>
Date: Fri, 12 Jul 2019 07:48:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190711223300.6061-2-jan.bobek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [RISU PATCH v3 01/18] risugen_common: add helper
 functions insnv, randint
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/12/19 12:32 AM, Jan Bobek wrote:
> insnv allows emitting variable-length instructions in little-endian or
> big-endian byte order; it subsumes functionality of former insn16()
> and insn32() functions.
> 
> randint can reliably generate signed or unsigned integers of arbitrary
> width.
> 
> Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
> ---
>  risugen_common.pm | 55 +++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 48 insertions(+), 7 deletions(-)
> 
> diff --git a/risugen_common.pm b/risugen_common.pm
> index 71ee996..d63250a 100644
> --- a/risugen_common.pm
> +++ b/risugen_common.pm
> @@ -23,8 +23,9 @@ BEGIN {
>      require Exporter;
>  
>      our @ISA = qw(Exporter);
> -    our @EXPORT = qw(open_bin close_bin set_endian insn32 insn16 $bytecount
> -                   progress_start progress_update progress_end
> +    our @EXPORT = qw(open_bin close_bin set_endian insn32 insn16
> +                   $bytecount insnv randint progress_start
> +                   progress_update progress_end
>                     eval_with_fields is_pow_of_2 sextract ctz
>                     dump_insn_details);
>  }
> @@ -37,7 +38,7 @@ my $bigendian = 0;
>  # (default is little endian, 0).
>  sub set_endian
>  {
> -    $bigendian = @_;
> +    ($bigendian) = @_;
>  }
>  
>  sub open_bin
> @@ -52,18 +53,58 @@ sub close_bin
>      close(BIN) or die "can't close output file: $!";
>  }
>  
> +sub insnv(%)
> +{
> +    my (%args) = @_;
> +
> +    # Default to big-endian order, so that the instruction bytes are
> +    # emitted in the same order as they are written in the
> +    # configuration file.
> +    $args{bigendian} = 1 unless defined $args{bigendian};
> +
> +    for (my $bitcur = 0; $bitcur < $args{width}; $bitcur += 8) {
> +        my $value = $args{value} >> ($args{bigendian}
> +                                     ? $args{width} - $bitcur - 8
> +                                     : $bitcur);
> +
> +        print BIN pack("C", $value & 0xff);
> +        $bytecount += 1;
> +    }

Looks like bytecount is no longer used?

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

