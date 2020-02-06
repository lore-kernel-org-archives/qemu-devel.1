Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB69FC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 15:25:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86CA72465D
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 15:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QKPhbquw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86CA72465D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izj1s-0006Hi-Mg
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 10:25:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59427)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izj1A-00053d-Ig
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 10:24:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izj18-0005mX-6l
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 10:24:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55803
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izj18-0005jT-1g
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 10:24:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581002673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cly84hWBEdaqk5oAmPTQHI9PvzT0kTKXVvQMQwMjBIw=;
 b=QKPhbquw+r0KEeUXnEGdLs5y52tLOUOvS26Vi0JJvMaX1LzqXBoDRz7bzN6kAESidhFo/m
 jIpMJ5I7sr2XmMAmabWfo0WNV60B+valVt2wIkb1RGek7RyDqoveLwq54fSBI7Xo2aOToX
 gIDfFHlx6sQao+EuNBA6dNTTmMzr9rM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-6z8KGw5KMZSOBWy19XELqg-1; Thu, 06 Feb 2020 10:24:16 -0500
Received: by mail-wr1-f72.google.com with SMTP id s13so3558256wru.7
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 07:24:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cly84hWBEdaqk5oAmPTQHI9PvzT0kTKXVvQMQwMjBIw=;
 b=bSXc2e2X6njFIuwenoFkl1FHNVD3eMhtvD53aUh80RWXCJRnUjzEtyWuwnk1DzSABw
 GkTiszD51WZkLJCZRQpROTVAnyg7/MaAIqqXpD5ISwZ/qfx4gWG89D0BxWuVAjzsYtxx
 dNhc86Yrdx0pFhV69anzvaqhFLZErGCxbsn+AQ2EqvgEUkpv8JlyNzZcuEoRguJaHg7S
 DVIOGYRhqc0/CaheaaHKp0YY/uLlgG/hRo9w+s7XqTYE5xfMlRNFATbulmOEQiqq6LTY
 ukDkUOX6e7FiBKwsfLqqwPbUOk547WLKXF6Oh1djnl7Mll70oaKpBcsVkUp+tkTKD0q3
 +ChA==
X-Gm-Message-State: APjAAAVUfajj2uJliiVoVFsFN6M5rq7uwQHsqYsL+f18dPrXSYHb2LGP
 ibi+xjKFLyazN2VgAeGlAw/RvotHcRhuQifdy0WxFnyZh//urSgVainCtFDgESQXYh4oWv7jIHU
 JFdPPCJGZqQZLEX8=
X-Received: by 2002:a5d:4b03:: with SMTP id v3mr4594487wrq.178.1581002655139; 
 Thu, 06 Feb 2020 07:24:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqw41nWziBfQ2TkECc0YcfhGNU7dXuV8CbheCIH5b4WBQY3jIQ+Oh+zNzyaXaYVMIfkyiA+QZw==
X-Received: by 2002:a5d:4b03:: with SMTP id v3mr4594429wrq.178.1581002654476; 
 Thu, 06 Feb 2020 07:24:14 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id g25sm13324521wmh.3.2020.02.06.07.24.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 07:24:13 -0800 (PST)
Subject: Re: [PATCH v2 0/6] tests/boot_linux_console: add extra boot
 acceptance tests
To: Liam Merwick <liam.merwick@oracle.com>, alex.bennee@linaro.org,
 fam@euphon.net
References: <1580914565-19675-1-git-send-email-liam.merwick@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4a924e1f-0c4a-931f-a261-041387f9de81@redhat.com>
Date: Thu, 6 Feb 2020 16:24:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1580914565-19675-1-git-send-email-liam.merwick@oracle.com>
Content-Language: en-US
X-MC-Unique: 6z8KGw5KMZSOBWy19XELqg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, wainersm@redhat.com,
 slp@redhat.com, sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/5/20 3:55 PM, Liam Merwick wrote:
> Add acceptance tests for the microvm machine class, PVH, and the
> new qboot BIOS.
> 
> In the case of the test to boot an uncompressed kernel there didn't
> seem to be any suitable uncompressed kernel on https://archives.fedoraproject.org/
> (there is a vmlinux in kernel-debuginfo but that RPM is 575M and
> caused timeouts when populating the Avocado cache when first run)
> so I chose an RPM with kernels for Kata that is 14M.
> (there was a discussion in [1] regarding testing PVH boot but it focussed
> more around building a vmlinux binary during testing).
> 
> [ What prompted these patches was the discovery that a 'pc' guest booting an
> uncompressed kernel (PVH) with a PCI netdev hangs (before we even get guest
> console output) when bios-microvm.bin (qboot) is supplied via -bios
> (no issue when using 'q35' or 'microvm' machine classes).
> 
> E.g. adding the following line to test_x86_64_pc_qboot_pvh() is enough to
> trigger a guest hang during startup:
> self.vm.add_args('-netdev', 'user,id=n1', '-device', 'virtio-net-pci,netdev=n1')
> 
> I bisected that issue to 176d2cda0dee [2] in 4.1 but haven't worked out yet
> how/why the "die-id" changes impact the qboot/PVH combination
> (the boot succeeds with any subset of those boot variables).
> 
> Is booting the 'pc' machine class with bios-microvm.bin something that QEMU
> officially supports or is qboot intended for microvm only? ]
> 
> Each test added here adds about 1.5s to the overall runtime.
> I have run them through the Travis QEMU CI [3] and those acceptance tests pass.
> 
> v1 -> v2
> Removed unnecessary qboot test for microvm in Patches 2 and 5 [Stefano]
> Added SeaBIOS test for microvm to Patch2
> Fix path concatenation in Patch4 to use os.path for filesystem paths [Wanier]
> Added Patch6 to fix extract_from_deb() to use os.path for filesystem paths
> Used dictionary to store kernel info in Patch5 [Philippe]
> Dropped patch with typo fix that has been queued separately
> Added Stefano's R-b to the patches which have not significantly changed.
> 
> [1] https://patchew.org/QEMU/20191206140012.15517-1-wainersm@redhat.com/
> [2] 176d2cda0dee ("i386/cpu: Consolidate die-id validity in smp context")
> [3] https://travis-ci.org/merwick/qemu/builds/645487393
> [4] https://github.com/wainersm/qemu/commit/8f705e98df90b436b0f4946331d441309c437f7b
> 
> 
> Liam Merwick (6):
>    tests/boot_linux_console: add microvm acceptance test
>    tests/boot_linux_console: add BIOS acceptance test
>    travis.yml: install rpm2cpio for acceptance tests
>    tests/boot_linux_console: add extract_from_rpm method
>    tests/boot_linux_console: add PVH acceptance tests
>    tests/boot_linux_console: use os.path for filesystem paths
> 
>   .travis.yml                            |   1 +
>   tests/acceptance/boot_linux_console.py | 114 ++++++++++++++++++++++++++++++---
>   2 files changed, 106 insertions(+), 9 deletions(-)

Patches 3, 4 and 6 applied to my python-next tree:
https://gitlab.com/philmd/qemu/commits/python-next


