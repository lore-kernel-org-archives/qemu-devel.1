Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFA8C54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 14:41:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED41B20728
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 14:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cardinalpeak-com.20150623.gappssmtp.com header.i=@cardinalpeak-com.20150623.gappssmtp.com header.b="UTfe8V7t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED41B20728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cardinalpeak.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRd32-0002UI-47
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 10:41:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34890)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dchristian@cardinalpeak.com>) id 1jRd1z-0001nL-Pe
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 10:40:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dchristian@cardinalpeak.com>) id 1jRd1z-0006XN-4e
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 10:40:47 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d]:46659)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dchristian@cardinalpeak.com>)
 id 1jRd1y-0006SU-Bt
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 10:40:46 -0400
Received: by mail-lj1-x22d.google.com with SMTP id f18so6428163lja.13
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 07:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cardinalpeak-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tmLqaNswjqFAUBlD9UrfA1571Gkff0hD3Gr6LMr1eXM=;
 b=UTfe8V7tUCp3tf0TmvQDW0g7vMRjuhE8Mx44o+k9qcPxCRcDne6xmJgxAAQvofEbr7
 5FViDpS4QV1Y1J5rzSc6r+5cRFdEAL/MCqazfjVVhbRQ2PSRHUyiUDm9bGSMMLbfH7Ct
 wTGzWYQHPIpjBcUCT+dLb4d7S73hcMUbVS+6IDse9JXTXwZBMylo8JJa6hnKKP3kuNy4
 rEbhWxdr2Pbc7OiYp2IXJxIO3kwDlobdpDO/XsUNb0FSzKCnM7Y6dUK0xkEUqYULZv7r
 wvA0xJaKV1Bw4KLM+d4pAuVx07y+auy8IFtBsYoEmbNTQKjlP0kQoJQmQAZKw0b/bBY1
 V5LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tmLqaNswjqFAUBlD9UrfA1571Gkff0hD3Gr6LMr1eXM=;
 b=l7I62NOqOhkcKR5FxljHxaUJd4nTWwo1o14eRZHdo5f9N4Ydci3+lF8ODg9e6C8ChY
 yI9pu17IOADv+7I+HdAaPc/l8TkhiUHRAPDwo8LDbD8nYPIzH5whT/Tmm77rdqXbXiod
 Wd7VUaLkA+OefW4shK5xAqdC3FFpo5RiejrVvcCm3wEhLoZM0b1YpzFItPXehly8Ydtr
 S3gddtryyF1NueXUlqwhicgF40yNwUipyea1suJCegRN1zeIdZ6LfPecMr4//WDwfb9H
 //84H9o62aY+edwbd8tiGx5qRkWqK2gIViZyE8lTw4Mnt35bLMHMpC2KcA0wMB/npFy1
 RY9w==
X-Gm-Message-State: AGi0PuZpABxnYsmUiYiuqOen/PMU4ugI/UujVmmGswdKtCuLMhKyWrX9
 T/b6CIkBInPBWDVsCkb+jJ9kDGy/DXvlJd3AmenirA==
X-Google-Smtp-Source: APiQypJmmOqGMV5SzSqewnpwZOG3qBnufMql3LKKBN99hHHdV1DHM/otWnkxaujy+IWEy5Gx+dP7Sf3709rxvOmudHk=
X-Received: by 2002:a05:651c:287:: with SMTP id
 b7mr2689429ljo.82.1587652843130; 
 Thu, 23 Apr 2020 07:40:43 -0700 (PDT)
MIME-Version: 1.0
References: <CADxL6wUGWZO0U=G7UTAebG57m6tG58hoMf_-TCC+0qReUB0G6w@mail.gmail.com>
 <20200423141112.GE1077680@redhat.com>
In-Reply-To: <20200423141112.GE1077680@redhat.com>
From: Dan Christian <dchristian@cardinalpeak.com>
Date: Thu, 23 Apr 2020 08:40:32 -0600
Message-ID: <CADxL6wX-0Lt_LKT9pQMiK3Y1L0tdrF9G23dfYU=9FXgFZB-4Fw@mail.gmail.com>
Subject: Re: Need BT support in qemu for Zephyr
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000bde23305a3f63b32"
Received-SPF: none client-ip=2a00:1450:4864:20::22d;
 envelope-from=dchristian@cardinalpeak.com; helo=mail-lj1-x22d.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::22d
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000bde23305a3f63b32
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'm new to trying to use qemu+bt (via btproxy) and haven't managed to get
anything working.

btproxy is launched first, then Zephyr launches qemu via it's west tool.
The commands look like:
sudo tools/btproxy -u -i 0 -d # in a separate window
x86_64-pokysdk-linux/usr/bin/qemu-system-aarch64 -cpu cortex-a53 -nographic
-machine virt -
net none -pidfile qemu.pid -chardev stdio,id=3Dcon,mux=3Don -serial chardev=
:con
-mon chardev=3Dcon,mode=3Dreadline -serial unix:/tmp/bt-server-bredr -kerne=
l
/home/dchristian/share-fb/zephyrproject/zephy
r/build/zephyr/zephyr.elf

It's failing with a device busy when btproxy tries to bind to the adapter.
I don't think this is a quemu issue.

Zephyr packages it's own qemu:  QEMU emulator version 4.2.0 (v4.2.0-dirty)

Dan


On Thu, Apr 23, 2020 at 8:11 AM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m>
wrote:

> On Thu, Apr 23, 2020 at 07:33:37AM -0600, Dan Christian wrote:
>
>

--000000000000bde23305a3f63b32
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">I&#39;m new to trying to use qemu+bt (via=
 btproxy) and haven&#39;t managed to get anything working.<div><br></div><d=
iv>btproxy is launched first, then Zephyr launches qemu via it&#39;s west t=
ool.=C2=A0 The commands look like:</div><div><font face=3D"monospace"><span=
 style=3D"color:rgb(0,0,0)">sudo tools/btproxy -u -i 0 -d # in a separate w=
indow</span><br></font></div><div><font face=3D"monospace">x86_64-pokysdk-l=
inux/usr/bin/<span style=3D"color:rgb(0,0,0)">qemu-system-aarch64 -cpu cort=
ex-a53 -nographic -machine virt -</span><br>net none -pidfile qemu.pid -cha=
rdev stdio,id=3Dcon,mux=3Don -serial chardev:con -mon chardev=3Dcon,mode=3D=
readline -serial unix:/tmp/bt-server-bredr -kernel /home/dchristian/share-f=
b/zephyrproject/zephy<br>r/build/zephyr/zephyr.elf</font><br></div><div><sp=
an style=3D"font-family:monospace"><br></span></div><div><span style=3D"fon=
t-family:monospace">It&#39;s failing with a device busy when btproxy tries=
=C2=A0to bind to the adapter.=C2=A0 I don&#39;t think this is a quemu=C2=A0=
issue.</span></div><div><span style=3D"font-family:monospace"><br></span></=
div><div><span style=3D"font-family:monospace">Zephyr packages it&#39;s own=
 qemu:=C2=A0=C2=A0</span>QEMU emulator version 4.2.0 (v4.2.0-dirty)</div><b=
r></div><div>Dan</div><div><br></div><br><div class=3D"gmail_quote"><div di=
r=3D"ltr" class=3D"gmail_attr">On Thu, Apr 23, 2020 at 8:11 AM Daniel P. Be=
rrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redhat.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">O=
n Thu, Apr 23, 2020 at 07:33:37AM -0600, Dan Christian wrote:<br><br>
</blockquote></div></div>

--000000000000bde23305a3f63b32--

