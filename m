Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018A0C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 11:37:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACD8B22464
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 11:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uMc1oaH1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACD8B22464
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itVMb-0003Ma-Rc
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 06:37:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47394)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1itVLk-0002dq-Qs
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 06:36:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1itVLj-0002KC-JP
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 06:36:08 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35257)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1itVLj-0002Jl-9P
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 06:36:07 -0500
Received: by mail-wr1-x442.google.com with SMTP id g17so29150575wro.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 03:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=EFbiN+5Hbkmk46/m9iWxcJW6hNcKw74W4TBQEkHBnSA=;
 b=uMc1oaH14PvThoan0Kn1Z4Bj2gK3JPoqmHKVw1yagVAjrno/2LSPLSI+dz5rjf34v8
 kIDkulcMYMl+4O1bd3WJQGuwwSxX/8xvRD6+vIhSwGaJBAVjyQ4crO0xwDypyjTmRoNt
 jinqJ+QGywhe4pEpBGyI9FW1nM7Elj4q3pQ8GUSETXLDicoqhhQRl6hNz95OFC5kldhE
 uA0PK9fgp3sJCija5fx++pSA2Abn5cSJtPdpx3/QQSPV8WPik8CWCwEAi0Yn/ESHnvlq
 kXOVhLm/o4Taja40EjqUXe1IRDjkKD4mkcdbdjlYsgFc7HBu6gQMSroptfvWao/C/Jtl
 qT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=EFbiN+5Hbkmk46/m9iWxcJW6hNcKw74W4TBQEkHBnSA=;
 b=HkUSs7u9tVbbIhalxVZvr4D5cD9DSn/yqNTjO3OfVYyF47/f2MEItlNm1msc7ljBi1
 ujnH0y1SMEWjXf+IMUF1wKZ2n89ykieqXnlKmbsQwx6qTIs924Z3V9remkadfRmWtocd
 BmU9wYQjeXPHxLJulwjMLhqckqXG06o5aG/x4DaGW/bi6AeRTVg4x2FzVdEvsAq5YLBt
 6B1KRYK0uUKYFMVLKUFfkhf8J6v2LPXx0qSW23Te4sDLUqp9xpOj6A0xLJG+nLmieGYX
 MOdy4IXQT5RVx6WPtn+YfGSQ9bUkMdVf6BF+MyChLcjg/ENJNzl2zlxCLzA3cbIq4ERe
 pKow==
X-Gm-Message-State: APjAAAX5+2Yz4ZEU5C0zbp44R9KQm6vuh+XSuEjV/dm8SpV9ektCl/M3
 LZrw/tlhCfejJJnEAx4MUmbXcg==
X-Google-Smtp-Source: APXvYqyk6WyOgbnZ8tIzFAUM15qZyXFW82pZl2q8131nrVia78VBDBgdDZVowzOL0KG57Do5Swi0aw==
X-Received: by 2002:adf:f28c:: with SMTP id k12mr18289248wro.360.1579520165376; 
 Mon, 20 Jan 2020 03:36:05 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f1sm48149995wrp.93.2020.01.20.03.36.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 03:36:04 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 13A7B1FF87;
 Mon, 20 Jan 2020 11:36:03 +0000 (GMT)
References: <20200114030138.260347-1-jkz@google.com>
 <87h80ymhcd.fsf@linaro.org>
 <CADgy-2vNk5RKV5VdcaFANiopezPKEgdSSHsQc=a_WaWgsAvxzA@mail.gmail.com>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Josh Kunz <jkz@google.com>
Subject: Re: [PATCH 0/4] migration: Replace gemu_log with qemu_log
In-reply-to: <CADgy-2vNk5RKV5VdcaFANiopezPKEgdSSHsQc=a_WaWgsAvxzA@mail.gmail.com>
Date: Mon, 20 Jan 2020 11:36:03 +0000
Message-ID: <87y2u22wd8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: armbru@redhat.com, Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Josh Kunz <jkz@google.com> writes:

> On Tue, Jan 14, 2020 at 3:02 AM Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
>
>>
>> Josh Kunz <jkz@google.com> writes:
>>
>> <snip>
>> >
>> > Not tested:
>> >   * Build/logging with bsd-user. I do not have easy access to a BSD
>> > system.
>>
>> If you have the time we have vm-build-netbsd:
>>
>>   make vm-build-netbsd EXTRA_CONFIGURE_OPTS=3D"--disable-system"
>>
>> Which will create a NetBSD image for you and run the build through it.
>> Other images are available ;-)
>>
>
> This works, but it looks like it only runs the tests on BSD, even with
> `configure --enable-bsd-user` first. I don't see the bsd-user binaries
> being produced in the output of this command.

Ahh the default build target for the BSDs is "check" but as bsd-user
doesn't have any checks it doesn't end up building. You can force it
with

  make vm-build-netbsd EXTRA_CONFIGURE_OPTS=3D"--disable-system" BUILD_TARG=
ET=3D"all"

It would be worth plumbing in the tests/tcg tests at some point. I
suspect most of the user-mode tests are more POSIX than Linux.

--=20
Alex Benn=C3=A9e

