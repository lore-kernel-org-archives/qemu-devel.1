Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D86C35671
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 11:34:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FCC320732
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 11:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MWF0JiDt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FCC320732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6C0U-0005in-Kq
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 06:34:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52530)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j6Bzk-0004sM-Dg
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 06:33:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j6Bzi-0002h8-6J
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 06:33:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22531
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j6Bzh-0002gX-TK
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 06:33:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582544028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zrZCXl6nQ6xgGkKPzhoS3oDlL1xOXCnpvNdOu08PWfk=;
 b=MWF0JiDtzO0VJVIauLghLXz19TPNXuashXcwWevxkvYbIeMXUNB1FF1eGIIQQouYoy5mjf
 HAeJTKJ2lDy3bRw9wY2bhqEPIla6jupXr6MmsHcO0dkEo+8+etKoc6TBgC3cX1cFsT2HED
 sUoRP9ff2DjGC8jUSSvjYvJRudk5AL4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-bi9Z2iZ9OwiMgH0L10519Q-1; Mon, 24 Feb 2020 06:33:47 -0500
X-MC-Unique: bi9Z2iZ9OwiMgH0L10519Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FCBE189F762
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 11:33:46 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5A55385F13;
 Mon, 24 Feb 2020 11:33:45 +0000 (UTC)
Date: Mon, 24 Feb 2020 12:33:42 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH v6 00/79] refactor main RAM allocation to use hostmem
 backend
Message-ID: <20200224123342.14b67e6d@redhat.com>
In-Reply-To: <09a2f9da-998c-545b-ea15-f1ae3490fb54@redhat.com>
References: <20200219160953.13771-1-imammedo@redhat.com>
 <09a2f9da-998c-545b-ea15-f1ae3490fb54@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 24 Feb 2020 09:45:11 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> Hi Igor,
>=20
> On 2/19/20 5:08 PM, Igor Mammedov wrote:
> [...]
> > Series removes ad hoc RAM allocation API (memory_region_allocate_system=
_memory)
> > and consolidates it around hostmem backend. It allows to
> >   * resolve conflicts between global -mem-prealloc and hostmem's "polic=
y" option
> >     fixing premature allocation before binding policy is applied
> >   * simplify complicated memory allocation routines which had to deal w=
ith 2 ways
> >     to allocate RAM.
> >   * it allows to reuse hostmem backends of a choice for main RAM withou=
t adding
> >     extra CLI options to duplicate hostmem features.
> >     Recent case was -mem-shared, to enable vhost-user on targets that d=
on't
> >     support hostmem backends [1] (ex: s390)
> >   * move RAM allocation from individual boards into generic machine cod=
e and
> >     provide them with prepared MemoryRegion.
> >   * clean up deprecated NUMA features which were tied to the old API (s=
ee patches)
> >      - "numa: remove deprecated -mem-path fallback to anonymous RAM"
> >      - (POSTPONED, waiting on libvirt side) "forbid '-numa node,mem' fo=
r 5.0 and newer machine types"
> >      - (POSTPONED) "numa: remove deprecated implicit RAM distribution b=
etween nodes"
> >=20
> > Conversion introduces a new machine.memory-backend property and wrapper=
 code that
> > aliases global -mem-path and -mem-alloc into automatically created host=
mem
> > backend properties (provided memory-backend was not set explicitly give=
n by user).
> > And then follows bulk of trivial patches that incrementally convert ind=
ividual
> > boards to using machine.memory-backend provided MemoryRegion.
> >=20
> > Board conversion typically involves:
> >   * providing MachineClass::default_ram_size and MachineClass::default_=
ram_id
> >     so generic code could create default backend if user didn't explici=
tly provide
> >     memory-backend or -m options
> >   * dropping memory_region_allocate_system_memory() call
> >   * using convenience MachineState::ram MemoryRegion, which points to M=
emoryRegion
> >     allocated by ram-memdev
> > On top of that for some boards:
> >   * added missing ram_size checks (typically it were boards with fixed =
ram size)
> >   * ram_size fixups were replaced by checks and hard errors, forcing us=
er to
> >     provide correct "-m" values instead of ignoring it and continuing r=
unning.
> >=20
> > After all boards are converted the old API is removed and memory alloca=
tion
> > routines are cleaned up. =20
>=20
> I wonder about the pre-QOM machines. As they don't call=20
> memory_region_allocate_system_memory(), the conversion is not required?=
=20
> (See for example pxa270_init).
Since they weren't using memory_region_allocate_system_memory(), they are
out of scope of this series.

As for the future, I'd only make boards that support user configurable
ram size to accept "-m".

For fixed size boards -m/memdev is overkill and we need to decide what to d=
o
with them. I see following options (in order of my preference):
  1. Non popular: error out if -m is specified (it used to work, but not
     anymore when check is added, i.e similar to size checks
     introduced in this series so users have to adapt their CLI).
     It can still use automatically created memdev but I'd ditch it on
     those boards and use plain memory_region_init_ram().
     This is matches well SoCs that have embedded RAM and don't really
     care about what user may specify with -m. It would simplify
     simple boards.

  2. a path of least resistance: continue support -m and generalize
     ram_size checks for such boards. This could use memdev since it
     comes for free with -m support. I don't expect complications
     with generalizing it (but one would only know for sure when
     it's coded)

The next this I plan to do is to clean up ram_size global and
hopefully get rid of MachineState:ram_size as well.


