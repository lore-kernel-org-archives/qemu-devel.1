Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299F6C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 10:38:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E3892222C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 10:38:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E3892222C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQpnX-0000Q7-03
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 06:38:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kQpdA-0005gg-3S
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 06:28:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:55298)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kQpd7-0002uE-IA
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 06:28:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 3C0F6ADD2;
 Fri,  9 Oct 2020 10:28:04 +0000 (UTC)
Subject: Re: does make check now require TCG? Or is it a parallelism issue?
To: Paolo Bonzini <pbonzini@redhat.com>
References: <11ef73ff-4178-b3e8-2e49-44ff014a13ed@suse.de>
 <569520f6-adf6-6212-9625-a184bf499e24@redhat.com>
 <d21dff22-90b1-4769-0948-6bc37eaeb885@linaro.org>
 <6fe91a5a-c136-9af3-c48a-97ccdca7a543@suse.de>
 <3c527b0f-afa1-4b86-4fa5-9acca2a296bd@linaro.org>
 <CABgObfYWK2E8PsSFOcHpuA2vuA3HWgvtuLbrtQCWA=9=r07=5w@mail.gmail.com>
 <a1694fe3-9bc8-df93-345f-29f0de37b923@suse.de>
 <8cedd3e4-dc6a-30ee-fd71-f4776aa8c953@redhat.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <48641901-68e7-7e34-5046-31eea3967701@suse.de>
Date: Fri, 9 Oct 2020 12:28:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <8cedd3e4-dc6a-30ee-fd71-f4776aa8c953@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 23:20:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.214,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alex Bennee <alex.bennee@linaro.org>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/9/20 9:40 AM, Paolo Bonzini wrote:
> On 08/10/20 23:07, Claudio Fontana wrote:
>> qtests are also broken for me now with --disable-tcg build,
>> it _seems_ to me that TCG-only tests are being run for --disable-tcg too.
>>
>> I am not sure if this is a test problem (for example tests/qtest/bios-tables-test.c): data->tcg_only
>> or if it is a build system problem, or some combination.
> 
> Yes, this is due to tcg_only.  But since CONFIG_TCG is included in
> config-host.mak, it should be easy to add a call to g_test_skip.
> 
> Paolo
> 
> 

I am trying to wrap my head around this, but I got lost in scripts/tap-driver.pl .

I tried the following:

commit 27db7fa56fcb3d23e0f125701f65248a70fa1242
Author: Claudio Fontana <cfontana@suse.de>
Date:   Fri Oct 9 10:23:26 2020 +0200

    qtest: unbreak non-TCG builds in bios-tables-test
    
    the tests assume TCG is available, thus breaking
    for TCG-only tests, where only the TCG accelerator option
    is passed to the QEMU binary.
    
    Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
    Signed-off-by: Claudio Fontana <cfontana@suse.de>

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index e15f36c8c7..5f17289964 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -651,6 +651,13 @@ static void test_acpi_one(const char *params, test_data *data)
     char *args;
     bool use_uefi = data->uefi_fl1 && data->uefi_fl2;
 
+#ifndef CONFIG_TCG
+    if (data->tcg_only) {
+        g_test_skip("TCG disabled, skipping ACPI tcg_only test");
+        return;
+    }
+#endif /* CONFIG_TCG */
+
     if (use_uefi) {
         /*
          * TODO: convert '-drive if=pflash' to new syntax (see e33763be7cd3)
---------------------------------------------------------------------------------------------------

but I get:

cd build-nontcg
make -j12
make -j12 check-qtest

Running test qtest-x86_64: qos-test
ERROR qtest-x86_64: bios-tables-test - too few tests run (expected 23, got 22)
make: *** [Makefile.mtest:1326: run-test-187] Error 1
make: *** Waiting for unfinished jobs....

What am I missing here?

Thanks,

Claudio


