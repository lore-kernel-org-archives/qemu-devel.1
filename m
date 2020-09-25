Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF8AC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:06:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D33320878
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AqxOCvE1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D33320878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLpJ4-0006zW-0t
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 11:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kLpEa-00036B-3V
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:02:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34646)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kLpES-00023g-Ve
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:02:03 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601046115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2ZOOUQ1jdb5Mq1HSDu653tvrD6cEWUY5YrfsKT3iLdA=;
 b=AqxOCvE1HajIml2Oq99a0+irnYKzDruvDL+sRNTaexrWdraHd3TQCb5hdtm64TuoMODwF4
 m9gbVSPbEup7tMwiWCK6pS7sE7+ZdNrIHCK35tuYM6xoBW6z8TZt2zEQzHwemvRsuQ6xFT
 DEBW7dFxitsI1qQAE+Hxo/OMpnqAbOA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-SAPuSzc2MceQL76ZhwE9OA-1; Fri, 25 Sep 2020 11:01:51 -0400
X-MC-Unique: SAPuSzc2MceQL76ZhwE9OA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 572821882FB5;
 Fri, 25 Sep 2020 15:01:50 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-83.ams2.redhat.com [10.36.114.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E5CA655785;
 Fri, 25 Sep 2020 15:01:44 +0000 (UTC)
Date: Fri, 25 Sep 2020 17:01:42 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 4/4] block/export: add BlockExportOptions->iothread member
Message-ID: <20200925150142.GD5731@linux.fritz.box>
References: <20200925134229.246169-1-stefanha@redhat.com>
 <20200925134229.246169-5-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200925134229.246169-5-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Coiby Xu <Coiby.Xu@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 25.09.2020 um 15:42 hat Stefan Hajnoczi geschrieben:
> Make it possible to specify the iothread where the export will run.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> Note the x-blockdev-set-iothread QMP command can be used to do the same,
> but not from the command-line. And it requires sending an additional
> command.
> 
> In the long run vhost-user-blk will support per-virtqueue iothread
> mappings. But for now a single iothread makes sense and most other
> transports will just use one iothread anyway.
> ---
>  qapi/block-export.json |  4 ++++
>  block/export/export.c  | 26 +++++++++++++++++++++++++-
>  2 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/qapi/block-export.json b/qapi/block-export.json
> index 87ac5117cd..eba6f6eae9 100644
> --- a/qapi/block-export.json
> +++ b/qapi/block-export.json
> @@ -219,11 +219,15 @@
>  #                export before completion is signalled. (since: 5.2;
>  #                default: false)
>  #
> +# @iothread: The name of the iothread object where the export will run. The
> +#            default is the main loop thread. (since: 5.2)

NBD exports currently switch automatically to a different AioContext if
another user (usually a guest device using the same node) tries to
change the AioContext. I believe this is also the most useful mode in
the context of the system emulator.

I can see the need for an iothread option in qemu-storage-daemon where
usually nobody else will move the node into a different AioContext.

But we need to define the semantics more precisely and specify what
happens if another user wants to change the AioContext later. Currently,
the NBD export will allow this and just switch the AioContext - after
this patch, ignoring what the user set explicitly with this new option.

I see two options to handle this more consistently:

1. If @iothread is set, move the block node into the requested
   AioContext, and if that fails, block-export-add fails. Other users of
   the node will be denied to change the AioContext while the export is
   active.

   If @iothread is not given, it behaves like today: Use whatever
   AioContext the node is currently in and switch whenever another user
   requests it.

2. Add a bool option @fixed-iothread that determines whether other users
   can change the AioContext while the export is active.

   Giving an @iothread and fixed-iothread == true means that we'll
   enforce the given AioContext during the whole lifetime of the export.
   With fixed-iothread == false it means that we try to move the block
   node to the requested iothread if possible (but we won't fail if it
   isn't possible) and will follow any other user switching the
   AioContext of the node.

   Not giving @iothread means that we start with the current AioContext
   of the node, and @fixed-iothread then means the same as before.

Does this make sense to you?

Kevin


