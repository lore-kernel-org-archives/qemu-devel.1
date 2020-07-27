Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72076C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:12:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B55420719
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X0EGuQr+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B55420719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k08Xv-0001IB-I3
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 15:12:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1k08XF-0000rI-Qv
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 15:11:41 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46918
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1k08XD-0008I7-RY
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 15:11:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595877098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bak/K0h17Syxv21sfpt6c1iVu9r+Vid5zphl8quXHdY=;
 b=X0EGuQr+iBkTVIJYMa+Pv7IsGtLosFItpIwqUDE2a3k1SB51Xl4g2L+OLl65jHkyTebn0D
 bzqQjQzGkjY6aZOaG63/dPki02WCJFjmfwuyks2+Nu8Q+rfurp8pG/utv0lK0PbB5gvOEX
 eiL5/2YtahOgGDfRtHMQX5SkqcZ+v34=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-g2R1x_j1PuqQrQ1eUOQXwA-1; Mon, 27 Jul 2020 15:11:34 -0400
X-MC-Unique: g2R1x_j1PuqQrQ1eUOQXwA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 523C3102C7EE;
 Mon, 27 Jul 2020 19:11:33 +0000 (UTC)
Received: from ibm-p8-OVS-01-fsp.mgmt.pnr.lab.eng.rdu2.redhat.com
 (ovpn-119-72.rdu2.redhat.com [10.10.119.72])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 40AAC5D9DD;
 Mon, 27 Jul 2020 19:11:31 +0000 (UTC)
Subject: Re: [PATCH 1/1] scripts/performance: Add bisect.py script
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
References: <20200721231536.21604-1-ahmedkhaledkaraman@gmail.com>
 <20200721231536.21604-2-ahmedkhaledkaraman@gmail.com>
 <CAHiYmc4e=8cb4q1Gn5i=Jx=coPQBozXHT=7kK+gKeA=vi16-7g@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <a8c14108-7320-c8aa-c849-10e082496058@redhat.com>
