Return-Path: <SRS0=r7Ry=6C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E6FC38A2B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 09:10:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B02BF214D8
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 09:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCd4mHsS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B02BF214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPjUR-00064M-Sv
	for qemu-devel@archiver.kernel.org; Sat, 18 Apr 2020 05:10:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56381)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jPjTL-0005JR-E7
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 05:09:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jPjTK-00037l-69
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 05:09:11 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:44586)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jPjTH-0002vr-KQ; Sat, 18 Apr 2020 05:09:07 -0400
Received: by mail-lf1-x142.google.com with SMTP id 131so3751071lfh.11;
 Sat, 18 Apr 2020 02:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=vqU2Vn5SVF+8iRx+sF+N3oPAm4c/K2xuA7uJzd1IKEg=;
 b=GCd4mHsSFjq6mIGeQpnXBod5ve5mIkn9SRRtO06b20u+fA9+ftbBzuUo7ROHjXmlGu
 UTFFxc2q/DyD004jboEq/a0DxEDF/2HAQW0pyP9A1ojSBAPoSnCGG3F0QF9HxgpC65Jb
 WACUyFP/S0xz5SoySdN0LzzqkYOyIjOcHDiAk3B1u7ZgrM3uuU0ThVSryLY7n7usuZ/n
 EnMK/49AnvwAIGNXHGuFZgsm6OezH+5kKexxI9eXxxdhBszf90YeDrahrBKqxyxNPgv/
 j56sTUFFa8wv7/EKBEys6VhWNQe/0+koGwfBG4i/F1LF7DuoVEHs8P4TXl9HjgIGEMVX
 Kz6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=vqU2Vn5SVF+8iRx+sF+N3oPAm4c/K2xuA7uJzd1IKEg=;
 b=eFVm5xOHGCozzb/oPA20hQnXDLB78GqLNZkIAg6s+sGMtJTDmG3qNajwk0O+bv4IU0
 L8YlvzUE8oHqPxrMhkJcWSeZPbPfYYR8EmgBZvIcWeKgbh1r4JG9PY6M7FWZaVSJ7uhV
 bJwIRH1GNb0AeywZfrDkci8uNHUCnijzVEFXLsVIiyhFzP/LEbRQnea1YXWM1ej8gQNm
 9HfN1Jzm6BbNP+0XqOCHfdcnKocDJgx74sVGh8szEGKMSfENdj6c89kFdtaFWy+kLEqy
 xyW/4VM4iaOGB/5BoPB80n4a9CgbM3CtzafWCgccg1ujLfthKbqRQC51NMpc1Oxjbgz8
 Y9IQ==
X-Gm-Message-State: AGi0Pua6IsaqXKSDpo8LIK4EdadBStLrKPc2u/AaRwFXzRyGESyjlZuU
 O1uhuxNYete43DE+YFaEuwY=
X-Google-Smtp-Source: APiQypIY1b77bL9vzTKhG6N/LJfFio/cSmV9XyeFfR5BGcDRgZXi+zctpQpXMr6AR/oJ8zsLleLvUw==
X-Received: by 2002:ac2:41d9:: with SMTP id d25mr4610725lfi.204.1587200944377; 
 Sat, 18 Apr 2020 02:09:04 -0700 (PDT)
Received: from localhost (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id v64sm9727696lfa.54.2020.04.18.02.09.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Apr 2020 02:09:02 -0700 (PDT)
Date: Sat, 18 Apr 2020 11:10:13 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Ramon Fried <rfried.dev@gmail.com>
Subject: Re: [PATCH resend v2] net: cadence_gem: clear RX control descriptor
Message-ID: <20200418091013.GD2669@toto>
References: <20200418085145.489726-1-rfried.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200418085145.489726-1-rfried.dev@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::142
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
Cc: peter.maydell@linaro.org, jasowang@redhat.com, alistair@alistair23.me,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Apr 18, 2020 at 11:51:45AM +0300, Ramon Fried wrote:
> The RX ring descriptors control field is used for setting
> SOF and EOF (start of frame and end of frame).
> The SOF and EOF weren't cleared from the previous descriptors,
> causing inconsistencies in ring buffer.
> Fix that by clearing the control field of every descriptors we're
> processing.
> 
> Signed-off-by: Ramon Fried <rfried.dev@gmail.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> 
> ---
> v2:
>   * change function name to rx_desc_clear_control as proposed by
>       Jason Wang
>   * Move the function call above the comment, as proposed by
>     Philippe Mathieu-Daudé
> 
>  hw/net/cadence_gem.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index b7b7985bf2..22a0b1b1f9 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -411,6 +411,11 @@ static inline void rx_desc_set_sof(uint32_t *desc)
>      desc[1] |= DESC_1_RX_SOF;
>  }
>  
> +static inline void rx_desc_clear_control(uint32_t *desc)
> +{
> +    desc[1]  = 0;
> +}
> +
>  static inline void rx_desc_set_eof(uint32_t *desc)
>  {
>      desc[1] |= DESC_1_RX_EOF;
> @@ -999,6 +1004,8 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
>          rxbuf_ptr += MIN(bytes_to_copy, rxbufsize);
>          bytes_to_copy -= MIN(bytes_to_copy, rxbufsize);
>  
> +        rx_desc_clear_control(s->rx_desc[q]);
> +
>          /* Update the descriptor.  */
>          if (first_desc) {
>              rx_desc_set_sof(s->rx_desc[q]);
> -- 
> 2.26.0
> 

