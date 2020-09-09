Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCE3C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 11:08:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCCB321582
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 11:08:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCCB321582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFxxT-0000y7-1P
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 07:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kFxwj-00009m-FV
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 07:07:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:39466)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kFxwg-0003n8-Hr
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 07:07:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id AC1CAAEF3;
 Wed,  9 Sep 2020 11:07:21 +0000 (UTC)
Subject: Re: [PATCH v7 00/16] QEMU cpus.c refactoring part2
To: Paolo Bonzini <pbonzini@redhat.com>
References: <20200903105614.17772-1-cfontana@suse.de>
 <13e066b4-03dd-e8f6-4420-25e25e404c72@suse.de>
 <CABgObfZBARDX=tFb03xEnSVMGAiG8TPn4TAKUpGEi=_iRChmWA@mail.gmail.com>
 <7e518674-b2a4-d6fb-f9f0-20a19765b995@suse.de>
 <74e99c7f-5eb0-f34a-e2a2-c2b590027e7a@redhat.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <83904d39-5b27-d6da-f648-408931d69f63@suse.de>
Date: Wed, 9 Sep 2020 13:07:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <74e99c7f-5eb0-f34a-e2a2-c2b590027e7a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 00:22:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.626,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/8/20 2:14 PM, Paolo Bonzini wrote:
> On 08/09/20 13:58, Claudio Fontana wrote:
>> Thanks Paolo,
>>
>> if it can help I try to keep a rebased functioning version at
>>
>> https://github.com/hw-claudio/qemu.git "cpus-refactoring"
>>
>> some of the CI complains about:
>>
>> check: qemu-img not found
>> Makefile.mtest:1229: recipe for target 'check-block' failed
> 
> This will be fixed by the next pull request (the issue appears with
> --enable-system --disable-tools builds).
> 
> Paolo
> 

Generating qemu-version.h with a meson_exe.py custom command
make: *** No rule to make target 'check-softfloat'.  Stop.
make: *** Waiting for unfinished jobs....
fatal: No names found, cannot describe anything.

Probably an instance of the same problem right?

I got this from travis-ci.org

GCC check-softfloat (user)


