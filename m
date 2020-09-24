Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D55C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:34:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17D1E2068D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P8ZB+dSI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17D1E2068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLNeF-0007du-Uz
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 05:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNTU-0000ax-Ij
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:23:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58390)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNTS-00060R-S5
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:23:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600939414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=79tytawcwJw9LHpxLHI/O73wCTA0ATdaC7xziuc35VA=;
 b=P8ZB+dSIEyvTH6zzKoLuZNA9WXxYDLJcWWQVYWHl6kbGD0XWk9njzk8dhPPyLRBgnbHK3t
 8Yt3cmlKfrJAycc/3ZLiKNd44GnwR3RVOQFdKZ4puEybLKecGVJCGxzLJuE2BGHjlAUMBj
 JrH3TpSLZjN9CSdugpX1fcw13A19WnE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-w94DBXR2MnmH_WKXp5Kt7Q-1; Thu, 24 Sep 2020 05:23:30 -0400
X-MC-Unique: w94DBXR2MnmH_WKXp5Kt7Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E74AA1891E8A;
 Thu, 24 Sep 2020 09:23:28 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 752E39CBA;
 Thu, 24 Sep 2020 09:23:28 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/92] hw/mips/mipssim: Use MMIO serial device on fake ISA I/O
Date: Thu, 24 Sep 2020 05:21:58 -0400
Message-Id: <20200924092314.1722645-17-pbonzini@redhat.com>
In-Reply-To: <20200924092314.1722645-1-pbonzini@redhat.com>
References: <20200924092314.1722645-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The 'mipssim' is not a real hardware, it is a simulator.

There is an ISA MMIO space mapped at 0x1fd00000, however
this is not a real ISA bus (no ISA IRQ). So can not use
the TYPE_ISA_SERIAL device...
Instead we have been using a plain MMIO device, but named
it IO.

TYPE_SERIAL_IO is a subset of TYPE_SERIAL_MM, using
regshift=0 and endianness=DEVICE_LITTLE_ENDIAN.

Directly use the TYPE_SERIAL_MM device, enforcing the
regshift/endianness values. 'regshift' default is already
'0'. 'endianness' is meaningless for 8-bit accesses.

This change breaks migration back compatibility, but
this is not an issue for the mipssim machine.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200907011538.818996-2-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/mips/mipssim.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/mips/mipssim.c b/hw/mips/mipssim.c
index 1b3b762203..5d4ad74828 100644
--- a/hw/mips/mipssim.c
+++ b/hw/mips/mipssim.c
@@ -216,10 +216,11 @@ mips_mipssim_init(MachineState *machine)
      * MIPS CPU INT2, which is interrupt 4.
      */
     if (serial_hd(0)) {
-        DeviceState *dev = qdev_new(TYPE_SERIAL_IO);
+        DeviceState *dev = qdev_new(TYPE_SERIAL_MM);
 
         qdev_prop_set_chr(dev, "chardev", serial_hd(0));
-        qdev_set_legacy_instance_id(dev, 0x3f8, 2);
+        qdev_prop_set_uint8(dev, "regshift", 0);
+        qdev_prop_set_uint8(dev, "endianness", DEVICE_LITTLE_ENDIAN);
         sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, env->irq[4]);
         sysbus_add_io(SYS_BUS_DEVICE(dev), 0x3f8,
-- 
2.26.2



