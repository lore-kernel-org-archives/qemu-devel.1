Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7830C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 21:36:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F7C62311B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 21:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g7QfQH3Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F7C62311B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJO3d-0005d6-UM
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 17:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1kJO2A-0004i3-Ma
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 17:35:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26096)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1kJO1q-0003MN-JD
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 17:35:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600464886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=KREMkcKPgdbo+OUhS7kRZApRFJjWQ5PO3gQ6R0JgX/4=;
 b=g7QfQH3YRwnkWYpQhrOYfGfwVOu9IAhqJFuT7pvNUgbd0J76OIaya71xIr64sSXqHb6wdp
 tfYS1FfEz25PiYcEhPxIiUpfEBSo38ZnuJvI83yYFw/Odue3GZfOuECZGcB59xboiaKQSR
 abB+wBLDZkKuBOfLxrpOuiuDMqXq8eY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-w7qqNkGzN6q5ky_ULhvw0g-1; Fri, 18 Sep 2020 17:34:44 -0400
X-MC-Unique: w7qqNkGzN6q5ky_ULhvw0g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BF10801AAB
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 21:34:43 +0000 (UTC)
Received: from horse.redhat.com (ovpn-113-188.rdu2.redhat.com [10.10.113.188])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 39ACA10013C1;
 Fri, 18 Sep 2020 21:34:37 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 9F2C3222E58; Fri, 18 Sep 2020 17:34:36 -0400 (EDT)
Date: Fri, 18 Sep 2020 17:34:36 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: virtio-fs-list <virtio-fs@redhat.com>, qemu-devel@nongnu.org
Subject: tools/virtiofs: Multi threading seems to hurt performance
Message-ID: <20200918213436.GA3520@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vgoyal@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=vgoyal@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 00:20:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi All,

virtiofsd default thread pool size is 64. To me it feels that in most of
the cases thread pool size 1 performs better than thread pool size 64.

I ran virtiofs-tests.

https://github.com/rhvgoyal/virtiofs-tests

And here are the comparision results. To me it seems that by default
we should switch to 1 thread (Till we can figure out how to make
multi thread performance better even when single process is doing
I/O in client).

I am especially more interested in getting performance better for
single process in client. If that suffers, then it is pretty bad.

Especially look at randread, randwrite, seqwrite performance. seqread
seems pretty good anyway.

If I don't run who test suite and just ran randread-psync job,
my throughput jumps from around 40MB/s to 60MB/s. That's a huge
jump I would say.

Thoughts?

Thanks
Vivek


NAME                    WORKLOAD                Bandwidth       IOPS            
cache-auto              seqread-psync           690(MiB/s)      172k            
cache-auto-1-thread     seqread-psync           729(MiB/s)      182k            

cache-auto              seqread-psync-multi     2578(MiB/s)     644k            
cache-auto-1-thread     seqread-psync-multi     2597(MiB/s)     649k            

cache-auto              seqread-mmap            660(MiB/s)      165k            
cache-auto-1-thread     seqread-mmap            672(MiB/s)      168k            

cache-auto              seqread-mmap-multi      2499(MiB/s)     624k            
cache-auto-1-thread     seqread-mmap-multi      2618(MiB/s)     654k            

cache-auto              seqread-libaio          286(MiB/s)      71k             
cache-auto-1-thread     seqread-libaio          260(MiB/s)      65k             

cache-auto              seqread-libaio-multi    1508(MiB/s)     377k            
cache-auto-1-thread     seqread-libaio-multi    986(MiB/s)      246k            

cache-auto              randread-psync          35(MiB/s)       9191            
cache-auto-1-thread     randread-psync          55(MiB/s)       13k             

cache-auto              randread-psync-multi    179(MiB/s)      44k             
cache-auto-1-thread     randread-psync-multi    209(MiB/s)      52k             

cache-auto              randread-mmap           32(MiB/s)       8273            
cache-auto-1-thread     randread-mmap           50(MiB/s)       12k             

cache-auto              randread-mmap-multi     161(MiB/s)      40k             
cache-auto-1-thread     randread-mmap-multi     185(MiB/s)      46k             

cache-auto              randread-libaio         268(MiB/s)      67k             
cache-auto-1-thread     randread-libaio         254(MiB/s)      63k             

cache-auto              randread-libaio-multi   256(MiB/s)      64k             
cache-auto-1-thread     randread-libaio-multi   155(MiB/s)      38k             

cache-auto              seqwrite-psync          23(MiB/s)       6026            
cache-auto-1-thread     seqwrite-psync          30(MiB/s)       7925            

cache-auto              seqwrite-psync-multi    100(MiB/s)      25k             
cache-auto-1-thread     seqwrite-psync-multi    154(MiB/s)      38k             

cache-auto              seqwrite-mmap           343(MiB/s)      85k             
cache-auto-1-thread     seqwrite-mmap           355(MiB/s)      88k             

cache-auto              seqwrite-mmap-multi     408(MiB/s)      102k            
cache-auto-1-thread     seqwrite-mmap-multi     438(MiB/s)      109k            

cache-auto              seqwrite-libaio         41(MiB/s)       10k             
cache-auto-1-thread     seqwrite-libaio         65(MiB/s)       16k             

cache-auto              seqwrite-libaio-multi   137(MiB/s)      34k             
cache-auto-1-thread     seqwrite-libaio-multi   214(MiB/s)      53k             

cache-auto              randwrite-psync         22(MiB/s)       5801            
cache-auto-1-thread     randwrite-psync         30(MiB/s)       7927            

cache-auto              randwrite-psync-multi   100(MiB/s)      25k             
cache-auto-1-thread     randwrite-psync-multi   151(MiB/s)      37k             

cache-auto              randwrite-mmap          31(MiB/s)       7984            
cache-auto-1-thread     randwrite-mmap          55(MiB/s)       13k             

cache-auto              randwrite-mmap-multi    124(MiB/s)      31k             
cache-auto-1-thread     randwrite-mmap-multi    213(MiB/s)      53k             

cache-auto              randwrite-libaio        40(MiB/s)       10k             
cache-auto-1-thread     randwrite-libaio        64(MiB/s)       16k             

cache-auto              randwrite-libaio-multi  139(MiB/s)      34k             
cache-auto-1-thread     randwrite-libaio-multi  212(MiB/s)      53k             







