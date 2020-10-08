Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88ABC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 17:57:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 098962184D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 17:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FyqoOxLi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 098962184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQaA5-0005gX-QW
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 13:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kQa2b-0007Ad-6S
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 13:49:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44451)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kQa2Y-0003Ro-Dk
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 13:49:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602179357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vbBaJvd39cd3bmHyrHU8nMgXJDOg6ZqFbIkKFi07KO4=;
 b=FyqoOxLiJP53w9q/5U2TNEBDypRX8SWldm9jpK8HTUz/LrHbmGymghc428dskRvEJ/VCYD
 UJei7wyl1oyoEGK0R5ato5PI2/Z81JHk7hPfVE1WcZQULEQnC1HJTXPjt1VX4JNG2J7R9G
 D66XvnwBynV3I0fu5Fda4aytpCdPHPY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-tiRb5HiiN7iWBaqgEPMXug-1; Thu, 08 Oct 2020 13:49:15 -0400
X-MC-Unique: tiRb5HiiN7iWBaqgEPMXug-1
Received: by mail-wr1-f72.google.com with SMTP id l15so4175572wro.10
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 10:49:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vbBaJvd39cd3bmHyrHU8nMgXJDOg6ZqFbIkKFi07KO4=;
 b=MFtMoTbVhq3NyBmBJ9AFjzxz8Qt2dBSVvb+hfXtO0Ngh4iXcev0n+zhaGW4R6aNh0d
 JuRqL7GnniPM6P+qZeX2dLR9RnqT9Qzp9RaKh4H24cfenkLnGT5KWVow0LUJGRO3vftr
 Z7kPdY3BchpfVrIYFIF5M2zTWbD2K6PVkqgdAxzTCtR7m37S9AI2MV11fk8ZkL2EC6bf
 U6j32SnVD7roAfs02QmrZsM3IqDQpH4UfFTmVefLm8NeDF6N3ByXAnerL7qU11phcLlk
 djc6WgIeRNkY8ZnGYhTj8MeG7HRkGx2giXn8PFakXP3jO6aBglK864+L8yB2h1xvzIif
 zthw==
X-Gm-Message-State: AOAM532H2MMNw1UFKKiqisNqhGjkyvu9InNdIkuF9Ru5PM7xlhG18G19
 TYcmUY9gpWzUKNzYDmAwRzUUkzOIENxYPBmc0Y2iayYlSvGhU94+2wopkngYJbBm8Do7L4lvpt+
 kMh/Y6WRgddKZMqs=
X-Received: by 2002:adf:f104:: with SMTP id r4mr10716521wro.202.1602179354028; 
 Thu, 08 Oct 2020 10:49:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwn+1oNp0icKFfFt6TaqJVV7QVYGriN8h8qSNbFDWILpr9CWnhfwJ8fnvVtou4m5ej/Oif70Q==
X-Received: by 2002:adf:f104:: with SMTP id r4mr10716504wro.202.1602179353844; 
 Thu, 08 Oct 2020 10:49:13 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id c4sm8236836wrp.85.2020.10.08.10.49.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2020 10:49:13 -0700 (PDT)
Subject: Re: [PATCH] mingw: Fix builds on f33 mingw
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, quintela@redhat.com, thuth@redhat.com
References: <20201008174359.157627-1-dgilbert@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <8f427549-ccd7-c578-8360-ebddc769aabe@redhat.com>
Date: Thu, 8 Oct 2020 19:49:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201008174359.157627-1-dgilbert@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 01:56:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/8/20 7:43 PM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Fedora 33's mingw moans about:
> 
> In file included from ../tests/test-bitmap.c:12:
> /home/dgilbert/git/migpull/include/qemu/osdep.h:76: error: "__USE_MINGW_ANSI_STDIO" redefined [-Werror]
>    76 | #define __USE_MINGW_ANSI_STDIO 1
>       |
> 
> the fix is to make sure osdep.h is the first include - which is our
> rule anyway; but one we broke in a couple of places.

Marc-André sent the same fix:
https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg02191.html

> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  migration/dirtyrate.c | 2 +-
>  tests/test-bitmap.c   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index ab9e1301f6..42b71e771e 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -10,8 +10,8 @@
>   * See the COPYING file in the top-level directory.
>   */
>  
> -#include <zlib.h>
>  #include "qemu/osdep.h"
> +#include <zlib.h>
>  #include "qapi/error.h"
>  #include "cpu.h"
>  #include "qemu/config-file.h"
> diff --git a/tests/test-bitmap.c b/tests/test-bitmap.c
> index 2f5b71458a..c3c9d79667 100644
> --- a/tests/test-bitmap.c
> +++ b/tests/test-bitmap.c
> @@ -8,8 +8,8 @@
>   * Author: Peter Xu <peterx@redhat.com>
>   */
>  
> -#include <stdlib.h>
>  #include "qemu/osdep.h"
> +#include <stdlib.h>
>  #include "qemu/bitmap.h"
>  
>  #define BMAP_SIZE  1024
> 


