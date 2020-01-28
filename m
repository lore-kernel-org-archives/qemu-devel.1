Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A99C33CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 07:40:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 295902173E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 07:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dme-org.20150623.gappssmtp.com header.i=@dme-org.20150623.gappssmtp.com header.b="l+IrpJcg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 295902173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dme.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwLTb-0003Ov-Dn
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 02:39:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37698)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dme@dme.org>) id 1iwLSv-0002vA-1H
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 02:39:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dme@dme.org>) id 1iwLSt-0001X5-PH
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 02:39:16 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53533)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dme@dme.org>) id 1iwLSt-0001WE-ER
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 02:39:15 -0500
Received: by mail-wm1-x342.google.com with SMTP id s10so1334236wmh.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 23:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dme-org.20150623.gappssmtp.com; s=20150623;
 h=to:subject:in-reply-to:references:from:date:message-id:mime-version;
 bh=ebCi1LDysOkXXC38u1i+mPgHoG6dAotOoZjAyRPynOM=;
 b=l+IrpJcgpAcbNMGmJrbwEg9zJixiQO1J48Fl0FGjp9r60aKpgeRhp1tehE3Y246R0G
 4NdycpasgmRFyo9ptGZlaoH92+Llhx1kRFx5YAmwSPvM3/hiTQ52LNQJCUfzJ22jgSoZ
 /50Nqdt5bDE4FQQDfqElDQCCba+rDVEgy/ergjWsGWZvyUK9dAQtiaRMJsXYbQH2CbB9
 Igv3h+CVKQtevTSxlKS6IyLy8EPRmojeo8R+c9SLs4hyHKIpEPGtW6yg28XePmAZouuJ
 7y4j4K9Sg2Hrwn9AxdtPYx3C33rEtISysZiF3FwIT75RORYeE0WYvS9xZ+sS2P5PC+V7
 pPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:subject:in-reply-to:references:from:date
 :message-id:mime-version;
 bh=ebCi1LDysOkXXC38u1i+mPgHoG6dAotOoZjAyRPynOM=;
 b=lMR6/DTpJsAcIgkAbguXWM6dP39txz7DPsg0SAIVgd4FuWZdmeRN/20rQYVDFMgXym
 Ml55IelsEYYdovrzMprQdfiJo2atEtM+4GRLPNn6eZLUJ4DW/665sfhPW5yehBqujAGv
 tadEsVZLv/dkXz7KRX3iOQTS8j384Fq7ffVtF1+7CpvTAYFAcP/OYxCogqT2ZiuUoyqN
 BhBjuOTi5EepdIbV5KsTuKmU4cRAiLqXIAaw/OCoQDWyZW8VSNKGunarUK9d0rxDf5gp
 7pJiJUno3GLP0VtikLQtSHnxi1/1z4xvpeWCstV6TUIhi2efugP76qSDYwYdarvXQgcD
 3MEw==
X-Gm-Message-State: APjAAAUyVKLAeMiVzKZv74OJVemI71UNL14ICWEmESsJ8Cz+nGKHV2Sm
 ijQ8LJew+Apyezj6ukvHJA8zqA==
X-Google-Smtp-Source: APXvYqxjvBbEmKuLErExrM55eC1pv/rmqOG3zsG8V2m6hunH4POog2ETQ1jF0IohKsmscVA9C3LPBA==
X-Received: by 2002:a1c:4e05:: with SMTP id g5mr3159044wmh.138.1580197153458; 
 Mon, 27 Jan 2020 23:39:13 -0800 (PST)
Received: from disaster-area.hh.sledj.net (disaster-area.hh.sledj.net.
 [81.149.164.25])
 by smtp.gmail.com with ESMTPSA id n3sm22921949wrs.8.2020.01.27.23.39.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2020 23:39:12 -0800 (PST)
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 22222fc7;
 Tue, 28 Jan 2020 07:39:11 +0000 (UTC)
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 2/2] doc: Use @code rather than @var for options
In-Reply-To: <8412b6bf-3819-9042-4ade-d42f36fd3a97@redhat.com>
References: <20200124103458.1525982-1-david.edmondson@oracle.com>
 <20200124103458.1525982-3-david.edmondson@oracle.com>
 <8412b6bf-3819-9042-4ade-d42f36fd3a97@redhat.com>
X-HGTTG: gag-halfrunt
From: David Edmondson <dme@dme.org>
Date: Tue, 28 Jan 2020 07:39:11 +0000
Message-ID: <cunr1zk9gio.fsf@gag-halfrunt.hh.sledj.net>
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 1/24/20 4:34 AM, David Edmondson wrote:
>> Texinfo defines @var for metasyntactic variables and such terms are
>> shown in upper-case or italics in the output of makeinfo. When
>> considering an option to a command, such as "-n", upper-casing is
>> undesirable as it may confuse the reader or be in conflict with the
>> equivalent upper-case option.
>> 
>> Replace the use of @var for options with @code to avoid this.
>> 
>> Signed-off-by: David Edmondson <david.edmondson@oracle.com>
>> ---
>>   qemu-img.texi | 16 ++++++++--------
>>   1 file changed, 8 insertions(+), 8 deletions(-)
>
> Is this patch still needed given Peter's recent push to move to rST 
> documentation?

No, it would be obviated by those changes.

>> 
>> diff --git a/qemu-img.texi b/qemu-img.texi
>> index 3b6dfd8682..6b4a1ac961 100644
>> --- a/qemu-img.texi
>> +++ b/qemu-img.texi
>> @@ -74,13 +74,13 @@ keys.
>>   @item --image-opts
>>   Indicates that the source @var{filename} parameter is to be interpreted as a
>>   full option string, not a plain filename. This parameter is mutually
>> -exclusive with the @var{-f} parameter.
>> +exclusive with the @code{-f} parameter.
>>   
>
>
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org

dme.
-- 
Don't you know you're never going to get to France.

