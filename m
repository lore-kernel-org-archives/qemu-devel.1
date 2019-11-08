Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB71DFC6199
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 21:20:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8494A207FA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 21:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEvIO64O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8494A207FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iTBg3-0000xO-JT
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 16:20:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57079)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iTBeO-000846-9p
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 16:18:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iTBeK-0001d6-Lt
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 16:18:36 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44758)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iTBeK-0001bJ-Dq; Fri, 08 Nov 2019 16:18:32 -0500
Received: by mail-wr1-x443.google.com with SMTP id f2so8519055wrs.11;
 Fri, 08 Nov 2019 13:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=58kR9q2cEK71h1k3gjJqWvSSjyB6wHO/TzcyeXj29EE=;
 b=DEvIO64O3J0d45xVtJxaP4AsifeRtUKsE+B0WAIMxQxDmQY7e4KpX0Dz/tIv9jDYXz
 Gmxxof3h+Wvet5r52Np70JC5KBsb1M0PeNCunB3JyM0HVBJzWYswNu7VgvgFmszePLGE
 zMf0jS/oU119E5FnmqzmT4tGjl00q5IXTF/ucZz5i1Ot6Z96VtmCU1B6XXqhdjdUbDtz
 0NeJKN9wUyFvkmIpscavkoZdou4eI45Pq4RBYuQQKNkIftBqgJL/IkeidNHIY6xu0923
 HdCIplBQQInSuxKLYwj4ypgL+x7Se+Mb39oo7HIfpnhsGQHPtjOcX0XBmUek3icfs5Iv
 QE0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=58kR9q2cEK71h1k3gjJqWvSSjyB6wHO/TzcyeXj29EE=;
 b=FK2ilazdPF/1Mdsh6K08CTyt8ABnOLiOFAmEqIjRxrSNByamQAH49VzcFs1J4dkm+g
 roJYsJF74vL0/eq1F40995j1FVNzrcb08gJFf7rXuNnQ3WTLTm3KlNwreJFFF3C8Fd/a
 PzyQmqzL7lrL9Jkjo/7ppFCQGELabedzt1BozocWzAFBNz1FImVzpjMBAmM4Zs/1aGH3
 BhSNvgDmDTF9OonmiLoyJcAzDyrs/QQ+KyxCNoWPW5eY/C4a9KxFgk+dBBecF0fFEM5/
 Y3u9XQcAb5iZ+mZ7SpZQ8X5Kb8GyqGgZGRt5FQ6j/2H5Uj6UCUwiq+2GDyj2TLzJ37A1
 A4VA==
X-Gm-Message-State: APjAAAXt2MBS+RqbzLUwu6dkytOCK8jSY5/Tn4LpLiHRwD4kGQwJtKRL
 miqjLmoviaMNSUYV4Cj+P521RzKbYMWRglglkWE=
X-Google-Smtp-Source: APXvYqy7IWli4J99/GtHWlmk67tjn3St9EHIFkIuF00w+t5H+W72qc9qX567mpn+izofNc7WJNE5L/noJ788H1pmMnI=
X-Received: by 2002:adf:ef0f:: with SMTP id e15mr10314169wro.312.1573247910957; 
 Fri, 08 Nov 2019 13:18:30 -0800 (PST)
MIME-Version: 1.0
References: <20191011160552.22907-1-vsementsov@virtuozzo.com>
 <20191011160552.22907-27-vsementsov@virtuozzo.com>
In-Reply-To: <20191011160552.22907-27-vsementsov@virtuozzo.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 9 Nov 2019 01:18:18 +0400
Message-ID: <CAJ+F1C+d21m9V5=aKakaJFD8h32Mobo8dEvxYMTbNAgSGJEFmw@mail.gmail.com>
Subject: Re: [RFC v5 026/126] python: add commit-per-subsystem.py
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
 Hailiang Zhang <zhang.zhanghailiang@huawei.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Laszlo Ersek <lersek@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Xie Changlong <xiechanglong.d@gmail.com>, Peter Lieven <pl@kamp.de>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>, Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>, Chris Wulff <crwulff@gmail.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, Michael Walle <michael@walle.cc>,
 "open list:sPAPR pseries" <qemu-ppc@nongnu.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
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
 Qemu-s390x list <qemu-s390x@nongnu.org>, "open list:ARM" <qemu-arm@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
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
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 "Richard W.M. Jones" <rjones@redhat.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, Max Reitz <mreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, QEMU <qemu-devel@nongnu.org>,
 Vincenzo Maffione <v.maffione@gmail.com>, Marek Vasut <marex@denx.de>,
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, Luigi Rizzo <rizzo@iet.unipi.it>,
 David Gibson <david@gibson.dropbear.id.au>,
 Tony Krowiak <akrowiak@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Pierre Morel <pmorel@linux.ibm.com>, Wen Congyang <wencongyang2@huawei.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Fri, Oct 11, 2019 at 9:11 PM Vladimir Sementsov-Ogievskiy
