Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A665DC4727F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 06:47:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1F7A2076A
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 06:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bgjyT9Gv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1F7A2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNVu4-000231-UO
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 02:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kNVsZ-0001d1-M9
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 02:46:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46057)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kNVsW-0000fK-Hn
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 02:46:19 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601448374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SHEFUvbfFQVIoCA0M/0qCCjn3EvZ++V+UzJPl2uzReI=;
 b=bgjyT9GvR/E0HLAcm+wGHymTlyDqP5+lfR13W8vv5Spvw30ffU8++HuRRbjPkEImLAluYH
 V/J04om6N17gHFhI5LtEzBLsw58hPONkmHTiBrpDwfvO+OysPmeskt0pLnJ3yPva/M9Tca
 N9FAllWljkS0cOz3kYvFwMU8fllf0tI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-H3rhzHjmMIegl6W4UvLjvA-1; Wed, 30 Sep 2020 02:46:07 -0400
X-MC-Unique: H3rhzHjmMIegl6W4UvLjvA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0543C107AD64;
 Wed, 30 Sep 2020 06:46:06 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B73015C1C4;
 Wed, 30 Sep 2020 06:46:00 +0000 (UTC)
Date: Wed, 30 Sep 2020 08:45:59 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: P J P <ppandit@redhat.com>
Subject: Re: [PATCH] pci: check bus pointer before dereference
Message-ID: <20200930084559.6796bbd0@redhat.com>
In-Reply-To: <nycvar.YSQ.7.78.906.2009301029460.10832@xnncv>
References: <20200827114917.1851111-1-ppandit@redhat.com>
 <CAKXe6SJNio2cy05ecr_DyB0Z6WjxHN_X8ZiOU5By0jwdRq12fg@mail.gmail.com>
 <b0859f8a-1224-66d0-7e32-091caa5cfcbe@redhat.com>
 <nycvar.YSQ.7.78.906.2009161152040.10832@xnncv>
 <CAFEAcA8Y+sJkapmrjNOdWP4xXa9kWTmSyXpthkvdb6QgUyDh5Q@mail.gmail.com>
 <nycvar.YSQ.7.78.906.2009281616200.10832@xnncv>
 <nycvar.YSQ.7.78.906.2009301029460.10832@xnncv>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:31:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Li Qiang <liq3ea@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Alexander Bulekov <alxndr@bu.edu>, Ruhr-University <bugs-syssec@rub.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVk?= =?UTF-8?B?w6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 30 Sep 2020 10:32:42 +0530 (IST)
P J P <ppandit@redhat.com> wrote:

> [+Paolo, +Fam Zheng - for scsi]
> 
> +-- On Mon, 28 Sep 2020, P J P wrote --+
> | +-- On Wed, 16 Sep 2020, Peter Maydell wrote --+
> | | On Wed, 16 Sep 2020 at 07:28, P J P <ppandit@redhat.com> wrote:
> | | > -> https://ruhr-uni-bochum.sciebo.de/s/NNWP2GfwzYKeKwE?path=%2Flsi_nullptr1
> | | > ==1183858==Hint: address points to the zero page.
> | | > #0 pci_change_irq_level hw/pci/pci.c:259
> | | > #1 pci_irq_handler hw/pci/pci.c:1445
> | | > #2 pci_set_irq hw/pci/pci.c:1463
> | | > #3 lsi_set_irq hw/scsi/lsi53c895a.c:488
> | | > #4 lsi_update_irq hw/scsi/lsi53c895a.c:523
> | | > #5 lsi_script_scsi_interrupt hw/scsi/lsi53c895a.c:554
> | | > #6 lsi_execute_script hw/scsi/lsi53c895a.c:1149
> | | > #7 lsi_reg_writeb hw/scsi/lsi53c895a.c:1984
> | | > #8 lsi_io_write hw/scsi/lsi53c895a.c:2146
> | ...
> | | Generally we don't bother to assert() that pointers that shouldn't be NULL 
> | | really are NULL immediately before dereferencing them, because the 
> | | dereference provides an equally easy-to-debug crash to the assert, and so 
> | | the assert doesn't provide anything extra. assert()ing that a pointer is 
> | | non-NULL is more useful if it is done in a place that identifies the problem 
> | | at an earlier and easier-to-debug point in execution rather than at a later 
> | | point which is distantly removed from the place where the bogus pointer was 
> | | introduced.
> | 
> | * The NULL dereference above occurs because the 'pci_dev->qdev->parent_bus' 
> |   address gets overwritten (with 0x0) during scsi 'Memory Move' operation in
> | 
> |  ../hw/scsi/lsi53c895a.c
> |   #define LSI_BUF_SIZE 4096
> | 
> | lsi_mmio_write
> |  lsi_reg_writeb
> |   lsi_execute_script
> |    static void lsi_memcpy(LSIState *s, ... int count=12MB)
> |    {
> |       int n;
> |       uint8_t buf[LSI_BUF_SIZE];
> | 
> |       while (count) {
> |         n = (count > LSI_BUF_SIZE) ? LSI_BUF_SIZE : count;
> |         lsi_mem_read(s, src, buf, n);          <== read from DMA memory
> |         lsi_mem_write(s, dest, buf, n);        <== write to I/O memory
> |         src += n;
> |         dest += n;
> |         count -= n;
> |      }
> |    }
> | -> https://www.manualslib.com/manual/1407578/Lsi-Lsi53c895a.html?page=254#manual
> | 
> | * Above loop moves data between DMA memory to i/o address space.
> | 
> | * Going through the manual above, it seems 'Memory Move' can move upto 16MB of 
> |   data between memory spaces.
> | 
> | * I tried to see a suitable fix, but couldn't get one.
> | 
> |   - Limiting 'count' value does not seem right, as allowed value is upto 16MB.
> | 
> |   - Manual above talks about moving data via 'dma_buf'. But it doesn't seem to 
> |     be used here.
> | 
> | * During above loop, 'dest' address moves past its 'MemoryRegion mr' and 
> |   overwrites the adjacent 'mr' memory area, overwritting 'parent_bus' value.
> | 
> | Any thoughts/hints please...?

'dest' is offset into MemoryRegion, so far I don't see how it could break into QEMU stack.
Do you have a simple reproducer?

> @Paolo, @Fam...wdyt?
> 
> Thank you.
> --
> Prasad J Pandit / Red Hat Product Security Team
> 8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D


