Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE01C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 15:09:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 380F9215EA
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 15:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ocyocS2B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 380F9215EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iExIl-00018s-9N
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 11:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58693)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rth7680@gmail.com>) id 1iExDf-0005N3-VZ
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 11:04:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rth7680@gmail.com>) id 1iExDe-0001TK-HB
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 11:04:11 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:32914)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <rth7680@gmail.com>)
 id 1iExDY-0001Re-Jb; Mon, 30 Sep 2019 11:04:05 -0400
Received: by mail-pg1-x543.google.com with SMTP id i30so7582616pgl.0;
 Mon, 30 Sep 2019 08:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:openpgp:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=i0k6tnXlA8YN3a1p4jVUdxleH1KsWDeKTH2i3mE3wNE=;
 b=ocyocS2Bv/sxXyX7P1Weg832gYWL+C9dutKP3BukaHUIZZMYFcx9tRWvWUeWIdah3u
 IU0hR33Q6pIeYwcc/YUdYIshJiHezHzt2MvjOMA9BhOun5kqtgbTu7auGSrp1/LLkEUg
 1RWGDsvKH+W3+45qJsZm2hUPGRd04VzpyYM82/BhdDJUqiXM0mIWEaLMBadL+M1NHnOn
 2mlMoRi8Zu+Hwb6vSroPSdCD643qJsKztflFKX+jZSa4VvPLANPNH5dSE6BYFcMch5VU
 jxdDoJPpU3nuHHNlA99e4ALAJb1gd+KrPStXitht6R1cJjko/qPLmhKSKBlIsd3xMKxO
 njLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=i0k6tnXlA8YN3a1p4jVUdxleH1KsWDeKTH2i3mE3wNE=;
 b=sOeOSEGxZgKAh5Sh4r9uBTTONKkO23xMNw7/zNOOFwdWKdQDwajXDTmascCK6H8vHz
 XO9fX7lZt5b7fnQwwo1N4MVuddvTpL6qf4E0BZSmKj7smdM4KgAFU7WZmxOkTrYlbxYY
 vxamYKCPCTm9l6raotU8ysQ5afhj9ay0NtKbwGct1YBQJ6oivqeq3youl5SQ+HdVmvQi
 jcVBJMjGed3NkjSBcGHWvpVF/q9a2IgCfC3cOJu5ti9nzkhluifysNe5uY88bDcbCyAH
 6S6q4rnUE9YdlFKqERtBxHEdx4tFy5OfJ1Ep3ln+1YlA0GEoI6xnkBC/M02/S8xlczHF
 PsgA==
X-Gm-Message-State: APjAAAUBUru1mSBxYTgfmFdutcdj35P/8YnNTCCeAOluACAwKDah5HSI
 l9Gv4z+b9qLLiczrIK6p9ywmR1yt
X-Google-Smtp-Source: APXvYqzedk9H2x+8eJ/+tyrhWzx+PXwjwLCyV8zj7TcpYoaGLtgA7LmGWBM5xBzj/GLDfvSldAZrzQ==
X-Received: by 2002:a17:90b:903:: with SMTP id
 bo3mr27112976pjb.52.1569855839674; 
 Mon, 30 Sep 2019 08:03:59 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.googlemail.com with ESMTPSA id w5sm13789703pfn.96.2019.09.30.08.03.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 30 Sep 2019 08:03:58 -0700 (PDT)
Subject: Re: [PATCH v3 02/18] target/s390x: Add ilen to unwind data
To: David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190926162615.31168-1-richard.henderson@linaro.org>
 <20190926162615.31168-3-richard.henderson@linaro.org>
 <4d1f9fbc-a6b3-cb7d-63a7-8d9568bc7406@redhat.com>
 <164856f8-fc7e-7a97-65b8-e1be2cf354be@linaro.org>
 <6557ae81-1e25-38bc-dff5-2d15b45284c5@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Openpgp: preference=signencrypt
Message-ID: <1ab7a5b3-40e8-c3ae-0877-07b8b50b90d1@twiddle.net>
Date: Mon, 30 Sep 2019 08:03:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6557ae81-1e25-38bc-dff5-2d15b45284c5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/30/19 12:55 AM, David Hildenbrand wrote:
>> What I think you should do instead is check env_neg(env)->icount_decr, exactly
>> like we do at the start of every basic block, and use that as an indication
>> that you should exit back to the main loop.
> 
> The issue is that when we return to the main loop we really have to
> inject an interrupt - otherwise we might simply skip parts of the
> (interruptible) instruction and continue with the next one.

Do we?  We will return to the main loop with psw.addr still pointing at MVCL,
so the interrupt is delivered, and when the exception returns we restart the
MVCL.  Or, an interrupt is not delivered and we restart from psw.addr and still
restart the MVCL.

We probably would have to take a hard look at EXECUTE of MVCL to see if that is
actually restartable.  Not that it makes particular sense to want that combo,
but it's required to work.

> However, with I/O interrupts, we can actually race against other VCPUs.
> So the I/O interrupt might be gone by the time we arrive in the main loop.

Of course, but it's no different with this case than any other.  If the
interrupt has already been handled, then we will simply restart the next TB as
per normal.


r~


