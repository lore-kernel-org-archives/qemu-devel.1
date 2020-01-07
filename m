Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF68C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 07:11:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A45D42077B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 07:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hwNHWv0F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A45D42077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioj1v-0007ak-FX
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 02:11:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43664)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ioix1-0006nE-Rm
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:06:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ioix0-0001O0-EH
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:06:51 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55709
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ioix0-0001NQ-BA
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:06:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578380809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Y9gMMUcwgkrMk7f9O1CDwtG2DUeIx7yjjMWuIxNueE=;
 b=hwNHWv0FE1RCV6lIi9kHOw2Qm5Qu9FuhEdPoxJVrNAhzh0+Q9K/5JTpZv5f9+ZpEoEYiu0
 EY+j7OcCTSHWBQcbGjICuzWsacSq5FM33Lf3ImrxqR2e+iP86fpb1SHr3wcNUyjf/PAGHm
 dc8+M2ChdHNI/ZbLi2KTx1NRCvDiajA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-hekV1hbsMqaJW_3Xx0KT7g-1; Tue, 07 Jan 2020 02:06:48 -0500
Received: by mail-wr1-f71.google.com with SMTP id v17so26623984wrm.17
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 23:06:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+Y9gMMUcwgkrMk7f9O1CDwtG2DUeIx7yjjMWuIxNueE=;
 b=hDg45Nj8BxbHkhojNi9Wgw2Hdjk1gCJcOAIbSpoLNwHpKTGwsxaB5Gagzd7NvADFk2
 XzLZ0qre0zhemfthDHil8G2ehW+qblLXFxK7eYa62dsEQTc2hjsRajg/OSdx+OOFc5X4
 xRWljqhacEwYzjHfOADViBqUONq02gTHpIov+zJYY7nzf8gepzZaFLFYEN1k8Tr2alQa
 A0fUUyJxiRsiifYwXO0UEWhpQfsnjtYB3AEOopI6Q2c6px1+nGq/SbPjgfutXPxJW///
 N7sUnPDjEni5lDXUwzYKUXf1vjpds9LG2lYdIZQPJSlYJuE4Lmk8VTGAfkA807oe074e
 ZPBA==
X-Gm-Message-State: APjAAAVhWl2EFm/KXWeDtaHEIKdWnii2P+8YxH2dMmeDpp9Qes0qKouv
 8z6UNkMS7X/El5p6sfawZwTK/D66E0mI6LkmbCfMQA1sBGU22KXHgjQzz4A8sCgn91+O1L1JP2e
 UcQoDxrMv8CqC794=
X-Received: by 2002:a1c:7c18:: with SMTP id x24mr38658965wmc.21.1578380807239; 
 Mon, 06 Jan 2020 23:06:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqxHfUSYrv88SY2ptPqMpnoThf6pTogfcjb1juerzpfcRegHV8MrQB7+IKVusIQNhFRzvuukVQ==
X-Received: by 2002:a1c:7c18:: with SMTP id x24mr38658950wmc.21.1578380807048; 
 Mon, 06 Jan 2020 23:06:47 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id x10sm75070249wrp.58.2020.01.06.23.06.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2020 23:06:46 -0800 (PST)
Subject: Re: [PATCH v1 00/59] trivial unneeded labels cleanup
To: Kevin Wolf <kwolf@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, minyard@acm.org
References: <20200106182425.20312-1-danielhb413@gmail.com>
 <20200106195457.GE2886@minyard.net>
 <f71eb524-571b-54d1-1a99-95d2896f6586@gmail.com>
 <20200107061613.GB4076@linux.fritz.box>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <cacf1a76-366e-7209-3f5e-3bb6728c2e8a@redhat.com>
Date: Tue, 7 Jan 2020 08:06:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200107061613.GB4076@linux.fritz.box>
Content-Language: en-US
X-MC-Unique: hekV1hbsMqaJW_3Xx0KT7g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/7/20 7:16 AM, Kevin Wolf wrote:
> Am 06.01.2020 um 21:35 hat Daniel Henrique Barboza geschrieben:
>> On 1/6/20 4:54 PM, Corey Minyard wrote:
>>> On Mon, Jan 06, 2020 at 03:23:26PM -0300, Daniel Henrique Barboza wrote:
>>>> Hello,
>> [...]
>>>>
>>>> Which is cleaner and requires less brain cycles to wonder
>>>> whether the 'cleanup' label does anything special, such
>>>> as a heap memory cleanup.
>>>
>>> I would disagree with this analysis.  To me, I often wonder
>>> when I have to add cleanup code to a routine whether there is
>>> some hidden return in the middle of the function.  That's a lot
>>> harder to spot than just looking for the cleanup label at the
>>> end of the function to see what it does.  For non-trivial
>>> functions I prefer to have one point of return at the end
>>> (and maybe some minor checks with returns right at the beginning).
>>> I'm not adamant about this, just my opinion.
> 
> It depends on the case, but yes, I had similar thoughts, at least when
> we're talking about non-trivial parts of a function. (Very short
> functions of just some initial checks returning directly are usually
> fine.)

 From a debugging point of view, and when adding trace-events, it is 
easier to have a single function exit path.

In various functions modified by your patches, we can split big 
functions in smaller ones and avoid the goto label.


