Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AC3C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 16:35:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEDBA20748
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 16:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iw1Zhc1A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEDBA20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k45Kp-0001oY-3i
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 12:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k45JJ-0007kt-3x
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 12:33:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26532
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k45JG-0002YJ-Gr
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 12:33:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596818012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X3Ok8bVi/khPluT5lI289nrJ81ZIAtciBHgU5joBWLA=;
 b=Iw1Zhc1A5uWNldC7xvhaFMJciDXLDKTrm+fVx2Hz7yASLP5SdTo/AJSv2W1rOBLNzYKKig
 O1d/LwzHAwk+tVQTvQzcZG93cTSjuE3ZSIGQz1jtWPo5Az5R9Wnfiy6iRh9Hwu5aqwljOR
 cjfyhnVH9u6LUNvqVsTeGgPfm+tse+0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-V_yNNqW3O36AySOvnJOClw-1; Fri, 07 Aug 2020 12:33:30 -0400
X-MC-Unique: V_yNNqW3O36AySOvnJOClw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0D90800138
 for <qemu-devel@nongnu.org>; Fri,  7 Aug 2020 16:33:29 +0000 (UTC)
Received: from work-vm (ovpn-114-9.ams2.redhat.com [10.36.114.9])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 40FB110027A6;
 Fri,  7 Aug 2020 16:33:03 +0000 (UTC)
Date: Fri, 7 Aug 2020 17:33:00 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v2 1/5] virtiofsd: Add notion of unprivileged mode
Message-ID: <20200807163300.GH2780@work-vm>
References: <20200730194736.173994-1-vgoyal@redhat.com>
 <20200730194736.173994-2-vgoyal@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200730194736.173994-2-vgoyal@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 02:21:37
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
Cc: berrange@redhat.com, vromanso@redhat.com, dwalsh@redhat.com,
 qemu-devel@nongnu.org, virtio-fs@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Vivek Goyal (vgoyal@redhat.com) wrote:
> At startup if we are running as non-root user, then internally set
> unpriviliged mode set. Also add a notion of sandbox NONE and set
> that internally in unprivileged mode. setting up namespaces and
> chroot() fails in unpriviliged mode.
> 
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  tools/virtiofsd/passthrough_ll.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
> index e2fbc614fd..cd91c4a831 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -147,11 +147,13 @@ enum {
>  enum {
>      SANDBOX_NAMESPACE,
>      SANDBOX_CHROOT,
> +    SANDBOX_NONE,
>  };
>  
>  struct lo_data {
>      pthread_mutex_t mutex;
>      int sandbox;
> +    bool unprivileged;
>      int debug;
>      int writeback;
>      int flock;
> @@ -3288,6 +3290,12 @@ int main(int argc, char *argv[])
>      lo_map_init(&lo.dirp_map);
>      lo_map_init(&lo.fd_map);
>  
> +    if (geteuid() != 0) {
> +       lo.unprivileged = true;
> +       lo.sandbox = SANDBOX_NONE;
> +       fuse_log(FUSE_LOG_DEBUG, "Running in unprivileged passthrough mode.\n");
> +    }

I don't like this being automatic; to switch to a less secure mode, the
user should have to explicitly ask for it; we don't want people
accidentally ending up with less security.

Also, I'm not sure that checking for geteuid() != 0  is the right test -
wouldn't the current virtiofsd run with a non-root user as long
as it had the correct capabilities?

I was doing to suggest we match cloud-hypervisor where we added
--disable-sandbox; but with this we now have a trinary switch;
so sandbox=none is probably the right way.

Dave

>      if (fuse_parse_cmdline(&args, &opts) != 0) {
>          goto err_out1;
>      }
> -- 
> 2.25.4
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


