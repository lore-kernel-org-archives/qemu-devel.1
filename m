Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB01C2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 11:08:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62E6D206DB
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 11:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SjVKyYqX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62E6D206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inKoc-0002tN-G4
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 06:08:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41451)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1inKnz-0002Tj-BC
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 06:07:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1inKnx-0007A5-Fi
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 06:07:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40876
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1inKnx-00075N-8r
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 06:07:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578049664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HaBHUlmO+DWXK6aoiC4wvOmxfEkD/AmjlbJ6VB4Hm98=;
 b=SjVKyYqXoe7WXxrLYCJqpQmntuLWJ7URiHNf93d6sWjvu/soZcLku25JiPqq9vg5mGphwh
 1nN3yA7yG3ua+/6y5aM+jR9QEEukMKoewzncYAemcpbLxioi0cBcEO8h0uufNRKKUKccko
 Y+DcGjl7XZuJyg2brJ9YMhsdpw2eV3E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-CCn88dkiN1uevMOjr-4wzg-1; Fri, 03 Jan 2020 06:07:43 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5CC4107ACC4;
 Fri,  3 Jan 2020 11:07:41 +0000 (UTC)
Received: from work-vm (ovpn-117-78.ams2.redhat.com [10.36.117.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 899675D9C9;
 Fri,  3 Jan 2020 11:07:34 +0000 (UTC)
Date: Fri, 3 Jan 2020 11:07:31 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Yury Kotov <yury-kotov@yandex-team.ru>, peterx@redhat.com
Subject: Re: [PATCH 0/2] Speed up QMP stream reading
Message-ID: <20200103110731.GC3804@work-vm>
References: <20191219160756.22389-1-yury-kotov@yandex-team.ru>
 <87a77ndlms.fsf@dusky.pond.sub.org>
 <549941577104857@iva4-9c479177d279.qloud-c.yandex.net>
MIME-Version: 1.0
In-Reply-To: <549941577104857@iva4-9c479177d279.qloud-c.yandex.net>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: CCn88dkiN1uevMOjr-4wzg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 "Denis V. Lunev" <den@openvz.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Yury Kotov (yury-kotov@yandex-team.ru) wrote:
> Hi!
>=20
> 20.12.2019, 19:09, "Markus Armbruster" <armbru@redhat.com>:
> > Yury Kotov <yury-kotov@yandex-team.ru> writes:
> >
> >>  Hi,
> >>
> >>  This series is continuation of another one:
> >>  [PATCH] monitor: Fix slow reading
> >>  https://lists.gnu.org/archive/html/qemu-devel/2019-11/msg03722.html
> >>
> >>  Which also tried to read more than one byte from a stream at a time,
> >>  but had some problems with OOB and HMP:
> >>  https://lists.gnu.org/archive/html/qemu-devel/2019-11/msg05018.html
> >>
> >>  This series is an attempt to fix problems described.
> >
> > Two problems: (1) breaks HMP migrate -d, and (2) need to think through
> > how this affects reading of QMP input, in particular OOB.
> >
> > This series refrains from changing HMP, thus avoids (1). Good.
> >
> > What about (2)? I'm feeling denser than usual today... Can you explain
> > real slow how QMP input works? PATCH 2 appears to splice in a ring
> > buffer. Why is that needed?
>=20
> Yes, the second patch introduced the input ring buffer to store remaining
> bytes while monitor is suspended.
>=20
> QMP input scheme:
> 1. monitor_qmp_can_read returns a number of bytes, which it's ready to re=
ceive.
>    Currently it returns 0 (if suspended) or 1 otherwise.
>    In my patch: monitor_qmp_can_read returns a free size of the introduce=
d
>    ring buffer.
>=20
> 2. monitor_qmp_read receives and handles input bytes
>    Currently it just puts received bytes into a json lexer.
>    If monitor is suspended this function won't be called and thus it won'=
t
>    process new command until monitor resume.
>    In my patch: monitor_qmp_read stores input bytes into the buffer and t=
hen
>    handles bytes in the buffer one by one while monitor is not suspended.
>    So, it allows to be sure that the original logic is preserved and
>    we won't handle new commands while monitor is suspended.
>=20
> 3. monitor_resume schedules monitor_accept_input which calls
>    monitor_qmp_handle_inbuf which tries to handle remaining bytes
>    in the buffer. monitor_accept_input is a BH scheduled by monitor_resum=
e
>    on monitor's aio context. It is needed to be sure, that we access
>    the input buffer only in monitor's context.
>=20
> Example:
> 1. QMP read 100 bytes
> 2. Handle some command in the first 60 bytes
> 3. For some reason, monitor becomes suspended after the first command
> 4. 40 bytes are remaining
> 5. After a while, something calls monitor_resume which handles
>    the remaining bytes in the buffer (implicitly: resume -> sched bh -> b=
uf)
>=20
> Actually, QMP continues to receive data even though the monitor is suspen=
ded
> until the buffer is full. But it doesn't process received data.

I *think* that's OK for OOB; my reading is that prior to this set of
patches, if you filled the queue (even with oob enabled) you could
suspend the monitor and block - but you're just not supposed to be
throwing commands quickly at an OOB monitor; but I'm cc'ing in Peter.

Dave

> Regards,
> Yury
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


