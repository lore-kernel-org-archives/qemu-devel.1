Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D010C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 14:04:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 585892065F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 14:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OaD79UUA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 585892065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAD5S-0002wL-LH
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 10:04:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kAD4T-00026R-3L
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 10:03:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24839
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kAD4R-0007MB-Lr
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 10:03:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598277814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QoxDH9u+RgG7BGcQvnvLITJtpgz5weaOrynUm3g9tp0=;
 b=OaD79UUAVnn5p0tYtl0oONCQCl2fWpBP1uXJOd4vKG2yBVa7l4RrNzwr5yvUd0bS1rMMka
 ntlrnC3gon9RBTmaFb/Pr97tqJ6rH3yvZayELJhAMnvIgqWgK+xNrHq3vpdYbGZXnAL6hu
 qgCysTTHLrYHqeOfQVgiS4zQ9X1Yq8M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-bAwIzM8LMvWCZby6rvHbdA-1; Mon, 24 Aug 2020 10:03:14 -0400
X-MC-Unique: bAwIzM8LMvWCZby6rvHbdA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5F59100746D;
 Mon, 24 Aug 2020 14:03:13 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-114-8.ams2.redhat.com [10.36.114.8])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 70CD41055A41;
 Mon, 24 Aug 2020 14:03:12 +0000 (UTC)
Subject: Re: [PATCH] disas/libvixl: Fix fall-through annotation for GCC >= 7
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200824130114.41368-1-thuth@redhat.com>
 <CAFEAcA97pa2eUx2-c-YmuBGaVA9jUDZ-VTd5fCpcyJ1rigiEww@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d9cd17bc-76da-89e1-d455-72d688e21cc7@redhat.com>
Date: Mon, 24 Aug 2020 16:03:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA97pa2eUx2-c-YmuBGaVA9jUDZ-VTd5fCpcyJ1rigiEww@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 06:40:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.25, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/08/2020 15.18, Peter Maydell wrote:
> On Mon, 24 Aug 2020 at 14:01, Thomas Huth <thuth@redhat.com> wrote:
>>
>> For compiling with -Wimplicit-fallthrough we need to fix the
>> fallthrough annotations in the libvixl code. This is based on
>> the following upstream vixl commit by Martyn Capewell:
>>
>>   https://git.linaro.org/arm/vixl.git/commit/?id=de326f850f736c3a337
>>
>>   "GCC 7 enables switch/case fallthrough checking, but this fails in
>>    VIXL, because the annotation we use is Clang specific.
>>
>>    Also, fix a missing annotation in the disassembler."
> 
> Maybe I should just update us to a newer upstream vixl...

That would certainly be nice, too.

  Thomas


