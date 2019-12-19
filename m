Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701EDC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 15:15:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AC95206EC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 15:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iCd1IIc2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AC95206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihxW6-00006c-60
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 10:15:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47652)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ihxTe-00058R-P3
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 10:12:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ihxTb-0005pP-OC
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 10:12:34 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42331
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ihxTZ-0005oa-QE
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 10:12:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576768347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6LCoPZ0ez041qk/fHC9tNbysyUQKyQN+XnRJpzHZTCw=;
 b=iCd1IIc2cPpAoUOSBZ4SjmAq3Ic99VTbP8u68lGF28VhqRsCcPLGNt9Y248eANQhpEGyz4
 hS2ZLhISvLNkL1hsdpg4MaTcgCjpL/3Rh4fh/pVaZkV3ca5PcIHKQFSknAz3LdMgwaM13h
 zKfcVSXfHm1Qflz0MB/3WLAGZeh4jPY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-7iPn_yUEP3mceYi19jwL8w-1; Thu, 19 Dec 2019 10:12:22 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F22058D8A38;
 Thu, 19 Dec 2019 15:12:20 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-53.ams2.redhat.com [10.36.117.53])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 638AC10013A7;
 Thu, 19 Dec 2019 15:12:10 +0000 (UTC)
Date: Thu, 19 Dec 2019 16:12:03 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Alexander Popov <alex.popov@linux.com>
Subject: Re: [PATCH v2 1/2] tests/ide-test: Create a single unit-test
 covering more PRDT cases
Message-ID: <20191219151203.GM5230@linux.fritz.box>
References: <20191216181405.462292-1-alex.popov@linux.com>
MIME-Version: 1.0
In-Reply-To: <20191216181405.462292-1-alex.popov@linux.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 7iPn_yUEP3mceYi19jwL8w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Andrea Arcangeli <aarcange@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, sstabellini@kernel.org,
 pmatouse@redhat.com, mdroth@linux.vnet.ibm.com, qemu-block@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, Kashyap Chamarthy <kashyap.cv@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, pjp@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 16.12.2019 um 19:14 hat Alexander Popov geschrieben:
> Fuzzing the Linux kernel with syzkaller allowed to find how to crash qemu
> using a special SCSI_IOCTL_SEND_COMMAND. It hits the assertion in
> ide_dma_cb() introduced in the commit a718978ed58a in July 2015.
> Currently this bug is not reproduced by the unit tests.
>=20
> Let's improve the ide-test to cover more PRDT cases including one
> that causes this particular qemu crash.
>=20
> The test is developed according to the Programming Interface for
> Bus Master IDE Controller (Revision 1.0 5/16/94).
>=20
> Signed-off-by: Alexander Popov <alex.popov@linux.com>

Looks mostly good to me, but I have a few comments.

First of all, the patch order needs to be reversed to keep the tree
bisectable (first fix the bug, then test that it's fixed).

> +/*
> + * This test is developed according to the Programming Interface for
> + * Bus Master IDE Controller (Revision 1.0 5/16/94)
> + */
> +static void test_bmdma_various_prdts(void)
>  {
> -    QTestState *qts;
> -    QPCIDevice *dev;
> -    QPCIBar bmdma_bar, ide_bar;
> -    uint8_t status;
> -
> -    PrdtEntry prdt[] =3D {
> -        {
> -            .addr =3D 0,
> -            .size =3D cpu_to_le32(0x1000 | PRDT_EOT),
> -        },
> -    };
> -
> -    qts =3D test_bmdma_setup();
> -
> -    dev =3D get_pci_device(qts, &bmdma_bar, &ide_bar);
> -
> -    /* Normal request */
> -    status =3D send_dma_request(qts, CMD_READ_DMA, 0, 1,
> -                              prdt, ARRAY_SIZE(prdt), NULL);
> -    g_assert_cmphex(status, =3D=3D, BM_STS_ACTIVE | BM_STS_INTR);
> -    assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF | ERR);
> +    uint32_t size =3D 0;
> +    uint32_t prd_size =3D 0;
> +    int req_sectors =3D 0;
> +    uint32_t req_size =3D 0;
> +    uint8_t s1 =3D 0, s2 =3D 0;
> +
> +    for (size =3D 0; size < 65536; size +=3D 256) {

We're testing 64 * 4 =3D 256 cases here, each of them starting a new qemu
process. Do we actually test anything new after the first couple of
requests or does this just make the test slower than it needs to be?

This test case really takes a long time for me (minutes), whereas all
other cases in ide-test combined run in like a second.

I would either test much less different sizes or at least run them in
the same qemu process. Or both, of course.

> +        /*
> +         * Two bytes specify the count of the region in bytes.
> +         * The bit 0 is always set to 0.
> +         * A value of zero in these two bytes indicates 64K.
> +         */
> +        prd_size =3D size & 0xfffe;
> +        if (prd_size =3D=3D 0) {
> +            prd_size =3D 65536;
> +        }
> =20
> -    /* Abort the request before it completes */
> -    status =3D send_dma_request(qts, CMD_READ_DMA | CMDF_ABORT, 0, 1,
> -                              prdt, ARRAY_SIZE(prdt), NULL);
> -    g_assert_cmphex(status, =3D=3D, BM_STS_INTR);
> -    assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF | ERR);
> -    free_pci_device(dev);
> -    test_bmdma_teardown(qts);
> +        for (req_sectors =3D 1; req_sectors <=3D 256; req_sectors *=3D 2=
) {
> +            req_size =3D req_sectors * 512;
> +
> +            /*
> +             * 1. If PRDs specified a smaller size than the IDE transfer
> +             * size, then the Interrupt and Active bits in the Controlle=
r
> +             * status register are not set (Error Condition).
> +             *
> +             * 2. If the size of the physical memory regions was equal t=
o
> +             * the IDE device transfer size, the Interrupt bit in the
> +             * Controller status register is set to 1, Active bit is set=
 to 0.
> +             *
> +             * 3. If PRDs specified a larger size than the IDE transfer =
size,
> +             * the Interrupt and Active bits in the Controller status re=
gister
> +             * are both set to 1.
> +             */
> +            if (prd_size < req_size) {
> +                s1 =3D 0;
> +                s2 =3D 0;
> +            } else if (prd_size =3D=3D req_size) {
> +                s1 =3D BM_STS_INTR;
> +                s2 =3D BM_STS_INTR;
> +            } else {
> +                s1 =3D BM_STS_ACTIVE | BM_STS_INTR;
> +                s2 =3D BM_STS_INTR;
> +            }
> +            test_bmdma_prdt(size, req_sectors, s1, s2);
> +        }
> +    }
>  }

And finally, as mentioned in the reply for patch 2, I wonder if we
should add a case with an empty PRDT (passing 0 as the PRDT size). This
would be a separate patch, though.

Kevin


