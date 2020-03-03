Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2498C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 14:11:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C6CF2073D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 14:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dHn4FU2R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C6CF2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j98GB-00070d-Ha
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 09:10:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60961)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1j98FW-0006P6-Dn
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 09:10:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1j98FU-0001C7-Em
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 09:10:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45761
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1j98FU-0001Bt-BH
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 09:10:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583244615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ugzEnBDcYi9jHVH6gC2NUEb5qAspRuDw/2xArEhrAqg=;
 b=dHn4FU2RDpqpGCKhP1q+HxaOBFy8Za15HL4LgmQ2g6n34fKKjLMbtfUTDrgMAQ1Hdfrd/D
 ZQpnjhRb/ywgswY1ohCrxXulKk2uYjAy64wKyt+yCgrhht9rCpI2THsSmm7Sow1G51MmsL
 8aebX8vYHzfRawMiatzXXUBr9vo/aXk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-wZPsLeRSNRKVz254Mpjlcw-1; Tue, 03 Mar 2020 09:10:12 -0500
X-MC-Unique: wZPsLeRSNRKVz254Mpjlcw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81A60107ACCC;
 Tue,  3 Mar 2020 14:10:10 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 57EDD5DA60;
 Tue,  3 Mar 2020 14:10:10 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com
 (zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 1B02C84468;
 Tue,  3 Mar 2020 14:10:10 +0000 (UTC)
Date: Tue, 3 Mar 2020 09:10:09 -0500 (EST)
From: Cleber Rosa <crosa@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Message-ID: <743818728.9995808.1583244609883.JavaMail.zimbra@redhat.com>
In-Reply-To: <877e017d4c.fsf@linaro.org>
References: <20200302180937.24148-1-alex.bennee@linaro.org>
 <c6f8e8b0-e391-67a7-4fcb-b88464285f65@redhat.com>
 <810018352.9991598.1583243092838.JavaMail.zimbra@redhat.com>
 <877e017d4c.fsf@linaro.org>
Subject: Re: [PATCH] tests/acceptance: move @skipUnless decoration to test
 itself
MIME-Version: 1.0
X-Originating-IP: [10.10.123.15, 10.4.195.10]
Thread-Topic: tests/acceptance: move @skipUnless decoration to test itself
Thread-Index: j3+4uRsKtIrKrHYi+o6pBQXuhXrRkg==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



----- Original Message -----
> From: "Alex Benn=C3=A9e" <alex.bennee@linaro.org>
> To: "Cleber Rosa" <crosa@redhat.com>
> Cc: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>, qemu-devel@nongnu.=
org, "Aurelien Jarno" <aurelien@aurel32.net>,
> f4bug@amsat.org, "Aleksandar Markovic" <amarkovic@wavecomp.com>
> Sent: Tuesday, March 3, 2020 8:59:47 AM
> Subject: Re: [PATCH] tests/acceptance: move @skipUnless decoration to tes=
t itself
>=20
>=20
> Cleber Rosa <crosa@redhat.com> writes:
>=20
> > ----- Original Message -----
> >> From: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
> >> To: "Alex Benn=C3=A9e" <alex.bennee@linaro.org>, qemu-devel@nongnu.org
> >> Cc: "Aurelien Jarno" <aurelien@aurel32.net>, f4bug@amsat.org, "Aleksan=
dar
> >> Markovic" <amarkovic@wavecomp.com>
> >> Sent: Monday, March 2, 2020 1:14:31 PM
> >> Subject: Re: [PATCH] tests/acceptance: move @skipUnless decoration to =
test
> >> itself
> >>=20
> >> On 3/2/20 7:09 PM, Alex Benn=C3=A9e wrote:
> >> > It appears ignore the decoration if just applied to the class.
> >>=20
> >> Odd I remember testing this, this might be a feature supported by a
> >> newer Avocado version than the one available on Travis-CI.
> >>=20
> >> >=20
> >> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >> > ---
> >> >   tests/acceptance/machine_mips_malta.py | 4 ++--
> >> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >> >=20
> >> > diff --git a/tests/acceptance/machine_mips_malta.py
> >> > b/tests/acceptance/machine_mips_malta.py
> >> > index 92b4f28a112..b8fac2a44d5 100644
> >> > --- a/tests/acceptance/machine_mips_malta.py
> >> > +++ b/tests/acceptance/machine_mips_malta.py
> >> > @@ -30,14 +30,14 @@ except ImportError:
> >> >       CV2_AVAILABLE =3D False
> >> >  =20
> >> >  =20
> >> > -@skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
> >> > -@skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
> >> >   class MaltaMachineFramebuffer(Test):
> >> >  =20
> >> >       timeout =3D 30
> >> >  =20
> >> >       KERNEL_COMMON_COMMAND_LINE =3D 'printk.time=3D0 '
> >> >  =20
> >> > +    @skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
> >> > +    @skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
> >> >       def do_test_i6400_framebuffer_logo(self, cpu_cores_count):
> >> >           """
> >> >           Boot Linux kernel and check Tux logo is displayed on the
> >> >           framebuffer.
> >> >=20
> >>=20
> >> Unfortunately you have to also add it to the 7/8cores tests.
> >>=20
> >>=20
> >>=20
> >
> > This is true of Avocado < 76.0, but on 76.0 you can decorate the
> > class too:
> >
> > https://avocado-framework.readthedocs.io/en/76.0/releases/76_0.html#use=
rs-test-writers
> >
> > Maybe replace this patch and bump Avocado's version?
>=20
> Where is this defined in the source?
>=20

It's defined at tests/requirements.txt.

- Cleber.

> >
> > - Cleber.
>=20
>=20
> --
> Alex Benn=C3=A9e
>=20
>=20


