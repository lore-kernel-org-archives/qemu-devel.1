Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF82C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 11:02:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CEF4206ED
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 11:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iv2yoaVL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CEF4206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc4wF-0005oq-Gb
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 06:02:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kc4ue-0005Fa-Oh
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 06:00:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51914)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kc4uc-00049W-AC
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 06:00:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604919637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/sOppP10Sa/qTnfGqyHwycKQciZf+IsnM4V5VBK2iIg=;
 b=Iv2yoaVLDMVEPYVvU399oSfDpdvFNcAkImI1o9zilWT/bW/JI4mJXXj4yFaKYiuOtiHC2I
 XxDyWD8ry4tkPUehI1JyzP28Di92eKHBn1CPQaha8l9pDklaq6KMC6p000GcYfvIcWzJzN
 ZO6pIwNIL23X/b3CN3/8FSmBNJSRqTw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-Q_9qCO8OO6q6n4ODVPpclA-1; Mon, 09 Nov 2020 06:00:35 -0500
X-MC-Unique: Q_9qCO8OO6q6n4ODVPpclA-1
Received: by mail-wm1-f70.google.com with SMTP id y1so1832525wma.5
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 03:00:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/sOppP10Sa/qTnfGqyHwycKQciZf+IsnM4V5VBK2iIg=;
 b=h6zeLtvROL346zAYZb/I65/G7jRMQGd2iy4JOGuMoo/hdzHDN++hKu/DsCeb5fK4qB
 6XTcPjYNsz2dOY4pP/OOqvIOXzFT6OWNzs1VK/59aMq5nq8fTaRByEtZs0IOIlhvr1Bz
 itXZ1bITHlNJydNgmSrp0TGyOJY1bCgX/qOmmZPJeYiYJriOFyyfUU8eWZOLNo3q2mIY
 EbV3mHD1fmqRVqD+gzKuxoyv2it29xT3KJ4Hrn2qaOm2vtSHW5rorb7xe2kQ/ZTWiLZZ
 lMTC9b5j0kL1wViDAb9qHAMcWbI+JmfVcchYYHcpx8EqBD1ARkz2Ia7TniJmlPH8MAOW
 Gppg==
X-Gm-Message-State: AOAM533gtbtQiDnk6RMp0aXNwZ8qHFfsnuIYoHQ7mEtC2q9firyPbMvu
 uJlJ04ht9LC4hUdkp6+aAJ3+bi4oTeYj24dVHLSs3HaFBQHXkFj1alfHymJJxsjY7ZX49OhdiE1
 JCLzvWgsrvYNSOos=
X-Received: by 2002:adf:dd51:: with SMTP id u17mr17627706wrm.139.1604919634500; 
 Mon, 09 Nov 2020 03:00:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy2sV6a2YPF/vmA9gce91JV2AgFgT+nSvkhXPUPfNDipX3KBHkjl3uhCx/vsDjWjAvKIev/YQ==
X-Received: by 2002:adf:dd51:: with SMTP id u17mr17627683wrm.139.1604919634306; 
 Mon, 09 Nov 2020 03:00:34 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id o184sm12185715wmo.37.2020.11.09.03.00.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2020 03:00:33 -0800 (PST)
Subject: Re: [PATCH-for-5.2 1/5] hw/usb/hcd-xhci: Make xhci base model abstract
To: Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20201107111307.262263-1-philmd@redhat.com>
 <20201107111307.262263-2-philmd@redhat.com>
 <20201109095127.dt7rzwqcrtx6k7n5@sirius.home.kraxel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a241f626-9798-933e-d5b4-1190b3da6746@redhat.com>
Date: Mon, 9 Nov 2020 12:00:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201109095127.dt7rzwqcrtx6k7n5@sirius.home.kraxel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 00:04:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Miroslav Rezanina <mrezanin@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Thomas who wrote the test.

On 11/9/20 10:51 AM, Gerd Hoffmann wrote:
> On Sat, Nov 07, 2020 at 12:13:03PM +0100, Philippe Mathieu-DaudÃ© wrote:
>> The TYPE_XHCI model is abstract and can not be used as it.
>> It is meant to be overloaded by children classes. Restore
>> it as abstract type.
> 
> Breaks "make check".
> 
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))} QTEST_QEMU_IMG=./qemu-img G_TEST_DBUS_DAEMON=/home/kraxel/projects/qemu/tests/dbus-vmstate-daemon.sh QTEST_QEMU_BINARY=./qemu-system-x86_64 tests/qtest/usb-hcd-xhci-test --tap -k
> **
> ERROR:../../qom/object.c:506:object_initialize_with_type: assertion failed: (type->abstract == false)

Well I suppose the test was always incorrect but working,
and 8ddab8dd3d8 revealed the problem. Testing the correct
device should fix the test:

-- >8 --
diff --git a/tests/qtest/usb-hcd-xhci-test.c
b/tests/qtest/usb-hcd-xhci-test.c
index 10ef9d2a91a..09f5ad71158 100644
--- a/tests/qtest/usb-hcd-xhci-test.c
+++ b/tests/qtest/usb-hcd-xhci-test.c
@@ -18,7 +18,7 @@ static void test_xhci_init(void)

 static void test_xhci_hotplug(void)
 {
-    usb_test_hotplug(global_qtest, "xhci", "1", NULL);
+    usb_test_hotplug(global_qtest, "nec-usb-xhci", "1", NULL);
 }

 static void test_usb_uas_hotplug(void)
---

I'll respin including the fix.

> 
> take care,
>   Gerd
> 


