Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_TONAME_EQ_TOLOCAL_SHORT,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FA4C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 10:41:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C60B20704
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 10:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BE5qispJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C60B20704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYRqL-0005ty-5p
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 06:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kYRpO-0004uN-El
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 06:40:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57058)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kYRpJ-0005yA-5n
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 06:40:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604054407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MXP7LpgDRMMjFi3rGqXxkYtg4iZDp6ql1pyWYVnAKo0=;
 b=BE5qispJ9/O5A2HZLPhBcqhvKa+uzddLFuzYLz9FsWIwOKl56RK0BVsL5DAAUlFFBbsqUL
 eSLs5r6OJmKnupr5NHdV2DFGXFZo5eAxb4atTFieOL7qGRTgXNZUgnFtasJFyzBm5Be+TP
 aGqjr3KEoRm+vbewZgZccCaqQbgidk0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-S33nwGNJOyulXy2aiFoYKA-1; Fri, 30 Oct 2020 06:40:04 -0400
X-MC-Unique: S33nwGNJOyulXy2aiFoYKA-1
Received: by mail-wr1-f69.google.com with SMTP id h8so2502822wrt.9
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 03:40:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=MXP7LpgDRMMjFi3rGqXxkYtg4iZDp6ql1pyWYVnAKo0=;
 b=aYCE76+gvAD6dZUl3fApKnUQ1F+uXmZFKNE9igCoodmL3qaksOCL0qdv+9im7d9axI
 rooh3MH6WsUDjzVPrngBs7brOH8+6tKGWowIVTiT9EvpW6xspSamzaUME/W5J1AR6zc4
 VXaEXq30dvtT5xYOHgotQ21p/J8SZ5QhV/ebINsrjL7qr0B6mbVzhgxYXXJKvlKm4D/c
 ylnq2CSve9nrkYd5Aiw3WKUnlYNFavR5VwnXJwirjBr9tWaJqASWCcvqZ+SztHx6BJng
 qBsi5L2CpRYA676Y5mCR0tWOm2dRpiNTs5I+ANqGX4pGCvZv47haiNkenXCO5q/sZ9F2
 MfoQ==
X-Gm-Message-State: AOAM532aXv7WIofJxHML4b+r3TMTdjYoZTYb1ldFS/wv3vwA3l4EHC0F
 rLokxr5qn5rLRpy5Ed1p04V83F5mJ9CkOMntM0QtxbpDUV46NBhfHHiIaOxXTYMH76fx+m2P4m2
 TG4hAPaD4T7IQSB0=
X-Received: by 2002:adf:c58f:: with SMTP id m15mr2326377wrg.144.1604054402910; 
 Fri, 30 Oct 2020 03:40:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVaTNQ1omoc+ElQ7pO3lwlaOxmMH1VYeCU6N3Fsp4/JmapZAs5QWvYEa8VdzvlCB4OduGArw==
X-Received: by 2002:adf:c58f:: with SMTP id m15mr2326351wrg.144.1604054402746; 
 Fri, 30 Oct 2020 03:40:02 -0700 (PDT)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id a17sm10207578wra.29.2020.10.30.03.40.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2020 03:40:02 -0700 (PDT)
To: qemu-devel <qemu-devel@nongnu.org>, qemu-discuss <qemu-discuss@nongnu.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Subject: QEMU continuous integration BoF session at KVM Forum 2020
Message-ID: <4f68c407-a46b-7340-678a-3389c2f0aad1@redhat.com>
Date: Fri, 30 Oct 2020 11:40:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 02:24:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PDS_TONAME_EQ_TOLOCAL_SHORT=1.999, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Yash Mankad <ymankad@redhat.com>,
 Marcelo Bandeira Condotta <mcondotta@redhat.com>, Jeff Nelson <jen@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Willian Rampazzo <wrampazz@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There will be a birds-of-a-feather session at KVM Forum,
a chance for us to get together and discuss about QEMU
continuous integration.

These sessions are a good opportunity to reach agreement
on topics that are hard to discuss via mailing lists.

Please add your suggestions to the agenda:
https://etherpad.opendev.org/p/QEMUCIKvmForum2020

The meeting link is:
https://meet.kernel.social/KVMForum20QEMUCI

Time: Friday Oct 30 11-12AM (GMT)

Regards,

Phil.


