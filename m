Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77895C3F2D7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 17:53:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A9B120CC7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 17:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVd257Jm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A9B120CC7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9Bjt-0004Z9-Ha
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 12:53:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41781)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j9Bj7-00048u-FY
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 12:53:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j9Bj2-0008I3-Nn
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 12:53:05 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55663)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j9Bj2-0008Hr-HG
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 12:53:00 -0500
Received: by mail-wm1-x342.google.com with SMTP id 6so4306639wmi.5
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 09:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SmbmRWU+CAqmFAjgwYS5OZXkuNaI4SXr0bw40+zOD5I=;
 b=iVd257Jm9Ci8YC4U176vDLrhNuL15VLMyFuLqmKuhzEwJPkn//07KXOmvdVkpjwz0h
 70SIAs38Elk3xrjK4YVJowNmMPaxY8JBBH4PkXmJE6BdsoEpRRwceVE6PXGvRgpEYTYH
 FOzMRXb3x2gVuaqAu5BGgmNX4hIExZfV1w6vunaYB1ByDCtuCM+PuE+rvaBGnodI2vnb
 +7+CYqaVwX8EnzPLhFvbcJTc5oeahGuBZLMzxrP6vVIWB7IXO06Czk3hQdw1aTb3JL8i
 7Q7Pt7uo/AHW8OBO+Z1yuF7x5xoMBKnC7RUgJF0rQkJZWkwg33Nb9UAzp1p93PKhF28S
 9qlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=SmbmRWU+CAqmFAjgwYS5OZXkuNaI4SXr0bw40+zOD5I=;
 b=J53m7Nm8P73JyxeaRG/GwKJtI8l2Ch3FplfD692nZH7JGo6fPLTeOncq1nndUSrADO
 2c2+wH1/ORQhTpFjZlKpL9Wlbvr8XPjuFWpiqho1tuXA6DzRd0QlaCu9XLcYTBARBKOh
 3RiHw8FfplhF0L7aHl7gzJX3SpQuCPcrj1Lv7C8n4DOMgGnOJ3yTGWks7hWaFbrkra4K
 ulqiYBTcn3535k5cqq3xApWA+W5gJv7M0eUa8DQlUF7dR8y9nORooMSn1KUE+Dlf4eya
 nMnXMBtob1r7No/Ma1qH1JFlNXEbXbmGX4xsH+f2PHo7rX7veGfHT6XlGsSUQTyBTFu6
 YpVQ==
X-Gm-Message-State: ANhLgQ0ZywHyGQchXVTQryfjLeY54uZQUnKOUYs7q55oIw0JPW/ixWqE
 kMo06KUtI2GrAqChDpPPuJIaPfXb
X-Google-Smtp-Source: ADFU+vulffrL9q4xZrHQkLJ67h7jkbgJSymrrBDjF2vJYlPvQOzCj8PB1xHpbO18gip1Sm3Qa2oY8Q==
X-Received: by 2002:a1c:4d3:: with SMTP id 202mr5388288wme.172.1583257979370; 
 Tue, 03 Mar 2020 09:52:59 -0800 (PST)
Received: from [192.168.178.40] ([151.20.254.94])
 by smtp.googlemail.com with ESMTPSA id u185sm5390154wmg.6.2020.03.03.09.52.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Mar 2020 09:52:58 -0800 (PST)
Subject: Re: [EXTERNAL] Re: PATCH] WHPX: TSC get and set should be dependent
 on VM state
To: Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>
References: <SN4PR2101MB08804D23439166E81FF151F7C0EA0@SN4PR2101MB0880.namprd21.prod.outlook.com>
 <37e639a1-eb9f-b769-d61c-112d148bcff3@redhat.com>
 <SN4PR2101MB0880FE16EE36BF356552A9DDC0E80@SN4PR2101MB0880.namprd21.prod.outlook.com>
 <4277f568-2b20-f7c4-5764-f516c8e281a9@redhat.com>
 <SN4PR2101MB088094833D95758F871BE401C0E70@SN4PR2101MB0880.namprd21.prod.outlook.com>
From: Paolo Bonzini <bonzini@gnu.org>
Autocrypt: addr=bonzini@gnu.org; prefer-encrypt=mutual; keydata=
 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
 10oh++mb6s1dGf3ADAaOTRf8
Message-ID: <225d909b-fea7-a655-4271-ceccb7701993@gnu.org>
Date: Tue, 3 Mar 2020 18:52:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <SN4PR2101MB088094833D95758F871BE401C0E70@SN4PR2101MB0880.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: Stefan Weil <sw@weilnetz.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/03/20 20:59, Sunil Muthuswamy wrote:
>> You'd be using it to include a signed tags in a pull requests; that is,
>> the git tag that you ask to pull has a cryptographic signature attached
>> to it.
> Great. Is there a link that I can use to read up on how to get the GPG key
> and how to include the signature or what process should I be following?

This guide seems good, though I haven't tried:

https://medium.com/@ryanmillerc/use-gpg-signing-keys-with-git-on-windows-10-github-4acbced49f68

You don't need the "git config --local commit.gpgsign true" command, but
you will then create a signed tag with

	git tag -s -f qemu-for-upstream
	# let's say "mirror" is your github repo
	git push mirror +tags/for-upstream

and send it to Peter.  I really think we should document this final step
("send it to Peter") better in the wiki, because the git tools for
sending pull requests leave a lot to be desired.

Paolo

