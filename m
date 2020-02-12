Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2998EC2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:03:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA2C52082F
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="msa/rAOc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA2C52082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1uTo-0002xK-72
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 11:03:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58771)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j1uT1-0002Rk-09
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:02:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j1uSv-0006ji-NP
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:02:22 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:41280)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j1uSv-0006jC-HI
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:02:17 -0500
Received: by mail-ot1-x341.google.com with SMTP id r27so2398204otc.8
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 08:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=jAoZfz/UvaecA57mSmtVqy/vLo3bWQsXaamXH+FO07w=;
 b=msa/rAOcErF4FfWc89IRgzQRP8XcB2ycEW3M8Sot0l7tSsfIJ8YKjo6N9RwqgNp2p/
 2cYix9FixcIawX73AcpyifdPXSAmOickRjtQJH47JoIOOTBEeytJtdZZ1T2yoeDGj+gi
 syzqquDxVYTqItso8pEU3kSk+bWlub3Nr8GjpoMqUotMwlBMHZyNFzEH+n/L19U1QeN/
 4C+dq7tVA6Ii5WiKMN1BglcgVkFlZDheO96UjcaWZAqAX916g/kyXhcDuX8dLfbxHxfH
 k/euUsUk//DO2FHjEcsRCmKRJu539EZhGfbR/PCyXF9e4pFuZ5S8R1FWyr6yL7K1fu1n
 6LMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=jAoZfz/UvaecA57mSmtVqy/vLo3bWQsXaamXH+FO07w=;
 b=MqO1Wson9EwU83wUif5WPyfbZJ6xHA19mpzRXhUHwO9iUXxgYAmEpBYp6FI4DY38YF
 yAaxVFeqp+oiXsSZgSn9IjUYqQB+Hz4Ahqc+NaOROLvgS96r0fkOOngDJ510MiRwLonF
 4NnK3r11v0Wk7p2h8vLEvpHIZ710Xhxyzsd+VHzi3EfyT3u7fHruBTdkCSa7n9UxmPE9
 SzDHqC5IxTBv7L88cXqPjX4REIw9HEo+/z7dvtCZxtXyZI5zDfJr8uDJllA0TT/mH+KZ
 Q6UPzxqWSL6Z/f3MTqaQRdqljaPRVjDnfHngHA7IhOwhU/Q5qMuZqjwu0Hqe0oVDBNJ/
 b14A==
X-Gm-Message-State: APjAAAXtE3uMrTKgN13LFBeKaAAi4lEDnfiV94XwFPfUIkkxYqJW8lHT
 +A1Q4nRcQ50Fdq837L3I1HFqNa4Vf5SOh9r3cj/N7A==
X-Google-Smtp-Source: APXvYqxflYP9llsj+DPkMnNgsUSYHz8lWRyoqmS7EzHEGlbLBwUzJFLxTT7ELmyduH7Bkp7WxBrreYFY7Gfq+mqAYpk=
X-Received: by 2002:a05:6830:1184:: with SMTP id
 u4mr9308009otq.221.1581523336118; 
 Wed, 12 Feb 2020 08:02:16 -0800 (PST)
MIME-Version: 1.0
References: <1908428819.7192207.1581512184275.JavaMail.zimbra@redhat.com>
 <1608747495.7195569.1581513386780.JavaMail.zimbra@redhat.com>
 <CAFEAcA-F-F1C4si7OXNkMnzE+9DHXtNnvCYv1eTx-nEpb4_OZw@mail.gmail.com>
 <20200212142832.GC434563@redhat.com>
In-Reply-To: <20200212142832.GC434563@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 12 Feb 2020 16:02:05 +0000
Message-ID: <CAFEAcA_VsdWJELxDuMJW9iaRsB-At_Dyf3Z6paOHWEp+VEhSgw@mail.gmail.com>
Subject: Re: [PATCH] docs: Fix virtiofsd.1 location
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Miroslav Rezanina <mrezanin@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 12 Feb 2020 at 14:28, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Wed, Feb 12, 2020 at 02:18:19PM +0000, Peter Maydell wrote:
> > On Wed, 12 Feb 2020 at 13:16, Miroslav Rezanina <mrezanin@redhat.com> w=
rote:
> > >
> > > Patch 6a7e2bbee5 docs: add virtiofsd(1) man page introduced new man
> > > page virtiofsd.1. Unfortunately, wrong file location is used as
> > > source for install command. This cause installation of docs fail.
> > >
> > > Fixing wrong location so installation is successful.
> > >
> > > Signed-off-by: Miroslav Rezanina <mrezanin@redhat.com>
> >
> > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> >
> > I noticed this in review of v1 of the patch
> > https://patchew.org/QEMU/20200127162514.56784-1-stefanha@redhat.com/
> > but missed that it hadn't been fixed in v2/v3.
>
> How come the mistake didn't break any of our CI ?  Looks like it
> should have failed due to non-existing source file

I imagine all our CI setups use separate-build-dir and don't
test 'make install'. This only shows up if you do build-in-source-tree
and then 'make install'. (In a separate-build-dir setup, the
MANUAL_BUILDDIR is the same as the actual build dir,
which is the same as make's current working directory, so
forgetting it in the install rune doesn't matter. In a build from
the source tree, Sphinx requires the output to be to a
different directory than the source, so we have to create
a subdirectory to be the MANUAL_BUILDDIR.)

thanks
-- PMM

