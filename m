Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6B3C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:12:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A717520702
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z+6phOSA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A717520702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jska4-0007hM-Ts
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 06:12:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jskZU-0007DN-4v
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 06:11:28 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21716
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jskZS-0001P8-GH
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 06:11:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594116685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V6Tlq6tUD/nqc9AFUoZ0ocgF7LPfLywxtiBKSdiJsII=;
 b=Z+6phOSA3j6r3LrOsImNUlUgFGPcYZQBrvQVJR/5lkDmaR/8himEt0rz5+/YbsQhjMoYIC
 rlRFmPnyHrhTieZOSRK1BnD0tbtFShSMi+ZhTAyj+juewJ6olEWqy9JRS9gJ0aqZQpXu3a
 Ot/7iZDxIhOW+9WChv+Y+aRQnqE0HSQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-klm3RsK4NSaJKAMYs9FNhQ-1; Tue, 07 Jul 2020 06:11:22 -0400
X-MC-Unique: klm3RsK4NSaJKAMYs9FNhQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E226D800C64;
 Tue,  7 Jul 2020 10:11:20 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-113.ams2.redhat.com [10.36.114.113])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D24C860CC0;
 Tue,  7 Jul 2020 10:11:15 +0000 (UTC)
Date: Tue, 7 Jul 2020 12:11:14 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH 5/6] migration: support excluding block devs in QMP
 snapshot commands
Message-ID: <20200707101114.GA7002@linux.fritz.box>
References: <20200702175754.2211821-1-berrange@redhat.com>
 <20200702175754.2211821-6-berrange@redhat.com>
 <20200706155708.GD5052@linux.fritz.box>
 <20200707091456.GD2649462@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200707091456.GD2649462@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:20:54
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
Cc: Peter Krempa <pkrempa@redhat.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 07.07.2020 um 11:14 hat Daniel P. Berrangé geschrieben:
> On Mon, Jul 06, 2020 at 05:57:08PM +0200, Kevin Wolf wrote:
> > Am 02.07.2020 um 19:57 hat Daniel P. BerrangÃƒÂ© geschrieben:
> > > This wires up support for a new "exclude" parameter to the QMP commands
> > > for snapshots (savevm, loadvm, delvm). This parameter accepts a list of
> > > block driver state node names.
> > > 
> > > One use case for this would be a VM using OVMF firmware where the
> > > variables store is a raw disk image. Ideally the variable store would be
> > > qcow2, allowing its contents to be included in the snapshot, but
> > > typically today the variable store is raw. It is still useful to be able
> > > to snapshot VMs using OVMF, even if the varstore is excluded, as the
> > > main OS disk content is usually the stuff the user cares about.
> > > 
> > > Signed-off-by: Daniel P. BerrangÃƒÂ© <berrange@redhat.com>
> > 
> > Wouldn't it be better to take an optional list of nodes to _include_
> > that just defaults to our current set of nodes?
> > 
> > The problem with excluding is that we already don't snapshot many nodes,
> > and the criteria to choose the right ones weren't entirely obvious, so
> > we just went with something that seemed to make the most sense. But the
> > management application may actually want to snapshot more nodes than we
> > cover by default.
> > 
> > I feel things become clearer and less surprising if the client just
> > tells us explicitly which images are supposed to be snapshotted instead
> > of adding exceptions on top of a default selection that we're already
> > not really sure about.
> 
> I thought that QEMU just excluded nodes which are not capable of being
> snapshotted.

No, QEMU tries to figure out which nodes must be snapshotted to capture
the current state, and if any of these nodes doesn't support snapshots,
the snapshot operation fails.

> By using exclusions, the mgmt apps don't have to know
> about what types of storage driver QEMU supports snapshots on, just let
> QEMU decide. It also felt simpler to use exclusions as normal case would
> be to snapshot everything.   Both inclusions/exclusions are easy to
> implement in QEMU though.

The problem when going from device based operation to node based is that
you need to figure out which nodes actually contain something that the
user wants to snapshot. For example, you usually don't want to try
creating a snapshot on the protocol node when there is a format node on
top.

What do you do with nodes that aren't attached to the guest, but maybe
used as the backend of the NBD server? What if a node is both directly
attached to some user and there is another node on top of it? In these
non-trivial cases, the default is rather arbitrary because there really
isn't a single right answer.

What QEMU currently does is snapshotting every node that is opened
read-write and either attached to a BlockBackend (i.e. is used by a
device, NBD server, or I guess as the main node of a block job) or that
doesn't have any parents (i.e. the user added it explicitly, but didn't
use it yet).

Come to think of it, the read-write condition may lead to surprising
results with dynamic auto-read-only... Good that file-posix doesn't
support snapshots and nothing else implements dynamic auto-read-only
yet.

Kevin


