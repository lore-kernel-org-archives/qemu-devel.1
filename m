Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF56AC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:51:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7566420659
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LkESELty"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7566420659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idFtA-0006qA-Aj
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 10:51:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54705)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1idEtA-0000Oi-9j
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:47:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1idEt6-0003ky-TY
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:47:22 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44131
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1idEt6-0003g2-DQ
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:47:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575643633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S7puR9cKXQmceadF8aHitsChjwoUelc3PuZxZ7OsHwg=;
 b=LkESELtyd20bLdAWIKyWAaczTpoPFYQmqPoGon0XwwvxBgcldRsbXAi3Q45OiApygVk0cI
 yyJgzKPdMz6D7Yn4hXoHv+t71yzczPDPSwQnL6D1yU1mVJkfncIbNV7g3Mv6lj56+VCjbp
 yZa7yBNg28Coo71XV2pcD/mX4zRXwFU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-MMCP8qYbNLKcimh9pfhsYw-1; Fri, 06 Dec 2019 07:46:24 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D68F800EB9;
 Fri,  6 Dec 2019 12:46:22 +0000 (UTC)
Received: from dhcp-17-72.bos.redhat.com (dhcp-17-72.bos.redhat.com
 [10.18.17.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A38567E52;
 Fri,  6 Dec 2019 12:46:14 +0000 (UTC)
Date: Fri, 6 Dec 2019 07:46:13 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v6 0/9] Clock framework API
Message-ID: <20191206124613.GA3902@dhcp-17-72.bos.redhat.com>
References: <20190904125531.27545-1-damien.hedde@greensocs.com>
 <CAFEAcA98rt6nRDSrwk8XRbaBT67LZXvF=XEV13dtJBp4fPUscw@mail.gmail.com>
 <be199ad6-1b79-f77d-afad-faeb042151ed@greensocs.com>
 <febdb64d-9d02-66ad-84d2-dc795879e48b@redhat.com>
 <a0cea550-d6c7-0193-b4e6-24ed879be61d@greensocs.com>
 <279a0fd5-1ea5-b3c7-27bb-b1d22db5e359@redhat.com>
 <20191205102151.GB2824@work-vm>
 <f3aa4881-dd41-ce71-0f5a-8d36bf5c3828@redhat.com>
 <20191205105613.GE2824@work-vm>
 <138ef325-dc9a-2ca5-9044-c67ffdabb968@redhat.com>
MIME-Version: 1.0
In-Reply-To: <138ef325-dc9a-2ca5-9044-c67ffdabb968@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: MMCP8qYbNLKcimh9pfhsYw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Mark Burton <mark.burton@greensocs.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Oksana Voshchana <ovoshcha@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 05, 2019 at 12:01:56PM +0100, Philippe Mathieu-Daud=E9 wrote:
>=20
> Understood, thanks for clearing this out!
>=20
> Side note, we don't do cross-arch migration testing, but we talked about
> having a 'different QEMU version' migration test. When we get a such test
> setup, it shouldn't be too difficult to evolve to some cross-arch migrati=
on
> test.
>

+Oksana,

Avocado-VT has had this as a core concept as far as I can remember, and
it's exposed even as a command line argument:

   avocado run --help
   ...
   [--vt-qemu-dst-bin VT_DST_QEMU_BIN]
   ...

Oksana is currently working on new migration test cases, and may consider
looking into adding "different QEMU version" support too.

PS: I have to say, though, that I'm trying to get my mind around
cross-arch migration being real.

- Cleber.

> > > I hope I'm wrong and confuse, this is a great news for me to know we
> > > can migrate floats!
> > >=20
> > > > Dave
> > > >=20
> > > > > > So we could store the frequency in clock out and migrate things=
 there.
> > > > > > But since we have no way to ensure all clock out states are mig=
rated
> > > > > > before some device fetch a ClockIn: we'll have to say "don't fe=
tch one
> > > > > > of your ClockIn frequency during migration and migrate the valu=
e
> > > > > > yourself if you need it", pretty much like gpios.
> > > > > >=20
> > > > > > So we will probably migrate all ClockOut and almost all ClockIn=
.
> > > > > >=20
> > > > > > It would nice if we had a way to ensure clocks are migrated bef=
ore
> > > > > > devices try to use them. But I don't think this is possible.
> > > > > >=20
> > > > > > --
> > > > > > Damien
> > > > > >=20
> > > > >=20
> > > > --
> > > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > > >=20
> > >=20
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >=20
>=20


