Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E529C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 22:32:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE74B2082F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 22:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sa4k+J+t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE74B2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0vdI-0007AF-1g
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 18:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47205)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.weiyang@gmail.com>) id 1i0vcJ-0006ii-0W
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 18:31:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.weiyang@gmail.com>) id 1i0vcH-0007xK-UX
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 18:31:38 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:44817)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
 id 1i0vcF-0007uU-3b
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 18:31:36 -0400
Received: by mail-ed1-x542.google.com with SMTP id a21so10234290edt.11
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 15:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=vuC0Rh6bklX5e875d1XPOhIM1JYo7MlRR0Lw5LroI4g=;
 b=Sa4k+J+tE6Ls2AtTUvvJsWd7oSlA8Q4dgqQk+vLaB55SWJBcJbcHeXFV8vLGWNWSQ1
 kkVoLHc/qK9Np1zGSjBs6XVPNMERFQYxrNWAk8dKe4TwQWdigW3H/UYLF/cFlNy0mVKG
 iKvI14c5/0Dq8G/Vi6RdLlHo5KkcjiGsgJF9FST9EtZdXD8HlXPY5jPGfRx0SDnQXrnE
 Ul6mglvta+gakF9uE1h6ixwgVZUkARUDBV6I7DO6NkNDBEjSAX9j6RFc7HS4q10/LfC3
 SltyGFgecJ3spazHz1gWE8caD3sds+SGguPYdr5rxzAJNRlyvJ1hwUHQkGH4PmxbY+3t
 2SMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=vuC0Rh6bklX5e875d1XPOhIM1JYo7MlRR0Lw5LroI4g=;
 b=OFtvyfi+wRoyOeFMVY7cd9h2x6+bSXk7GfAX+4CYdTYEn7cPj6lcDj5CXf8Jiuodij
 8yLuWoV94HC+876mm27EJy6PFtF0RAplGfhxUdfOcjfpPrE6+xdgCPNRgwWXQqmORrrM
 1zPhLEQrxJLVjZ5yVCKCPzDK1L6dhMmwrqb31TYlCAySiqyfWeyS/FrwmWz3gC1nNfTb
 hYkhALoMLPal3B3A4kXVzwTAslTuim5qB1OtU/c29sSufLfdoKfNpIgYY8i8oMvqztsQ
 L8+YAHRJmR9mHTxd1sgsLAU0W8rS/wTmnqedu8UzmX7MnwHQS4d9WYYmW1DTBCTg6c6z
 mPIA==
X-Gm-Message-State: APjAAAV/H7SmF7fRMoelbUA9Kl23Km/S0iCpsrlgaL1RJN1hp/MNl6wP
 1ECN89NXx/g2SWyyMU3SPmk=
X-Google-Smtp-Source: APXvYqxg1O3Mj7hnfdvMPta7YTzCbOO6jPLWCFxivVjTjOLLS5Wp+5pyl7XKLOHis10mI9OqcS0nUA==
X-Received: by 2002:aa7:d981:: with SMTP id u1mr1277567eds.150.1566513090924; 
 Thu, 22 Aug 2019 15:31:30 -0700 (PDT)
Received: from localhost ([185.92.221.13])
 by smtp.gmail.com with ESMTPSA id r19sm141708edy.52.2019.08.22.15.31.29
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 22 Aug 2019 15:31:29 -0700 (PDT)
Date: Thu, 22 Aug 2019 22:31:29 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190822223129.olrzuad3smk3ytgm@master>
References: <20190321082555.21118-1-richardw.yang@linux.intel.com>
 <20190819030654.GA18468@richard>
 <ca763291-dd0d-48ba-cede-4b19493c01fb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca763291-dd0d-48ba-cede-4b19493c01fb@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::542
Subject: Re: [Qemu-devel] [PATCH 0/6] Refine exec
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
Cc: qemu-devel@nongnu.org, rth@twiddle.net,
 Wei Yang <richardw.yang@linux.intel.com>, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 22, 2019 at 12:25:44PM +0200, Paolo Bonzini wrote:
>On 19/08/19 05:06, Wei Yang wrote:
>> On Thu, Mar 21, 2019 at 04:25:49PM +0800, Wei Yang wrote:
>>> This serial refine exec a little.
>>>
>> 
>> Ping again.
>
>Queued all except 2, thanks!
>

Thanks~

>Paolo
>
>>> Wei Yang (6):
>>>  exec.c: replace hwaddr with uint64_t for better understanding
>>>  exec.c: remove an unnecessary assert on PHYS_MAP_NODE_NIL in
>>>    phys_map_node_alloc()
>>>  exec.c: get nodes_nb_alloc with one MAX calculation
>>>  exec.c: subpage->sub_section is already initialized to 0
>>>  exec.c: correct the maximum skip value during compact
>>>  exec.c: add a check between constants to see whether we could skip
>>>
>>> exec.c | 21 ++++++++++-----------
>>> 1 file changed, 10 insertions(+), 11 deletions(-)
>>>
>>> -- 
>>> 2.19.1
>> 
>

-- 
Wei Yang
Help you, Help me

