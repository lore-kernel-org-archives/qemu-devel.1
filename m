Return-Path: <SRS0=cZnO=DD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00E3C2D0A8
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 07:36:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AF0F2080A
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 07:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X2VboUQ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AF0F2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kM4kw-0003kU-3r
	for qemu-devel@archiver.kernel.org; Sat, 26 Sep 2020 03:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1kM4jb-00039j-6S
 for qemu-devel@nongnu.org; Sat, 26 Sep 2020 03:35:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32569)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1kM4jZ-0005St-DN
 for qemu-devel@nongnu.org; Sat, 26 Sep 2020 03:35:06 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601105704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RI06t/WwaovAIfZnEoGhaiBphJNHbqgyhvvgcVePw+8=;
 b=X2VboUQ9YwxhoB2jYNCLkJeRs4y3cJSxMk7i0Anu4L+zh09KEdklAkG+7wexiG7xBc3YaJ
 yM5S8eRpfjdGQoMnZRp6MiXU/1gH6mDdtBhkS+0/h/yUfL1Cqdi2/dylyvhpiNrkbhSXGm
 wrj261zrTngcwVRmS0GEIVuHVAFlL7M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-W0HgJK_rOMWiW7rMDChskA-1; Sat, 26 Sep 2020 03:35:00 -0400
X-MC-Unique: W0HgJK_rOMWiW7rMDChskA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2268E800050;
 Sat, 26 Sep 2020 07:34:59 +0000 (UTC)
Received: from localhost (ovpn-112-51.ams2.redhat.com [10.36.112.51])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B84DA60BEC;
 Sat, 26 Sep 2020 07:34:58 +0000 (UTC)
Date: Sat, 26 Sep 2020 08:34:57 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 3/3] nbd: Add 'qemu-nbd -A' to expose allocation depth
Message-ID: <20200926073457.GW3888@redhat.com>
References: <20200925203249.155705-1-eblake@redhat.com>
 <20200925203249.155705-4-eblake@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200925203249.155705-4-eblake@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=rjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=rjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/26 03:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
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
Cc: Kevin Wolf <kwolf@redhat.com>, pkrempa@redhat.com, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, vsementsov@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 25, 2020 at 03:32:49PM -0500, Eric Blake wrote:
> Allow the server to expose an additional metacontext to be requested
> by savvy clients.  qemu-nbd adds a new option -A to expose the
> qemu:allocation-depth metacontext through NBD_CMD_BLOCK_STATUS; this
> can also be set via QMP when using nbd-server-add.
> 
> qemu as client can be hacked into viewing this new context by using
> the now-misnamed x-dirty-bitmap option when creating an NBD blockdev;
> although it is worth noting the decoding of how such context
> information will appear in 'qemu-img map --output=json':
> 
> NBD_STATE_DEPTH_UNALLOC => "zero":false, "data":true
> NBD_STATE_DEPTH_LOCAL => "zero":false, "data":false
> NBD_STATE_DEPTH_BACKING => "zero":true, "data":true
> 
> libnbd as client is probably a nicer way to get at the information
> without having to decipher such hacks in qemu as client. ;)

I've been meaning to add extents information to nbdinfo, or
perhaps a new tool ("nbdmap").

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-builder quickly builds VMs from scratch
http://libguestfs.org/virt-builder.1.html


