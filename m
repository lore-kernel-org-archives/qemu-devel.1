Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17B5C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 08:40:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B278D20857
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 08:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X53XFuP4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B278D20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJvOp-0007NX-TZ
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 04:40:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42671)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rjones@redhat.com>) id 1jJvO0-0006pm-8j
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 04:39:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rjones@redhat.com>) id 1jJvNy-0002ee-0o
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 04:39:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44862
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rjones@redhat.com>) id 1jJvNx-0002cw-SM
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 04:39:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585816777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u0JhiszkVtPRKLVK03lTofBfu+fDRlIKlVihOxx9Lgc=;
 b=X53XFuP45RH/XsKLbHzJM4yujNY3OlvkDWmPstRpdNxPiKJDOnva/rOg5dyzzM9KXEI4y+
 UXAa/JajO7cHoKUlHXBhIZspEAMYQF+T6EaoxA2xW+vTRqCOHmZsF0Ns6k9pzIgSveY3+e
 3QPPtkBQoCA1deBA03Ooxl9SOGFx8v8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-OJ-97-R8P4-AZz9Jjx07hg-1; Thu, 02 Apr 2020 04:38:28 -0400
X-MC-Unique: OJ-97-R8P4-AZz9Jjx07hg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9448E19251A2;
 Thu,  2 Apr 2020 08:38:27 +0000 (UTC)
Received: from localhost (ovpn-112-30.ams2.redhat.com [10.36.112.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 11BFE5E000;
 Thu,  2 Apr 2020 08:38:26 +0000 (UTC)
Date: Thu, 2 Apr 2020 09:38:26 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH for-5.0?] nbd: Attempt reconnect after server error of
 ESHUTDOWN
Message-ID: <20200402083826.GY3888@redhat.com>
References: <20200401223841.312793-1-eblake@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200401223841.312793-1-eblake@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On Wed, Apr 01, 2020 at 05:38:41PM -0500, Eric Blake wrote:
> I was trying to test qemu's reconnect-delay parameter by using nbdkit
> as a server that I could easily make disappear and resume.  A bit of
> experimenting shows that when nbdkit is abruptly killed (SIGKILL),
> qemu detects EOF on the socket and manages to reconnect just fine; but
> when nbdkit is gracefully killed (SIGTERM), it merely fails all
> further guest requests with NBD_ESHUTDOWN until the client disconnects
> first, and qemu was blindly failing the I/O request with ESHUTDOWN
> from the server instead of attempting to reconnect.
>=20
> While most NBD server failures are unlikely to change by merely
> retrying the same transaction, our decision to not start a retry loop
> in the common case is correct.  But NBD_ESHUTDOWN is rare enough, and
> really is indicative of a transient situation, that it is worth
> special-casing.
>=20
> Here's the test setup I used: in one terminal, kick off a sequence of
> nbdkit commands that has a temporary window where the server is
> offline; in another terminal (and within the first 5 seconds) kick off
> a qemu-img convert with reconnect enabled.  If the qemu-img process
> completes successfully, the reconnect worked.
>=20
> $ #term1
> $ MYSIG=3D    # or MYSIG=3D'-s KILL'
> $ timeout $MYSIG 5s ~/nbdkit/nbdkit -fv --filter=3Ddelay --filter=3Dnoext=
ents \
>   null 200M delay-read=3D1s; sleep 5; ~/nbdkit/nbdkit -fv --filter=3Dexit=
last \
>   --filter=3Ddelay --filter=3Dnoextents null 200M delay-read=3D1s
>=20
> $ #term2
> $ MYCONN=3Dserver.type=3Dinet,server.host=3Dlocalhost,server.port=3D10809
> $ qemu-img convert -p -O raw --image-opts \
>   driver=3Dnbd,$MYCONN,,reconnect-delay=3D60 out.img
>=20
> See also: https://bugzilla.redhat.com/show_bug.cgi?id=3D1819240#c8
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>=20
> This is not a regression, per se, as reconnect-delay has been unchanged
> since 4.2; but I'd like to consider this as an interoperability bugfix
> worth including in the next rc.
>=20
>  block/nbd.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/block/nbd.c b/block/nbd.c
> index 2906484390f9..576b95fb8753 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -863,6 +863,15 @@ static coroutine_fn int nbd_co_receive_one_chunk(
>      if (ret < 0) {
>          memset(reply, 0, sizeof(*reply));
>          nbd_channel_error(s, ret);
> +    } else if (s->reconnect_delay && *request_ret =3D=3D -ESHUTDOWN) {
> +        /*
> +         * Special case: if we support reconnect and server is warning
> +         * us that it wants to shut down, then treat this like an
> +         * abrupt connection loss.
> +         */
> +        memset(reply, 0, sizeof(*reply));
> +        *request_ret =3D 0;
> +        nbd_channel_error(s, -EIO);
>      } else {
>          /* For assert at loop start in nbd_connection_entry */
>          *reply =3D s->reply;

For the case I care about (long running virt-v2v conversions with an
intermittent network) we don't expect that nbdkit will be killed nor
gracefully shut down.  Instead what we expect is that nbdkit returns
an error such as NBD_EIO and keeps running.

Indeed if nbdkit actually dies then reconnecting will not help since
there will be no server to reconnect to.

So I'm neutral about this patch.  If you want it for qemu that's fine
but I don't think it will affect v2v.

Rich.

--=20
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjon=
es
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-builder quickly builds VMs from scratch
http://libguestfs.org/virt-builder.1.html


