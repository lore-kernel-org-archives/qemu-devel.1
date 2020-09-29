Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7F2C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 06:23:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ED0A20BED
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 06:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cpT5YOYe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ED0A20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kN92t-00041v-Ea
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 02:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kN92F-0003Om-LX
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 02:22:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25820)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kN92D-0001TK-8l
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 02:22:47 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601360564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cGN3csnpgc7f9P/kxcOb/5bqVXa8IiMVA32ZpXwdgXc=;
 b=cpT5YOYe4lGZiig1U3nNuvlwcynQnUOgsGRAtP35Qnldhlnu8RhU1WMqS/BFCzkx386MYy
 n3nAq+oBc1C/cWR8Q5SqmqDeq5gFjRwnuIWc6OjFzsvpf0gC2bVpa25d1g6E6UY64AqwgI
 RP9yofGZkKfiC9HzD4/87TdGFG821Nk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-OhsziOXoOfS4wfNsUpVv3A-1; Tue, 29 Sep 2020 02:22:40 -0400
X-MC-Unique: OhsziOXoOfS4wfNsUpVv3A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A7381868409;
 Tue, 29 Sep 2020 06:22:39 +0000 (UTC)
Received: from kaapi (ovpn-112-119.phx2.redhat.com [10.3.112.119])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F52C7A41F;
 Tue, 29 Sep 2020 06:22:35 +0000 (UTC)
Date: Tue, 29 Sep 2020 11:52:32 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: Li Qiang <liq3ea@gmail.com>
Subject: Re: [PATCH v2] hw/ide: check null block before _cancel_dma_sync
In-Reply-To: <CAKXe6SL6BFErCqk+AJt2iQiQsCN_EvHJCur=Y8J1yz7F_c8t4A@mail.gmail.com>
Message-ID: <nycvar.YSQ.7.78.906.2009291106100.10832@xnncv>
References: <20200903183138.2161977-1-ppandit@redhat.com>
 <CAKXe6SLv1HX5_ty2SP5F_MkVKYO-tz5fNOKhpqZr0mH_ePypSA@mail.gmail.com>
 <nycvar.YSQ.7.78.906.2009181427350.10832@xnncv>
 <CAKXe6SL6BFErCqk+AJt2iQiQsCN_EvHJCur=Y8J1yz7F_c8t4A@mail.gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ppandit@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed;
 BOUNDARY="-1463810047-18043354-1601360261=:10832"
Content-ID: <nycvar.YSQ.7.78.906.2009291150510.10832@xnncv>
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_CHARSET_FARAWAY=2.45, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Ruhr-University <bugs-syssec@rub.de>, John Snow <jsnow@redhat.com>,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
---1463810047-18043354-1601360261=:10832
Content-Type: text/plain; CHARSET=ISO-2022-JP
Content-ID: <nycvar.YSQ.7.78.906.2009291150511.10832@xnncv>

  Hello Li,

+-- On Fri, 18 Sep 2020, Li Qiang wrote --+
| P J P <ppandit@redhat.com> 于2020年9月18日周五 下午6:26写道：
| > +-- On Fri, 18 Sep 2020, Li Qiang wrote --+
| > | Update v2: use an assert() call
| > |   ->https://lists.nongnu.org/archive/html/qemu-devel/2020-08/msg08336.html
| 
| In 'ide_ioport_write' the guest can set 'bus->unit' to 0 or 1 by issue 
| 'ATA_IOPORT_WR_DEVICE_HEAD'. So this case the guest can set the active ifs. 
| If the guest set this to 1.
| 
| Then in 'idebus_active_if' will return 'IDEBus.ifs[1]' and thus the 's->blk' 
| will be NULL.

Right, guest does select the drive via

  portio_write
   ->ide_ioport_write
      case ATA_IOPORT_WR_DEVICE_HEAD:
      /* FIXME: HOB readback uses bit 7 */
      bus->ifs[0].select = (val & ~0x10) | 0xa0;
      bus->ifs[1].select = (val | 0x10) | 0xa0;
      /* select drive */
      bus->unit = (val >> 4) & 1;     <== set bus->unit=0x1
      break;


| So from your (Peter's) saying, we need to check the value in
| 'ATA_IOPORT_WR_DEVICE_HEAD' handler. To say if the guest
| set a valid 'bus->unit'. This can also work I think.

Yes, with the following fix, an assert(3) in ide_cancel_dma_sync fails.

===
diff --git a/hw/ide/core.c b/hw/ide/core.c
index f76f7e5234..cb55cc8b0f 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -1300,7 +1300,11 @@ void ide_ioport_write(void *opaque, uint32_t addr, 
uint_)
         bus->ifs[0].select = (val & ~0x10) | 0xa0;
         bus->ifs[1].select = (val | 0x10) | 0xa0;
         /* select drive */
+        uint8_t bu = bus->unit;
         bus->unit = (val >> 4) & 1;
+        if (!bus->ifs[bus->unit].blk) {
+            bus->unit = bu;
+        }
         break;
     default:

qemu-system-x86_64: ../hw/ide/core.c:724: ide_cancel_dma_sync: Assertion `s->bus->dma->aiocb == NULL' failed.
Aborted (core dumped)
===
 
| As we the 'ide_exec_cmd' and other functions in 'hw/ide/core.c' check the 
| 's->blk' directly. I think we just check it in 'ide_cancel_dma_sync' is 
| enough and also this is more consistent with the other functions. 
| 'ide_cancel_dma_sync' is also called by 'cmd_device_reset' which is one of 
| the 'ide_cmd_table' handler.

  Yes, I'm okay with either approach. Earlier patch v1 checks 's->blk' in 
ide_cancel_dma_sync().
 
| BTW, where is the Peter's email saying this, just want to learn something, 
| :).

  -> https://lists.nongnu.org/archive/html/qemu-devel/2020-09/msg05820.html

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D
---1463810047-18043354-1601360261=:10832--


