Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A4DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 17:02:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 868D12067D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 17:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="JHgq/5Kn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 868D12067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jz15B-0001D2-QJ
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 13:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jz13M-0007vs-Dr
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 13:00:12 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:48224 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jz13J-0005Dr-TR
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 13:00:11 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id C22CB4C8B7;
 Fri, 24 Jul 2020 17:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 in-reply-to:content-transfer-encoding:content-disposition
 :content-type:content-type:mime-version:references:message-id
 :subject:subject:from:from:date:date:received:received:received;
 s=mta-01; t=1595610003; x=1597424404; bh=loLDjDc7xyR0xsn1AXmD2h
 v8VAo/Q+F3n/iRMw33/2E=; b=JHgq/5Kn9unAloxzOfPEJLXwB7WQIf3VNArJ9K
 uKkWGOcyoqorByTTggHakVSYP4YNKKxZnRds7jVGLYleqQ/WVXS0MCa832489Yzo
 7t8RnvfHiB2hRGYTNxYwB1Hf9gNxUu6uMINTFswVn59qZep37xuHbluHOoErO1/W
 dY1c8=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9l-pIoO2RPIU; Fri, 24 Jul 2020 20:00:03 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id D7C354C8A9;
 Fri, 24 Jul 2020 20:00:02 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 24
 Jul 2020 20:00:02 +0300
Date: Fri, 24 Jul 2020 20:00:02 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 3/4] build: Don't make object files for dtrace on macOS
Message-ID: <20200724170002.GA34804@SPB-NB-133.local>
References: <20200717093517.73397-1-r.bolshakov@yadro.com>
 <20200717093517.73397-4-r.bolshakov@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200717093517.73397-4-r.bolshakov@yadro.com>
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 13:00:05
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 17, 2020 at 12:35:16PM +0300, Roman Bolshakov wrote:
> dtrace on macOS uses unresolved symbols with a special prefix to define
> probes [1], only headers should be generated for USDT (dtrace(1)). But
> it doesn't support backwards compatible no-op -G flag [2] and implicit
> build rules fail.
> 
> 1. https://markmail.org/message/6grq2ygr5nwdwsnb
> 2. https://markmail.org/message/5xrxt2w5m42nojkz
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Cc: Cameron Esfahani <dirty@apple.com>
> Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
> ---
>  Makefile.objs | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Makefile.objs b/Makefile.objs
> index d22b3b45d7..982f15ba30 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -211,5 +211,7 @@ trace-events-files = $(SRC_PATH)/trace-events $(trace-events-subdirs:%=$(SRC_PAT
>  trace-obj-y = trace-root.o
>  trace-obj-y += $(trace-events-subdirs:%=%/trace.o)
>  trace-obj-$(CONFIG_TRACE_UST) += trace-ust-all.o
> +ifneq ($(CONFIG_DARWIN),y)
>  trace-obj-$(CONFIG_TRACE_DTRACE) += trace-dtrace-root.o
>  trace-obj-$(CONFIG_TRACE_DTRACE) += $(trace-events-subdirs:%=%/trace-dtrace.o)
> +endif
> -- 
> 2.26.1
> 

An article about DTrace [1] mentions that FreeBSD also doesn't need that:
"On FreeBSD/Mac OS X, you do not have to generate a separate probe
object file for linking. This makes the compilation process much more
straightforward [...]"

I don't know for sure but perhaps "-G" makes dummy object files there.

1. https://www.ibm.com/developerworks/aix/library/au-dtraceprobes.html

Thanks,
Roman

