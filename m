Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3C4C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 15:58:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A17BE20715
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 15:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="elhJ1w5+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A17BE20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsTVH-0007MV-UT
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 11:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jsTUb-00060S-SK
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 11:57:17 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49889
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jsTUZ-0001Wc-VQ
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 11:57:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594051034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bII9UDEAv4g70Q1ciDU10DC8QgdfDH4XOjobdsEBjaU=;
 b=elhJ1w5+WLIZISfY5sRaCNHExfJkyvE0wBxHbCFMjIOBrbdbBZGKDx7HSZxqhDfMr+ARec
 Yzd0k7T4/+UTvJ+9UKPR23Vfr9Rrp0252GBLj//1B2FU3OCiPywTF4LhJn5Zn8JzsfgZuA
 TrGFyhYfafCu1xuo+CYxZBM+HlQsMuY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-N8Ds-uVOMDSv-cIDbFEF4A-1; Mon, 06 Jul 2020 11:57:13 -0400
X-MC-Unique: N8Ds-uVOMDSv-cIDbFEF4A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D05DEC1A0;
 Mon,  6 Jul 2020 15:57:12 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-203.ams2.redhat.com [10.36.114.203])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1342619D7C;
 Mon,  6 Jul 2020 15:57:09 +0000 (UTC)
Date: Mon, 6 Jul 2020 17:57:08 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH 5/6] migration: support excluding block devs in QMP
 snapshot commands
Message-ID: <20200706155708.GD5052@linux.fritz.box>
References: <20200702175754.2211821-1-berrange@redhat.com>
 <20200702175754.2211821-6-berrange@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200702175754.2211821-6-berrange@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:39:15
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
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 02.07.2020 um 19:57 hat Daniel P. Berrangé geschrieben:
> This wires up support for a new "exclude" parameter to the QMP commands
> for snapshots (savevm, loadvm, delvm). This parameter accepts a list of
> block driver state node names.
> 
> One use case for this would be a VM using OVMF firmware where the
> variables store is a raw disk image. Ideally the variable store would be
> qcow2, allowing its contents to be included in the snapshot, but
> typically today the variable store is raw. It is still useful to be able
> to snapshot VMs using OVMF, even if the varstore is excluded, as the
> main OS disk content is usually the stuff the user cares about.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Wouldn't it be better to take an optional list of nodes to _include_
that just defaults to our current set of nodes?

The problem with excluding is that we already don't snapshot many nodes,
and the criteria to choose the right ones weren't entirely obvious, so
we just went with something that seemed to make the most sense. But the
management application may actually want to snapshot more nodes than we
cover by default.

I feel things become clearer and less surprising if the client just
tells us explicitly which images are supposed to be snapshotted instead
of adding exceptions on top of a default selection that we're already
not really sure about.

Kevin


