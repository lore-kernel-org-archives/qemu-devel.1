Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD607C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 12:27:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74AAF216F4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 12:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R5pAcHc/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74AAF216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iafMq-0004al-H5
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 07:27:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48068)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iaeQD-0003pt-57
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 06:26:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iaeQ8-0006pR-78
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 06:26:45 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41661
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iaeQ6-0006lc-8N
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 06:26:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575026800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GdJ7wFtpkbCYQb0UUv7JqqkrdQ5bZAFgG4V/lCfE4cs=;
 b=R5pAcHc/X3Lw+xUFHeO+6FkoqksUqHh8nvPO6CP9O7w4iYiI2D+csRFNmrKOc3X/OFhjE3
 asA4NtTBsl8/LYRs9biIBPbcr3H8N5orGb45dnm8oDRjtzVmRt5kU90adEabrf2dJ0t7QZ
 qEe/i9w/ZyvvgG1J+AqHD8Xt8VIQu/w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-XDe4H-CyODK-p-4lczFucw-1; Fri, 29 Nov 2019 06:26:38 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DAE3980183C;
 Fri, 29 Nov 2019 11:26:37 +0000 (UTC)
Received: from work-vm (ovpn-117-253.ams2.redhat.com [10.36.117.253])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C34EA19C4F;
 Fri, 29 Nov 2019 11:26:36 +0000 (UTC)
Date: Fri, 29 Nov 2019 11:26:34 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] build: rename CONFIG_LIBCAP to CONFIG_LIBCAP_NG
Message-ID: <20191129112634.GB2837@work-vm>
References: <20191129111632.22840-1-pbonzini@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191129111632.22840-1-pbonzini@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: XDe4H-CyODK-p-4lczFucw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: berrange@redhat.com, qemu-devel@nongnu.org, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Paolo Bonzini (pbonzini@redhat.com) wrote:
> Since we are using the newer capng library, rename the symbol to match.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  configure             |  2 +-
>  qemu-bridge-helper.c  |  6 +++---
>  scsi/qemu-pr-helper.c | 12 ++++++------
>  3 files changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/configure b/configure
> index 6099be1d84..afe9393f04 100755
> --- a/configure
> +++ b/configure
> @@ -6759,7 +6759,7 @@ if test "$l2tpv3" =3D "yes" ; then
>    echo "CONFIG_L2TPV3=3Dy" >> $config_host_mak
>  fi
>  if test "$cap_ng" =3D "yes" ; then
> -  echo "CONFIG_LIBCAP=3Dy" >> $config_host_mak
> +  echo "CONFIG_LIBCAP_NG=3Dy" >> $config_host_mak
>  fi
>  echo "CONFIG_AUDIO_DRIVERS=3D$audio_drv_list" >> $config_host_mak
>  for drv in $audio_drv_list; do
> diff --git a/qemu-bridge-helper.c b/qemu-bridge-helper.c
> index 3d50ec094c..88b26747fc 100644
> --- a/qemu-bridge-helper.c
> +++ b/qemu-bridge-helper.c
> @@ -43,7 +43,7 @@
> =20
>  #include "net/tap-linux.h"
> =20
> -#ifdef CONFIG_LIBCAP
> +#ifdef CONFIG_LIBCAP_NG
>  #include <cap-ng.h>
>  #endif
> =20
> @@ -207,7 +207,7 @@ static int send_fd(int c, int fd)
>      return sendmsg(c, &msg, 0);
>  }
> =20
> -#ifdef CONFIG_LIBCAP
> +#ifdef CONFIG_LIBCAP_NG
>  static int drop_privileges(void)
>  {
>      /* clear all capabilities */
> @@ -246,7 +246,7 @@ int main(int argc, char **argv)
>      int access_allowed, access_denied;
>      int ret =3D EXIT_SUCCESS;
> =20
> -#ifdef CONFIG_LIBCAP
> +#ifdef CONFIG_LIBCAP_NG
>      /* if we're run from an suid binary, immediately drop privileges pre=
serving
>       * cap_net_admin */
>      if (geteuid() =3D=3D 0 && getuid() !=3D geteuid()) {
> diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
> index debb18f4aa..0659ceef09 100644
> --- a/scsi/qemu-pr-helper.c
> +++ b/scsi/qemu-pr-helper.c
> @@ -24,7 +24,7 @@
>  #include <linux/dm-ioctl.h>
>  #include <scsi/sg.h>
> =20
> -#ifdef CONFIG_LIBCAP
> +#ifdef CONFIG_LIBCAP_NG
>  #include <cap-ng.h>
>  #endif
>  #include <pwd.h>
> @@ -70,7 +70,7 @@ static int num_active_sockets =3D 1;
>  static int noisy;
>  static int verbose;
> =20
> -#ifdef CONFIG_LIBCAP
> +#ifdef CONFIG_LIBCAP_NG
>  static int uid =3D -1;
>  static int gid =3D -1;
>  #endif
> @@ -97,7 +97,7 @@ static void usage(const char *name)
>  "                            (default '%s')\n"
>  "  -T, --trace [[enable=3D]<pattern>][,events=3D<file>][,file=3D<file>]\=
n"
>  "                            specify tracing options\n"
> -#ifdef CONFIG_LIBCAP
> +#ifdef CONFIG_LIBCAP_NG
>  "  -u, --user=3DUSER           user to drop privileges to\n"
>  "  -g, --group=3DGROUP         group to drop privileges to\n"
>  #endif
> @@ -827,7 +827,7 @@ static void close_server_socket(void)
>      num_active_sockets--;
>  }
> =20
> -#ifdef CONFIG_LIBCAP
> +#ifdef CONFIG_LIBCAP_NG
>  static int drop_privileges(void)
>  {
>      /* clear all capabilities */
> @@ -920,7 +920,7 @@ int main(int argc, char **argv)
>              pidfile =3D g_strdup(optarg);
>              pidfile_specified =3D true;
>              break;
> -#ifdef CONFIG_LIBCAP
> +#ifdef CONFIG_LIBCAP_NG
>          case 'u': {
>              unsigned long res;
>              struct passwd *userinfo =3D getpwnam(optarg);
> @@ -1056,7 +1056,7 @@ int main(int argc, char **argv)
>          exit(EXIT_FAILURE);
>      }
> =20
> -#ifdef CONFIG_LIBCAP
> +#ifdef CONFIG_LIBCAP_NG
>      if (drop_privileges() < 0) {
>          error_report("Failed to drop privileges: %s", strerror(errno));
>          exit(EXIT_FAILURE);
> --=20
> 2.21.0
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