<vsementsov@virtuozzo.com> wrote:
>
> Add script to automatically commit tree-wide changes per-subsystem.

Oh interesting! I guess it could use a --help or a larger commit
message to explain a bit what it does (I imagine from the rest of the
series, but someone looking at the script without context may wonder;)

You could also fix some pep8/pylint/pycodestyle

>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>
> CC: Gerd Hoffmann <kraxel@redhat.com>
> CC: "Gonglei (Arei)" <arei.gonglei@huawei.com>
> CC: Eduardo Habkost <ehabkost@redhat.com>
> CC: Igor Mammedov <imammedo@redhat.com>
> CC: Laurent Vivier <lvivier@redhat.com>
> CC: Amit Shah <amit@kernel.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Max Reitz <mreitz@redhat.com>
> CC: John Snow <jsnow@redhat.com>
> CC: Ari Sundholm <ari@tuxera.com>
> CC: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> CC: Fam Zheng <fam@euphon.net>
> CC: Stefan Weil <sw@weilnetz.de>
> CC: Ronnie Sahlberg <ronniesahlberg@gmail.com>
> CC: Peter Lieven <pl@kamp.de>
> CC: Eric Blake <eblake@redhat.com>
> CC: "Denis V. Lunev" <den@openvz.org>
> CC: Markus Armbruster <armbru@redhat.com>
> CC: Alberto Garcia <berto@igalia.com>
> CC: Jason Dillaman <dillaman@redhat.com>
> CC: Wen Congyang <wencongyang2@huawei.com>
> CC: Xie Changlong <xiechanglong.d@gmail.com>
> CC: Liu Yuan <namei.unix@gmail.com>
> CC: "Richard W.M. Jones" <rjones@redhat.com>
> CC: Jeff Cody <codyprime@gmail.com>
> CC: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> CC: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
> CC: Richard Henderson <rth@twiddle.net>
> CC: Greg Kurz <groug@kaod.org>
> CC: "Michael S. Tsirkin" <mst@redhat.com>
> CC: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> CC: Beniamino Galvani <b.galvani@gmail.com>
> CC: Peter Maydell <peter.maydell@linaro.org>
> CC: "C=C3=A9dric Le Goater" <clg@kaod.org>
> CC: Andrew Jeffery <andrew@aj.id.au>
> CC: Joel Stanley <joel@jms.id.au>
> CC: Andrew Baumann <Andrew.Baumann@microsoft.com>
> CC: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
> CC: Antony Pavlov <antonynpavlov@gmail.com>
> CC: Jean-Christophe Dubois <jcd@tribudubois.net>
> CC: Peter Chubb <peter.chubb@nicta.com.au>
> CC: Subbaraya Sundeep <sundeep.lkml@gmail.com>
> CC: Eric Auger <eric.auger@redhat.com>
> CC: Alistair Francis <alistair@alistair23.me>
> CC: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
> CC: Stefano Stabellini <sstabellini@kernel.org>
> CC: Anthony Perard <anthony.perard@citrix.com>
> CC: Paul Durrant <paul@xen.org>
> CC: Paul Burton <pburton@wavecomp.com>
> CC: Aleksandar Rikalo <arikalo@wavecomp.com>
> CC: Chris Wulff <crwulff@gmail.com>
> CC: Marek Vasut <marex@denx.de>
> CC: David Gibson <david@gibson.dropbear.id.au>
> CC: Cornelia Huck <cohuck@redhat.com>
> CC: Halil Pasic <pasic@linux.ibm.com>
> CC: Christian Borntraeger <borntraeger@de.ibm.com>
> CC: "Herv=C3=A9 Poussineau" <hpoussin@reactos.org>
> CC: Xiao Guangrong <xiaoguangrong.eric@gmail.com>
> CC: Aurelien Jarno <aurelien@aurel32.net>
> CC: Aleksandar Markovic <amarkovic@wavecomp.com>
> CC: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> CC: Jason Wang <jasowang@redhat.com>
> CC: Laszlo Ersek <lersek@redhat.com>
> CC: Yuval Shaia <yuval.shaia@oracle.com>
> CC: Palmer Dabbelt <palmer@sifive.com>
> CC: Sagar Karandikar <sagark@eecs.berkeley.edu>
> CC: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> CC: David Hildenbrand <david@redhat.com>
> CC: Thomas Huth <thuth@redhat.com>
> CC: Eric Farman <farman@linux.ibm.com>
> CC: Matthew Rosato <mjrosato@linux.ibm.com>
> CC: Hannes Reinecke <hare@suse.com>
> CC: Michael Walle <michael@walle.cc>
> CC: Artyom Tarasenko <atar4qemu@gmail.com>
> CC: Stefan Berger <stefanb@linux.ibm.com>
> CC: Samuel Thibault <samuel.thibault@ens-lyon.org>
> CC: Alex Williamson <alex.williamson@redhat.com>
> CC: Tony Krowiak <akrowiak@linux.ibm.com>
> CC: Pierre Morel <pmorel@linux.ibm.com>
> CC: Michael Roth <mdroth@linux.vnet.ibm.com>
> CC: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
> CC: Juan Quintela <quintela@redhat.com>
> CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> CC: Luigi Rizzo <rizzo@iet.unipi.it>
> CC: Giuseppe Lettieri <g.lettieri@iet.unipi.it>
> CC: Vincenzo Maffione <v.maffione@gmail.com>
> CC: Jan Kiszka <jan.kiszka@siemens.com>
> CC: Anthony Green <green@moxielogic.com>
> CC: Stafford Horne <shorne@gmail.com>
> CC: Guan Xuetao <gxt@mprc.pku.edu.cn>
> CC: Max Filippov <jcmvbkbc@gmail.com>
> CC: qemu-block@nongnu.org
> CC: integration@gluster.org
> CC: sheepdog@lists.wpkg.org
> CC: qemu-arm@nongnu.org
> CC: xen-devel@lists.xenproject.org
> CC: qemu-ppc@nongnu.org
> CC: qemu-s390x@nongnu.org
> CC: qemu-riscv@nongnu.org
>
>  python/commit-per-subsystem.py | 204 +++++++++++++++++++++++++++++++++
>  1 file changed, 204 insertions(+)
>  create mode 100755 python/commit-per-subsystem.py
>
> diff --git a/python/commit-per-subsystem.py b/python/commit-per-subsystem=
.py
> new file mode 100755
> index 0000000000..2ccf84cb15
> --- /dev/null
> +++ b/python/commit-per-subsystem.py
> @@ -0,0 +1,204 @@
> +#!/usr/bin/env python3
> +#
> +# Copyright (c) 2019 Virtuozzo International GmbH
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
> +#
> +
> +import subprocess
> +import sys
> +import os
> +import glob
> +
> +
> +def git_add(pattern):
> +    subprocess.run(['git', 'add', pattern])
> +
> +
> +def git_commit(msg):
> +    subprocess.run(['git', 'commit', '-m', msg], capture_output=3DTrue)
> +
> +
> +def git_changed_files():
> +    ret =3D subprocess.check_output(['git', 'diff', '--name-only'], enco=
ding=3D'utf-8').split('\n')
> +    if ret[-1] =3D=3D '':
> +        del ret[-1]
> +    return ret
> +
> +
> +maintainers =3D sys.argv[1]
> +message =3D sys.argv[2].strip()
> +
> +subsystem =3D None
> +
> +remap =3D {
> +    'Block layer core': 'block',
> +    'Block Jobs': 'block',
> +    'Dirty Bitmaps': 'block',
> +    'Block QAPI, monitor, command line': 'block',
> +    'Block I/O path': 'block',
> +    'Throttling infrastructure': 'block',
> +    'Architecture support': 's390x',
> +    'Guest CPU Cores (KVM)': 'kvm',
> +    'Guest CPU Cores (Xen)': 'xen',
> +    'Guest CPU cores (TCG)': 'tcg',
> +    'Network Block Device (NBD)': 'nbd',
> +    'Parallel NOR Flash devices': 'pflash',
> +    'Firmware configuration (fw_cfg)': 'fw_cfg',
> +    'Block SCSI subsystem': 'scsi',
> +    'Network device backends': 'net',
> +    'Netmap network backend': 'net',
> +    'Host Memory Backends': 'hostmem',
> +    'Cryptodev Backends': 'cryptodev',
> +    'QEMU Guest Agent': 'qga',
> +    'COLO Framework': 'colo',
> +    'Command line option argument parsing': 'cmdline',
> +    'Character device backends': 'chardev'
> +}
> +
> +
> +class Maintainers:
> +    def add(self, subsystem, path, mapper, mapper_name, glob_count=3D1):
> +        if subsystem in remap:
> +            subsystem =3D remap[subsystem]
> +        if subsystem not in self.subsystems:
> +            self.subsystems.append(subsystem)
> +
> +        if path[-1] =3D=3D '/':
> +            path =3D path[:-1]
> +
> +        if path in mapper:
> +            if mapper[path][1] =3D=3D glob_count:
> +                print('Warning: "{}" both in "{}" and "{}" in {} mapper =
with '
> +                      'same glob-count=3D{}. {} ignored for this path.'.=
format(
> +                        path, mapper[path][0], subsystem, mapper_name, g=
lob_count,
> +                          subsystem))
> +                return
> +            if mapper[path][1] < glob_count:
> +                # silently ignore worse match
> +                return
> +
> +        mapper[path] =3D (subsystem, glob_count)
> +
> +    def __init__(self, file_name):
> +        self.map_file =3D {}
> +        self.map_glob_file =3D {}
> +        self.map_dir =3D {}
> +        self.map_glob_dir =3D {}
> +        self.map_unmaintained_dir =3D {
> +            'python': ('python', 1),
> +            'hw/misc': ('misc', 1)
> +        }
> +        self.subsystems =3D ['python', 'misc']
> +        subsystem =3D None
> +
> +        with open(file_name) as f:
> +            mode2 =3D False
> +            prevline =3D ''
> +            for line in f:
> +                line =3D line.rstrip()
> +                if not line:
> +                    continue
> +                if len(line) >=3D 2 and line[1] =3D=3D ':':
> +                    if line[0] =3D=3D 'F':
> +                        fname =3D line[3:]
> +                        if fname in ['*', '*/']:
> +                            continue
> +                        if os.path.isfile(fname):
> +                            self.add(subsystem, fname, self.map_file, 'f=
ile')
> +                        elif os.path.isdir(fname):
> +                            self.add(subsystem, fname, self.map_dir, 'di=
r')
> +                        else:
> +                            paths =3D glob.glob(fname)
> +                            if not paths:
> +                                print('Warning: nothing corresponds to "=
{}"'.format(fname))
> +                                continue
> +
> +                            n =3D len(paths)
> +                            for f in paths:
> +                                if os.path.isfile(f):
> +                                    self.add(subsystem, f, self.map_glob=
_file, 'glob-file', n)
> +                                else:
> +                                    assert os.path.isdir(f)
> +                                    self.add(subsystem, f, self.map_glob=
_dir, 'glob-dir', n)
> +                elif line[:3] =3D=3D '---':
> +                    subsystem =3D prevline
> +                    if subsystem =3D=3D 'Devices':
> +                        mode2 =3D True
> +                elif mode2:
> +                    subsystem =3D line
> +                prevline =3D line
> +
> +    def find_in_map_dir(self, file_name, mapper):
> +        while file_name !=3D '' and file_name not in mapper:
> +            file_name =3D os.path.dirname(file_name)
> +
> +        return None if file_name =3D=3D '' else mapper[file_name][0]
> +
> +    def find_in_map_file(self, file_name, mapper):
> +        if file_name in mapper:
> +            return mapper[file_name][0]
> +
> +    def find_subsystem(self, file_name):
> +        s =3D self.find_in_map_file(file_name, self.map_file)
> +        if s is not None:
> +            return s
> +
> +        s =3D self.find_in_map_file(file_name, self.map_glob_file)
> +        if s is not None:
> +            return s
> +
> +        s =3D self.find_in_map_dir(file_name, self.map_dir)
> +        if s is not None:
> +            return s
> +
> +        s =3D self.find_in_map_dir(file_name, self.map_glob_dir)
> +        if s is not None:
> +            return s
> +
> +        s =3D self.find_in_map_dir(file_name, self.map_unmaintained_dir)
> +        if s is not None:
> +            return s
> +
> +        self.subsystems.append(file_name)
> +        return file_name
> +
> +
> +def commit(subsystem):
> +    msg =3D subsystem
> +    if msg in remap:
> +        msg =3D remap[msg]
> +    msg +=3D ': ' + message
> +    git_commit(msg)
> +
> +mnt =3D Maintainers(maintainers)
> +res =3D {}
> +for f in git_changed_files():
> +    s =3D mnt.find_subsystem(f)
> +    if s in res:
> +        res[s].append(f)
> +    else:
> +        res[s] =3D [f]
> +
> +for s in mnt.subsystems:
> +    if s in res:
> +        print(s)
> +        for f in res[s]:
> +            print('  ', f)
> +
> +for s in mnt.subsystems:
> +    if s in res:
> +        for f in res[s]:
> +            git_add(f)
> +        commit(s)
> --
> 2.21.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

