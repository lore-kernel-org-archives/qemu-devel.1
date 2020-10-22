Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888F8C388F9
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 19:22:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BE7221534
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 19:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UdsG1nDV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BE7221534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVgAQ-00030Q-3q
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 15:22:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kVg8G-0002KR-78
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 15:20:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42781)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kVg8C-0001o9-Fv
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 15:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603394410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EVQTsA2lJqovr4AdxqYGYk6ZsfXRdPPK7Pm1jHBpUhU=;
 b=UdsG1nDVkHGyWcD78Wf88b7nIeQo5STKVNRDweyq5X8D/EIogTKKW/mV5nLviS+eKQ2Dd1
 Vu8R8inlLa0sNk+tmlbhU69gwlImxwrNeM6/ZQLYntBwfVMtcku3GTfFmLypa2CqWho7XG
 H8lahniTDPdcXoji8Z1i10wkn+H49cI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-vrr54_qIOF2E6X36cEoLMw-1; Thu, 22 Oct 2020 15:20:06 -0400
X-MC-Unique: vrr54_qIOF2E6X36cEoLMw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E1CE80400B;
 Thu, 22 Oct 2020 19:20:05 +0000 (UTC)
Received: from work-vm (ovpn-114-253.ams2.redhat.com [10.36.114.253])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E5D535C1D7;
 Thu, 22 Oct 2020 19:19:56 +0000 (UTC)
Date: Thu, 22 Oct 2020 20:19:54 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v3] virtiofsd: add container-friendly -o sandbox=chroot
 option
Message-ID: <20201022191954.GK2951@work-vm>
References: <20201008085534.16070-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201008085534.16070-1-stefanha@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 08:09:01
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
Cc: vromanso@redhat.com, Daniel Walsh <dwalsh@redhat.com>,
 qemu-devel@nongnu.org, rmohr@redhat.com, virtio-fs@redhat.com,
 Al Viro <viro@zeniv.linux.org.uk>, mpatel@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Stefan Hajnoczi (stefanha@redhat.com) wrote:
> virtiofsd cannot run in a container because CAP_SYS_ADMIN is required to
> create namespaces.
> 
> Introduce a weaker sandbox mode that is sufficient in container
> environments because the container runtime already sets up namespaces.
> Use chroot to restrict path traversal to the shared directory.
> 
> virtiofsd loses the following:
> 
> 1. Mount namespace. The process chroots to the shared directory but
>    leaves the mounts in place. Seccomp rejects mount(2)/umount(2)
>    syscalls.
> 
> 2. Pid namespace. This should be fine because virtiofsd is the only
>    process running in the container.
> 
> 3. Network namespace. This should be fine because seccomp already
>    rejects the connect(2) syscall, but an additional layer of security
>    is lost. Container runtime-specific network security policies can be
>    used drop network traffic (except for the vhost-user UNIX domain
>    socket).
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

I've just tripped over another case where this probably helps (but not
yet tested...); pivot_root doesn't work if your current / isn't a
mountpoint - so you can't currently run the existing virtiofsd inside
a chroot.

(pivot_root is awful for telling you this - it has 6 different manpage
listed reasons it might return EINVAL and leaves you to figure out how
you offended it).

Dave

