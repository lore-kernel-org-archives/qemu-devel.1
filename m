Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D071C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 09:15:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46FE520818
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 09:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fgLpL2Hb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46FE520818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUokA-0007pT-Do
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 04:15:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43373)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iUojV-0007Mx-NP
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 04:14:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iUojT-0002nd-3G
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 04:14:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35477
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iUojS-0002nA-Vh
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 04:14:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573636474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5kIY4xWlQMyMvS3kGdhwXWYuIDdn+NGlddjvqzBRPZU=;
 b=fgLpL2HbTm0iCdGULlzLtCb1lT7YZNsfBDT70PVGGVKH3F/xCgG5NZvUTM28GLLpy77/3L
 cIn6TzDS0Tq6GytfKxNLmdpDe2WJLhH4opP49srh9fWJBARlaXtBoh92HIPkFkjIrChsog
 HUcDEizA8KM+jQGJtNrITMO0qMhM8UQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-KafejNxeMW-7jy3yFFo5Rg-1; Wed, 13 Nov 2019 04:14:32 -0500
Received: by mail-wr1-f69.google.com with SMTP id e10so1208311wrt.16
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 01:14:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=NGrDeq3qn+8SRYJRwYHqbrjzYQ7lC1qwY11nnXD2DQU=;
 b=Ux+nykBSq91XwSWviFZq3nlUDbXJsPmaaId280sLMWmQi+9tIxrt5XfMiQMNUPwQg7
 em2D9uuo60xoUeZYbyJZFisE0FiZIQyAIerxWiUF3g00Vp6Ac+3XcGsMIgpsacG0wIRs
 +2lDnQEN+P03P3k8ADRE7OxX+LQrCTY0MxjEsADEM1diR5HK8U8NrdgZSWMd0iQKNeWQ
 zzNqTBTjwSSKfu7uYf7pC0splTs7+6z5LO25M5M77N5gJtyK9qwPtQ8ha3H+hFyyU7+M
 B8iGI8nbsS3q8klrJw6ruwsaxDJQILUNXTMmZiUrgfOk8ZA1TmoyyHLgUgR1i7MQ1dpq
 eDNw==
X-Gm-Message-State: APjAAAUyHT9NEbuXTCco0N4Ssjbo07UOW4cUbkbg5STdHZeX0EAmk3BJ
 h1y7FMLxH9ezQUBW2MTRk3rDlOhTECsIzwUrgEVGoXFU4Bm1pgi+M7SeKRtGF8K4TNOS1GYZTtk
 RzHmRvdUo0+KX1/0=
X-Received: by 2002:a1c:7f44:: with SMTP id a65mr1731247wmd.19.1573636471764; 
 Wed, 13 Nov 2019 01:14:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqw3vMDjjs3NhWUh2V7DBunG4q4Dj47J465bDXY9czF8Ynsgs2s9VNKQczLfQU850lYjWK5Y/Q==
X-Received: by 2002:a1c:7f44:: with SMTP id a65mr1731219wmd.19.1573636471424; 
 Wed, 13 Nov 2019 01:14:31 -0800 (PST)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id s9sm1515872wmj.22.2019.11.13.01.14.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2019 01:14:30 -0800 (PST)
References: <20191112113012.71136-1-slp@redhat.com>
 <157359898425.22470.3655469789274855006@37313f22b938>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v3 0/8] blockdev: avoid acquiring AioContext lock twice at
 do_drive_backup and do_blockdev_backup
In-reply-to: <157359898425.22470.3655469789274855006@37313f22b938>
Date: Wed, 13 Nov 2019 10:14:29 +0100
Message-ID: <87pnhwt9xm.fsf@redhat.com>
MIME-Version: 1.0
X-MC-Unique: KafejNxeMW-7jy3yFFo5Rg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
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
Cc: kwolf@redhat.com, armbru@redhat.com, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


no-reply@patchew.org writes:

> Patchew URL: https://patchew.org/QEMU/20191112113012.71136-1-slp@redhat.c=
om/
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
>   TEST    iotest-qcow2: 268
> Failures: 141

Hm... 141 didn't fail in my test machine. I'm going to have a look.

Sergio.

> Failed 1 of 108 iotests
> make: *** [check-tests/check-block.sh] Error 1
> Traceback (most recent call last):
>   File "./tests/docker/docker.py", line 662, in <module>
>     sys.exit(main())
> ---
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run', '=
--label', 'com.qemu.instance.uuid=3D5e0a4e7f97154a93b182d709969b9417', '-u'=
, '1003', '--security-opt', 'seccomp=3Dunconfined', '--rm', '-e', 'TARGET_L=
IST=3D', '-e', 'EXTRA_CONFIGURE_OPTS=3D', '-e', 'V=3D', '-e', 'J=3D14', '-e=
', 'DEBUG=3D', '-e', 'SHOW_ENV=3D1', '-e', 'CCACHE_DIR=3D/var/tmp/ccache', =
'-v', '/home/patchew2/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v', '=
/var/tmp/patchew-tester-tmp-6a9_8q0n/src/docker-src.2019-11-12-17.38.46.260=
27:/var/tmp/qemu:z,ro', 'qemu:centos7', '/var/tmp/qemu/run', 'test-quick']'=
 returned non-zero exit status 2.
> filter=3D--filter=3Dlabel=3Dcom.qemu.instance.uuid=3D5e0a4e7f97154a93b182=
d709969b9417
> make[1]: *** [docker-run] Error 1
> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-6a9_8q0n/src'
> make: *** [docker-run-test-quick@centos7] Error 2
>
> real    10m57.839s
> user    0m8.062s
>
>
> The full log is available at
> http://patchew.org/logs/20191112113012.71136-1-slp@redhat.com/testing.doc=
ker-quick@centos7/?type=3Dmessage.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com


