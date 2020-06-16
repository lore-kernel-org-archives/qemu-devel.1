Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099BEC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:59:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE49920644
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yal4w2t4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE49920644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlD3R-00037X-1j
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jlCpH-0001Gm-7p
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 10:44:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34180
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jlCpF-0002q4-GC
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 10:44:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592318672;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=2HSSVClTbN/6CYEN6qhlS9VdcH/s7v/hFrWVyfRHp3I=;
 b=Yal4w2t4iEo/EXndBFz5uixQ1Un3KU7qvUgOn9i0OtmX0T5mSnwl/9aEu3rCkfWIfvwdku
 3w3Xmf5Iv/MzvdO9HhpN9VjpQvFTdjsFOzdM/cGzQFT8HYjh5U6ubuUIdOvqVTzjIknP81
 t+o69bq74QB6BsSn1xDiLZfrlPKivaE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-sEXjh7zBPvyNO6VCfeNGmQ-1; Tue, 16 Jun 2020 10:44:23 -0400
X-MC-Unique: sEXjh7zBPvyNO6VCfeNGmQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B6E76100CCC7;
 Tue, 16 Jun 2020 14:44:22 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8702C60BEC;
 Tue, 16 Jun 2020 14:44:09 +0000 (UTC)
Date: Tue, 16 Jun 2020 15:44:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Subject: Re: [PATCH v4 2/4] block/nbd.c: Add yank feature
Message-ID: <20200616144406.GJ550360@redhat.com>
References: <cover.1590421341.git.lukasstraub2@web.de>
 <8e6a8e61b25813cdcdf385729709ef57f6255a3e.1590421341.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8e6a8e61b25813cdcdf385729709ef57f6255a3e.1590421341.git.lukasstraub2@web.de>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 02:46:07
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 Juan Quintela <quintela@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 25, 2020 at 05:44:26PM +0200, Lukas Straub wrote:
> Register a yank function which shuts down the socket and sets
> s->state = NBD_CLIENT_QUIT. This is the same behaviour as if an
> error occured.
> 
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> ---
>  Makefile.objs |   1 +
>  block/nbd.c   | 101 ++++++++++++++++++++++++++++++++------------------
>  2 files changed, 65 insertions(+), 37 deletions(-)
> 
> diff --git a/Makefile.objs b/Makefile.objs
> index a7c967633a..8e403b81f3 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -18,6 +18,7 @@ block-obj-y += block.o blockjob.o job.o
>  block-obj-y += block/ scsi/
>  block-obj-y += qemu-io-cmds.o
>  block-obj-$(CONFIG_REPLICATION) += replication.o
> +block-obj-y += yank.o

Oh, I see this is repeated for migration and chardev code too.

Instead of doing this and relying on linker to merge duplicates,
I think we should put yank.c into util/ and built it into util-obj-y,
so it gets added to everything.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


