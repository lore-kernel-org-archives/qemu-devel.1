Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE77EC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:02:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97B492073D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NGPBSV2B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97B492073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iopRT-0006fI-RV
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 09:02:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57118)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ionzb-0003ut-Cr
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:29:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ionza-0002NM-0w
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:29:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46732
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ionzZ-0002N2-Ta
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:29:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578400189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TZ83UycMDOLcCA+hbp/J8ADRZ3RUxhBa2G8MTX0Ec+k=;
 b=NGPBSV2BE+Q9UkoOfOsIb4tGqiTgiRh3IT776PCbyfUB248DJp6GU29Ihw5tG28wNlcCJ4
 I7fleGqCbpQpJ6pTfQpDDwn84njrFm3yb8LX3p8trvc9mJAJDSUYPhZM99f98aLEPwAatK
 JxVel1bJcDslMGK+a9J+uH+xMXdYt8M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-uAP-MQbNN2Ozt3wjVi-AIQ-1; Tue, 07 Jan 2020 07:29:46 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86F7C1007269;
 Tue,  7 Jan 2020 12:29:45 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-78.ams2.redhat.com [10.36.116.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D7C3F272D3;
 Tue,  7 Jan 2020 12:29:25 +0000 (UTC)
Date: Tue, 7 Jan 2020 13:29:24 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: Priority of -accel (was: [PATCH] tests/qemu-iotests: Update
 tests to recent desugarized -accel option)
Message-ID: <20200107122924.GI4076@linux.fritz.box>
References: <20200106130951.29873-1-philmd@redhat.com>
 <c493e693-13a7-7dc4-eb2d-5dbc7b3053f1@redhat.com>
 <12334054-4ae7-e580-9727-2d322bfa2bda@redhat.com>
 <58eb34db-7d32-8b0e-d9ef-98648209486b@redhat.com>
MIME-Version: 1.0
In-Reply-To: <58eb34db-7d32-8b0e-d9ef-98648209486b@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: uAP-MQbNN2Ozt3wjVi-AIQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 07.01.2020 um 13:18 hat Thomas Huth geschrieben:
> On 07/01/2020 11.14, Paolo Bonzini wrote:
> > On 07/01/20 11:03, Thomas Huth wrote:
> >>> =20
> >>>  vm =3D QEMUMachine(iotests.qemu_prog)
> >>> -vm.add_args('-machine', 'accel=3Dkvm:tcg')
> >>> +vm.add_args('-accel', 'kvm', '-accel', 'tcg')
> >> Looking at this, I wonder whether we really want the "-accel" option t=
o
> >> prioritize the accelerators in the order of appearance? A lot of other
> >> CLI tools give the highest priority to the last parameter instead, e.g=
.
> >> "gcc -O3 -O1" compiles with -O1, and not with -O3.
> >>
> >> Also I think it might be quite common that there are shell scripts whi=
ch
> >> call "qemu-system-xxx -accel xyz $*" ... and if we don't invert the
> >> priorities of -accel, it will be impossible to override -accel in that
> >> case...
> >=20
> > Hmm, it does match "-machine accel=3Dkvm:tcg" and in general I think it=
's
> > more self-explanatory.  However, it is indeed less friendly to scripts.
> >  On one hand those could be changed to place "-accel xyz" after $* (or
> > better "$@"), on the other hand we could also add a priority option to
> > "-accel".  What do you think?
>=20
> I don't think we need a separate priority parameter here. But IMHO it's
>  really rather common practice to prioritize the last option. So while
> it might be more "self-explanatory" to a CLI newbie if the first
> occurrence got the highest priority, it might be rather confusing
> instead for a CLI veteran...?
>=20
> What do others on the list here think about this?

But in those cases where a later option takes priority, at least those
that I'm thinking of right now, it actually completely overrides the
first option as if it hadn't been given.

This one seems to be different in that a later option actually just adds
to the list. Processing a list backwards isn't necessarily less
confusing than what we have.

Kevin


