Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B306C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 15:46:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71A0C23401
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 15:46:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71A0C23401
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0pIQ-0005IT-HK
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 11:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54163)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1i0pGf-0003u5-DB
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 11:44:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1i0pGe-0005rc-3M
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 11:44:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41844)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1i0pGd-0005rC-Tt; Thu, 22 Aug 2019 11:44:52 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0D3DE2A09A7;
 Thu, 22 Aug 2019 15:44:51 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6964360CDA;
 Thu, 22 Aug 2019 15:44:50 +0000 (UTC)
Date: Thu, 22 Aug 2019 17:44:47 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <20190822174447.3be81c81.cohuck@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Thu, 22 Aug 2019 15:44:51 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] 'make check-unit' breakage on s390x host
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
Cc: qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I just noticed a breakage with 'make check-unit' when running on an
s390x host (on my laptop, it runs fine; haven't tried other
architectures). This happens with current master, but I managed to
track the original breakage down to

commit ff3dc8fefe953fd3650279e064bf63b212c5699a
Author: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Date:   Wed Mar 13 17:36:18 2019 +0000

    filemon: ensure watch IDs are unique to QFileMonitor scope
   =20
    The watch IDs are mistakenly only unique within the scope of the
    directory being monitored. This is not useful for clients which are
    monitoring multiple directories. They require watch IDs to be unique
    globally within the QFileMonitor scope.
   =20
    Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
    Tested-by: Bandan Das <bsd@redhat.com>
    Reviewed-by: Bandan Das <bsd@redhat.com>
    Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

On that commit, make check-unit fails with

  TEST    check-unit: tests/test-util-filemonitor
Expected watch id 4 but got 0
**
ERROR:/root/git/qemu/tests/test-util-filemonitor.c:651:test_file_monitor_ev=
ents: assertion failed: (err =3D=3D 0)
ERROR - Bail out! ERROR:/root/git/qemu/tests/test-util-filemonitor.c:651:te=
st_file_monitor_events: assertion failed: (err =3D=3D 0)
make: *** [/root/git/qemu/tests/Makefile.include:908: check-unit] Error 1

(I usually run as root on that box and as a normal user on my laptop;
not sure if that makes a difference.)

On master, the failure looks a bit different, but it's probably the
same issue:

  TEST    check-unit: tests/test-util-filemonitor
Expected watch id 200000000 but got 100000000
**
ERROR:/root/git/qemu/tests/test-util-filemonitor.c:665:test_file_monitor_ev=
ents: assertion failed: (err =3D=3D 0)
ERROR - Bail out! ERROR:/root/git/qemu/tests/test-util-filemonitor.c:665:te=
st_file_monitor_events: assertion failed: (err =3D=3D 0)
make: *** [/root/git/qemu/tests/Makefile.include:904: check-unit] Error 1

Fedora 29, QEMU built with '/root/git/qemu/build/../configure'
'--target-list=3Ds390x-softmmu x86_64-softmmu' '--enable-kvm'
'--enable-linux-aio' '--enable-virtfs' '--enable-trace-backends=3Dsimple'
'--python=3D/usr/bin/python3'

I can try to collect extra info if you tell me what would be helpful.

