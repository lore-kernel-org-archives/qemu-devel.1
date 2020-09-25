Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7E2C4727D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:38:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA265206BE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="IfClmXIu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA265206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLqk8-0007gz-Qx
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 12:38:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kLqer-0001pL-PP
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:33:17 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:54795)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kLqep-0008Ec-Lc
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:33:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=Mtlvd6/JfhA7bnxupmXQsyc+Nnh9ngRKS9o/dIotvbc=; b=IfClmXIutjsdqvoNX99L9xC3oe
 YCEz9m2MvrGsIjAAE+9uLZQaJlTfWO6hu3Z15E3qqCQBLfLags3LehZrwOh55bRQ6WnNTctMf1kmI
 jNMPvrU9XsxzcuJwvSptERsB4lxgL5exLWj10nwwaX3aXT4p3PYtStX2T9RpzqSfcbpZi1zJFVYlu
 qL/GEhy3Ljn7FH7uIAnjv4nJ4Ya8X7sRLKRb/GfXdLF5PyPrY9q/XYdILENhl+Ert6hb6UG1h5QsP
 70emr140Mbq1fF7Gb3w3w0Ydbld7khu7PHN00UF/g+WYhRoOEEHy824BbkmqPXS407lJty2G5zLzR
 Lbng2wQA==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Venegas Munoz,
 Jose Carlos" <jose.carlos.venegas.munoz@intel.com>,
 "cdupontd@redhat.com" <cdupontd@redhat.com>,
 virtio-fs-list <virtio-fs@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Shinde, Archana M" <archana.m.shinde@intel.com>,
 Vivek Goyal <vgoyal@redhat.com>
Subject: Re: virtiofs vs 9p performance(Re: tools/virtiofs: Multi threading
 seems to hurt performance)
Date: Fri, 25 Sep 2020 18:33:08 +0200
Message-ID: <1726614.lvKUr2j5NN@silver>
In-Reply-To: <7085634.CctCyd8GvG@silver>
References: <20200918213436.GA3520@redhat.com> <20200925130538.GK2873@work-vm>
 <7085634.CctCyd8GvG@silver>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 11:47:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Freitag, 25. September 2020 18:05:17 CEST Christian Schoenebeck wrote:
> On Freitag, 25. September 2020 15:05:38 CEST Dr. David Alan Gilbert wrote:
> > > > 9p ( mount -t 9p -o trans=virtio kernel /mnt
> > > > -oversion=9p2000.L,cache=mmap,msize=1048576 ) test: (g=0): rw=randrw,
> > > 
> > > Bottleneck ------------------------------^
> > > 
> > > By increasing 'msize' you would encounter better 9P I/O results.
> > 
> > OK, I thought that was bigger than the default;  what number should I
> > use?
> 
> It depends on the underlying storage hardware. In other words: you have to
> try increasing the 'msize' value to a point where you no longer notice a
> negative performance impact (or almost). Which is fortunately quite easy to
> test on guest like:
> 
> 	dd if=/dev/zero of=test.dat bs=1G count=12
> 	time cat test.dat > /dev/null

I forgot: you should execute that 'dd' command and host side, and the 'cat' 
command on guest side, to avoid any caching making the benchmark result look 
better than it actually is. Because for finding a good 'msize' value you only 
care about actual 9p data really being transmitted between host and guest.

Best regards,
Christian Schoenebeck



