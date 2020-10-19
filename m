Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51009C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 17:17:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 911D621741
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 17:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+A/x7Fs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 911D621741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUYn4-0001wu-Cw
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 13:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1kUYm6-00016F-08
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 13:16:46 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:38912)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1kUYm4-0003Jj-2G
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 13:16:45 -0400
Received: by mail-lf1-x142.google.com with SMTP id 184so398446lfd.6
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 10:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=th9JOcV/EgGibZtrjIRRR/ng1hA/m7GKy2qi1b1VUlY=;
 b=W+A/x7Fs7Fc5NUwsaLX6S8PtU5BjV3/7qRO0iRp7PcL5wjpOjM7oxFiGuDCzU1cIMQ
 jmaNa2mwhJoQcgWEQ5YETfOTpB55D9tKAvYo/a7wt5ZAkt81BK+zfMm+/pAzsrZfaBNR
 rHvAxhOZknsad1dX1EHQnsPV4sHZ3JfOgZm2ktToks49NB4658aTVEobh/nlWn8mYSKc
 zUom1oe1Uvlqd5KDHGlY1O8I8N3RzwL4FR4TaPgMz2hHopXS4G0K7fshCbWAGZACZrNM
 eoIEnBUhb4Yk/2IQAMpBWyF/MEX3VF67fz6A5cjUkz2NMOCajmZWB/31/uDdnX+A3i+X
 b4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=th9JOcV/EgGibZtrjIRRR/ng1hA/m7GKy2qi1b1VUlY=;
 b=hSlJ06ctGFCjlVQ10K+hREMcp/5AwxjkYWM5DpgLAl2ucKUkhAhiUxHDf2An9nbgGO
 h58gkP1VUJBThlyfmHXu/bikXDTkjVyQxTmRwAxmzvoxXcVFe5L8yFXFPt4ltw0tSY6k
 fIZebxUgt0m4sJOrakkRhrc6NKtbVHUHmV6RRIKGlgsbmbPe9GILw7v3ButZyLM7uohO
 riGwdVxV5PUXiRFUe2rygZY2LOwNM05ousQngfcyY3ZtwG8Lf2AP98vANmsYQhVjyxlV
 6jAJhI0lBf5Hc3nNzlgFPbZHkiX++rW9S/dSn1cQzJDWMHaRlOsf720V7Z16zcydTOlG
 AXrA==
X-Gm-Message-State: AOAM530xUqeSjoc6HYZRNOy2q/ZsVIRb6fZC3F5OHcAhXlN8h8NzK35G
 TqWcxSfoYjC1gXNt/UEiC2cpCvBltwYBuloY
X-Google-Smtp-Source: ABdhPJxmRyDvUins6si9lCCEKJ/vW/nMUfn3RyG5sQR6AGqc77UE5HyNq+Co1zQjMsq4wuB2hNzy2w==
X-Received: by 2002:ac2:5048:: with SMTP id a8mr230652lfm.60.1603127801804;
 Mon, 19 Oct 2020 10:16:41 -0700 (PDT)
Received: from [192.168.2.1] (net.iroazh.eu. [109.190.73.171])
 by smtp.gmail.com with ESMTPSA id 137sm63802lfi.246.2020.10.19.10.16.40
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 19 Oct 2020 10:16:41 -0700 (PDT)
From: "Emmanuel Blot" <eblot.ml@gmail.com>
To: QEMU <qemu-devel@nongnu.org>
Subject: Re: ld: file not found: _PreallocMode_lookup on macOS Catalina
Date: Mon, 19 Oct 2020 19:16:39 +0200
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <3C35D6D8-D9FE-4977-B27F-59CCACFEAA32@gmail.com>
In-Reply-To: <AA504B32-5134-4CDD-8CDA-6F200C7376CF@gmail.com>
References: <24B952F3-465C-4AB2-AF28-6CA4722D94B7@gmail.com>
 <3869557c-10a0-8f07-a59a-69120a522568@redhat.com>
 <AA504B32-5134-4CDD-8CDA-6F200C7376CF@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::142;
 envelope-from=eblot.ml@gmail.com; helo=mail-lf1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19 Oct 2020, at 18:40, Emmanuel Blot wrote:

> On 19 Oct 2020, at 17:50, Philippe Mathieu-Daudé wrote:
>
>> Cc'ing Markus/John/Paolo
>
> 604f3e4e90c011a6b94fdc1d13700f3ec2375f2a is the first bad commit
> commit 604f3e4e90c011a6b94fdc1d13700f3ec2375f2a

Applying the reverse diff to the current master does “fix” the 
trouble.

It seems the issue narrows down to an initial empty symbol generated in 
the generated output file, e.g.:

--- undef_sh.log	2020-10-19 19:15:08.000000000 +0200
+++ undef_py.log	2020-10-19 19:15:20.000000000 +0200
@@ -1,3 +1,4 @@
+-Wl,-u,
  -Wl,-u,_PreallocMode_lookup
  -Wl,-u,__TRACE_CURL_CLOSE_DSTATE
  -Wl,-u,__TRACE_CURL_OPEN_DSTATE


I think it can be addressed with the following patch:

 From d157bd508d32485dd5cdb3efcff7969a89628cc1 Mon Sep 17 00:00:00 2001
 From: Emmanuel Blot <emmanuel.blot@sifive.com>
Date: Mon, 19 Oct 2020 19:07:03 +0200
Subject: [PATCH] Fix regression with undefined symbol filter introduced 
in
  604f3e4e.

---
  scripts/undefsym.py | 2 ++
  1 file changed, 2 insertions(+)

diff --git a/scripts/undefsym.py b/scripts/undefsym.py
index 69a895cd26..254c456f25 100644
--- a/scripts/undefsym.py
+++ b/scripts/undefsym.py
@@ -21,6 +21,8 @@ def filter_lines_set(stdout, from_staticlib):
                      continue
                  if not from_staticlib and tokens[1] != b'U':
                      continue
+            if not tokens[0]:
+                continue
              new_line = b'-Wl,-u,' + tokens[0]
              if not new_line in linesSet:
                  linesSet.add(new_line)
--
2.28.0



HTH,
Emmanuel.

