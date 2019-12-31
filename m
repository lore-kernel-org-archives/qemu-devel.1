Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2DBC2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 10:52:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4258A206D9
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 10:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AAwNNqXz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4258A206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imF8Z-0006zD-9o
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 05:52:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38717)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1imF7r-0006G4-Uu
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 05:51:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1imF7o-0000dP-Tc
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 05:51:45 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51014
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1imF7o-0000an-NO
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 05:51:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577789504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1UAE0AtIez2HdWdyxJdb6ylgmz6+ahVBb7sXcCocAQk=;
 b=AAwNNqXzj7ZpYApJXJPFF0yQ3rUCEhghRbgkKCjhsUm42s0gsD6UmJCUipp2o/OCctsG7X
 JBFk86vGOI2CZdc6RKqDEyTSwhGuN8dCy4BBeNppgJg7iFqSnCgpborM1mpMZvj1fNwOSb
 wpS/roR01KBLd0aQ7eTWH7NEJbUyYQk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-Nx0XsU3JPFacJrQSRl54yg-1; Tue, 31 Dec 2019 05:51:40 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 476311005502;
 Tue, 31 Dec 2019 10:51:39 +0000 (UTC)
Received: from Igors-MacBook-Pro (ovpn-204-105.brq.redhat.com [10.40.204.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7B7B65C1C3;
 Tue, 31 Dec 2019 10:51:38 +0000 (UTC)
Date: Tue, 31 Dec 2019 11:51:35 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Eryu Guan <eguan@linux.alibaba.com>
Subject: Re: [BUG qemu 4.0] segfault when unplugging virtio-blk-pci device
Message-ID: <20191231115136.7b967604@Igors-MacBook-Pro>
In-Reply-To: <20191231103434.GA41863@e18g06458.et15sqa>
References: <20191231103434.GA41863@e18g06458.et15sqa>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: Nx0XsU3JPFacJrQSRl54yg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 31 Dec 2019 18:34:34 +0800
Eryu Guan <eguan@linux.alibaba.com> wrote:

> Hi,
>=20
> I'm using qemu 4.0 and hit segfault when tearing down kata sandbox, I
> think it's because io completion hits use-after-free when device is
> already gone. Is this a known bug that has been fixed? (I went through
> the git log but didn't find anything obvious).
>=20
> gdb backtrace is:
>=20
> Core was generated by `/usr/local/libexec/qemu-kvm -name sandbox-5b8df8c6=
c6901c3c0a9b02879be10fe8d69d6'.
> Program terminated with signal 11, Segmentation fault.
> #0 object_get_class (obj=3Dobj@entry=3D0x0) at /usr/src/debug/qemu-4.0/qo=
m/object.c:903
> 903        return obj->class;
> (gdb) bt
> #0  object_get_class (obj=3Dobj@entry=3D0x0) at /usr/src/debug/qemu-4.0/q=
om/object.c:903
> #1 =C2=A00x0000558a2c009e9b in virtio_notify_vector (vdev=3D0x558a2e7751d=
0,
> =C2=A0 =C2=A0 vector=3D<optimized out>) at /usr/src/debug/qemu-4.0/hw/vir=
tio/virtio.c:1118
> #2 =C2=A00x0000558a2bfdcb1e in virtio_blk_discard_write_zeroes_complete (
> =C2=A0 =C2=A0 opaque=3D0x558a2f2fd420, ret=3D0)
> =C2=A0 =C2=A0 at /usr/src/debug/qemu-4.0/hw/block/virtio-blk.c:186
> #3 =C2=A00x0000558a2c261c7e in blk_aio_complete (acb=3D0x558a2eed7420)
> =C2=A0 =C2=A0 at /usr/src/debug/qemu-4.0/block/block-backend.c:1305
> #4 =C2=A00x0000558a2c3031db in coroutine_trampoline (i0=3D<optimized out>=
,
> =C2=A0 =C2=A0 i1=3D<optimized out>) at /usr/src/debug/qemu-4.0/util/corou=
tine-ucontext.c:116
> #5 =C2=A00x00007f45b2f8b080 in ?? () from /lib64/libc.so.6
> #6 =C2=A00x00007fff9ed75780 in ?? ()
> #7 =C2=A00x0000000000000000 in ?? ()
>=20
> It seems like qemu was completing a discard/write_zero request, but
> parent BusState was already freed & set to NULL.
>=20
> Do we need to drain all pending request before unrealizing virtio-blk
> device? Like the following patch proposed?
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg02945.html
>=20
> If more info is needed, please let me know.

may be this will help: https://patchwork.kernel.org/patch/11213047/


>=20
> Thanks,
> Eryu
>=20


