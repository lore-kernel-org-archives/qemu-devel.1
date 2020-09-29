Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50CAC4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 14:03:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 382A220848
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 14:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i8Z+9fP+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 382A220848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNGDc-0007Q7-4F
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 10:03:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1kNGCb-0006JF-Qe
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 10:01:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59156)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1kNGCU-0004YS-Hg
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 10:01:57 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601388108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V3mdZ0sfO904h/WFbEnwVRv8DURBzF1rcoMsW8vvi0I=;
 b=i8Z+9fP+dpFDeucVClgA9v1YIufmoUSKk5fbxe4hpGWEPJB/43yQb5HFH6OuNb6ne5E1kG
 45F/hesV1OvGn9+cBBrdhhY3BBL9pnCklkYg8kd6inzVephxhKMUn7RW668r+WgZNa+nK/
 nVjbZxshRfuduCdBOmJO+U50Bk5k1QU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-b-p899PjMR-LLXqIW4-OCA-1; Tue, 29 Sep 2020 10:01:42 -0400
X-MC-Unique: b-p899PjMR-LLXqIW4-OCA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D02A106BBE5;
 Tue, 29 Sep 2020 14:01:41 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-167.rdu2.redhat.com [10.10.116.167])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D025A6E715;
 Tue, 29 Sep 2020 14:01:36 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 5EF2E220203; Tue, 29 Sep 2020 10:01:36 -0400 (EDT)
Date: Tue, 29 Sep 2020 10:01:36 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: [Virtio-fs] virtiofs vs 9p performance(Re: tools/virtiofs: Multi
 threading seems to hurt performance)
Message-ID: <20200929140136.GD220516@redhat.com>
References: <20200918213436.GA3520@redhat.com> <20200921153243.GK3221@work-vm>
 <20200922102531.GA2837@work-vm> <20200922174733.GD57620@redhat.com>
 <46D726A6-72F3-40FE-9382-A189513F783D@intel.com>
 <20200924221023.GB132653@redhat.com>
 <20200925124139.GJ2873@work-vm>
 <20200929131753.GB220516@redhat.com>
 <CAOssrKcVNs=uiU2U1-ScowogFan8W=iw7kyTCnaz-vL8r9gLmw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOssrKcVNs=uiU2U1-ScowogFan8W=iw7kyTCnaz-vL8r9gLmw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Venegas Munoz,
 Jose Carlos" <jose.carlos.venegas.munoz@intel.com>,
 "cdupontd@redhat.com" <cdupontd@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 virtio-fs-list <virtio-fs@redhat.com>, "Shinde,
 Archana M" <archana.m.shinde@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 29, 2020 at 03:49:04PM +0200, Miklos Szeredi wrote:
> On Tue, Sep 29, 2020 at 3:18 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> 
> > - virtiofs cache=none mode is faster than cache=auto mode for this
> >   workload.
> 
> Not sure why.  One cause could be that readahead is not perfect at
> detecting the random pattern.  Could we compare total I/O on the
> server vs. total I/O by fio?

Hi Miklos,

I will instrument virtiosd code to figure out total I/O.

One more potential issue I am staring at is refreshing the attrs on 
READ if fc->auto_inval_data is set.

fuse_cache_read_iter() {
        /*
         * In auto invalidate mode, always update attributes on read.
         * Otherwise, only update if we attempt to read past EOF (to ensure
         * i_size is up to date).
         */
        if (fc->auto_inval_data ||
            (iocb->ki_pos + iov_iter_count(to) > i_size_read(inode))) {
                int err;
                err = fuse_update_attributes(inode, iocb->ki_filp);
                if (err)
                        return err;
        }
}

Given this is a mixed READ/WRITE workload, every WRITE will invalidate
attrs. And next READ will first do GETATTR() from server (and potentially
invalidate page cache) before doing READ.

This sounds suboptimal especially from the point of view of WRITEs
done by this client itself. I mean if another client has modified
the file, then doing GETATTR after a second makes sense. But there
should be some optimization to make sure our own WRITEs don't end
up doing GETATTR and invalidate page cache (because cache contents
are still valid).

I disabled ->auto_invalid_data and that seemed to result in 8-10%
gain in performance for this workload.

Thanks
Vivek


