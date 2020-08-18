Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93A1C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 07:20:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85EFD205CB
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 07:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hH1nzDQ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85EFD205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7vuf-0008H3-RD
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 03:20:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k7vu3-0007rf-FK
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 03:19:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48790
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k7vu1-00023K-RB
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 03:19:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597735164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7HmBFJsqb3bc4IdO6cSt/l0uC1jRXFmCuHEz/1m+hYU=;
 b=hH1nzDQ5aFrms5o2lAU/uw7voSTm1qpKzYgsQ5KHAPbwfuAYsBwU5MaTRsx45CThWTu6ZH
 POdnbeUP5gKQBLhhKCfeK83ryYz6xoFd0qmrddt7TUFZCcGL79aw2vRNlsAkzgOhsjKp5y
 Xo5jjkByZIvC9Yl/x8vQTaWHak/qkO0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-_uLKRIQHNe-X2-8hdDOdrw-1; Tue, 18 Aug 2020 03:19:23 -0400
X-MC-Unique: _uLKRIQHNe-X2-8hdDOdrw-1
Received: by mail-wr1-f72.google.com with SMTP id d6so7874016wrv.23
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 00:19:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7HmBFJsqb3bc4IdO6cSt/l0uC1jRXFmCuHEz/1m+hYU=;
 b=hi7aO9sfJC7AVK/fOVgRtVuitpxxtK94Ej3x7+o43kpXhLI4sL8EDmhdOLcP06Cr+N
 Qb5jZmtbmROg8C5utvb9Xv7WxnLPGFfJY6SR/qe6+e8ioN2mf6mQs/h7vj7OHRlCNekg
 ONJjmS5Ih0kjRj0KKZOoZhj6mhY5C3nkFwJU6Uxl7xxSgRaY1ZR8GwxGgGbBn4OEbDwe
 F/kI09PZjDplMP0X9QSDa60llbIlKS5hJdSBIfMYaDlj0x1ZqfKwjzAydRGJO4R+j4sV
 d4jWPSwqaVd/5DZ1uhFz5X6UYHPhZn5BHvE/xUsH69GPSGFyDdXllBF4aZEcyDdg50QE
 76qw==
X-Gm-Message-State: AOAM531X0tQPd+2q7VA30rWA5HcVpQN5oDfE1gGJor6Dx2jo8ccGtTir
 kE5QacW60PKv4ongAeBeqpXsZjBi0pTF7LAT7rP/9hlCVFduuJAwaTxyXOkUQ55XVwVYKrDNdTI
 P6YM+BxuIl2309xU=
X-Received: by 2002:a1c:ed16:: with SMTP id l22mr16832060wmh.80.1597735161836; 
 Tue, 18 Aug 2020 00:19:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdhJlarSBoNnAwM7JLEQoZAVIpKys1e5IKTm+yfaRDXdcqEeRjFwbWWE608s+gHSoLCLGqFQ==
X-Received: by 2002:a1c:ed16:: with SMTP id l22mr16832045wmh.80.1597735161593; 
 Tue, 18 Aug 2020 00:19:21 -0700 (PDT)
Received: from steredhat ([5.180.207.22])
 by smtp.gmail.com with ESMTPSA id k15sm33134677wrp.43.2020.08.18.00.19.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2020 00:19:21 -0700 (PDT)
Date: Tue, 18 Aug 2020 09:19:18 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Yi Li <yili@winhong.com>
Subject: Re: [PATCH] qemu-img: Explicit number replaced by a constant
Message-ID: <20200818071918.vzdhdlndxuviq3ue@steredhat>
References: <20200817110113.1552683-1-yili@winhong.com>
MIME-Version: 1.0
In-Reply-To: <20200817110113.1552683-1-yili@winhong.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: none client-ip=207.211.31.120; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 02:25:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, yilikernel@gmail.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Yi Li,
thanks for this patch! Just a comment below:

On Mon, Aug 17, 2020 at 07:01:13PM +0800, Yi Li wrote:
> Signed-off-by: Yi Li <yili@winhong.com>
> ---
>  qemu-img.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/qemu-img.c b/qemu-img.c
> index 5308773811..a0fbc2757c 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -1181,7 +1181,7 @@ static int64_t find_nonzero(const uint8_t *buf, int64_t n)
>  }
>  
>  /*
> - * Returns true iff the first sector pointed to by 'buf' contains at least
> + * Returns true if the first sector pointed to by 'buf' contains at least

This change seems unrelated, please can you put this in a separate patch?

Thanks,
Stefano

>   * a non-NUL byte.
>   *
>   * 'pnum' is set to the number of sectors (including and immediately following
> @@ -1200,10 +1200,10 @@ static int is_allocated_sectors(const uint8_t *buf, int n, int *pnum,
>          *pnum = 0;
>          return 0;
>      }
> -    is_zero = buffer_is_zero(buf, 512);
> +    is_zero = buffer_is_zero(buf, BDRV_SECTOR_SIZE);
>      for(i = 1; i < n; i++) {
> -        buf += 512;
> -        if (is_zero != buffer_is_zero(buf, 512)) {
> +        buf += BDRV_SECTOR_SIZE;
> +        if (is_zero != buffer_is_zero(buf, BDRV_SECTOR_SIZE)) {
>              break;
>          }
>      }
> @@ -2489,8 +2489,8 @@ static int img_convert(int argc, char **argv)
>              }
>          }
>  
> -        qemu_opt_set_number(opts, BLOCK_OPT_SIZE, s.total_sectors * 512,
> -                            &error_abort);
> +        qemu_opt_set_number(opts, BLOCK_OPT_SIZE,
> +                            s.total_sectors * BDRV_SECTOR_SIZE, &error_abort);
>          ret = add_old_style_options(out_fmt, opts, out_baseimg, NULL);
>          if (ret < 0) {
>              goto out;
> -- 
> 2.25.3
> 
> 
> 
> 


