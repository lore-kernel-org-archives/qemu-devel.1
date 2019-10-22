Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B622CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 22:11:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 612662084B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 22:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GzTTZG61"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 612662084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iN2Mu-0000ZH-Ht
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 18:11:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56830)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iN2Lh-0007mg-Uk
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 18:09:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iN2Lf-0001uB-J6
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 18:09:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35035
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iN2Lf-0001tx-Fl
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 18:09:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571782190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AbJX8WkuwtZCUjwdmHq6trYNYsCr8F5Tbj9f/oZDWPM=;
 b=GzTTZG61zImIztuFJev8TZIia3pTU/Ca022m63BBLkLycXWeYdgofHVqqfe7NEr1DJhxPq
 LEB5OAUAGxzcnSxlVq/pu/jQ7IjGsBhUKIF8Y8Uxj/+CKMYajcxKSMLx61QSYs0WwHtki9
 Vkc1chbkqKeg8hPi6ZL4RG4ep8Caaa0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-36UyoW5IMpGcpY5TrN_QDg-1; Tue, 22 Oct 2019 18:09:48 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C44A2107AD31;
 Tue, 22 Oct 2019 22:09:46 +0000 (UTC)
Received: from localhost (ovpn-116-104.gru2.redhat.com [10.97.116.104])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3D6CB194BB;
 Tue, 22 Oct 2019 22:09:42 +0000 (UTC)
Date: Tue, 22 Oct 2019 19:09:41 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 0/3] eliminate remaining places that abuse
 memory_region_allocate_system_memory()
Message-ID: <20191022220941.GD4084@habkost.net>
References: <20191008113318.7012-1-imammedo@redhat.com>
 <20191010193503.097548e4@Igors-MacBook-Pro>
 <20191011172310.19fc5d93@redhat.com>
 <CAP+75-W5HD37gA2JOpniQKMqnVf5z+U6RQT8YZT9TtdDyz3d5g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAP+75-W5HD37gA2JOpniQKMqnVf5z+U6RQT8YZT9TtdDyz3d5g@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 36UyoW5IMpGcpY5TrN_QDg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Helge Deller <deller@gmx.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "open list:sPAPR" <qemu-ppc@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Oct 20, 2019 at 04:38:06PM +0200, Philippe Mathieu-Daud=E9 wrote:
> Ping?

Sorry, missed this.  queued on machine-next.  Pull request will
be submitted today or tomorrow.

>=20
> On Fri, Oct 11, 2019 at 5:23 PM Igor Mammedov <imammedo@redhat.com> wrote=
:
> > On Thu, 10 Oct 2019 19:35:03 +0200
> > Igor Mammedov <imammedo@redhat.com> wrote:
> >
> > Forgot to actually CC Eduardo,
> >
> > > On Tue,  8 Oct 2019 07:33:15 -0400
> > > Igor Mammedov <imammedo@redhat.com> wrote:
> > ...
> > > Eduardo,
> > >
> > > This patches are fixing various machines across tree, so series does =
not belong
> > > to any particular arch specific tree, can you merge it via generic ma=
chine tree?
> >
> >
> > > >
> > > >
> > > > Igor Mammedov (3):
> > > >   sparc64: use memory_region_allocate_system_memory() only for '-m'
> > > >     specified RAM
> > > >   ppc: rs6000_mc: drop usage of memory_region_allocate_system_memor=
y()
> > > >   hppa: drop usage of memory_region_allocate_system_memory() for RO=
M
> > > >
> > > >  hw/hppa/machine.c    |  5 ++---
> > > >  hw/ppc/rs6000_mc.c   | 15 ++++++++++-----
> > > >  hw/sparc64/niagara.c | 25 +++++++++++++------------
> > > >  3 files changed, 25 insertions(+), 20 deletions(-)
> > > >

--=20
Eduardo


