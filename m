Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB24C2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 13:08:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0928320866
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 13:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aPTpXX/F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0928320866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inMgs-0006hm-2A
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 08:08:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54234)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1inMfW-0006GX-GQ
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 08:07:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1inMfS-0001Aq-6H
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 08:07:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55379
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1inMfR-00015V-W1
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 08:07:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578056824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MkHo0L9p1yFIAkabYZ8ORc4YAtTnm4a5CDymUkbtK5o=;
 b=aPTpXX/F8/u9xxsqVZMeuUZofWkrEv4ucNs/uNWS6ITCZ4iKV53ZwA78QnKQjWKzJ2wIho
 czZmU/5SSJwdRbCdfxYRq1z4i1gNzKMc7OUqpJLSZ03CcGwjCDStWD0ZHMkYN7XwLKax19
 mRfADmlqkUatzaD47FHW/sAShBqAyvo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-YplajQBVOiWzhW2uCSjWFw-1; Fri, 03 Jan 2020 08:07:03 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1A1F800D41
 for <qemu-devel@nongnu.org>; Fri,  3 Jan 2020 13:07:02 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DA1FD60C18;
 Fri,  3 Jan 2020 13:06:59 +0000 (UTC)
Date: Fri, 3 Jan 2020 14:06:57 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH 00/86] refactor main RAM allocation to use hostmem backend
Message-ID: <20200103140657.23b143e4@redhat.com>
In-Reply-To: <c2d1f51d-a204-ec82-1b0a-bf91161b819f@redhat.com>
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
 <c2d1f51d-a204-ec82-1b0a-bf91161b819f@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: YplajQBVOiWzhW2uCSjWFw-1
X-Mimecast-Spam-Score: 0
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 31 Dec 2019 16:58:10 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> Hi Igor,
>=20
> On 12/31/19 2:02 PM, Igor Mammedov wrote:
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
> >      - "numa: remove deprecated implicit RAM distribution between nodes=
"
> >      - "forbid '-numa node,mem' for 5.0 and newer machine types"
> >=20
> > Conversion introduces a new machine.ram-memdev property and wrapper cod=
e that
> > aliases global -mem-path and -mem-alloc into automatically created host=
mem
> > backend properties (provided ram-memdev was not set explicitly by user)=
.
> > And then follows bulk of trivial patches that incrementally convert ind=
ividual
> > boards to using machine.ram-memdev provided MemoryRegion.
> >=20
> > Board conversion typically involves:
> >   * providing MachineClass::default_ram_size and MachineClass::default_=
ram_id
> >     so generic code could create default backend if user didn't explici=
tly provide
> >     ram-memdev or -m options
> >   * dropping memory_region_allocate_system_memory() call
> >   * using covinience MachineState::ram MemoryRegion, which points to Me=
moryRegion
> >     allocated by ram-memdev
> > On top of that for some boards:
> >   * added missing ram_size checks (typically it were boards with fixed =
ram size)
> >   * ram_size fixups were replaced by checks and hard errors, forcing us=
er to
> >     provide correct "-m" values instead of ignoring it and continuing r=
unning.
> >    =20
> > After all boards are converted the old API is removed and memory alloca=
tion
> > routines are cleaned up. =20
>=20
> I'm replying to the cover because multiple patches are concerned.
>=20
> Compiling arm/lm32/mips64el/ppc on 32-bit host I get:
what host/gcc version are you building on,
my fedora 30-32bit setup I did reproduce only a couple of errors.

