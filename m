Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADDFC34021
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 16:30:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9F24214D8
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 16:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EC6lHMpE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9F24214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3jHi-00026V-RV
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 11:30:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56574)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j3jH7-0001ds-JN
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 11:29:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j3jH5-0008Pc-VA
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 11:29:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31603
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j3jH5-0008PU-Ne
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 11:29:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581956974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B4oYyeK0rxIgLo+WM6R6TbnUYpk/8y5GQI+fFggOsFY=;
 b=EC6lHMpEJTAe9qATLf4iDjxnlAxZ8S62zpCZqVrI24RWiZ1h3v1OS1JlUsVdtu2CWQsIPt
 8KC0jPUmfygiOWRex9knrXMd0YMGvAmYArkTJeEpfrVXcAyt7ElTf92i3EIBMIvdoRfxN3
 BYega+9x6+yYYEmfr+T4CgJ2GuL9A2k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-adiqBEHMPna7JNykr2d_SQ-1; Mon, 17 Feb 2020 11:29:33 -0500
Received: by mail-wr1-f71.google.com with SMTP id c6so9144478wrm.18
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 08:29:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=B4oYyeK0rxIgLo+WM6R6TbnUYpk/8y5GQI+fFggOsFY=;
 b=XATfnVfkVDvOKTwYIKN0hFR2HGf922Ml2vu3R4zNmYa1fEovW0ZXjXQTYAjzLnVk74
 MSDDME1iGiD8bGKQH1ssHk5gybSS1gcUJgZ3vsmPwdL+CuOeohB7xLIAYfmiVQ4hoCnp
 rp/DPWgdo/s6HbMPbMs5wM3X3QftJ/gmQdBYqz1S2RFDj1wSjOv4YNAnXZU2yX5ohOYl
 AIC3PRkFj5Q0TCj7mxYMVWavvHTLdbp3d9s13FsM41oozvKOjIHRUIhzImyiX+MrmvhQ
 46lc8v5boy2YaO/VskF18AFnIPh/YkPB6nkf7ijZzfHW/qL4vbIQxJZivoIr4y46wBOb
 uppA==
X-Gm-Message-State: APjAAAWtk3XpKM7QSwjVnaMZG2J1WyE0AZVHf0Gf7vsyiK03e8y+vYCJ
 tLQutOnSL6R+my9bFahVWMZsZF4EfSKiucy5krRV2a+fbI067EnmmJb3km9fqNh0x0sHu+Jw4SI
 JdzpMUGk3UGGtwMg=
X-Received: by 2002:a7b:c652:: with SMTP id q18mr22586955wmk.123.1581956971813; 
 Mon, 17 Feb 2020 08:29:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqx6no6GEQA5g9nRv71krFgf51InpcUVW2NB7hOacMUJUG9EWvPPTGLpLrs5PoF5KJaO52KKPQ==
X-Received: by 2002:a7b:c652:: with SMTP id q18mr22586942wmk.123.1581956971579; 
 Mon, 17 Feb 2020 08:29:31 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:59c7:c3ee:2dec:d2b4?
 ([2001:b07:6468:f312:59c7:c3ee:2dec:d2b4])
 by smtp.gmail.com with ESMTPSA id 5sm1843044wrc.75.2020.02.17.08.29.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 08:29:31 -0800 (PST)
Subject: Re: [PATCH 0/3] docs: Create a 'tools' manual
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200217155415.30949-1-peter.maydell@linaro.org>
 <1865c4e9-a0b5-0c50-adb8-e46da1b0d8a9@redhat.com>
 <CAFEAcA8T0LXra=P9r0xwEA809R++hxbfUCz5d8g7h6=fX0-azw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6aceeb16-faa9-8621-b997-8cb1c161c8c1@redhat.com>
Date: Mon, 17 Feb 2020 17:29:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8T0LXra=P9r0xwEA809R++hxbfUCz5d8g7h6=fX0-azw@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: adiqBEHMPna7JNykr2d_SQ-1
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/02/20 17:18, Peter Maydell wrote:
> The mechanics for handling .hx files are already in the tree;
> I can either help or work on the bit of qemu.1 that uses those.

Right, basically if somebody else does qemu.1 I won't complain. :)  But
recently I retested the makeinfo+pandoc magic formulae that convert the
rest into rST and they work so I can take care of that part.

> Kashyap has volunteered to do qemu-cpu-models.texi.
> I have patches on-list that try to do the QAPI doc-comments.
> 
> I think the next thing after this is to take chunks of documentation
> that are currently used in qemu-doc.html but not put into the
> qemu.1 manpage (ie which aren't in the 'man begin'/'man end'
> sections), and convert those into individual .rst files
> to go into docs/system:
> 
>  * docs/security.texi
>  * qemu-tech.texi
>  * qemu-deprecated.texi
>  * various bits of qemu-doc.texi that don't go in the
>    manpage and that are coherent chunks of documentation,
>    eg "Supported build platforms", the various "$ARCH System emulator"
>    sections

One initial step here is to split qemu-doc.texi into separate Texinfo
files.  I can take a look at that as well.

Paolo

> That will whittle qemu-doc.texi down to more or less just
> the contents of the manpage. Then we can convert that
> part to rST.
> 
> I note that softfreeze is now 1 month away -- we should
> decide whether we think we can get this basically all
> done by then, or whether there's a good "pause point"
> we'd like to use where, say, most of qemu-doc.texi
> remains as it is, or where it retains just the
> content that goes into the qemu.1 manpage.


