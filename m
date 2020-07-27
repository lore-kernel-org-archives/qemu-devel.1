Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F792C433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:46:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF99320719
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hos18RAC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF99320719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k04Oc-0005MY-8t
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 10:46:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1k04NW-0004SW-8I
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:45:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58187
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1k04NT-0002q2-VA
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:45:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595861119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tDd1qbIcbNo65TbypPKRW6HkRE45KXTDVjtDggjZ/5M=;
 b=Hos18RACvTVwZZ1i01LzMUS/376r8Dbjgpw2uX+0SkEqEIN5TauGCpT6y+ZjYocdWFZha5
 IkPZWYryaBFpXOs0Rk4kupElkO/P9jfni4dS0er8XFlXAIE/RgXD5JDmBfgbTi6TIi7IaQ
 ZBpk9Qhylsgb8pXrWQwEXv12xBErkjM=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-CPkkckODMPKfKZbHC767lw-1; Mon, 27 Jul 2020 10:45:16 -0400
X-MC-Unique: CPkkckODMPKfKZbHC767lw-1
Received: by mail-oi1-f200.google.com with SMTP id y84so8828217oia.19
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 07:45:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=tDd1qbIcbNo65TbypPKRW6HkRE45KXTDVjtDggjZ/5M=;
 b=E8hMUyNsG6YJ44Fg4xXtXv6pwNv9xwo6AirTAfGSdN7KBMZln+IWRBhmjvwLMz9GDf
 xt+/0hklX0EjOLpxueaQRbcu3/2cfFhjPlQePc1WyYjkpeErOixC4pUH4AllqlnN/neP
 c9o31ZEIB7eCkxG1hy77IAXjIDLMBsd0nS71IjlBGksCLZvfNms8SZ6XKGSFyQSoM71P
 5P4q4olUkuoGXFmPMqpwyNaElW15QAfcgIyVaKbBkPC7k0cCp6li3Mg6Ls+K3NaR4mDB
 ks4Jp4aoJMl1t/oZvdbLv4pGz4ke7+V5YZvNRHtJttIXnl85WiG8pjpkv70Dpy4HW0qL
 f7jQ==
X-Gm-Message-State: AOAM533ZH3D5U6t3fU8GHJGPK0gSRK28M2ttDRg+anTugcdSiU8hJkP0
 OU07ygFV0RDoa1gshvTnyFQ/ozHVx92OcTfaKyXVCMHUq1F0WWb2FY5XX0lOGUf8ikG++J95PwQ
 3kmbpWORn10tqsjJ/bzLo5EoGgoC1wCg=
X-Received: by 2002:a05:6830:309b:: with SMTP id
 f27mr21255892ots.315.1595861115961; 
 Mon, 27 Jul 2020 07:45:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCJgktQ/avl+oQ4HlFI7x1lTN+hH6fcATNCbvOS5GfgWnjyARFlAgEUfsoTL6XJyoc6XGBJoE90Gf+hUrP/io=
X-Received: by 2002:a05:6830:309b:: with SMTP id
 f27mr21255867ots.315.1595861115650; 
 Mon, 27 Jul 2020 07:45:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200726152532.256261-1-nsoffer@redhat.com>
 <20200726152532.256261-3-nsoffer@redhat.com>
 <b0e61f48-d272-0aa5-3698-5d17a1de0774@redhat.com>
In-Reply-To: <b0e61f48-d272-0aa5-3698-5d17a1de0774@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Mon, 27 Jul 2020 17:44:59 +0300
Message-ID: <CAMRbyyt_XZeGBuLfuC_HHF1CfkJHNB40fAtujFSBHeGWU=4kwg@mail.gmail.com>
Subject: Re: [PATCH 2/2] qemu-iotests: Test convert to qcow2 compressed to NBD
To: Max Reitz <mreitz@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=nsoffer@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=nsoffer@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:44:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 Nir Soffer <nirsof@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 27, 2020 at 1:05 PM Max Reitz <mreitz@redhat.com> wrote:
>
> On 26.07.20 17:25, Nir Soffer wrote:
> > Add test for "qemu-img convert -O qcow2 -c" to NBD target. The use case
> > is writing compressed disk content to OVA archive.
> >
> > Signed-off-by: Nir Soffer <nsoffer@redhat.com>
> > ---
> >  tests/qemu-iotests/302     | 83 ++++++++++++++++++++++++++++++++++++++
> >  tests/qemu-iotests/302.out | 27 +++++++++++++
> >  tests/qemu-iotests/group   |  1 +
> >  3 files changed, 111 insertions(+)
> >  create mode 100755 tests/qemu-iotests/302
> >  create mode 100644 tests/qemu-iotests/302.out
> >
> > diff --git a/tests/qemu-iotests/302 b/tests/qemu-iotests/302
> > new file mode 100755
> > index 0000000000..cefde1f7cf
> > --- /dev/null
> > +++ b/tests/qemu-iotests/302
> > @@ -0,0 +1,83 @@
> > +#!/usr/bin/env python3
> > +#
> > +# Tests conveting qcow2 compressed to NBD
>
> *converting
>
> > +#
> > +# Copyright (c) 2020 Nir Soffer <nirsof@gmail.com>
> > +#
> > +# This program is free software; you can redistribute it and/or modify
> > +# it under the terms of the GNU General Public License as published by
> > +# the Free Software Foundation; either version 2 of the License, or
> > +# (at your option) any later version.
> > +#
> > +# This program is distributed in the hope that it will be useful,
> > +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> > +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > +# GNU General Public License for more details.
> > +#
> > +# You should have received a copy of the GNU General Public License
> > +# along with this program.  If not, see <http://www.gnu.org/licenses/>=
.
> > +#
> > +# owner=3Dnirsof@gmail.com
> > +
> > +import json
> > +import iotests
> > +
> > +from iotests import (
> > +    file_path,
> > +    qemu_img,
> > +    qemu_img_create,
> > +    qemu_img_log,
> > +    qemu_img_pipe,
> > +    qemu_io,
> > +    qemu_nbd,
> > +)
> > +
> > +iotests.script_initialize(supported_fmts=3D["qcow2"])
> > +
> > +# Create source disk, format does not matter.
> > +src_disk =3D file_path("disk.img")
> > +qemu_img_create("-f", "raw", src_disk, "10m")
>
> If the format doesn=E2=80=99t matter, why not just use qcow2 and so put
> iotests.imgfmt here?  (And everywhere else where you now have -f raw.)

