Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8413DC3F2D1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 19:58:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 396B62073B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 19:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IkgWfwgP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 396B62073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9Dg0-0000p4-Bf
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 14:58:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38035)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j9Des-0007st-Hg
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:56:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j9Der-0002q3-81
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:56:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22910
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j9Der-0002pt-3g
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:56:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583265408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3wVaDBAw+4KYU0QLU7NDCpDTqATt35p0ifxOkq8lrD8=;
 b=IkgWfwgPdR/vIC6/BvXzTpBocJoCrdMB3Iwco44O3OuDU4oDo2vZ75w9jEvWVoN+VTUf1M
 fIAEyCK871Yqhj1VQ2Ke+RXNVb+C7RJiXHeBvsVWQYSEJWGy5cp+YwCAUqhdrMABKsKv67
 lyFUfdul8oE0i4LurBSu7BLefWFlJUU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-72KYtE3YNiCqm4A-TTDCGQ-1; Tue, 03 Mar 2020 14:56:45 -0500
X-MC-Unique: 72KYtE3YNiCqm4A-TTDCGQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F00C100550E;
 Tue,  3 Mar 2020 19:56:43 +0000 (UTC)
Received: from work-vm (ovpn-117-2.ams2.redhat.com [10.36.117.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6586690782;
 Tue,  3 Mar 2020 19:56:30 +0000 (UTC)
Date: Tue, 3 Mar 2020 19:56:27 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [PATCH v5 08/50] multi-process: add functions to synchronize
 proxy and remote endpoints
Message-ID: <20200303195627.GW3170@work-vm>
References: <cover.1582576372.git.jag.raman@oracle.com>
 <3d013f0091ac6babb55f30cadf6ed806c322b7ce.1582576372.git.jag.raman@oracle.com>
MIME-Version: 1.0
In-Reply-To: <3d013f0091ac6babb55f30cadf6ed806c322b7ce.1582576372.git.jag.raman@oracle.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, liran.alon@oracle.com,
 stefanha@redhat.com, thanos.makatos@nutanix.com, rth@twiddle.net,
 kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Jagannathan Raman (jag.raman@oracle.com) wrote:
> In some cases, for example MMIO read, QEMU has to wait for the remote to
> complete a command before proceeding. An eventfd based mechanism is
> added to synchronize QEMU & remote process.
>=20
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> ---
>  include/io/mpqemu-link.h |  7 +++++++
>  io/mpqemu-link.c         | 41 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 48 insertions(+)
>=20
> diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
> index 2f2dd83..ae04fca 100644
> --- a/include/io/mpqemu-link.h
> +++ b/include/io/mpqemu-link.h
> @@ -135,4 +135,11 @@ void mpqemu_link_set_callback(MPQemuLinkState *s,
>                                mpqemu_link_callback callback);
>  void mpqemu_start_coms(MPQemuLinkState *s);
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
> index bac120b..73b7032 100644
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
> @@ -216,6 +217,46 @@ int mpqemu_msg_recv(MPQemuMsg *msg, MPQemuChannel *c=
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

Shouldn't these be UINT64_MAX?

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

Can you explain what's going on there??

> +    return val;
> +}
> +
> +void notify_proxy(int efd, uint64_t val)
> +{
> +    val =3D (val =3D=3D ULLONG_MAX) ? val : (val + 1);
> +
> +    if (write(efd, &val, sizeof(val)) =3D=3D -1) {

I'd actually check the write/read's are returning sizeof(val) - they
can on a bad day return 0 or send only a few bytes; in theory?

Dave

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
> 1.8.3.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


