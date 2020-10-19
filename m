Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE52BC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 11:29:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3786B22257
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 11:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hpDNC08p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3786B22257
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUTMA-0001Si-3T
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 07:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUTKh-0000X2-UX
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 07:28:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56711)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUTKe-0006EK-SF
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 07:28:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603106883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gqeZOA/7WpfbCWLyG5ypfCEXr1s35JvKGP/095RRlxE=;
 b=hpDNC08pob81sf5piKJ5Llcgtkcqh4sbfpYTW9tiAtUNyu9UuTIw9ac30AumCwm8bR7wXZ
 xTwnWVod4J8/Ma9x9gRRhpwz9WaTmzpbwr26z1eWT3+xZnCRg9STCdlkRRtsumMp2+AhxF
 kERJPMZUbLYzK6pmpqmM46qOYufQ4dc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-EWSIrRQINuKFe4o8sjBlYg-1; Mon, 19 Oct 2020 07:28:01 -0400
X-MC-Unique: EWSIrRQINuKFe4o8sjBlYg-1
Received: by mail-wm1-f69.google.com with SMTP id i9so4310576wml.2
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 04:28:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gqeZOA/7WpfbCWLyG5ypfCEXr1s35JvKGP/095RRlxE=;
 b=dwBfROaYTP07KJMFZF5Ygl3hOUBQ9RAsUvf5Iai9d6LikWbtt16n9+HIWstIuKsKjg
 FDYWCtwf/tdnexjwOMOnzTQnELKI7bUtzKExpNmUMlpVhDrdWNVxSGMVXqW1180IJuNN
 rkvm0wR8S8UsGxavxMyHjY24ap269VhYyXCNHV6Ctrk0PYH2YssB68x2x9xAHHNMZmxC
 /gfMqjvHWRKEv07fbGcsvzugg7mT7XMrF+AZ/KJ1Ez0jIfBk3of5uxI3WURMADvtmmO7
 DYiApYPI45kohW6IFgX62zd7G8UtO1fJKhe0DrQWq+YqAcieJVuDR8B4wsCBSpHeVjjv
 Cl0w==
X-Gm-Message-State: AOAM533Cwwi7C2eRKA0cVB5pkv3hMgwBJ9xC+J5EwC3VeS5OXPo0enyp
 XZRU+JfAJk+99lPn9yqXsHih7xej7Vx3yqjM5frx+3PAeZnRLJpNemB1QcPg8Lh55uXhILwCge9
 AV6mlyxxGDbbuE/M=
X-Received: by 2002:a1c:7f97:: with SMTP id
 a145mr17804822wmd.160.1603106880061; 
 Mon, 19 Oct 2020 04:28:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyz5HsSKXC7jgOa3oQJLHqHlJRisx75EOpzEXEVl3UG1ZviXKAXVpCiwXsrbiLfP5llQS5KVg==
X-Received: by 2002:a1c:7f97:: with SMTP id
 a145mr17804792wmd.160.1603106879753; 
 Mon, 19 Oct 2020 04:27:59 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id q10sm13108843wme.2.2020.10.19.04.27.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2020 04:27:59 -0700 (PDT)
Subject: Re: [PATCH] configure: Test that gio libs from pkg-config work
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200928160402.7961-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8b6ed4df-4f3e-85ec-94c9-68a13b729786@redhat.com>
Date: Mon, 19 Oct 2020 13:27:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20200928160402.7961-1-peter.maydell@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 02:32:01
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/28/20 6:04 PM, Peter Maydell wrote:
> On some hosts (eg Ubuntu Bionic) pkg-config returns a set of
> libraries for gio-2.0 which don't actually work when compiling
> statically. (Specifically, the returned library string includes
> -lmount, but not -lblkid which -lmount depends upon, so linking
> fails due to missing symbols.)
> 
> Check that the libraries work, and don't enable gio if they don't,
> in the same way we do for gnutls.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I wanted a statically-linked system emulation binary (which, yes,
> I know is not really something we support :-)). I got one with
> suitably liberal use of --disable-foo configure options, and
> this was the only thing I couldn't work around that way.
> The patch is needed because there's no --disable-gio. I suppose
> we could add that instead (or as well)...
> Possibly meson offers a nicer way to do this, but this was
> simple and gnutls is doing the check this way already.
> ---
>   configure | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


