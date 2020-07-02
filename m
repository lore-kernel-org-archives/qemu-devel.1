Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69099C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 09:18:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30C3B20702
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 09:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FNEM0sGd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30C3B20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqvMi-0007VJ-BJ
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 05:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqvM9-000751-Kk
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 05:18:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57441
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqvM7-0000cr-Do
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 05:18:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593681485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C5N1gDouXR8B6tz/VAJ4XoAlQQp3VHJ0MwjErLprTUQ=;
 b=FNEM0sGdWjt1QdSP4nSASV8ZzZOGBwNJ9pj7g/Nhd+iIvtOxhvHO7Vs+Elbr4TJXJdo3kZ
 LPXwNn69M2CVfln4DZgClBL/U17iujvca16ih7fobKmDpAVvFt6bFDT22RhoUttQpHkJwK
 EWhfN5BJ/nbk/aR1GwEuW1IDBwfqCpI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-L2XvIeICPCa_2MqNwX6e9g-1; Thu, 02 Jul 2020 05:18:04 -0400
X-MC-Unique: L2XvIeICPCa_2MqNwX6e9g-1
Received: by mail-wr1-f72.google.com with SMTP id j3so4842992wrq.9
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 02:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=C5N1gDouXR8B6tz/VAJ4XoAlQQp3VHJ0MwjErLprTUQ=;
 b=G/T4dFdxWVXXiLWWT+5usa6jRKxoopnHS1/5gYesGMJmdjqMTUtxnyVPbOiQFq2Wg6
 +BLuo1w3gd0BrKEg0a2uZ4FkSMGlJ2gjj8t4Q8+PMPcJ5bMMpwhi+ZLihr1tXA5NqLuM
 zxe6I9rU6UUXoINotDaVTLjd7bQsJ52OXg8eWkNH6zPhgMEJsmFrwM6CJ084LUtW5fC2
 oKFnh4Kpc/diwCNDIjxRqJ70g5xUTzBW0xJHemehx6ywZ8Z2bXnln9x/okft9VYx0Imy
 M5ivGMrUZlO6IZWjCANDdVE1BuzVpzuLY1CvMfkx8dWaBLYx8hZqHyJ/riyXEI8q5SCR
 BqZQ==
X-Gm-Message-State: AOAM531yXo3QIKJcQmq2Ug6N9xZhmHN6QK+mFVgbNbVE9MxuazhK+O5V
 2bRafQOc2cQblG6Bo3Mp6cge6Jo0at3Wtmw3qtvss49CwG/urBgAXeTsBK7oWAAdweQaa6wGVPc
 rzboZJ4EosXJgVXY=
X-Received: by 2002:a5d:420e:: with SMTP id n14mr32435612wrq.164.1593681483305; 
 Thu, 02 Jul 2020 02:18:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDSiAAuU1vlzuNbDoXhGSaRiV4JEKl8ayv5JXLY+bVmG6TKfUnTen0RJ8fVlUdphprvimhpA==
X-Received: by 2002:a5d:420e:: with SMTP id n14mr32435593wrq.164.1593681483143; 
 Thu, 02 Jul 2020 02:18:03 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:2cad:376b:7d21:868e?
 ([2001:b07:6468:f312:2cad:376b:7d21:868e])
 by smtp.gmail.com with ESMTPSA id d63sm10472107wmc.22.2020.07.02.02.18.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2020 02:18:02 -0700 (PDT)
Subject: Re: Race with atexit functions in system emulation
To: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <87v9j7qyuh.fsf@linaro.org>
 <CAMgSi0G+_3ZVDMpYL5XYWvUyUUtP__zUCLPpRJ+adn3t7B8a7g@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <aabc2e67-944c-aa65-f6d9-24cf2df6df65@redhat.com>
Date: Thu, 2 Jul 2020 11:18:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAMgSi0G+_3ZVDMpYL5XYWvUyUUtP__zUCLPpRJ+adn3t7B8a7g@mail.gmail.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 03:23:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Pavel.Dovgaluk" <pavel.dovgalyuk@ispras.ru>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/07/20 08:18, Pavel Dovgalyuk wrote:
> Is it true, that semihosting can be used to access (read and write) host
> files from the guest?
> In such a case it can't be used with RR for the following reasons:
> 1. We don't preserve modified files, therefore the execution result may
> change in the future runs.
> 2. Even in the case, when all the files are read only, semihosting FDs
> can't be saved, therefore it may not be used with reverse debugging.

Since there are many cases in which semihosting and RR can work together
well, I think the fix here should not be to just block semihosting.  The
replay_finish issue is just an example, there can be more atexit handlers.

Paolo


