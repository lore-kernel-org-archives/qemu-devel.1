Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD13C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 11:53:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C79D8206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 11:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UtNU0rcO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C79D8206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD4qX-0002tQ-Po
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 07:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kD4pq-0002Em-71
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 07:52:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45831)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kD4pn-0002ko-4q
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 07:52:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598961138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j7B6K2kWzT+w/sWX2RyaQJhgHxBDpcYdxf3oXGvPBes=;
 b=UtNU0rcOLifqC8jLgC4MS0ODekRuVa7ssJ9wqz5To1HW9NddsJ7ZHdJDr4vbKOVams/sUA
 K4vox+lpp8Vm6ZHB4Wdc0MEc0SYNgz0MRsmoqZcByT6yE+fdQlNPALSF5HA5JxKuSrQup4
 2i8GvsupQLwMXfmuxWc5+xr4rf+mpGc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-aKo8bLDKMae2wijg7NSnTQ-1; Tue, 01 Sep 2020 07:52:14 -0400
X-MC-Unique: aKo8bLDKMae2wijg7NSnTQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87D3E10060C1;
 Tue,  1 Sep 2020 11:52:12 +0000 (UTC)
Received: from kaapi (unknown [10.74.8.94])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 563CF78B2F;
 Tue,  1 Sep 2020 11:52:09 +0000 (UTC)
Date: Tue, 1 Sep 2020 17:22:07 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: Alexander Bulekov <alxndr@bu.edu>
Subject: Re: [PATCH] sd: sdhci: check data_count is within fifo_buffer
In-Reply-To: <20200830174636.q6tg3d4podqhekec@mozz.bu.edu>
Message-ID: <nycvar.YSQ.7.78.906.2009011711280.306228@xnncv>
References: <20200827115336.1851276-1-ppandit@redhat.com>
 <20200830174636.q6tg3d4podqhekec@mozz.bu.edu>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ppandit@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 01:27:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Ruhr-University <bugs-syssec@rub.de>,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+-- On Sun, 30 Aug 2020, Alexander Bulekov wrote --+
| Here's a qtest reproducer for this one:
| 
| cat << EOF |./i386-softmmu/qemu-system-i386 -nodefaults \
| -device sdhci-pci -device sd-card,drive=mydrive \
| -drive if=sd,index=0,file=null-co://,format=raw,id=mydrive \
| -nographic -accel qtest -qtest stdio -nographic
| outl 0xcf8 0x80001001
| outl 0xcfc 0x7e6f25b7
| outl 0xcf8 0x80001012
| outl 0xcfc 0x842b1212
| writeb 0x12120005 0xff
| writeq 0x12120027 0x5e32b7120584125e
| write 0x0 0x1 0x21
| write 0x8 0x1 0x21
| write 0x10 0x1 0x21
| write 0x18 0x1 0x21
| write 0x20 0x1 0x21
| write 0x23 0x1 0x2b
| writeq 0x1212000c 0x123a0584052da3ab
| writeq 0x12120000 0xcfff000000000002
| writeq 0x12120027 0x5c04c1c9c100005e
| clock_step
| EOF
| 
| Is it related to this https://bugs.launchpad.net/qemu/+bug/1892960 ?

  Yes, it's same. This patch fixes it.


| > +++ b/hw/sd/sdhci.c
| > @@ -604,6 +604,9 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
| >              }
| > +            if (s->data_count <= begin || s->data_count > s->buf_maxsz) {
| > +                break;
| > +            }
| >              dma_memory_write(s->dma_as, s->sdmasysad,
| >                               &s->fifo_buffer[begin], s->data_count - begin);
| ...
| > +            if (s->data_count <= begin || s->data_count > s->buf_maxsz) {
| > +                break;
| > +            }
| >              dma_memory_read(s->dma_as, s->sdmasysad,
| >                              &s->fifo_buffer[begin], s->data_count - begin);


Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D