I tried to use the simplest setup that is less likely to break, but
thinking about
CI environments with strange storage, maybe using qcow2 source disk will be
more robust.

> > +qemu_io("-f", "raw", "-c", "write 1m 64K", src_disk)
>
> (Except I think qemu_io already has -f qcow2 in its arguments by
> default, so specifying the format wouldn=E2=80=99t even be necessary here=
.)
>
> > +# The use case is writing qcow2 image directly into a tar file. Code t=
o create
> > +# real tar file not included.
> > +#
> > +# offset    content
> > +# -------------------------------
> > +#      0    first memebr header
>
> *member
>
> > +#    512    first member data
> > +#   1024    second memeber header
>
> *member
>
> > +#   1536    second member data
> > +
> > +tar_file =3D file_path("test.tar")
> > +out =3D qemu_img_pipe("measure", "-O", "qcow2", "--output", "json", sr=
c_disk)
> > +measure =3D json.loads(out)
> > +qemu_img_create("-f", "raw", tar_file, str(measure["required"]))
>
> Should this be measure["required"] + 1536?
>
> > +
> > +nbd_sock =3D file_path("nbd-sock", base_dir=3Diotests.sock_dir)
> > +nbd_uri =3D "nbd+unix:///exp?socket=3D" + nbd_sock
> > +
> > +# Use raw format to allow creating qcow2 directy into tar file.
> > +qemu_nbd(
> > +    "--socket", nbd_sock,
> > +    "--persistent",
> > +    "--export-name", "exp",
> > +    "--format", "raw",
> > +    "--offset", "1536",
> > +    tar_file)
> > +
> > +iotests.log("=3D=3D=3D Target image info =3D=3D=3D")
> > +qemu_img_log("info", nbd_uri)
> > +
> > +# Write image into the tar file. In a real applicatio we would write a=
 tar
>
> *application
>
> > +# entry after writing the image.
> > +qemu_img("convert", "-f", "raw", "-O", "qcow2", "-c", src_disk, nbd_ur=
i)
> > +
> > +iotests.log("=3D=3D=3D Converted image info =3D=3D=3D")
> > +qemu_img_log("info", nbd_uri)
> > +
> > +iotests.log("=3D=3D=3D Converted image check =3D=3D=3D")
> > +qemu_img_log("check", nbd_uri)
> > +
> > +iotests.log("=3D=3D=3D Comparing to source disk =3D=3D=3D")
> > +qemu_img_log("compare", src_disk, nbd_uri)
> > diff --git a/tests/qemu-iotests/302.out b/tests/qemu-iotests/302.out
> > new file mode 100644
> > index 0000000000..babef3d574
> > --- /dev/null
> > +++ b/tests/qemu-iotests/302.out
> > @@ -0,0 +1,27 @@
> > +=3D=3D=3D Target image info =3D=3D=3D
> > +image: nbd+unix:///exp?socket=3DSOCK_DIR/PID-nbd-sock
> > +file format: raw
> > +virtual size: 446 KiB (457216 bytes)
> > +disk size: unavailable
> > +
> > +=3D=3D=3D Converted image info =3D=3D=3D
> > +image: nbd+unix:///exp?socket=3DSOCK_DIR/PID-nbd-sock
> > +file format: qcow2
> > +virtual size: 10 MiB (10485760 bytes)
> > +disk size: unavailable
> > +cluster_size: 65536
> > +Format specific information:
> > +    compat: 1.1
> > +    compression type: zlib
> > +    lazy refcounts: false
> > +    refcount bits: 16
> > +    corrupt: false
> > +
> > +=3D=3D=3D Converted image check =3D=3D=3D
> > +No errors were found on the image.
> > +1/160 =3D 0.62% allocated, 100.00% fragmented, 100.00% compressed clus=
ters
> > +Image end offset: 393216
>
> I hope none of this is fs-dependant.  (I don=E2=80=99t think it is, but w=
ho
> knows.  I suppose we=E2=80=99ll find out.)

I don't think the check would be affected, but maybe the compare step
can use the strict
option if we change to qcow2 source disk.

>
> Max
>
> > +=3D=3D=3D Comparing to source disk =3D=3D=3D
> > +Images are identical.
> > +
> > diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
> > index 1d0252e1f0..1e1cb27bc8 100644
> > --- a/tests/qemu-iotests/group
> > +++ b/tests/qemu-iotests/group
> > @@ -308,3 +308,4 @@
> >  297 meta
> >  299 auto quick
> >  301 backing quick
> > +302 quick
> >
>
>


