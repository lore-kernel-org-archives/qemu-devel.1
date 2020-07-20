Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80058C433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 14:21:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49EBB20B1F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 14:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BwftTtrr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49EBB20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxWfW-0000U5-IK
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 10:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jxWbX-0002uJ-IX
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 10:17:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37554
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jxWbN-0002qL-Sd
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 10:17:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595254629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XIGogesj2pjtkUhjhK+zlBqNmnHAOq71h9rPnCukOIo=;
 b=BwftTtrrEX7suDIfjlNVVsEhCZApt+N/yQ+AFEQf2iBlcL4Vj7nWCiMRPfplSvRGmhfU22
 KYG1d29xWivt6glS95uQrG7v2uvorZcrpwAhQ32l1+Vmoa68rPYeegFynqdDEWSeUmKvmD
 YJwHLpmRLHZTpqjBhokzLjQwmrFSDt8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-rjCNQKGiNZOltfpUNDT1TQ-1; Mon, 20 Jul 2020 10:17:07 -0400
X-MC-Unique: rjCNQKGiNZOltfpUNDT1TQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4BFD87A380;
 Mon, 20 Jul 2020 14:16:41 +0000 (UTC)
Received: from ibm-p8-OVS-01-fsp.mgmt.pnr.lab.eng.rdu2.redhat.com
 (ovpn-119-174.rdu2.redhat.com [10.10.119.174])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A2E581002393;
 Mon, 20 Jul 2020 14:16:40 +0000 (UTC)
Subject: Re: tests/vm infrastructure fails to notice that QEMU dying is a
 failure
To: Peter Maydell <peter.maydell@linaro.org>
References: <CAFEAcA8iKKDKEdq8TtbZNwqfsH=ZO78eEXWfrVbYTDjdy9DYDw@mail.gmail.com>
 <890eb42e-cd77-2a63-c441-61637ac5094f@redhat.com>
 <42c71a79-4911-dc47-d983-783d98e819c5@redhat.com>
 <89f309c2-9909-f306-2f2b-93fc1b8adc17@redhat.com>
 <CAFEAcA8k50qCcxwp99fF2xOL13jP1unNMbVFEYXy119u00wJcg@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <90fcac2d-d2e5-0f09-b553-62fa8e386108@redhat.com>
Date: Mon, 20 Jul 2020 10:16:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8k50qCcxwp99fF2xOL13jP1unNMbVFEYXy119u00wJcg@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 03:17:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Robert Foley <robert.foley@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/18/20 5:30 AM, Peter Maydell wrote:
> On Fri, 17 Jul 2020 at 23:24, John Snow <jsnow@redhat.com> wrote:
>> - The real problem, though: Why is QEMU hanging? It might need a longer
>> timeout, or it might be having problems with the console socket again.
> 
> The host machine seemed to be under really heavy I/O load at the time.
> 
> thanks
> -- PMM
> 

Kevin's reporting problems too, with a 3 second wait being too 
optimistic. Let's extend the timeout a bit, which should help in that case.

(Avoiding exceptions in the atexit handler will take a little longer 
perhaps, but I will start working on that too.)

--js


