Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34117C33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 07:48:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECFC724125
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 07:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MH7u+Q1t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECFC724125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuXEN-0005Cn-5N
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 02:48:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45419)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iuXDD-0004kk-Ma
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:47:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iuXDB-0002Jo-Ub
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:47:35 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50073
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iuXDB-0002J3-Eq
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:47:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579765652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bHlkv35AeN8GtQN2RAEYkWnO5WFBFl05Nb9komQSiu0=;
 b=MH7u+Q1t1rwsyaXixLUc52KtJgUBoPzoUcc2IG4kaZTSbO+dKF8MP1wYJvlSRxpPI84Hqw
 VYMYO09/RAOmYkLXgY1n9Dd0n1xf1+Qj5IhEHowyu6p+tJfq1/ED0wvfCgxpj6+MKN1oKR
 uiMcEDcQNT8hAd5VDpmBempFgWgdw0c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-ylV_X1wwPEW4iWTd6z1fvA-1; Thu, 23 Jan 2020 02:47:30 -0500
Received: by mail-wm1-f69.google.com with SMTP id e12so339766wma.7
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 23:47:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=cawcREq5RwTcoSWnPCo0c5ae9EhqWgrfO15v8URR0jo=;
 b=feQOcrmqvluiWFarh9piEc3D4Q5c60UdISiEXML866scfZ/O5o+kqW64NSz/aEVmAc
 3iDiNQAVo+yx1+/ad4cNwW3Zp7/4H0yzu4Ol9I+VzTDBkA8ybn2yd5BngMLXhbj19siq
 mf7PPOZSFkglQLt9SKtOdjTZUkl+18lyXAoUf9AtpcN0XwKZtE8EZnDOt2YDALYp9eSx
 WaOsbXqceEoWAyi1Bg8piSWP3RhsVjtUaDbYsn6vHb66M8hpeS+Cm0Zo3zdkSIGbfNcT
 dVQ7+uCD6Wh7cuVLXoN0TTUpc29lvETfRoKcPDbKOs6VnhyVxgHlY00TgqGitF62RZbx
 eD9w==
X-Gm-Message-State: APjAAAXIfBmOY4Et2LiXGgcql5wwMDBEwAyiCT1AfqWuIqdRfjCqkuJV
 k7dEwAuYk31tKk9NA7q/FGOf13RCetPC+o7T4A7mWakahe8goeDHz+IHhMTXyATCjwEAE8ReuCe
 I2vkhzan/3usQ/L0=
X-Received: by 2002:adf:a746:: with SMTP id e6mr15928262wrd.329.1579765648749; 
 Wed, 22 Jan 2020 23:47:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqywwrbzyxvJMk4XZOiNVFH0k6dHyVEmpG1cWxqqff34vOTjYQHSY3Zp7lFBQdho7JU2wM8Aaw==
X-Received: by 2002:adf:a746:: with SMTP id e6mr15928222wrd.329.1579765648402; 
 Wed, 22 Jan 2020 23:47:28 -0800 (PST)
Received: from redhat.com (bzq-79-176-0-156.red.bezeqint.net. [79.176.0.156])
 by smtp.gmail.com with ESMTPSA id
 q11sm1963325wrp.24.2020.01.22.23.47.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 23:47:27 -0800 (PST)
Date: Thu, 23 Jan 2020 02:47:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PULL v3 00/18] virtio, pc: fixes, features
Message-ID: <20200123024708-mutt-send-email-mst@kernel.org>
References: <20200123070913.626488-1-mst@redhat.com>
 <157976553234.12545.16551531339287540211@f6d1ed32ca6b>
MIME-Version: 1.0
In-Reply-To: <157976553234.12545.16551531339287540211@f6d1ed32ca6b>
X-MC-Unique: ylV_X1wwPEW4iWTd6z1fvA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 22, 2020 at 11:45:33PM -0800, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200123070913.626488-1-mst@redhat.=
com/
>=20
>=20
>=20
> Hi,
>=20
> This series seems to have some coding style problems.

yes but they are fixed by a follow up patch :)

