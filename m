Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4882EC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 16:29:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12C5B21582
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 16:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b9VFVssN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12C5B21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihFia-0007Zt-EN
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 11:29:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48678)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ihFhi-0006da-NN
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 11:28:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ihFhf-0005CN-Ef
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 11:28:08 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51500
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ihFhf-0005AD-2a
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 11:28:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576600086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=29QsIsimFZUmIbFiqSt1DDtCg86xzhtCMexBtAtqszc=;
 b=b9VFVssNdsAWaA/1M+y0eI3YPfn/jO/RgvOC8BSC4o9BD9EdHysng8+77vmlFYj9paFybc
 6K0PqMS9NUvQmXXmrCBmTmXgvibaJRpebbrnAqUZJDoDGNogHmAj+Rnxp/1az1eXt+bFly
 h3vyq72VfBFGcNPhZRqdhpc0rlFrzDE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-2NdgqrvNNhG7eFypDzkOaA-1; Tue, 17 Dec 2019 11:27:59 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECFD4185432F;
 Tue, 17 Dec 2019 16:27:56 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-149.ams2.redhat.com [10.36.116.149])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5AF555D9E2;
 Tue, 17 Dec 2019 16:27:50 +0000 (UTC)
Subject: Re: [Bug 1856706] [NEW] target/mips/op_helper.c:971:duplicated
 branches ?
To: Bug 1856706 <1856706@bugs.launchpad.net>, qemu-devel@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <157658912470.5706.7275804988501900768.malonedeb@gac.canonical.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <bf392e35-7962-38fa-6dce-d4d8bb5ef485@redhat.com>
Date: Tue, 17 Dec 2019 17:27:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <157658912470.5706.7275804988501900768.malonedeb@gac.canonical.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 2NdgqrvNNhG7eFypDzkOaA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/12/2019 14.25, dcb wrote:
> Public bug reported:
> 
> qemu-4.2.0/target/mips/op_helper.c:971:8: warning: this condition has
> identical branches [-Wduplicated-branches]
> 
> Source code is
> 
>    if (other_tc == other->current_tc) {
>         tccause = other->CP0_Cause;
>     } else {
>         tccause = other->CP0_Cause;
>     }
> 
> Possible cut'n'paste error ?

 Hi Edgar,

you added the code in 2011 ... do you still remember the details here,
whether that was on purpose or whether it should look differently?

 Thomas


