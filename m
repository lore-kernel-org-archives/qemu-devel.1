Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED44C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 09:57:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3146D21655
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 09:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="biQ13aWj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3146D21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVAsG-0003cw-Ux
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 05:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kVArN-00034h-Rt
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 05:56:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36497)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kVArM-0006ON-5G
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 05:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603274201;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lxGTzyPBwGWvV28ARxZgIwHiWo0XjLB61wbte7k7ySM=;
 b=biQ13aWjwt/A6TdDXeHP96KRMVVmnG8aEIoZBmwWltxDuT7OsedslsV5Ag45jvS2hM4RBT
 1nr/Viro1Ku6kJAiuks8n5ZldX0fE149sZHjXJGBk8/qGGdEBJ8JmzwWnnlGXS2iIH+QM0
 HGvP7ypZOJF99SAc3Ambxf8FDuRfHEM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-_ZsKyGyPNE-uokQMdcP3Zw-1; Wed, 21 Oct 2020 05:56:37 -0400
X-MC-Unique: _ZsKyGyPNE-uokQMdcP3Zw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61CB18064BA;
 Wed, 21 Oct 2020 09:56:36 +0000 (UTC)
Received: from redhat.com (ovpn-114-86.ams2.redhat.com [10.36.114.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AED3D5D9EF;
 Wed, 21 Oct 2020 09:56:33 +0000 (UTC)
Date: Wed, 21 Oct 2020 10:56:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 2/3] migration: Make save_snapshot() return bool, not
 0/-1
Message-ID: <20201021095630.GG412988@redhat.com>
References: <20201012122743.3390867-1-philmd@redhat.com>
 <20201012122743.3390867-3-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201012122743.3390867-3-philmd@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 12, 2020 at 02:27:42PM +0200, Philippe Mathieu-Daudé wrote:
> Just for consistency, following the example documented since
> commit e3fe3988d7 ("error: Document Error API usage rules"),
> return a boolean value indicating an error is set or not.
> 
> Acked-by: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  include/migration/snapshot.h |  9 ++++++++-
>  migration/savevm.c           | 16 ++++++++--------
>  replay/replay-debugging.c    |  2 +-
>  replay/replay-snapshot.c     |  2 +-
>  4 files changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/include/migration/snapshot.h b/include/migration/snapshot.h
> index c85b6ec75b7..a40c34307b5 100644
> --- a/include/migration/snapshot.h
> +++ b/include/migration/snapshot.h
> @@ -15,7 +15,14 @@
>  #ifndef QEMU_MIGRATION_SNAPSHOT_H
>  #define QEMU_MIGRATION_SNAPSHOT_H
>  
> -int save_snapshot(const char *name, Error **errp);
> +/**
> + * save_snapshot: Save a snapshot.
> + * @name: path to snapshot

This isn't a path, it is a name.

I'll apply this change:

  - * save_snapshot: Save a snapshot.
  - * @name: path to snapshot
  + * save_snapshot: Save an internal snapshot.
  + * @name: name of internal snapshot



Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


