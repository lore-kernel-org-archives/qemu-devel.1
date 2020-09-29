Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE01C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 13:19:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED68320757
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 13:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eZm9QH5K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED68320757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNFXv-0004vi-Nz
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 09:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1kNFWA-00042C-DM
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 09:18:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40120)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1kNFW8-0006NA-0h
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 09:18:06 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601385483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PPbkkC9FMyjvlcJK9Y8akpwUgQWAGA3b4Syy8ayWkOw=;
 b=eZm9QH5KMD8beUQdyAzbKfRBuVck6In8i5H0A56fX504FCl4zO9ud8kIhEuQhmHnevkTOu
 KebKW3kVDY4voeFahJgNqBvB+RpMFRI46bFoEWvlJbLutRf3O2L+vYSHqd7n548lh7B1am
 d6RanjqcfWiCA99N4T74Ai2gCBQpoKY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-xNcgO_1ZNCSH14wiymIf7A-1; Tue, 29 Sep 2020 09:18:01 -0400
X-MC-Unique: xNcgO_1ZNCSH14wiymIf7A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 96E4C10BBEC5;
 Tue, 29 Sep 2020 13:17:59 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-167.rdu2.redhat.com [10.10.116.167])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EB74D10013D0;
 Tue, 29 Sep 2020 13:17:53 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 70119220203; Tue, 29 Sep 2020 09:17:53 -0400 (EDT)
Date: Tue, 29 Sep 2020 09:17:53 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: virtiofs vs 9p performance(Re: tools/virtiofs: Multi threading
 seems to hurt performance)
Message-ID: <20200929131753.GB220516@redhat.com>
References: <20200918213436.GA3520@redhat.com> <20200921153243.GK3221@work-vm>
 <20200922102531.GA2837@work-vm> <20200922174733.GD57620@redhat.com>
 <46D726A6-72F3-40FE-9382-A189513F783D@intel.com>
 <20200924221023.GB132653@redhat.com>
 <20200925124139.GJ2873@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200925124139.GJ2873@work-vm>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vgoyal@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=vgoyal@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
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
Cc: "Venegas Munoz, Jose Carlos" <jose.carlos.venegas.munoz@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "cdupontd@redhat.com" <cdupontd@redhat.com>,
 virtio-fs-list <virtio-fs@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Shinde, Archana M" <archana.m.shinde@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 25, 2020 at 01:41:39PM +0100, Dr. David Alan Gilbert wrote:

[..]
> So I'm sitll beating 9p; the thread-pool-size=1 seems to be great for
> read performance here.
> 

Hi Dave,

I spent some time making changes to virtiofs-tests so that I can test
a mix of random read and random write workload. That testsuite runs
a workload 3 times and reports the average. So I like to use it to
reduce run to run variation effect.

So I ran following to mimic carlos's workload.

$ ./run-fio-test.sh test -direct=1 -c <test-dir> fio-jobs/randrw-psync.job >
testresults.txt

$ ./parse-fio-results.sh testresults.txt

I am using a SSD at the host to back these files. Option "-c" always
creates new files for testing.

Following are my results in various configurations. Used cache=mmap mode
for 9p and cache=auto (and cache=none) modes for virtiofs. Also tested
9p default as well as msize=16m. Tested virtiofs both with exclusive
as well as shared thread pool.

NAME                    WORKLOAD                Bandwidth       IOPS            
9p-mmap-randrw          randrw-psync            42.8mb/14.3mb   10.7k/3666      
9p-mmap-msize16m        randrw-psync            42.8mb/14.3mb   10.7k/3674      
vtfs-auto-ex-randrw     randrw-psync            27.8mb/9547kb   7136/2386       
vtfs-auto-sh-randrw     randrw-psync            43.3mb/14.4mb   10.8k/3709      
vtfs-none-sh-randrw     randrw-psync            54.1mb/18.1mb   13.5k/4649      


- Increasing msize to 16m did not help with performance for this workload.
- virtiofs exclusive thread pool ("ex"), is slower than 9p.
- virtiofs shared thread pool ("sh"), matches the performance of 9p.
- virtiofs cache=none mode is faster than cache=auto mode for this
  workload.

Carlos, I am looking at more ways to optimize it further for virtiofs.
In the mean time I think switching to "shared" thread pool should
bring you very close to 9p in your setup I think.

Thanks
Vivek


