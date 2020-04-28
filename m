Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1ABC83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 18:12:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCA9F206A1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 18:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e7qIrTvc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCA9F206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTUil-0003O2-Py
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 14:12:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48602)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsuvorov@redhat.com>) id 1jTUhW-0002Al-LG
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 14:11:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <jsuvorov@redhat.com>) id 1jTUhV-0005z6-0a
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 14:11:21 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51173
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsuvorov@redhat.com>)
 id 1jTUhU-0005yY-F2
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 14:11:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588097478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t36IJX7Y87U5sq8z29bfgchMRQmNzy9N4kwsu2Xg57I=;
 b=e7qIrTvcA/v2W7UHv+mJje/7RNKs/HkzREGyQAbcruGu2L95S79TMgHWqhzzBxVgRVTopb
 qbwj4rQa33lGbZWDp0eJbNSrmRdM/Hk4vHPgKYRNQfson2oXnQfU5ZOVwg4TGM6yUgJn2A
 rJCIi1v93+XFM1nb7jHK+lruzWEU5wA=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-Jr-D2iMcOcmC1gei3BLGrA-1; Tue, 28 Apr 2020 14:11:11 -0400
X-MC-Unique: Jr-D2iMcOcmC1gei3BLGrA-1
Received: by mail-lj1-f197.google.com with SMTP id z1so3767935ljk.9
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 11:11:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=t36IJX7Y87U5sq8z29bfgchMRQmNzy9N4kwsu2Xg57I=;
 b=fsNE2gDOM9JmYo8GWWWvpPgmxYUT2izfhh8gd/KNdPW91xrJNoN6cnUjdQN6Pcm2Ka
 WIw016LepF2NUL2HXdZExCmBH9VA8ktF6C1VregAuNLyWDt5N9VRLFMQTZ+Orzd4jKoC
 53Y5y5oLQMvboOOUg4vow4M1tteLr4K39ebfvd2pkAyecFoogJYSDeU3hCCu2ZixzUFv
 8tC63unVw1Cdb9cHAdfhdcE95P/Y2wfG/cBRZ9ZXfPgZ1/u9OINioAFKF05Gc0CSmury
 JGKYpYRXKOMfIXkvmXuzrYm1bflfByqmNP8XpQh+Vzg8DS3x6pkQCx94ltzvBSZnmU+n
 KAqQ==
X-Gm-Message-State: AGi0PuYO4I56nPWF1G6Q6TAER6ugneKvRLrnDpG4XooBt6fIT8YppMRz
 JigtxjOLsdZkFGGNbbsQNvZM6YjF0iwI8HpSONu1d9338iWnAHrWZfEzd6GA+eq/GP4+gMwS+lU
 S7OV8eNqAYm754rpPrlUlEKkA65ot6lg=
X-Received: by 2002:a05:651c:1131:: with SMTP id
 e17mr19521636ljo.79.1588097470169; 
 Tue, 28 Apr 2020 11:11:10 -0700 (PDT)
X-Google-Smtp-Source: APiQypK5t4m9zawMLyqBE8FUSGtezmeVgCRalWhGlWGLr6mo4RZ0JNoqnOwNf/NNKIkw8ArucihLonXtraWWwB9W7N4=
X-Received: by 2002:a05:651c:1131:: with SMTP id
 e17mr19521620ljo.79.1588097469908; 
 Tue, 28 Apr 2020 11:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200427182440.92433-1-jusual@redhat.com>
 <158801823561.15667.6932995854888702598@39012742ff91>
In-Reply-To: <158801823561.15667.6932995854888702598@39012742ff91>
From: Julia Suvorova <jusual@redhat.com>
Date: Tue, 28 Apr 2020 20:10:58 +0200
Message-ID: <CAMDeoFXHNch7YoVXR4T1EFtxopsvDZ_YY7cc=r9=cX2FY-pPmQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] hw/pci/pcie: Forbid hot-plug if it's disabled on
 the slot
