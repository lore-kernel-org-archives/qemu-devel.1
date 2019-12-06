Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369BAC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:56:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1D36206DB
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f1nhVLyM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1D36206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idF1Y-0002x1-0w
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 09:56:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51230)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1idESn-0005mj-0t
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:20:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1idESl-0007lc-El
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:20:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24665
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1idESl-0007hz-79
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:20:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575642004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qeEpOHiVicsdQEuTeVw1xPx0IpulfUWaY/EsL1Z8z1Q=;
 b=f1nhVLyM5DhijZ8xG4duIOOm4J/0OeMvwg/dPZ7yADw1H94Rj2ieItDTRE4HyFQBATTOTi
 9qV4mV/F/McrKP39vvjZtdbAJ2e4Jyat4M04934lOMaDdDFHoy3oBlSuHtDngOB9NDVRZd
 yy80B2cqaiAydHJVlQfie1hnd8vcK7Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-4R-FKP8ONSOLEjbz2If8fQ-1; Fri, 06 Dec 2019 08:49:12 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AFEA7107ACC4;
 Fri,  6 Dec 2019 13:49:10 +0000 (UTC)
Received: from work-vm (ovpn-117-232.ams2.redhat.com [10.36.117.232])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3ADC9608A5;
 Fri,  6 Dec 2019 13:49:02 +0000 (UTC)
Date: Fri, 6 Dec 2019 13:48:59 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH v6 0/9] Clock framework API
Message-ID: <20191206134859.GC2878@work-vm>
References: <CAFEAcA98rt6nRDSrwk8XRbaBT67LZXvF=XEV13dtJBp4fPUscw@mail.gmail.com>
 <be199ad6-1b79-f77d-afad-faeb042151ed@greensocs.com>
 <febdb64d-9d02-66ad-84d2-dc795879e48b@redhat.com>
 <a0cea550-d6c7-0193-b4e6-24ed879be61d@greensocs.com>
 <279a0fd5-1ea5-b3c7-27bb-b1d22db5e359@redhat.com>
 <20191205102151.GB2824@work-vm>
 <f3aa4881-dd41-ce71-0f5a-8d36bf5c3828@redhat.com>
 <20191205105613.GE2824@work-vm>
 <138ef325-dc9a-2ca5-9044-c67ffdabb968@redhat.com>
 <20191206124613.GA3902@dhcp-17-72.bos.redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191206124613.GA3902@dhcp-17-72.bos.redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 4R-FKP8ONSOLEjbz2If8fQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Mark Burton <mark.burton@greensocs.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Oksana Voshchana <ovoshcha@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Cleber Rosa (crosa@redhat.com) wrote:
> On Thu, Dec 05, 2019 at 12:01:56PM +0100, Philippe Mathieu-Daud=E9 wrote:
> >=20
> > Understood, thanks for clearing this out!
> >=20
> > Side note, we don't do cross-arch migration testing, but we talked abou=
t
> > having a 'different QEMU version' migration test. When we get a such te=
st
> > setup, it shouldn't be too difficult to evolve to some cross-arch migra=
tion
> > test.
> >
>=20
> +Oksana,
>=20
> Avocado-VT has had this as a core concept as far as I can remember, and
> it's exposed even as a command line argument:
>=20
>    avocado run --help
>    ...
>    [--vt-qemu-dst-bin VT_DST_QEMU_BIN]
>    ...
>=20

Yeh, I've run that in the past - it works OK.

Dave

> Oksana is currently working on new migration test cases, and may consider
> looking into adding "different QEMU version" support too.
>=20
> PS: I have to say, though, that I'm trying to get my mind around
> cross-arch migration being real.
>=20
> - Cleber.
>=20
> > > > I hope I'm wrong and confuse, this is a great news for me to know w=
e
> > > > can migrate floats!
> > > >=20
> > > > > Dave
> > > > >=20
> > > > > > > So we could store the frequency in clock out and migrate thin=
gs there.
> > > > > > > But since we have no way to ensure all clock out states are m=
igrated
> > > > > > > before some device fetch a ClockIn: we'll have to say "don't =
fetch one
> > > > > > > of your ClockIn frequency during migration and migrate the va=
lue
> > > > > > > yourself if you need it", pretty much like gpios.
> > > > > > >=20
> > > > > > > So we will probably migrate all ClockOut and almost all Clock=
In.
> > > > > > >=20
> > > > > > > It would nice if we had a way to ensure clocks are migrated b=
efore
> > > > > > > devices try to use them. But I don't think this is possible.
> > > > > > >=20
> > > > > > > --
> > > > > > > Damien
> > > > > > >=20
> > > > > >=20
> > > > > --
> > > > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > > > >=20
> > > >=20
> > > --
> > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > >=20
> >=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


