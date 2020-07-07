Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B60C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 09:16:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F7C7206DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 09:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hCkV92xV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F7C7206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsjhq-000881-Pv
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 05:16:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jsjh8-0007dB-VT
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 05:15:18 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26494
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jsjh6-0008Ru-RW
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 05:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594113316;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jfItJUR0OAG49L9jvwH43BZP+ytJoPG1AonLYuu4C+g=;
 b=hCkV92xVV/aqgZdIVrkIYRyaJHV7F690NmRpq4neQOJviS7vql2svcf/ukWXIfNfYCBS1t
 +kSrqbnpUgJ0W1UeI6b9LXhch11PmCPK5ikUHelGKZu+YrpUS1y40+QUXOR13K/SszhL8w
 7NjXpjX7w6P9Hxbj10rSJGy9Rp6y+Yw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-VnfQNnyVMdOuopl_sgerQw-1; Tue, 07 Jul 2020 05:15:08 -0400
X-MC-Unique: VnfQNnyVMdOuopl_sgerQw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9E4D100CCC3;
 Tue,  7 Jul 2020 09:15:06 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 181DE5C1D0;
 Tue,  7 Jul 2020 09:14:59 +0000 (UTC)
Date: Tue, 7 Jul 2020 10:14:56 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 5/6] migration: support excluding block devs in QMP
 snapshot commands
Message-ID: <20200707091456.GD2649462@redhat.com>
References: <20200702175754.2211821-1-berrange@redhat.com>
 <20200702175754.2211821-6-berrange@redhat.com>
 <20200706155708.GD5052@linux.fritz.box>
MIME-Version: 1.0
In-Reply-To: <20200706155708.GD5052@linux.fritz.box>
User-Agent: Mutt/1.14.3 (2020-06-14)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:20:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Peter Krempa <pkrempa@redhat.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 06, 2020 at 05:57:08PM +0200, Kevin Wolf wrote:
> Am 02.07.2020 um 19:57 hat Daniel P. BerrangÃÂ© geschrieben:
> > This wires up support for a new "exclude" parameter to the QMP commands
> > for snapshots (savevm, loadvm, delvm). This parameter accepts a list of
> > block driver state node names.
> > 
> > One use case for this would be a VM using OVMF firmware where the
> > variables store is a raw disk image. Ideally the variable store would be
> > qcow2, allowing its contents to be included in the snapshot, but
> > typically today the variable store is raw. It is still useful to be able
> > to snapshot VMs using OVMF, even if the varstore is excluded, as the
> > main OS disk content is usually the stuff the user cares about.
> > 
> > Signed-off-by: Daniel P. BerrangÃÂ© <berrange@redhat.com>
> 
> Wouldn't it be better to take an optional list of nodes to _include_
> that just defaults to our current set of nodes?
> 
> The problem with excluding is that we already don't snapshot many nodes,
> and the criteria to choose the right ones weren't entirely obvious, so
> we just went with something that seemed to make the most sense. But the
> management application may actually want to snapshot more nodes than we
> cover by default.
> 
> I feel things become clearer and less surprising if the client just
> tells us explicitly which images are supposed to be snapshotted instead
> of adding exceptions on top of a default selection that we're already
> not really sure about.

I thought that QEMU just excluded nodes which are not capable of being
snapshotted. By using exclusions, the mgmt apps don't have to know
about what types of storage driver QEMU supports snapshots on, just let
QEMU decide. It also felt simpler to use exclusions as normal case would
be to snapshot everything.   Both inclusions/exclusions are easy to
implement in QEMU though.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


