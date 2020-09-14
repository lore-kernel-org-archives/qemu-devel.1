Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D693C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 07:21:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9831921548
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 07:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UxFGTcrA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9831921548
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHinT-0005lw-O7
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 03:21:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHilD-0001fk-9D
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 03:18:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44390
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHilB-0002BV-Di
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 03:18:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600067924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YzSKldiW2HRn7UhD5Yr2QwZoornJWo/pDiXyanJE4Qs=;
 b=UxFGTcrAdjLNrLNq/ZG6yDz/3voX01OHdvxnEraYpS1WArjNN9jJG0xx2IalrypXVp8gAP
 LiTUMn1T2w/4zl3MQohZp+48waEgcbPnkk0F8GNEs2VGkv3M1ccomrlJLXtvCFp8JiJkhZ
 J7ag4Rn+JWr2X7j5cwvP/xJ8ZqHPYjM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-ZRv6fOwtPeCmnPAFkNefUg-1; Mon, 14 Sep 2020 03:18:40 -0400
X-MC-Unique: ZRv6fOwtPeCmnPAFkNefUg-1
Received: by mail-wm1-f71.google.com with SMTP id m25so2145392wmi.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 00:18:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YzSKldiW2HRn7UhD5Yr2QwZoornJWo/pDiXyanJE4Qs=;
 b=WKHEY05Oz5kw4uMz0NVxnFfYsmVn0tXgZwrR36z1gxeQYzW6AG40OUGbHVYwz1Xv46
 w5RwrugjViGpAibcx6sCQZXL7n7WbCUjFSbxhYWLWdji+xYPVIUYemiaryBiw+4yaPCY
 Ak1P9KxmgzjUvpBSLIVXnffj4uwNiO9e7BBd1x9GmRiaYj6Ii4OSo/vL40mHSDCbiMGa
 GnUKO8R0lWDGvnemS8jlECLXT/9+l4MoLvDXey5JcPmJ3dorDKq+JdkZxckV+182I7rb
 CjL3oAlDw91+/LCTiK/ndurjZv/yByj7vdmMuJ9p8T/dgnmxY7EdVDZwX3XRfezrDrEd
 Lipw==
X-Gm-Message-State: AOAM531YieBQD3s2n2GjdV/7Ff+WBY3xvj3hJOvddEUPI2AEu4EecvFr
 3NFt00IeAes4JjpI+vkC781KiQ1KifT67VwLxbXiVBr/6AyqUaWoZFyS+2HY2cT4kZKIImjc4b+
 ZM6tMYgmuSxniFJw=
X-Received: by 2002:a5d:53d1:: with SMTP id a17mr13692926wrw.98.1600067919352; 
 Mon, 14 Sep 2020 00:18:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpRblCwdUPWMmfFHtkmFRr1szMxC7MZhBZ940y+3NU6mntZRrk7itWUxGejpod+k6g4tL+/g==
X-Received: by 2002:a5d:53d1:: with SMTP id a17mr13692903wrw.98.1600067919151; 
 Mon, 14 Sep 2020 00:18:39 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id x24sm19051297wrd.53.2020.09.14.00.18.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 00:18:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/10] tests: acpi: update "virt/SSDT.memhp" for
 edk2-stable202008
Date: Mon, 14 Sep 2020 09:17:20 +0200
Message-Id: <20200914071720.1099898-11-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200914071720.1099898-1-philmd@redhat.com>
References: <20200914071720.1099898-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 01:39:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Laszlo Ersek <lersek@redhat.com>

The NVDIMM_ACPI_MEM_ADDR dword in "virt/SSDT.memhp" needs an update due to
the firmware now allocating NVDIMM_DSM_MEM_FILE at a lower address.

>          }
>      }
>
> -    Name (MEMA, 0x43DD0000)
> +    Name (MEMA, 0x43D10000)
>  }
>

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
Ref: https://bugs.launchpad.net/qemu/+bug/1852196
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200908072939.30178-11-lersek@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 tests/data/acpi/virt/SSDT.memhp             | Bin 736 -> 736 bytes
 2 files changed, 1 deletion(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index e569098abdd..dfb8523c8bf 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/virt/SSDT.memhp",
diff --git a/tests/data/acpi/virt/SSDT.memhp b/tests/data/acpi/virt/SSDT.memhp
index db61d6733284c90153e0e2c1d6c2ac25c22b1d84..375d7b6fc85a484f492a26ccd355c205f2c34473 100644
GIT binary patch
delta 22
dcmaFB`hb-yIM^lR0TTlQqy0v%D@;rmodHrj2HXGu

delta 22
dcmaFB`hb-yIM^lR0TTlQqwz+rD@;sxodHqw2HXGu

-- 
2.26.2


