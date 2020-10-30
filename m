Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A5FC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 10:53:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A7AA2224A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 10:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=euphon.net header.i=fam@euphon.net header.b="VZ4KzcRf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A7AA2224A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=euphon.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYS2W-00023z-Sd
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 06:53:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fam@euphon.net>) id 1kYS0j-0000zC-EI
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 06:51:58 -0400
Received: from sender3-op-o12.zoho.com.cn ([124.251.121.243]:17723)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fam@euphon.net>) id 1kYS0a-0001ir-Te
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 06:51:56 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1604055045; cv=none; d=zoho.com.cn; s=zohoarc; 
 b=SvRUlyPueWDWks2eCtdGptx6T+fzM1Ab+y8vWZYy599PmohAAgXxFNIby1NSVLOOFrRB9OFarjJfB64L5NEjgPoDEtYNRufZIN3RR6LQUdvhXWud8PwUL9BjDEISmy8jXeeDSqeIT7JHw1HgFShmArRP4krVwyKgRLsZMorBVcw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn;
 s=zohoarc; t=1604055045;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To;
 bh=0X3dT8RQrcW0bT5PDPbK51DrbI9R+K6M8Kr+xQtCGwI=; 
 b=UgxlAqxnurV5PCv6ycKECtSoFN4FCLay4B9Sl56Q4mPJLyAH9FEboC69MgtdwcQFDwuC+MAQrpu8vIPYruv7b7+p0jvGY0iI70MZmwfVJ/1/dj4WNYwPTwYSMVVzPbFaEm7JqG/jnEIYOBrENCAhu5o+eaztCPY5odoF8Shl9ns=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
 dkim=pass  header.i=euphon.net;
 spf=pass  smtp.mailfrom=fam@euphon.net;
 dmarc=pass header.from=<fam@euphon.net> header.from=<fam@euphon.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1604055045; 
 s=zoho; d=euphon.net; i=fam@euphon.net;
 h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:Content-Type:Mime-Version:Content-Transfer-Encoding;
 bh=0X3dT8RQrcW0bT5PDPbK51DrbI9R+K6M8Kr+xQtCGwI=;
 b=VZ4KzcRf7NkVifgtnZ/MuvfDs8CCsNlXb4w7oYD2/1qvZxs7np17t2AfANFoYMcb
 AEdZOjcgUK8kgNQiXfpdq2FRKW+CZA895orSvmpZHMI+XL4XowETBxVM9jmAC+4Fvb+
 ltedBLVhLHT9wrHROo4R/rsTSNZYz/CpFy/xoTXw=
Received: from u60bdefc337955a.ant.amazon.com (54.239.6.187 [54.239.6.187]) by
 mx.zoho.com.cn with SMTPS id 1604055040784519.4361461122597;
 Fri, 30 Oct 2020 18:50:40 +0800 (CST)
Message-ID: <37ec64a3dba529fe52630b10ce3f5b1187cdadd7.camel@euphon.net>
Subject: Re: [PATCH] pci: check bus pointer before dereference
From: Fam Zheng <fam@euphon.net>
To: "Michael S. Tsirkin" <mst@redhat.com>, P J P <ppandit@redhat.com>
Date: Fri, 30 Oct 2020 10:50:28 +0000
In-Reply-To: <20201030050050-mutt-send-email-mst@kernel.org>
References: <20200827114917.1851111-1-ppandit@redhat.com>
 <CAKXe6SJNio2cy05ecr_DyB0Z6WjxHN_X8ZiOU5By0jwdRq12fg@mail.gmail.com>
 <b0859f8a-1224-66d0-7e32-091caa5cfcbe@redhat.com>
 <nycvar.YSQ.7.78.906.2009161152040.10832@xnncv>
 <CAFEAcA8Y+sJkapmrjNOdWP4xXa9kWTmSyXpthkvdb6QgUyDh5Q@mail.gmail.com>
 <nycvar.YSQ.7.78.906.2009281616200.10832@xnncv>
 <nycvar.YSQ.7.78.906.2009301029460.10832@xnncv>
 <20201030050050-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-ZohoCNMailClient: External
