Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70497C04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:26:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F526214AF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QsYbeyWR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F526214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j04aK-000859-Fm
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:26:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49594)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j04ZX-0006yd-3Q
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:25:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j04ZV-0004qW-N6
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:25:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25151
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j04ZV-0004pR-Iz
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:25:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581085529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5giItzpYoo3JEelMMhtzAC6x4a3E/6AQgX4HqCHDuJE=;
 b=QsYbeyWRVzcxFF7z2Vg/GpAtwzhxRJI748j1qxV2XxFhtx9nPwu7POMnc3NGIp8XZUEI5N
 rpSZmrfgeTd0HEITIe6qz/5/uwfu6EpksXKR4FUNCS6SJ+Icop/v6KY87jgA1XRH+5LDSZ
 yl5GM69ECOiJ2zRbR1IzpJExAVsZlJM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-uf37IS3iPmiQODtFL0uyng-1; Fri, 07 Feb 2020 09:25:26 -0500
Received: by mail-qk1-f197.google.com with SMTP id a132so1519148qkg.5
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 06:25:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=zs6K5DgkRqHV/ngJLTDOx4/uc8Jnp+hvbLz9w49py/Q=;
 b=oXiExi0p0PLPICcI8+J5XirCe7KwcskXlqm4xd7yMDzgakTSgbI22gnn9sT75sSnzJ
 xfoK17tjZWWXBjuoDJdUUtRCe9Tp7ToK3YaRicenvc+8cDAdx6qTtWaKZW3r4SSibc53
 1ZfYEP5TYSi1TqAO0jcGuYEKLQX++6hY8GC7rwQ7+XDz/I99auZR7k/MQDnrhRQhXc0P
 KbOoNj1XT5thUt+Ro0FAYnZg+YPeFyWviuNl8RUXUsJWexZQazperRlcnQ5vSzklDd9v
 koTbQ2aQUVLVjWuCkJUM/mF2LIiaD1GdZxJJwnwDET0zx2BafSVZbjfjdNvBNBwPSqVH
 Fm6A==
X-Gm-Message-State: APjAAAV4nQ1TK5V2U19ytLsk1gL3tKDt9UmuHzc4SZXQfeFeJUne4rVO
 h5ArHNoQolSKxzHnM1uRXJX1Svw+SRnKD+18cLfqdUriW/lk1PaTlt6US6Wure3gtFJGuwgbwc8
 N9OmrkQ/qGXOJCJE=
X-Received: by 2002:ac8:607:: with SMTP id d7mr7573949qth.271.1581085525601;
 Fri, 07 Feb 2020 06:25:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqzmFBmC/C8aFTepE2yfJ9wB6lNLabovEOWo1q8396V/RXiRthP2BnpsoYobvSJMZLQVX0nzfQ==
X-Received: by 2002:ac8:607:: with SMTP id d7mr7573905qth.271.1581085525317;
 Fri, 07 Feb 2020 06:25:25 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
 by smtp.gmail.com with ESMTPSA id m204sm1407189qke.35.2020.02.07.06.25.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 06:25:24 -0800 (PST)
Date: Fri, 7 Feb 2020 09:25:16 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH v3 2/3] hw: Make MachineClass::is_default a boolean type
Message-ID: <20200207092450-mutt-send-email-mst@kernel.org>
References: <20200207130453.16666-1-philmd@redhat.com>
 <20200207130453.16666-3-philmd@redhat.com>
 <20200207091138-mutt-send-email-mst@kernel.org>
 <16ec9b38-94e4-bd2d-a47f-83a27289ab47@vivier.eu>
MIME-Version: 1.0
In-Reply-To: <16ec9b38-94e4-bd2d-a47f-83a27289ab47@vivier.eu>
X-MC-Unique: uf37IS3iPmiQODtFL0uyng-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Chris Wulff <crwulff@gmail.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>, Anthony Green <green@moxielogic.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek Vasut <marex@denx.de>,
 Jia Liu <proljc@gmail.com>, qemu-trivial@nongnu.org,
 Helge Deller <deller@gmx.de>, Magnus Damm <magnus.damm@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>,
 qemu-riscv@nongnu.org, Thomas Huth <huth@tuxfamily.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Michael Walle <michael@walle.cc>,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Feb 07, 2020 at 03:22:19PM +0100, Laurent Vivier wrote:
