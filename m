Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742E1CA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 07:32:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ED1A2086D
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 07:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PQ9mg2vC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ED1A2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMSAu-0002mE-6B
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 03:32:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48224)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1iMS90-0001Ja-Ly
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 03:30:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1iMS8y-0001XQ-SY
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 03:30:22 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51822
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1iMS8y-0001X8-OU
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 03:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571643019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WLp9NAsFpmEpPQIAM9I1NFONPa+a1KHvoyydxIAtusc=;
 b=PQ9mg2vCegzfHfw592i36on2A+HEfgTGZ5m1ghtGtXfWd0oR4tbrfAIuLe8Wlt2pjCde76
 myFpYNdsKoRan66gqF9mSSDJSvWb5pV67nJ+6nMLH1H8XSR7yNa6oo08FMBNX3durvGIo1
 bN9WhyNQtAsFqdvJJH6gOTr0Jbk8Sok=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-IOr6EGvjMAKVq_IoHzVsxg-1; Mon, 21 Oct 2019 03:30:15 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D8D35E4;
 Mon, 21 Oct 2019 07:30:14 +0000 (UTC)
Received: from localhost (dhcp-192-217.str.redhat.com [10.33.192.217])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 555E260127;
 Mon, 21 Oct 2019 07:30:02 +0000 (UTC)
Date: Mon, 21 Oct 2019 09:30:00 +0200
From: Jens Freimann <jfreimann@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v4 0/11] add failover feature for assigned network devices
Message-ID: <20191021073000.7hrkf3hjxjgneibs@jenstp.localdomain>
References: <20191018202040.30349-1-jfreimann@redhat.com>
 <157149794605.24734.17200533702799976293@37313f22b938>
MIME-Version: 1.0
In-Reply-To: <157149794605.24734.17200533702799976293@37313f22b938>
User-Agent: NeoMutt/20180716-1376-5d6ed1
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: IOr6EGvjMAKVq_IoHzVsxg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: pkrempa@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 mst@redhat.com, aadam@redhat.com, dgilbert@redhat.com,
 alex.williamson@redhat.com, laine@redhat.com, ailan@redhat.com,
 parav@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Oct 19, 2019 at 08:12:27AM -0700, no-reply@patchew.org wrote:
>Patchew URL: https://patchew.org/QEMU/20191018202040.30349-1-jfreimann@red=
hat.com/
>
>
>
>Hi,
>
>This series failed the docker-quick@centos7 build test. Please find the te=
sting commands and
>their output below. If you have Docker installed, you can probably reprodu=
ce it
>locally.
>
>=3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
>#!/bin/bash
>make docker-image-centos7 V=3D1 NETWORK=3D1
>time make docker-test-quick@centos7 SHOW_ENV=3D1 J=3D14 NETWORK=3D1
>=3D=3D=3D TEST SCRIPT END =3D=3D=3D
>
>  CC      hw/core/or-irq.o
>  CC      hw/core/split-irq.o
>/tmp/qemu-test/src/hw/core/qdev.c: In function 'qdev_should_hide_device':
>/tmp/qemu-test/src/hw/core/qdev.c:235:5: error: 'rc' may be used uninitial=
ized in this function [-Werror=3Dmaybe-uninitialized]
>     return rc > 0;

hmpf, always run all tests especially after last minute changes on friday a=
fternoon. I'll fix this.

regards,
Jens=20


     ^
>cc1: all warnings being treated as errors
>make: *** [hw/core/qdev.o] Error 1
>make: *** Waiting for unfinished jobs....
>Traceback (most recent call last):
>  File "./tests/docker/docker.py", line 662, in <module>
>---
>    raise CalledProcessError(retcode, cmd)
>subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run', '-=
-label', 'com.qemu.instance.uuid=3D45df366e5eaf45f6ac429142fe2cc309', '-u',=
 '1001', '--security-opt', 'seccomp=3Dunconfined', '--rm', '-e', 'TARGET_LI=
ST=3D', '-e', 'EXTRA_CONFIGURE_OPTS=3D', '-e', 'V=3D', '-e', 'J=3D14', '-e'=
, 'DEBUG=3D', '-e', 'SHOW_ENV=3D1', '-e', 'CCACHE_DIR=3D/var/tmp/ccache', '=
-v', '/home/patchew/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v', '/v=
ar/tmp/patchew-tester-tmp-ozx9dk_0/src/docker-src.2019-10-19-11.10.07.7972:=
/var/tmp/qemu:z,ro', 'qemu:centos7', '/var/tmp/qemu/run', 'test-quick']' re=
turned non-zero exit status 2.
>filter=3D--filter=3Dlabel=3Dcom.qemu.instance.uuid=3D45df366e5eaf45f6ac429=
142fe2cc309
>make[1]: *** [docker-run] Error 1
>make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-ozx9dk_0/src'
>make: *** [docker-run-test-quick@centos7] Error 2
>
>real    2m19.619s
>user    0m8.409s
>
>
>The full log is available at
>http://patchew.org/logs/20191018202040.30349-1-jfreimann@redhat.com/testin=
g.docker-quick@centos7/?type=3Dmessage.
>---
>Email generated automatically by Patchew [https://patchew.org/].
>Please send your feedback to patchew-devel@redhat.com


