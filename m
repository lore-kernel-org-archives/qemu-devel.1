Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFFEC4BA06
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 07:57:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5658222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 07:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LdEMslK/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5658222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7E3C-0001xl-1e
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 02:57:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57085)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7E2S-0001Jp-NS
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 02:56:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7E2R-0007mI-Mm
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 02:56:56 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55305
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7E2R-0007kn-Iz
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 02:56:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582790215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H4T4SEAtCV7t6TBZjUrYHbVftbeBLpSiOJmo/Sm4Y1U=;
 b=LdEMslK/fjbr3c5/zd5TpsNrkLmvlMqO66MQagVbRJ8yg2ekMr5ttqn/ADOGEAZiehE6Ll
 R09OQLU7HMyOxpYLEcC3idwwlouHpq0y1zxXzoAVZV5PbBWftkSlzzjnxiCQ/9FVjkHMKD
 vjYAb9h5REVRc707+32Rtzc6pfpnYxU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-KcwKuXqvN5eo7ukUUYQs5Q-1; Thu, 27 Feb 2020 02:56:47 -0500
X-MC-Unique: KcwKuXqvN5eo7ukUUYQs5Q-1
Received: by mail-wr1-f70.google.com with SMTP id w6so942494wrm.16
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 23:56:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=H4T4SEAtCV7t6TBZjUrYHbVftbeBLpSiOJmo/Sm4Y1U=;
 b=auWrsMFaie4bSpQ5e/NAQegnK17/b7dA4HdCvynR6MV8O3Ic4lSSIpsUKThf9kqxP9
 dDu1dAFd3SfrTNhcalLRerF+oE2BzVFLYNSge2aUrHwAICKY8siF7oCdx5ghYjoYUQ43
 W3Tjhs2URyFtXV6f+zJlJRK3sylxQ+Z5zyVTFm4ukegRAINnKwn7PlnJrgsdYIfaOaQq
 jIGEIhshUQ19xThrXcF3uAG19yx0aQrtaeSyE86rS4cNN8RVCLGoBmeAeF7Z6UE6UOux
 CMW0O9wvG5KWCJL1lGpVYMB/T8XANotkg242/DlcOItb05IEUNg90/Qn2aNLnX2l4WDT
 47oA==
X-Gm-Message-State: APjAAAUc3yUpUMrXc2s4CLtjgQKAXRH/SfJq8XGiQh7/CRdY02dhtv0M
 K94BRYfro/b2vpkk9F2XfdLbz1JOFJUj0Fc9EeFAEIab5fcqY9kxtfPZyYnwdtLr8ZjyY9GzH97
 HrMmyW67Y19wn5x4=
X-Received: by 2002:a1c:984a:: with SMTP id a71mr3755810wme.185.1582790206267; 
 Wed, 26 Feb 2020 23:56:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqy7Qeec/88cYAQhSR1ghEGkLVjk2Y+LBRrBreTUBtUFojGUct0RpJnDoa+lu4R3UkoEwjPx9g==
X-Received: by 2002:a1c:984a:: with SMTP id a71mr3755753wme.185.1582790205781; 
 Wed, 26 Feb 2020 23:56:45 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id c9sm7019607wrq.44.2020.02.26.23.56.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2020 23:56:45 -0800 (PST)
Subject: Re: [PATCH] MAINTAINERS: Add entry for Guest X86 HAXM CPUs
To: Colin Xu <colin.xu@intel.com>, qemu-devel@nongnu.org, pbonzini@redhat.com
References: <20200226043204.67961-1-colin.xu@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <556a79eb-de83-0471-353f-b92423a77faa@redhat.com>
Date: Thu, 27 Feb 2020 08:56:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200226043204.67961-1-colin.xu@intel.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, wenchao.wang@intel.com,
 hang.yuan@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing qemu-trivial@

On 2/26/20 5:32 AM, Colin Xu wrote:
> HAXM covers below files:
> include/sysemu/hax.h
> target/i386/hax-*
> 
> Cc: Wenchao Wang <wenchao.wang@intel.com>
> Cc: Hang Yuan <hang.yuan@intel.com>
> Signed-off-by: Colin Xu <colin.xu@intel.com>

Please keep the Acked-by/Reviewed-by tags:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg623832.html

This patch already has:
Reviewed-by: Hang Yuan <hang.yuan@intel.com>

> ---
>   MAINTAINERS | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 36d94c17a654..27727e2fac13 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -435,6 +435,16 @@ F: include/hw/block/dataplane/xen*
>   F: include/hw/xen/
>   F: include/sysemu/xen-mapcache.h
>   
> +Guest CPU Cores (HAXM)
> +---------------------
> +X86 HAXM CPUs
> +M: Wenchao Wang <wenchao.wang@intel.com>
> +M: Colin Xu <colin.xu@intel.com>
> +L: haxm-team@intel.com
> +S: Maintained
> +F: include/sysemu/hax.h
> +F: target/i386/hax-*
> +
>   Hosts
>   -----
>   LINUX
> 


