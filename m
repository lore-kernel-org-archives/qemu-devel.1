Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8868C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 10:18:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BD52206B6
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 10:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMovLMUw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BD52206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT0qn-00025D-Oc
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 06:18:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41432)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jT0pO-00018I-Ch
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 06:17:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jT0pN-0001mK-W3
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 06:17:30 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44189)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jT0pH-0001Ax-A8; Mon, 27 Apr 2020 06:17:23 -0400
Received: by mail-wr1-x443.google.com with SMTP id d17so19857291wrg.11;
 Mon, 27 Apr 2020 03:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yxwzn8F5oHtItWkeR1/MbHSJihRf/baZIBBiplF6lsg=;
 b=NMovLMUwfO31whS2CE202jpOPT0TO/s5YwSsABm7XY29BP/i9G9w4CW07W/QGZap2R
 DFCEpe3q+DgxCXFwL6RW/AQcUF1NVnlXeHc9h/OMVGrbPy1ktDm5OxghQ2mlq5iZHj+E
 0IseGg04VK2GJhFilMCxErx2eYHnfKpT9MN4KQ2rqXFOFMQZAVM2D0FJ7VDyhBCrYo51
 1Ogar0ao/3k9m8zxU3TVy5ODL3CZQyjkdbd+1HZi2tJWExxNDzPmgA7B1BLyhQjeRN8W
 xIWADfv2OHXURTy3frJWtpvbXUcsMJmKo0iT5vwedvF2e1zMhqEDElc2/tPvgPOJIqlF
 4P+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=yxwzn8F5oHtItWkeR1/MbHSJihRf/baZIBBiplF6lsg=;
 b=ZqSVY670uJZnQjXK9YVeMLG/moon88cX55I8BFr7AbpaLX4JH1tMryInrN5xn/Ln6K
 HXTdr7MkNYGSbQC0jDBHmzR126EbnDFtbJhcADxoenbtIXH1w6hU3fNp42p6LTo5lNNO
 tpCDogeXgArzhU5yiJs+tGvIeqFay+Ly5DkjHeussZTtbeq3U0fEl7hCtsoK8G4LVTlN
 0avsLBepN7Fl2Fn4uLdlCjc1JQJiSZMmZOkz3j78mpUOeVbNIuom1XnYPlDSwhl6LufI
 +WQFhvwzW/WjUtGyBmTfDBx1gXzgAJCNGF6Oej9UGcE+b5kTUwZpryEJQ+o6Fq3pmJEn
 REMg==
X-Gm-Message-State: AGi0PuYD+l6s4zZ4dcmviGwI5ICS9HoGzKIJL8Cj/lXA6ZgL0kxNpIO+
 DGhHrLlk5CshyECI15MS+5Ec/JLf
X-Google-Smtp-Source: APiQypLrHHZDM6S7v8nYYYQqmnT74Nb59LgiX30ZQP53e/NHgyE9EJ6/KxwjcejfqhJOe+p2kOQ+pg==
X-Received: by 2002:a05:6000:8f:: with SMTP id
 m15mr26680151wrx.19.1587982640861; 
 Mon, 27 Apr 2020 03:17:20 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id k14sm20813049wrp.53.2020.04.27.03.17.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2020 03:17:20 -0700 (PDT)
Subject: Re: [PATCH] chardev: Add macOS to list of OSes that support -chardev
 serial
To: Mikhail Gusarov <dottedmag@dottedmag.net>, qemu-devel@nongnu.org
References: <20200426210956.17324-1-dottedmag@dottedmag.net>
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
Message-ID: <4e9edcaf-d623-b5c6-fdf9-0d649ef8ba2d@amsat.org>
Date: Mon, 27 Apr 2020 12:17:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200426210956.17324-1-dottedmag@dottedmag.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::443
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
Cc: qemu-trivial@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/26/20 11:09 PM, Mikhail Gusarov wrote:
> macOS API for dealing with serial ports/ttys is identical to BSDs.
> 
> Signed-off-by: Mikhail Gusarov <dottedmag@dottedmag.net>
> ---
> 
> Note that the same file has a line
>> #endif /* linux || sun */
> that is severely out of date.
> 
>  chardev/char-serial.c | 2 +-
>  include/qemu/osdep.h  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/chardev/char-serial.c b/chardev/char-serial.c
> index 5b833ea077..7c3d84ae24 100644
> --- a/chardev/char-serial.c
> +++ b/chardev/char-serial.c
> @@ -53,7 +53,7 @@ static void qmp_chardev_open_serial(Chardev *chr,
>  
>  #elif defined(__linux__) || defined(__sun__) || defined(__FreeBSD__)      \
>      || defined(__NetBSD__) || defined(__OpenBSD__) || defined(__DragonFly__) \
> -    || defined(__GLIBC__)
> +    || defined(__GLIBC__) || defined(__APPLE__)
>  
>  static void tty_serial_init(int fd, int speed,
>                              int parity, int data_bits, int stop_bits)
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 20f5c5f197..ff7c17b857 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -379,7 +379,7 @@ void qemu_anon_ram_free(void *ptr, size_t size);
>  #define HAVE_CHARDEV_SERIAL 1
>  #elif defined(__linux__) || defined(__sun__) || defined(__FreeBSD__)    \
>      || defined(__NetBSD__) || defined(__OpenBSD__) || defined(__DragonFly__) \
> -    || defined(__GLIBC__)
> +    || defined(__GLIBC__) || defined(__APPLE__)
>  #define HAVE_CHARDEV_SERIAL 1
>  #endif
>  
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