Date: Mon, 27 Jul 2020 15:11:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHiYmc4e=8cb4q1Gn5i=Jx=coPQBozXHT=7kK+gKeA=vi16-7g@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:46:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: "ldoktor@redhat.com" <ldoktor@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "crosa@redhat.com" <crosa@redhat.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/25/20 8:31 AM, Aleksandar Markovic wrote:
> 
> 
> On Wednesday, July 22, 2020, Ahmed Karaman <ahmedkhaledkaraman@gmail.com 
> <mailto:ahmedkhaledkaraman@gmail.com>> wrote:
> 
>     Python script that locates the commit that caused a performance
>     degradation or improvement in QEMU using the git bisect command
>     (binary search).
> 
>     Syntax:
>     bisect.py [-h] -s,--start START [-e,--end END] [-q,--qemu QEMU] \
>     --target TARGET --tool {perf,callgrind} -- \
>     <target executable> [<target executable options>]
> 
>     [-h] - Print the script arguments help message
>     -s,--start START - First commit hash in the search range
>     [-e,--end END] - Last commit hash in the search range
>                      (default: Latest commit)
>     [-q,--qemu QEMU] - QEMU path.
>                      (default: Path to a GitHub QEMU clone)
>     --target TARGET - QEMU target name
>     --tool {perf,callgrind} - Underlying tool used for measurements
> 
>     Example of usage:
>     bisect.py --start=fdd76fecdd --qemu=/path/to/qemu --target=ppc \
>     --tool=perf -- coulomb_double-ppc -n 1000
> 
>     Example output:
>     Start Commit Instructions:     12,710,790,060
>     End Commit Instructions:       13,031,083,512
>     Performance Change:            -2.458%
> 
>     Estimated Number of Steps:     10
> 
>     *****************BISECT STEP 1*****************
>     Instructions:        13,031,097,790
>     Status:              slow commit
>     *****************BISECT STEP 2*****************
>     Instructions:        12,710,805,265
>     Status:              fast commit
>     *****************BISECT STEP 3*****************
>     Instructions:        13,031,028,053
>     Status:              slow commit
>     *****************BISECT STEP 4*****************
>     Instructions:        12,711,763,211
>     Status:              fast commit
>     *****************BISECT STEP 5*****************
>     Instructions:        13,031,027,292
>     Status:              slow commit
>     *****************BISECT STEP 6*****************
>     Instructions:        12,711,748,738
>     Status:              fast commit
>     *****************BISECT STEP 7*****************
>     Instructions:        12,711,748,788
>     Status:              fast commit
>     *****************BISECT STEP 8*****************
>     Instructions:        13,031,100,493
>     Status:              slow commit
>     *****************BISECT STEP 9*****************
>     Instructions:        12,714,472,954
>     Status:              fast commit
>     ****************BISECT STEP 10*****************
>     Instructions:        12,715,409,153
>     Status:              fast commit
>     ****************BISECT STEP 11*****************
>     Instructions:        12,715,394,739
>     Status:              fast commit
> 
>     *****************BISECT RESULT*****************
>     commit 0673ecdf6cb2b1445a85283db8cbacb251c46516
>     Author: Richard Henderson <richard.henderson@linaro.org
>     <mailto:richard.henderson@linaro.org>>
>     Date:   Tue May 5 10:40:23 2020 -0700
> 
>          softfloat: Inline float64 compare specializations
> 
>          Replace the float64 compare specializations with inline functions
>          that call the standard float64_compare{,_quiet} functions.
>          Use bool as the return type.
>     ***********************************************
> 
>     Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com
>     <mailto:ahmedkhaledkaraman@gmail.com>>
>     ---
>       scripts/performance/bisect.py | 374 ++++++++++++++++++++++++++++++++++
>       1 file changed, 374 insertions(+)
>       create mode 100755 scripts/performance/bisect.py
> 
>     diff --git a/scripts/performance/bisect.py
>     b/scripts/performance/bisect.py
>     new file mode 100755
>     index 0000000000..869cc69ef4
>     --- /dev/null
>     +++ b/scripts/performance/bisect.py
>     @@ -0,0 +1,374 @@
>     +#!/usr/bin/env python3
>     +
>     +#  Locate the commit that caused a performance degradation or
>     improvement in
>     +#  QEMU using the git bisect command (binary search).
>     +#
>     +#  Syntax:
>     +#  bisect.py [-h] -s,--start START [-e,--end END] [-q,--qemu QEMU] \
>     +#  --target TARGET --tool {perf,callgrind} -- \
>     +#  <target executable> [<target executable options>]
>     +#
>     +#  [-h] - Print the script arguments help message
>     +#  -s,--start START - First commit hash in the search range
>     +#  [-e,--end END] - Last commit hash in the search range
>     +#             (default: Latest commit)
>     +#  [-q,--qemu QEMU] - QEMU path.
>     +#              (default: Path to a GitHub QEMU clone)
>     +#  --target TARGET - QEMU target name
>     +#  --tool {perf,callgrind} - Underlying tool used for measurements
>     +
>     +#  Example of usage:
>     +#  bisect.py --start=fdd76fecdd --qemu=/path/to/qemu --target=ppc
>     --tool=perf \
>     +#  -- coulomb_double-ppc -n 1000
>     +#
>     +#  This file is a part of the project "TCG Continuous Benchmarking".
>     +#
>     +#  Copyright (C) 2020  Ahmed Karaman <ahmedkhaledkaraman@gmail.com
>     <mailto:ahmedkhaledkaraman@gmail.com>>
>     +#  Copyright (C) 2020  Aleksandar Markovic
>     <aleksandar.qemu.devel@gmail.com
>     <mailto:aleksandar.qemu.devel@gmail.com>>
>     +#
> 
> 
> Hi, Ahmed.
> 
> Yes, somewhat related to John's hints on these comments, it is customary 
> to have just a brief description before "Copyright" lines. This means 
> one sentence, or a short paragraph (3-4 sentences max). The lenghty 
> syntax commemt should be, in my opinion, moved after the license 
> preamble, just before the start of real Python code.
> 

I think it's fine in the module-level docstring. Those are sometimes 
pretty long and generally refer you to other functions/classes/etc of 
interest.

In this case, this is intended to be an executable script / entrypoint, 
so having the syntax up top isn't really such a cumbersome thing.

That said, it might be prone to rot up here. Moving it to a docstring 
for the main() function, near where the parser is actually constructed, 
might help preserve accuracy for longer, at the expense of burying it 
deeper into the file.

It's an extremely minor point, and I'm afraid of getting lost too deeply 
in bikeshedding for a GSoC submission. I will be happy to see 
pylint/flake8 pass. (In pylint's case: some minimum exceptions to turn 
off warnings for too many lines / too many variables is good.)

--js


