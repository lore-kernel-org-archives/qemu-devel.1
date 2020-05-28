Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E49C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 09:45:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F85E208DB
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 09:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=adacore-com.20150623.gappssmtp.com header.i=@adacore-com.20150623.gappssmtp.com header.b="WpRJq3Kk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F85E208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeF6D-0000oe-Lo
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 05:45:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <konrad@adacore.com>)
 id 1jeF5E-0007vI-5L
 for qemu-devel@nongnu.org; Thu, 28 May 2020 05:44:16 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:38059)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <konrad@adacore.com>)
 id 1jeF5C-0002W9-Rm
 for qemu-devel@nongnu.org; Thu, 28 May 2020 05:44:15 -0400
Received: by mail-wm1-x335.google.com with SMTP id f185so1329283wmf.3
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 02:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore-com.20150623.gappssmtp.com; s=20150623;
 h=from:subject:to:cc:message-id:date:user-agent:mime-version
 :content-language:content-transfer-encoding;
 bh=5j/vmYegqPghKDia8OOQxLyOBC7VOwqwEuCRC9v9smg=;
 b=WpRJq3KkARWuMlF7HqAsdC6ijO/Z4+j6PY5kp2wmx1KZfy5W90R0abQedy74BrtUGR
 3kDV0B07ROWyBKGQHyECltW8xQZfwswaYjdbu61nfyraRUSG0bq3R4fsCwgM7S9eN+f6
 pku6f1EkN0dGsTWxMdlK2vUveor42e5VmgCFtNiIgRFFuOchrr5GTIsbXANSOWe2Ddvv
 CacbuKNq9t+OumsgEZxw29vF53r505+uxGZg3iqlpNZ1VAdP5o6jjKwNwBMX97kSol4n
 Zd5QXvu4Lu68YqATwoX6JQ5O2bYAiGvU3/OBIfWGtwEuxXTr9TlhDzcwVZRLB6+lNvrv
 /miQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=5j/vmYegqPghKDia8OOQxLyOBC7VOwqwEuCRC9v9smg=;
 b=qUjxTx9uReZml9OQllMEWxF5fY+IxOhBSZ8f4eqayh5ifTXGiFOmHRPyREoLbEXC2D
 bK4BSkNC5O3tQPfVwTaEHyr8oho+XeU8wuDs0Jpo6rJ1PTRFwSRaKMxVyXTc67SGUgEz
 zNpdSeP2vwHdWPPBaKz+6jsAk3SGwRu9OId4/6aMBaZi4iM56ABxIEfGaVmEw3ROXBgZ
 L2iUux01nVr624elp7uqRLxshJ/h3OHgUvgXdC0E6+SIiben/PbQVTEYvHyNwsmgXTB6
 YKA/p7BQOsyp6SfP0sdKkfDaEvCiFXbaZa25RYiKe+wFAcf34RubtHQAPoVCBQs3LgAv
 JL1g==
X-Gm-Message-State: AOAM532weajvT/+43vwDPLsSsx+KRVyjSf1b0c89y1md8LjSFl/oPusD
 NZw8DUxKrOH45IxafhseMiR+7w==
X-Google-Smtp-Source: ABdhPJz+bWJHmZMdZBnF5bvcBV5GqoJns+dAgG2xN9rzta0sj2Lg5lNdXj0DQuSerqpgR9sMEFYuxg==
X-Received: by 2002:a1c:1fc2:: with SMTP id f185mr2340091wmf.4.1590659052796; 
 Thu, 28 May 2020 02:44:12 -0700 (PDT)
Received: from linux.home ([2a01:cb19:867e:2100:7eef:23e0:9210:3e8])
 by smtp.gmail.com with ESMTPSA id y37sm6119738wrd.55.2020.05.28.02.44.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2020 02:44:12 -0700 (PDT)
From: Fred Konrad <konrad@adacore.com>
Subject: [RFC] some semihosting interrogation
To: QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <141c5b32-31cd-1a1d-b1aa-692b9002dac9@adacore.com>
Date: Thu, 28 May 2020 11:44:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=konrad@adacore.com; helo=mail-wm1-x335.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all,

Just wonderring if there is any reason not to be able to defer
qemu_semihosting_connect_chardevs a little more to be able to specify
chardev=serial0?

Like:

diff --git a/softmmu/vl.c b/softmmu/vl.c
index 6390cf0..9fa1553 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -4333,8 +4333,6 @@ void qemu_init(int argc, char **argv, char **envp)

      qemu_opts_foreach(qemu_find_opts("chardev"),
                        chardev_init_func, NULL, &error_fatal);
-    /* now chardevs have been created we may have semihosting to connect */
-    qemu_semihosting_connect_chardevs();

  #ifdef CONFIG_VIRTFS
      qemu_opts_foreach(qemu_find_opts("fsdev"),
@@ -4484,6 +4482,9 @@ void qemu_init(int argc, char **argv, char **envp)
      if (foreach_device_config(DEV_DEBUGCON, debugcon_parse) < 0)
          exit(1);

+    /* now chardevs have been created we may have semihosting to connect */
+    qemu_semihosting_connect_chardevs();
+
      /* If no default VGA is requested, the default is "none".  */
      if (default_vga) {
          vga_model = get_default_vga_model(machine_class);

Also I found out that the trailing \0 is sent to the chardev 
(console.c:copy_user_string) is that expected in case of semihosting?

static GString *copy_user_string(CPUArchState *env, target_ulong addr)
{
     CPUState *cpu = env_cpu(env);
     GString *s = g_string_sized_new(128);
     uint8_t c;

     do {
         if (cpu_memory_rw_debug(cpu, addr++, &c, 1, 0) == 0) {
             if (c) {
                 s = g_string_append_c(s, c);
             }
         } else {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "%s: passed inaccessible address " TARGET_FMT_lx,
                           __func__, addr);
             break;
         }
     } while (c!=0);

     return s;
}

I can roll out two patches if needed..

Cheers,
Fred

