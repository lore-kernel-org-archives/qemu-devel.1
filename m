Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05E3C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 17:46:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23E5D206B2
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 17:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HWGmZOoq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23E5D206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3jyX-00026p-O8
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 13:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k3jxw-0001fi-QU
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 13:46:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53605
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k3jxu-00049K-QS
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 13:46:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596735965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dq43EQlhYyIbzxg9EEDi7sEZvpnlQYEC3rQx4OESku0=;
 b=HWGmZOoqNptuLgijoJnCDiWf+fuOtWkXRo3RrY72sPsCsgRbMb2XAWndo13HghoWRCey1F
 +oAVJXnYimZPpTZTtwXgSZqOCOeb/yaQv3XvjzCtH4SB5a0a+OvG+sAqnFQk3rsSh7vG15
 2jCFfZRs9HEcIu+PGZpV1CdElGcH6Y0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-rBdWWkhfM3G-wFN2SrJ4Uw-1; Thu, 06 Aug 2020 13:46:04 -0400
X-MC-Unique: rBdWWkhfM3G-wFN2SrJ4Uw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3406680046B;
 Thu,  6 Aug 2020 17:46:03 +0000 (UTC)
Received: from work-vm (ovpn-114-105.ams2.redhat.com [10.36.114.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 812BF1010405;
 Thu,  6 Aug 2020 17:45:58 +0000 (UTC)
Date: Thu, 6 Aug 2020 18:45:56 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] virtiofsd: Disable remote posix locks by default
Message-ID: <20200806174556.GL2711@work-vm>
References: <20200727161841.GA54539@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200727161841.GA54539@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 00:24:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: virtio-fs-list <virtio-fs@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>,
 qemu-devel@nongnu.org, jimbothom@yandex.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Vivek Goyal (vgoyal@redhat.com) wrote:
> Right now we enable remote posix locks by default. That means when guest
> does a posix lock it sends request to server (virtiofsd). But currently
> we only support non-blocking posix lock and return -EOPNOTSUPP for
> blocking version.
> 
> This means that existing applications which are doing blocking posix
> locks get -EOPNOTSUPP and fail. To avoid this, people have been
> running virtiosd with option "-o no_posix_lock". For new users it
> is still a surprise and trial and error takes them to this option.
> 
> Given posix lock implementation is not complete in virtiofsd, disable
> it by default. This means that posix locks will work with-in applications
> in a guest but not across guests. Anyway we don't support sharing
> filesystem among different guests yet in virtiofs so this should
> not lead to any kind of surprise or regression and will make life
> little easier for virtiofs users.
> 
> Reported-by: Aa Aa <jimbothom@yandex.com>
> Suggested-by: Miklos Szeredi <mszeredi@redhat.com>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>

Thanks, queued into my local dev world; I'll push it out after some
others and get it into the qemu world when it reopens.

Dave
> ---
>  tools/virtiofsd/passthrough_ll.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
> index 6514674f04..82d8c962d0 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -3208,7 +3208,7 @@ int main(int argc, char *argv[])
>      struct lo_data lo = {
>          .debug = 0,
>          .writeback = 0,
> -        .posix_lock = 1,
> +        .posix_lock = 0,
>          .proc_self_fd = -1,
>      };
>      struct lo_map_elem *root_elem;
> -- 
> 2.25.4
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


