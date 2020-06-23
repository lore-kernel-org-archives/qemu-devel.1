Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C731EC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 10:41:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 928C020706
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 10:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hc/WiWmV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 928C020706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jngMV-00034X-QN
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 06:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jngLn-0001pA-On
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 06:40:23 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59068
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jngLm-0001Nq-1m
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 06:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592908821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VJyc4JMnkXWSvuLTxwTo43jj0HzLAU7hkaprs2P4gpI=;
 b=hc/WiWmVgj7FaYBr6RTx2MtJNcpTt9qaCTHhVDt7nxa6tKnSjuasOiomc8sC+jXtegeLyD
 MgZUTzk8DwMGgWhJO4AAeXD7MVpR9sDmEjDy9AhDO2Jst78gDvqCV6/mx+Qz649HK2Xtru
 yzihWeKq1xTIrKPfpWcw+GKuB6wW6cM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-x0YCMXAGNjWZUtiIZmfwsw-1; Tue, 23 Jun 2020 06:40:17 -0400
X-MC-Unique: x0YCMXAGNjWZUtiIZmfwsw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91B19464;
 Tue, 23 Jun 2020 10:40:16 +0000 (UTC)
Received: from linux.fritz.box (ovpn-115-78.ams2.redhat.com [10.36.115.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E5CE4101E663;
 Tue, 23 Jun 2020 10:40:10 +0000 (UTC)
Date: Tue, 23 Jun 2020 12:40:09 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v5 3/7] qcow: Tolerate backing_fmt=, but warn on
 backing_fmt=raw
Message-ID: <20200623104009.GF5853@linux.fritz.box>
References: <20200403175859.863248-1-eblake@redhat.com>
 <20200403175859.863248-4-eblake@redhat.com>
 <20200505073542.GA5759@linux.fritz.box>
 <4b4f83fb-eb3d-6ae5-116a-da921ee2b403@redhat.com>
 <8c8e6d46-ad18-96a2-3d40-630566082ff5@redhat.com>
MIME-Version: 1.0
In-Reply-To: <8c8e6d46-ad18-96a2-3d40-630566082ff5@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 01:55:08
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
Cc: libvir-list@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 22.06.2020 um 23:58 hat Eric Blake geschrieben:
> On 5/5/20 10:30 AM, Eric Blake wrote:
> > On 5/5/20 2:35 AM, Kevin Wolf wrote:
> > > Am 03.04.2020 um 19:58 hat Eric Blake geschrieben:
> > > > qcow has no space in the metadata to store a backing format, and there
> > > > are existing qcow images backed both by raw or by other formats
> > > > (usually qcow) images, reliant on probing to tell the difference.
> > > > While we don't recommend the creation of new qcow images (as qcow2 is
> > > > hands-down better), we can at least insist that if the user does
> > > > request a specific format without using -u, then it must be non-raw
> > > > (as a raw backing file that gets inadvertently edited into some other
> > > > format can form a security hole); if the user does not request a
> > > > specific format or lies when using -u, then the status quo of probing
> > > > for the backing format remains intact (although an upcoming patch will
> > > > warn when omitting a format request).  Thus, when this series is
> > > > complete, the only way to use a backing file for qcow without
> > > > triggering a warning is when using -F if the backing file is non-raw
> > > > to begin with.  Note that this is only for QemuOpts usage; there is no
> > > > change to the QAPI to allow a format through -blockdev.
> > > > 
> > > > Add a new iotest 290 just for qcow, to demonstrate the new warning.
> > > > 
> > > > Signed-off-by: Eric Blake <eblake@redhat.com>
> > > 
> > > Somehow this feels backwards. Not specifying the backing file format at
> > > all isn't any safer than explicitly specifying raw.
> > > 
> > > If there is a difference at all, I would say that explicitly specifying
> > > raw means that the user is aware what they are doing. So we would have
> > > more reason to warn against raw images if the backing format isn't
> > > specified at all because then the user might not be aware that they are
> > > using a backing file that probes as raw.
> > 
> > Prior to this patch, -F does not work with qcow.  And even with this
> > patch, we still cannot store the explicit value of -F in the qcow file.
> > Anything that does not use -F must continue to work for now (although it
> > may now warn, and in fact must warn if we deprecate it), while anything
> > explicit is free to fail (since it failed already), but could also be
> > made to work (if letting it work is nicer than making it fail, and where
> > "work" may still include a warning, although it's pointless to have
> > something brand new that works but is deprecated out of the box).  So
> > the following is my summary of the two options we can choose between:
> > 
> > Option 1, qcow backed by raw is more common than qcow backed by other,
> > so we want:
> > raw <- qcow, no -F: work without warning (but if backing file is edited,
> > a future probe seeing non-raw would break image)
> > raw <- qcow, with -F: work without warning (but if backing file is
> > edited, a future probe seeing non-raw would break image)
> > other <- qcow, no -F: works but issues a warning (but backing file will
> > always probe correctly)
> > other <- qcow, with -F: fails (we cannot honor the user's explicit
> > request, because we would still have to probe)
> > 
> > Option 2, qcow backed by other is more common than qcow backed by raw,
> > so we want:
> > raw <- qcow, no -F: works but issues a warning (using a raw backing file
> > without explicit buy-in is risky)
> > raw <- qcow, with -F: works but issues a warning (explicit buy-in will
> > still require subsequent probing, and a backing file could change which
> > would break image)
> > other <- qcow, no -F: works without warning
> > other <- qcow, with -F: works without warning (later probing will still
> > see non-raw)
> > 
> > It looks like you are leaning more towards option 1, while my patch
> > leaned more towards option 2.  Anyone else want to chime in with an
> > opinion on which is safer vs. easier?
> 
> > Option 3:
> > completely deprecate qcow images with backing files, as there is no safe
> > way to do things favoring either raw (option 1) or non-raw (option 2),
> > and therefore accept -F solely for convenience with the rest of the
> > series, but always issue a warning regardless of whether -F was present.
> 
> 
> Hearing no other opinion in the meantime, I've come up with option 4:
> 
> raw <- qcow, no -F: works but issues a warning to use -F (the user should be
> explicit that they know they are using raw)
> raw <- qcow, with -F raw: a probe is attempted, if it returns anything other
> than raw, then fail (since we can't store the backing type, and the user's
> explicit type didn't match reality); otherwise works without warning (users
> tend to treat backing files as read-only, so even though editing a backing
> file could make it appear non-raw, that's less likely to happen)

Actually, even for a backing file, I think bs->probed should be set, so
the raw driver would return an I/O error if you write the magic of an
image format to the first sector. We should just add a test case to
verify this behaviour for backing files (e.g. in the context of a commit
job).

Of course, if you edit the backing file outside of QEMU, that's your
problem.

> other <- qcow, no -F: works without warning (we'll probe in future opens,
> but the probe will see the same file type and not corrupt user data)
> other <- qcow, with -F: a probe is attempted and must match, but otherwise
> works without warning (we'll still have to probe in future opens, but it's
> no worse than before)

This plan makes sense to me.

Kevin


