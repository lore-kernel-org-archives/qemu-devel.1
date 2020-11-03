Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EF3C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 10:25:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0277206F1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 10:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CSi7uPPh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0277206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZtVd-0002xJ-LH
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 05:25:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kZtUz-0002Sn-Ab
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 05:25:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40914)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kZtUt-0000Vs-Rf
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 05:25:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604399101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Bx/msDzPZ0tNVuhA/+VSrPWXvqNglYbs4HeszIUTGg=;
 b=CSi7uPPh5BHfYMY7Y2S1tO/0aluSXkecIRV9PvDf56j7pyVs+Z3d7VfVrLDhODaXwllw0J
 IV0O7WK038LsRwDEoomcWDts8WutWNPiyDdYCaDEz+mL73vyZpEMsHrwpucZUxNUWuo6Nx
 OtvuIIUpWidC58aZ///t4KNHlQWYG3g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-1fV8Od4lPKmLEhAPDM1gVQ-1; Tue, 03 Nov 2020 05:25:00 -0500
X-MC-Unique: 1fV8Od4lPKmLEhAPDM1gVQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1457B59;
 Tue,  3 Nov 2020 10:24:59 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.195.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 25ED55C5FD;
 Tue,  3 Nov 2020 10:24:50 +0000 (UTC)
Subject: Re: [PULL 10/12] virtiofsd: Announce sub-mount points
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, peterx@redhat.com, philmd@redhat.com,
 zhangjiachen.jaycee@bytedance.com
References: <20201102195657.219501-1-dgilbert@redhat.com>
 <20201102195657.219501-11-dgilbert@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a52b74d6-933d-7c44-ab06-725b5f38c4d1@redhat.com>
Date: Tue, 3 Nov 2020 11:24:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201102195657.219501-11-dgilbert@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: stefanha@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02.11.20 20:56, Dr. David Alan Gilbert (git) wrote:
> From: Max Reitz <mreitz@redhat.com>
> 
> Whenever we encounter a directory with an st_dev or mount ID that
> differs from that of its parent, we set the FUSE_ATTR_SUBMOUNT flag so
> the guest can create a submount for it.
> 
> We only need to do so in lo_do_lookup().  The following functions return
> a fuse_attr object:
> - lo_create(), though fuse_reply_create(): Calls lo_do_lookup().
> - lo_lookup(), though fuse_reply_entry(): Calls lo_do_lookup().
> - lo_mknod_symlink(), through fuse_reply_entry(): Calls lo_do_lookup().
> - lo_link(), through fuse_reply_entry(): Creating a link cannot create a
>   submount, so there is no need to check for it.
> - lo_getattr(), through fuse_reply_attr(): Announcing submounts when the
>   node is first detected (at lookup) is sufficient.  We do not need to
>   return the submount attribute later.
> - lo_do_readdir(), through fuse_add_direntry_plus(): Calls
>   lo_do_lookup().
> 
> Make announcing submounts optional, so submounts are only announced to
> the guest with the announce_submounts option.  Some users may prefer the
> current behavior, so that the guest learns nothing about the host mount
> structure.
> 
> (announce_submounts is force-disabled when the guest does not present
> the FUSE_SUBMOUNTS capability, or when there is no statx().)
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Message-Id: <20201102161859.156603-6-mreitz@redhat.com>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  tools/virtiofsd/helper.c         |  1 +
>  tools/virtiofsd/passthrough_ll.c | 22 ++++++++++++++++++++++
>  2 files changed, 23 insertions(+)

> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
[...]

> index 34d107975f..ec1008bceb 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c

[...]

> @@ -601,6 +604,20 @@ static void lo_init(void *userdata, struct fuse_conn_info *conn)

[...]

> +#ifndef CONFIG_STATX
> +    if (lo->announce_submounts) {
> +        fuse_log(FUSE_LOG_WARNING, "lo_init: Cannot announce submounts, there "
> +                 "is no statx()\n");
> +        lo->announce_submounts = false;
> +    }
> +#endif

When reviewing this series, Miklos noted today that this warning is
wrong (we can still announce submounts even without statx()), and we
concluded that we should probably drop it and the
“lo->announce_submounts = false” assignment (i.e. this whole block).

I don’t think that needs to stop this pull request, though, we can
easily fix it on top.

Max


