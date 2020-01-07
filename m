Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E14CC33C9E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 17:44:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFF1424672
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 17:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g5bwJEsb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFF1424672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iosuR-0005Vp-Nh
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 12:44:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41314)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dinechin@redhat.com>) id 1iostI-0004CW-GV
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 12:43:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dinechin@redhat.com>) id 1iostG-0004kU-2e
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 12:43:39 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55329
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dinechin@redhat.com>) id 1iostF-0004j9-Tq
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 12:43:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578419016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qQ49FJHANItdcew1FzP9oGgJRD/gx8RQjsrFr1uNCpU=;
 b=g5bwJEsb+P6gGA95SweP8sJ5tWRkiH0Qq9ca4WYT7OPeVgMDSgiH2jGOwm48JOJ3JUhDLp
 pmis/Cd9WUu1hlXfSSwjJqKr84ww9Xn13sR41ULvvV1DYe/PFu1t8y2b4LCyYJqU7DSZzD
 ykZQXftPfeBK9tA8gD9oOZ2Py6ETNy0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-legcxuitNGaZUJ2EZSNojw-1; Tue, 07 Jan 2020 12:43:33 -0500
Received: by mail-wm1-f70.google.com with SMTP id 18so113567wmp.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 09:43:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=2Vu2yY8W04pu7S8ygsK+K132+sMkdfPunBKD2HLDtkM=;
 b=BJpX/E3YTrGhQDDozcv57p46OsZOLsu4TOujnZTvqxrnKJwnVYuJqBmDGdBJR/b6nZ
 sijWKQHd70QKdFV+MvwzLUJVgXv9g6JOm1ruRnteL7lNMxizFFwmAh8mCZQ0sAl4ZHUf
 ympQGtSWgOExz0shwBQyy1k53W2mCW823N5IjLlwVYB7/gevEFSKFdE6HkmD3SnpyD7t
 M9Ttczj6PJMCwjCg8dHQem1Ps9wgF/6LPS/BvR78mSSMXU25aL1iwISJOSfyVHHRZ6+o
 /u3TD4qjMmAnGfcGU5rt28Zq3tqNxBr14qAq38s05vEdIu9X2MraXjPq81oxPb3YMW/w
 eISQ==
X-Gm-Message-State: APjAAAVD9bo60Yo7sNVndI5TbaYtyP59vrYBBa/2rqzr/HE8u8TAusX1
 tN3++p9ex+OlWR5uDD567hS7i9cEc5uXlZOYhNPwQPX0ZxJM9r9AKt+dBvEaL5J/DKgLf4DCQiZ
 nqqouNVuy/bYFrvY=
X-Received: by 2002:adf:f5cf:: with SMTP id k15mr257794wrp.182.1578419012512; 
 Tue, 07 Jan 2020 09:43:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqyyIViWis2adK/d5qrIW0zPmHkIe0jXvsQUu6dlRX1A9277x7C7AiZ6gJVlQH17RN/OJg/XkQ==
X-Received: by 2002:adf:f5cf:: with SMTP id k15mr257764wrp.182.1578419012233; 
 Tue, 07 Jan 2020 09:43:32 -0800 (PST)
Received: from ?IPv6:2a01:e0a:466:71c0:8d4b:4003:dcb:4c70?
 ([2a01:e0a:466:71c0:8d4b:4003:dcb:4c70])
 by smtp.gmail.com with ESMTPSA id v8sm729157wrw.2.2020.01.07.09.43.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 07 Jan 2020 09:43:31 -0800 (PST)
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: Priority of -accel (was: [PATCH] tests/qemu-iotests: Update tests
 to recent desugarized -accel option)
From: Christophe de Dinechin <dinechin@redhat.com>
In-Reply-To: <360fa010-ba80-b02b-3a35-19c2b48a462d@redhat.com>
Date: Tue, 7 Jan 2020 18:43:30 +0100
Message-Id: <5FB9F11E-77DC-4FD6-B780-AB508DD42B42@redhat.com>
References: <20200106130951.29873-1-philmd@redhat.com>
 <c493e693-13a7-7dc4-eb2d-5dbc7b3053f1@redhat.com>
 <12334054-4ae7-e580-9727-2d322bfa2bda@redhat.com>
 <1A5859EA-4403-4921-B527-DFD07C59C702@redhat.com>
 <360fa010-ba80-b02b-3a35-19c2b48a462d@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
X-MC-Unique: legcxuitNGaZUJ2EZSNojw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain;
	charset=utf-8
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel Berrange <berrange@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 7 Jan 2020, at 15:37, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
> On 07/01/20 14:55, Christophe de Dinechin wrote:
>> So what about ranking the accelerators, so that all combinaisons
>> -accel=3Dkvm:tcg, -accel=3Dtcg:kvm, -accel kvm -accel tcg, etc would
>=20
> (I assume you mean "-machine accel=3Dkvm:tcg" and "-machine accel=3Dtcg:k=
vm"
> for the first two.  This is the "older" way which has now become sugar
> for "-accel kvm -accel tcg").

Yes.

>=20
>> all pickup kvm if available, and tcg as a fallback? Implementation-wise,
>> it would simply mean ranking the accelerators and updating the accelerat=
or
>> only if it=E2=80=99s available and better.
>=20
> This is an interesting idea.  I like this better than "-accel best",
> because "-accel best" has the problem that you can't add suboptions to
> it (the suboptions for the various accelerators are disjoint).
>=20
> It would break backwards compatibility for "-machine accel=3Dtcg:kvm",
> which so far meant "use TCG if compiled in, otherwise use KVM".  This is
> not something I would have a problem with... except that "tcg:kvm" is
> the default if no -accel option is provided!

What is the rationale for picking tcg over kvm?

My guess is that when this was selected, KVM was the new fancy unstable
thing and this was deemed the safe choice. My other guess is that this was
around 1907 or so :-) My third guess is that you will probably provide me
with a much better rationale ;-)

Without knowing a rationale, my mind goes wild. I=E2=80=99m trying to imagi=
ne
who runs qemu directly, without the -accel option. For some reason, I
picture a guy named Joe typing something like "qemu win95.qcow2=E2=80=9D,
somewhere in a dark and dusty basement with old neon lamps flashing
in the background and a few rats gnawing at damp CAT5 cables.
Joe is intent on playing Day of the Tentacle one last time before it=E2=80=
=99s too
late. Joe's only complaint so far has been that the game was a bit slow,
and that=E2=80=99s why he=E2=80=99s nervous and sweats profusely. <insert t=
ense music here>
Will Joe have the time to complete this one last task? <zoom to an old
clock in a corner, ominous tic-toc sound>

Now, it turns out that Joe just updated his system, and suddenly, to his
amazement, Day of the Tentacle is fluid and fast. It=E2=80=99s a miracle!
<insert joyful music here, with a few butterflies flying around for effect>
What is Joe going to do that might be an issue for us? Maybe Joe will
immediately run to Twitter, eyes full of thankful tears, full of a burning
desire to tell the entire world that the qemu folks went totally overboard
with this release and super-optimized it like crazy?

(Consider the above as my way to tell that I=E2=80=99m a bit puzzled as to =
why
selecting kvm would be a problem. I even intentionally inserted win95,
hoping that this might be one of the scenarios where kvm might be more
trouble than anything, but I don=E2=80=99t know that for sure, having not t=
ested it)


