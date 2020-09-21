Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6E8C43464
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 08:51:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63E3F20EDD
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 08:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dNGb0OgE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63E3F20EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKHXt-0001pF-G9
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 04:51:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kKHWy-0001O3-Aq
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 04:50:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57955
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kKHWt-0004rj-8U
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 04:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600678234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rjRs7t1lbnCL2uKfLDC/o96iZNsPgEuMhPjbGywGuqs=;
 b=dNGb0OgELt5cheDQUihw/LRIJrpnAoZ81/eJxwg8LNCLpMdrK9V15taZoVYhvr2t5v6AyB
 HJfCBkXtpYZVdhyq8PHLZf3lMQzVgWsv7PjD9LLQRJajCKZP++3C2AB2PTr7BH7LIaSDdW
 D6NjYm75Y1aPVW3Vo/4DqdemDcjM58g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-6wfNg6scMeOAvvs77QoPEQ-1; Mon, 21 Sep 2020 04:50:30 -0400
X-MC-Unique: 6wfNg6scMeOAvvs77QoPEQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F300D188C131
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 08:50:28 +0000 (UTC)
Received: from work-vm (ovpn-114-207.ams2.redhat.com [10.36.114.207])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 27EDC1C6;
 Mon, 21 Sep 2020 08:50:21 +0000 (UTC)
Date: Mon, 21 Sep 2020 09:50:19 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: tools/virtiofs: Multi threading seems to hurt performance
Message-ID: <20200921085019.GB3221@work-vm>
References: <20200918213436.GA3520@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200918213436.GA3520@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 03:53:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.501,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: virtio-fs-list <virtio-fs@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Vivek Goyal (vgoyal@redhat.com) wrote:
> Hi All,
> 
> virtiofsd default thread pool size is 64. To me it feels that in most of
> the cases thread pool size 1 performs better than thread pool size 64.
> 
> I ran virtiofs-tests.
> 
> https://github.com/rhvgoyal/virtiofs-tests
> 
> And here are the comparision results. To me it seems that by default
> we should switch to 1 thread (Till we can figure out how to make
> multi thread performance better even when single process is doing
> I/O in client).
> 
> I am especially more interested in getting performance better for
> single process in client. If that suffers, then it is pretty bad.
> 
> Especially look at randread, randwrite, seqwrite performance. seqread
> seems pretty good anyway.
> 
> If I don't run who test suite and just ran randread-psync job,
> my throughput jumps from around 40MB/s to 60MB/s. That's a huge
> jump I would say.
> 
> Thoughts?

What's your host setup; how many cores has the host got and how many did
you give the guest?

Dave

> Thanks
> Vivek
> 
> 
> NAME                    WORKLOAD                Bandwidth       IOPS            
> cache-auto              seqread-psync           690(MiB/s)      172k            
> cache-auto-1-thread     seqread-psync           729(MiB/s)      182k            
> 
> cache-auto              seqread-psync-multi     2578(MiB/s)     644k            
> cache-auto-1-thread     seqread-psync-multi     2597(MiB/s)     649k            
> 
> cache-auto              seqread-mmap            660(MiB/s)      165k            
> cache-auto-1-thread     seqread-mmap            672(MiB/s)      168k            
> 
> cache-auto              seqread-mmap-multi      2499(MiB/s)     624k            
> cache-auto-1-thread     seqread-mmap-multi      2618(MiB/s)     654k            
> 
> cache-auto              seqread-libaio          286(MiB/s)      71k             
> cache-auto-1-thread     seqread-libaio          260(MiB/s)      65k             
> 
> cache-auto              seqread-libaio-multi    1508(MiB/s)     377k            
> cache-auto-1-thread     seqread-libaio-multi    986(MiB/s)      246k            
> 
> cache-auto              randread-psync          35(MiB/s)       9191            
> cache-auto-1-thread     randread-psync          55(MiB/s)       13k             
> 
> cache-auto              randread-psync-multi    179(MiB/s)      44k             
> cache-auto-1-thread     randread-psync-multi    209(MiB/s)      52k             
> 
> cache-auto              randread-mmap           32(MiB/s)       8273            
> cache-auto-1-thread     randread-mmap           50(MiB/s)       12k             
> 
> cache-auto              randread-mmap-multi     161(MiB/s)      40k             
> cache-auto-1-thread     randread-mmap-multi     185(MiB/s)      46k             
> 
> cache-auto              randread-libaio         268(MiB/s)      67k             
> cache-auto-1-thread     randread-libaio         254(MiB/s)      63k             
> 
> cache-auto              randread-libaio-multi   256(MiB/s)      64k             
> cache-auto-1-thread     randread-libaio-multi   155(MiB/s)      38k             
> 
> cache-auto              seqwrite-psync          23(MiB/s)       6026            
> cache-auto-1-thread     seqwrite-psync          30(MiB/s)       7925            
> 
> cache-auto              seqwrite-psync-multi    100(MiB/s)      25k             
> cache-auto-1-thread     seqwrite-psync-multi    154(MiB/s)      38k             
> 
> cache-auto              seqwrite-mmap           343(MiB/s)      85k             
> cache-auto-1-thread     seqwrite-mmap           355(MiB/s)      88k             
> 
> cache-auto              seqwrite-mmap-multi     408(MiB/s)      102k            
> cache-auto-1-thread     seqwrite-mmap-multi     438(MiB/s)      109k            
> 
> cache-auto              seqwrite-libaio         41(MiB/s)       10k             
> cache-auto-1-thread     seqwrite-libaio         65(MiB/s)       16k             
> 
> cache-auto              seqwrite-libaio-multi   137(MiB/s)      34k             
> cache-auto-1-thread     seqwrite-libaio-multi   214(MiB/s)      53k             
> 
> cache-auto              randwrite-psync         22(MiB/s)       5801            
> cache-auto-1-thread     randwrite-psync         30(MiB/s)       7927            
> 
> cache-auto              randwrite-psync-multi   100(MiB/s)      25k             
> cache-auto-1-thread     randwrite-psync-multi   151(MiB/s)      37k             
> 
> cache-auto              randwrite-mmap          31(MiB/s)       7984            
> cache-auto-1-thread     randwrite-mmap          55(MiB/s)       13k             
> 
> cache-auto              randwrite-mmap-multi    124(MiB/s)      31k             
> cache-auto-1-thread     randwrite-mmap-multi    213(MiB/s)      53k             
> 
> cache-auto              randwrite-libaio        40(MiB/s)       10k             
> cache-auto-1-thread     randwrite-libaio        64(MiB/s)       16k             
> 
> cache-auto              randwrite-libaio-multi  139(MiB/s)      34k             
> cache-auto-1-thread     randwrite-libaio-multi  212(MiB/s)      53k             
> 
> 
> 
> 
> 
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


