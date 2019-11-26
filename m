Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8EDC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 22:06:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E6412064B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 22:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L9KhMPCQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E6412064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZiz1-0000iX-D7
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 17:06:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55193)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iZiwv-0007iY-VK
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 17:04:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iZiws-00007M-FI
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 17:04:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29636
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iZiws-00007C-7s
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 17:04:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574805881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aHw6rp8pwubQP9KoglpGS3FiYdJPxjVn2aNnSHaPx0M=;
 b=L9KhMPCQoHOzVcmwvY2fhtoeC4EPOQrEPxYx2eh58bucym1pZarS9zA1v5A4+s1Gu6gk8B
 p5J4Buy0cjwN0WEiPKPUEjfW0tlUhDsHa1v3tQeGurdPOcBhntMk1DFLdW1egI58sTJ7v4
 BGTWYc2Lb20szGIAjVLhsNege+rJ7FM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-YXmN4ndxNlqqmRn3CecmAA-1; Tue, 26 Nov 2019 17:04:38 -0500
Received: by mail-wm1-f72.google.com with SMTP id l11so1586960wmi.0
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 14:04:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aHw6rp8pwubQP9KoglpGS3FiYdJPxjVn2aNnSHaPx0M=;
 b=rDF0QKA2QZUyd6Mm5wo9bTnPxS7Ps/3gYYc2nTkoSyZ/3cMuZSwTJz5XGIVkz51jJH
 +xzPlkIVLUEvP/VSp1Si0iUZaVQX4Cqum+9NMvxGIW6xFB4jcSZi0oWK+Phlh9fA6HSR
 iYAnwU7HVmXhqznrToAysKgqZLAPW03O0HGld9GEFSSobWDevdby2CS26sbNHduKY6AR
 jIyPRwQqciEglx0+PN/OspStIJ8GAr+VqxHcbHRMHdwHR+zY5d9B4IAiYWaNFMcxQShr
 Bz343bHqQHt951prUEmDW21d/PAW3MKQi5gmeNAF8SDUKLHLkIVHNNSme2ydujCTtSYi
 qn4Q==
X-Gm-Message-State: APjAAAXgUBu5GJ4eRgafPaiqguXFwkFca10hwYUguiE4vYOya8UEwbUO
 TAJJQhDGTGXycxXZKm5PuHz+CbQxn6eNMnhJqrqIEecm0YfKD1inucDYLkAtJ4p14oBA/eSsayS
 QVB90j4Y1HXAoE4c=
X-Received: by 2002:a1c:96c4:: with SMTP id y187mr531453wmd.112.1574805877704; 
 Tue, 26 Nov 2019 14:04:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqzZwazgDEZTQ62ihpx+JRqgEIFn+s8a1dnEaVVnnT/UtSyAYogCzMiETEuSUXFywV6M2BZJ2g==
X-Received: by 2002:a1c:96c4:: with SMTP id y187mr531438wmd.112.1574805877459; 
 Tue, 26 Nov 2019 14:04:37 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id 16sm6058507wmf.0.2019.11.26.14.04.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2019 14:04:36 -0800 (PST)
Subject: Re: [PULL 0/5] i386 patches for QEMU 4.2-rc
To: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 pbonzini@redhat.com
References: <157475994490.31055.5778115059405326734@37313f22b938>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e5352867-943c-6010-4700-78a0e25cea10@redhat.com>
Date: Tue, 26 Nov 2019 23:04:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <157475994490.31055.5778115059405326734@37313f22b938>
Content-Language: en-US
X-MC-Unique: YXmN4ndxNlqqmRn3CecmAA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

On 11/26/19 10:19 AM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20191126085936.1689-1-pbonzini@redhat.com/
> 
> This series failed the docker-quick@centos7 build test. Please find the testing commands and
> their output below. If you have Docker installed, you can probably reproduce it
> locally.
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> make docker-image-centos7 V=1 NETWORK=1
> time make docker-test-quick@centos7 SHOW_ENV=1 J=14 NETWORK=1
> === TEST SCRIPT END ===
> 
>    TEST    check-unit: tests/test-thread-pool
> wait_for_migration_fail: unexpected status status=wait-unplug allow_active=1
> **
> ERROR:/tmp/qemu-test/src/tests/migration-test.c:908:wait_for_migration_fail: assertion failed: (result)
> ERROR - Bail out! ERROR:/tmp/qemu-test/src/tests/migration-test.c:908:wait_for_migration_fail: assertion failed: (result)
> make: *** [check-qtest-aarch64] Error 1

Should we worry about this error?

[...]
> real    9m26.610s
> user    0m8.328s
> 
> 
> The full log is available at
> http://patchew.org/logs/20191126085936.1689-1-pbonzini@redhat.com/testing.docker-quick@centos7/?type=message.


