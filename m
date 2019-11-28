Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC5DC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 08:59:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D47002176D
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 08:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iJWlvaPB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D47002176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaFeK-00032g-Vv
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 03:59:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53197)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iaFaj-0001QO-M1
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 03:56:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iaFaB-0003h1-Qa
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 03:55:29 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54922
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iaFaB-0003a7-JT
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 03:55:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574931325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OSPxVWVaufVBzbSp9R9OBKc7D3f68hj0r8Lx6mZvlhY=;
 b=iJWlvaPB++gP+KCyCHD9nEMDs13skbqQcxkY9WhjNkgWF4DyyJvFMqpnwF+VBj2p13QhWO
 H0nX+xyfBLgADZZc3D6FZpCLEa1ImaDqbvIYSbbVPIAuH9PUN3RUkFyTDMSO0Bc1b5m+j4
 MvibIc5XrgZdWjVAw/OnV1foQ2xRrj0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-8C0kW4w4Osa9qoF5Z7ze_w-1; Thu, 28 Nov 2019 03:55:23 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36C6410054E3;
 Thu, 28 Nov 2019 08:55:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 190AD5D9E1;
 Thu, 28 Nov 2019 08:54:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 96EEF1138606; Thu, 28 Nov 2019 09:54:48 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [RFC v5 000/126] error: auto propagated local_err
References: <20191011160552.22907-1-vsementsov@virtuozzo.com>
Date: Thu, 28 Nov 2019 09:54:48 +0100
In-Reply-To: <20191011160552.22907-1-vsementsov@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Fri, 11 Oct 2019 19:03:46 +0300")
Message-ID: <87tv6opehz.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 8C0kW4w4Osa9qoF5Z7ze_w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>, Jeff Cody <codyprime@gmail.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Alberto Garcia <berto@igalia.com>,
 Hailiang Zhang <zhang.zhanghailiang@huawei.com>, qemu-block@nongnu.org,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Halil Pasic <pasic@linux.ibm.com>,
 =?utf-8?Q?Herv=C3=A9?= Poussineau <hpoussin@reactos.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Laszlo Ersek <lersek@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Xie Changlong <xiechanglong.d@gmail.com>, Peter Lieven <pl@kamp.de>, "Dr.
 David Alan Gilbert" <dgilbert@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>, Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>, Chris Wulff <crwulff@gmail.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, Michael Walle <michael@walle.cc>,
 qemu-ppc@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Igor Mammedov <imammedo@redhat.com>, Fam Zheng <fam@euphon.net>,
 Peter Maydell <peter.maydell@linaro.org>, sheepdog@lists.wpkg.org,
 Matthew Rosato <mjrosato@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Palmer Dabbelt <palmer@sifive.com>, Eric Farman <farman@linux.ibm.com>,
 Max Filippov <jcmvbkbc@gmail.com>, "Denis V. Lunev" <den@openvz.org>,
 Hannes Reinecke <hare@suse.com>, Stefano Stabellini <sstabellini@kernel.org>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>, Liu Yuan <namei.unix@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Amit Shah <amit@kernel.org>, Stefan Weil <sw@weilnetz.de>,
 Greg Kurz <groug@kaod.org>, Yuval Shaia <yuval.shaia@oracle.com>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Stafford Horne <shorne@gmail.com>, qemu-riscv@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Paul Burton <pburton@wavecomp.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, Paul Durrant <paul@xen.org>,
 Anthony Green <green@moxielogic.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Ari Sundholm <ari@tuxera.com>,
 Juan Quintela <quintela@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Joel Stanley <joel@jms.id.au>,
 Jason Dillaman <dillaman@redhat.com>, Antony Pavlov <antonynpavlov@gmail.com>,
 xen-devel@lists.xenproject.org, integration@gluster.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Richard W.M. Jones" <rjones@redhat.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, Max Reitz <mreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Vincenzo Maffione <v.maffione@gmail.com>, Marek Vasut <marex@denx.de>,
 armbru@redhat.com,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, Luigi Rizzo <rizzo@iet.unipi.it>,
 David Gibson <david@gibson.dropbear.id.au>,
 Tony Krowiak <akrowiak@linux.ibm.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Pierre Morel <pmorel@linux.ibm.com>, Wen Congyang <wencongyang2@huawei.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Please accept my sincere apologies for taking so long to reply.  A few
thoughts before I dig deeper.

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> Hi all!
>
> At the request of Markus: full version of errp propagation. Let's look
> at it. Cover as much as possible, except inserting macro invocation
> where it's not necessary.
>
> It's huge, and so it's an RFC.

It's a monster.  Best to get it into full view before we commit to
fighting it.

> In v5 I've added a lot more preparation cleanups:
> 01-23 are preparation cleanups
>   01: not changed, keep Eric's r-b
>   02: improve commit msg [Markus], keep Eric's r-b
>   03: changed, only error API here, drop r-b
> 24 is core macro
>   - improve cover letter, wording and macro code style
>   - keep Eric's r-b
> 25-26: automation scripts
>    - commit-per-subsystem changed a lot. it's a draft, don't bother too
>      much with it
>    - coccinelle: add support of error_propagate_prepend
>
> 27-126: generated patches

