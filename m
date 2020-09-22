Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F00C4727D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:56:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93D3F23787
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B9YgA3ZU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93D3F23787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKmWd-0000B3-Ow
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 13:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1kKmOK-0007vu-NT
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 13:47:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30625)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1kKmOI-0004KD-Le
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 13:47:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600796865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Lj3UbafpoojkTj52+qJnHyCGtSx65I6ftVoJpK00Z5Y=;
 b=B9YgA3ZUCngBRR6ydpAb5aV1JDEDYba54W5dg1pFW3y01bN3GaEZXDz4Itcqs5pKRNJpki
 ScDl0OhVvJpOxsk9Mt20MV0c5kMK/dmb0Q2FWhgSRAAzZpqW7OJZLqRWce8DF7vBEcCbCw
 OB2wXr40ZjzE7tg4spGf7+Vr0lue/ug=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-0sK8dVRHPQGpxi2V4oEbyQ-1; Tue, 22 Sep 2020 13:47:41 -0400
X-MC-Unique: 0sK8dVRHPQGpxi2V4oEbyQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B71311007278;
 Tue, 22 Sep 2020 17:47:40 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-78.rdu2.redhat.com [10.10.116.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9A07F5C1A3;
 Tue, 22 Sep 2020 17:47:34 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 1E96E223B13; Tue, 22 Sep 2020 13:47:33 -0400 (EDT)
Date: Tue, 22 Sep 2020 13:47:33 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: tools/virtiofs: Multi threading seems to hurt performance
Message-ID: <20200922174733.GD57620@redhat.com>
References: <20200918213436.GA3520@redhat.com> <20200921153243.GK3221@work-vm>
 <20200922102531.GA2837@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200922102531.GA2837@work-vm>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vgoyal@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=vgoyal@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
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
Cc: jose.carlos.venegas.munoz@intel.com, qemu-devel@nongnu.org,
 cdupontd@redhat.com, virtio-fs-list <virtio-fs@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, archana.m.shinde@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 22, 2020 at 11:25:31AM +0100, Dr. David Alan Gilbert wrote:
> * Dr. David Alan Gilbert (dgilbert@redhat.com) wrote:
> > Hi,
> >   I've been doing some of my own perf tests and I think I agree
> > about the thread pool size;  my test is a kernel build
> > and I've tried a bunch of different options.
> > 
> > My config:
> >   Host: 16 core AMD EPYC (32 thread), 128G RAM,
> >      5.9.0-rc4 kernel, rhel 8.2ish userspace.
> >   5.1.0 qemu/virtiofsd built from git.
> >   Guest: Fedora 32 from cloud image with just enough extra installed for
> > a kernel build.
> > 
> >   git cloned and checkout v5.8 of Linux into /dev/shm/linux on the host
> > fresh before each test.  Then log into the guest, make defconfig,
> > time make -j 16 bzImage,  make clean; time make -j 16 bzImage 
> > The numbers below are the 'real' time in the guest from the initial make
> > (the subsequent makes dont vary much)
> > 
> > Below are the detauls of what each of these means, but here are the
> > numbers first
> > 
> > virtiofsdefault        4m0.978s
> > 9pdefault              9m41.660s
> > virtiofscache=none    10m29.700s
> > 9pmmappass             9m30.047s
> > 9pmbigmsize           12m4.208s
> > 9pmsecnone             9m21.363s
> > virtiofscache=noneT1   7m17.494s
> > virtiofsdefaultT1      3m43.326s
> > 
> > So the winner there by far is the 'virtiofsdefaultT1' - that's
> > the default virtiofs settings, but with --thread-pool-size=1 - so
> > yes it gives a small benefit.
> > But interestingly the cache=none virtiofs performance is pretty bad,
> > but thread-pool-size=1 on that makes a BIG improvement.
> 
> Here are fio runs that Vivek asked me to run in my same environment
> (there are some 0's in some of the mmap cases, and I've not investigated
> why yet).

cache=none does not allow mmap in case of virtiofs. That's when you
are seeing 0.

>virtiofs is looking good here in I think all of the cases;
> there's some division over which cinfig; cache=none
> seems faster in some cases which surprises me.

I know cache=none is faster in case of write workloads. It forces
direct write where we don't call file_remove_privs(). While cache=auto
goes through file_remove_privs() and that adds a GETXATTR request to
every WRITE request.

Vivek


