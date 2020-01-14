Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D677BC33CB2
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 18:59:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3C5B24673
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 18:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FLAjnTjj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3C5B24673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irRPp-00089N-NU
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 13:59:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59359)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1irROw-0007K7-3c
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 13:58:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1irROu-0008MD-V9
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 13:58:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50306
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1irROu-0008Lu-R9
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 13:58:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579028332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bbLZzMEOiIaJcPJZKJ3Lp79IU+qvLfacyczVVfeV9cY=;
 b=FLAjnTjjVi1W5GSGXRoACOif6+wW9d1xUvup+SMPxGgutkaX8T9zV0UZGgzTFLpAW2aW3m
 ljQdN43XzOV1y6gMJnS0q6E/76poEypdibqyFV18XjdNaRzsUj8kaDCIFf1N7trPjLVUzm
 euzfVY/gnGr4ie8FG7wVPf+3zM+HwuA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-SvqXwZuoM8mp9OW-U7F4Tg-1; Tue, 14 Jan 2020 13:58:51 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F41D08DFF43;
 Tue, 14 Jan 2020 18:58:49 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-253.ams2.redhat.com [10.36.116.253])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B7BC5C1D6;
 Tue, 14 Jan 2020 18:58:46 +0000 (UTC)
Date: Tue, 14 Jan 2020 19:58:44 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v2 0/4] qmp: Optionally run handlers in coroutines
Message-ID: <20200114185844.GD8159@linux.fritz.box>
References: <20200114182735.5553-1-kwolf@redhat.com>
 <20200114184508.GT4071034@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200114184508.GT4071034@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: SvqXwZuoM8mp9OW-U7F4Tg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: stefanha@redhat.com, marcandre.lureau@gmail.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 14.01.2020 um 19:45 hat Daniel P. Berrang=E9 geschrieben:
> On Tue, Jan 14, 2020 at 07:27:31PM +0100, Kevin Wolf wrote:
> > Some QMP command handlers can block the main loop for a relatively long
> > time, for example because they perform some I/O. This is quite nasty.
> > Allowing such handlers to run in a coroutine where they can yield (and
> > therefore release the BQL) while waiting for an event such as I/O
> > completion solves the problem.
>=20
> Am I right that with this approach, there's no functional difference
> to QMP from a mgmt app POV ? ie this is purely focused on avoiding
> stalls in the main event loop which impact the guest OS and other
> parts of QEMU ?
>=20
> IOW, the response to the QMP command being executed will get sent
> back to the mgmt app as normal when the command completes, and the
> QMP monitor still serializes execution of commands ?

Yes, the QMP dispatcher still processes one request after another. The
only visible effect should be that the guest and other background tasks
aren't blocked.

> > This series adds the infrastructure to allow this and switches
> > block_resize to run in a coroutine as a first example.
> >=20
> > This is an alternative solution to Marc-Andr=E9's "monitor: add
> > asynchronous command type" series.
>=20
> Where as this is an actual functional improvement to QMP from
> the mgmt app POV in allowing background commands & thus
> concurrent execution ?
>=20
> If this is correct, then the two proposals are somewhat
> complementary=20

Marc-Andr=E9's first proposal (maybe two years ago) actually added real
asynchronous commands to the protocol. But his latest versions gave up
on this and made commands only internally asynchronous, with pretty much
the same effect as this series.

If we ever do want to extend the protocol to have async commands on the
protocol level, this can still be done on top. There is no fundamental
problem that would prevent just launching a coroutine for each parallel
request. In fact, this series is probably the first step that you would
make anyway to even have something that can be parallelised.

Kevin