Splitting up the monster can make fighting it easier.

Your description suggests three high-level parts:

Part 1: Preparation (makes sense by itself)
Part 2: Error interface update (with rules what code should do now)
Part 3: Make the code obey the new rules everywhere

I hope we can get part 1 out of the way quickly.  Diffstat:

 backends/cryptodev.c       |  11 +---
 block/nbd.c                |  10 +--
 block/snapshot.c           |   4 +-
 dump/dump-hmp-cmds.c       |   4 +-
 hw/9pfs/9p-local.c         |   4 +-
 hw/9pfs/9p-proxy.c         |   5 +-
 hw/core/loader-fit.c       |   5 +-
 hw/core/machine-hmp-cmds.c |   6 +-
 hw/core/qdev.c             |  28 ++++----
 hw/i386/amd_iommu.c        |  14 ++--
 hw/ppc/spapr.c             |   2 +-
 hw/s390x/event-facility.c  |   2 +-
 hw/s390x/s390-stattrib.c   |   3 +-
 hw/sd/sdhci.c              |   2 +-
 hw/tpm/tpm_emulator.c      |   8 +--
 hw/usb/dev-network.c       |   2 +-
 hw/vfio/ap.c               |  16 +----
 include/block/snapshot.h   |   2 +-
 include/monitor/hmp.h      |   2 +-
 include/qapi/error.h       |  69 ++++++++++++++++++--
 include/qom/object.h       |   4 +-
 monitor/hmp-cmds.c         | 155 ++++++++++++++++++++++-------------------=
----
 monitor/qmp-cmds.c         |   2 +-
 net/net.c                  |  17 ++---
 qdev-monitor.c             |  28 ++++----
 qga/commands-posix.c       |   2 +-
 qga/commands-win32.c       |   2 +-
 qga/commands.c             |  12 ++--
 qom/qom-hmp-cmds.c         |   4 +-
 target/ppc/kvm.c           |   6 +-
 target/ppc/kvm_ppc.h       |   4 +-
 ui/vnc.c                   |  20 ++----
 ui/vnc.h                   |   2 +-
 util/error.c               |  30 ++++-----
 34 files changed, 261 insertions(+), 226 deletions(-)

At first glance, I can see bug fixes, non-mechanical cleanups, and
mechanical cleanups.

Within each of these three groups, we have related sub-groups.  For
instance, several patches clean up funny names for the common Error **
parameters.  Several more rename "uncommon" Error ** parameters, to
signal their uncommon role.  I doubt splitting up these subgroups of
related mechanical changes along subsystem lines is worthwhile.

Part 2 needs careful interface review.  Having part 3 ready helps there,
because we can see rather than guess how the interface changes play out.
We really want to get this part right from the start, because if we
don't, we get to do part 3 again.

Part 3 is what makes this a monster.  I understand it's mechanical.  We
can merge it incrementally, but we do want to merge it all, and sooner
rather than later, to avoid a mix of old and new error handling code.
Such mixes inevitably confuse developers, and lead to new instances of
the old patterns creeping in.

I do have doubts about your automated split.

I acknowledge maintainers of active subsystems may want to merge this on
their own terms, to minimize disruption.  Splitting off sub-monsters for
them makes sense.  Splitting off the long tail of less busy subsystems
not so much; it'll only drag out the merging.  Your list below shows 100
parts, and chasing their maintainers is not going to be a fun
experience.

Moreover, using MAINTAINERS to guide an automatic split is a cute idea,
but it falls apart when MAINTAINERS attributes the same file to several
subsystems, which is fairly common.  A sane split requires human touch.

Instead, I'd start with big subsystems with maintainers known to be
sympathetic to this effort.  Split off their sub-monsters, get them
merged.  Iterate until the remainder can be merged in one final push.

> =3D=3D=3D=3D
>
> Here is a proposal of auto propagation for local_err, to not call
> error_propagate on every exit point, when we deal with local_err.

More cleverness, less code, avoids one kind of error (forgetting manual
propagate when we should), risks another kind of error (automatic
propagate when we shouldn't).  Tradeoffs, but the general feeling among
reviewers appears to be positive.

> There are also two issues with errp:
>
> 1. error_fatal & error_append_hint/error_prepend: user can't see this
> additional info, because exit() happens in error_setg earlier than info
> is added. [Reported by Greg Kurz]

Yes, broken by design, hurts users.

> 2. error_abort & error_propagate: when we wrap
> error_abort by local_err+error_propagate, resulting coredump will
> refer to error_propagate and not to the place where error happened.
> (the macro itself don't fix the issue, but it allows to [3.] drop all
> local_err+error_propagate pattern, which will definitely fix the issue)
> [Reported by Kevin Wolf]

Yes, broken by design, inconveniences developers.

> =3D=3D=3D=3D
>
> Generated patches split:
>
> misc
>    hw/misc/ivshmem.c
>    hw/misc/tmp105.c
>    hw/misc/tmp421.c
[99 more...]


