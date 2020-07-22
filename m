Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCE4C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 17:59:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B790208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 17:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OQfl+Jzu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B790208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyJ1J-0000aN-Bh
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 13:59:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jyJ0k-00009f-PD
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 13:58:34 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45043
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jyJ0i-0002Fb-VZ
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 13:58:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595440712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=swmjm0qPfECQMFQZ4qpoHEm6Wv9MP4vDDiM1FDOFf8k=;
 b=OQfl+Jzu6kkmClm1yHBaxskncJUU1UR6mAnRdIGKyrTo5R4eejtmT5OiMf4/krlSlRYndy
 uUZbaiAOmG7D1jpXbyQXB9epAndoInHPbNv0S1jh+ME5ea3SVKucZEiscHwfRApfBXrrnh
 AZxfbD+KF9a8MaaOVBI2EgZXWCoIRdc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-62mbyHKYOFeN0EQ0GkEA5Q-1; Wed, 22 Jul 2020 13:58:30 -0400
X-MC-Unique: 62mbyHKYOFeN0EQ0GkEA5Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D3FF58
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 17:58:29 +0000 (UTC)
Received: from work-vm (ovpn-112-43.ams2.redhat.com [10.36.112.43])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 789002B583;
 Wed, 22 Jul 2020 17:58:22 +0000 (UTC)
Date: Wed, 22 Jul 2020 18:58:20 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH for-5.1 2/3] virtiofsd: add container-friendly -o chroot
 sandboxing option
Message-ID: <20200722175820.GL2660@work-vm>
References: <20200722130206.224898-1-stefanha@redhat.com>
 <20200722130206.224898-3-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200722130206.224898-3-stefanha@redhat.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 21:28:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: virtio-fs@redhat.com, rmohr@redhat.com, qemu-devel@nongnu.org,
 vromanso@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Stefan Hajnoczi (stefanha@redhat.com) wrote:
> virtiofsd cannot run in an unprivileged container because CAP_SYS_ADMIN
> is required to create namespaces.
> 
> Introduce a weaker sandbox that is sufficient in container environments
> because the container runtime already sets up namespaces. Use chroot to
> restrict path traversal to the shared directory.
> 
> virtiofsd loses the following:
> 
> 1. Mount namespace. The process chroots to the shared directory but
>    leaves the mounts in place. Seccomp rejects mount(2)/umount(2)
>    syscalls.

OK, I'm guessing the behaviour of what happens if the host adds another
mount afterwards might be different?

> 2. Pid namespace. This should be fine because virtiofsd is the only
>    process running in the container.

Is it ? Isn't the qemu and any other vhost-user processes also in the
same container?

> 3. Network namespace. This should be fine because seccomp already
>    rejects the connect(2) syscall, but an additional layer of security
>    is lost. Container runtime-specific network security policies can be
>    used drop network traffic (except for the vhost-user UNIX domain
>    socket).

Should this be tied to the same flag - this feels different from the
chroot specific problem.

> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tools/virtiofsd/helper.c         |  3 +++
>  tools/virtiofsd/passthrough_ll.c | 44 ++++++++++++++++++++++++++++++--
>  2 files changed, 45 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
> index 3105b6c23a..7421c9ca1a 100644
> --- a/tools/virtiofsd/helper.c
> +++ b/tools/virtiofsd/helper.c
> @@ -151,6 +151,9 @@ void fuse_cmdline_help(void)
>             "    -o cache=<mode>            cache mode. could be one of \"auto, "
>             "always, none\"\n"
>             "                               default: auto\n"
> +           "    -o chroot|no_chroot        use container-friendly chroot instead\n"
> +           "                               of stronger mount namespace sandbox\n"
> +           "                               default: false\n"

I agree with Dan that something more enum like feels right

>             "    -o flock|no_flock          enable/disable flock\n"
>             "                               default: no_flock\n"
>             "    -o log_level=<level>       log level, default to \"info\"\n"
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
> index 50a164a599..990c0a8a70 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -139,6 +139,7 @@ enum {
>  
>  struct lo_data {
>      pthread_mutex_t mutex;
> +    int chroot; /* 1 - use chroot, 0 - use mount namespace */
>      int debug;
>      int writeback;
>      int flock;
> @@ -162,6 +163,8 @@ struct lo_data {
>  };
>  
>  static const struct fuse_opt lo_opts[] = {
> +    { "chroot", offsetof(struct lo_data, chroot), 1 },
> +    { "no_chroot", offsetof(struct lo_data, chroot), 0 },
>      { "writeback", offsetof(struct lo_data, writeback), 1 },
>      { "no_writeback", offsetof(struct lo_data, writeback), 0 },
>      { "source=%s", offsetof(struct lo_data, source), 0 },
> @@ -2665,6 +2668,37 @@ static void setup_capabilities(char *modcaps_in)
>      pthread_mutex_unlock(&cap.mutex);
>  }
>  
> +/*
> + * Use chroot as a weaker sandbox for environment where the process is launched
> + * without CAP_SYS_ADMIN.
> + */
> +static void setup_chroot(struct lo_data *lo)
> +{
> +    lo->proc_self_fd = open("/proc/self/fd", O_PATH);
> +    if (lo->proc_self_fd == -1) {
> +        fuse_log(FUSE_LOG_ERR, "open(\"/proc/self/fd\", O_PATH): %m\n");
> +        exit(1);
> +    }
> +
> +    /*
> +     * Make the shared directory the file system root so that FUSE_OPEN
> +     * (lo_open()) cannot escape the shared directory by opening a symlink.
> +     *
> +     * It's still possible to escape the chroot via lo->proc_self_fd but that
> +     * requires gaining control of the process first.
> +     */
> +    if (chroot(lo->source) != 0) {
> +        fuse_log(FUSE_LOG_ERR, "chroot(\"%s\"): %m\n", lo->source);
> +        exit(1);
> +    }
> +
> +    /* Move into the chroot */
> +    if (chdir("/") != 0) {
> +        fuse_log(FUSE_LOG_ERR, "chdir(\"/\"): %m\n");
> +        exit(1);
> +    }
> +}
> +

This looks OK to me, but I would prefer a check from someone who has the
experience of why the mount based sandboxing is so much more common than
old chroot.

Dave

>  /*
>   * Lock down this process to prevent access to other processes or files outside
>   * source directory.  This reduces the impact of arbitrary code execution bugs.
> @@ -2672,8 +2706,13 @@ static void setup_capabilities(char *modcaps_in)
>  static void setup_sandbox(struct lo_data *lo, struct fuse_session *se,
>                            bool enable_syslog)
>  {
> -    setup_namespaces(lo, se);
> -    setup_mounts(lo->source);
> +    if (lo->chroot) {
> +        setup_chroot(lo);
> +    } else {
> +        setup_namespaces(lo, se);
> +        setup_mounts(lo->source);
> +    }
> +
>      setup_seccomp(enable_syslog);
>      setup_capabilities(g_strdup(lo->modcaps));
>  }
> @@ -2820,6 +2859,7 @@ int main(int argc, char *argv[])
>      struct fuse_session *se;
>      struct fuse_cmdline_opts opts;
>      struct lo_data lo = {
> +        .chroot = 0,
>          .debug = 0,
>          .writeback = 0,
>          .posix_lock = 1,
> -- 
> 2.26.2
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