> Le 07/02/2020 =E0 15:11, Michael S. Tsirkin a =E9crit=A0:
> > On Fri, Feb 07, 2020 at 02:04:52PM +0100, Philippe Mathieu-Daud=E9 wrot=
e:
> >> There's no good reason for it to be type int, change it to bool.
> >>
> >> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> >> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> >=20
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> >=20
> >> ---
> >> v3: new patch
> >> ---
> >>  include/hw/boards.h                      |  2 +-
> >>  hw/alpha/dp264.c                         |  2 +-
> >>  hw/cris/axis_dev88.c                     |  2 +-
> >>  hw/hppa/machine.c                        |  2 +-
> >>  hw/i386/pc_piix.c                        | 10 +++++-----
> >>  hw/lm32/lm32_boards.c                    |  2 +-
> >>  hw/m68k/mcf5208.c                        |  2 +-
> >>  hw/microblaze/petalogix_s3adsp1800_mmu.c |  2 +-
> >>  hw/mips/mips_malta.c                     |  2 +-
> >>  hw/moxie/moxiesim.c                      |  2 +-
> >>  hw/nios2/10m50_devboard.c                |  2 +-
> >>  hw/openrisc/openrisc_sim.c               |  2 +-
> >>  hw/ppc/mac_oldworld.c                    |  2 +-
> >>  hw/ppc/spapr.c                           |  2 +-
> >>  hw/riscv/spike.c                         |  2 +-
> >>  hw/s390x/s390-virtio-ccw.c               |  2 +-
> >>  hw/sh4/shix.c                            |  2 +-
> >>  hw/sparc/sun4m.c                         |  2 +-
> >>  hw/sparc64/niagara.c                     |  2 +-
> >>  hw/sparc64/sun4u.c                       |  4 ++--
> >>  hw/unicore32/puv3.c                      |  2 +-
> >>  21 files changed, 26 insertions(+), 26 deletions(-)
> >>
> ...
> >> diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
> >> index 5eb2d097b9..81a1748fad 100644
> >> --- a/hw/sparc64/niagara.c
> >> +++ b/hw/sparc64/niagara.c
> >> @@ -170,7 +170,7 @@ static void niagara_class_init(ObjectClass *oc, vo=
id *data)
> >> =20
> >>      mc->desc =3D "Sun4v platform, Niagara";
> >>      mc->init =3D niagara_init;
> >> -    mc->max_cpus =3D 1; /* XXX for now */
> >> +    mc->max_cpus =3D true; /* XXX for now */
>=20
> what happened here ^^^
>=20
> >>      mc->default_boot_order =3D "c";
> >>      mc->default_cpu_type =3D SPARC_CPU_TYPE_NAME("Sun-UltraSparc-T1")=
;
> >>  }
> >> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> >> index b7ac42f7a5..3c2c9d2eb0 100644
> >> --- a/hw/sparc64/sun4u.c
> >> +++ b/hw/sparc64/sun4u.c
> >> @@ -816,7 +816,7 @@ static void sun4u_class_init(ObjectClass *oc, void=
 *data)
> >>      mc->init =3D sun4u_init;
> >>      mc->block_default_type =3D IF_IDE;
> >>      mc->max_cpus =3D 1; /* XXX for now */
> >> -    mc->is_default =3D 1;
> >> +    mc->is_default =3D true;
> >>      mc->default_boot_order =3D "c";
> >>      mc->default_cpu_type =3D SPARC_CPU_TYPE_NAME("TI-UltraSparc-IIi")=
;
> >>      mc->ignore_boot_device_suffixes =3D true;
> >> @@ -841,7 +841,7 @@ static void sun4v_class_init(ObjectClass *oc, void=
 *data)
> >>      mc->desc =3D "Sun4v platform";
> >>      mc->init =3D sun4v_init;
> >>      mc->block_default_type =3D IF_IDE;
> >> -    mc->max_cpus =3D 1; /* XXX for now */
> >> +    mc->max_cpus =3D true; /* XXX for now */
>=20
> and here ^^
>=20
> Thanks,
> Laurent

Ooh good catch. Which probably means we don't have a unit test for these
...


