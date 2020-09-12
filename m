Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C639C43461
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 18:54:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED77121531
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 18:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GiGJ7mFe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED77121531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHAf5-0003Ts-Ui
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 14:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kHAeX-00030U-Bf
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 14:53:37 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40004
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kHAeU-0001yF-T9
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 14:53:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599936813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nw8+m4akWB79PY3R4MAhbkoOevZxlZLzZlfCGihMWzo=;
 b=GiGJ7mFenGzZ/GI5kY7FvzX1MO82oBGV4hhXw7304wRmv49pqxhcUplUZ96E5flbcKsxPT
 80PQuUEUf2deI+agsrF91z5nlAARlFKVfJdZwNctn6VwBl6npzcvMy4xBGqxJ02SX3qduk
 ugHDYmwtdbicvEU4Ys0c1y1ubjcAwmU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-UK3-YrfePdKIko1fFodeyQ-1; Sat, 12 Sep 2020 14:53:29 -0400
X-MC-Unique: UK3-YrfePdKIko1fFodeyQ-1
Received: by mail-wr1-f69.google.com with SMTP id x15so4594059wrm.7
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2020 11:53:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nw8+m4akWB79PY3R4MAhbkoOevZxlZLzZlfCGihMWzo=;
 b=aJecqPp6f1x13l05pixfYsVdEUicR42CRQ+DyscKuzizB9SocYlTesHN29AItVYafK
 71OlIuX2v5vEI6EWMRYEGK1jn+Ox/PbsHgSiPhEeqTA0QzB4N3UeQsF0GWGe3T4nh8qv
 /27vWtcDWd5HpOaYoUiV8WhSkn9HM+bb5qZMCyJ20nNlTCO/d8Oz+x5tR4YFQxiBEJ7Z
 PmaSXmvU8beChJexsCT4W9thiirHRpKlE8zvBcQIWMbqUIoMum1Ah2PCL5QEqKI0hMHj
 SxgfbbBDAV1MNxM3aZ388O10RZvs9l4W2E2GJmewu3xQ9/DL2j+ePm+N9joB9zHgsoby
 zkPg==
X-Gm-Message-State: AOAM532aIYkFODpIuR5Ujb/gKhQ+QMkYa/em6ruoOw5AICsPwmvq8frS
 RPRp7vhOiqjdHDOxNYDjlj93Uso5wdDHp1rL4xr4C0aDRIvpTGmSJN3VcnSLZCozYiIoh28zH63
 b50aewnASSX3iNsE=
X-Received: by 2002:adf:81a3:: with SMTP id 32mr7839211wra.368.1599936808025; 
 Sat, 12 Sep 2020 11:53:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0mEHZ9SdQqBrkc8IhA03fF+Yd5uhRcE0MEAvicj6sNBmnYxDpKoQwGAoTHNMtE3icUzVtFg==
X-Received: by 2002:adf:81a3:: with SMTP id 32mr7839198wra.368.1599936807835; 
 Sat, 12 Sep 2020 11:53:27 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9fd9:16f2:2095:52d7?
 ([2001:b07:6468:f312:9fd9:16f2:2095:52d7])
 by smtp.gmail.com with ESMTPSA id h17sm12612328wro.27.2020.09.12.11.53.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Sep 2020 11:53:27 -0700 (PDT)
Subject: Re: [PATCH 0/3] gitmodules: add qboot, meson, and vbootrom mirrors
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200909101642.17698-1-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <51582674-6c83-245a-709a-95304003b3e5@redhat.com>
Date: Sat, 12 Sep 2020 20:53:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200909101642.17698-1-stefanha@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/12 14:53:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.543, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/09/20 12:16, Stefan Hajnoczi wrote:
> This patch series adds qemu.org mirrors for qboot, meson, and vbootrom.
> 
> vbootrom is not yet used by qemu.git/master so you may wish to hold off on
> applying the final patch.
> 
> Stefan Hajnoczi (3):
>   gitmodules: switch to qemu.org qboot mirror
>   gitmodules: switch to qemu.org meson mirror
>   gitmodules: add qemu.org vbootrom submodule
> 
>  .gitmodules | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 

Thanks Stefan,

I created the github mirrors too.

Paolo


