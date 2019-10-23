Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899F6CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 09:51:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52AC72064A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 09:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gx2cuvcO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52AC72064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNDIm-0006VS-GY
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 05:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36700)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iNDED-0004I1-NH
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 05:47:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iNDE9-0004Ai-P7
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 05:46:51 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35145
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iNDE9-0004AM-Kg
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 05:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571824008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Y2t/BhyVmvDozLXHPKCzDy1H1TUrEvSVf9l6QuSFEM=;
 b=gx2cuvcOmjXR0Qd8A+rBgKlb81DSIgitadFDXsw9M4e7J4jd74ocp4VtM4FxKMXngqJICz
 D8Tmn4x8yVqy4vbX+qcqfAnDOECTnVO6Ous+2XJx3huiXTBOC6X0dMW7K7zt9aAwcmD8xw
 4aJqqhxrTlihMRYjQXEVf3TVJEc6a1c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-3gdE4MFZPIiBuVufVgZDKQ-1; Wed, 23 Oct 2019 05:46:46 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0B201800D6B
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 09:46:45 +0000 (UTC)
Received: from work-vm (ovpn-117-198.ams2.redhat.com [10.36.117.198])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8261E600CC;
 Wed, 23 Oct 2019 09:46:39 +0000 (UTC)
Date: Wed, 23 Oct 2019 10:46:36 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 2/2] virtiofsd: move to a new pid namespace
Message-ID: <20191023094636.GB2834@work-vm>
References: <20191016160157.12414-1-stefanha@redhat.com>
 <20191016160157.12414-3-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191016160157.12414-3-stefanha@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 3gdE4MFZPIiBuVufVgZDKQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Stefan Hajnoczi (stefanha@redhat.com) wrote:
> virtiofsd needs access to /proc/self/fd.  Let's move to a new pid
> namespace so that a compromised process cannot see another other
> processes running on the system.
>=20
> One wrinkle in this approach: unshare(CLONE_NEWPID) affects *child*
> processes and not the current process.  Therefore we need to fork the
> pid 1 process that will actually run virtiofsd and leave a parent in
> waitpid(2).  This is not the same thing as daemonization and parent
> processes should not notice a difference.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

