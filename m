Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B487BC33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 13:07:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E6D2206D5
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 13:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aKEctoCQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E6D2206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is4sA-0003Ga-NR
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 08:07:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39502)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1is4rG-0002dW-1h
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 08:06:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1is4rC-0007N6-NP
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 08:06:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45119
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1is4rC-0007Mm-JI
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 08:06:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579180002;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tzM349piLanBIg0eCYJA/uoBwSBRKRRzfVlmnUZ1vh4=;
 b=aKEctoCQM8n3VvRSo1xBLiQkIg7Rw0+xZoogVgasy5x5haWzwngiG+pmv9v4xVidTTH55z
 RDwdWDd83ZKmH88aliAigndIDxrHzFYkEwascSDGuTjx9z88XnSZ7hzZKbg1lI5QMUjncm
 c2yR4o0e/5ZVWn2Eif6nMK7cR1vxck4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-fjgL6zCbNeaqggc-xefzaw-1; Thu, 16 Jan 2020 08:06:38 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6EF05108C254;
 Thu, 16 Jan 2020 13:06:37 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A848610016DA;
 Thu, 16 Jan 2020 13:06:30 +0000 (UTC)
Date: Thu, 16 Jan 2020 13:06:28 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [libvirt] [PATCH v2 82/86] numa: forbid '-numa node, mem' for
 5.0 and newer machine types
Message-ID: <20200116130628.GG4611@redhat.com>
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-83-git-send-email-imammedo@redhat.com>
 <20200115153453.GL3243410@angien.pipo.sk>
 <20200115175237.325055f3@redhat.com>
 <8b9be103-d550-853a-86ff-1dc504daab64@redhat.com>
 <20200116133703.11248ead@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200116133703.11248ead@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: fjgL6zCbNeaqggc-xefzaw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: peter.maydell@linaro.org, Peter Krempa <pkrempa@redhat.com>,
 ehabkost@redhat.com, mst@redhat.com, libvir-list@redhat.com,
 Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, pbonzini@redhat.com,
 david@gibson.dropbear.id.au, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 16, 2020 at 01:37:03PM +0100, Igor Mammedov wrote:
> On Thu, 16 Jan 2020 11:42:09 +0100
> Michal Privoznik <mprivozn@redhat.com> wrote:
>=20
> > On 1/15/20 5:52 PM, Igor Mammedov wrote:
> > > On Wed, 15 Jan 2020 16:34:53 +0100
> > > Peter Krempa <pkrempa@redhat.com> wrote:
> > >  =20
> > >> On Wed, Jan 15, 2020 at 16:07:37 +0100, Igor Mammedov wrote: =20
> > >>> Deprecation period is ran out and it's a time to flip the switch
> > >>> introduced by cd5ff8333a.
> > >>> Disable legacy option for new machine types and amend documentation=
.
> > >>>
> > >>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > >>> ---
> > >>> CC: peter.maydell@linaro.org
> > >>> CC: ehabkost@redhat.com
> > >>> CC: marcel.apfelbaum@gmail.com
> > >>> CC: mst@redhat.com
> > >>> CC: pbonzini@redhat.com
> > >>> CC: rth@twiddle.net
> > >>> CC: david@gibson.dropbear.id.au
> > >>> CC: libvir-list@redhat.com
> > >>> CC: qemu-arm@nongnu.org
> > >>> CC: qemu-ppc@nongnu.org
> > >>> ---
> > >>>   hw/arm/virt.c        |  2 +-
> > >>>   hw/core/numa.c       |  6 ++++++
> > >>>   hw/i386/pc.c         |  1 -
> > >>>   hw/i386/pc_piix.c    |  1 +
> > >>>   hw/i386/pc_q35.c     |  1 +
> > >>>   hw/ppc/spapr.c       |  2 +-
> > >>>   qemu-deprecated.texi | 16 ----------------
> > >>>   qemu-options.hx      |  8 ++++----
> > >>>   8 files changed, 14 insertions(+), 23 deletions(-) =20
> > >>
> > >> I'm afraid nobody bothered to fix it yet:
> > >>
> > >> https://bugzilla.redhat.com/show_bug.cgi?id=3D1783355 =20
> > >=20
> > > It's time to start working on it :)
> > > (looks like just deprecating stuff isn't sufficient motivation,
> > > maybe actual switch flipping would work out better)
> > >  =20
> >=20
> > So how was the upgrade from older to newer version resolved? I mean, if=
=20
> > the old qemu used -numa node,mem=3DXXX and it is migrated to a host wit=
h=20
> > newer qemu, the cmd line can't be switched to -numa node,memdev=3Dnode0=
,=20
> > can it? I'm asking because I've just started working on this.
>=20
> see commit cd5ff8333a3c87 for detailed info.
> Short answer is it's not really resolved [*],
> -numa node,mem will keep working on newer QEMU but only for old machine t=
ypes
> new machine types will accept only -numa node,memdev.
>=20
> One can check if "mem=3D' is supported by using QAPI query-machines
> and checking numa-mem-supported field. That field is flipped to false
> for 5.0 and later machine types in this patch.

Since libvirt droppped the ball here, can we postpone this change
to machine types until a later release.=20


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


