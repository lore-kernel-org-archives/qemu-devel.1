Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E861CC76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 09:41:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B184A20880
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 09:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uvnWzkW5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B184A20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hngRL-00086Z-Vb
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 05:41:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40027)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hngRA-0007cB-DG
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 05:41:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hngR9-00017j-5a
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 05:41:24 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43664)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hngR5-000160-Qt
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 05:41:21 -0400
Received: by mail-wr1-x444.google.com with SMTP id p13so24003490wru.10
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 02:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=68cXQfTQHWpmkjIKGO8JQl5O2KmJd897j6dOCcHcJNQ=;
 b=uvnWzkW5PftszUCCJpc13xt0CellFUSPUUil66SYDmRn/cdS+7NYr+xhJItz368WfD
 KxTNvM50ef3Wz8SgEtTHyhCpyN2Qg7PMEAD0HLAQBVDRl8bCoJBl0E71Bg6Ei8imWrEE
 mouZTYlK4txDf983vyd6dqM4GULbJS9NUHFoypn/QvsVcmTfuE+VwgZr/0KUBltW1qOw
 Ta042I+BmpKOt/YPo+SkDxM1WDuzfZgBEdccGbUlBuNWYpwNJYLWHv9vwqxP86PRO330
 +NlEdssJRrf1reW1/MAHSCic1hz5D+FA9CX953bh7YDfXTVTZiV4VDvIdAK0SNsQT/25
 q1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=68cXQfTQHWpmkjIKGO8JQl5O2KmJd897j6dOCcHcJNQ=;
 b=IR80z0UyIVmf2um4j/ucOLnvSWNpRGtPnIrsKqMPrFBX4YCQ3SevJZ1BDe6zipXQaz
 gXhSrMzEYgvho6AKC2PqnVN6irwhhuTiwQyGFrpAj0OBEmsmyyJ4x07EwHmaz6IeKzXV
 RtlClsQx2C7IW1Wa60XlXmyymtrzMue9roOD2bQRFc3pRoIuwFAfslws6oGJWggWaJhp
 1UZn15N3Gh5BK1VEvkfuwatjTtl/z9W92P+pWIw10WQCddWmoMvJ37a4lXhqAYsUUNDq
 hjUVdBLHnqV9VXfwaLuenebmM7UVw93l5zs+auN/3UpDtLX7yJ66Oo8HvlkURR0yYqqB
 5tcg==
X-Gm-Message-State: APjAAAXMBlsw6Di18GxB/Q31xdYgdD48VrivS8ARiZf3gHWi0NTdw6sP
 durJd9UqJdooa3Jak5w+PjmmPw==
X-Google-Smtp-Source: APXvYqwcNXnWg1Y6kIMwi90UKNBHRIdo+4X31mcm7Me/gERLiFS+Y+d3WEZ8ZfGuuV2nX7UHdmEQwg==
X-Received: by 2002:a5d:69c4:: with SMTP id s4mr11117898wrw.163.1563356478412; 
 Wed, 17 Jul 2019 02:41:18 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id b15sm37956872wrt.77.2019.07.17.02.41.17
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 17 Jul 2019 02:41:17 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0806F1FF87;
 Wed, 17 Jul 2019 10:41:17 +0100 (BST)
References: <20190716121352.302-1-alex.bennee@linaro.org>
 <20190717013346.GB2217@umbus.fritz.box>
User-agent: mu4e 1.3.3; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: David Gibson <david@gibson.dropbear.id.au>
In-reply-to: <20190717013346.GB2217@umbus.fritz.box>
Date: Wed, 17 Jul 2019 10:41:16 +0100
Message-ID: <878ssxuhfn.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [RFC PATCH for 4.1?] target/ppc: move opcode
 decode tables to PowerPCCPU
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
Cc: "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>,
 1836558@bugs.launchpad.net, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


David Gibson <david@gibson.dropbear.id.au> writes:

> On Tue, Jul 16, 2019 at 01:13:52PM +0100, Alex Benn=C3=A9e wrote:
>> The opcode decode tables aren't really part of the CPUPPCState but an
>> internal implementation detail for the translator. This can cause
>> problems with memcpy in cpu_copy as any table created during
>> ppc_cpu_realize get written over causing a memory leak. To avoid this
>> move the tables into PowerPCCPU which is better suited to hold
>> internal implementation details.
>>
>> Attempts to fix: https://bugs.launchpad.net/qemu/+bug/1836558
>> Cc: 1836558@bugs.launchpad.net
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> I've applied this now to ppc-for-4.2.  If there's an argument for
> including it in 4.1 during hard freeze, you'll need to spell it out
> for me.

Well without:

  Subject: [RFC PATCH for 4.1] linux-user: unparent CPU object before unref
  Date: Tue, 16 Jul 2019 15:01:33 +0100
  Message-Id: <20190716140133.8578-1-alex.bennee@linaro.org>

it doesn't matter as we never attempt to free the memory once a thread
is destroyed. This causes all linux-user guests that create and destroy
threads quickly to slowly leak memory. However due to the dynamic opcode
table ppc/ppc64-linux-user guests leak a lot faster than most, in the
order of ~50k each time a thread is created and destroyed.

However I'm happy to defer to you as the maintainer :-)

--
Alex Benn=C3=A9e

