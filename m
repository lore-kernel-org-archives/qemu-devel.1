Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10065C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 14:38:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD84720838
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 14:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ahNZNMfl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD84720838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv06m-0002pN-96
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 09:38:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45426)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iv06D-0002Oz-BB
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 09:38:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iv06C-0002ae-0D
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 09:38:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42941
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iv06B-0002X6-Hs
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 09:38:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579876694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eyUcU+V4lHSk5W8E9HKjD42DV58uLud3FhLk+VSRftQ=;
 b=ahNZNMflyYREXlNHLfAQLPF9X5dRRvJuKBP2KC7WFygR3dwqxyzdJgfWb2TKlEcQmMe4d7
 9D1jhItcvYY5370s+t7pfN6nfEXDQ3UKWqUUSzVmJDZJN8/BC6NpyrvNdK1xz3Bj/eDpHu
 H3s0ENN3kO2jyq9rSMx/q3s74dPo4Kk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-OeJ8yHCaOeWXyrz5qI6AwA-1; Fri, 24 Jan 2020 09:38:10 -0500
Received: by mail-wr1-f69.google.com with SMTP id f17so1358457wrt.19
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 06:38:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JttKX3bF0Km785u25+/taSKxdyIum3B6Pbv+HGQwX34=;
 b=l+Xf415HzOyu+6X2ZqYNdtmi4ssjWzUVZijkqqst6kA4vsbJEDgX4mol+Oj/wvijTH
 bcLpEKuMYoFPJlvJFURIRIZ75u8b26awBlzm8//mMBIWXNZ/2llr/EJ49Zme3lotNzaO
 Fhdvn0aC3+CGuLZ1EzM/lZtZtmD03tzqZRw977dCgonQ2MkWoQ7ov2UQn1dihXGLGg01
 LyjuKX04Tns8arYoPv4E0UsQwgHDqMvXXbzKhFi4GqCj7mpKUfJw7OSVmPxWJxYffEmZ
 vHOJ57DWJrCj4RE9dnikqqCrbX9eXEgkZGGeiOkcN0HPW5WWQnu0A65idVmWJwAZflnE
 K5OA==
X-Gm-Message-State: APjAAAUHbXJj/7o1xEH6W40EUaU8Nc5HBMZOjKLjZYY49WnWRD8xD0pK
 Lej7kax8r0zlUTggk55WanLIhVfFI6UQwmo5mbqRN5p4gFs5qnTXDWUNFr7kOoyzD/C9E8bnsxx
 k6zo83Jmx1Suf1jU=
X-Received: by 2002:a7b:c318:: with SMTP id k24mr3855829wmj.54.1579876689315; 
 Fri, 24 Jan 2020 06:38:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqzU/6hLSaAhU4Pc8cjUkXKJoVRhBhuNbPq3Nan3xIueOYPQCnMBF6az9DIc42uE4FnhFSTH5Q==
X-Received: by 2002:a7b:c318:: with SMTP id k24mr3855804wmj.54.1579876688995; 
 Fri, 24 Jan 2020 06:38:08 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b8fe:679e:87eb:c059?
 ([2001:b07:6468:f312:b8fe:679e:87eb:c059])
 by smtp.gmail.com with ESMTPSA id q19sm6742846wmc.12.2020.01.24.06.38.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2020 06:38:08 -0800 (PST)
Subject: Re: [PULL v2 00/59] Misc (x86 and QOM) patches for 2020-01-23
To: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
 <CAFEAcA8R5yDfAYYraeBStD_Oh7G60QSgUaw_JVdqC=C8y4n0Jw@mail.gmail.com>
 <CABgObfZF7D+MgxXMDbrqZQpOb6WaOiKFaLSUv9U+3Ufb0GGKMw@mail.gmail.com>
 <f03723ca-9514-149a-180e-172a88f6e4f0@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <96dbb37e-b99a-17f3-0fc4-aa914ceda0f0@redhat.com>
Date: Fri, 24 Jan 2020 15:38:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <f03723ca-9514-149a-180e-172a88f6e4f0@linaro.org>
Content-Language: en-US
X-MC-Unique: OeJ8yHCaOeWXyrz5qI6AwA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/01/20 00:31, Richard Henderson wrote:
> On 1/23/20 9:20 AM, Paolo Bonzini wrote:
>> Il gio 23 gen 2020, 19:43 Peter Maydell <peter.maydell@linaro.org
>> <mailto:peter.maydell@linaro.org>> ha scritto:
>>     When I try to build-test this merge, the clang sanitizer
>>     build seems to fail whenever it tries to link anything:
>>     (configure args '--cc=3Dclang' '--cxx=3Dclang++' '--enable-gtk'
>>     '--extra-cflags=3D-fsanitize=3Dundefined=C2=A0 -fno-sanitize=3Dshift=
-base -Werror')
>>
>>
>> That's intended, you need to add -fsanitize=3Dundefined to --extra-ldfla=
gs as
>> well now. I can change that back, but then I am not sure what one would =
use
>> --extra-ldflags for.
>=20
> This seems broken to me.  Most cflags have to be present on the link line=
 as
> well, unless you know very much what you're doing.  I would not expect
> --extra-cflags to have to be repeated.

But then Peter's command line is missing --extra-cxxflags.  So I think
more clarity is better even at the cost of verbosity.  Anyway, for now
I'll make --extra-cflags affect both EXTRA_CFLAGS and EXTRA_LDFLAGS.

Paolo


