Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D64C35647
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:27:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E8F8222C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MjoKaU8F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E8F8222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58Kp-0003Zs-6T
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:27:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57552)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j583m-0001iD-8G
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:09:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j583l-0005e2-2s
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:09:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55527
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j583k-0005al-Tr
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:09:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582290576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NQbeFl2hhSMamiHGGFNVxXXEEsK3mfH7N2oov1RSkp0=;
 b=MjoKaU8FawsKwOXJhlGjaOZePb0VyQ8k6O9r5UK/CX7+972+RXksBLBkUUyKiW7Otl0mwa
 R5UBCLshkbnj8Q78R3oHTt9PR9fl1c4kuewZ8oQ7vvHPa8zkwT8AchwDI0dfeHvzYiC/Fy
 XV9e3xhKP1mRxrg3CNjnEk+nP9C0IY4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-4Ahbd55cNHea0wv39p8oug-1; Fri, 21 Feb 2020 08:09:35 -0500
X-MC-Unique: 4Ahbd55cNHea0wv39p8oug-1
Received: by mail-wr1-f69.google.com with SMTP id l1so1009797wrt.4
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 05:09:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NQbeFl2hhSMamiHGGFNVxXXEEsK3mfH7N2oov1RSkp0=;
 b=nsXKXh69IdRRUqZTPYA+5szeeHWa67XyxffaAk50zprUYVpvtr8t9+O9JS1YqrSupY
 90xHdFBRXdUf9ujGWUoxGW4i6BHrIsdVrq4CZKzHkHOdxHPwRL6Od4N/ewh/KaQpgViu
 b9Kvgv6OcHZnN+vcDxJIbvLFnwVlT5bJ2rBfuutQCmPgzlub8K4Uw8CWg8CTy07zljLJ
 BqXYtM0umb9ZNE51H6S0OAel9hPbN2Aws0v6MQLxuq+buIARPClIZCPtkihwUG/+4rQI
 vAMIfed9bqDb9xLpB8tmahp3bdqiDF916+kPKS47ZVJxsJlZ060vcacWoZxm3oWsqiJX
 CelQ==
X-Gm-Message-State: APjAAAWiZ4jcN8B264Aoy+twWX0ioAAX9YO9lbe7Ho0ZizGmDEljlFQR
 w6RdRUbcSC4isOU342uDNteNMTENYhiaBfa/Xt8AALZieSkQBXKrYPRxxiZq76318x49r5eqln9
 uxlR1be3cIEkbHCA=
X-Received: by 2002:a1c:ddd6:: with SMTP id u205mr3984732wmg.151.1582290573770; 
 Fri, 21 Feb 2020 05:09:33 -0800 (PST)
X-Google-Smtp-Source: APXvYqxf+z72cnJuaup+vuvZwt07xHJKSUaDFI9cTtBPTkP+jBIFDagsveUV068gQGVRrT4TlcYN/w==
X-Received: by 2002:a1c:ddd6:: with SMTP id u205mr3984701wmg.151.1582290573474; 
 Fri, 21 Feb 2020 05:09:33 -0800 (PST)
Received: from [192.168.178.40] ([151.20.135.128])
 by smtp.gmail.com with ESMTPSA id r7sm1704369wmh.45.2020.02.21.05.09.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2020 05:09:32 -0800 (PST)
Subject: Re: [PATCH] hw/char/pl011: Output characters using best-effort mode
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200220060108.143668-1-gshan@redhat.com>
 <f3c8adba729d050ba2144cc9c834fe82@kernel.org>
 <CAFEAcA8inLO75XOcCO3bUiiJQyZT+nqmp1be+z6ZtQx2a=68+g@mail.gmail.com>
 <fda602ae-43d5-728c-a5bb-f607f0acd3df@redhat.com>
 <CAFEAcA-VB1t2XDuAHgq_p2Fz8NQ+3HFgyNOzRjk8BjixNJb0qg@mail.gmail.com>
 <eedbac05-5a17-82e6-3cdc-c3b21983545b@redhat.com>
 <CAFEAcA-bHCLQGkFucY5RAY-mw9wFdDeOqCkcv0xgSRg-EYh9ew@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fe7f3a60-5d90-ea3c-44d1-119f8b45b15c@redhat.com>
Date: Fri, 21 Feb 2020 14:09:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-bHCLQGkFucY5RAY-mw9wFdDeOqCkcv0xgSRg-EYh9ew@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Gavin Shan <gshan@redhat.com>, Marc Zyngier <maz@kernel.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 Shan Gavin <shan.gavin@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/02/20 13:44, Peter Maydell wrote:
> On Fri, 21 Feb 2020 at 11:44, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 21/02/20 11:21, Peter Maydell wrote:
>>> Before you do that, I would suggest investigating:
>>>  * is this a problem we've already had on x86 and that there is a
>>>    standard solution for
>> Disconnected sockets always lose data (see tcp_chr_write in
>> chardev/char-socket.c).
>>
>> For connected sockets, 8250 does at most 4 retries (each retry is
>> triggered by POLLOUT|POLLHUP).  After these four retries the output
>> chardev is considered broken, just like in Gavin's patch, and only a
>> reset will restart the output.
>>
>>>  * should this be applicable to more than just the socket chardev?
>>>    What's special about the socket chardev?
>>
>> For 8250 there's no difference between socket and everything else.
> 
> Interesting, I didn't know our 8250 emulation had this
> retry-and-drop-data logic. Is it feasible to put it into
> the chardev layer instead, so that every serial device
> can get it without having to manually implement it?

Yes, it should be possible.  But I must say I'm not sure why it exists
at all.  Maybe it should be dropped instead.  Instead, we should make
sure that after POLLHUP (the socket is disconnected) data is dropped.
Then, having retries triggered by repeated POLLOUT should not matter
very much.

Paolo


