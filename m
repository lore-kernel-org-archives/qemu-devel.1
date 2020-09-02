Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8971AC43461
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 12:17:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CE1E20767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 12:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NeQo60q0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CE1E20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDRhg-0003I8-FE
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 08:17:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDRgg-0002Zj-Gg
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 08:16:26 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44017
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDRgd-0001jI-Hw
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 08:16:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599048982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uhRKxfHunVKXu/B+eep13Mnk4+rqNm62itVbd5WUpHI=;
 b=NeQo60q06n88vmQ0Cjt2nVXDbUz/H8tAKQtk6qremCaZTQufU4m8LxgoTxaGYVCOO9HCiv
 Rsyr1acJVE44Sr6vAs7zruDbwoz9dchbBVOYCNuJ8CYgwnfPDwE02BAaK9HwAPYge0iXGy
 iraXejfO8EGOs31qgvPc3p9zCPAGGGE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-O-bvXBNuOaeEQdKxrn1E5w-1; Wed, 02 Sep 2020 08:16:20 -0400
X-MC-Unique: O-bvXBNuOaeEQdKxrn1E5w-1
Received: by mail-wm1-f71.google.com with SMTP id m125so1840372wmm.7
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 05:16:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uhRKxfHunVKXu/B+eep13Mnk4+rqNm62itVbd5WUpHI=;
 b=Cb3xsK2QBkFDMXHnNK/Y+wdK3pH/ChSJHAHDKNsWyp1fHuFUh2aQI8H4FeqwVfK3Iw
 u7M3PILtshgY50IHoSYHDK075nN5iEOKrxyLcJ3QGZV5U+NmWKv+bjhjIo6yfwBfyWXG
 YhA1Tf8M+c5DA6PQlo55oNavhX1vxpZamqp0pcLm4ZZ7KJ/kgEYND6TB458DI5wAwOsw
 blyj/W7R2J8PoB4n01fM7QwKcYqF764khWROwfzEdkqddzTfbr72HFKtArqtk3m48wVC
 OcsskLCDWxBdT1A54/S2AjAUhm9lS8jYmj8YLhnQSipSNGMpH7vaiwCdMvCae+KsCWRl
 gVqw==
X-Gm-Message-State: AOAM533yd/RumWOngswUi4lSHXwIX4L/VjdwtGMh9Xmsoq/GQ3/6R//h
 mGxzJsGEc1QOAxikL//iqo5loq9pji7SGrcwevvPgEpzHkHf7LlbMVLi9PVRsA+MSyY/7SYXrNX
 AcrAfF5Goz9zk0CM=
X-Received: by 2002:a1c:1f42:: with SMTP id f63mr367620wmf.1.1599048979095;
 Wed, 02 Sep 2020 05:16:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGwj2+QXg9jUszeKPDEIX/ZRjPmxNgiO50uPQ/9NeQbII+sjvTb8QNOVtnLcffjKP23ByYJQ==
X-Received: by 2002:a1c:1f42:: with SMTP id f63mr367597wmf.1.1599048978870;
 Wed, 02 Sep 2020 05:16:18 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.173.193])
 by smtp.gmail.com with ESMTPSA id m10sm6069076wmi.9.2020.09.02.05.16.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 05:16:18 -0700 (PDT)
Subject: Re: [PATCH 00/13] Make QEMU installation relocatable
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20200901062020.26660-1-pbonzini@redhat.com>
 <156da43a-4744-ac6c-fc4b-54788a40b3e9@ilande.co.uk>
 <CABgObfYcaCsZNYof9nd7gzCOY_6qN5MV+xD6dw7W4D4ircsdaQ@mail.gmail.com>
 <7516c253-0448-b5cd-18a0-45caaebc1d05@ilande.co.uk>
 <0db09727-a909-71db-3628-4edb3ce87f2b@redhat.com>
 <76488c26-a3a7-be05-01ec-b29985ab29e7@ilande.co.uk>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <25b47439-05da-5cb5-f9d8-65e453e00275@redhat.com>
Date: Wed, 2 Sep 2020 14:16:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <76488c26-a3a7-be05-01ec-b29985ab29e7@ilande.co.uk>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 03:24:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.324, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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
Cc: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/09/20 13:42, Mark Cave-Ayland wrote:
> The main issues I can see are that the .exe files end up under /msys64/qemu
> and the ROMs end up directly under /qemu rather than in $DESTDIR/share.

This series doesn't try to change the layout; it only makes it possible
to do so (because QEMU is now able to look for ROMs relative to the
executable).

Just to be on the same page, how did you run "configure"?

> Do we know why there is also a qemu-system-ppcw.exe that appears?

That executable doesn't bring up a console window.

Paolo