To: QEMU Developers <qemu-devel@nongnu.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jsuvorov@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 04:11:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Igor Mammedov <imammedo@redhat.com>, Daniel Berrange <berrange@redhat.com>,
 Michael Tsirkin <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Apr 27, 2020 at 10:11 PM <no-reply@patchew.org> wrote:
>
> Patchew URL: https://patchew.org/QEMU/20200427182440.92433-1-jusual@redha=
t.com/
>
>
>
> Hi,
>
> This series failed the docker-quick@centos7 build test. Please find the t=
esting commands and
> their output below. If you have Docker installed, you can probably reprod=
uce it
> locally.
>
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> make docker-image-centos7 V=3D1 NETWORK=3D1
> time make docker-test-quick@centos7 SHOW_ENV=3D1 J=3D14 NETWORK=3D1
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>
>   TEST    check-unit: tests/test-qht
> socket_accept failed: Resource temporarily unavailable
> **
> ERROR:/tmp/qemu-test/src/tests/qtest/libqtest.c:301:qtest_init_without_qm=
p_handshake: assertion failed: (s->fd >=3D 0 && s->qmp_fd >=3D 0)
> /tmp/qemu-test/src/tests/qtest/libqtest.c:166: kill_qemu() tried to termi=
nate QEMU process but encountered exit status 1 (expected 0)
> ERROR - Bail out! ERROR:/tmp/qemu-test/src/tests/qtest/libqtest.c:301:qte=
st_init_without_qmp_handshake: assertion failed: (s->fd >=3D 0 && s->qmp_fd=
 >=3D 0)
> make: *** [check-qtest-aarch64] Error 1
> make: *** Waiting for unfinished jobs....
>   TEST    iotest-qcow2: 022
>   TEST    check-unit: tests/test-qht-par
> ---
>   TEST    iotest-qcow2: 039
> socket_accept failed: Resource temporarily unavailable
> **
> ERROR:/tmp/qemu-test/src/tests/qtest/libqtest.c:301:qtest_init_without_qm=
p_handshake: assertion failed: (s->fd >=3D 0 && s->qmp_fd >=3D 0)
> /tmp/qemu-test/src/tests/qtest/libqtest.c:166: kill_qemu() tried to termi=
nate QEMU process but encountered exit status 1 (expected 0)
> ERROR - Bail out! ERROR:/tmp/qemu-test/src/tests/qtest/libqtest.c:301:qte=
st_init_without_qmp_handshake: assertion failed: (s->fd >=3D 0 && s->qmp_fd=
 >=3D 0)
> make: *** [check-qtest-x86_64] Error 1
>   TEST    iotest-qcow2: 040
>   TEST    iotest-qcow2: 041
>   TEST    iotest-qcow2: 042
> ---
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run', '=
--label', 'com.qemu.instance.uuid=3Dc66f60264261441e87b973b137ab56d7', '-u'=
, '1003', '--security-opt', 'seccomp=3Dunconfined', '--rm', '-e', 'TARGET_L=
IST=3D', '-e', 'EXTRA_CONFIGURE_OPTS=3D', '-e', 'V=3D', '-e', 'J=3D14', '-e=
', 'DEBUG=3D', '-e', 'SHOW_ENV=3D1', '-e', 'CCACHE_DIR=3D/var/tmp/ccache', =
'-v', '/home/patchew2/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v', '=
/var/tmp/patchew-tester-tmp-ksshgsdx/src/docker-src.2020-04-27-15.54.25.261=
90:/var/tmp/qemu:z,ro', 'qemu:centos7', '/var/tmp/qemu/run', 'test-quick']'=
 returned non-zero exit status 2.
> filter=3D--filter=3Dlabel=3Dcom.qemu.instance.uuid=3Dc66f60264261441e87b9=
73b137ab56d7
> make[1]: *** [docker-run] Error 1
> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-ksshgsdx/src'
> make: *** [docker-run-test-quick@centos7] Error 2
>
> real    16m11.272s
> user    0m9.880s
>
>
> The full log is available at
> http://patchew.org/logs/20200427182440.92433-1-jusual@redhat.com/testing.=
docker-quick@centos7/?type=3Dmessage.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com

Looks like false positive.


