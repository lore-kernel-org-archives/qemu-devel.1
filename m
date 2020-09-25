Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C11C4727E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 18:53:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFEB620878
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 18:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ePW0R+w+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFEB620878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLsqK-0007xo-PR
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 14:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kLspL-0007V0-9d
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 14:52:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51060)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kLspI-00010P-Mw
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 14:52:14 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601059931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cMxaFPxG1eBNjJ2Be/WPnv7L4OGNxGiFZ8ZERl5Kflc=;
 b=ePW0R+w+V9CWQ0SbuUGHNGw+LKtNzu2cMHkCHkckgUBoHjrKnzV6+z4Z6U/Q4Q60BBKmsc
 47/7Q4opBR+WzwNVGZjx3RsqwrPYmwrk7fZxh75L1mBHffI2Rkxxdn6JS89WJmXGw89Dko
 xBdkLY8akZkU0fT5Q3X62mhO50jJR68=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-2RDZ81nTNV-OFyc4VdMfSw-1; Fri, 25 Sep 2020 14:52:06 -0400
X-MC-Unique: 2RDZ81nTNV-OFyc4VdMfSw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22E5D807352;
 Fri, 25 Sep 2020 18:52:05 +0000 (UTC)
Received: from work-vm (ovpn-114-177.ams2.redhat.com [10.36.114.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 80C8E7B7A3;
 Fri, 25 Sep 2020 18:51:49 +0000 (UTC)
Date: Fri, 25 Sep 2020 19:51:47 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: virtiofs vs 9p performance(Re: tools/virtiofs: Multi threading
 seems to hurt performance)
Message-ID: <20200925185147.GS2873@work-vm>
References: <20200918213436.GA3520@redhat.com> <4973513.bp6ERB8pJA@silver>
 <20200925130538.GK2873@work-vm> <7085634.CctCyd8GvG@silver>
MIME-Version: 1.0
In-Reply-To: <7085634.CctCyd8GvG@silver>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 02:48:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
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
Cc: "Venegas Munoz, Jose Carlos" <jose.carlos.venegas.munoz@intel.com>,
 qemu-devel@nongnu.org, "cdupontd@redhat.com" <cdupontd@redhat.com>,
 virtio-fs-list <virtio-fs@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Shinde, Archana M" <archana.m.shinde@intel.com>,
 Vivek Goyal <vgoyal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Christian Schoenebeck (qemu_oss@crudebyte.com) wrote:
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
> It depends on the underlying storage hardware. In other words: you have to try 
> increasing the 'msize' value to a point where you no longer notice a negative 
> performance impact (or almost). Which is fortunately quite easy to test on 
> guest like:
> 
> 	dd if=/dev/zero of=test.dat bs=1G count=12
> 	time cat test.dat > /dev/null
> 
> I would start with an absolute minimum msize of 10MB. I would recommend 
> something around 100MB maybe for a mechanical hard drive. With a PCIe flash 
> you probably would rather pick several hundred MB or even more.
> 
> That unpleasant 'msize' issue is a limitation of the 9p protocol: client 
> (guest) must suggest the value of msize on connection to server (host). Server 
> can only lower, but not raise it. And the client in turn obviously cannot see 
> host's storage device(s), so client is unable to pick a good value by itself. 
> So it's a suboptimal handshake issue right now.

It doesn't seem to be making a vast difference here:



9p mount -t 9p -o trans=virtio kernel /mnt -oversion=9p2000.L,cache=mmap,msize=104857600

Run status group 0 (all jobs):
   READ: bw=62.5MiB/s (65.6MB/s), 62.5MiB/s-62.5MiB/s (65.6MB/s-65.6MB/s), io=3070MiB (3219MB), run=49099-49099msec
  WRITE: bw=20.9MiB/s (21.9MB/s), 20.9MiB/s-20.9MiB/s (21.9MB/s-21.9MB/s), io=1026MiB (1076MB), run=49099-49099msec

9p mount -t 9p -o trans=virtio kernel /mnt -oversion=9p2000.L,cache=mmap,msize=1048576000

Run status group 0 (all jobs):
   READ: bw=65.2MiB/s (68.3MB/s), 65.2MiB/s-65.2MiB/s (68.3MB/s-68.3MB/s), io=3070MiB (3219MB), run=47104-47104msec
  WRITE: bw=21.8MiB/s (22.8MB/s), 21.8MiB/s-21.8MiB/s (22.8MB/s-22.8MB/s), io=1026MiB (1076MB), run=47104-47104msec


Dave

> Many users don't even know this 'msize' parameter exists and hence run with 
> the Linux kernel's default value of just 8kB. For QEMU 5.2 I addressed this by 
> logging a performance warning on host side for making users at least aware 
> about this issue. The long-term plan is to pass a good msize value from host 
> to guest via virtio (like it's already done for the available export tags) and 
> the Linux kernel would default to that instead.
> 
> Best regards,
> Christian Schoenebeck
> 
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


