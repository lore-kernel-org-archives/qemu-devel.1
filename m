Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41FEC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:51:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EAD92086A
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Az7CX8hL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EAD92086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2g3J-0003UR-QI
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 13:51:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39588)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j2g2h-0002bx-Dt
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:50:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j2g2f-0007HO-Uy
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:50:22 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48763
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j2g2f-0007Gf-Qp
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:50:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581706220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=25n0Pow/DHqYLzkIHe28dtmgWxeqpYNTEgmRYVFc6t0=;
 b=Az7CX8hLNEPlHVip+5ozHK+sfHkNd3SBS2S00/O9bIgRtpGbDwZ8SD5pKYP81zSHGdW5WE
 S8IWkiV99h4Wl/Fi2Yi5CkatZsDfHnAy0woGZnAaTSrcWuTgedRYUDwLwJrWN+wJgxc/8y
 cuuZcceI6qBqN9NoMxFaHOd5AWdIqCo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-9w7p4TG7NveO94s5bvMvBg-1; Fri, 14 Feb 2020 13:50:18 -0500
Received: by mail-wm1-f71.google.com with SMTP id w12so3967096wmc.3
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 10:50:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EFCGK+WcmpbaeNo3y6X06cTz7r4R6XqHhb72yc2+Br8=;
 b=YCLqKIeyJ1PueDAVGaHcjRTHrxv0e7j2VLaj3A3BdvrLsBPrGLfu2TGq4jiHISi97m
 qCbx3xERC2e8yZdh/lG/nt/auXD8xOR/YshEsSVPl4WjgWg+KxEGSZz/xHevS3YLo6IN
 nAI+sZood/9vthJwWaz2Uw/TJb11zPoynazbclf5ECkr5jaMxDnwrmiPY3zgvBBPnpM+
 zR4on6AuwIOS7+ZHkvfz6KOYa+dcjiU1DGi0/0rLXLG/74bqIXBJESt6bIU9UWGmS9SB
 q/KkdcZGOJp7Ssw1oeyDXX4l+GgwjTDAPe1TjIYdpbsPkRoJ9pUCo9RSwLZ7MstWgjCK
 3pKA==
X-Gm-Message-State: APjAAAWBekULQFde9v4AlqUSt8WoJCTxPK4DIQR8sdsZtxgevaPLL4D2
 N1inJyi7QDs4XQQKZmfQXL0eGXwKR0cwttplZdqSm3cgiRHeyrpgFrMbDQX0y6BWmnfsE1SIfvY
 T/5qMPvdgg7LzwsE=
X-Received: by 2002:a7b:c392:: with SMTP id s18mr6004023wmj.169.1581706217330; 
 Fri, 14 Feb 2020 10:50:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqxMdUWiW/iO/egqruu44ffqau+lXfPzqUhlIAyZkf8geIl+WPbsWqOmvVXngxZU5LLvugLrOQ==
X-Received: by 2002:a7b:c392:: with SMTP id s18mr6004004wmj.169.1581706217101; 
 Fri, 14 Feb 2020 10:50:17 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id x10sm8598669wrp.58.2020.02.14.10.50.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Feb 2020 10:50:16 -0800 (PST)
Subject: Re: [PATCH 02/19] target/arm: Rename isar_feature_aa32_simd_r32
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200214181547.21408-1-richard.henderson@linaro.org>
 <20200214181547.21408-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <49b39fe4-a63f-953b-159e-6b735ee0f0f3@redhat.com>
Date: Fri, 14 Feb 2020 19:50:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200214181547.21408-3-richard.henderson@linaro.org>
Content-Language: en-US
X-MC-Unique: 9w7p4TG7NveO94s5bvMvBg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/14/20 7:15 PM, Richard Henderson wrote:
> The old name, isar_feature_aa32_fp_d32, does not reflect
> the MVFR0 field name, SIMDReg.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu.h               |  2 +-
>   target/arm/translate-vfp.inc.c | 52 +++++++++++++++++-----------------
>   2 files changed, 27 insertions(+), 27 deletions(-)

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