> See output below for
> more information:
>=20
> Type: series
> Message-id: 20200123070913.626488-1-mst@redhat.com
> Subject: [PULL v3 00/18] virtio, pc: fixes, features
>=20
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> git rev-parse base > /dev/null || exit 0
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> git config --local diff.algorithm histogram
> ./scripts/checkpatch.pl --mailback base..
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>=20
> Switched to a new branch 'test'
> 2b8191c vhost: coding style fix
> 7bb1f74 i386:acpi: Remove _HID from the SMBus ACPI entry
> 5d5ae0b vhost: Only align sections for vhost-user
> 2fe690d vhost: Add names to section rounded warning
> 85f2aa9 vhost-vsock: delete vqs in vhost_vsock_unrealize to avoid memleak=
s
> ae724d7 virtio-scsi: convert to new virtio_delete_queue
> 32a8d7a virtio-scsi: delete vqs in unrealize to avoid memleaks
> ce15ad4 virtio-9p-device: convert to new virtio_delete_queue
> 3bdf076 virtio-9p-device: fix memleak in virtio_9p_device_unrealize
> 01fb3bc bios-tables-test: document expected file update
> 021497c acpi: cpuhp: add CPHP_GET_CPU_ID_CMD command
> 8df7461 acpi: cpuhp: spec: add typical usecases
> f37ff6b acpi: cpuhp: introduce 'Command data 2' field
> 9c2e2a3 acpi: cpuhp: spec: clarify store into 'Command data' when 'Comman=
d field' =3D=3D 0
> 31632fb acpi: cpuhp: spec: fix 'Command data' description
> 8833b70 acpi: cpuhp: spec: clarify 'CPU selector' register usage and endi=
anness
> 59529c2 tests: q35: MCH: add default SMBASE SMRAM lock test
> ab4ab8f q35: implement 128K SMRAM at default SMBASE address
>=20
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> 1/18 Checking commit ab4ab8fed8c2 (q35: implement 128K SMRAM at default S=
MBASE address)
> 2/18 Checking commit 59529c21dc20 (tests: q35: MCH: add default SMBASE SM=
RAM lock test)
> 3/18 Checking commit 8833b70f38a3 (acpi: cpuhp: spec: clarify 'CPU select=
or' register usage and endianness)
> 4/18 Checking commit 31632fb04976 (acpi: cpuhp: spec: fix 'Command data' =
description)
> 5/18 Checking commit 9c2e2a3c55cf (acpi: cpuhp: spec: clarify store into =
'Command data' when 'Command field' =3D=3D 0)
> 6/18 Checking commit f37ff6b0328f (acpi: cpuhp: introduce 'Command data 2=
' field)
> 7/18 Checking commit 8df7461f8e9c (acpi: cpuhp: spec: add typical usecase=
s)
> 8/18 Checking commit 021497cfae81 (acpi: cpuhp: add CPHP_GET_CPU_ID_CMD c=
ommand)
> 9/18 Checking commit 01fb3bc40a44 (bios-tables-test: document expected fi=
le update)
> WARNING: line over 80 characters
> #23: FILE: tests/qtest/bios-tables-test.c:20:
> + * Contributor or ACPI Maintainer (steps 4-7 need to be redone to resolv=
e conflicts
>=20
> total: 0 errors, 1 warnings, 38 lines checked
>=20
> Patch 9/18 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 10/18 Checking commit 3bdf076c6da1 (virtio-9p-device: fix memleak in virt=
io_9p_device_unrealize)
> 11/18 Checking commit ce15ad428cde (virtio-9p-device: convert to new virt=
io_delete_queue)
> 12/18 Checking commit 32a8d7a0b553 (virtio-scsi: delete vqs in unrealize =
to avoid memleaks)
> 13/18 Checking commit ae724d76b8ed (virtio-scsi: convert to new virtio_de=
lete_queue)
> 14/18 Checking commit 85f2aa9f8aa0 (vhost-vsock: delete vqs in vhost_vsoc=
k_unrealize to avoid memleaks)
> 15/18 Checking commit 2fe690da39c7 (vhost: Add names to section rounded w=
arning)
> 16/18 Checking commit 5d5ae0b9e061 (vhost: Only align sections for vhost-=
user)
> ERROR: trailing whitespace
> #49: FILE: hw/virtio/vhost.c:554:
> +    if (dev->vhost_ops->backend_type =3D=3D VHOST_BACKEND_TYPE_USER) {  =
 $
>=20
> WARNING: line over 80 characters
> #64: FILE: hw/virtio/vhost.c:569:
> +        trace_vhost_region_add_section_aligned(section->mr->name, mrs_gp=
a, mrs_size,
>=20
> total: 1 errors, 1 warnings, 43 lines checked
>=20
> Patch 16/18 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>=20
> 17/18 Checking commit 7bb1f74b40e9 (i386:acpi: Remove _HID from the SMBus=
 ACPI entry)
> 18/18 Checking commit 2b8191c490a6 (vhost: coding style fix)
> =3D=3D=3D OUTPUT END =3D=3D=3D
>=20
> Test command exited with code: 1
>=20
>=20
> The full log is available at
> http://patchew.org/logs/20200123070913.626488-1-mst@redhat.com/testing.ch=
eckpatch/?type=3Dmessage.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com


