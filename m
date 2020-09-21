Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFDDC43465
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 13:41:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4555A2084C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 13:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MUWeDw7s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4555A2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKM4g-0007x4-Vo
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 09:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1kKM2v-0006rM-K9
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 09:39:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22843)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1kKM2t-00049T-JA
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 09:39:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600695594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BhIAlzTmatnRN3sJuXt3Lanoyylt5RTJVbBzjG15f3M=;
 b=MUWeDw7sSqDef4l0r1rBFcyusNBK2QoiM4sooNoiOgc0IdRka+oGueNvvHD43Ix1fHnokq
 3T+9tZc4yIBz2L0a47lbccNxePsG1R790hXMNyTvGkTiXcq8TwZy4C0tTc2aK/Ad9GbYJO
 LrVc94AHEkU/Vyw+e0iSZsiLioSQOHg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-570-L1pRI1c-OjedaKIZfx8T7g-1; Mon, 21 Sep 2020 09:39:52 -0400
X-MC-Unique: L1pRI1c-OjedaKIZfx8T7g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8FEBC6408B
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 13:39:51 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-27.rdu2.redhat.com [10.10.114.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4BE3E78824;
 Mon, 21 Sep 2020 13:39:45 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id C77B4220C56; Mon, 21 Sep 2020 09:39:44 -0400 (EDT)
Date: Mon, 21 Sep 2020 09:39:44 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: tools/virtiofs: Multi threading seems to hurt performance
Message-ID: <20200921133944.GB13362@redhat.com>
References: <20200918213436.GA3520@redhat.com>
 <20200921083923.GA71121@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200921083923.GA71121@stefanha-x1.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vgoyal@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=vgoyal@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:44:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: virtio-fs-list <virtio-fs@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 21, 2020 at 09:39:23AM +0100, Stefan Hajnoczi wrote:
> On Fri, Sep 18, 2020 at 05:34:36PM -0400, Vivek Goyal wrote:
> > And here are the comparision results. To me it seems that by default
> > we should switch to 1 thread (Till we can figure out how to make
> > multi thread performance better even when single process is doing
> > I/O in client).
> 
> Let's understand the reason before making changes.
> 
> Questions:
>  * Is "1-thread" --thread-pool-size=1?

Yes.

>  * Was DAX enabled?

No.

>  * How does cache=none perform?

I just ran random read workload with cache=none.

cache-none              randread-psync          45(MiB/s)       11k             
cache-none-1-thread     randread-psync          63(MiB/s)       15k

With 1 thread it offers more IOPS.

>  * Does commenting out vu_queue_get_avail_bytes() + fuse_log("%s:
>    Queue %d gave evalue: %zx available: in: %u out: %u\n") in
>    fv_queue_thread help?

Will try that.

>  * How do the kvm_stat vmexit counters compare?

This should be same, isn't it. Changing number of threads serving should
not change number of vmexits?

>  * How does host mpstat -P ALL compare?

Never used mpstat. Will try running it and see if I can get something
meaningful.

>  * How does host perf record -a compare?

Will try it. I feel this might be too big and too verbose to get
something meaningful.

>  * Does the Rust virtiofsd show the same pattern (it doesn't use glib
>    thread pools)?

No idea. Never tried rust implementation of virtiofsd.

But I suepct it has to do with thread pool implementation and possibly
extra cacheline bouncing.

Thanks
Vivek


