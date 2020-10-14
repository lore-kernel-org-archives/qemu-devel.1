Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743B7C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 18:12:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3D5C21D81
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 18:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CQj2iD5A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3D5C21D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSlGM-0007yZ-OJ
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 14:12:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSlCV-0005p5-4O
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 14:08:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25616)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSlCS-0000SV-OA
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 14:08:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602698910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gw4+jbDCGpTkhxsYnLRx5qsgwgyiwiGU8BCS/yimy8w=;
 b=CQj2iD5A0HfUO0RA8gtIFVRonKYGVQo3chv38fzT7xvxdRzRQKbDQdMDJGT/mGTPFcwUkD
 Y72lnc3Ff1C11e02wQ1yZGZzlV2s1SMOjJWRmmYNqJu2xAXuTLvB6A1YDy3/xI+hPCK3bN
 YEWhhNDgc4A0v1KzOlRp86rn+EaUdpQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-wmcTVb_2NqOgK1BTRAnCXQ-1; Wed, 14 Oct 2020 14:08:29 -0400
X-MC-Unique: wmcTVb_2NqOgK1BTRAnCXQ-1
Received: by mail-wr1-f71.google.com with SMTP id v5so24595wrr.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 11:08:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gw4+jbDCGpTkhxsYnLRx5qsgwgyiwiGU8BCS/yimy8w=;
 b=siz7O6PEXvxlhXr4jtogbpKuQvjhLMvNjsYQ5KPqlk9LsU6i16AOZ+nUyjp80lB0Xk
 fiecJAfWH4Kj58BPjIvwHUuiXMtLUsJIiPzE8EAcpAubpbUK9xcYpx4/M6r5Er+ivq7Q
 M8VFE2udCgCAcXrmMiOBPSd2zwv6n9XKamrJYcu4NL/X1L9RnqgLIkwyA78i3AGDY+cV
 +kN5twwsGPzAhh1+7OCxKoVUFcViFnIEGLD2pITj46mZTVe1bq4JTpKOVybDeuRz8IZx
 3wDoUcAfVBMGdFfduWUcauc6UgFukWDYorlCul2LGcWdCoej/OFGfIO6syC8Gi1Q/jwp
 RQtQ==
X-Gm-Message-State: AOAM532dy21wCP2z4pMU4Mjfhx5l68IBGhI5p7rwXwRzt53GvAUOmQiR
 TnBUZ4ZKOBUfXkXPA0hS4fiowZuUTqfw1m2fKH65qpkCSsX9KBu4vbeHKO4nN960UjfxUyhGDgK
 OuKOdlRstfWsmtX4=
X-Received: by 2002:adf:f50c:: with SMTP id q12mr10206wro.249.1602698907962;
 Wed, 14 Oct 2020 11:08:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLU2sh4kiweW8S/Fzy3fMt2nIUkroAd1Zq4O0Nt+iL8H+aBXJksg2pgwjBSb41zUmAXwyTgQ==
X-Received: by 2002:adf:f50c:: with SMTP id q12mr10188wro.249.1602698907728;
 Wed, 14 Oct 2020 11:08:27 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id w11sm155762wrs.26.2020.10.14.11.08.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2020 11:08:26 -0700 (PDT)
Subject: Re: [PATCH v2 13/15] python: move .isort.cfg into setup.cfg
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20201014142957.763624-1-jsnow@redhat.com>
 <20201014142957.763624-14-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3f8fc41f-64f4-ba00-24b9-b4e19005abbf@redhat.com>
Date: Wed, 14 Oct 2020 20:08:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201014142957.763624-14-jsnow@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 03:37:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Ben Widawsky <ben@bwidawsk.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Rohit Shinde <rohit.shinde12194@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/20 4:29 PM, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   python/.isort.cfg | 7 -------
>   python/setup.cfg  | 8 ++++++++
>   2 files changed, 8 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


