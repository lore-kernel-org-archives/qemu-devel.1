Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82494C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 10:58:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E940208D4
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 10:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iuyBdZXo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E940208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX1Cb-0000uY-7K
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 05:57:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43489)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iX1AR-0007Io-Ve
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 05:55:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iX1AP-0004sk-02
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 05:55:30 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60094
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iX1AO-0004sI-PT
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 05:55:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574160928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4VJVSPVpJl+IFXugMvRA1Is6o9upcxL1JsLlF6PzJos=;
 b=iuyBdZXoz1OhfgVGxBGkUdCA5q2jDRfQcOoddhE2H66LTp0ZTkP4HMYlcvnS2zZwsQoITq
 zOyEdzcsEpFy0ad2HyXjdm9ilV0ULxd17jZI69tCFxIOUwmg0oFEYfStnXM5TUWryYyEDL
 pBKZnM+vdPFC9l3i5AcUGGMbFQOPn2M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-otmttMhRNZyZlO_JMsvixg-1; Tue, 19 Nov 2019 05:55:25 -0500
X-MC-Unique: otmttMhRNZyZlO_JMsvixg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 763E6800A02;
 Tue, 19 Nov 2019 10:55:24 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ECCB460BE0;
 Tue, 19 Nov 2019 10:55:22 +0000 (UTC)
References: <20191112113012.71136-1-slp@redhat.com>
 <157359898425.22470.3655469789274855006@37313f22b938>
 <87pnhwt9xm.fsf@redhat.com> <87h837ucxa.fsf@redhat.com>
 <34ffd31f-66c4-59f5-ead1-b2df449ecee6@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v3 0/8] blockdev: avoid acquiring AioContext lock twice at
 do_drive_backup and do_blockdev_backup
In-reply-to: <34ffd31f-66c4-59f5-ead1-b2df449ecee6@redhat.com>
Date: Tue, 19 Nov 2019 11:54:43 +0100
Message-ID: <87d0docf0s.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Max Reitz <mreitz@redhat.com> writes:

> On 13.11.19 14:24, Sergio Lopez wrote:
>>=20
>> Sergio Lopez <slp@redhat.com> writes:
>>=20
>>> no-reply@patchew.org writes:
>>>
>>>> Patchew URL: https://patchew.org/QEMU/20191112113012.71136-1-slp@redha=
t.com/
>>>>
>>>>
>>>>
>>>> Hi,
>>>>
>>>> This series failed the docker-quick@centos7 build test. Please find th=
e testing commands and
>>>> their output below. If you have Docker installed, you can probably rep=
roduce it
>>>> locally.
>>>>
>>>> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
>>>> #!/bin/bash
>>>> make docker-image-centos7 V=3D1 NETWORK=3D1
>>>> time make docker-test-quick@centos7 SHOW_ENV=3D1 J=3D14 NETWORK=3D1
>>>> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>>>>
>>>>   TEST    iotest-qcow2: 268
>>>> Failures: 141
>>>
>>> Hm... 141 didn't fail in my test machine. I'm going to have a look.
>>=20
>> So here's the output:
>>=20
>> --- /root/qemu/tests/qemu-iotests/141.out=092019-11-12 04:43:27.65155758=
7 -0500
>> +++ /root/qemu/build/tests/qemu-iotests/141.out.bad=092019-11-13 08:12:0=
6.575967337 -0500
>> @@ -10,6 +10,8 @@
>>  Formatting 'TEST_DIR/o.IMGFMT', fmt=3DIMGFMT size=3D1048576 backing_fil=
e=3DTEST_DIR/t.IMGFMT backing_fmt=3DIMGFMT
>>  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "eve=
nt": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job0"}}
>>  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "eve=
nt": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
>> +{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "eve=
nt": "JOB_STATUS_CHANGE", "data": {"status": "paused", "id": "job0"}}
>> +{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "eve=
nt": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
>>  {"error": {"class": "GenericError", "desc": "Node 'drv0' is busy: node =
is used as backing hd of 'NODE_NAME'"}}
>>  {"return": {}}
>>  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "eve=
nt": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "job0"}}
>>=20
>> Those extra lines, the "paused" and "running", are a result of the job
>> being done in a transaction, within a drained section.
>>=20
>> We can update 141.out, but now I'm wondering, was it safe creating the
>> job at do_drive_backup() outside of a drained section, as
>> qmp_drive_backup was doing?
>
> I think it is.  Someone needs to drain the source node before attaching
> the job filter (which intercepts writes), and bdrv_backup_top_append()
> does precisely this.
>
> If the source node is in an I/O thread, you could argue that the drain
> starts later than when the user has invoked the backup command, and so
> some writes might slip through.  That=E2=80=99s correct.  But at the same=
 time,
> it=E2=80=99s impossible to drain it the instant the command is received. =
 So
> some writes might always slip through (and the drain will not stop them
> either, it will just let them happen).
>
> Therefore, I think it=E2=80=99s fine the way it is.
>
>> Do you think there may be any potential drawbacks as a result of always
>> doing it now inside a drained section?
>
> Well, one drawback is clearly visible.  The job goes to paused for no
> reason.

This is something that already happens when requesting the drive-backup
through a transaction:

{"execute":"transaction","arguments":{"actions":[{"type":"drive-backup","da=
ta":{"device":"drv0","target":"o.qcow2","sync":"full","format":"qcow2"}}]}}

I don't think it makes sense to have two different behaviors for the
same action. So we either accept the additional pause+resume iteration
for qmp_drive_backup, or we remove the drained section from the
transaction based one.

What do you think?

Cheers,
Sergio.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl3TyfQACgkQ9GknjS8M
AjVjcRAAs8rDo9Yvfxmsb6PXTnpAOI2jDFXKppNw0D9A9ZMNxzzwaV4M7b0x66YJ
az1RJiHUww87oq/dcN1bZn15W7d8sfH4ORr1/thgZzxy65DVEq5oW9wEoCz7RMnC
/483E3hfQX3x2bq8CKmiCLEeL+A+2MdmzgSpQCs8B5ONtlDLM/e4PNpE5lL+OetC
WHq5KclzfcJpgNXeyKQHcjmYIoDPoxJ7VVLL0iXF6dqZQSXWN81mcC2L6lqsu60f
oROqkrBUwunFur6YhAHeEflNmSkfuQpLcbDs6tpnX5SfLkz63mMUOQYLDxHefpXS
IGvSBfkrRc7TjX6OWeXoeZC9QSu2FeRoJyyYFOePx08E83INoD+B+iGlvolR0kSC
QcMuDU/WzQT4exPVOTCw2g+EL6rD+gxAMKNLR93zXmjqLLj96qdIsH8UWNR5aiMY
B2okK8ZN2r2Q0xJ8xnv2J9DH5BJ8LZXz3nQBf/Tclx0Ft/qlz57sxlbe3RVDAw96
i85ihNNYZ95+4LFiJRoQ0AFmPRNp3SJMLI5I2CovvRISuQDgeJjz7veTX3O4bRhd
lL/c8r96RNprRucPsyHhxKZ+UjS2SpuC9tsIF9d/AMkjbqRZ1CYWkkYoff+xQL4n
TEl/esyT76MWPA3lxYl3rqyTMRw4IXQlORg08ttiss7POs9JFU0=
=FSz8
-----END PGP SIGNATURE-----
--=-=-=--


