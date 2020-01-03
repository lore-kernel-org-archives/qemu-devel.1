Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C447FC2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 19:38:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B1E620866
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 19:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SQvBM5Ze"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B1E620866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inSlt-0006yX-KO
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 14:38:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50851)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1inSkd-00067B-Sr
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 14:36:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1inSka-0004Y2-IO
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 14:36:50 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29010
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1inSka-0004Rp-4T
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 14:36:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578080206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cShQfQXu90uxLCw1PPex7aGCURKPjSBACR+xtDvYlZk=;
 b=SQvBM5Zeta+YrN6QC4vOE6H0DYTpiU0CLss/AG4oda+lntShh/dtKeHNyPJLSoZi1cczIr
 sFrZuTotWOnOqF8tlf8mWZkpsD1azIp6DdwzK5DqIhogxrBw98/gXGt/PmKIQbVyfJIkPh
 hexU/yuAvzJwust3deIwKtvvFkGLbFY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-ZN1ODQy5MVWUGy08-L4MTA-1; Fri, 03 Jan 2020 14:36:43 -0500
Received: by mail-qk1-f200.google.com with SMTP id l7so11466616qke.8
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2020 11:36:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=X/X1Qmanw8CICMN3evGP3+ifZr/jGld29lY2tUdSQVc=;
 b=qSoubsN4AWsw4Pw2Qy01520EqP0I44uJSm4rSPCXyDF0+un/WV3aB17grUr4ugM6Dy
 ZVXHg8X2E77/F80+1n/bqTL1MvA13CQzUyTcVZe7cGOKtx+oGMcmwUqjgGVNaqtxVjvC
 rcC6pS2CIC6PY0jbJ1Xned89SDQPB5zpyw9Qm07g0Ch3Hn+BofqZswKHIW048ZpxfrgK
 mWc/Tc6mG6sYG5nHSM2+otn4j05tSOvC1GGzwe+dC6/elYG1M5bUMVS2esnzpO719AaE
 p77xVwnL6C6iu+mW718+HySMSldxuxio5b2tGOt2HsP5+klEAmKpxi9t90G+BP2IgM+5
 IuHw==
X-Gm-Message-State: APjAAAVluYOemBegoNfxYjhuB6EdNJctpFBZmjuIR6P/rQbT7hDF4btb
 87LjbFCzEcF8FxFTi1pXPxmf+ijwzeNCMqAsQQKNm9ezm6jTJsoaOjeAFprlyUpy7LumjOIBjGV
 WBHKgG+I+TnzGu84=
X-Received: by 2002:a05:620a:1116:: with SMTP id
 o22mr74074372qkk.190.1578080203069; 
 Fri, 03 Jan 2020 11:36:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqxuKpK5MKco0LteK2ZDBqytRPfrzgW+JiwQ+amJbOPqfyk0BR3t1L9A+8dhT1twQQgOrFtXoQ==
X-Received: by 2002:a05:620a:1116:: with SMTP id
 o22mr74074349qkk.190.1578080202772; 
 Fri, 03 Jan 2020 11:36:42 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
 by smtp.gmail.com with ESMTPSA id k73sm16931927qke.36.2020.01.03.11.36.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jan 2020 11:36:41 -0800 (PST)
Date: Fri, 3 Jan 2020 14:36:40 -0500
From: Peter Xu <peterx@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 0/2] Speed up QMP stream reading
Message-ID: <20200103193640.GF157597@xz-x1>
References: <20191219160756.22389-1-yury-kotov@yandex-team.ru>
 <87a77ndlms.fsf@dusky.pond.sub.org>
 <549941577104857@iva4-9c479177d279.qloud-c.yandex.net>
 <20200103110731.GC3804@work-vm> <20200103190627.GE157597@xz-x1>