> ---
> v3:
>  * Rebased onto David Gilbert's latest migration & virtiofsd pull
>    request
> 
>  tools/virtiofsd/helper.c         |  8 +++++
>  tools/virtiofsd/passthrough_ll.c | 57 ++++++++++++++++++++++++++++++--
>  docs/tools/virtiofsd.rst         | 32 ++++++++++++++----
>  3 files changed, 88 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
> index 85770d63f1..2e181a49b5 100644
> --- a/tools/virtiofsd/helper.c
> +++ b/tools/virtiofsd/helper.c
> @@ -166,6 +166,14 @@ void fuse_cmdline_help(void)
>             "                               enable/disable readirplus\n"
>             "                               default: readdirplus except with "
>             "cache=none\n"
> +           "    -o sandbox=namespace|chroot\n"
> +           "                               sandboxing mode:\n"
> +           "                               - namespace: mount, pid, and net\n"
> +           "                                 namespaces with pivot_root(2)\n"
> +           "                                 into shared directory\n"
> +           "                               - chroot: chroot(2) into shared\n"
> +           "                                 directory (use in containers)\n"
> +           "                               default: namespace\n"
>             "    -o timeout=<number>        I/O timeout (seconds)\n"
>             "                               default: depends on cache= option.\n"
>             "    -o writeback|no_writeback  enable/disable writeback cache\n"
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
> index ff53df4451..5b9064278a 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -137,8 +137,14 @@ enum {
>      CACHE_ALWAYS,
>  };
>  
> +enum {
> +    SANDBOX_NAMESPACE,
> +    SANDBOX_CHROOT,
> +};
> +
>  struct lo_data {
>      pthread_mutex_t mutex;
> +    int sandbox;
>      int debug;
>      int writeback;
>      int flock;
> @@ -163,6 +169,12 @@ struct lo_data {
>  };
>  
>  static const struct fuse_opt lo_opts[] = {
> +    { "sandbox=namespace",
> +      offsetof(struct lo_data, sandbox),
> +      SANDBOX_NAMESPACE },
> +    { "sandbox=chroot",
> +      offsetof(struct lo_data, sandbox),
> +      SANDBOX_CHROOT },
>      { "writeback", offsetof(struct lo_data, writeback), 1 },
>      { "no_writeback", offsetof(struct lo_data, writeback), 0 },
>      { "source=%s", offsetof(struct lo_data, source), 0 },
> @@ -2660,6 +2672,41 @@ static void setup_capabilities(char *modcaps_in)
>      pthread_mutex_unlock(&cap.mutex);
>  }
>  
> +/*
> + * Use chroot as a weaker sandbox for environments where the process is
> + * launched without CAP_SYS_ADMIN.
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
> +     * The chroot(2) syscall is later disabled by seccomp and the
> +     * CAP_SYS_CHROOT capability is dropped so that tampering with the chroot
> +     * is not possible.
> +     *
> +     * However, it's still possible to escape the chroot via lo->proc_self_fd
> +     * but that requires first gaining control of the process.
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
>  /*
>   * Lock down this process to prevent access to other processes or files outside
>   * source directory.  This reduces the impact of arbitrary code execution bugs.
> @@ -2667,8 +2714,13 @@ static void setup_capabilities(char *modcaps_in)
>  static void setup_sandbox(struct lo_data *lo, struct fuse_session *se,
>                            bool enable_syslog)
>  {
> -    setup_namespaces(lo, se);
> -    setup_mounts(lo->source);
> +    if (lo->sandbox == SANDBOX_NAMESPACE) {
> +        setup_namespaces(lo, se);
> +        setup_mounts(lo->source);
> +    } else {
> +        setup_chroot(lo);
> +    }
> +
>      setup_seccomp(enable_syslog);
>      setup_capabilities(g_strdup(lo->modcaps));
>  }
> @@ -2815,6 +2867,7 @@ int main(int argc, char *argv[])
>      struct fuse_session *se;
>      struct fuse_cmdline_opts opts;
>      struct lo_data lo = {
> +        .sandbox = SANDBOX_NAMESPACE,
>          .debug = 0,
>          .writeback = 0,
>          .posix_lock = 0,
> diff --git a/docs/tools/virtiofsd.rst b/docs/tools/virtiofsd.rst
> index 7ecee49834..65f8e76569 100644
> --- a/docs/tools/virtiofsd.rst
> +++ b/docs/tools/virtiofsd.rst
> @@ -17,13 +17,24 @@ This program is designed to work with QEMU's ``--device vhost-user-fs-pci``
>  but should work with any virtual machine monitor (VMM) that supports
>  vhost-user.  See the Examples section below.
>  
> -This program must be run as the root user.  Upon startup the program will
> -switch into a new file system namespace with the shared directory tree as its
> -root.  This prevents "file system escapes" due to symlinks and other file
> -system objects that might lead to files outside the shared directory.  The
> -program also sandboxes itself using seccomp(2) to prevent ptrace(2) and other
> -vectors that could allow an attacker to compromise the system after gaining
> -control of the virtiofsd process.
> +This program must be run as the root user.  The program drops privileges where
> +possible during startup although it must be able to create and access files
> +with any uid/gid:
> +
> +* The ability to invoke syscalls is limited using seccomp(2).
> +* Linux capabilities(7) are dropped.
> +
> +In "namespace" sandbox mode the program switches into a new file system
> +namespace and invokes pivot_root(2) to make the shared directory tree its root.
> +A new pid and net namespace is also created to isolate the process.
> +
> +In "chroot" sandbox mode the program invokes chroot(2) to make the shared
> +directory tree its root. This mode is intended for container environments where
> +the container runtime has already set up the namespaces and the program does
> +not have permission to create namespaces itself.
> +
> +Both sandbox modes prevent "file system escapes" due to symlinks and other file
> +system objects that might lead to files outside the shared directory.
>  
>  Options
>  -------
> @@ -69,6 +80,13 @@ Options
>    * readdirplus|no_readdirplus -
>      Enable/disable readdirplus.  The default is ``readdirplus``.
>  
> +  * sandbox=namespace|chroot -
> +    Sandbox mode:
> +    - namespace: Create mount, pid, and net namespaces and pivot_root(2) into
> +    the shared directory.
> +    - chroot: chroot(2) into shared directory (use in containers).
> +    The default is "namespace".
> +
>    * source=PATH -
>      Share host directory tree located at PATH.  This option is required.
>  
> -- 
> 2.26.2
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


