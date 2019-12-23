Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E5FC2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 12:41:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF64C20709
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 12:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="A53pRvUK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF64C20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijN25-0007oa-OV
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 07:41:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47547)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1ijN1O-0007Lh-Lu
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 07:41:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1ijN1L-00014s-Ac
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 07:41:12 -0500
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:60554)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
 id 1ijN1K-00011f-LF
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 07:41:11 -0500
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::162])
 by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id C34092E0906;
 Mon, 23 Dec 2019 15:41:07 +0300 (MSK)
Received: from localhost (localhost [::1])
 by mxbackcorp1j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 nNWtOQxBW9-f74qRprC; Mon, 23 Dec 2019 15:41:07 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1577104867; bh=Ysp/RGgxpcmPne2qC9vI5ElNlvXKn8AWqTzP70fspj0=;
 h=Subject:In-Reply-To:Cc:Date:References:To:From:Message-Id;
 b=A53pRvUKNSBlvhdpPEtqYa8t4XEhpw9w8mToauoAuNS9Q4itMS6cIk6Hq2TyafSoQ
 6eCoOtVPEX5CYQYV74CBYYMZL/V43voVI5WQMGotZ+O03MeLERxm1YEZrL2Fv5fY08
 pnniC+IQMzkpZOguetDaALS+wNoqc/IBFytn2x8I=
Authentication-Results: mxbackcorp1j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
X-Yandex-Sender-Uid: 1120000000071945
X-Yandex-Avir: 1
Received: from mxbackcorp1j.mail.yandex.net (localhost [::1])
 by mxbackcorp1j.mail.yandex.net with LMTP id Ok9msd15WZ-uXuXTj6g
 for <yury-kotov@yandex-team.ru>; Mon, 23 Dec 2019 15:40:57 +0300
Received: by iva4-9c479177d279.qloud-c.yandex.net with HTTP;
 Mon, 23 Dec 2019 15:40:57 +0300
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: Markus Armbruster <armbru@redhat.com>
In-Reply-To: <87a77ndlms.fsf@dusky.pond.sub.org>
References: <20191219160756.22389-1-yury-kotov@yandex-team.ru>
 <87a77ndlms.fsf@dusky.pond.sub.org>
Subject: Re: [PATCH 0/2] Speed up QMP stream reading
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Mon, 23 Dec 2019 15:41:07 +0300
Message-Id: <549941577104857@iva4-9c479177d279.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 95.108.205.193
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 "Denis V. Lunev" <den@openvz.org>,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi!

20.12.2019, 19:09, "Markus Armbruster" <armbru@redhat.com>:
> Yury Kotov <yury-kotov@yandex-team.ru> writes:
>
>>  Hi,
>>
>>  This series is continuation of another one:
>>  [PATCH] monitor: Fix slow reading
>>  https://lists.gnu.org/archive/html/qemu-devel/2019-11/msg03722.html
>>
>>  Which also tried to read more than one byte from a stream at a time,
>>  but had some problems with OOB and HMP:
>>  https://lists.gnu.org/archive/html/qemu-devel/2019-11/msg05018.html
>>
>>  This series is an attempt to fix problems described.
>
> Two problems: (1) breaks HMP migrate -d, and (2) need to think through
> how this affects reading of QMP input, in particular OOB.
>
> This series refrains from changing HMP, thus avoids (1). Good.
>
> What about (2)? I'm feeling denser than usual today... Can you explain
> real slow how QMP input works? PATCH 2 appears to splice in a ring
> buffer. Why is that needed?

Yes, the second patch introduced the input ring buffer to store remaining
bytes while monitor is suspended.

QMP input scheme:
1. monitor_qmp_can_read returns a number of bytes, which it's ready to receive.
   Currently it returns 0 (if suspended) or 1 otherwise.
   In my patch: monitor_qmp_can_read returns a free size of the introduced
   ring buffer.

2. monitor_qmp_read receives and handles input bytes
   Currently it just puts received bytes into a json lexer.
   If monitor is suspended this function won't be called and thus it won't
   process new command until monitor resume.
   In my patch: monitor_qmp_read stores input bytes into the buffer and then
   handles bytes in the buffer one by one while monitor is not suspended.
   So, it allows to be sure that the original logic is preserved and
   we won't handle new commands while monitor is suspended.

3. monitor_resume schedules monitor_accept_input which calls
   monitor_qmp_handle_inbuf which tries to handle remaining bytes
   in the buffer. monitor_accept_input is a BH scheduled by monitor_resume
   on monitor's aio context. It is needed to be sure, that we access
   the input buffer only in monitor's context.

Example:
1. QMP read 100 bytes
2. Handle some command in the first 60 bytes
3. For some reason, monitor becomes suspended after the first command
4. 40 bytes are remaining
5. After a while, something calls monitor_resume which handles
   the remaining bytes in the buffer (implicitly: resume -> sched bh -> buf)

Actually, QMP continues to receive data even though the monitor is suspended
until the buffer is full. But it doesn't process received data.

Regards,
Yury


