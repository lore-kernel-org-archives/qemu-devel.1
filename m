Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCEEC33CB1
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 14:23:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B95472469A
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 14:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L6oObKMM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B95472469A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isp0Y-0003PM-SV
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 09:23:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47126)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1isozx-0002zF-Hw
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 09:22:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1isozv-0000Lm-Fz
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 09:22:48 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52979
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1isozv-0000L2-C8
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 09:22:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579357366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7g1Bc9E2Tsk8bxO1iW9dj64GTkNL8PNSnI+qRsAZZ1k=;
 b=L6oObKMMgYRzBSMYNOahAiSvwT/JdPocVRTvC+hV5czybaBf93X3pLjN7yZFqvzkwQ2iZs
 XW+S876L5o1O+oIb4daoEjalJK1bKw580MnxNvAj0bOSwK4V9mz16bJqMFnyUHQt9x2EdJ
 aAgU1TmmdInTDRhQQIwhXv8H0fdhLls=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-6aX9F01OPAaEIVa9JMZY4A-1; Sat, 18 Jan 2020 09:22:41 -0500
Received: by mail-wr1-f72.google.com with SMTP id i9so11799205wru.1
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2020 06:22:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nhXWYkCCU8BlICNnT7qsr+rygBlLlK19jL72KO4oH98=;
 b=NNITAJCVnYtBBp1VAI5RQYqpQjzojZz+IqI1oztCD/cw8E/b0vn+GjqTDk7dgXAeF6
 RRs8O9IURK21TWaUf8vs301PrC1NhJZnEWi5tvqJudnnT0IFs/7B11TppiJsgy6IRndM
 1U9tvrCmlzu5GfgJVZOcC7t9jpRZVoyqe5huVrKtDFsm/heDA3/BUC9VpfVTvydJrb2H
 7GZ0TftF4MThcwUoWpsH1NC6KC50KoSkFrxT4YLWdVLoC5GUPuzOqN8oWG4SRMhokuEy
 M85E+Xn0UguOBdPEfYp4g0T0ClKovjVsGMlqZcqittfcadydf2eQuQyAhkz4hySXP8ND
 v3eQ==
X-Gm-Message-State: APjAAAV4cDZX6mTPw6Lp8Ar2H6dkx6yXK0piIWH/w0MwqjHyeGkEVB4f
 APdsBdGLgt5TNd1m/PawX2VbgB4R04oAR9FJYuONrBjnHmwlJNsmh2+It0u6T4ILvwt10aOljPt
 wf95Hxx5KfgDBKsM=
X-Received: by 2002:a5d:540f:: with SMTP id g15mr8378732wrv.86.1579357360344; 
 Sat, 18 Jan 2020 06:22:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqzwcVDxAJFr9G7IxykY/E93t4dBc8aZ9gHBoxtedAUy0D+by+vExGFFtVZI6Cjj1cHok5JoaA==
X-Received: by 2002:a5d:540f:: with SMTP id g15mr8378711wrv.86.1579357360107; 
 Sat, 18 Jan 2020 06:22:40 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id x17sm37857653wrt.74.2020.01.18.06.22.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Jan 2020 06:22:39 -0800 (PST)
Subject: Re: [PATCH v2 0/6] buildsys: Build faster (mostly tools and
 linux-user)
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
References: <20200118140619.26333-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4b4dfacf-47d2-65f2-c6cf-5e9d540bc239@redhat.com>
Date: Sat, 18 Jan 2020 15:22:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200118140619.26333-1-philmd@redhat.com>
Content-Language: en-US
X-MC-Unique: 6aX9F01OPAaEIVa9JMZY4A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/18/20 3:06 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> In some configuration (linux-user, tools) we can ignore building
> various objects (and the libfdt).
>=20
> Tested with all the combinations of --[enable|disable]-tools,
> --[enable|disable]-user and --[enable|disable]-system using the
> following commands (suggested by Laurent Vivier in v1):
>=20
>    $ mkdir build
>    $ cd build
>    $ for user in enable disable; do \
>          for tools in enable disable; do \
>              for system in enable disable; do \
>                  rm -fr build-$user-$system-$tools && \
>                  mkdir build-$user-$system-$tools && \
>                      (cd build-$user-$system-$tools && \
>                       ../../configure \
>                                       --${user}-user \
>                                       --${system}-system \
>                                       --${tools}-tools \
>                                       --disable-docs \
>                      ); \
>              done; \
>          done; \
>      done
>=20
> Then building each of the 8 subdirectories on x86_64 and aarch64
> hosts, running 'make check', and only on x86_64:
> 'make run-tcg-tests-x86_64-linux-user'.
>=20
> All CI green:
> https://gitlab.com/philmd/qemu/pipelines/110420332
> https://travis-ci.org/philmd/qemu/builds/638781159
> https://app.shippable.com/github/philmd/qemu/runs/587/summary/console
>=20
> Since v1:
> - no code change, improved commit description, added review tags
> - added 2 new patches touching hw/core/ (remove reset.o from linux-user)
>=20
> $ git backport-diff -u v1
> Key:
> [----] : patches are identical
> [####] : number of functional differences between upstream/downstream pat=
ch
> [down] : patch is downstream-only
> The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively
>=20
> 001/6:[----] [--] 'configure: Do not build libfdt if not required'
> 002/6:[----] [--] 'Makefile: Clarify all the codebase requires qom/ objec=
ts'
> 003/6:[----] [--] 'Makefile: Restrict system emulation and tools objects'
> 004/6:[----] [--] 'Makefile: Remove unhelpful comment'
> 005/6:[down] 'hw/core: Restrict reset handlers API to system-mode'
> 006/6:[down] 'hw/core/Makefile: Group generic objects versus system-mode =
objects'
>=20
> Supersedes: <20200109153939.27173-1-philmd@redhat.com>

   ^ testing latest patchew feature, v2 has different subject name
     than v1, but patchew successfully linked them :)

See "Diff against v1" in v2:
https://patchew.org/QEMU/20200118140619.26333-1-philmd@redhat.com/

https://patchew.org/QEMU/20200109153939.27173-1-philmd@redhat.com/diff/2020=
0118140619.26333-1-philmd@redhat.com/

Thanks Kevin & Paolo for this feature :)


