Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0048BC4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 16:33:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3213A2072E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 16:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bH5uak1q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3213A2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNf2w-00082v-T5
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 12:33:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kNexz-00060S-Oy
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 12:28:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50240)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kNext-0005Gn-Oi
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 12:28:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601483305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IWlejYLOEtME4/CaNiqiGmYDlL/+xu/chVBf3n34s/k=;
 b=bH5uak1qtOabZbFuw9tyQoUFWbQa00jUDnqOF+Vql4XVeM21aLjVRLkeSiojYLPuEIMJkf
 A+mGbN9hB9/BjJWqOdYygTq7uC9cOGsndoMSI2pUGlS/c8plluBZLUcVWs9FjuKoFNhj0Z
 zyOP9WPKB270vVBrAD18CrzymO6a3W0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-ogGcZkvSMruCtppv2Y1Rqg-1; Wed, 30 Sep 2020 12:28:10 -0400
X-MC-Unique: ogGcZkvSMruCtppv2Y1Rqg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86E8F1019627;
 Wed, 30 Sep 2020 16:28:09 +0000 (UTC)
Received: from work-vm (ovpn-114-238.ams2.redhat.com [10.36.114.238])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8653878807;
 Wed, 30 Sep 2020 16:28:00 +0000 (UTC)
Date: Wed, 30 Sep 2020 17:27:57 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 4/4] virtiofsd: avoid false positive compiler warning
Message-ID: <20200930162757.GD2783@work-vm>
References: <20200930155859.303148-1-borntraeger@de.ibm.com>
 <20200930155859.303148-5-borntraeger@de.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20200930155859.303148-5-borntraeger@de.ibm.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Christian Borntraeger (borntraeger@de.ibm.com) wrote:
> make: *** [Makefile:121: config-host.mak] Error 1
> [cborntra@m83lp52 qemu]$ make -C build/
> make: Entering directory '/home/cborntra/REPOS/qemu/build'
> Generating qemu-version.h with a meson_exe.py custom command
> Compiling C object tools/virtiofsd/virtiofsd.p/passthrough_ll.c.o
> ../tools/virtiofsd/passthrough_ll.c: In function ‘lo_setattr’:
> ../tools/virtiofsd/passthrough_ll.c:702:19: error: ‘fd’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
>   702 |             res = futimens(fd, tv);
>       |                   ^~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make: *** [Makefile.ninja:1438: tools/virtiofsd/virtiofsd.p/passthrough_ll.c.o] Error 1
> make: Leaving directory '/home/cborntra/REPOS/
> 
> as far as I can see this can not happen. Let us silence the warning by
> giving fd a default value.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

Yeh, I'd posted https://www.mail-archive.com/qemu-devel@nongnu.org/msg738783.html
but not yet merged it; only difference is I'd used -1 since it seemd
safer to use -1 even if it couldn't happen :-)

Dave

> ---
>  tools/virtiofsd/passthrough_ll.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
> index 0b229ebd5786..da06aa6e9264 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -620,7 +620,7 @@ static void lo_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
>      struct lo_inode *inode;
>      int ifd;
>      int res;
> -    int fd;
> +    int fd = 0;
>  
>      inode = lo_inode(req, ino);
>      if (!inode) {
> -- 
> 2.26.2
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