MIME-Version: 1.0
In-Reply-To: <20200103190627.GE157597@xz-x1>
X-MC-Unique: ZN1ODQy5MVWUGy08-L4MTA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Yury Kotov <yury-kotov@yandex-team.ru>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 "Denis V. Lunev" <den@openvz.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jan 03, 2020 at 02:06:27PM -0500, Peter Xu wrote:
> On Fri, Jan 03, 2020 at 11:07:31AM +0000, Dr. David Alan Gilbert wrote:
> > * Yury Kotov (yury-kotov@yandex-team.ru) wrote:
> > > Hi!
> > >=20
> > > 20.12.2019, 19:09, "Markus Armbruster" <armbru@redhat.com>:
> > > > Yury Kotov <yury-kotov@yandex-team.ru> writes:
> > > >
> > > >>  Hi,
> > > >>
> > > >>  This series is continuation of another one:
> > > >>  [PATCH] monitor: Fix slow reading
> > > >>  https://lists.gnu.org/archive/html/qemu-devel/2019-11/msg03722.ht=
ml
> > > >>
> > > >>  Which also tried to read more than one byte from a stream at a ti=
me,
> > > >>  but had some problems with OOB and HMP:
> > > >>  https://lists.gnu.org/archive/html/qemu-devel/2019-11/msg05018.ht=
ml
> > > >>
> > > >>  This series is an attempt to fix problems described.
> > > >
> > > > Two problems: (1) breaks HMP migrate -d, and (2) need to think thro=
ugh
> > > > how this affects reading of QMP input, in particular OOB.
> > > >
> > > > This series refrains from changing HMP, thus avoids (1). Good.
> > > >
> > > > What about (2)? I'm feeling denser than usual today... Can you expl=
ain
> > > > real slow how QMP input works? PATCH 2 appears to splice in a ring
> > > > buffer. Why is that needed?
> > >=20
> > > Yes, the second patch introduced the input ring buffer to store remai=
ning
> > > bytes while monitor is suspended.
> > >=20
> > > QMP input scheme:
> > > 1. monitor_qmp_can_read returns a number of bytes, which it's ready t=
o receive.
> > >    Currently it returns 0 (if suspended) or 1 otherwise.
> > >    In my patch: monitor_qmp_can_read returns a free size of the intro=
duced
> > >    ring buffer.
> > >=20
> > > 2. monitor_qmp_read receives and handles input bytes
> > >    Currently it just puts received bytes into a json lexer.
> > >    If monitor is suspended this function won't be called and thus it =
won't
> > >    process new command until monitor resume.
> > >    In my patch: monitor_qmp_read stores input bytes into the buffer a=
nd then
> > >    handles bytes in the buffer one by one while monitor is not suspen=
ded.
> > >    So, it allows to be sure that the original logic is preserved and
> > >    we won't handle new commands while monitor is suspended.
> > >=20
> > > 3. monitor_resume schedules monitor_accept_input which calls
> > >    monitor_qmp_handle_inbuf which tries to handle remaining bytes
> > >    in the buffer. monitor_accept_input is a BH scheduled by monitor_r=
esume
> > >    on monitor's aio context. It is needed to be sure, that we access
> > >    the input buffer only in monitor's context.
> > >=20
> > > Example:
> > > 1. QMP read 100 bytes
> > > 2. Handle some command in the first 60 bytes
> > > 3. For some reason, monitor becomes suspended after the first command
> > > 4. 40 bytes are remaining
> > > 5. After a while, something calls monitor_resume which handles
> > >    the remaining bytes in the buffer (implicitly: resume -> sched bh =
-> buf)
> > >=20
> > > Actually, QMP continues to receive data even though the monitor is su=
spended
> > > until the buffer is full. But it doesn't process received data.
> >=20
> > I *think* that's OK for OOB; my reading is that prior to this set of
> > patches, if you filled the queue (even with oob enabled) you could
> > suspend the monitor and block - but you're just not supposed to be
> > throwing commands quickly at an OOB monitor; but I'm cc'ing in Peter.
>=20
> I read this first:
>=20
> https://lists.nongnu.org/archive/html/qemu-devel/2017-05/msg00472.html
>=20
> Which makes sense to me.  From OOB POV, IMHO it's fine, because as
> Markus pointed out that we only call emit() after the json
> parser/streamer, so IIUC it should not be affected on how much we read
> from the chardev frontend each time.
>=20
> But from my understanding what Markus suggested has nothing to do with
> the currently introduced ring buffer.  Also, from what I read above I
> still didn't find anywhere that explained on why we need a ring buffer
> (or I must have missed it).

Oh I think I see the point now...  So what matters is not the general
OOB messages, but actually when OOB is disabled or when OOB queue is
full.  In other words, json_message_parser_feed() can call
monitor_suspend() itself, so we must make sure
json_message_parser_feed() is still called with size=3D=3D1 always,
otherwise we can't suspend monitors properly.

I see that patch 2 did this right on checking against suspend_cnt
before each call of json_message_parser_feed(size=3D=3D1), so it seems
good..  And yes in that case the ring buffer is needed to achieve this.

--=20
Peter Xu


