Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9DDC4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 05:34:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4589206A5
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 05:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hlb6kz/x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4589206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kODhm-0001Od-QT
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 01:34:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kODgZ-0000wm-Gy
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 01:32:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20081)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kODgX-000703-L4
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 01:32:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601616768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e0FTI5Tj364X0uSEMZp2Q9D8M8aRy/nc7tEEkdAUye8=;
 b=hlb6kz/xS0/0XcbO93lF/cr1NdurwX/o45fRVkappMKY0LuZtIxfGCBDToPZql0DX4clSJ
 IQzOKanoutf4P8qQ9pjWqV0uVzUYHkjyb/LVTnPcFh/W0KOz7hz4Uoeg2CHur1WzNLAiPP
 cyxkfze73PVEWAh3WPzVWf6cyWdDGvA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-hrHMUME9P1Sv9bgjHge0Ag-1; Fri, 02 Oct 2020 01:32:47 -0400
X-MC-Unique: hrHMUME9P1Sv9bgjHge0Ag-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D714E420E7;
 Fri,  2 Oct 2020 05:32:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-101.ams2.redhat.com
 [10.36.112.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C50573693;
 Fri,  2 Oct 2020 05:32:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B45E01132784; Fri,  2 Oct 2020 07:32:39 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 1/2] block/export: add vhost-user-blk multi-queue support
References: <20201001144604.559733-1-stefanha@redhat.com>
 <20201001144604.559733-2-stefanha@redhat.com>
Date: Fri, 02 Oct 2020 07:32:39 +0200
In-Reply-To: <20201001144604.559733-2-stefanha@redhat.com> (Stefan Hajnoczi's
 message of "Thu, 1 Oct 2020 15:46:03 +0100")
Message-ID: <87tuvdry4o.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 01:13:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Coiby Xu <Coiby.Xu@gmail.com>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Stefan Hajnoczi <stefanha@redhat.com> writes:

> Allow the number of queues to be configured using --export
> vhost-user-blk,num-queues=N. This setting should match the QEMU --device
> vhost-user-blk-pci,num-queues=N setting but QEMU vhost-user-blk.c lowers
> its own value if the vhost-user-blk backend offers fewer queues than
> QEMU.
>
> The vhost-user-blk-server.c code is already capable of multi-queue. All
> virtqueue processing runs in the same AioContext. No new locking is
> needed.
>
> Add the num-queues=N option and set the VIRTIO_BLK_F_MQ feature bit.
> Note that the feature bit only announces the presence of the num_queues
> configuration space field. It does not promise that there is more than 1
> virtqueue, so we can set it unconditionally.
>
> I tested multi-queue by running a random read fio test with numjobs=4 on
> an -smp 4 guest. After the benchmark finished the guest /proc/interrupts
> file showed activity on all 4 virtio-blk MSI-X. The /sys/block/vda/mq/
> directory shows that Linux blk-mq has 4 queues configured.
>
> An automated test is included in the next commit.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  qapi/block-export.json               |  6 +++++-
>  block/export/vhost-user-blk-server.c | 24 ++++++++++++++++++------
>  2 files changed, 23 insertions(+), 7 deletions(-)
>
> diff --git a/qapi/block-export.json b/qapi/block-export.json
> index a793e34af9..17020de257 100644
> --- a/qapi/block-export.json
> +++ b/qapi/block-export.json
> @@ -93,11 +93,15 @@
>  #        SocketAddress types are supported. Passed fds must be UNIX domain
>  #        sockets.
>  # @logical-block-size: Logical block size in bytes. Defaults to 512 bytes.
> +# @num-queues: Number of request virtqueues. Must be greater than 0. Defaults
> +#              to 1.
>  #
>  # Since: 5.2
>  ##
>  { 'struct': 'BlockExportOptionsVhostUserBlk',
> -  'data': { 'addr': 'SocketAddress', '*logical-block-size': 'size' } }
> +  'data': { 'addr': 'SocketAddress',
> +	    '*logical-block-size': 'size',

Tab damage.

> +            '*num-queues': 'uint16'} }

Out of curiosity: what made you pick 16 bit signed?  net.json uses both
32 and 64 bit signed.  Odd...

>  
>  ##
>  # @NbdServerAddOptions:

Acked-by: Markus Armbruster <armbru@redhat.com>


