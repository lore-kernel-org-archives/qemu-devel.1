Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F6AC433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 21:08:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F380922203
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 21:08:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F380922203
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQd97-0006Or-TJ
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 17:08:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kQd80-0005kL-8M
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 17:07:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:53128)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kQd7x-0002nk-LM
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 17:07:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 47754AB91;
 Thu,  8 Oct 2020 21:07:04 +0000 (UTC)
Subject: Re: does make check now require TCG? Or is it a parallelism issue?
To: Paolo Bonzini <pbonzini@redhat.com>
References: <11ef73ff-4178-b3e8-2e49-44ff014a13ed@suse.de>
 <569520f6-adf6-6212-9625-a184bf499e24@redhat.com>
 <d21dff22-90b1-4769-0948-6bc37eaeb885@linaro.org>
 <6fe91a5a-c136-9af3-c48a-97ccdca7a543@suse.de>
 <3c527b0f-afa1-4b86-4fa5-9acca2a296bd@linaro.org>
 <CABgObfYWK2E8PsSFOcHpuA2vuA3HWgvtuLbrtQCWA=9=r07=5w@mail.gmail.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <a1694fe3-9bc8-df93-345f-29f0de37b923@suse.de>
Date: Thu, 8 Oct 2020 23:07:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CABgObfYWK2E8PsSFOcHpuA2vuA3HWgvtuLbrtQCWA=9=r07=5w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 23:49:25
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
Cc: Alex Bennee <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/8/20 8:24 PM, Paolo Bonzini wrote:
> 
> 
> Il gio 8 ott 2020, 20:05 Richard Henderson <richard.henderson@linaro.org <mailto:richard.henderson@linaro.org>> ha scritto:
> 
>     Ah, TARGET_DIRS isn't being pruned anymore when a target is disabled for lack
>     of accelerator.
> 
>     Paolo, side effect of 8a19980e3f ("configure: move accelerator logic to
>     meson")?  I guess we should move the setting of TARGET_DIRS to meson as well.
> 
> 
> TARGET_DIRS is pruned by Meson, I didn't add any back propagation to make because it is not really needed; qemu-iotests only every uses the "host architecture" QEMU binary (see tests/qemu-iotests/common.config), check-block + --target-list has never worked.
> 
> check-tcg could use the pruned TARGET_DIRS, but it is of limited use anyway with --disable-tcg.
> 
> At this point it may make sense to establish which config-host.mak variables are available in the Makefile, because there's probably just a handful. I won't have much time in the next couple of weeks though.
> 
> Paolo
> 
> 
>     r~
> 

qtests are also broken for me now with --disable-tcg build,
it _seems_ to me that TCG-only tests are being run for --disable-tcg too.

I am not sure if this is a test problem (for example tests/qtest/bios-tables-test.c): data->tcg_only
or if it is a build system problem, or some combination.

make check-qtest

...
Running test qtest-x86_64: device-plug-test
Running test qtest-x86_64: drive_del-test
Running test qtest-x86_64: tco-test
Running test qtest-x86_64: cpu-plug-test
Running test qtest-x86_64: q35-test
Running test qtest-x86_64: vmgenid-test
Running test qtest-x86_64: migration-test
Running test qtest-x86_64: test-x86-cpuid-compat
Running test qtest-x86_64: numa-test
Running test qtest-x86_64: cdrom-test
Running test qtest-x86_64: device-introspect-test
Running test qtest-x86_64: machine-none-test
Running test qtest-x86_64: qmp-test
Running test qtest-x86_64: qmp-cmd-test
Running test qtest-x86_64: qom-test
Running test qtest-x86_64: test-hmp
Running test qtest-x86_64: qos-test

qemu-system-x86_64: -accel tcg: invalid accelerator tcg
qemu-system-x86_64: falling back to QTest

ERROR:../tests/qtest/boot-sector.c:161:boot_sector_test: assertion failed (signature == SIGNATURE): (0x00000000 == 0x0000dead)
ERROR qtest-x86_64: bios-tables-test - too few tests run (expected 23, got 22)
make: *** [Makefile.mtest:1298: run-test-183] Error 1
make: *** Waiting for unfinished jobs....






