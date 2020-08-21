Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A7AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 15:11:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F15D2076E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 15:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HQj9R6Wq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F15D2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k98hb-00053u-JA
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 11:11:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k98gm-0004AE-Ns
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 11:10:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55630)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k98gk-0004BR-Qn
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 11:10:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598022641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ctQTlHwbLv5QQWzDib28OJAOn/QuTpeG0eGB7lSWKfQ=;
 b=HQj9R6WqCu7vGWydm4CT9viDma8kW75RnzqIOxKhcXCg8mbGvJiegexnZR3jXVbW7zLz/9
 4VgNFImPK9D7Z7ATVCoVSB+2rjZXl+FOL3YQpZHokLDe2HJHSxX8b1gqbB7dln79nesM/N
 meKavsSQcUOaSnAM8Xx6UZa773bmdB8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-Urrogsp4PTm9adqyW6CqUg-1; Fri, 21 Aug 2020 11:10:39 -0400
X-MC-Unique: Urrogsp4PTm9adqyW6CqUg-1
Received: by mail-wm1-f70.google.com with SMTP id t26so929187wmn.4
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 08:10:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ctQTlHwbLv5QQWzDib28OJAOn/QuTpeG0eGB7lSWKfQ=;
 b=gt4bmgd2xAsq4MsGhwxTvHlaXvLH9tTJOtlGfKk2BYwT3euN+Qqq6hEgtbt59OIJyY
 bo0bTFLNNnfRcJrkzel0wPzN9zsSoJGEqlp2//DhouKya/gcvm3ISfU7jZF5+J5WeGVz
 f/aT2ddxPYoKuAo6xRXfu9f4WelJN3MkPZ6zUNT24ZoSaHvp+1PYtHrjhYX81YenKKM0
 45GM3dnm0V5uuaE6wftStikVCW8xbcGAawVeeU0+ruDmbdLBRGbt9Mnujc2cFwwVilLa
 +rzr9DcCP64gVDwmyz+I6OmodYbkm5MNR2fc7SG3odfiLNSV6UaowqMYOzKOnsAeWQo2
 ELgw==
X-Gm-Message-State: AOAM531d7hbLmKnNgpAKOlroaOp2K8a0GQjqpybnicLU0yLZtXmRwtRj
 HnO/N1kB0OHdk/hZEibdl6Tge2+obS810UKuLw7FuZ7zQUAjM7lgLrxYZcCHAVSoaLPeJJg+3C+
 TBNvSH/U3j5Xoqvk=
X-Received: by 2002:adf:82f6:: with SMTP id 109mr3405551wrc.25.1598022638383; 
 Fri, 21 Aug 2020 08:10:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy3W6xw0bU6xD4eMpXbsa/NRGmSccX1yRu4ZYy/B0zuedN89OejP7BMfY2CMUXnJruv3WJ0iQ==
X-Received: by 2002:adf:82f6:: with SMTP id 109mr3405530wrc.25.1598022638153; 
 Fri, 21 Aug 2020 08:10:38 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1cc0:4e4e:f1a9:1745?
 ([2001:b07:6468:f312:1cc0:4e4e:f1a9:1745])
 by smtp.gmail.com with ESMTPSA id m8sm4655108wro.75.2020.08.21.08.10.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2020 08:10:37 -0700 (PDT)
Subject: Re: [PATCH] configure: silence 'shift' error message in version_ge()
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
References: <20200821150014.42461-1-sgarzare@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e6ced1f4-89ea-aa02-0a4b-c039d44094bc@redhat.com>
Date: Fri, 21 Aug 2020 17:10:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200821150014.42461-1-sgarzare@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 02:43:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/08/20 17:00, Stefano Garzarella wrote:
> If there are less than 2 arguments in version_ge(), the second shift
> prints this error:
>     ../configure: line 232: shift: shift count out of range
> 
> Let's shut it up, since we're expecting this situation.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index 4e5fe33211..de4bd0df36 100755
> --- a/configure
> +++ b/configure
> @@ -229,7 +229,7 @@ version_ge () {
>          set x $local_ver1
>          local_first=${2-0}
>          # shift 2 does nothing if there are less than 2 arguments
> -        shift; shift
> +        shift; shift 2>/dev/null
>          local_ver1=$*
>          set x $local_ver2
>          # the second argument finished, the first must be greater or equal
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>


