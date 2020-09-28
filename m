Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D98BC2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 16:43:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 891B0214D8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 16:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kw3le/Kt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 891B0214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMwFU-0004Pm-9r
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 12:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kMwEB-0003ep-D9
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 12:42:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49066)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kMwE9-0001bO-NR
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 12:42:15 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601311333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PsdMn6NTdoTquQ6rtzjGgaLoIxKBI5AHREQJS60Moko=;
 b=Kw3le/KtN2Y3wpq1HWWbVjpkk1B/34TezZbkYLarMH2ibHhdyxM8sA1KbNZZZVC/dBf/+W
 0qGTpCeW/LeRgbVXQKOR1isGxiL/nL7+LamJ+4SujOJQQ5H9Z9GhrV4DoRRcjAE3EXeKiv
 zIu7fiLGXJ86Y+2B1/5g5TqUwf7yFT4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-_v9aKt_qNuq49GEyjyXLwg-1; Mon, 28 Sep 2020 12:42:11 -0400
X-MC-Unique: _v9aKt_qNuq49GEyjyXLwg-1
Received: by mail-wm1-f71.google.com with SMTP id w3so600102wmg.4
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 09:42:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PsdMn6NTdoTquQ6rtzjGgaLoIxKBI5AHREQJS60Moko=;
 b=RMe5bRNcmMCfucpSr8fTAkbPLqzFzZXHFUjwyQ0ucTtOW2OqO6HWnIpw2vCed2+7qb
 Jx/yfxS276tFDRSU2yaE/6ZIdifUjPY1ky6B4y2eJHOgz7ozWr3CTUMNuJiDNNpKs1Y8
 OJ/4IDHAm8T0wrSdMBA55SRYR25bOdN13W/R6Xu0hC2OADkEaG9ZkuB64hMY4k4Z4y7k
 N3uMy7K/cV0/+pXx0O/S6E3rxxErHm59JeCX8ow5plxfMNyGSc470ep4W5ATkFe7Lzb8
 oLjuC4KU52EvCPFFB1RqynYjvktImb/cAPRHYhGajdllu9C0R1bCZd3qiKOJnKmnwMLv
 QkIA==
X-Gm-Message-State: AOAM533rTn5HbJq9a0v21svAnqy20LZpfqSFuO8nwD7yxN6wJ7n7/uo0
 C7bfUUQgWqCMdtOVD2Iez0gj1ja96e2xBY4sXIOH09NQvokHfolE/5dG7qcAqat5kFQbZ+xpV3N
 3v4JHVuuABNyfeag=
X-Received: by 2002:a1c:b608:: with SMTP id g8mr91675wmf.106.1601311330044;
 Mon, 28 Sep 2020 09:42:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwXUwUQAQY9UBpEQyKOFe/sBjw1rTM/G2x6LHenrmv0vBy94me0MEWCIswfHa6LcPrMKgXIA==
X-Received: by 2002:a1c:b608:: with SMTP id g8mr91662wmf.106.1601311329791;
 Mon, 28 Sep 2020 09:42:09 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:f4f8:dc3e:26e3:38c7?
 ([2001:b07:6468:f312:f4f8:dc3e:26e3:38c7])
 by smtp.gmail.com with ESMTPSA id y68sm1943704wmd.39.2020.09.28.09.42.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2020 09:42:08 -0700 (PDT)
Subject: Re: [PATCH] configure: Test that gio libs from pkg-config work
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200928160402.7961-1-peter.maydell@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0cbbe621-cae0-548b-fecf-0dd0e7b30fec@redhat.com>
Date: Mon, 28 Sep 2020 18:42:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200928160402.7961-1-peter.maydell@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:47:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/09/20 18:04, Peter Maydell wrote:
> I wanted a statically-linked system emulation binary (which, yes,
> I know is not really something we support :-)). I got one with
> suitably liberal use of --disable-foo configure options, and
> this was the only thing I couldn't work around that way.
> The patch is needed because there's no --disable-gio. I suppose
> we could add that instead (or as well)...
> Possibly meson offers a nicer way to do this, but this was
> simple and gnutls is doing the check this way already.

No, you'd get just that warning about static libraries not being
available; so I think either this patch or --disable-gio is fine.

Paolo


