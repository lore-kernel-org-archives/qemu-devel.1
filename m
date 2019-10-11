Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B302EC47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 12:19:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DACD2084C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 12:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcjuaOOg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DACD2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIttA-0001Jg-IL
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 08:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51924)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.weiyang@gmail.com>) id 1iItrL-0008S7-OQ
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 08:17:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.weiyang@gmail.com>) id 1iItrK-0000q4-QR
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 08:17:27 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:39288)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
 id 1iItrK-0000pY-KO
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 08:17:26 -0400
Received: by mail-ed1-x542.google.com with SMTP id a15so8485229edt.6
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 05:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=+JrqV+7SPyE/hOGTlL7Q+X4naHO9BbdyZsH8axXlwHU=;
 b=kcjuaOOgySN0WTz23sxqgVrdxERMgXNEzn7oiKinRhWVUcHzhi519NSavFVU0ejgvC
 txaq5EEjE+ZRa0MCiJtojJ2hn95+BIW8S/NAHbqWEINU03m/eZr7GIQXqHWvajN+CL1i
 KZvQnTC/9EyZ2D3utrajroJM0nsUg/14mOQithE6mPwlZYcw7gsntzIcL5fMHXwxgfdS
 wbsF7aw0auadyd+2w9Qle/4Go67ThtjPTD0pZBmKLyQU2pwTnhaJQ629TkWt5FSOe2kM
 W5dAq/XoswlyfJPOXhCPQeITkJaw8Xe7uClzbnY+I267cR3XEwREfziVqffqwiV9BFYz
 7uZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=+JrqV+7SPyE/hOGTlL7Q+X4naHO9BbdyZsH8axXlwHU=;
 b=tlMKIc/y9ji54JFCWn54/m9Lu86/GOrlKsUexmDpta8Cdkj9gJUjg+6GYcihdHiTU2
 6P7Fv/o4Lfg/ff2SG2Gt9+QBhZPNoixh1/dg6bik9k84NZu0dFzWRin8mF4+D0PlwLBs
 NZjRurSFfN/wUZfh4U3nw3670dPiCyWQgd5hbFWbZViNQNIZTErrFJlroP3CqdaTq+X0
 MNVQSej/DcIcQXXU7283QHHZCsySagf2VKGE79tANdxjMk+tocJfl7MsSgYS547Lod1T
 Msg03jcv17zSzNUfYuH5R46lxlCSkwfAUkvzf6okSb1/EMmFFT/oFKEhQUiZ1bFqlEox
 F4qA==
X-Gm-Message-State: APjAAAVGUyBs+lynqs63zE6zd3S+WmD62BzOgE1IAgWkVI2W6hiebxqp
 /ffNpjbAbzDLdDzPejWsFgcLDC8m
X-Google-Smtp-Source: APXvYqy40HubFXi1hrQRfgVn/z1smjarYv7GFnxJ1bA4V1m9qNnR8FdNPqHqNBZ+Xw4e0E6Mi2qpHg==
X-Received: by 2002:a50:f704:: with SMTP id g4mr12917643edn.255.1570796245213; 
 Fri, 11 Oct 2019 05:17:25 -0700 (PDT)
Received: from localhost ([185.92.221.13])
 by smtp.gmail.com with ESMTPSA id u9sm174149edo.42.2019.10.11.05.17.24
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 11 Oct 2019 05:17:24 -0700 (PDT)
Date: Fri, 11 Oct 2019 12:17:24 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH 3/4] migration/multifd: initialize packet->magic/version
 once at setup stage
Message-ID: <20191011121724.fsogllmlvyqlqnfc@master>
References: <20191011085050.17622-1-richardw.yang@linux.intel.com>
 <20191011085050.17622-4-richardw.yang@linux.intel.com>
 <87d0f3wpkv.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d0f3wpkv.fsf@trasno.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::542
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
Cc: qemu-devel@nongnu.org, Wei Yang <richardw.yang@linux.intel.com>,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 11, 2019 at 12:20:48PM +0200, Juan Quintela wrote:
>Wei Yang <richardw.yang@linux.intel.com> wrote:
>> MultiFDPacket_t's magic and version field never changes during
>> migration, so move these two fields in setup stage.
>>
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>
>Reviewed-by: Juan Quintela <quintela@redhat.com>
>
>It don't really matter, and is faster your way O:-)

You are right.

And I am wondering one more thing. Why we need to carry magic/version for each
packet? Would it be better to just carry and check magic/version for the
initial packet only?

-- 
Wei Yang
Help you, Help me

