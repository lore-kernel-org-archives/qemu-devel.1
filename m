Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A2EC83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 11:50:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DD1B206D7
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 11:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YYJ6r3Ve"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DD1B206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTOkj-00027K-C5
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 07:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52136)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jTOja-0000NL-Bh
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 07:49:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jTOiy-0000i8-RH
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 07:49:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29822
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jTOiy-0000hl-Dy
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 07:48:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588074506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AOyTLqnVAxrxNvi7l+LBOaZw9+Jvd8cLb4KdlUDQTos=;
 b=YYJ6r3VebHEfPHVTSL1m8ATob6xRzPiwQ4zgyqS5Kl8YweX1tCVkNavlMov2c2Zze5R0o3
 ONzwFBSXXC2jYsju7f3Ym4QsKS6MXd4kFy84v5mUrTxEvq9qcVLHj4/HMOjfG5r4i9G2gd
 G4MuvZ8PkJKapYkPHEzeitD24rfhIJo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-mWTDLapvNh-q2yVeL9kQqg-1; Tue, 28 Apr 2020 07:48:25 -0400
X-MC-Unique: mWTDLapvNh-q2yVeL9kQqg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B7C51005510
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 11:48:24 +0000 (UTC)
Received: from work-vm (ovpn-113-77.ams2.redhat.com [10.36.113.77])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 74AF95D715;
 Tue, 28 Apr 2020 11:48:17 +0000 (UTC)
Date: Tue, 28 Apr 2020 12:48:15 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 1/2] virtiofsd: only retain file system capabilities
Message-ID: <20200428114815.GC2794@work-vm>
References: <20200416164907.244868-1-stefanha@redhat.com>
 <20200416164907.244868-2-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200416164907.244868-2-stefanha@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 04:15:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org,
 Vivek Goyal <vgoyal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Stefan Hajnoczi (stefanha@redhat.com) wrote:
> virtiofsd runs as root but only needs a subset of root's Linux
> capabilities(7).  As a file server its purpose is to create and access
> files on behalf of a client.  It needs to be able to access files with
> arbitrary uid/gid owners.  It also needs to be create device nodes.
>=20
> Introduce a Linux capabilities(7) whitelist and drop all capabilities
> that we don't need, making the virtiofsd process less powerful than a
> regular uid root process.
>=20
>   # cat /proc/PID/status
>   ...
>           Before           After
>   CapInh: 0000000000000000 0000000000000000
>   CapPrm: 0000003fffffffff 00000000880000df
>   CapEff: 0000003fffffffff 00000000880000df
>   CapBnd: 0000003fffffffff 0000000000000000
>   CapAmb: 0000000000000000 0000000000000000
>=20
> Note that file capabilities cannot be used to achieve the same effect on
> the virtiofsd executable because mount is used during sandbox setup.
> Therefore we drop capabilities programmatically at the right point
> during startup.
>=20
> This patch only affects the sandboxed child process.  The parent process
> that sits in waitpid(2) still has full root capabilities and will be
> addressed in the next patch.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Looks reasonable to me; I can't see any capabilities in the manpage that
you're missing that make sense.
They also look old enough not to be a problem with reasonably old
systems.



Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  tools/virtiofsd/passthrough_ll.c | 38 ++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>=20
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrou=
gh_ll.c
> index 4c35c95b25..af97ba1c41 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -2695,6 +2695,43 @@ static void setup_mounts(const char *source)
>      close(oldroot);
>  }
> =20
> +/*
> + * Only keep whitelisted capabilities that are needed for file system op=
eration
> + */
> +static void setup_capabilities(void)
> +{
> +    pthread_mutex_lock(&cap.mutex);
> +    capng_restore_state(&cap.saved);
> +
> +    /*
> +     * Whitelist file system-related capabilities that are needed for a =
file
> +     * server to act like root.  Drop everything else like networking an=
d
> +     * sysadmin capabilities.
> +     *
> +     * Exclusions:
> +     * 1. CAP_LINUX_IMMUTABLE is not included because it's only used via=
 ioctl
> +     *    and we don't support that.
> +     * 2. CAP_MAC_OVERRIDE is not included because it only seems to be
> +     *    used by the Smack LSM.  Omit it until there is demand for it.
> +     */
> +    capng_setpid(syscall(SYS_gettid));
> +    capng_clear(CAPNG_SELECT_BOTH);
> +    capng_updatev(CAPNG_ADD, CAPNG_PERMITTED | CAPNG_EFFECTIVE,
> +            CAP_CHOWN,
> +            CAP_DAC_OVERRIDE,
> +            CAP_DAC_READ_SEARCH,
> +            CAP_FOWNER,
> +            CAP_FSETID,
> +            CAP_SETGID,
> +            CAP_SETUID,
> +            CAP_MKNOD,
> +            CAP_SETFCAP);
> +    capng_apply(CAPNG_SELECT_BOTH);
> +
> +    cap.saved =3D capng_save_state();
> +    pthread_mutex_unlock(&cap.mutex);
> +}
> +
>  /*
>   * Lock down this process to prevent access to other processes or files =
outside
>   * source directory.  This reduces the impact of arbitrary code executio=
n bugs.
> @@ -2705,6 +2742,7 @@ static void setup_sandbox(struct lo_data *lo, struc=
t fuse_session *se,
>      setup_namespaces(lo, se);
>      setup_mounts(lo->source);
>      setup_seccomp(enable_syslog);
> +    setup_capabilities();
>  }
> =20
>  /* Raise the maximum number of open file descriptors */
> --=20
> 2.25.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


