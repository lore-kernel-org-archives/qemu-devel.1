Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FA0C33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 12:29:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90CB7214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 12:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hobq+KHG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90CB7214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irho6-0005L8-Pe
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 07:29:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47734)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1irhil-0006uT-VR
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 07:24:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1irhii-0002Tk-AB
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 07:24:27 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50124)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1irhii-0002TT-6u
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 07:24:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579091063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SbsA0p+qnwYaNJhMZMOG+NxrrhSQvPocTAZy99uBr64=;
 b=hobq+KHG6x7spdwJxL8IYag+hAGYsT+VeJ/Bog70QI1AzzB2+wLz651GPQrqSUNF12jl2A
 2rsSCzKJl0dzALsSrWJAUOfHF2N5B3yjphM4PC7QAhA9HS9MXyUE2HhZtMkPlV8ji0f/3y
 ePMbCZCBrIoQ/UDN+PPKei0Xb/f4UvI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-oYWQkEt4NxCyVDWTeFMzWQ-1; Wed, 15 Jan 2020 07:24:18 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9AFDC107B00A;
 Wed, 15 Jan 2020 12:24:17 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-87.ams2.redhat.com [10.36.117.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3FCB119757;
 Wed, 15 Jan 2020 12:24:14 +0000 (UTC)
Date: Wed, 15 Jan 2020 13:24:12 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 0/4] qmp: Optionally run handlers in coroutines
Message-ID: <20200115122412.GA5505@linux.fritz.box>
References: <20200114182735.5553-1-kwolf@redhat.com>
 <157903449903.1076.10596408768402573833@37313f22b938>
MIME-Version: 1.0
In-Reply-To: <157903449903.1076.10596408768402573833@37313f22b938>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: oYWQkEt4NxCyVDWTeFMzWQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: stefanha@redhat.com, marcandre.lureau@gmail.com, armbru@redhat.com,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 14.01.2020 um 21:41 hat no-reply@patchew.org geschrieben:
> Patchew URL: https://patchew.org/QEMU/20200114182735.5553-1-kwolf@redhat.=
com/
>=20
> Hi,
>=20
> This series failed the docker-quick@centos7 build test. Please find the t=
esting commands and
> their output below. If you have Docker installed, you can probably reprod=
uce it
> locally.
>=20
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> make docker-image-centos7 V=3D1 NETWORK=3D1
> time make docker-test-quick@centos7 SHOW_ENV=3D1 J=3D14 NETWORK=3D1
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>=20
> aio_co_schedule: Co-routine was already scheduled in 'aio_co_schedule'
> Broken pipe
> /tmp/qemu-test/src/tests/qtest/libqtest.c:149: kill_qemu() detected QEMU =
death from signal 6 (Aborted) (core dumped)
> ERROR - too few tests run (expected 4, got 1)
> make: *** [check-qtest-aarch64] Error 1
> make: *** Waiting for unfinished jobs....

This was a real bug in the series, v3 incoming.

Kevin


