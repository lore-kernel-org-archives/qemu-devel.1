Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C204C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 04:27:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75A362074B
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 04:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BvDqRM3S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75A362074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNTiW-0007Z5-Ed
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 00:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kNThO-00073i-2c
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 00:26:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37127)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kNThK-0000Dy-Lb
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 00:26:37 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601439993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lHp5O4NZmgZmLQzp3LXK/kfMMm1usbN6Cp/islfYUOs=;
 b=BvDqRM3S5QCdwIIqa80hpy4q+Ll8olf/Cd46ZeR3Ka5dlOS1y+9w3Hv+ihXFjsQzmKFrEL
 EboC7hjhP8G9pzukkkk0FvxUT1R9ftea8Mqa6ihpfc86wTN8iOTDwuTtPP35k5PV6McAd7
 aJstbJ+itjymNpCE5lEhAHX35JIjZmQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-OobVAP5VM6iRAesbEN04MQ-1; Wed, 30 Sep 2020 00:26:27 -0400
X-MC-Unique: OobVAP5VM6iRAesbEN04MQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6CCD0801AC8;
 Wed, 30 Sep 2020 04:26:26 +0000 (UTC)
Received: from kaapi (unknown [10.40.192.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1BC1C6198B;
 Wed, 30 Sep 2020 04:26:22 +0000 (UTC)
Date: Wed, 30 Sep 2020 09:56:20 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2] hw/ide: check null block before _cancel_dma_sync
In-Reply-To: <CAKXe6SKBhVXfvAxQDUTjc7PeR5PPiOMHfZxLSmoQcgYYFcftfQ@mail.gmail.com>
Message-ID: <nycvar.YSQ.7.78.906.2009300954550.10832@xnncv>
References: <20200903183138.2161977-1-ppandit@redhat.com>
 <CAKXe6SLv1HX5_ty2SP5F_MkVKYO-tz5fNOKhpqZr0mH_ePypSA@mail.gmail.com>
 <nycvar.YSQ.7.78.906.2009181427350.10832@xnncv>
 <CAKXe6SL6BFErCqk+AJt2iQiQsCN_EvHJCur=Y8J1yz7F_c8t4A@mail.gmail.com>
 <nycvar.YSQ.7.78.906.2009291106100.10832@xnncv>
 <CAKXe6SKBhVXfvAxQDUTjc7PeR5PPiOMHfZxLSmoQcgYYFcftfQ@mail.gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ppandit@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed;
 boundary="-1463810047-1273881197-1601439985=:10832"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Ruhr-University <bugs-syssec@rub.de>, Li Qiang <liq3ea@gmail.com>,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
---1463810047-1273881197-1601439985=:10832
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

+-- On Tue, 29 Sep 2020, Li Qiang wrote --+
| P J P <ppandit@redhat.com> 于2020年9月29日周二 下午2:22写道：
| > +-- On Fri, 18 Sep 2020, Li Qiang wrote --+
| > | P J P <ppandit@redhat.com> 于2020年9月18日周五 下午6:26写道：
| > | > +-- On Fri, 18 Sep 2020, Li Qiang wrote --+
| > | > | Update v2: use an assert() call
| > | > |   ->https://lists.nongnu.org/archive/html/qemu-devel/2020-08/msg08336.html
| > |
| > | In 'ide_ioport_write' the guest can set 'bus->unit' to 0 or 1 by issue
| > | 'ATA_IOPORT_WR_DEVICE_HEAD'. So this case the guest can set the active ifs.
| > | If the guest set this to 1.
| > |
| > | Then in 'idebus_active_if' will return 'IDEBus.ifs[1]' and thus the 's->blk'
| > | will be NULL.
| >
| > Right, guest does select the drive via
| >
| >   portio_write
| >    ->ide_ioport_write
| >       case ATA_IOPORT_WR_DEVICE_HEAD:
| >       /* FIXME: HOB readback uses bit 7 */
| >       bus->ifs[0].select = (val & ~0x10) | 0xa0;
| >       bus->ifs[1].select = (val | 0x10) | 0xa0;
| >       /* select drive */
| >       bus->unit = (val >> 4) & 1;     <== set bus->unit=0x1
| >       break;
| >
| >
| > | So from your (Peter's) saying, we need to check the value in
| > | 'ATA_IOPORT_WR_DEVICE_HEAD' handler. To say if the guest
| > | set a valid 'bus->unit'. This can also work I think.
| >
| > Yes, with the following fix, an assert(3) in ide_cancel_dma_sync fails.
| >
| > ===
| > diff --git a/hw/ide/core.c b/hw/ide/core.c
| > index f76f7e5234..cb55cc8b0f 100644
| > --- a/hw/ide/core.c
| > +++ b/hw/ide/core.c
| > @@ -1300,7 +1300,11 @@ void ide_ioport_write(void *opaque, uint32_t addr,
| > uint_)
| >          bus->ifs[0].select = (val & ~0x10) | 0xa0;
| >          bus->ifs[1].select = (val | 0x10) | 0xa0;
| >          /* select drive */
| > +        uint8_t bu = bus->unit;
| >          bus->unit = (val >> 4) & 1;
| > +        if (!bus->ifs[bus->unit].blk) {
| > +            bus->unit = bu;
| > +        }
| >          break;
| >      default:
| >
| > qemu-system-x86_64: ../hw/ide/core.c:724: ide_cancel_dma_sync: Assertion `s->bus->dma->aiocb == NULL' failed.
| > Aborted (core dumped)
| 
| This is what I am worried, in the 'ide_ioport_write' set the 'bus->unit'. It 
| also change the 'buf->ifs[0].select'. Also there maybe some other corner 
| case that causes some inconsistent. And if we choice this method we need to 
| deep into the more ahci-spec to know how things really going.
| 
| > ===
| >
| > | As we the 'ide_exec_cmd' and other functions in 'hw/ide/core.c' check the
| > | 's->blk' directly. I think we just check it in 'ide_cancel_dma_sync' is
| > | enough and also this is more consistent with the other functions.
| > | 'ide_cancel_dma_sync' is also called by 'cmd_device_reset' which is one of
| > | the 'ide_cmd_table' handler.
| >
| >   Yes, I'm okay with either approach. Earlier patch v1 checks 's->blk' in
| > ide_cancel_dma_sync().
| 
| I prefer the 'check the s->blk in the beginning of ide_cancel_dma_sync' method.
| Some little different with your earlier patch.
| 
| Anyway, let the maintainer do the choices.
| 

@John ...wdyt?

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D
---1463810047-1273881197-1601439985=:10832--


