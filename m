Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A75CC33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 16:50:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5489D2064C
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 16:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N2SfaZBu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5489D2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isUp6-0008U7-Bs
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 11:50:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47101)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1isUfj-00027g-QT
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 11:40:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1isUff-0005tn-W6
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 11:40:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39978
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1isUff-0005qk-Ja
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 11:40:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579279230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xnIw2RAn14u/F1+9sdN9pDV5EFCRUubFjli7LgnDt60=;
 b=N2SfaZBuTnEweSxSLvL0acHgy52I5qMSDlJu3aVkQuzTbK2kat+roLq93jR9hDdVu/Z/3m
 eVcEoo7MW/nhyFB+wXcdF5NdB5l8Qm8EMyLqOAWR2Xs7CusHGb1kioD6COo+vLsz+4ARz9
 0M0n1u8nI72IvNRBV7ZXia7fp9CKKJA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-heBC3wffMKG8QemoxUBMXg-1; Fri, 17 Jan 2020 11:40:29 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6AA25100551A;
 Fri, 17 Jan 2020 16:40:28 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 696C71081333;
 Fri, 17 Jan 2020 16:40:22 +0000 (UTC)
Date: Fri, 17 Jan 2020 17:40:21 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH v2 00/86] refactor main RAM allocation to use hostmem
 backend
Message-ID: <20200117174021.7a2d4cc8@redhat.com>
In-Reply-To: <8ca4cae4-8399-73df-c3f3-78ee857ec954@redhat.com>
References: <157912207219.8290.12574147223674937177@37313f22b938>
 <b81ad35f-73d0-a333-d0fe-758e64242ca2@redhat.com>
 <20200117170340.7e91ff8c@redhat.com>
 <8ca4cae4-8399-73df-c3f3-78ee857ec954@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: heBC3wffMKG8QemoxUBMXg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: no-reply@patchew.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 Jan 2020 17:19:26 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> On 1/17/20 5:03 PM, Igor Mammedov wrote:
> > On Thu, 16 Jan 2020 16:43:07 +0100
> > Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
> >  =20
> >> On 1/15/20 10:01 PM, no-reply@patchew.org wrote: =20
> >>> Patchew URL: https://patchew.org/QEMU/1579100861-73692-1-git-send-ema=
il-imammedo@redhat.com/
> >>>
> >>>
> >>>
> >>> Hi,
> >>>
> >>> This series failed the docker-quick@centos7 build test. Please find t=
he testing commands and
> >>> their output below. If you have Docker installed, you can probably re=
produce it
> >>> locally.
> >>>
> >>> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> >>> #!/bin/bash
> >>> make docker-image-centos7 V=3D1 NETWORK=3D1
> >>> time make docker-test-quick@centos7 SHOW_ENV=3D1 J=3D14 NETWORK=3D1 =
=20
> >=20
> > it doesn't work on my host, since it tries to use /tmp for building an =
image
> > and fails with no space.
> > is there any way to point it to some other place? =20
>=20
> What is failing? Building the docker image, or building QEMU withing the=
=20
> docker container?

docker image


