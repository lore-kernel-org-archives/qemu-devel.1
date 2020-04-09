Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFBDC2BB55
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 17:57:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E398C206E9
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 17:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V8C1VPpl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E398C206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMbQM-00021L-5j
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 13:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42626)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jMbPc-0001Zm-On
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:56:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jMbPb-0006uE-Lq
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:56:24 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53255
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jMbPb-0006u1-Hv
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586454983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qK2s5zgjoX1OP05crt7Ipk4oIHWG9KI//c1I1sBdU7E=;
 b=V8C1VPpltcbJ4N7rROJ1jSzMTeRwvtgVK6YnXCyWBcheGcdFOgFZIH6awRM/2ksx3XETMO
 FWiYmsW+Ci/xkx6w3gVOheubxE/zaOhX9CVEm2BRG+OFxmiEH6MyprkcBltP9QjEDW3oGn
 aW4Cklc4/MtORbeYknsbsgR6hiJL9d4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-GkStwIN-Ooeviy95QAaFAw-1; Thu, 09 Apr 2020 13:56:21 -0400
X-MC-Unique: GkStwIN-Ooeviy95QAaFAw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6CD7518B5F6B;
 Thu,  9 Apr 2020 17:56:19 +0000 (UTC)
Received: from work-vm (ovpn-114-117.ams2.redhat.com [10.36.114.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 34467391;
 Thu,  9 Apr 2020 17:56:07 +0000 (UTC)
Date: Thu, 9 Apr 2020 18:56:04 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH v6 12/36] multi-process: add functions to synchronize
 proxy and remote endpoints
Message-ID: <20200409175604.GF3065@work-vm>
References: <cover.1586165555.git.elena.ufimtseva@oracle.com>
 <013cbc654f4f22a60659e580e98bd45925614866.1586165556.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <013cbc654f4f22a60659e580e98bd45925614866.1586165556.git.elena.ufimtseva@oracle.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: fam@euphon.net, john.g.johnson@oracle.com, swapnil.ingle@nutanix.com,
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, liran.alon@oracle.com, stefanha@redhat.com,
 thanos.makatos@nutanix.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* elena.ufimtseva@oracle.com (elena.ufimtseva@oracle.com) wrote:
> From: Jagannathan Raman <jag.raman@oracle.com>
>=20
> In some cases, for example MMIO read, QEMU has to wait for the remote to
> complete a command before proceeding. An eventfd based mechanism is
> added to synchronize QEMU & remote process.
>=20
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> ---
>  include/io/mpqemu-link.h |  7 +++++++
>  io/mpqemu-link.c         | 41 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 48 insertions(+)
>=20
> diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
> index af401e640c..ef95599bca 100644
> --- a/include/io/mpqemu-link.h
> +++ b/include/io/mpqemu-link.h
> @@ -124,4 +124,11 @@ void mpqemu_link_set_callback(MPQemuLinkState *s,
>  void mpqemu_start_coms(MPQemuLinkState *s, MPQemuChannel* chan);
>  bool mpqemu_msg_valid(MPQemuMsg *msg);
> =20
> +#define GET_REMOTE_WAIT eventfd(0, EFD_CLOEXEC)
> +#define PUT_REMOTE_WAIT(wait) close(wait)
> +#define PROXY_LINK_WAIT_DONE 1
> +
> +uint64_t wait_for_remote(int efd);
> +void notify_proxy(int fd, uint64_t val);
> +
>  #endif
> diff --git a/io/mpqemu-link.c b/io/mpqemu-link.c
> index b7d3e53ae8..fa9b3a66b1 100644
> --- a/io/mpqemu-link.c
> +++ b/io/mpqemu-link.c
> @@ -10,6 +10,7 @@
> =20
>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
> +#include <poll.h>
> =20
>  #include "qemu/module.h"
>  #include "io/mpqemu-link.h"
> @@ -204,6 +205,46 @@ int mpqemu_msg_recv(MPQemuMsg *msg, MPQemuChannel *c=
han)
>      return rc;
>  }
> =20
> +uint64_t wait_for_remote(int efd)
> +{
> +    struct pollfd pfd =3D { .fd =3D efd, .events =3D POLLIN };
> +    uint64_t val;
> +    int ret;
> +
> +    ret =3D poll(&pfd, 1, 1000);
> +
> +    switch (ret) {
> +    case 0:
> +        qemu_log_mask(LOG_REMOTE_DEBUG, "Error wait_for_remote: Timed ou=
t\n");
> +        /* TODO: Kick-off error recovery */
> +        return ULLONG_MAX;
> +    case -1:
> +        qemu_log_mask(LOG_REMOTE_DEBUG, "Poll error wait_for_remote: %s\=
n",
> +                      strerror(errno));
> +        return ULLONG_MAX;
> +    default:
> +        if (read(efd, &val, sizeof(val)) =3D=3D -1) {
> +            qemu_log_mask(LOG_REMOTE_DEBUG, "Error wait_for_remote: %s\n=
",
> +                          strerror(errno));
> +            return ULLONG_MAX;
> +        }
> +    }
> +
> +    val =3D (val =3D=3D ULLONG_MAX) ? val : (val - 1);
> +
> +    return val;

These don't seem to have changed since my review of v5 on the 4th March
in which Jag said they would change to UINT64_MAX etc and there would be
a big comment etc on the next function.

Dave

> +}
> +
> +void notify_proxy(int efd, uint64_t val)
> +{
> +    val =3D (val =3D=3D ULLONG_MAX) ? val : (val + 1);
> +
> +    if (write(efd, &val, sizeof(val)) =3D=3D -1) {
> +        qemu_log_mask(LOG_REMOTE_DEBUG, "Error notify_proxy: %s\n",
> +                      strerror(errno));
> +    }
> +}
> +
>  static gboolean mpqemu_link_handler_prepare(GSource *gsrc, gint *timeout=
)
>  {
>      g_assert(timeout);
> --=20
> 2.25.GIT
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


