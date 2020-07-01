Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D7DC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 18:22:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E888120781
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 18:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fyim3fFu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E888120781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqhNL-0005zp-79
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 14:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43762)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqhMG-0004mo-Hw
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 14:21:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22633
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqhME-0003Tr-3e
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 14:21:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593627677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=lFQ/ParbqOUevNI7Ylq2+nZP+mTmdCPF3opWIJ3joVA=;
 b=Fyim3fFu3VfKXXG0m8aEonBZC+SMvAuObdL2zxLAh8xlqBx3QW1wymPAoag79Mt5u0AV6/
 HosoUMnKzSg9lIulsvF2d7mDU8QGexhcDJWiiC5a0AG4fqnWe80QfuHXO1/ZdUer/ntEbI
 wGiNWW3kF1RI2EQunEHf4z4MoGSeevI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-rrzQaa3TPkSwQPlU_EGVuw-1; Wed, 01 Jul 2020 14:21:04 -0400
X-MC-Unique: rrzQaa3TPkSwQPlU_EGVuw-1
Received: by mail-ej1-f70.google.com with SMTP id yw17so16751733ejb.12
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 11:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lFQ/ParbqOUevNI7Ylq2+nZP+mTmdCPF3opWIJ3joVA=;
 b=qYKeOXuEg4ePbZFW+6gdn9SZz9Df5kx1HV/W6fQ4J/QH4wiG92rNPk3GlZcPGfFJwG
 GkTgmE9eEscQdBq6neFFRzHFe4lsw/2aUBNC5FUcR20Cqe+EfJ9+7vOQ79Lj6rYxiEGb
 n9l3b5hj+iCprk3VemfIpwP16SE0fSUBILl0kUOGRGpf+0FxHUCbtqKl4ArX5vXFsq4C
 w6eHFgFq+mgD0awwsJ3iYI4atYeaWkDe7nYOnLrGVER67JfkeVGsXKdf15WVrZEHRBfU
 10gOwCJTp/FAPnA+aYEeho+6tG94Ytd0JBrcTXlUGWfu9naTAxe80wIh20R7ec2SXxjW
 AxfA==
X-Gm-Message-State: AOAM530twsogAf6vlH8S3LJvI07qq3W1jiHFO0MYUXSu6FWxXBvFFttV
 +hChetsOhh2S/4qAFwcwlwH3eR9I0jonluw8QTLzG9m7wNm6AeFTlf9+apLcRhb2sNHkaWbLsHp
 eeJ2U4sHMbmUX8EM=
X-Received: by 2002:a50:d513:: with SMTP id u19mr29642723edi.241.1593627663368; 
 Wed, 01 Jul 2020 11:21:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWN+vhcdxt56U0xOXNPg96lhmzTQYYxByNFPiQL9HWYGbRV+f1Zs2OrwRWTwKSLceLasP3Hw==
X-Received: by 2002:a50:d513:: with SMTP id u19mr29642696edi.241.1593627663150; 
 Wed, 01 Jul 2020 11:21:03 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id p14sm6770815edr.23.2020.07.01.11.21.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2020 11:21:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH] cpus: Initialize current_cpu with the first vCPU created
Date: Wed,  1 Jul 2020 20:21:00 +0200
Message-Id: <20200701182100.26930-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 01:29:47
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Bulekov <alxndr@bu.edu>, Bug 1878645 <1878645@bugs.launchpad.net>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We can run I/O access with the 'i' or 'o' HMP commands in the
monitor. These commands are expected to run on a vCPU. The
monitor is not a vCPU thread. To avoid crashing, initialize
the 'current_cpu' variable with the first vCPU created. The
command executed on the monitor will end using it.

