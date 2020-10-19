Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3A3C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 14:29:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 350B8222C3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 14:29:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 350B8222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUWAI-0007eU-UO
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 10:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.rutland@arm.com>)
 id 1kUW9B-0006Nn-4f
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 10:28:25 -0400
Received: from foss.arm.com ([217.140.110.172]:51700)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mark.rutland@arm.com>) id 1kUW98-0004zI-5X
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 10:28:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 232F2D6E;
 Mon, 19 Oct 2020 07:28:18 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.55.56])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33E9C3F66E;
 Mon, 19 Oct 2020 07:28:17 -0700 (PDT)
Date: Mon, 19 Oct 2020 15:28:14 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v3 0/3] target/arm: Implement an IMPDEF pauth algorithm
Message-ID: <20201019142814.GF34028@C02TD0UTHF1T.local>
References: <20200814213938.369628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814213938.369628-1-richard.henderson@linaro.org>
Received-SPF: pass client-ip=217.140.110.172;
 envelope-from=mark.rutland@arm.com; helo=foss.arm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 10:28:18
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, alex.bennee@linaro.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Richard,

Thanks again for this, and sorry for the radiosilence -- I broke my arm
the weekend this was sent, and once I had recovered enough to use a
computer again this had slipped off my TODO list.

I've just given this a go, applied atop of this morning's HEAD commit
(ba2a9a9e6318bfd93a2306dec40137e198205b86), which only had trivial
diff conflicts.

With a somewhat instrumented kernel booted under TCG with cpu=max, I see:

* pauth=off
  takes ~20s real time to boot to a prompt

* pauth=on
  takes ~250s real time to boot to a prompt

* pauth=on,pauth-impdef=true
  takes ~35s real time to boot to a prompt

... which is a significant improvement, and makes this usable for
my testing setup!

I also checked that this caught pointer modification, which it does:

| # echo CORRUPT_PAC > /sys/kernel/debug/provoke-crash/DIRECT 
| [   92.897446] lkdtm: Performing direct entry CORRUPT_PAC
| [   92.899007] lkdtm: changing PAC parameters to force function return failure...
| [   92.901989] Unable to handle kernel paging request at virtual address bfffbe2dc161abac
| [   92.904137] Mem abort info:
| [   92.905480]   ESR = 0x86000004
| [   92.906613]   EC = 0x21: IABT (current EL), IL = 32 bits
| [   92.908480]   SET = 0, FnV = 0
| [   92.909381]   EA = 0, S1PTW = 0
| [   92.910566] [bfffbe2dc161abac] address between user and kernel address ranges
| [   92.913238] Internal error: Oops: 86000004 [#1] PREEMPT SMP
| [   92.915670] CPU: 1 PID: 244 Comm: bash Not tainted 5.9.0-rc3-00106-g2634241baafc #6
| [   92.917251] Hardware name: linux,dummy-virt (DT)
| [   92.919361] pstate: 80400005 (Nzcv daif +PAN -UAO BTYPE=--)
| [   92.921284] pc : 0xbfffbe2dc161abac
| [   92.923882] lr : lkdtm_CORRUPT_PAC+0x84/0xc4
| [   92.925219] sp : ffff800010583c80
| [   92.926372] x29: ffff800010583c80 x28: ffff0001f5fac600 
| [   92.928594] x27: 0000000000000000 x26: ffffbe2dc2b6e648 
| [   92.930249] x25: ffff800010583df0 x24: 000000000000000c 
| [   92.932146] x23: ffff0001f15fb000 x22: ffffbe2dc31dfdc0 
| [   92.933807] x21: ffffbe2dc2b6e728 x20: 000000000000000c 
| [   92.935812] x19: 0000000000000001 x18: 0080000000000000 
| [   92.937663] x17: 0000000000000000 x16: 0000000000000000 
| [   92.939341] x15: 0000000000000001 x14: ffffbe2dc3e42810 
| [   92.940959] x13: 0000000000000001 x12: 0000000000000000 
| [   92.942679] x11: ffffbe2dc2e0f4c8 x10: ffffbe2dc2817530 
| [   92.944855] x9 : 6b20657479622d32 x8 : 3320646e61707865 
| [   92.946847] x7 : 00000000beb3692b x6 : ffff0001f5fad3d8 
| [   92.948936] x5 : ffff0001f5fac600 x4 : 0000000000000000 
| [   92.950721] x3 : ffffbe2dc0600000 x2 : ffffbe2dc2840000 
| [   92.952615] x1 : ffff0001f5fac600 x0 : 0000000000000000 
| [   92.954758] Call trace:
| [   92.956237]  0xbfffbe2dc161abac
| [   92.957753]  lkdtm_do_action+0x3c/0x50
| [   92.959378]  direct_entry+0x1a4/0x268
| [   92.961202]  full_proxy_write+0x94/0xd8
| [   92.962779]  vfs_write+0x138/0x350
| [   92.964500]  ksys_write+0x98/0x168
| [   92.965930]  __arm64_sys_write+0x24/0x38
| [   92.967731]  el0_svc_common.constprop.3+0xe8/0x258
| [   92.969384]  do_el0_svc+0xb4/0xf8
| [   92.970696]  el0_sync_handler+0x1a8/0x218
| [   92.972497]  el0_sync+0x158/0x180
| [   92.974560] Code: bad PC value
| [   92.976782] ---[ end trace 434c9ef9ca3d6114 ]---

... so this all looks good to me, and it would be nice to see merged!

Feel free to add:

Tested-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

