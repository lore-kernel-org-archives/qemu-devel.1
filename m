Return-Path: <SRS0=nDBX=XQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD534C49ED7
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 13:11:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CC892080F
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 13:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKt3xr4A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CC892080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBfAE-0001IZ-GR
	for qemu-devel@archiver.kernel.org; Sat, 21 Sep 2019 09:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58438)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vvavrychuk@gmail.com>) id 1iBZT9-0004nP-Oz
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 03:06:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vvavrychuk@gmail.com>) id 1iBZT8-0001zh-DQ
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 03:06:11 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:46441)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <vvavrychuk@gmail.com>)
 id 1iBZT7-0001yQ-Jc
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 03:06:09 -0400
Received: by mail-lj1-x241.google.com with SMTP id e17so9058462ljf.13
 for <qemu-devel@nongnu.org>; Sat, 21 Sep 2019 00:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=in-reply-to:to:cc:from:subject:message-id:date:user-agent
 :mime-version:content-transfer-encoding:content-language;
 bh=rjdSGKN4ZlM0jQwLqZTBTz0vfDBhuv1yVmg18hbtJK8=;
 b=XKt3xr4AZSCHnnfLRRZXC+DddTvWb1uspj0sIK4iC+aT0tjuFiX/wNg/N/mda3rB6E
 1ZeFG2cazxnnegkyG9MsHdewd3gy0PeMkk1MpW9AKlNGCKx3fLc5JhnygVSSbM/0nqIi
 Rn58t9LQooRS+PhLhP73VYh9GV9IjIk/omfSxaWNIYpDXdiS1j3YLA4fJL/GebojJ55R
 KQiU6mJp8+F9xOvFBUo7TnkAGRzPiwTh4hbD//Bl+YffFDk0Q5AFgKCUb7oHKNYVgn7V
 ZR+EJqRa17xcgdzkIP6aZJenpHfWRrFrrSPl5ug/hciZIjosXwzaioVb1xU67CPB8eIs
 QZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:in-reply-to:to:cc:from:subject:message-id:date
 :user-agent:mime-version:content-transfer-encoding:content-language;
 bh=rjdSGKN4ZlM0jQwLqZTBTz0vfDBhuv1yVmg18hbtJK8=;
 b=a9925ZKXbF3DcpBq0G5jMGEuGdgUHhuO2j4/FJ+pFjyTNRpYO56SBzz/MRhsQMjB78
 rF/ATkrMMSmxuLfiofpCv1KxH49nkuEMoEASmUrDSOjjnhmWERnGh8LBn7g30nBSu8F/
 8XtZol5I4KGEbOBMTnDC8yL9YULLJzBJTEmolPPyNzQ0XD/VNmkmlEvTMOORjd1rZY3m
 27PuJxwENkKlX/xG8/CEwUSRq9bPHQfZl3N5Hyj9rf610XCMxwgGzxrSQhek2e2ApCQl
 3JNA5aailFmQekdQiLTaR9cqnwUeewuAEtgLq9u+aDXXrEl/g1wCWXyCautISajOHdJr
 5Tbw==
X-Gm-Message-State: APjAAAUwN7goW47hmg2WYB8CHyl/B5X82nYmWlzjtHMwgRSH8AQQJIn/
 sOgR5wnJlt244ZYYojNylnWfZwKBBX0=
X-Google-Smtp-Source: APXvYqxVi0uEazLGvhI33sAYsmisYOG6dmlyclSMTgDbkZMmUAqr451k01Y4fRohGG0KiXRhjAzgOA==
X-Received: by 2002:a2e:2e17:: with SMTP id u23mr11612749lju.26.1569049566992; 
 Sat, 21 Sep 2019 00:06:06 -0700 (PDT)
Received: from [192.168.1.4] ([213.174.16.211])
 by smtp.gmail.com with ESMTPSA id t10sm983636ljt.68.2019.09.21.00.06.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 21 Sep 2019 00:06:06 -0700 (PDT)
In-Reply-To: <20190913120559.40835-1-slp@redhat.com>
To: Sergio Lopez <slp@redhat.com>
From: Vasyl Vavrychuk <vvavrychuk@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3] virtio-mmio: implement modern (v2),
 personality (virtio-1)
Message-ID: <a51cbe82-9213-d535-a43b-57f68f78475d@gmail.com>
Date: Sat, 21 Sep 2019 10:06:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
X-Mailman-Approved-At: Sat, 21 Sep 2019 09:09:01 -0400
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Sergio,

 > For this reason, the v2 personality is disabled, keeping the legacy
 > behavior as default. Machine types willing to use v2, can enable it
 > using MachineClass's compat_props.
...
 > +    DEFINE_PROP_BOOL("force-legacy", VirtIOMMIOProxy, legacy, true),

Currently, I am not enable to set "force-legacy" to false from command 
line for
virt machine.

I think, the "force-legacy" and compat_props should work the other way 
around.

The "force-legacy" should be set to false by default to select a new 
behaviour.
Instead of this hw_compat_4_1 should be modified to keep the old behaviour:

--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -29,6 +29,7 @@

  GlobalProperty hw_compat_4_1[] = {
      { "virtio-pci", "x-pcie-flr-init", "off" },
+    { "virtio-mmio", "force-legacy", "on" },
  };
  const size_t hw_compat_4_1_len = G_N_ELEMENTS(hw_compat_4_1);


This way, one can keep the old behaviour by doing "-M virt-4.1"

Best regards,
Vasyl


