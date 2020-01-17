Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22986C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 16:05:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2794214AF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 16:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MIR71iFL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2794214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isU7Y-00037H-0C
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 11:05:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41993)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1isU6G-0002am-Ag
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 11:03:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1isU6B-0006ij-V1
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 11:03:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36073
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1isU6B-0006iH-RR
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 11:03:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579277030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kJefJFXf899kKvjQoIuPAjXbr5yzhbcpYJDdQ73P8D4=;
 b=MIR71iFLjtXqGsnr2zp8JB9zzD65YcSVdPVdQEmCpVZakeuW1hjFDB4Pm1sL7N9iHa1bAC
 Jk+VVXaU/RnRwCztlHk6FgUDF990puRm0gn2Ic3nmoJ853MLGKEEI9gfvEveqxShcnvzo/
 aZxERvQ/hfGyGypkH2jO2/h0lFQZefQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-q1MUAVsPNh6WtPjDQ9g8DA-1; Fri, 17 Jan 2020 11:03:47 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DAECF18FE89D;
 Fri, 17 Jan 2020 16:03:45 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CD81A675AF;
 Fri, 17 Jan 2020 16:03:42 +0000 (UTC)
Date: Fri, 17 Jan 2020 17:03:40 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH v2 00/86] refactor main RAM allocation to use hostmem
 backend
Message-ID: <20200117170340.7e91ff8c@redhat.com>
In-Reply-To: <b81ad35f-73d0-a333-d0fe-758e64242ca2@redhat.com>
References: <157912207219.8290.12574147223674937177@37313f22b938>
 <b81ad35f-73d0-a333-d0fe-758e64242ca2@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: q1MUAVsPNh6WtPjDQ9g8DA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: no-reply@patchew.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 Jan 2020 16:43:07 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> On 1/15/20 10:01 PM, no-reply@patchew.org wrote:
> > Patchew URL: https://patchew.org/QEMU/1579100861-73692-1-git-send-email=
-imammedo@redhat.com/
> >=20
> >=20
> >=20
> > Hi,
> >=20
> > This series failed the docker-quick@centos7 build test. Please find the=
 testing commands and
> > their output below. If you have Docker installed, you can probably repr=
oduce it
> > locally.
> >=20
> > =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> > #!/bin/bash
> > make docker-image-centos7 V=3D1 NETWORK=3D1
> > time make docker-test-quick@centos7 SHOW_ENV=3D1 J=3D14 NETWORK=3D1

it doesn't work on my host, since it tries to use /tmp for building an imag=
e
and fails with no space.
is there any way to point it to some other place?

> > =3D=3D=3D TEST SCRIPT END =3D=3D=3D
> >=20
> >    TEST    iotest-qcow2: 217
> > socket_accept failed: Resource temporarily unavailable
> > **
> > ERROR:/tmp/qemu-test/src/tests/qtest/libqtest.c:272:qtest_init_without_=
qmp_handshake: assertion failed: (s->fd >=3D 0 && s->qmp_fd >=3D 0)
> > /tmp/qemu-test/src/tests/qtest/libqtest.c:140: kill_qemu() tried to ter=
minate QEMU process but encountered exit status 1 (expected 0)
> > ERROR - Bail out! ERROR:/tmp/qemu-test/src/tests/qtest/libqtest.c:272:q=
test_init_without_qmp_handshake: assertion failed: (s->fd >=3D 0 && s->qmp_=
fd >=3D 0)
> > make: *** [check-qtest-x86_64] Error 1 =20
>=20
> Is this something we should care about?


#217 passes on my host, albeit it takes time to complete

>=20
> > make: *** Waiting for unfinished jobs....
> >    TEST    check-qtest-aarch64: tests/qtest/test-hmp
> >    TEST    iotest-qcow2: 220
> > ---
> >      raise CalledProcessError(retcode, cmd)
> > subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run',=
 '--label', 'com.qemu.instance.uuid=3D755fcbfd171f40b1b16d6aac34e7c09b', '-=
u', '1003', '--security-opt', 'seccomp=3Dunconfined', '--rm', '-e', 'TARGET=
_LIST=3D', '-e', 'EXTRA_CONFIGURE_OPTS=3D', '-e', 'V=3D', '-e', 'J=3D14', '=
-e', 'DEBUG=3D', '-e', 'SHOW_ENV=3D1', '-e', 'CCACHE_DIR=3D/var/tmp/ccache'=
, '-v', '/home/patchew2/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v',=
 '/var/tmp/patchew-tester-tmp-qd5wtatm/src/docker-src.2020-01-15-15.50.14.2=
8652:/var/tmp/qemu:z,ro', 'qemu:centos7', '/var/tmp/qemu/run', 'test-quick'=
]' returned non-zero exit status 2.
> > filter=3D--filter=3Dlabel=3Dcom.qemu.instance.uuid=3D755fcbfd171f40b1b1=
6d6aac34e7c09b
> > make[1]: *** [docker-run] Error 1
> > make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-qd5wtatm/src'
> > make: *** [docker-run-test-quick@centos7] Error 2
> >=20
> > real    11m0.219s
> > user    0m8.267s
> >=20
> >=20
> > The full log is available at
> > http://patchew.org/logs/1579100861-73692-1-git-send-email-imammedo@redh=
at.com/testing.docker-quick@centos7/?type=3Dmessage.
> > ---
> > Email generated automatically by Patchew [https://patchew.org/].
> > Please send your feedback to patchew-devel@redhat.com
> >  =20
>=20
>=20


