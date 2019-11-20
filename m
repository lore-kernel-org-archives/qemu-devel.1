Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBD9C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 17:37:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 334A5206CB
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 17:37:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 334A5206CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=asm.pp.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXTuy-0007jK-CU
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 12:37:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56560)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bsdasm@gmail.com>) id 1iXTuK-0007Af-Rn
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 12:36:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bsdasm@gmail.com>) id 1iXTuJ-0004Nk-QH
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 12:36:48 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:34777)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bsdasm@gmail.com>) id 1iXTuJ-0004NP-Ly
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 12:36:47 -0500
Received: by mail-ot1-f41.google.com with SMTP id w11so345372ote.1
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 09:36:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=rwSwj1u2dx1aDKOiog7abZrcBIxBxjBvhT95G4nhgnk=;
 b=P0VXesezkfK+tWUY1bvcEKdhn7NnL905OqQgXqJOIeRWKTDq3m90A+2wHbL/qM96vS
 JievnFsEvDolaSB74fXr/UY5xpICxy8JLZ6Vo4DqKV5bAtfcZB88kB6YMNj2uytvjk5l
 K2m3JTv64CCIiL9mkl7sw6IJGemMAXOuytdnITiddI/rUfSJrn8RH9cyzMPzqitRN9pR
 qx7mZrTVwilJpx/v4u1DI6EJVUKMcNz//eZuP2ScIPQq0Xys+6WDzumOQPgdl/kmHyM2
 PQTgo3nZkxYVz8ypMYWT9gutupDuMHVfiRqROXpVGj5AzqbE44zsbV9NCqxJYfPWMkFJ
 ki8w==
X-Gm-Message-State: APjAAAWg8XfcD4MLSWzjxxX55BI4C4W0HxcyJYelLpTNPB1yNZIBo0B4
 eORFOZSELjLkU+A44cOKEeRalVC+5QbzUCelfYLaTL6/p+I=
X-Google-Smtp-Source: APXvYqwyRc1Ig6D725xpb2Ogm0bd3SD263oFqYZbWAVmf6pYnia5tgXw7a679zEygxitzzWipM/V3IVeP7HFTWVKgBM=
X-Received: by 2002:a05:6830:1512:: with SMTP id
 k18mr2913343otp.123.1574271405150; 
 Wed, 20 Nov 2019 09:36:45 -0800 (PST)
MIME-Version: 1.0
References: <CAMmAVbWzrYWZBXwKxSd-f5SXmq6qP1ok8abvyKJhp3=REEaMPA@mail.gmail.com>
In-Reply-To: <CAMmAVbWzrYWZBXwKxSd-f5SXmq6qP1ok8abvyKJhp3=REEaMPA@mail.gmail.com>
From: ASM <asm@asm.pp.ru>
Date: Wed, 20 Nov 2019 20:36:32 +0300
Message-ID: <CAMmAVbXNMjk=FasuySEcUa0U8CqGkCghehsJsWbVV2VHCAPA-w@mail.gmail.com>
Subject: PCI memory sync question (kvm,dpdk,e1000,packet stalled)
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.41
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi folks!

I trying solve the problem, with packets stopping (e1000,tap,kvm).
My studies led to the following:
1. From flatview_write_continue() I see, what e1000 writes the number
"7" to the STAT register.
2. The driver from target OS reads STAT register with number "7" and
writes to the register the number "0".
3. From flatview_write_continue() (I make edits):
            memcpy(ptr, buf, l);
            new1=ptr[0xc];
            usleep(100);
            new2=ptr[0xc];
            invalidate_and_set_dirty(mr, addr1, l);
            new3=ptr[0xc];
printf("Old: %i, new1, %i, new2: %i, new3: %i\n", old,new1,new2,new3);

I see what memory in first printf is "7", but after usleep() is "0".
Do I understand correctly that this should not be? Or RCU lock
suggests the ability to the multiple writers?

The problem is that qemu(e1000) writes the number 7, after which
target(dpdk driver) reads 7, on the basis of this it writes the number
0, but as a result (extremely rarely), the value STATUS still remains
7. Therefore, packet processing is interrupted. This behavior is
observed only on kvm (it is not observed on tcg).

Please help with advice or ideas.

P.S. I started a bug report earlier. There is more detailed
information. In my broken English:
bugs.launchpad.net/qemu/+bug/1853123

---
Best regards,
Leonid Myravjev

