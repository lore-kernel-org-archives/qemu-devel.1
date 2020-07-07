Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FB9C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:42:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1B5D2064C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eyP5naRn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1B5D2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsqfd-0002KN-Sn
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 12:42:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jsq7n-0003h4-4h
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:07:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37087
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jsq7j-00073K-Q9
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:07:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594138030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/YiqAr9e+eEUFPbEdoIPErTXKb+7N1FxdAz6Kj1cMjk=;
 b=eyP5naRnIPtOV0lrrDHAyIo9mYrAdttN0DNRvZJbdoBYp3CtmgweHrJgeQLTfu3bXit6T0
 x6UL+zghmR93TseAPM1SLbRhMDQ3xtdVZ4d9LTfjCnnURGe02Ek/XkWERkD98QHHt/VB0Z
 hKpwv/Boi6swMsZ2eX3xdSoamSIb51w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-rzJUfY8hN8e80_fpEPf_fw-1; Tue, 07 Jul 2020 12:07:08 -0400
X-MC-Unique: rzJUfY8hN8e80_fpEPf_fw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C265A10059A8;
 Tue,  7 Jul 2020 16:07:07 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-113.ams2.redhat.com [10.36.114.113])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0654473FD7;
 Tue,  7 Jul 2020 16:07:02 +0000 (UTC)
Date: Tue, 7 Jul 2020 18:07:01 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v6 08/10] iotests: Specify explicit backing format where
 sensible
Message-ID: <20200707160701.GE7002@linux.fritz.box>
References: <20200706203954.341758-1-eblake@redhat.com>
 <20200706203954.341758-9-eblake@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200706203954.341758-9-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:46:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: pkrempa@redhat.com, qemu-block@nongnu.org, kchamart@redhat.com,
 libvir-list@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 06.07.2020 um 22:39 hat Eric Blake geschrieben:
> There are many existing qcow2 images that specify a backing file but
> no format.  This has been the source of CVEs in the past, but has
> become more prominent of a problem now that libvirt has switched to
> -blockdev.  With older -drive, at least the probing was always done by
> qemu (so the only risk of a changed format between successive boots of
> a guest was if qemu was upgraded and probed differently).  But with
> newer -blockdev, libvirt must specify a format; if libvirt guesses raw
> where the image was formatted, this results in data corruption visible
> to the guest; conversely, if libvirt guesses qcow2 where qemu was
> using raw, this can result in potential security holes, so modern
> libvirt instead refuses to use images without explicit backing format.
> 
> The change in libvirt to reject images without explicit backing format
> has pointed out that a number of tools have been far too reliant on
> probing in the past.  It's time to set a better example in our own
> iotests of properly setting this parameter.
> 
> iotest calls to create, rebase, and convert are all impacted to some
> degree.  It's a bit annoying that we are inconsistent on command line
> - while all of those accept -o backing_file=...,backing_fmt=..., the
> shortcuts are different: create and rebase have -b and -F, while
> convert has -B but no -F.  (amend has no shortcuts, but the previous
> patch just deprecated the use of amend to change backing chains).
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

This breaks at least 024 and 043 for qed because qemu-img info can't
print the backing file format there (qed only saves a flag whether it's
raw or non-raw).

We can fix the output filtering during the freeze, though.

Kevin


