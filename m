Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC20C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 22:11:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CC2323A1B
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 22:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RC4ojBKO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CC2323A1B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLZSw-0002tM-Sk
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 18:11:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1kLZRo-0002FI-5K
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 18:10:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30520)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1kLZRl-0001He-Mv
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 18:10:39 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600985436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gbs9h17fz2LLgWdKJt9SGupF/V10Wb8z2l5HvirAdmg=;
 b=RC4ojBKOUeTxDr57ldwVTAAeUlzJ3iA2JvOEGwGGd6bnekJmtFQQHX8NmDX8XBVvjDsPay
 3QYMz4v7UodMRNUi895LnXQ6DUJY3cNXIWBtjW6SxRGzJxHyTnKqxwSdYpCVoiPbQmI0/U
 2uANUW95Gu63V+2Dxh2FQ5tpxIHSSdg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-s9BURt0KNlqm-5fB4NnYGg-1; Thu, 24 Sep 2020 18:10:31 -0400
X-MC-Unique: s9BURt0KNlqm-5fB4NnYGg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF180186DD3D;
 Thu, 24 Sep 2020 22:10:30 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-53.rdu2.redhat.com [10.10.116.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 381DB78830;
 Thu, 24 Sep 2020 22:10:24 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id A3F35222FC0; Thu, 24 Sep 2020 18:10:23 -0400 (EDT)
Date: Thu, 24 Sep 2020 18:10:23 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: "Venegas Munoz, Jose Carlos" <jose.carlos.venegas.munoz@intel.com>
Subject: virtiofs vs 9p performance(Re: tools/virtiofs: Multi threading seems
 to hurt performance)
Message-ID: <20200924221023.GB132653@redhat.com>
References: <20200918213436.GA3520@redhat.com> <20200921153243.GK3221@work-vm>
 <20200922102531.GA2837@work-vm> <20200922174733.GD57620@redhat.com>
 <46D726A6-72F3-40FE-9382-A189513F783D@intel.com>
MIME-Version: 1.0
In-Reply-To: <46D726A6-72F3-40FE-9382-A189513F783D@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vgoyal@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=vgoyal@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "cdupontd@redhat.com" <cdupontd@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 virtio-fs-list <virtio-fs@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Shinde, Archana M" <archana.m.shinde@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 24, 2020 at 09:33:01PM +0000, Venegas Munoz, Jose Carlos wrote:
> Hi Folks,
> 
> Sorry for the delay about how to reproduce `fio` data.
> 
> I have some code to automate testing for multiple kata configs and collect info like:
> - Kata-env, kata configuration.toml, qemu command, virtiofsd command.
> 
> See: 
> https://github.com/jcvenegas/mrunner/
> 
> 
> Last time we agreed to narrow the cases and configs to compare virtiofs and 9pfs
> 
> The configs where the following:
> 
> - qemu + virtiofs(cache=auto, dax=0) a.ka. `kata-qemu-virtiofs` WITOUT xattr
> - qemu + 9pfs a.k.a `kata-qemu`
> 
> Please take a look to the html and raw results I attach in this mail.

Hi Carlos,

So you are running following test.

fio --direct=1 --gtod_reduce=1 --name=test --filename=random_read_write.fio --bs=4k --iodepth=64 --size=4G --readwrite=randrw --rwmixread=75 --output=/output/fio.txt

And following are your results.

9p
--
READ: bw=211MiB/s (222MB/s), 211MiB/s-211MiB/s (222MB/s-222MB/s), io=3070MiB (3219MB), run=14532-14532msec

WRITE: bw=70.6MiB/s (74.0MB/s), 70.6MiB/s-70.6MiB/s (74.0MB/s-74.0MB/s), io=1026MiB (1076MB), run=14532-14532msec

virtiofs
--------
Run status group 0 (all jobs):
   READ: bw=159MiB/s (167MB/s), 159MiB/s-159MiB/s (167MB/s-167MB/s), io=3070MiB (3219MB), run=19321-19321msec
  WRITE: bw=53.1MiB/s (55.7MB/s), 53.1MiB/s-53.1MiB/s (55.7MB/s-55.7MB/s), io=1026MiB (1076MB), run=19321-19321msec

So looks like you are getting better performance with 9p in this case.

Can you apply "shared pool" patch to qemu for virtiofsd and re-run this
test and see if you see any better results.

In my testing, with cache=none, virtiofs performed better than 9p in 
all the fio jobs I was running. For the case of cache=auto  for virtiofs
(with xattr enabled), 9p performed better in certain write workloads. I
have identified root cause of that problem and working on
HANDLE_KILLPRIV_V2 patches to improve WRITE performance of virtiofs
with cache=auto and xattr enabled.

I will post my 9p and virtiofs comparison numbers next week. In the
mean time will be great if you could apply following qemu patch, rebuild
qemu and re-run above test.

https://www.redhat.com/archives/virtio-fs/2020-September/msg00081.html

Also what's the status of file cache on host in both the cases. Are
you booting host fresh for these tests so that cache is cold on host
or cache is warm?

Thanks
Vivek


