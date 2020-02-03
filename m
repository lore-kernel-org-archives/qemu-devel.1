Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC10EC35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 16:12:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A490C2080D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 16:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XJv9RCee"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A490C2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyeKo-0008Ae-SP
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 11:12:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42865)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iyeKE-0007h3-20
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 11:11:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iyeKD-0003RJ-3g
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 11:11:49 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42794
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iyeKC-0003NM-Vq
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 11:11:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580746308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FgsW68br4p+oVZpmuhel177NIit65QDxxDp1WknU9Hs=;
 b=XJv9RCeeh/LSuUusebt5Mm66eAnN7mZBlg2PucC9tWIFG4qF8JE7k6KlvluNispRWkU7Ff
 riDsQI5hMgwH5lp/JPJNWubwtYFeiZU6eWJAh3Jy6Xq/AiJeKGx4dRf57t5D3rAb949N7n
 2QhBm5Hlrd7AqxxEX5t33Q1OLE4kAdQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-mgpmld10MQmYT4MMUp8sUw-1; Mon, 03 Feb 2020 11:11:43 -0500
Received: by mail-wr1-f72.google.com with SMTP id 50so7649211wrc.2
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 08:11:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=H16G/2pyCboewb+aqoieCVQGYhYAP0leOFD1GWuoHvc=;
 b=rDGRNQXAVG8L8n1wVRd7eJzZIQ16NHTNj9+6sz8aWnUN39Sc7FCESe2dPkA6pLATNs
 eJVXHrqeVxOLe/DuX5gmcHn4DcKcccaGp/9vWiW5GpwuHIX2tn79uybUSjifQc4uGTX4
 rDV79rrU92ZS16C9lSR+j2uS92EBL9nMvbVGHNwXf0BP1S6Ff9MRboU/4uHjJoAopCRR
 Uv25YmqcpD90qSXvqhxKLcGeUdGtF4NVcdwT0AHuFaSZV+MQtN2wZX6yJVTf2E/4AHZf
 fgL/ZwYisjO94MPpFi6L5pqCBVU0OEyJQ+w6HyHpJiO56UTa9Ak0bZzwm6jSd38QWgnT
 WFHg==
X-Gm-Message-State: APjAAAUqz4LaBZcynFylOH/h6biXx3JOMloWGbOGP/ZTNheKUqedo9VT
 MUHX+Tw8LP3M3EBgdbkj1dS1nlaJ7X1590laFOBWGp9aYVHNtZnvcOQXh6BJeFLknYLiE6EB6JB
 ggzFDU68Xyp63Ods=
X-Received: by 2002:a1c:660a:: with SMTP id a10mr29742785wmc.122.1580746302084; 
 Mon, 03 Feb 2020 08:11:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqyoCVpDtxIwfpzSYx3+0dVZxssy5JdjY2HhNIRLEW+S4dlVdRAE2vVoD3qt1fnocz1tahNc3g==
X-Received: by 2002:a1c:660a:: with SMTP id a10mr29742771wmc.122.1580746301919; 
 Mon, 03 Feb 2020 08:11:41 -0800 (PST)
Received: from [192.168.1.35] (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id a62sm24723810wmh.33.2020.02.03.08.11.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2020 08:11:41 -0800 (PST)
Subject: Re: [PATCH] configure: Fix typo of the have_afalg variable
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200203160046.23194-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <fa896988-958b-911a-2068-85af05c4e4b9@redhat.com>
Date: Mon, 3 Feb 2020 17:11:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200203160046.23194-1-thuth@redhat.com>
Content-Language: en-US
X-MC-Unique: mgpmld10MQmYT4MMUp8sUw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Longpeng <longpeng2@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/3/20 5:00 PM, Thomas Huth wrote:
> The variable is called 'have_afalg' and not 'hava_afalg'.
>=20
> Fixes: f0d92b56d88 ('introduce some common functions for af_alg backend')
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   configure | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/configure b/configure
> index 5095f01728..115dc38085 100755
> --- a/configure
> +++ b/configure
> @@ -5843,7 +5843,7 @@ fi
>  =20
>   ##########################################
>   # check for usable AF_ALG environment
> -hava_afalg=3Dno
> +have_afalg=3Dno
>   cat > $TMPC << EOF
>   #include <errno.h>
>   #include <sys/types.h>
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


