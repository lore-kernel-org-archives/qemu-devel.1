Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681D4C3F2CE
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 21:48:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32CF320717
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 21:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M0azXiEQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32CF320717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9bsL-0002bc-Cp
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 16:48:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54527)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9brN-0001EC-Jy
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 16:47:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9brM-0008Mk-Db
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 16:47:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47208
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9brM-0008MU-A3
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 16:47:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583358439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=StGOTJ8n5KB9LfrJk3EdcbqQkbOUK5C44zgIzdBC7MY=;
 b=M0azXiEQZ0WNzhjqzBmr1q5Gx2gHeV+GeMSnUa7Ne+4B8weAHbZh7fZLbvcXaK/nikk5rU
 UZjIk9DStQI1L0vROWnzSVOMDw+9BKa14bYZLV1MNkp6FXOqNG9chKqA9MnvR8v+E9d9st
 YGfD3DmGW+MQ1RGRKhGymrl7jQJhsNU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-Ft6ECQA4MXK5gKxGNNYhAg-1; Wed, 04 Mar 2020 16:47:18 -0500
X-MC-Unique: Ft6ECQA4MXK5gKxGNNYhAg-1
Received: by mail-ed1-f70.google.com with SMTP id r26so2662039edl.5
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 13:47:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=StGOTJ8n5KB9LfrJk3EdcbqQkbOUK5C44zgIzdBC7MY=;
 b=mmBHncejFcmStvIy6RF+3STCdtkR1WBunX9hbSeV/zAjlF7td42ekh2v3xZpgRijs8
 almQhY39s9uUMj5tkq2Edk0RQsGWVqOhy/yhrPcGTHACZOBgbuvkT7KhBaRhctc4oUu9
 V1dKkFGDl0L3vj1CJDYyj3F7XXzJmPiBGuVEpofq8CQDfuL1Rd1OuqMM8bb4KYKdNNO4
 zNKnEBc+XvT8BkqrjbBr4FIT9Sv944oR37RYX0rxm5UYPuajHmHXmzJ1I21QQQw1zArE
 rWuD8x2CK5ygitPJX6DK92NZ/b7RE/L5D99EuoPdpdq/PobaCRb/AdV2dPuD2MYU83aK
 FN7w==
X-Gm-Message-State: ANhLgQ1iEh5cspx/JitUDAtAGmaJUZB7Q3MPJYVY/Q2PH3qDfOwl70Uy
 hyO41tGFBb1yVGQPAiL3U3xQtUbv36mlZn1rqF6np0C5xinpIPsv0Zy/1lurQYpONBVum2Ey52p
 qmGKuILmCy13SHY0=
X-Received: by 2002:aa7:c751:: with SMTP id c17mr4921697eds.293.1583358437208; 
 Wed, 04 Mar 2020 13:47:17 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsChhqe9Tc7xK98BMp2O5xEt+sU7hYOZnX7HU2cRe/WsYQmxXf//3WNzOHaFjAKJ3++kJlwaQ==
X-Received: by 2002:aa7:c751:: with SMTP id c17mr4921680eds.293.1583358437021; 
 Wed, 04 Mar 2020 13:47:17 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id y5sm663546edw.79.2020.03.04.13.47.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Mar 2020 13:47:16 -0800 (PST)
Subject: Re: [PATCH v7 09/10] iotests: Mark verify functions as private
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200304213818.15341-1-jsnow@redhat.com>
 <20200304213818.15341-10-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9f43ef9a-9c19-bf16-648b-efd2914e1e07@redhat.com>
Date: Wed, 4 Mar 2020 22:47:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200304213818.15341-10-jsnow@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, armbru@redhat.com, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/4/20 10:38 PM, John Snow wrote:
> Discourage their use.

I recommend you to repeat the subject, else it is harder to review 
looking only at patch description.

> 
> (Also, make pending patches not yet using the new entry points fail in a
> very obvious way.)
> 
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   tests/qemu-iotests/iotests.py | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
> index 1f88d2fa2a..23678f2daa 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -982,7 +982,7 @@ def case_notrun(reason):
>       open('%s/%s.casenotrun' % (output_dir, seq), 'a').write(
>           '    [case not run] ' + reason + '\n')
>   
> -def verify_image_format(supported_fmts=(), unsupported_fmts=()):
> +def _verify_image_format(supported_fmts=(), unsupported_fmts=()):
>       assert not (supported_fmts and unsupported_fmts)
>   
>       if 'generic' in supported_fmts and \
> @@ -996,7 +996,7 @@ def verify_image_format(supported_fmts=(), unsupported_fmts=()):
>       if not_sup or (imgfmt in unsupported_fmts):
>           notrun('not suitable for this image format: %s' % imgfmt)
>   
> -def verify_protocol(supported=(), unsupported=()):
> +def _verify_protocol(supported=(), unsupported=()):
>       assert not (supported and unsupported)
>   
>       if 'generic' in supported:
> @@ -1006,7 +1006,7 @@ def verify_protocol(supported=(), unsupported=()):
>       if not_sup or (imgproto in unsupported):
>           notrun('not suitable for this protocol: %s' % imgproto)
>   
> -def verify_platform(supported=(), unsupported=()):
> +def _verify_platform(supported=(), unsupported=()):
>       if any((sys.platform.startswith(x) for x in unsupported)):
>           notrun('not suitable for this OS: %s' % sys.platform)
>   
> @@ -1014,11 +1014,11 @@ def verify_platform(supported=(), unsupported=()):
>           if not any((sys.platform.startswith(x) for x in supported)):
>               notrun('not suitable for this OS: %s' % sys.platform)
>   
> -def verify_cache_mode(supported_cache_modes=()):
> +def _verify_cache_mode(supported_cache_modes=()):
>       if supported_cache_modes and (cachemode not in supported_cache_modes):
>           notrun('not suitable for this cache mode: %s' % cachemode)
>   
> -def verify_aio_mode(supported_aio_modes=()):
> +def _verify_aio_mode(supported_aio_modes=()):
>       if supported_aio_modes and (aiomode not in supported_aio_modes):
>           notrun('not suitable for this aio mode: %s' % aiomode)
>   
> @@ -1145,11 +1145,11 @@ def execute_setup_common(supported_fmts: Collection[str] = (),
>           sys.stderr.write('Please run this test via the "check" script\n')
>           sys.exit(os.EX_USAGE)
>   
> -    verify_image_format(supported_fmts, unsupported_fmts)
> -    verify_protocol(supported_protocols, unsupported_protocols)
> -    verify_platform(supported=supported_platforms)
> -    verify_cache_mode(supported_cache_modes)
> -    verify_aio_mode(supported_aio_modes)
> +    _verify_image_format(supported_fmts, unsupported_fmts)
> +    _verify_protocol(supported_protocols, unsupported_protocols)
> +    _verify_platform(supported=supported_platforms)
> +    _verify_cache_mode(supported_cache_modes)
> +    _verify_aio_mode(supported_aio_modes)
>   
>       debug = '-d' in sys.argv
>       if debug:
> 


