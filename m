Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3E7C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 13:49:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9C2521BE5
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 13:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E+kwM4aC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9C2521BE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL59e-0002GF-TM
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 09:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kL581-0001Bo-V9
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 09:48:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20544)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kL57z-0007Py-9S
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 09:48:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600868890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zh2/An+F+GVOP48Peyd0VYG2kDzLn4AikGuGQlECes4=;
 b=E+kwM4aCv1g7fI2dsrX2RHq2p6maX+o3DQYCFeyoX5m5gVEXInjkAwC5QbOFOSCAqpj5wM
 dD7//Tt53AgQexwzN/0tjMJgYFdF0M2HoPYXk4I5mlKOgwOrzvNaCHbwioCzkLkls/oGEj
 fu0hKOYFBBBSEBsFI0QrWr2XNr2aRXg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-Z7hatDlWOPi5wez9qvuoMw-1; Wed, 23 Sep 2020 09:48:08 -0400
X-MC-Unique: Z7hatDlWOPi5wez9qvuoMw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 030FA6408F;
 Wed, 23 Sep 2020 13:48:06 +0000 (UTC)
Received: from localhost (ovpn-113-77.ams2.redhat.com [10.36.113.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B626F19930;
 Wed, 23 Sep 2020 13:47:58 +0000 (UTC)
Date: Wed, 23 Sep 2020 14:47:57 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH v9 06/20] multi-process: define MPQemuMsg format and
 transmission functions
Message-ID: <20200923134757.GA62770@stefanha-x1.localdomain>
References: <20200827181231.22778-1-elena.ufimtseva@oracle.com>
 <20200827181231.22778-7-elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20200827181231.22778-7-elena.ufimtseva@oracle.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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
Cc: fam@euphon.net, john.g.johnson@oracle.com, swapnil.ingle@nutanix.com,
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, thanos.makatos@nutanix.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--ibTvN161/egqYuK8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2020 at 11:12:17AM -0700, elena.ufimtseva@oracle.com wrote:
> +/**
> + * MPQemuCmd:
> + *
> + * MPQemuCmd enum type to specify the command to be executed on the remo=
te
> + * device.
> + */
> +typedef enum {
> +    INIT =3D 0,
> +    MAX =3D INT_MAX,

enum members are in a global namespace. INIT and MAX are likely to
collide with other code using these names. Please use MPQEMU_CMD_INIT
and MPQEMU_CMD_MAX.

Why is MAX =3D INT_MAX? I expected MAX to be related to the number of
commands that have been defined (1 so far).

> +} MPQemuCmd;
> +
> +/**
> + * MPQemuMsg:
> + * @cmd: The remote command
> + * @size: Size of the data to be shared
> + * @data: Structured data
> + * @fds: File descriptors to be shared with remote device
> + *
> + * MPQemuMsg Format of the message sent to the remote device from QEMU.
> + *
> + */
> +typedef struct {
> +    int cmd;
> +    size_t size;

I worry about the hole (compiler-inserted padding) between the cmd and
size fields.

It is safer to use fixed-size types and use QEMU_PACKED for structs that
are transferred over the network:

  typedef struct {
      int32_t cmd;
      uint64_t size;
      ...
  } QEMU_PACKED MPQemuMsg;

This way the struct layout is independent of the compilation environment
(32-/64-bit, ABI) and there is no risk of accidentally exposing memory
(information leaks) through holes.

> +
> +    union {
> +        uint64_t u64;
> +    } data;
> +
> +    int fds[REMOTE_MAX_FDS];
> +    int num_fds;
> +} MPQemuMsg;
> +
> +void mpqemu_msg_send(MPQemuMsg *msg, QIOChannel *ioc, Error **errp);
> +void mpqemu_msg_recv(MPQemuMsg *msg, QIOChannel *ioc, Error **errp);
> +
> +bool mpqemu_msg_valid(MPQemuMsg *msg);
> +
> +#endif
> diff --git a/io/meson.build b/io/meson.build
> index 768c1b5ec3..3d40cd8867 100644
> --- a/io/meson.build
> +++ b/io/meson.build
> @@ -15,6 +15,8 @@ io_ss.add(files(
>    'task.c',
>  ))
> =20
> +io_ss.add(when: 'CONFIG_MPQEMU', if_true: files('mpqemu-link.c'))
> +
>  io_ss =3D io_ss.apply(config_host, strict: false)
>  libio =3D static_library('io', io_ss.sources() + genh,
>                         dependencies: [io_ss.dependencies()],
> diff --git a/io/mpqemu-link.c b/io/mpqemu-link.c
> new file mode 100644
> index 0000000000..d9be2bdeab
> --- /dev/null
> +++ b/io/mpqemu-link.c
> @@ -0,0 +1,173 @@
> +/*
> + * Communication channel between QEMU and remote device process
> + *
> + * Copyright =A9 2018, 2020 Oracle and/or its affiliates.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +
> +#include "qemu/module.h"
> +#include "io/mpqemu-link.h"
> +#include "qapi/error.h"
> +#include "qemu/iov.h"
> +#include "qemu/error-report.h"
> +#include "qemu/main-loop.h"
> +
> +void mpqemu_msg_send(MPQemuMsg *msg, QIOChannel *ioc, Error **errp)
> +{
> +    bool iolock =3D qemu_mutex_iothread_locked();
> +    Error *local_err =3D NULL;
> +    struct iovec send[2];
> +    int *fds =3D NULL;
> +    size_t nfds =3D 0;
> +
> +    send[0].iov_base =3D msg;
> +    send[0].iov_len =3D MPQEMU_MSG_HDR_SIZE;
> +
> +    send[1].iov_base =3D (void *)&msg->data;
> +    send[1].iov_len =3D msg->size;
> +
> +    if (msg->num_fds) {
> +        nfds =3D msg->num_fds;
> +        fds =3D msg->fds;
> +    }
> +
> +    if (iolock) {
> +        qemu_mutex_unlock_iothread();
> +    }
> +
> +    (void)qio_channel_writev_full_all(ioc, send, G_N_ELEMENTS(send), fds=
, nfds,
> +                                      &local_err);

I tried to understand when it is safe to call this function:

Thread    | Coroutine? | Comments
------------------------------------
Main loop | Yes        | Okay
Main loop | No         | Do not use, blocks main loop
vCPU      | Yes        | Careful, can move coroutine to main loop
vCPU      | No         | Okay if no other ioc activity in main loop
IOThread  | Yes        | Broken: we shouldn't touch the global mutex!
IOThread  | No         | Do not use, blocks IOThread

The IOThreads case with coroutines can be fixed by skipping
qemu_mutex_lock_iothread() when running in an IOThread. Please address
this.

Cases that look usable to me are:
1. Main loop with coroutines
2. vCPU without coroutines
3. IOThread with coroutines (needs fix though)

All this is not obvious so a comment and assertions would be good. The
following helpers are available for implementing assertions:
1. bool qemu_in_coroutine() -> true if running in a coroutine
2. qemu_get_current_aio_context() !=3D qemu_get_aio_context() -> true in
   IOThread

> +
> +    if (iolock) {
> +        qemu_mutex_lock_iothread();
> +    }
> +
> +    if (errp) {
> +        error_propagate(errp, local_err);
> +    } else if (local_err) {
> +        error_report_err(local_err);
> +    }
> +
> +    return;
> +}
> +
> +static ssize_t mpqemu_read(QIOChannel *ioc, void *buf, size_t len, int *=
*fds,
> +                           size_t *nfds, Error **errp)

The same constraints apply to this function.

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9rUg0ACgkQnKSrs4Gr
c8jfkwf/dZooZffkCo8Qv+gntxMJna/9vMUgli4mAUkdNjwwOhSKP3xSJgrypumD
+WJUeMNEqTkHkqUxg528XGrqx8+gEcpKtRodn+Mh2N0bKrq04I1Geu7apR1OW4YT
YbfaNe20+2B/Y1EKmB7H89CDARu2KjB621iIJ/TgkMIjFjjsXeX0tl9KSwXKcZ3B
d7urm0Z9SNa3F0anujks/A+v+4tuSaxzrFLsFuo71nvjuwJGFc3alCY32gDaGc8p
fYHni4nKx1qlBumK9nImHJOWjP6OyvVNbR6QdRjehfG6hLJl2qOyTJfM7SDrEhv5
9SFvHFtcIAtnBYEe4oj1buM+mKCAfg==
=ls5i
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--


