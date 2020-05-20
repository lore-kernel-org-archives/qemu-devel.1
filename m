Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F231C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:25:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD5962065F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Og7+IYrH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD5962065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbK2l-0002SH-Ut
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 04:25:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jbK2B-0001sE-9b
 for qemu-devel@nongnu.org; Wed, 20 May 2020 04:25:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45068
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jbK2A-000357-5k
 for qemu-devel@nongnu.org; Wed, 20 May 2020 04:25:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589963101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SjOOf9UsDZ6qokOxIyQbup5jJ4LAituaR9F3x2Ax5uo=;
 b=Og7+IYrHkF4Giqh72TejbqzB2UofXSvARU1tq4S+RmxRn6ZZP8i+enIl05XsWP2JpeN/F5
 IwxTxKqRDYKx9IkXi0FIOj2vjsN5coDdl3uVJCelmusraBfY2M/j1qKZJBpf78AWKzPRvy
 G70ohFfcbX580p+w136Cx6J/ZUjuzWM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-798qJTM_NhyXHvPxwIlzYQ-1; Wed, 20 May 2020 04:24:59 -0400
X-MC-Unique: 798qJTM_NhyXHvPxwIlzYQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38E74107ACCA;
 Wed, 20 May 2020 08:24:58 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-58.ams2.redhat.com [10.36.114.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 688DF60C05;
 Wed, 20 May 2020 08:24:57 +0000 (UTC)
Date: Wed, 20 May 2020 10:24:55 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Masayoshi Mizuma <msys.mizuma@gmail.com>
Subject: Re: Question: How do I discard any changes for the device which is
 set by blockdev option?
Message-ID: <20200520082455.GA5192@linux.fritz.box>
References: <20200519175659.4poxgjmp4xoufl7h@gabell>
MIME-Version: 1.0
In-Reply-To: <20200519175659.4poxgjmp4xoufl7h@gabell>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 01:34:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 19.05.2020 um 19:56 hat Masayoshi Mizuma geschrieben:
> Hello,
> 
> I would like to discard any changes while the qemu guest OS is done.
> I can do that with snapshot and drive option.
> However, snapshot option doesn't work for the device which set by
> blockdev option like as:
> 
> $QEMU --enable-kvm \
>       -m 1024 \
>       -nographic \
>       -serial mon:stdio \
>       -blockdev driver=file,node-name=mydisk,filename=/mnt/fedora.qcow2 \
>       -blockdev driver=qcow2,node-name=vda,file=mydisk \
>       -device virtio-blk-pci,drive=vda,bootindex=1 \
>       -snapshot
> 
> I would like to use blockdev option to set the device because
> libvirt uses blockdev option for disk element.
> 
> If there's no way to do so, does that make sense to get available
> snapshot option to blockdev as well? If that makes sense, I'll try to
> implement that.

The idea with -blockdev is that you have control over every single layer
in the block device tree and manage everything explicitly. This is
mainly useful for management applications, but of course also provides
more control to human users where necessary, at the cost of being less
convenient than -drive.

-snapshot is pretty much the opposite: It's a high-level convenience
option where you basically tell QEMU that you don't care about the
details, but you just want to get some temporary overlay.

So the expected way to achieve the same functionality with -blockdev is
that you create a temporary qcow2 overlay file that has your real image
as its backing file (this is what -snapshot really does) and then open
that explicitly.

As you correctly concluded, this is something that libvirt should
probably implement.

Kevin


