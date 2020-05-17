Return-Path: <SRS0=EQsI=67=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF220C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 11:31:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92D692075F
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 11:31:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92D692075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaHWG-0001CR-O1
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 07:31:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jaHV4-0000TK-49
 for qemu-devel@nongnu.org; Sun, 17 May 2020 07:30:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:49662)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jaHV2-0007v7-N9
 for qemu-devel@nongnu.org; Sun, 17 May 2020 07:30:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 0B58DAE70;
 Sun, 17 May 2020 11:30:31 +0000 (UTC)
To: qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
From: Claudio Fontana <cfontana@suse.de>
Subject: sharing intention for developing per-target, dynamically loadable
 accelerator modules
Message-ID: <1b5c9fee-6574-ddf4-b2d0-aa12e6fc9c84@suse.de>
Date: Sun, 17 May 2020 13:30:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 07:30:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello all,

my intention would be to develop per-target, dynamically loadable accelerator modules.

This would allow to distribute a single QEMU base binary, and then provide accelerators as optional additional binary packages to install,
with the first separate optional package being TCG.

CONFIG_TCG would become 'm' as a result, but then also CONFIG_KVM, CONFIG_HAX, CONFIG_WHPX, CONFIG_HVF.

Here are some elements that seem to be needed:

1 - The module CONFIG_MODULE part of the build system would need some extension to add per-target modules. I have some tentative results that shows that this is possible (but a bit clunky atm).
    There is some existing instability in the existing Makefile infrastructure of modules that shows up when trying to extend it.

2 - new "accelerator drivers" seems to be needed, either in addition or as additional functionality inside the current AccelState.

3 - for target/i386 in particular, there is some refactoring work needed to split even more different unrelated bits and pieces.
    dependencies of hw/i386 machine stuff with accelerator-specific stuff are also painful.

4 - CPU Arch Classes could be extended with per-accelerator methods. Initial fooling around shows it should probably work.
    One alternative would be trying to play with the dynamic linker (weak symbols, creative use of dlsym etc), but I have not sorted out the details of this option.

5 - cputlb, in particular tlb_flush and friends is a separate problem since it is not part of the cpuclass. Should it be?

6 - a painpoint is represented by the fact that in USER mode, the accel class is not applied, which causes a lot of uncleanliness all around
    (tcg_allowed outside of the AccelClass).

7 - I have not really thought about the KConfig aspects because I am not super-familiar

8 - cpus.c needs some good splitting

... more things to find out and think about ...

Overall, I think that the activity has the potential to provide benefits overall beyond the actual goal, in the form of cleanups, leaner configurations,
minor fixes, maybe improving the CONFIG_MODULE instabilities if any etc.

As an example, the first activity I would plan to submit as RFC is point 8 above,
there is the split between cpus.c and cpus-tcg.c that results in lots of TCG-specific code being removed from non-tcg builds (using CONFIG_TCG).

One thing that should be kept in check is any performance impact of the changes, in particular for point 4, hot paths should probably avoid going through too many pointer indirections.

Does anybody share similar goals? Any major obstacle or blocker that would put the feasibility into question?
Any suggestion on any of this? In particular point 4 and 5 come to mind, as well as some better understanding of the reasons behind 6, or even suggestions on how to best to 2.

Anyway, I will continue to work on the first RFC for some smaller initial steps and hopefully have something to submit soon.

Ciao ciao,

Claudio

-- 
Claudio Fontana
Engineering Manager Virtualization, SUSE Labs Core

SUSE Software Solutions Italy Srl

