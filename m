Return-Path: <SRS0=lwXe=VR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABD3C7618F
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 01:36:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10E9720873
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 01:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFRsS1wI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10E9720873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoeIW-0006FZ-4Z
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 21:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45115)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.weiyang@gmail.com>) id 1hoeIJ-0005dD-26
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 21:36:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.weiyang@gmail.com>) id 1hoeII-0001hL-6C
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 21:36:15 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:39190)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
 id 1hoeII-0001gW-0K
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 21:36:14 -0400
Received: by mail-ed1-x541.google.com with SMTP id m10so35911403edv.6
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 18:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=8Hky2HQyR7fCEpjhi8ueqO8K1UmZaOZMsChsLjM1uok=;
 b=gFRsS1wIxFPdtfn7RCpbiFt3p6i0uDmjTJ61iegKG7Is8Xp0fZ8rm2Nb3Tc57AZtWo
 LmvN6W3BjqklImctkZa8mP7Ufd9Ze16ohFFehtNxq2Ox2TOmQndp8Iyr/ZXLJwVufCdz
 fg1jamgtwy2HpTImcMfEh43V3v7W/ryUF37AQPdHmusAKSWB7GJbUPpe1CjWU1nRAse1
 S00wyZWw4k5CEbWScMDvLbvv7A4jl/pMihWsuQG4gJBxHIejxQmww8cRiWKRdcQz5qIU
 9n7SBYMk8aeIPF6kfxXduOsGl4hKICZC1cn/qXKOXY7xH5mY6j4Je7nn9AnpRrFqznxC
 hZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=8Hky2HQyR7fCEpjhi8ueqO8K1UmZaOZMsChsLjM1uok=;
 b=reyYni+mlrc/ErV48CRsWIedmcmrA6T7IPkKNpZurmgZSExhiqmLfp/YxheE8Wu5rB
 NroVtfhR2pv+zMe/SSKnAlfbBt81QWzjwX7ANLawL/jZdQrE5GHor1BS7TbbSFWVMcbI
 DbqskZgVWMYBX6FhG8EhQHAxEsXDn5J7HH9gHmQQ/q3wvyol6NPEpQ33RIM17UqFY3qy
 FEapnpJWGmnGNt4o2EoGxxCcal9Cxzl8UiSqTjh8tvQOrec9YXYMTxav3r/d7dryyE+2
 N5wMWk6+wSkYTp+YpP4Ik2NyZIH7WmHyMfurtYVRzVa4lmtQnS5sNcHrQ4DJDPMYcqWZ
 3V7A==
X-Gm-Message-State: APjAAAW+XIXfuGiIj/e9hUhrTyo864E5p6w6naSiFQk0EeS68omZTlhM
 VBrmk7EwGng8/Kloe2i30IY=
X-Google-Smtp-Source: APXvYqzud7YYMHWjINJQV8XWfjux5tTTbQqssorgtdeNtUzlwjG+haFKef1L/hMBXMHLmF/JXl3pFg==
X-Received: by 2002:a17:906:3d69:: with SMTP id
 r9mr42439278ejf.28.1563586572105; 
 Fri, 19 Jul 2019 18:36:12 -0700 (PDT)
Received: from localhost ([185.92.221.13])
 by smtp.gmail.com with ESMTPSA id c24sm6458799ejb.33.2019.07.19.18.36.10
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 19 Jul 2019 18:36:11 -0700 (PDT)
Date: Sat, 20 Jul 2019 01:36:10 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190720013610.o6hagbbnuq6nvcoz@master>
References: <20190402003106.17614-1-richardw.yang@linux.intel.com>
 <20190611082520.GA11125@richard> <87zhmottba.fsf@trasno.org>
 <20190717011459.GB14233@richard> <20190719180544.GL3000@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719180544.GL3000@work-vm>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::541
Subject: Re: [Qemu-devel] [PATCH] migration: remove unused field bytes_xfer
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
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Cc: Juan Quintela <quintela@redhat.com>,
 Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 19, 2019 at 07:05:44PM +0100, Dr. David Alan Gilbert wrote:
>* Wei Yang (richardw.yang@linux.intel.com) wrote:
>> On Tue, Jun 11, 2019 at 10:33:29AM +0200, Juan Quintela wrote:
>> >Wei Yang <richardw.yang@linux.intel.com> wrote:
>> >> On Tue, Apr 02, 2019 at 08:31:06AM +0800, Wei Yang wrote:
>> >>>MigrationState->bytes_xfer is only set to 0 in migrate_init().
>> >>>
>> >>>Remove this unnecessary field.
>> >>>
>> >>>Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> >>
>> >> Hi, David
>> >
>> >Hi
>> >
>> >I am on duty this week, will get it.
>> >
>> 
>> Hi, Juan
>> 
>> Sounds we lost this one and the one above this :-)
>> 
>
>We're in freeze at the moment; we'll pick it up as soon
>as it opens up again; I've got quite a list of your clean-up patches!
>

Thanks for your reply.

Have a good weekend. :-)

>Dave
>
>> -- 
>> Wei Yang
>> Help you, Help me
>--
>Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

-- 
Wei Yang
Help you, Help me

