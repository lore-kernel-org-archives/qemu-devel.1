Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36406C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 08:47:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E08FC2067C
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 08:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KePLka+u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E08FC2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7xHd-00016C-54
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 04:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k7xH8-0000gf-8B
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 04:47:22 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25764
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k7xH6-0004ro-C0
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 04:47:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597740438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o4ZtICq6FUiSTy0SOYYyA7VbN0Q10E5YbHeTYNFkECs=;
 b=KePLka+u35WMo4EWWXIi5LniXKrwrwGv99HqZCTzQQN6fgvdoUq1qVXkmBy6kTSb1xuIWS
 nz7NOfMLJelOlqvVaaEpKQB0BFntq66ZsrNFSBo6fJIlYImnrfH0e8bye0ehNlo4juiUQa
 Xmhnjlb4oRpF8vGg2jgnuW5FfWkroyY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-0sD0XwlaNjOqVMkdqajEJw-1; Tue, 18 Aug 2020 04:47:16 -0400
X-MC-Unique: 0sD0XwlaNjOqVMkdqajEJw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 263E981F019;
 Tue, 18 Aug 2020 08:47:15 +0000 (UTC)
Received: from linux.fritz.box (ovpn-112-105.ams2.redhat.com [10.36.112.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E927519C4F;
 Tue, 18 Aug 2020 08:47:13 +0000 (UTC)
Date: Tue, 18 Aug 2020 10:47:12 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Nir Soffer <nsoffer@redhat.com>
Subject: Re: [RFC PATCH 06/22] qemu-nbd: Use raw block driver for --offset
Message-ID: <20200818084712.GB6865@linux.fritz.box>
References: <20200813162935.210070-1-kwolf@redhat.com>
 <20200813162935.210070-7-kwolf@redhat.com>
 <CAMRbyyu8=uFJkqCuC5BBamzHOwfXaw-rWVa+KT4gQc3bE=WKfQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMRbyyu8=uFJkqCuC5BBamzHOwfXaw-rWVa+KT4gQc3bE=WKfQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: none client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 02:16:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 17.08.2020 um 19:19 hat Nir Soffer geschrieben:
> On Thu, Aug 13, 2020 at 7:36 PM Kevin Wolf <kwolf@redhat.com> wrote:
> 
> > Instead of implementing qemu-nbd --offset in the NBD code, just put a
> > raw block node with the requested offset on top of the user image and
> > rely on that doing the job.
> >
> > This does not only simplify the nbd_export_new() interface and bring it
> > closer to the set of options that the nbd-server-add QMP command offers,
> > but in fact it also eliminates a potential source for bugs in the NBD
> > code which previously had to add the offset manually in all relevant
> > places.
> >
> 
> Just to make sure I understand this correctly -
> 
> qemu-nbd can work with:
> 
>     $ qemu-nbd 'json:{"driver": "file", "filename": "test.raw"}'
> 
> And:
> 
>     $ qemu-nbd 'json:{"driver": "raw", "file": {"driver": "file",
> "filename": "test.raw"}}'
> 
> I assumed that we always create the raw node?

No, the first form creates only the 'file' node without a 'raw' node on
top. For all practical matters, this should be the same in qemu-img or
qemu-nbd. For actually running VMs, omitting the 'raw' node where it's
not needed can improve performance a little.

What is true is that if you use a filename without specifying the driver
(i.e.  you rely on format probing), you'll get a 'raw' node on top of
the 'file' node.

> oVirt always uses the second form to make it easier to support offset,
> size, and backing.
> https://github.com/oVirt/ovirt-imageio/blob/2021164d064227d7c5e03c8da087adc66e3a577e/daemon/ovirt_imageio/_internal/qemu_nbd.py#L104
> 
> This also seems to be the way libvirt builds the nodes using -blockdev.

libvirt actually has a BZ to avoid the 'raw' node for performance when
it's not needed.

> Do we have a way to visualize the internal node graph used by
> qemu-nbd/qemu-img?

No, but as long as you explicitly specify the driver, you get exactly
what you specified.

For exploring what happens, you can pass the same json: filename to QEMU
(maybe with -hda) and then use the monitor to inspect the state.

Kevin


