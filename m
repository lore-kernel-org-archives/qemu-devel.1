Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B770C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:34:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ADB52065F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dPMidhnU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ADB52065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jskw3-0007kN-CG
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 06:34:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jskv4-0006sy-12
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 06:33:46 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55844
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jskv1-0005IL-4B
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 06:33:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594118022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ILm3e8DojcXLC7g7JGo5aJu8v1+4oqCqjulabZTFBNQ=;
 b=dPMidhnUL5SP6Ssr3atuPjMX261lqc+7aeSkPpaGIKIJNPqZISWtt0xoafjlw1hNjLWfeT
 yIZrMwSxzpcxD7sMkm3f4AKHl6w0VC6ln4Oz5GDcTPky2rvD2qAhi6QgrImW7YX1iwmBxb
 rvUjWPY0pcSDkcXG648EtDxpAAibht4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-P917rZpXN3mx27GRH8OvoQ-1; Tue, 07 Jul 2020 06:33:38 -0400
X-MC-Unique: P917rZpXN3mx27GRH8OvoQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D002107B274;
 Tue,  7 Jul 2020 10:33:37 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-113.ams2.redhat.com [10.36.114.113])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A029607A0;
 Tue,  7 Jul 2020 10:33:32 +0000 (UTC)
Date: Tue, 7 Jul 2020 12:33:31 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Krempa <pkrempa@redhat.com>
Subject: Re: [PATCH 2/6] migration: introduce savevm, loadvm, delvm QMP
 commands
Message-ID: <20200707103331.GB7002@linux.fritz.box>
References: <20200702175754.2211821-1-berrange@redhat.com>
 <20200702175754.2211821-3-berrange@redhat.com>
 <fcff0e8b-fd60-2897-0553-49ab24a9b7fa@redhat.com>
 <20200702182452.GP1888119@redhat.com>
 <20200703154933.GE6641@work-vm>
 <20200703160235.GM2213227@redhat.com>
 <20200706161555.GE5052@linux.fritz.box>
 <20200707063853.GA9048@angien.pipo.sk>
MIME-Version: 1.0
In-Reply-To: <20200707063853.GA9048@angien.pipo.sk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:31:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 07.07.2020 um 08:38 hat Peter Krempa geschrieben:
> On Mon, Jul 06, 2020 at 18:15:55 +0200, Kevin Wolf wrote:
> > Am 03.07.2020 um 18:02 hat Daniel P. Berrangé geschrieben:
> > > On Fri, Jul 03, 2020 at 04:49:33PM +0100, Dr. David Alan Gilbert wrote:
> > > > * Daniel P. Berrangé (berrange@redhat.com) wrote:
> > > > > On Thu, Jul 02, 2020 at 01:12:52PM -0500, Eric Blake wrote:
> > > > > > On 7/2/20 12:57 PM, Daniel P. Berrangé wrote:
> 
> [...]
> 
> > > migration only does vmstate, not disks. The current blockdev commands
> > > are all related to external snapshots, nothing for internal snapshots
> > > AFAIK. So we still need commands to load/save internal snapshots of
> > > the disk data in the qcow2 files.
> > > 
> > > So we could look at loadvm/savevm conceptually as a syntax sugar above
> > > a migration transport that targets disk images, and blockdev QMP command
> > > that can do internal snapshots. Neither of these exist though and feel
> > > like a significantly larger amount of work than using existing functionality
> > > that is currently working.
> > 
> > There is blockdev-snapshot-internal-sync, which does a disk-only
> > snapshot of a single node. A snapshot of multiple nodes can be taken by
> > putting multiple blockdev-snapshot-internal-sync inside a 'transaction'
> > command.
> 
> Libvirt never implemented support for disk-only internal snapshots as I
> didn't think they are worth it. We also made a mistake by using the
> VIR_DOMAIN_SNAPSHOT_DISK_ONLY to switch to an external snapshot, so
> while the XML can modify the snapshot to be internal it's not very clear
> nor user-friendly to force an internal disk only snapshot.
> 
> > If we want to build on top of this, we'd have to implement a
> > transactionable command for storing only the VM state to a specific
> > node. This would probably still be a long-running job.
> 
> IMO we really want this also for external snapshots. Driving the
> migration as standard migration is really suboptimal especially when the
> user wants minimal downtime. Transactioning a post-copy style copy-on
> write migration would simplify this a lot. I agree though that this is
> for a different conversation.

This is an interesting point actually. And while the implementation of
the post-copy style live snapshotting is for a different conversation, I
think the implications it has on the API are relevant for us now.

But even if we have an all-in-one snapshot job instead of a transaction
to group all the individual operations together, I think you could still
represent that by just specifying an empty list of nodes to be
snapshotted. (I feel this is another argument for passing the nodes to
include rather than nodes to exclude from the disk snapshot.)

Kevin