>=20
>    CC      hw/arm/digic_boards.o
> hw/arm/digic_boards.c: In function 'digic4_board_init':
> hw/arm/digic_boards.c:57:22: error: format '%lli' expects argument of=20
> type 'long long int', but argument 2 has type 'ram_addr_t {aka unsigned=
=20
> int}' [-Werror=3Dformat=3D]
>           error_report("Invalid RAM size, should be %" PRIi64 " Bytes",
>                        ^
> cc1: all warnings being treated as errors
> rules.mak:69: recipe for target 'hw/arm/digic_boards.o' failed
> make: *** [hw/arm/digic_boards.o] Error 1
>    CC      hw/arm/musicpal.o
> hw/arm/musicpal.c: In function 'musicpal_init':
> hw/arm/musicpal.c:1598:22: error: format '%lli' expects argument of type=
=20
> 'long long int', but argument 2 has type 'ram_addr_t {aka unsigned int}'=
=20
> [-Werror=3Dformat=3D]
>           error_report("Invalid RAM size, should be %" PRIi64 " Bytes",
>                        ^
> cc1: all warnings being treated as errors
> rules.mak:69: recipe for target 'hw/arm/musicpal.o' failed
> make: *** [hw/arm/musicpal.o] Error 1
>    CC      hw/arm/nseries.o
> hw/arm/nseries.c: In function 'n8x0_init':
> hw/arm/nseries.c:1316:22: error: format '%lli' expects argument of type=
=20
> 'long long int', but argument 2 has type 'ram_addr_t {aka unsigned int}'=
=20
> [-Werror=3Dformat=3D]
>           error_report("Invalid RAM size, should be %" PRIi64 " Bytes",
>                        ^
> cc1: all warnings being treated as errors
> rules.mak:69: recipe for target 'hw/arm/nseries.o' failed
> make: *** [hw/arm/nseries.o] Error 1
>    CC      hw/arm/omap_sx1.o
> hw/arm/omap_sx1.c: In function 'sx1_init':
> hw/arm/omap_sx1.c:119:22: error: format '%lli' expects argument of type=
=20
> 'long long int', but argument 2 has type 'ram_addr_t {aka unsigned int}'=
=20
> [-Werror=3Dformat=3D]
>           error_report("Invalid RAM size, should be %" PRIi64 " Bytes",
>                        ^
> cc1: all warnings being treated as errors
> rules.mak:69: recipe for target 'hw/arm/omap_sx1.o' failed
> make: *** [hw/arm/omap_sx1.o] Error 1
>    CC      hw/arm/palm.o
> hw/arm/palm.c: In function 'palmte_init':
> hw/arm/palm.c:202:22: error: format '%lli' expects argument of type=20
> 'long long int', but argument 2 has type 'ram_addr_t {aka unsigned int}'=
=20
> [-Werror=3Dformat=3D]
>           error_report("Invalid RAM size, should be %" PRIi64 " Bytes",
>                        ^
> cc1: all warnings being treated as errors
> rules.mak:69: recipe for target 'hw/arm/palm.o' failed
> make: *** [hw/arm/palm.o] Error 1
>    CC      hw/arm/collie.o
> hw/arm/collie.c: In function 'collie_init':
> hw/arm/collie.c:32:22: error: format '%lli' expects argument of type=20
> 'long long int', but argument 2 has type 'ram_addr_t {aka unsigned int}'=
=20
> [-Werror=3Dformat=3D]
>           error_report("Invalid RAM size, should be %" PRIi64 " Bytes",
>                        ^
> cc1: all warnings being treated as errors
> rules.mak:69: recipe for target 'hw/arm/collie.o' failed
> make: *** [hw/arm/collie.o] Error 1
>    CC      hw/arm/mps2.o
> hw/arm/mps2.c: In function 'mps2_common_init':
> hw/arm/mps2.c:121:22: error: format '%lli' expects argument of type=20
> 'long long int', but argument 2 has type 'ram_addr_t {aka unsigned int}'=
=20
> [-Werror=3Dformat=3D]
>           error_report("Invalid RAM size, should be %" PRIi64 " Bytes",
>                        ^
> cc1: all warnings being treated as errors
> rules.mak:69: recipe for target 'hw/arm/mps2.o' failed
> make: *** [hw/arm/mps2.o] Error 1
>    CC      hw/arm/mps2-tz.o
> hw/arm/mps2-tz.c: In function 'mps2tz_common_init':
> hw/arm/mps2-tz.c:391:22: error: format '%lli' expects argument of type=20
> 'long long int', but argument 2 has type 'ram_addr_t {aka unsigned int}'=
=20
> [-Werror=3Dformat=3D]
>           error_report("Invalid RAM size, should be %" PRIi64 " Bytes",
>                        ^
> cc1: all warnings being treated as errors
> rules.mak:69: recipe for target 'hw/arm/mps2-tz.o' failed
> make: *** [hw/arm/mps2-tz.o] Error 1
>    CC      hw/lm32/lm32_boards.o
> hw/lm32/lm32_boards.c: In function 'lm32_evr_init':
> hw/lm32/lm32_boards.c:89:22: error: format '%lli' expects argument of=20
> type 'long long int', but argument 2 has type 'ram_addr_t {aka unsigned=
=20
> int}' [-Werror=3Dformat=3D]
>           error_report("Invalid RAM size, should be %" PRIi64 " Bytes",
>                        ^
> hw/lm32/lm32_boards.c: In function 'lm32_uclinux_init':
> hw/lm32/lm32_boards.c:179:22: error: format '%lli' expects argument of=20
> type 'long long int', but argument 2 has type 'ram_addr_t {aka unsigned=
=20
> int}' [-Werror=3Dformat=3D]
>           error_report("Invalid RAM size, should be %" PRIi64 " Bytes",
>                        ^
> cc1: all warnings being treated as errors
> rules.mak:69: recipe for target 'hw/lm32/lm32_boards.o' failed
> make: *** [hw/lm32/lm32_boards.o] Error 1
>    CC      hw/lm32/milkymist.o
> hw/lm32/milkymist.c: In function 'milkymist_init':
> hw/lm32/milkymist.c:100:22: error: format '%lli' expects argument of=20
> type 'long long int', but argument 2 has type 'ram_addr_t {aka unsigned=
=20
> int}' [-Werror=3Dformat=3D]
>           error_report("Invalid RAM size, should be %" PRIi64 " Bytes",
>                        ^
> cc1: all warnings being treated as errors
>    CC      hw/mips/mips_fulong2e.o
> hw/mips/mips_fulong2e.c: In function 'mips_fulong2e_init':
> hw/mips/mips_fulong2e.c:317:22: error: format '%ld' expects argument of=
=20
> type 'long int', but argument 2 has type 'long long int' [-Werror=3Dforma=
t=3D]
>           error_report("Invalid RAM size, should be %ld", 256 * MiB);
>                        ^
> cc1: all warnings being treated as errors
>    CC      hw/ppc/ppc405_boards.o
> hw/ppc/ppc405_boards.c: In function 'ref405ep_init':
> hw/ppc/ppc405_boards.c:165:22: error: format '%lli' expects argument of=
=20
> type 'long long int', but argument 2 has type 'ram_addr_t {aka unsigned=
=20
> int}' [-Werror=3Dformat=3D]
>           error_report("Invalid RAM size, should be %" PRIi64 " Bytes",
>                        ^
> hw/ppc/ppc405_boards.c: In function 'taihu_405ep_init':
> hw/ppc/ppc405_boards.c:435:22: error: format '%lli' expects argument of=
=20
> type 'long long int', but argument 2 has type 'ram_addr_t {aka unsigned=
=20
> int}' [-Werror=3Dformat=3D]
>           error_report("Invalid RAM size, should be %" PRIi64 " Bytes",
>                        ^
> cc1: all warnings being treated as errors
> rules.mak:69: recipe for target 'hw/ppc/ppc405_boards.o' failed
> make: *** [hw/ppc/ppc405_boards.o] Error 1
>    CC      hw/ppc/ppc4xx_devs.o
> hw/ppc/ppc4xx_devs.c: In function 'ppc4xx_sdram_adjust':
> hw/ppc/ppc4xx_devs.c:704:39: error: format '%lli' expects argument of=20
> type 'long long int', but argument 3 has type 'ram_addr_t {aka const=20
> unsigned int}' [-Werror=3Dformat=3D]
>               char *t =3D g_strdup_printf("%s%" PRIi64 "%s", s,=20
> sdram_bank_sizes[i],
>                                         ^
> hw/ppc/ppc4xx_devs.c:709:22: error: format '%lli' expects argument of=20
> type 'long long int', but argument 2 has type 'ram_addr_t {aka unsigned=
=20
> int}' [-Werror=3Dformat=3D]
>           error_report("Invalid RAM size, unable to fit all RAM into RAM=
=20
> banks"
>                        ^
> cc1: all warnings being treated as errors
> rules.mak:69: recipe for target 'hw/ppc/ppc4xx_devs.o' failed
> make: *** [hw/ppc/ppc4xx_devs.o] Error 1
>    CC      hw/ppc/e500.o
> hw/ppc/e500.c: In function 'ppce500_init':
> hw/ppc/e500.c:909:22: error: format '%ld' expects argument of type 'long=
=20
> int', but argument 2 has type 'long long int' [-Werror=3Dformat=3D]
>           error_report("RAM size must be multiple of %ld", RAM_SIZES_ALIG=
N);
>                        ^
> cc1: all warnings being treated as errors
>=20
>=20


