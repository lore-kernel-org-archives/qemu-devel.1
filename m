Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B3DC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 14:04:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1884C20658
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 14:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QVfFnScJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1884C20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvi1a-0006jW-A3
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 10:04:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jvi0h-0005cG-H8
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 10:03:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27306
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jvi0f-00077k-MA
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 10:03:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594821824;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=An0cgTDQDExsHUbha0lBptZOM4BH5zzLNKVU8QLuQGo=;
 b=QVfFnScJxJQk9dLcWP4C1XLXrx0naPD4UTjaCQqyptGTBLfzTKtwJ9IYUOg7Qa7tHFUFhc
 HKdbIXM6kBZ50paKbFhTRIWKMuyw/oJ6KmxGakrXCO0rXH5mSex94OaCTQbQO2hASTd4MR
 q3xqX5OJdVr949kWNvq7OmC3ggsdsfM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-dGHkCk7MOsaKsaVh1PcsCg-1; Wed, 15 Jul 2020 10:03:25 -0400
X-MC-Unique: dGHkCk7MOsaKsaVh1PcsCg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E26971DE2;
 Wed, 15 Jul 2020 14:03:23 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B50F5D9CA;
 Wed, 15 Jul 2020 14:03:22 +0000 (UTC)
Date: Wed, 15 Jul 2020 15:03:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Nir Soffer <nsoffer@redhat.com>
Subject: Re: [PATCH for-5.1 1/2] block: Require aligned image size to avoid
 assertion failure
Message-ID: <20200715140319.GB88416@redhat.com>
References: <20200710142149.40962-1-kwolf@redhat.com>
 <20200710142149.40962-2-kwolf@redhat.com>
 <CAMRbyyux0eQo8vmz4JB8pT_1i4PJviQJPKiaJC6ehwjLhc649A@mail.gmail.com>
 <20200713165637.GH10318@linux.fritz.box>
 <CAMRbyysaB5MDWGz7upg-O=N2vhQn4OUdZVsqeBothYBtZyy6ZA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMRbyysaB5MDWGz7upg-O=N2vhQn4OUdZVsqeBothYBtZyy6ZA@mail.gmail.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 02:37:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 15, 2020 at 04:22:06PM +0300, Nir Soffer wrote:
> On Mon, Jul 13, 2020 at 7:56 PM Kevin Wolf <kwolf@redhat.com> wrote:
> >
> > Am 13.07.2020 um 18:33 hat Nir Soffer geschrieben:
> > > On Fri, Jul 10, 2020 at 5:22 PM Kevin Wolf <kwolf@redhat.com> wrote:
> > > >
> > > > Unaligned requests will automatically be aligned to bl.request_alignment
> > > > and we don't want to extend requests to access space beyond the end of
> > > > the image, so it's required that the image size is aligned.
> > > >
> > > > With write requests, this could cause assertion failures like this if
> > > > RESIZE permissions weren't requested:
> > > >
> > > > qemu-img: block/io.c:1910: bdrv_co_write_req_prepare: Assertion `end_sector <= bs->total_sectors || child->perm & BLK_PERM_RESIZE' failed.
> > > >
> > > > This was e.g. triggered by qemu-img converting to a target image with 4k
> > > > request alignment when the image was only aligned to 512 bytes, but not
> > > > to 4k.
> > >
> > > Was it on NFS? Shouldn't this be fix by the next patch then?
> >
> > Patch 2 makes the problem go away for NFS because NFS doesn't even
> > require the 4k alignment. But on storage that legitimately needs 4k
> > alignment (or possibly other filesystems that are misdetected), you
> > would still hit the same problem.
> 
> I want to add oVirt point of view on this. We enforce raw image
> alignment of 4k on
> file based storage, and 128m on block storage, so our raw images cannot have
> this issue.

OpenStack should have minimium alignment of 1 GB for image sizes, so
this change is also no trouble for it.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


