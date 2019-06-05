Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20D2C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 13:37:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE2A1206BB
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 13:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvYAlm/E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE2A1206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41873 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYW6I-0002U4-Ke
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 09:37:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1hYW4B-0001Gv-6c
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 09:35:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1hYW4A-0003ZT-D3
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 09:34:59 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:35452)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
	id 1hYW48-0003VJ-Gg
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 09:34:58 -0400
Received: by mail-ed1-x541.google.com with SMTP id p26so5871610edr.2
	for <qemu-devel@nongnu.org>; Wed, 05 Jun 2019 06:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=GOWb9ioC0546FOpscSihL8r2b7zqTxILoSkcnY5Pe9U=;
	b=PvYAlm/E6XpqfqNDaUv/Vqs9HEWpSm1xu3t6EQCJ9N8zYu5aOfngo+G+CHcf30Juwv
	EsNmOFdttkK05XKtkT4VVLs/DJ1ghddgVfUET6m06BdJO3bNjBSK7EqXGmvUKu97Efbk
	WgnpcBUu8yEna3k1KxRxMWDBN4SYNaitIX/TnqilHuabvYrOCIwt3n+bGFih8Hj26zjp
	T2TFqBridLMMcIoIrFUxwFDNJ1u1b2ivNRtUN+gy3/BMzBFQ/gVmUdXcU6FVHevRKHJn
	Gt1etmOVdZpO/J2Ug5kohtlSjYn+ciUloPIyS3SVDyrmTLM1wwbx7UEE6ZUBan/csZws
	PYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
	:references:mime-version:content-disposition:in-reply-to:user-agent;
	bh=GOWb9ioC0546FOpscSihL8r2b7zqTxILoSkcnY5Pe9U=;
	b=Fedg31q+18cp7TrzDrsQcGYuzsnEeFa2yghh2MVglgqVJ1HlsdDp0Km70yJI6UUlIQ
	DV9hJI2aiMw5VsEfzWIUU6GYt1rWUKAytUJTUbcXx9QFCPUpQ5m4gHSRqTnDfkGffE8A
	/Uj4pepSnn+Ts5VXJaFvVgYxK0M4RhCGK0JVw4cyMsNe9FyowslPh9sWq4D58gVgMVWI
	TXc60cMTL9FTwbvJiOVVmdSc2rDsWpUTh6jnr0+06Qnw7bbMOZIx6dro/psiso6qkZ0B
	4deE6S1oMZ4tR+zfbuy1vzuD385a/RO+4CFTyhLUOT/m+ZFpjiUW6sxq8Dqyw1CAX7SI
	dLqw==
X-Gm-Message-State: APjAAAWw41sYDxh3zqXZCsPrQ2SUva9EZGx3VnNZxraUNbl6PG+IRhlg
	169k9DwvdU1Cx1d4KVvAqkc=
X-Google-Smtp-Source: APXvYqxSUfdVy/l4NYwzU6mhTd01T7XCEJKGyKzqoMys47lYCsXG/NIjwb+ylqE78sBWYa134DLMsg==
X-Received: by 2002:a17:907:397:: with SMTP id
	ss23mr35688596ejb.226.1559741694269; 
	Wed, 05 Jun 2019 06:34:54 -0700 (PDT)
Received: from localhost ([185.92.221.13])
	by smtp.gmail.com with ESMTPSA id j2sm597010ejc.43.2019.06.05.06.34.53
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 05 Jun 2019 06:34:53 -0700 (PDT)
Date: Wed, 5 Jun 2019 13:34:53 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Juan Quintela <quintela@redhat.com>
Message-ID: <20190605133453.zekrnhnm5uycn7iw@master>
References: <20190604023540.26532-1-richardw.yang@linux.intel.com>
	<875zpk5nat.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875zpk5nat.fsf@trasno.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::541
Subject: Re: [Qemu-devel] [PATCH] migration/multifd: sync packet_num after
 all thread are done
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>, dgilbert@redhat.com,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 05, 2019 at 12:39:06PM +0200, Juan Quintela wrote:
>Wei Yang <richardw.yang@linux.intel.com> wrote:
>> Notification from recv thread is not ordered, which means we may be
>> notified by one MultiFDRecvParams but adjust packet_num for another.
>>
>> Move the adjustment after we are sure each recv thread are sync-ed.
>>
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>
>
>Reviewed-by: Juan Quintela <quintela@redhat.com>
>
>It shouldn't matter a lot in real life, but I agree that it is better.

Yep, thanks.

-- 
Wei Yang
Help you, Help me

