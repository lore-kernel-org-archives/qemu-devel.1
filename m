Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286E6C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 16:28:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B818F20708
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 16:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QilC6aCx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B818F20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL7dD-0007Uh-Nr
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 12:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kL7bm-0005ZR-W5
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 12:27:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49953)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kL7bk-0000um-AF
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 12:27:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600878423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wJlnyCDymov13Jk60v/CUr4C1zQamRhaj6udcCqNQiM=;
 b=QilC6aCxnF7i2on9rKojJbsR4PQ5Mjm9ft1+PDGJuYcecJ++x0DrQeJ4mq/ZPva8nTEKL5
 mPG3P1JKvw4qG+VZYbr0ylGbLtIhcvG9AS2lMOmuL7Pc0sjZ8/LgfRc+c90RFOpgtLYcsE
 1obDkq61+yv909TfuBJTAPxbDp0MYy0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-vz18FP23MFqnBSt1zAhMsQ-1; Wed, 23 Sep 2020 12:27:01 -0400
X-MC-Unique: vz18FP23MFqnBSt1zAhMsQ-1
Received: by mail-wr1-f72.google.com with SMTP id a12so36048wrg.13
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 09:27:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wJlnyCDymov13Jk60v/CUr4C1zQamRhaj6udcCqNQiM=;
 b=savP/b1PZtkwujI3yB1UrFmGwZVkAySvx5FdctMsAebVNB3XqkHQ3TqKIMdTzIVL5d
 5tVAyHBRgp9YXCPXPN5IujvigG6z9XpeyIRili/XazGx4kD+s9zyc4qy5h03O0Sq+gID
 DAWVdRvS2tywgE3Q23ljiZOPB2IPx3fUK4WFiZU4/dKfA310dOwZI2AFqKtUoI2mdDgI
 7DF93AFpH5fkaA3vjA85/tF9NlV1QaAz+cedPq6g1zAsPo4xXDmO+by/3LCUsQXDP3+R
 83+3lHlAFIDxS80756n2cKn6uvCNpH3OCN4rD7Mewo73qBwj8Ko1qCyxLS1Gyzdo2vvi
 vE1Q==
X-Gm-Message-State: AOAM5318cGDV+8qz6Gwwi23UFMUhIZlUPX0WbeOIUTltxJHMfQb4fKAz
 Uqa9F3WTf8i1ZTXtYjFmZqb9hA4neNJw3ms7TkOTO6CGJgMoaIzsgTNKZF7g3ptjYli79EmM6KR
 4RM22baha4vV78X4=
X-Received: by 2002:a1c:6254:: with SMTP id w81mr387531wmb.94.1600878420118;
 Wed, 23 Sep 2020 09:27:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwINpjG9075gyFKLhzV6fjuUwuKGcgQRIcExXkX8jmCWcPYRcMA8VoLx1RMI7EbY5Gyj1G6Eg==
X-Received: by 2002:a1c:6254:: with SMTP id w81mr387511wmb.94.1600878419822;
 Wed, 23 Sep 2020 09:26:59 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:15f1:648d:7de6:bad9?
 ([2001:b07:6468:f312:15f1:648d:7de6:bad9])
 by smtp.gmail.com with ESMTPSA id m13sm307191wrr.74.2020.09.23.09.26.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2020 09:26:58 -0700 (PDT)
Subject: Re: [PATCH] travis: remove TCI test
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200923151030.1613449-1-pbonzini@redhat.com>
 <9f33653a-30bc-ca38-cec6-c0fbe17cbea0@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fe045d2d-022b-0a7e-8330-a2def315c16f@redhat.com>
Date: Wed, 23 Sep 2020 18:26:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <9f33653a-30bc-ca38-cec6-c0fbe17cbea0@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/09/20 18:04, Thomas Huth wrote:
> On 23/09/2020 17.10, Paolo Bonzini wrote:
>> The TCI test is already performed on gitlab CI, and it fails because
>> Travis tests (generally) disable tools and therefore do not have
>> "make check-qtest".  Just remove it.
> Huh? Where is it failing? It currently seems to work fine:
> 
>  https://travis-ci.org/github/qemu/qemu/jobs/729440748
> 
> Anyway, since we already have similar job in the Gitlab-CI, I think it's
> ok to remove it from Travis, so with the commit message tweaked:
> 
> Acked-by: Thomas Huth <thuth@redhat.com>
> 
> 

You're right, it's only broken on my own branch (due to "meson: qtest:
set "depends" correctly").  Currently we're running all qtests with a
QTEST_QEMU_IMG pointing to a nonexistent executable, and I'd rather
avoid that.  In that patch I took the big hammer, but we can also decide
not to remove qtests for --disable-tools and add a little bit of
complication to tests/qtest/meson.build.

Paolo


