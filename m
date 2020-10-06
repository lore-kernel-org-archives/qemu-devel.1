Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A94C4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:05:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A77F62080A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xupc+1/I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A77F62080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPkmM-0007mf-Lv
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 07:05:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kPklD-0007GH-0l
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 07:03:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51268)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kPklA-0004LJ-DC
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 07:03:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601982235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8y9whln4LwEsuW+7p4mDqE3F7osGP+omK5Mro6quS+Q=;
 b=Xupc+1/IIqgqcvvRf+khO5wcTPi7bEAg9S5DraJfHaXuqOBGyEZLOnfgcthZPTNL7bj9sZ
 QPsn0e1UYaAFZeNskXKjEaV3n7DZH6lc4IZQeEkI2bYKvtyn7dMNmeMJWLhULUDyXmRh/F
 kiR5+yQtRyTtbghBUa1Hx+6W7MHNUz4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-4mi4e1jVOHy26_luL6mIJA-1; Tue, 06 Oct 2020 07:03:53 -0400
X-MC-Unique: 4mi4e1jVOHy26_luL6mIJA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D25987950C
 for <qemu-devel@nongnu.org>; Tue,  6 Oct 2020 11:03:52 +0000 (UTC)
Received: from work-vm (ovpn-114-216.ams2.redhat.com [10.36.114.216])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AFC8910013DB;
 Tue,  6 Oct 2020 11:03:41 +0000 (UTC)
Date: Tue, 6 Oct 2020 12:03:39 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] virtiofsd: avoid /proc/self/fd tempdir
Message-ID: <20201006110339.GC3000@work-vm>
References: <20201006095826.59813-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201006095826.59813-1-stefanha@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 00:55:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: virtio-fs@redhat.com, Miklos Szeredi <mszeredi@redhat.com>,
 Jens Freimann <jfreimann@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Stefan Hajnoczi (stefanha@redhat.com) wrote:
> In order to prevent /proc/self/fd escapes a temporary directory is
> created where /proc/self/fd is bind-mounted. This doesn't work on
> read-only file systems.
> 
> Avoid the temporary directory by bind-mounting /proc/self/fd over /proc.
> This does not affect other processes since we remounted / with MS_REC |
> MS_SLAVE. /proc must exist and virtiofsd does not use it so it's safe to
> do this.
> 
> Path traversal can be tested with the following function:
> 
>   static void test_proc_fd_escape(struct lo_data *lo)
>   {
>       int fd;
>       int level = 0;
>       ino_t last_ino = 0;
> 
>       fd = lo->proc_self_fd;
>       for (;;) {
>           struct stat st;
> 
>           if (fstat(fd, &st) != 0) {
>               perror("fstat");
>               return;
>           }
>           if (last_ino && st.st_ino == last_ino) {
>               fprintf(stderr, "inode number unchanged, stopping\n");
>               return;
>           }
>           last_ino = st.st_ino;
> 
>           fprintf(stderr, "Level %d dev %lu ino %lu\n", level,
>                   (unsigned long)st.st_dev,
>                   (unsigned long)last_ino);
>           fd = openat(fd, "..", O_PATH | O_DIRECTORY | O_NOFOLLOW);
>           level++;
>       }
>   }
> 
> Before and after this patch only Level 0 is displayed. Without
> /proc/self/fd bind-mount protection it is possible to traverse parent
> directories.
> 
> Fixes: 397ae982f4df4 ("virtiofsd: jail lo->proc_self_fd")
> Cc: Miklos Szeredi <mszeredi@redhat.com>
> Cc: Jens Freimann <jfreimann@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Yes, getting rid of the tmpdir altogether seems better.


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  tools/virtiofsd/passthrough_ll.c | 34 +++++++++++---------------------
>  1 file changed, 11 insertions(+), 23 deletions(-)
> 
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
> index 0b229ebd57..6ae7ffcdd7 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -2393,8 +2393,6 @@ static void setup_wait_parent_capabilities(void)
>  static void setup_namespaces(struct lo_data *lo, struct fuse_session *se)
>  {
>      pid_t child;
> -    char template[] = "virtiofsd-XXXXXX";
> -    char *tmpdir;
>  
>      /*
>       * Create a new pid namespace for *child* processes.  We'll have to
> @@ -2458,33 +2456,23 @@ static void setup_namespaces(struct lo_data *lo, struct fuse_session *se)
>          exit(1);
>      }
>  
> -    tmpdir = mkdtemp(template);
> -    if (!tmpdir) {
> -        fuse_log(FUSE_LOG_ERR, "tmpdir(%s): %m\n", template);
> +    /*
> +     * We only need /proc/self/fd. Prevent ".." from accessing parent
> +     * directories of /proc/self/fd by bind-mounting it over /proc. Since / was
> +     * previously remounted with MS_REC | MS_SLAVE this mount change only
> +     * affects our process.
> +     */
> +    if (mount("/proc/self/fd", "/proc", NULL, MS_BIND, NULL) < 0) {
> +        fuse_log(FUSE_LOG_ERR, "mount(/proc/self/fd, MS_BIND): %m\n");
>          exit(1);
>      }
>  
> -    if (mount("/proc/self/fd", tmpdir, NULL, MS_BIND, NULL) < 0) {
> -        fuse_log(FUSE_LOG_ERR, "mount(/proc/self/fd, %s, MS_BIND): %m\n",
> -                 tmpdir);
> -        exit(1);
> -    }
> -
> -    /* Now we can get our /proc/self/fd directory file descriptor */
> -    lo->proc_self_fd = open(tmpdir, O_PATH);
> +    /* Get the /proc (actually /proc/self/fd, see above) file descriptor */
> +    lo->proc_self_fd = open("/proc", O_PATH);
>      if (lo->proc_self_fd == -1) {
> -        fuse_log(FUSE_LOG_ERR, "open(%s, O_PATH): %m\n", tmpdir);
> +        fuse_log(FUSE_LOG_ERR, "open(/proc, O_PATH): %m\n");
>          exit(1);
>      }
> -
> -    if (umount2(tmpdir, MNT_DETACH) < 0) {
> -        fuse_log(FUSE_LOG_ERR, "umount2(%s, MNT_DETACH): %m\n", tmpdir);
> -        exit(1);
> -    }
> -
> -    if (rmdir(tmpdir) < 0) {
> -        fuse_log(FUSE_LOG_ERR, "rmdir(%s): %m\n", tmpdir);
> -    }
>  }
>  
>  /*
> -- 
> 2.26.2
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


