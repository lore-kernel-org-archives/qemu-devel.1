Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8355C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 16:08:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D65322264
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 16:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mymailcheap.com header.i=@mymailcheap.com header.b="sABJ++4T";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="AwYAtGLD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D65322264
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=flygoat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZyrH-0002gE-4M
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 11:08:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1kZyQK-0003fj-0f
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:40:40 -0500
Received: from relay1.mymailcheap.com ([144.217.248.102]:58712)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1kZyQH-0003qu-Du
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:40:39 -0500
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com
 [149.56.130.247])
 by relay1.mymailcheap.com (Postfix) with ESMTPS id 6E5ED3F157;
 Tue,  3 Nov 2020 15:40:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by filter1.mymailcheap.com (Postfix) with ESMTP id 4CF5F2A34E;
 Tue,  3 Nov 2020 10:40:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
 s=default; t=1604418035;
 bh=EOgaE3Mq+7D+a8b54/VJyhQ+vITTIZCbu+UWCF8H6m0=;
 h=Date:From:To:CC:Subject:In-Reply-To:References:From;
 b=sABJ++4TLXeAh91l9QJYG7Spzcs4wO3OgdCAXt2MbbXBTCi6sWJ3BDE3uNa0OnMEc
 ChBPlPPh7rvm5FvacvwXrUZRQrVCQF0qVBG1hfnCP0YyrFR6MpcXn9IQxATwzIb1ci
 IWrBAkz/pVJzkckuPWzeJdZ5KPwBnUaBl4pSkteU=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
 by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZplEOx2RKeau; Tue,  3 Nov 2020 10:40:33 -0500 (EST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by filter1.mymailcheap.com (Postfix) with ESMTPS;
 Tue,  3 Nov 2020 10:40:33 -0500 (EST)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
 by mail20.mymailcheap.com (Postfix) with ESMTP id C7D95400C1;
 Tue,  3 Nov 2020 15:40:29 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com; dkim=pass (1024-bit key;
 unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="AwYAtGLD"; 
 dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from [127.0.0.1] (ec2-18-163-194-20.ap-east-1.compute.amazonaws.com
 [18.163.194.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail20.mymailcheap.com (Postfix) with ESMTPSA id 65998400C1;
 Tue,  3 Nov 2020 15:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com;
 s=default; t=1604418022;
 bh=EOgaE3Mq+7D+a8b54/VJyhQ+vITTIZCbu+UWCF8H6m0=;
 h=Date:From:To:CC:Subject:In-Reply-To:References:From;
 b=AwYAtGLDij2UpQkphA/Tf8B7KjSfGn5ZHgdFQZrdQpM+FD/A90FvkQXERCvHYdRcN
 RaFId0JQIlWzP2q87DlEgpg6DYpA4jFJBo9t+Sv4+CYmkkiqd8zklfjFhlQ7jiGdWd
 XgyRnNWLRTpNRCkalG2QO4b6yBJiEqVWR3LydnRA=
Date: Tue, 03 Nov 2020 23:40:15 +0800
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>,
 AlexChen <alex.chen@huawei.com>, chenhc@lemote.com
Subject: Re: [PATCH] hw/intc: Fix incorrect calculation of core in
 liointc_read() and liointc_write()
User-Agent: K-9 Mail for Android
In-Reply-To: <a4915556-bc78-a8c4-c887-f53ed14251b6@amsat.org>
References: <5FA12391.8090400@huawei.com>
 <a4915556-bc78-a8c4-c887-f53ed14251b6@amsat.org>
Message-ID: <02FD0B38-19BC-442F-9DAB-1B56BB8115B0@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: C7D95400C1
X-Spamd-Result: default: False [-0.10 / 10.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; R_DKIM_ALLOW(0.00)[flygoat.com:s=default];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 R_SPF_SOFTFAIL(0.00)[~all]; RCPT_COUNT_FIVE(0.00)[6];
 ML_SERVERS(-3.10)[148.251.23.173];
 DKIM_TRACE(0.00)[flygoat.com:+];
 DMARC_POLICY_ALLOW(0.00)[flygoat.com,none];
 DMARC_POLICY_ALLOW_WITH_FAILURES(0.00)[];
 RCVD_NO_TLS_LAST(0.10)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
 RCVD_COUNT_TWO(0.00)[2]; MID_RHS_MATCH_FROM(0.00)[];
 HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1]
X-Rspamd-Server: mail20.mymailcheap.com
Received-SPF: pass client-ip=144.217.248.102;
 envelope-from=jiaxun.yang@flygoat.com; helo=relay1.mymailcheap.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 10:40:35
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Cc: zhengchuan@huawei.com, QEMU <qemu-devel@nongnu.org>,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



=E4=BA=8E 2020=E5=B9=B411=E6=9C=883=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=888=
:28:27, "Philippe Mathieu-Daud=C3=A9" <f4bug@amsat=2Eorg> =E5=86=99=E5=88=
=B0:
>On 11/3/20 10:32 AM, AlexChen wrote:
>> According to the loongson spec
>> (http://www=2Eloongson=2Ecn/uploadfile/cpu/3B1500/Loongson_3B1500_cpu_u=
ser_1=2Epdf)
>> and the macro definition(#define R_PERCORE_ISR(x) (0x40 + 0x8 * x)), we=
 know
>> that the ISR size of per CORE is 8, so here we need to divide
>> (addr - R_PERCORE_ISR(0)) by 8, not 4=2E
>>=20
>> Reported-by: Euler Robot <euler=2Erobot@huawei=2Ecom>
>> Signed-off-by: Alex Chen <alex=2Echen@huawei=2Ecom>
>> ---
>>  hw/intc/loongson_liointc=2Ec | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>
>For a model added in 2020, its code style is a bit
>disappointing (leading to that kind of hidden bugs)=2E
>I'm even surprised it passed the review process=2E
>
>Thanks for the fix=2E
>
>Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat=2Eorg>

It was my proof of concept code=2E

Any suggestions on enhancement?
I'll have some free time afterwards so probably can do something=2E

Thanks=2E

-Jiaxun

