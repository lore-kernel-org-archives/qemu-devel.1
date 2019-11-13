Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F3DC17442
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 13:28:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68CDF21783
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 13:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hxmE6KhR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68CDF21783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44663 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUsgx-0008Vl-HO
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 08:28:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43638)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iUsdW-0004oE-HZ
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 08:24:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iUsdU-0004Ux-Tb
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 08:24:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35760
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iUsdU-0004UL-Q6
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 08:24:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573651479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1p5ClNoOQDcjkba7vYceRH17UtgvTORbKhF14U1vLzM=;
 b=hxmE6KhREBcdlcy5rINgvs99XihJwSrseVlpr7MRo+H6/T8ehyRYwiJ7oDIKnvZOUyx1pk
 dWFSOIoCoeGI0015XRy2cxkKXSy5R7vgR8QUseZ7tqaq+eF04nMVsccq5oxkmvBqpkQKfF
 biH2f0afxkf6hAN7A10VrUWO6/0szpA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-TGwMv3CvMzumQnQPh_OiQg-1; Wed, 13 Nov 2019 08:24:36 -0500
Received: by mail-wm1-f71.google.com with SMTP id d140so2752923wmd.1
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 05:24:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=ORt9y/nnFurnyknDQFHy/Zkeb3AQJfblOfAtFac/DDc=;
 b=XVzyi0BLqWWio3yJ1jHBvGEUA8XNugf5yJldtUC5USRkN69thjXQ0YXXl3TtD8p3Qt
 wH5Xn3lfaaWDq5CAajboSjVVWXCk086mQoKE6zMVz1KffdhdJRipulkXwp++qx7laRxR
 SE413hQH29utYCZAKhJaASMnTytYS77MViqFCDJobA5eS2qHSUrW18WUZe9OZ6ydNBXZ
 A9Nc+OKLroqDRf9O7zxNBcRGldmntLlJhbOHeKhDb8Hci16bGop+7GOiypLyOXhRg3pR
 XiVzgIOFTwcXx3QXc5HqWCzg57qCMkbGMP2HdRWhUoW22M76XX/ePT5U3ensuLiMI3x5
 0ynQ==
X-Gm-Message-State: APjAAAXS2ci5quJeo+9X9ufRWeO8wfqdEU+ndxnaLXi6Y1KXxhKGGgcW
 V1CEI8bQ3hn8k1J+RPS73EyKq9/zi6TWPCl5D54zuDti8om0gNCNBD6LWu9ffzR6Lq/OW/bj6zg
 6yzHyxQRENIp9tfg=
X-Received: by 2002:a1c:49d5:: with SMTP id w204mr2907361wma.111.1573651475423; 
 Wed, 13 Nov 2019 05:24:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqwvBS2OM1E8bfoTD6CUCOywCDMOa1Pi66N6heK1fC62pUu+NLsvNd3So9lpozrE8LXR2ftmww==
X-Received: by 2002:a1c:49d5:: with SMTP id w204mr2907335wma.111.1573651475094; 
 Wed, 13 Nov 2019 05:24:35 -0800 (PST)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id 5sm2051625wmk.48.2019.11.13.05.24.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2019 05:24:34 -0800 (PST)
References: <20191112113012.71136-1-slp@redhat.com>
 <157359898425.22470.3655469789274855006@37313f22b938>
 <87pnhwt9xm.fsf@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v3 0/8] blockdev: avoid acquiring AioContext lock twice at
 do_drive_backup and do_blockdev_backup
In-reply-to: <87pnhwt9xm.fsf@redhat.com>
Date: Wed, 13 Nov 2019 14:24:33 +0100
Message-ID: <87h837ucxa.fsf@redhat.com>
MIME-Version: 1.0
X-MC-Unique: TGwMv3CvMzumQnQPh_OiQg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: kwolf@redhat.com, armbru@redhat.com, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Sergio Lopez <slp@redhat.com> writes:

> no-reply@patchew.org writes:
>
>> Patchew URL: https://patchew.org/QEMU/20191112113012.71136-1-slp@redhat.=
com/
>>
>>
>>
>> Hi,
>>
>> This series failed the docker-quick@centos7 build test. Please find the =
testing commands and
>> their output below. If you have Docker installed, you can probably repro=
duce it
>> locally.
>>
>> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
>> #!/bin/bash
>> make docker-image-centos7 V=3D1 NETWORK=3D1
>> time make docker-test-quick@centos7 SHOW_ENV=3D1 J=3D14 NETWORK=3D1
>> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>>
>>   TEST    iotest-qcow2: 268
>> Failures: 141
>
> Hm... 141 didn't fail in my test machine. I'm going to have a look.

So here's the output:

--- /root/qemu/tests/qemu-iotests/141.out=092019-11-12 04:43:27.651557587 -=
0500
+++ /root/qemu/build/tests/qemu-iotests/141.out.bad=092019-11-13 08:12:06.5=
75967337 -0500
@@ -10,6 +10,8 @@
 Formatting 'TEST_DIR/o.IMGFMT', fmt=3DIMGFMT size=3D1048576 backing_file=
=3DTEST_DIR/t.IMGFMT backing_fmt=3DIMGFMT
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "paused", "id": "job0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
 {"error": {"class": "GenericError", "desc": "Node 'drv0' is busy: node is =
used as backing hd of 'NODE_NAME'"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "job0"}}

Those extra lines, the "paused" and "running", are a result of the job
being done in a transaction, within a drained section.

We can update 141.out, but now I'm wondering, was it safe creating the
job at do_drive_backup() outside of a drained section, as
qmp_drive_backup was doing?

Do you think there may be any potential drawbacks as a result of always
doing it now inside a drained section?

Thanks,
Sergio.

> Sergio.
>
>> Failed 1 of 108 iotests
>> make: *** [check-tests/check-block.sh] Error 1
>> Traceback (most recent call last):
>>   File "./tests/docker/docker.py", line 662, in <module>
>>     sys.exit(main())
>> ---
>>     raise CalledProcessError(retcode, cmd)
>> subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run', =
'--label', 'com.qemu.instance.uuid=3D5e0a4e7f97154a93b182d709969b9417', '-u=
', '1003', '--security-opt', 'seccomp=3Dunconfined', '--rm', '-e', 'TARGET_=
LIST=3D', '-e', 'EXTRA_CONFIGURE_OPTS=3D', '-e', 'V=3D', '-e', 'J=3D14', '-=
e', 'DEBUG=3D', '-e', 'SHOW_ENV=3D1', '-e', 'CCACHE_DIR=3D/var/tmp/ccache',=
 '-v', '/home/patchew2/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v', =
'/var/tmp/patchew-tester-tmp-6a9_8q0n/src/docker-src.2019-11-12-17.38.46.26=
027:/var/tmp/qemu:z,ro', 'qemu:centos7', '/var/tmp/qemu/run', 'test-quick']=
' returned non-zero exit status 2.
>> filter=3D--filter=3Dlabel=3Dcom.qemu.instance.uuid=3D5e0a4e7f97154a93b18=
2d709969b9417
>> make[1]: *** [docker-run] Error 1
>> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-6a9_8q0n/src'
>> make: *** [docker-run-test-quick@centos7] Error 2
>>
>> real    10m57.839s
>> user    0m8.062s
>>
>>
>> The full log is available at
>> http://patchew.org/logs/20191112113012.71136-1-slp@redhat.com/testing.do=
cker-quick@centos7/?type=3Dmessage.
>> ---
>> Email generated automatically by Patchew [https://patchew.org/].
>> Please send your feedback to patchew-devel@redhat.com


