Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF9BC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 10:53:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 192BE206BB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 10:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZjonAZmQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 192BE206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iU7K2-0007kQ-CG
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 05:53:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53303)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iU7JJ-0007Fi-UD
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 05:52:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iU7JG-0000Nb-UO
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 05:52:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59951
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iU7JG-0000NM-MZ
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 05:52:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573469557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6PBIdcPfNqqcHFkfwIEe+m8/cIuqiHvjlyyKR98ZeX8=;
 b=ZjonAZmQLvKatYrdO/ZDfEh/AtXYY0hQBKe+6qeF7Dwo889VoDKMEp9laOL3PPY3a7rxcF
 3SrjQM3TkKFRj20apK8gXrYke3HSVIGKW8Vo6XM99YwEQaaZu907Pl7R9t7x1Z92GlxSNZ
 bpSAlFO6zZbp2eTtV60tr7iJdVEL7ys=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-u-_TIRNNO3-scXCEEaI-JQ-1; Mon, 11 Nov 2019 05:52:36 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23838107ACC4
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2019 10:52:36 +0000 (UTC)
Received: from gondolin (ovpn-117-4.ams2.redhat.com [10.36.117.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C135F60FCC;
 Mon, 11 Nov 2019 10:52:32 +0000 (UTC)
Date: Mon, 11 Nov 2019 11:52:30 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Michal Privoznik <mprivozn@redhat.com>
Subject: Re: [PATCH 1/2] hw/vfio/pci: Fix double free of migration_blocker
Message-ID: <20191111115230.4cc1bd6b.cohuck@redhat.com>
In-Reply-To: <c96b132607f4314ce1efc1af995be300f21ecc04.1573468531.git.mprivozn@redhat.com>
References: <cover.1573468531.git.mprivozn@redhat.com>
 <c96b132607f4314ce1efc1af995be300f21ecc04.1573468531.git.mprivozn@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: u-_TIRNNO3-scXCEEaI-JQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
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
Cc: alex.williamson@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 11 Nov 2019 11:37:41 +0100
Michal Privoznik <mprivozn@redhat.com> wrote:

> When user tries to hotplug a VFIO device, but the operation fails
> somewhere in the middle (in my testing it failed because of
> RLIMIT_MEMLOCK forbidding more memory allocation), then a double
> free occurs. In vfio_realize() the vdev->migration_blocker is
> allocated, then something goes wrong which causes control to jump
> onto 'error' label where the error is freed. But the pointer is
> left pointing to invalid memory. Later, when
> vfio_instance_finalize() is called, the memory is freed again.
>=20
> In my testing the second hunk was sufficient to fix the bug, but
> I figured the first hunk doesn't hurt either.

Better safe than sorry, I guess.

>=20
> =3D=3D169952=3D=3D Invalid read of size 8
> =3D=3D169952=3D=3D    at 0xA47DCD: error_free (error.c:266)
> =3D=3D169952=3D=3D    by 0x4E0A18: vfio_instance_finalize (pci.c:3040)
> =3D=3D169952=3D=3D    by 0x8DF74C: object_deinit (object.c:606)
> =3D=3D169952=3D=3D    by 0x8DF7BE: object_finalize (object.c:620)
> =3D=3D169952=3D=3D    by 0x8E0757: object_unref (object.c:1074)
> =3D=3D169952=3D=3D    by 0x45079C: memory_region_unref (memory.c:1779)
> =3D=3D169952=3D=3D    by 0x45376B: do_address_space_destroy (memory.c:279=
3)
> =3D=3D169952=3D=3D    by 0xA5C600: call_rcu_thread (rcu.c:283)
> =3D=3D169952=3D=3D    by 0xA427CB: qemu_thread_start (qemu-thread-posix.c=
:519)
> =3D=3D169952=3D=3D    by 0x80A8457: start_thread (in /lib64/libpthread-2.=
29.so)
> =3D=3D169952=3D=3D    by 0x81C96EE: clone (in /lib64/libc-2.29.so)
> =3D=3D169952=3D=3D  Address 0x143137e0 is 0 bytes inside a block of size =
48 free'd
> =3D=3D169952=3D=3D    at 0x4A342BB: free (vg_replace_malloc.c:530)
> =3D=3D169952=3D=3D    by 0xA47E05: error_free (error.c:270)
> =3D=3D169952=3D=3D    by 0x4E0945: vfio_realize (pci.c:3025)
> =3D=3D169952=3D=3D    by 0x76A4FF: pci_qdev_realize (pci.c:2099)
> =3D=3D169952=3D=3D    by 0x689B9A: device_set_realized (qdev.c:876)
> =3D=3D169952=3D=3D    by 0x8E2C80: property_set_bool (object.c:2080)
> =3D=3D169952=3D=3D    by 0x8E0EF6: object_property_set (object.c:1272)
> =3D=3D169952=3D=3D    by 0x8E3FC8: object_property_set_qobject (qom-qobje=
ct.c:26)
> =3D=3D169952=3D=3D    by 0x8E11DB: object_property_set_bool (object.c:133=
8)
> =3D=3D169952=3D=3D    by 0x5E7BDD: qdev_device_add (qdev-monitor.c:673)
> =3D=3D169952=3D=3D    by 0x5E81E5: qmp_device_add (qdev-monitor.c:798)
> =3D=3D169952=3D=3D    by 0x9E18A8: do_qmp_dispatch (qmp-dispatch.c:132)
> =3D=3D169952=3D=3D  Block was alloc'd at
> =3D=3D169952=3D=3D    at 0x4A35476: calloc (vg_replace_malloc.c:752)
> =3D=3D169952=3D=3D    by 0x51B1158: g_malloc0 (in /usr/lib64/libglib-2.0.=
so.0.6000.6)
> =3D=3D169952=3D=3D    by 0xA47357: error_setv (error.c:61)
> =3D=3D169952=3D=3D    by 0xA475D9: error_setg_internal (error.c:97)
> =3D=3D169952=3D=3D    by 0x4DF8C2: vfio_realize (pci.c:2737)
> =3D=3D169952=3D=3D    by 0x76A4FF: pci_qdev_realize (pci.c:2099)
> =3D=3D169952=3D=3D    by 0x689B9A: device_set_realized (qdev.c:876)
> =3D=3D169952=3D=3D    by 0x8E2C80: property_set_bool (object.c:2080)
> =3D=3D169952=3D=3D    by 0x8E0EF6: object_property_set (object.c:1272)
> =3D=3D169952=3D=3D    by 0x8E3FC8: object_property_set_qobject (qom-qobje=
ct.c:26)
> =3D=3D169952=3D=3D    by 0x8E11DB: object_property_set_bool (object.c:133=
8)
> =3D=3D169952=3D=3D    by 0x5E7BDD: qdev_device_add (qdev-monitor.c:673)
>=20
> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>

Fixes: f045a0104c8c ("vfio: unplug failover primary device before migration=
")

> ---
>  hw/vfio/pci.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