This fixes:

  $ cat << EOF| qemu-system-i386 -M q35 -nographic -serial none -monitor stdio
  o/4 0xcf8 0x8400f841
  o/4 0xcfc 0xaa215d6d
  o/4 0x6d30 0x2ef8ffbe
  o/1 0xb2 0x20
  EOF
  Segmentation fault (core dumped)

  Thread 1 "qemu-system-i38" received signal SIGSEGV, Segmentation fault.
  0x00005555558946c7 in tcg_handle_interrupt (cpu=0x0, mask=64) at accel/tcg/tcg-all.c:57
  57          old_mask = cpu->interrupt_request;
  (gdb) bt
  #0  0x00005555558946c7 in tcg_handle_interrupt (cpu=0x0, mask=64) at accel/tcg/tcg-all.c:57
  #1  0x00005555558ed7d2 in cpu_interrupt (cpu=0x0, mask=64) at include/hw/core/cpu.h:877
  #2  0x00005555558ee776 in ich9_apm_ctrl_changed (val=32, arg=0x555556e2ff50) at hw/isa/lpc_ich9.c:442
  #3  0x0000555555b47f96 in apm_ioport_writeb (opaque=0x555556e308c0, addr=0, val=32, size=1) at hw/isa/apm.c:44
  #4  0x0000555555879931 in memory_region_write_accessor (mr=0x555556e308e0, addr=0, value=0x7fffffffb9f8, size=1, shift=0, mask=255, attrs=...) at memory.c:483
  #5  0x0000555555879b5a in access_with_adjusted_size (addr=0, value=0x7fffffffb9f8, size=4, access_size_min=1, access_size_max=1, access_fn=
      0x55555587984e <memory_region_write_accessor>, mr=0x555556e308e0, attrs=...) at memory.c:544
  #6  0x000055555587ca32 in memory_region_dispatch_write (mr=0x555556e308e0, addr=0, data=32, op=MO_32, attrs=...) at memory.c:1465
  #7  0x000055555581b7e9 in flatview_write_continue (fv=0x55555698a790, addr=178, attrs=..., ptr=0x7fffffffbb84, len=4, addr1=0, l=4, mr=0x555556e308e0) at exec.c:3198
  #8  0x000055555581b92e in flatview_write (fv=0x55555698a790, addr=178, attrs=..., buf=0x7fffffffbb84, len=4) at exec.c:3238
  #9  0x000055555581bc81 in address_space_write (as=0x555556441220 <address_space_io>, addr=178, attrs=..., buf=0x7fffffffbb84, len=4) at exec.c:3329
  #10 0x0000555555873f08 in cpu_outl (addr=178, val=32) at ioport.c:80
  #11 0x000055555598a26a in hmp_ioport_write (mon=0x5555567621b0, qdict=0x555557702600) at monitor/misc.c:937
  #12 0x0000555555c9c5a5 in handle_hmp_command (mon=0x5555567621b0, cmdline=0x55555676aae1 "/1 0xb2 0x20") at monitor/hmp.c:1082
  #13 0x0000555555c99e02 in monitor_command_cb (opaque=0x5555567621b0, cmdline=0x55555676aae0 "o/1 0xb2 0x20", readline_opaque=0x0) at monitor/hmp.c:47
                            ^
    HMP command from monitor

Reported-by: Alexander Bulekov <alxndr@bu.edu>
Buglink: https://bugs.launchpad.net/qemu/+bug/1878645
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
Cc: Bug 1878645 <1878645@bugs.launchpad.net>

RFC because I believe the correct fix is to NOT use current_cpu
out of cpus.c, at least use qemu_get_cpu(0) to get the first vCPU.
---
 cpus.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/cpus.c b/cpus.c
index 41d1c5099f..1f6f43d221 100644
--- a/cpus.c
+++ b/cpus.c
@@ -2106,6 +2106,9 @@ void qemu_init_vcpu(CPUState *cpu)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
 
+    if (!current_cpu) {
+        current_cpu = cpu;
+    }
     cpu->nr_cores = ms->smp.cores;
     cpu->nr_threads =  ms->smp.threads;
     cpu->stopped = true;
-- 
2.21.3


