Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5CCC433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 15:09:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A4E820771
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 15:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MSdjoGLZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A4E820771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jycqH-0000H1-BZ
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 11:09:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jycpQ-0007yq-4E
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 11:08:12 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46352
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jycpO-0005HC-GX
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 11:08:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595516889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xKihhCyZTmmqAQdkRYc9L4cji2/lsCMJCMx270Gc3AY=;
 b=MSdjoGLZlvs71XQqpRsL4v+Owv6w6e5rPK7ekUK9qgcbY4lQkLR0upwHVx/w4nuJSAeA9F
 4RiJMC543jFL4DXK04QAfT2GjHL2MaWJAU99OlX8B+jGEPXSjOEYGNagyrgfR4UseBiv2v
 xZA+kCrdqqhRuf/WjMRKbfi85s72AeQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-f-0oopbCOXCNUeodyEN8Yw-1; Thu, 23 Jul 2020 11:08:06 -0400
X-MC-Unique: f-0oopbCOXCNUeodyEN8Yw-1
Received: by mail-wr1-f69.google.com with SMTP id m7so1494368wrb.20
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 08:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=xKihhCyZTmmqAQdkRYc9L4cji2/lsCMJCMx270Gc3AY=;
 b=AECaLoOo3JD0Nkb9e9GmKCXF3bddvA4/z+by42LKIvlDOLiDJnXq6+MVDwIC9j1l/E
 K5bPGiydgKV73DHh/vwjwrAcGZ0oLttA3ZJwC02IZ3L+4R6Z17BJ9CJutLHiBae1CCVO
 fn8OhB6MVTBVi3UsOg+JPgwnomN11HrnuAgkK0mS6Tce3NAxEwdU63FstZgOnYXRLXpk
 SkQ2IHddhJEwlljivCcDzQtMRAATJgdczPviNSraivF3Q+VSF2ukiO+My5p4VElGb6Ue
 P4Rf4I81+/sqldGZD/XJvgiGJbQDZeNw+hpdwTZ1iT+rfpYrllRGC5YqvhFp0flHdkdk
 NaQw==
X-Gm-Message-State: AOAM5328k6JeQFn/OLi5tlkaQJDkwuMTKJtJ8GjxM1+jUj9bQ/jrpK3Q
 FYeaXDqkee4BE1BLwq/YGD2rAh8hVy2aqwWa92LDQVhM+DiUucEOyqW3Czv/pskrUamMqKz12Ua
 r643kd8bDh+4wmJw=
X-Received: by 2002:a7b:c08b:: with SMTP id r11mr4489250wmh.130.1595516885687; 
 Thu, 23 Jul 2020 08:08:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7h/hxPNFNGUaAi4Ea0lp+M6OEAv/puSqpsK7CIXyRsklHLUVJAJdaavaUTqoh8MjPV0KeCw==
X-Received: by 2002:a7b:c08b:: with SMTP id r11mr4489224wmh.130.1595516885410; 
 Thu, 23 Jul 2020 08:08:05 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id c10sm4361998wro.84.2020.07.23.08.08.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2020 08:08:04 -0700 (PDT)
Subject: Re: [PATCH 1/3] scripts/qmp/qom-fuse: Unbreak import of
 QEMUMonitorProtocol
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200723142738.1868568-1-armbru@redhat.com>
 <20200723142738.1868568-2-armbru@redhat.com>
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
Message-ID: <34250135-17de-dac2-4581-6bf380aaf774@redhat.com>
Date: Thu, 23 Jul 2020 17:08:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200723142738.1868568-2-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:26:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/23/20 4:27 PM, Markus Armbruster wrote:
> Commit c7b942d7f8 "scripts/qmp: Fix shebang and imports" messed with
> it for reasons I don't quite understand.  I do understand how it fails
> now: it neglects to import sys.  Fix that.

Oops I missed that.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
> It now fails because it expects an old version of module fuse.  That's
> next.
> 
> Fixes: c7b942d7f84ef54f266921bf7668d43f1f2c7c79
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qmp/qom-fuse | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/qmp/qom-fuse b/scripts/qmp/qom-fuse
> index 5fa6b3bf64..b7dabe8d65 100755
> --- a/scripts/qmp/qom-fuse
> +++ b/scripts/qmp/qom-fuse
> @@ -13,7 +13,7 @@
>  
>  import fuse, stat
>  from fuse import Fuse
> -import os, posix
> +import os, posix, sys
>  from errno import *
>  
>  sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
> @@ -134,7 +134,7 @@ class QOMFS(Fuse):
>              yield fuse.Direntry(str(item['name']))
>  
>  if __name__ == '__main__':
> -    import sys, os
> +    import os
>  
>      fs = QOMFS(QEMUMonitorProtocol(os.environ['QMP_SOCKET']))
>      fs.main(sys.argv)
> 


