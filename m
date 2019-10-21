Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB343CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 15:00:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 672BF20656
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 15:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yev1s37r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 672BF20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMZAE-0007In-25
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 11:00:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53337)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iMZ8i-0005pS-6J
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 10:58:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iMZ8f-0004os-KA
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 10:58:30 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60773
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iMZ8f-0004oM-CG
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 10:58:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571669908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6abUmKP/NmKNmjhVzPa7Sp7wiDwQ32hBBylFGoOY8wk=;
 b=Yev1s37r3T24JVLdvd5WiIb+0Y46jE6/6K/T3Iba89YGgDG/XAApWMoADBPjQiIJtz9KSs
 XjhmyCBjt2pLFBHsEknWlJRGZYi5t1IP8gvyvfh/UVucPWPSwhxBvV1Rs7pu+Mt/I+Shvy
 A0WM8fFAbWmvXGY3NC3AG/etrjDfH8Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-kfAcDzWyOuik_j-T6uwnuw-1; Mon, 21 Oct 2019 10:58:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1943F107AD31;
 Mon, 21 Oct 2019 14:57:56 +0000 (UTC)
Received: from work-vm (ovpn-117-232.ams2.redhat.com [10.36.117.232])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C4184B5;
 Mon, 21 Oct 2019 14:57:31 +0000 (UTC)
Date: Mon, 21 Oct 2019 15:57:29 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 12/21] hw/arm: Let the machine be the owner of the system
 memory
Message-ID: <20191021145729.GC5837@work-vm>
References: <20191020225650.3671-1-philmd@redhat.com>
 <20191020225650.3671-13-philmd@redhat.com>
 <CAFEAcA8bhP9X-2AaTus9=GtEAqmnNA9me6hv8U=vXYwjQp_CnA@mail.gmail.com>
 <42944bea-4b15-7bdf-61a7-f1c73f5f7c2b@redhat.com>
 <CAFEAcA8hJ7bQeQNdWB6Rg4P7RzYmcXZmQKm7pnDAOutADHe9jA@mail.gmail.com>
 <20804096-7b34-9d79-1d93-fa9a31bbfd66@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20804096-7b34-9d79-1d93-fa9a31bbfd66@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: kfAcDzWyOuik_j-T6uwnuw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Leif Lindholm <leif.lindholm@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paul Burton <pburton@wavecomp.com>, Rob Herring <robh@kernel.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Helge Deller <deller@gmx.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Antony Pavlov <antonynpavlov@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Fabien Chouteau <chouteau@adacore.com>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Jan Kiszka <jan.kiszka@web.de>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, patchew-devel@redhat.com,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, Andrew Jeffery <andrew@aj.id.au>,
 Michael Walle <michael@walle.cc>, qemu-ppc <qemu-ppc@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Peter Chubb <peter.chubb@nicta.com.au>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Philippe Mathieu-Daud=E9 (philmd@redhat.com) wrote:
> Cc'ing Paolo/David.
>=20
> On 10/21/19 11:39 AM, Peter Maydell wrote:
> > On Mon, 21 Oct 2019 at 10:34, Philippe Mathieu-Daud=E9 <philmd@redhat.c=
om> wrote:
> > >=20
> > > On 10/21/19 11:22 AM, Peter Maydell wrote:
> > > > On Mon, 21 Oct 2019 at 00:01, Philippe Mathieu-Daud=E9 <philmd@redh=
at.com> wrote:
> > > > >=20
> > > > > Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> > > > > ---
> > > >=20
> > > > >    hw/arm/virt.c             | 2 +-
> > > >=20
> > > > I think from a quick code scan that this is ok, but did
> > > > you test that migration compat from old to new still works?
> > > > I vaguely recall that there are some cases when adding an
> > > > owner to a memory region changes the name string used for
> > > > identifying the ramblock in migration.
> > >=20
> > > It seems to still works:
> > >=20
> > > $ make check-qtest-aarch64 V=3D1
> >=20
> > > This test migrate the virt machine.
> > >=20
> > > Is this enough?
> >=20
> > No, you need to test migration from a QEMU binary without
> > this patchset to a QEMU binary that has it. Otherwise you're
> > only checking that the new version can migrate from itself
> > to itself. I find the easiest way to test this is just to
> > use the 'savevm' command to save a state snapshot to a
> > qcow2 disk image while running the old binary, and then run
> > 'loadvm' with the new binary and check it restored OK.
>=20
> I did not think if this case.
>=20
> I followed your blog post [*] and tested the migration works OK.
>=20
> Paolo, now thinking about regular testing, we should add this testing to
> patchew too. Something like:
>=20
> - when mainstream/master is updated, patchew build QEMU (it should be
> already mostly ccached) and generate some vm dumps with 'savevm'.
>=20
> - build/test the series
>=20
> - if series succeeded testing, run 'loadvm' tests
>=20
> [*] https://translatedcode.wordpress.com/2015/07/06/tricks-for-debugging-=
qemu-savevm-snapshots/

Avocado certainly already has an option for specifying source and
destination qemu separately; I've used that for testing
cross version in the past.

The challenge is finding a command line/set of devices for each
architecture that's expected to be stable.
You want a command line with as big a set of devices as possible (for
coverage) yet really is tied to machine type.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


