Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D093C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 08:37:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC94A207C3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 08:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dcL1Pv42"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC94A207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSFof-0002tj-WA
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 04:37:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSFmR-0000YZ-RR
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 04:35:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29952)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSFmP-0004v8-Hl
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 04:35:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602578132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RGVk86dV2c40mJsaB0GuZyo4FuOI8eRya7E9IfirM9s=;
 b=dcL1Pv42YJfucHr/TeobxBJaCGNnw5x0kg6Ta62ME4+eDs3O+pkkH72cWyWnU9uy0zTFaa
 ag07BFhNZTs32r5ZzmPwv4NqUbvNAcxWDi/NnJt2dF3neov6mDk2ZkRXpq2MIvLe6BCiNu
 DDOSzNxMRJJEA6TbkS3USV6FkfVoOQg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-AVW9O-WwNIqqLO2oICKX7A-1; Tue, 13 Oct 2020 04:35:31 -0400
X-MC-Unique: AVW9O-WwNIqqLO2oICKX7A-1
Received: by mail-wm1-f71.google.com with SMTP id v14so6501863wmj.6
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 01:35:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RGVk86dV2c40mJsaB0GuZyo4FuOI8eRya7E9IfirM9s=;
 b=JbD6gqBKSvoukuf0Ev6wAt/wdxHSqdQDQKjoPvlxmQfqmTmJVNGlzyihEqHXBSb7oV
 ta8CXBp/BtjRXcj5Ik2sIYFBJsi3dxKnG/A+XypVJ9oLmekv624XQNxLy1hUDxbzkGo9
 Bqch1INUcSO/jWm+1/1UAAcMVDvK7sgNAaduTm92xI0WzyKiHcMpvoAfcFJL2kTcXGOp
 KdkNFqWKZ8tNIiH3AqgXmSefnvLw3rhwrwrXvf/07Lfr6phqWcWJBrfsqlWvW8xfHrp7
 oMk+VoX5LrG+UiSnN6NKKefmLqYYeu98Ri++XpxwxR6yEaIcmDhR6kX+bWQufE3Fuz5U
 Gsrg==
X-Gm-Message-State: AOAM532b4mc6YmolJED8f/sDJIHK/jX23UycdrROhsGOAyS+8Kwbfbjw
 wvzbBYvGLl5ilgOiaoFaklmhUkm9cZfzzKW4q73LJOiGsihBcSXq3JX4Zbppo4FMQm0VgqVX4pU
 ikkL4uKJWBKsXVL0=
X-Received: by 2002:adf:ea0a:: with SMTP id q10mr22488351wrm.242.1602578129169; 
 Tue, 13 Oct 2020 01:35:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwopslEBIzPABteuTnu243j7fqDM/V1pNHDQZh1NqPTwUcVXCQPgM1renr8mNETXKJHzy5tew==
X-Received: by 2002:adf:ea0a:: with SMTP id q10mr22488326wrm.242.1602578128980; 
 Tue, 13 Oct 2020 01:35:28 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id a82sm27913568wmc.44.2020.10.13.01.35.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 01:35:28 -0700 (PDT)
Subject: Re: [PATCH v9 1/5] configure: fixes indent of $meson setup
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20201012234348.1427-1-luoyonggang@gmail.com>
 <20201012234348.1427-2-luoyonggang@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9ced66f9-6641-ac41-15fa-975331c77eef@redhat.com>
Date: Tue, 13 Oct 2020 10:35:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201012234348.1427-2-luoyonggang@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 03:04:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/13/20 1:43 AM, Yonggang Luo wrote:
> convert these line from tab to space
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   configure | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/configure b/configure
> index b553288c5e..1b63488521 100755
> --- a/configure
> +++ b/configure
> @@ -7211,13 +7211,13 @@ NINJA=${ninja:-$PWD/ninjatool} $meson setup \
>           -Db_pie=$(if test "$pie" = yes; then echo true; else echo false; fi) \
>           -Db_staticpic=$(if test "$pie" = yes; then echo true; else echo false; fi) \
>           -Db_coverage=$(if test "$gcov" = yes; then echo true; else echo false; fi) \
> -	-Dmalloc=$malloc -Dmalloc_trim=$malloc_trim -Dsparse=$sparse \
> -	-Dkvm=$kvm -Dhax=$hax -Dwhpx=$whpx -Dhvf=$hvf \
> -	-Dxen=$xen -Dxen_pci_passthrough=$xen_pci_passthrough -Dtcg=$tcg \
> -	-Dcocoa=$cocoa -Dmpath=$mpath -Dsdl=$sdl -Dsdl_image=$sdl_image \
> -	-Dvnc=$vnc -Dvnc_sasl=$vnc_sasl -Dvnc_jpeg=$vnc_jpeg -Dvnc_png=$vnc_png \
> -	-Dgettext=$gettext -Dxkbcommon=$xkbcommon -Du2f=$u2f \
> -	-Dcapstone=$capstone -Dslirp=$slirp -Dfdt=$fdt \
> +        -Dmalloc=$malloc -Dmalloc_trim=$malloc_trim -Dsparse=$sparse \
> +        -Dkvm=$kvm -Dhax=$hax -Dwhpx=$whpx -Dhvf=$hvf \
> +        -Dxen=$xen -Dxen_pci_passthrough=$xen_pci_passthrough -Dtcg=$tcg \
> +        -Dcocoa=$cocoa -Dmpath=$mpath -Dsdl=$sdl -Dsdl_image=$sdl_image \
> +        -Dvnc=$vnc -Dvnc_sasl=$vnc_sasl -Dvnc_jpeg=$vnc_jpeg -Dvnc_png=$vnc_png \
> +        -Dgettext=$gettext -Dxkbcommon=$xkbcommon -Du2f=$u2f \
> +        -Dcapstone=$capstone -Dslirp=$slirp -Dfdt=$fdt \
>           $cross_arg \
>           "$PWD" "$source_path"
>   
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