Received-SPF: pass client-ip=124.251.121.243; envelope-from=fam@euphon.net;
 helo=sender3-op-o12.zoho.com.cn
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 06:51:31
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Li Qiang <liq3ea@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Alexander Bulekov <alxndr@bu.edu>, Ruhr-University <bugs-syssec@rub.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2020-10-30 at 05:01 -0400, Michael S. Tsirkin wrote:
> On Wed, Sep 30, 2020 at 10:32:42AM +0530, P J P wrote:
> > 
> > [+Paolo, +Fam Zheng - for scsi]
> > 
> > +-- On Mon, 28 Sep 2020, P J P wrote --+
> > > +-- On Wed, 16 Sep 2020, Peter Maydell wrote --+
> > > > On Wed, 16 Sep 2020 at 07:28, P J P <ppandit@redhat.com> wrote:
> > > > > -> 
> > > > > https://ruhr-uni-bochum.sciebo.de/s/NNWP2GfwzYKeKwE?path=%2Flsi_nullptr1
> > > > > ==1183858==Hint: address points to the zero page.
> > > > > #0 pci_change_irq_level hw/pci/pci.c:259
> > > > > #1 pci_irq_handler hw/pci/pci.c:1445
> > > > > #2 pci_set_irq hw/pci/pci.c:1463
> > > > > #3 lsi_set_irq hw/scsi/lsi53c895a.c:488
> > > > > #4 lsi_update_irq hw/scsi/lsi53c895a.c:523
> > > > > #5 lsi_script_scsi_interrupt hw/scsi/lsi53c895a.c:554
> > > > > #6 lsi_execute_script hw/scsi/lsi53c895a.c:1149
> > > > > #7 lsi_reg_writeb hw/scsi/lsi53c895a.c:1984
> > > > > #8 lsi_io_write hw/scsi/lsi53c895a.c:2146
> > > 
> > > ...
> > > > Generally we don't bother to assert() that pointers that
> > > > shouldn't be NULL 
> > > > really are NULL immediately before dereferencing them, because
> > > > the 
> > > > dereference provides an equally easy-to-debug crash to the
> > > > assert, and so 
> > > > the assert doesn't provide anything extra. assert()ing that a
> > > > pointer is 
> > > > non-NULL is more useful if it is done in a place that
> > > > identifies the problem 
> > > > at an earlier and easier-to-debug point in execution rather
> > > > than at a later 
> > > > point which is distantly removed from the place where the bogus
> > > > pointer was 
> > > > introduced.
> > > 
> > > * The NULL dereference above occurs because the 'pci_dev->qdev-
> > > >parent_bus' 
> > >   address gets overwritten (with 0x0) during scsi 'Memory Move'
> > > operation in
> > > 
> > >  ../hw/scsi/lsi53c895a.c
> > >   #define LSI_BUF_SIZE 4096
> > > 
> > > lsi_mmio_write
> > >  lsi_reg_writeb
> > >   lsi_execute_script
> > >    static void lsi_memcpy(LSIState *s, ... int count=12MB)
> > >    {
> > >       int n;
> > >       uint8_t buf[LSI_BUF_SIZE];
> > > 
> > >       while (count) {
> > >         n = (count > LSI_BUF_SIZE) ? LSI_BUF_SIZE : count;
> > >         lsi_mem_read(s, src, buf, n);          <== read from DMA
> > > memory
> > >         lsi_mem_write(s, dest, buf, n);        <== write to I/O
> > > memory
> > >         src += n;
> > >         dest += n;
> > >         count -= n;
> > >      }
> > >    }
> > > -> 
> > > https://www.manualslib.com/manual/1407578/Lsi-Lsi53c895a.html?page=254#manual
> > > 
> > > * Above loop moves data between DMA memory to i/o address space.
> > > 
> > > * Going through the manual above, it seems 'Memory Move' can move
> > > upto 16MB of 
> > >   data between memory spaces.
> > > 
> > > * I tried to see a suitable fix, but couldn't get one.
> > > 
> > >   - Limiting 'count' value does not seem right, as allowed value
> > > is upto 16MB.
> > > 
> > >   - Manual above talks about moving data via 'dma_buf'. But it
> > > doesn't seem to 
> > >     be used here.
> > > 
> > > * During above loop, 'dest' address moves past its 'MemoryRegion
> > > mr' and 
> > >   overwrites the adjacent 'mr' memory area, overwritting
> > > 'parent_bus' value.

I agree with Igor, I don't understand how pci_dma_rw writing into the
next mr can cause the NULL pointer. parent_bus is in the QEMU heap, but
mr is backed by different ram areas, protected with boundary check.

Is there a backtrace at the corruption time?

Fam



