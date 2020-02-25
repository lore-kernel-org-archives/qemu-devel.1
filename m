Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5919C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:10:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF2DD20CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgY3PQvU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF2DD20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZyM-0008Ir-QI
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:10:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52706)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Z0M-0003lL-VG
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:08:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Z0L-0003c8-Si
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:08:02 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:53401)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Z0L-0003az-Hm
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:08:01 -0500
Received: by mail-wm1-x333.google.com with SMTP id t79so1237984wmt.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 04:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9ph3STgQjKk5oaNbdTlejspLDxctf6PfbtEr82fU/bI=;
 b=dgY3PQvUa3mnh6lz595d4P75TllLIQopadteSIl7ofKkoMNtvoWC8aWs3WpKpOEq2p
 yTNKenGLePA3ki37urmBbM6o/pwycEqbSXob7phSoSHX7LvS57dhyF8bfoFZVKN+58J8
 /TBA7qsgNi3LAy+RhqOJrppV5VWUei83LkbrME1sbiJDSXFJBhiecatPxzvIFY00q4+6
 J/jeGaeYl4P0V01fhcWGARPXhROL3ksRtSeaj5F97Rmj+p0mz/7fY/r5FCfJxbjJ6r7q
 4mYTp35fnK9t2+fwpQMi4ojESX2BOKOyFZT+bemnWaE1+ssBIVyoAUOFsDY133RBfr5r
 O+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=9ph3STgQjKk5oaNbdTlejspLDxctf6PfbtEr82fU/bI=;
 b=Ti8QpBVGrWIm0ki3/KT1GIGEkwx5x9VJqYKQAXHUBb5j5aT/54yQLxGIirXZOEt6BB
 a/KaOb8DzYwp5O0bgqdEvnTa0Fxr65maHJ5J7ynq+djQJQ8VhIVFykpMFbqwYdSZPNLB
 VD9WUrP0t05rxSl+dW8zSEC0+i4ilZYFf6lm3EWLI0WRnkgSHSAdmbzqWOsoEoT89j49
 eqxCstbRObgi7ch1KxUOOiCq8pDcWPf4u0Rb24YX1ErppQivs3I6Yz6qgjbaDC7SmCFY
 YxwwrQD5BU6UJKvW+ajRLxFa9aRQpmfVS8uJKeey5i3DagbirdNpF4p+VryoewqCCzsv
 164w==
X-Gm-Message-State: APjAAAWL2VM4shwOikZcu8Vg1qXe0YiGmfeHJj7lmzXKw7m26/fZ3Gs7
 cWUmznYVleTukYDjoVv7PAI13Zgx
X-Google-Smtp-Source: APXvYqyIxj6RIgsnO7wgKIHaDMRzJrjx0QmIBSrUFXjB0peB5hNy0dlkSk2jTE3p5xzLMqh+Frxe0g==
X-Received: by 2002:a1c:2089:: with SMTP id g131mr4745478wmg.63.1582632480269; 
 Tue, 25 Feb 2020 04:08:00 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id h13sm22709423wrw.54.2020.02.25.04.07.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 04:07:59 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 127/136] hw/input/milkymist-softusb: Remove unused 'pmem_ptr'
 field
Date: Tue, 25 Feb 2020 13:07:25 +0100
Message-Id: <1582632454-16491-25-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

In commit 029ad4bcf3 we removed softusb_{read, write}_pmem(),
we can also remove the 'pmem_ptr' field.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200224205533.23798-30-philmd@redhat.com>
Supersedes: <20200221173049.18134-1-philmd@redhat.com>
---
 hw/input/milkymist-softusb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/input/milkymist-softusb.c b/hw/input/milkymist-softusb.c
index 3e0a7eb..7deeb12 100644
--- a/hw/input/milkymist-softusb.c
+++ b/hw/input/milkymist-softusb.c
@@ -64,7 +64,6 @@ struct MilkymistSoftUsbState {
     MemoryRegion dmem;
     qemu_irq irq;
 
-    void *pmem_ptr;
     void *dmem_ptr;
 
     /* device properties */
@@ -263,7 +262,6 @@ static void milkymist_softusb_realize(DeviceState *dev, Error **errp)
     memory_region_init_ram_nomigrate(&s->pmem, OBJECT(s), "milkymist-softusb.pmem",
                            s->pmem_size, &error_fatal);
     vmstate_register_ram_global(&s->pmem);
-    s->pmem_ptr = memory_region_get_ram_ptr(&s->pmem);
     sysbus_init_mmio(sbd, &s->pmem);
     memory_region_init_ram_nomigrate(&s->dmem, OBJECT(s), "milkymist-softusb.dmem",
                            s->dmem_size, &error_fatal);
-- 
1.8.3.1



