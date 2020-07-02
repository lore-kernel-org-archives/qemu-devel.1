Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F9BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 03:08:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91A2620720
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 03:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mymailcheap.com header.i=@mymailcheap.com header.b="lsH/FPcF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="aMBNmvPR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91A2620720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=flygoat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqpa2-0002u2-Sx
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 23:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1jqpZS-0002HZ-Dl
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 23:07:30 -0400
Received: from relay1.mymailcheap.com ([149.56.97.132]:60225)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1jqpZP-0001yh-JF
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 23:07:29 -0400
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com
 [149.56.130.247])
 by relay1.mymailcheap.com (Postfix) with ESMTPS id 8F6DA3F157;
 Wed,  1 Jul 2020 23:07:24 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by filter1.mymailcheap.com (Postfix) with ESMTP id 6AF332A0C5;
 Wed,  1 Jul 2020 23:07:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
 s=default; t=1593659244;
 bh=xqpK3Zq/ivhIU1Zi/WF8LnIVsq7K/pN4mGMWvSMefwU=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=lsH/FPcFBG842LR9ltum1O5YJBzvPJlQDnObmb7EK+dekpuIeamFPMkWNuNLopo6J
 Ktd3WfFfvQKsACXL3MmVObakl5y6ljSvv7z6pgDqqlfWtys/l8CFCz/vLWx3Jv61qB
 JoymhiypFxLjZ3srPAO+cx9I+73fpVMN/8PG2Rt4=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
 by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pjVZ2FDuxMPv; Wed,  1 Jul 2020 23:07:23 -0400 (EDT)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by filter1.mymailcheap.com (Postfix) with ESMTPS;
 Wed,  1 Jul 2020 23:07:22 -0400 (EDT)
Received: from [213.133.102.83] (ml.mymailcheap.com [213.133.102.83])
 by mail20.mymailcheap.com (Postfix) with ESMTP id 420FA403B3;
 Thu,  2 Jul 2020 03:07:20 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com; dkim=pass (1024-bit key;
 unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="aMBNmvPR"; 
 dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from [0.0.0.0] (ec2-18-163-238-147.ap-east-1.compute.amazonaws.com
 [18.163.238.147])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail20.mymailcheap.com (Postfix) with ESMTPSA id 73E10403B3;
 Thu,  2 Jul 2020 03:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com;
 s=default; t=1593659231;
 bh=xqpK3Zq/ivhIU1Zi/WF8LnIVsq7K/pN4mGMWvSMefwU=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=aMBNmvPRhjZVtxar2SYyfz945uiUwMXgeG6Wu21qHZjf1N+YQmL1SHKEmVoFSCn2J
 KAWDPmjBH4T4JIVCHNi8RwBSBSjQaZCXs40AQ6/Io0lStgJ0NLFRR6umbO1hiMISW5
 xfNchDVnC3s/bDL53P+Rb/pSwdA8UQ7BRaLStIEs=
Subject: Re: [PATCH v4 28/40] tests/acceptance: skip multicore mips_malta
 tests on GitLab
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200701135652.1366-1-alex.bennee@linaro.org>
 <20200701135652.1366-29-alex.bennee@linaro.org>
 <2c5aab2c-5001-9d1a-d3f7-8afed1c4af1b@amsat.org> <87mu4jqj7y.fsf@linaro.org>
 <0eecc9ed-f0d4-97b4-37e2-d98ec0fd9b6b@amsat.org>
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <af8d2234-5e0b-d1f0-8542-539329819979@flygoat.com>
Date: Thu, 2 Jul 2020 11:06:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0eecc9ed-f0d4-97b4-37e2-d98ec0fd9b6b@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 420FA403B3
X-Spamd-Result: default: False [1.40 / 10.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; R_DKIM_ALLOW(0.00)[flygoat.com:s=default];
 MID_RHS_MATCH_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; R_SPF_SOFTFAIL(0.00)[~all];
 HFILTER_HELO_BAREIP(3.00)[213.133.102.83,1];
 ML_SERVERS(-3.10)[213.133.102.83];
 DKIM_TRACE(0.00)[flygoat.com:+];
 DMARC_POLICY_ALLOW(0.00)[flygoat.com,none];
 RCPT_COUNT_TWELVE(0.00)[13];
 RCVD_IN_DNSWL_NONE(0.00)[213.133.102.83:from];
 DMARC_POLICY_ALLOW_WITH_FAILURES(0.00)[];
 RCVD_NO_TLS_LAST(0.10)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:24940, ipnet:213.133.96.0/19, country:DE];
 FREEMAIL_CC(0.00)[euphon.net,syrmia.com,redhat.com,linaro.org,nongnu.org,gmail.com,braap.org,aurel32.net];
 SUSPICIOUS_RECIPS(1.50)[]; RCVD_COUNT_TWO(0.00)[2]
X-Rspamd-Server: mail20.mymailcheap.com
Received-SPF: pass client-ip=149.56.97.132;
 envelope-from=jiaxun.yang@flygoat.com; helo=relay1.mymailcheap.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 23:07:24
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 berrange@redhat.com, richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, cota@braap.org,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


在 2020/7/2 1:01, Philippe Mathieu-Daudé 写道:
> On 7/1/20 6:43 PM, Alex Bennée wrote:
>> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
>>
>>> On 7/1/20 3:56 PM, Alex Bennée wrote:
>>>> For some reason these tests fail all the time on GitLab. I can
>>>> re-create the hang around 3% of the time locally but it doesn't seem
>>>> to be MTTCG related. For now skipIf on GITLAB_CI.
>>>>
>>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>>> Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>>>> ---
>>>>   tests/acceptance/machine_mips_malta.py | 3 +++
>>>>   1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/tests/acceptance/machine_mips_malta.py b/tests/acceptance/machine_mips_malta.py
>>>> index 92b4f28a112..7c9a4ee4d2d 100644
>>>> --- a/tests/acceptance/machine_mips_malta.py
>>>> +++ b/tests/acceptance/machine_mips_malta.py
>>>> @@ -15,6 +15,7 @@ from avocado import skipUnless
>>>>   from avocado_qemu import Test
>>>>   from avocado_qemu import wait_for_console_pattern
>>>>   from avocado.utils import archive
>>>> +from avocado import skipIf
>>>>   
>>>>   
>>>>   NUMPY_AVAILABLE = True
>>>> @@ -99,6 +100,7 @@ class MaltaMachineFramebuffer(Test):
>>>>           """
>>>>           self.do_test_i6400_framebuffer_logo(1)
>>>>   
>>> So the test works using a single core...
>>> Good we have a test to figure the bug!
>> It's about a 1-3% failure rate on my big test box but hits every time on
>> CI. However I did disable MTTCG and still saw failures so I think it's a
>> more subtle breakage than just a straight race.
> I first thought it was a MTTCG problem, but then I realized you didn't
> disable the single core test. When using >1 core, the malta uses a
> different device, the CPS for Coherent Processing System. It contains
> a Inter-Thread Communication Unit and a Global Interrupt Controller.
> There might be a I/O locking problem. In particular, some of these
> devices access the &cpu->env (the ITU is more of micro-architecture).
>
> This is why I was excited by your finding :) We might have a way
> to figure it out.

FYI: This issue seems relative with the performence of host machine.

I can reproduce the issue in high frequency if I unplug my laptop from

AC adapter (it will switch to powersave governor).


So my first thought was it just because TCG runs too slow so cores failed

to respond IPI timely.


Thanks.

- Jiaxun

