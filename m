Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76DEC4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 13:19:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84509246A1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 13:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fn45oFol"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84509246A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7J4m-0004LW-O8
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 08:19:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57647)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j7J3u-0003UV-TJ
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:18:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j7J3t-0002f2-RC
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:18:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21658
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j7J3t-0002dn-Mo
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:18:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582809525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5fWPI0So0kRNF67hG8L/t6xJt78gjPmuZxHM8Ow+eqQ=;
 b=Fn45oFolmi1BvRYpiai6E8jX4NylKZncgh41/N9pKKozyW9v8taLNcZtVRb7hWSbo+wNfB
 kzowO/2LKGxv9j3up7HtkPE0KuZSszWxN3TMQrIE4ETGhia0l2bYHGu8sbs+5W2S4M/wUi
 jH2wQl+njdbnbAMW93RU9APQy2PI1SM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-ZZ78be1FNcSjfVqtOXnaDQ-1; Thu, 27 Feb 2020 08:18:37 -0500
X-MC-Unique: ZZ78be1FNcSjfVqtOXnaDQ-1
Received: by mail-wr1-f69.google.com with SMTP id w18so1311065wro.2
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 05:18:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5fWPI0So0kRNF67hG8L/t6xJt78gjPmuZxHM8Ow+eqQ=;
 b=QFspBL1T2Ywl3+DH9mG+YYD7HD6rKrRNvq+CUYoyp8EVnJUoC58wWtEYFAKcvkBvXA
 4d1QUEZyj7hETrUx7asw8eDgIZcE1aCQoUfYuSBqNOtCwnGAdRu+jv4gyFiBoth5uCkK
 zZibrMRKQbo1/FhNVdPVMm1dM3wUa6DdJciBEXqbDN9jj0js7Sps/7+mPWptV5Tsrq7Q
 Ihi4RgvUJPP0NsoIu5ZmXEQ7yhrnEp4fheFlbvvjVdSzBk26gArCcg3gQ18XXjPrH21Y
 ca1f9mg9mMPCpARE6zGlzaQUK7KXaPdept04KmUS8xkD6blruvY3UEXhT1YFijTLvUSP
 p8AA==
X-Gm-Message-State: APjAAAVqFTmtPQq9J91g1XwvCJkMYeFIWTjeJ/aFYqs+vVIUQOjkQUB6
 m/vkycZr+pd4VCGOWXZG/YKEkxUjTbZI/5qD51mbETlLZwthirPXYVZ/Nnz7F6UuLUOrmHhAyAv
 LOttJSr+hLVSuW8A=
X-Received: by 2002:a1c:9d85:: with SMTP id g127mr5256663wme.75.1582809516312; 
 Thu, 27 Feb 2020 05:18:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqwWSZbCDewlyvsPOv6rsjA55GGXuZB8IBrrAGKRJvQDQ5tvi90k22B9VC7vdYZ5+LH1DYH98A==
X-Received: by 2002:a1c:9d85:: with SMTP id g127mr5256649wme.75.1582809516072; 
 Thu, 27 Feb 2020 05:18:36 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:30cb:d037:e500:2b47?
 ([2001:b07:6468:f312:30cb:d037:e500:2b47])
 by smtp.gmail.com with ESMTPSA id e22sm8162002wme.45.2020.02.27.05.18.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2020 05:18:35 -0800 (PST)
Subject: Re: [PATCH 18/18] docs/system: convert Texinfo documentation to rST
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200226113034.6741-1-pbonzini@redhat.com>
 <20200226113034.6741-19-pbonzini@redhat.com>
 <CAFEAcA_721QV7FKjmnFHUZsvHrACkFsu2hya_CeMe2wqOFoB_A@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a49bf9be-e835-adfd-5532-93d61afb556e@redhat.com>
Date: Thu, 27 Feb 2020 14:18:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_721QV7FKjmnFHUZsvHrACkFsu2hya_CeMe2wqOFoB_A@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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

On 27/02/20 13:26, Peter Maydell wrote:
> My Sphinx doesn't like this:
> 
> Warning, treated as error:
> /home/petmay01/linaro/qemu-from-laptop/qemu/docs/system/target-arm.rst:using
> "math" markup without a Sphinx math extension active, please use one
> of the math extensions described at
> http://sphinx-doc.org/en/master/ext/math.html

Interesting, it works for me.  Maybe some difference between Fedora and
whatever distro you're using, or something like that.

> This is all down to the I2C/I2S usage of superscript; this fixes it:

Yes, that should do.

Also:

> - images.rst: add toctree

There is no toctree anymore in this file.

Paolo


