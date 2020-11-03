Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E68C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:26:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B330206F1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gjr0FN1Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B330206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZyCt-0008Do-2S
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 10:26:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kZxnP-00051b-0o
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:00:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41683)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kZxnM-0006Wd-CE
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:00:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604415623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KofDogDoyMq2ECoyE0nv0SuHCEF4jUK+6LhPcW3eB50=;
 b=gjr0FN1Qz6WKpiqV6hQU8kX7kSBHRaC2iALitCIQUuAtWenBro3Y9I30X68SBcHL0ui0yZ
 2KUNRTnK03/ZCymhXQeIWRKSyakwLpaXY38EWptQvo1782/ZaMg6tRuaBxsb0RFWENZhuq
 d2GR/cb5wHhEoRLzW94d/IG9kr++exE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-lxWWj8SQPOm6XM0Hy61KyA-1; Tue, 03 Nov 2020 10:00:22 -0500
X-MC-Unique: lxWWj8SQPOm6XM0Hy61KyA-1
Received: by mail-ej1-f72.google.com with SMTP id p18so5518763ejl.14
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 07:00:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KofDogDoyMq2ECoyE0nv0SuHCEF4jUK+6LhPcW3eB50=;
 b=EPE8Umz5u/Mx4pZgHeYyF6Ms2rIzy53Bf8cHHZvLAJ8XpTnn+VGysJF8mtqJWwwd83
 mxvFoe64Tbhni9Q1p+yAK0UaR6A2kJTvRkz7u9PjrffC6qqIGMFo6Cri1k0XIaoKDCQ7
 WUruy32z0idfzAe4yfkTBuzdQB0Z3AiOTYjR8fVEOQDzVkEvFxn2+EvnqTblBUDvX4jd
 AwQxft9wvuGTrGpSIhBb0OgSskMVdwotw9a+98Q8Uc3BX8MphOk9NPvCkAd+HFn4YuZ+
 zTbG2wW4JWouLdzP63Tq5GJh4s1i5JdQG0dW4GQC4zu5a24GESpA/Yb7Ui82S6/e9kzt
 ULWQ==
X-Gm-Message-State: AOAM531dsAZefPdnh64cPuL5PBXsvdY8Gchc8KHxyOzwgT8wzTzuGIYS
 mQymETuDWW8wudKRhNbBtz48T+eRkJ5GzOkQ4X9zRSnKZnH+89F99d31TN58pLDS9Vfrotf45iy
 hy3trjQiax5adons=
X-Received: by 2002:a17:906:198b:: with SMTP id
 g11mr2727668ejd.445.1604415619942; 
 Tue, 03 Nov 2020 07:00:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwkidZFA27lFIH7biX5d2tjKU2lHuO/HovqswpDysA94Xrfk+7cPAgVIz3rA25RxFlEXwTLcw==
X-Received: by 2002:a17:906:198b:: with SMTP id
 g11mr2727554ejd.445.1604415619239; 
 Tue, 03 Nov 2020 07:00:19 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id k22sm12163771edr.12.2020.11.03.07.00.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 07:00:17 -0800 (PST)
Subject: Re: [PATCH] configure: fix gio_libs reference
To: Bruce Rogers <brogers@suse.com>, qemu-devel@nongnu.org
References: <20201103145121.668865-1-brogers@suse.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d6e5490c-5286-1bc7-ca37-8f58e9fe9ecc@redhat.com>
Date: Tue, 3 Nov 2020 16:00:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201103145121.668865-1-brogers@suse.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: peter.maydell@linaro.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/11/20 15:51, Bruce Rogers wrote:
> The gio library detection code no longer works, due to a missing $ in
> front of the gio_libs reference. Make the string be $gio_libs.
> 
> Fixes: 76346b6264a ("configure: Test that gio libs from pkg-config
> work")
> 
> Signed-off-by: Bruce Rogers <brogers@suse.com>
> ---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index 2c3c69f118..bc06aa81e5 100755
> --- a/configure
> +++ b/configure
> @@ -3499,7 +3499,7 @@ if $pkg_config --atleast-version=$glib_req_ver gio-2.0; then
>      # with pkg-config --static --libs data for gio-2.0 that is missing
>      # -lblkid and will give a link error.
>      write_c_skeleton
> -    if compile_prog "" "gio_libs" ; then
> +    if compile_prog "" "$gio_libs" ; then
>          gio=yes
>      else
>          gio=no
> 

Queued, thanks.

Paolo