OK, I think that's OK (I don't know the mount semantics that well).

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  contrib/virtiofsd/passthrough_ll.c | 95 ++++++++++++++++++++++--------
>  1 file changed, 72 insertions(+), 23 deletions(-)
>=20
> diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/passt=
hrough_ll.c
> index c27ff7d800..b6ee9b2e90 100644
> --- a/contrib/virtiofsd/passthrough_ll.c
> +++ b/contrib/virtiofsd/passthrough_ll.c
> @@ -56,9 +56,12 @@
>  #include <sys/xattr.h>
>  #include <sys/mman.h>
>  #include <sys/socket.h>
> +#include <sys/types.h>
>  #include <sys/un.h>
> +#include <sys/wait.h>
>  #include <sys/capability.h>
> =20
> +
>  #include "ireg.h"
>  #include <sys/mount.h>
>  #include <sys/resource.h>
> @@ -2749,6 +2752,72 @@ static void setup_net_namespace(void)
>  =09}
>  }
> =20
> +/*
> + * Move to a new pid namespace to prevent access to other processes if t=
his
> + * process is compromised.
> + */
> +static void setup_pid_namespace(void)
> +{
> +=09pid_t child;
> +
> +=09/*
> +=09 * Create a new pid namespace for *child* processes.  We'll have to
> +=09 * fork in order to enter the new pid namespace.  A new mount namespa=
ce
> +=09 * is also needed so that we can remount /proc for the new pid
> +=09 * namespace.
> +=09 */
> +=09if (unshare(CLONE_NEWPID | CLONE_NEWNS) !=3D 0) {
> +=09=09fuse_log(FUSE_LOG_ERR, "unshare(CLONE_NEWPID | CLONE_NEWNS): %m\n"=
);
> +=09=09exit(1);
> +=09}
> +
> +=09child =3D fork();
> +=09if (child < 0) {
> +=09=09fuse_log(FUSE_LOG_ERR, "fork() failed: %m\n");
> +=09=09exit(1);
> +=09}
> +=09if (child > 0) {
> +=09=09pid_t waited;
> +=09=09int wstatus;
> +
> +=09=09/* The parent waits for the child */
> +=09=09do {
> +=09=09=09waited =3D waitpid(child, &wstatus, 0);
> +=09=09} while (waited < 0 && errno =3D=3D EINTR);
> +
> +=09=09if (WIFEXITED(wstatus)) {
> +=09=09=09exit(WEXITSTATUS(wstatus));
> +=09=09}
> +
> +=09=09exit(1);
> +=09}
> +
> +=09/*
> +=09 * If the mounts have shared propagation then we want to opt out so o=
ur
> +=09 * mount changes don't affect the parent mount namespace.
> +=09 */
> +=09if (mount(NULL, "/", NULL, MS_REC|MS_SLAVE, NULL) < 0) {
> +=09=09fuse_log(FUSE_LOG_ERR, "mount(/, MS_REC|MS_SLAVE): %m\n");
> +=09=09exit(1);
> +=09}
> +
> +=09/* The child must remount /proc to use the new pid namespace */
> +=09if (mount("proc", "/proc", "proc",
> +=09=09  MS_NODEV | MS_NOEXEC | MS_NOSUID | MS_RELATIME, NULL) < 0) {
> +=09=09fuse_log(FUSE_LOG_ERR, "mount(/proc): %m\n");
> +=09=09exit(1);
> +=09}
> +}
> +
> +static void setup_proc_self_fd(struct lo_data *lo)
> +{
> +=09lo->proc_self_fd =3D open("/proc/self/fd", O_PATH);
> +=09if (lo->proc_self_fd =3D=3D -1) {
> +=09=09fuse_log(FUSE_LOG_ERR, "open(/proc/self/fd, O_PATH): %m\n");
> +=09=09exit(1);
> +=09}
> +}
> +
>  /* This magic is based on lxc's lxc_pivot_root() */
>  static void setup_pivot_root(const char *source)
>  {
> @@ -2803,20 +2872,10 @@ static void setup_pivot_root(const char *source)
> =20
>  /*
>   * Make the source directory our root so symlinks cannot escape and no o=
ther
> - * files are accessible.
> + * files are accessible.  Assumes unshare(CLONE_NEWNS) was already calle=
d.
>   */
>  static void setup_mount_namespace(const char *source)
>  {
> -=09if (unshare(CLONE_NEWNS) !=3D 0) {
> -=09=09fuse_log(FUSE_LOG_ERR, "unshare(CLONE_NEWNS): %m\n");
> -=09=09exit(1);
> -=09}
> -
> -=09if (mount(NULL, "/", NULL, MS_REC|MS_SLAVE, NULL) < 0) {
> -=09=09fuse_log(FUSE_LOG_ERR, "mount(/, MS_REC|MS_PRIVATE): %m\n");
> -=09=09exit(1);
> -=09}
> -
>  =09if (mount(source, source, NULL, MS_BIND, NULL) < 0) {
>  =09=09fuse_log(FUSE_LOG_ERR, "mount(%s, %s, MS_BIND): %m\n", source, sou=
rce);
>  =09=09exit(1);
> @@ -2831,6 +2890,8 @@ static void setup_mount_namespace(const char *sourc=
e)
>   */
>  static void setup_sandbox(struct lo_data *lo, bool enable_syslog)
>  {
> +=09setup_pid_namespace();
> +=09setup_proc_self_fd(lo);
>  =09setup_net_namespace();
>  =09setup_mount_namespace(lo->source);
>  =09setup_seccomp(enable_syslog);
> @@ -2860,15 +2921,6 @@ static void setup_root(struct lo_data *lo, struct =
lo_inode *root)
>  =09g_atomic_int_set(&root->refcount, 2);
>  }
> =20
> -static void setup_proc_self_fd(struct lo_data *lo)
> -{
> -=09lo->proc_self_fd =3D open("/proc/self/fd", O_PATH);
> -=09if (lo->proc_self_fd =3D=3D -1) {
> -=09=09fuse_log(FUSE_LOG_ERR, "open(/proc/self/fd, O_PATH): %m\n");
> -=09=09exit(1);
> -=09}
> -}
> -
>  /* Raise the maximum number of open file descriptors to the system limit=
 */
>  static void setup_nofile_rlimit(void)
>  {
> @@ -3110,9 +3162,6 @@ int main(int argc, char *argv[])
>  =09=09get_shared(&lo, &lo.root);
>  =09}
> =20
> -=09/* Must be after daemonize to get the right /proc/self/fd */
> -=09setup_proc_self_fd(&lo);
> -
>  =09setup_sandbox(&lo, opts.syslog);
> =20
>  =09setup_root(&lo, &lo.root);
> --=20
> 2.21.0
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


