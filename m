Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0633CCA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 16:39:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C28132053B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 16:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ipdvKGbr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C28132053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMaiK-0000ue-O6
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 12:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38884)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iMagk-0007qZ-6I
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:37:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iMagi-0003zo-09
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:37:45 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:39216)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iMagh-0003zP-R4
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:37:43 -0400
Received: by mail-pl1-x641.google.com with SMTP id s17so6873659plp.6
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 09:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=yyBsV81B9TiiGOGFut9ASC+PoAWiM5D6xCvxrOZRGAs=;
 b=ipdvKGbrDH9LyzdiuPKW9Rl0imPmc4UhcQB4f6EZaZ2oQNH6ys9nD5gC7F3oLROKKl
 JGJN0ch0EqrEguxF3PmGCfDOWKoMWyW1CpQT1gKN++/ztuNorzK3ZCvTZlK8b3IqP5d8
 rAaIqLWv2MWieGey75O3nLTtAxju0uvQzGYwDUGCgHs6V3DLuwd4Z7x4d/Eek7H87pYL
 T846er3g25nHd8QMeQf2kRaH0Emmub7rWoSPvNvMlR/IUdKXusFha9B0bMGdKOVFCpFo
 S7yHrJFUbgKjULWJdQyEx0WPxU0JYvzYdrDZTxjy6iVpUE7ce4O2YrtxHimVyVtsRG2T
 yB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yyBsV81B9TiiGOGFut9ASC+PoAWiM5D6xCvxrOZRGAs=;
 b=K7EHcXluxT8HeW3QaV88+Lz/S/RitP/+CFdK89MWz4uXiiJVgqXuQ0W0UPSfXvfYeT
 YEDod6IduC97DY35OeHmxPADYJym8Nv+XJRzINGji1VWTupjbXHKoqcAgsiQmUm+/BV5
 7ApCHj33FTG/ncbKCglQgyFsCEHyV+QIayzLf45T1Oiuu8CjIUl5P69CCx7y/Xl+IC+o
 UEOvKVxJL7Dit1vsTYa64DHYdhJcfzCM/LbVNiKF524wPuwc4F8jmLLz8FiW4FBX0yN7
 swpg5GYNmJgG11EIAXQAVSXJ2xCHSDWpMJ1cxYYfRwBz1n/wo118l+pFVvmmCiI7ltZM
 /ubA==
X-Gm-Message-State: APjAAAVkzUPUIl+kblF97EJt317BtL6xubCrhhrkMKP5s0NILvxvh3oe
 8CZGcQQvsBP2ML51u3Qi4t9+fQ==
X-Google-Smtp-Source: APXvYqzvTHyLpwVCORXdoA0tmwYmyAqYFgyeqPwoQCoZ6WOKbQ1/qaf0h/+LzBAOPaG2YTLchC9WTA==
X-Received: by 2002:a17:902:fe04:: with SMTP id
 g4mr14039888plj.58.1571675861465; 
 Mon, 21 Oct 2019 09:37:41 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id w12sm19274847pfq.138.2019.10.21.09.37.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Oct 2019 09:37:40 -0700 (PDT)
Subject: Re: s390x/qemu-user: TODO /home/dhildenb/git/qemu/tcg/tci.c:859:
 tcg_qemu_tb_exec()
To: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 qemu-s390x <qemu-s390x@nongnu.org>, Stefan Weil <sw@weilnetz.de>
References: <60a0d510-b693-0ed7-560f-e70904d9574d@redhat.com>
 <9925b761-6d9b-2361-1697-a8a726b2ef21@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <2848d03e-4aa6-d74e-14fe-afa9fd107171@linaro.org>
Date: Mon, 21 Oct 2019 09:37:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <9925b761-6d9b-2361-1697-a8a726b2ef21@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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

On 10/17/19 4:01 AM, Thomas Huth wrote:
> On 17/10/2019 12.02, David Hildenbrand wrote:
>> Hi,
>>
>> I'm currently trying to run Fedora 31 under qemu-user
>> (https://github.com/fedora-cloud/docker-brew-fedora/tree/8a81f67271e959dfc8f8a888b161bbd540b7a83b/s390x)
>> in order to debug  a vector instruction issue.
>>
>> Strangely, when trying to chroot into above rootfs and running
>> /bin/bash, I get
>>
>> t460s: ~/f31  $ sudo chroot . ./qemu-s390x  /bin/bash
>> TODO /home/dhildenb/git/qemu/tcg/tci.c:859: tcg_qemu_tb_exec()
>> /home/dhildenb/git/qemu/tcg/tci.c:859: tcg fatal error
>> Aborted
> 
> That's likely the issue which might be fixed by Stefan's patch here:
> 
> https://patchwork.ozlabs.org/patch/1083601/
> 
> ... unfortunately, this has never been merged into master. Stefan, any
> chance that you could finally get this upstream?

Oops.  Sorry about that.  Queued.


r~


