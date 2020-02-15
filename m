Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD39C2BA83
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 10:39:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ADE12083B
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 10:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JOtKUtfm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ADE12083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2urb-0000RE-JR
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 05:39:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44967)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j2ur4-0008Sh-4O
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 05:39:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j2ur3-0001jR-2D
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 05:39:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22289
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j2ur2-0001jB-Uk
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 05:39:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581763160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MnvAUty6NlRxhkG02gJpAexwwENi7d7U+xr8z90jlAw=;
 b=JOtKUtfmyHf+io33XI3JvXgbpqKeIH4QVjcDZdeFYTTJf5ZN0r6cbQsZY0WoH7tJd50HKb
 w8wop1MPlGqSGQqyldAuFFppMNVhzN8O3+HPYVFHoM+ZgIlBhm9+2BNV4qA++yvf6YEw6u
 iJgwZKeXO5G4XrQVo1NiCFU2/X2pdPM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-DTE3uQHdNYenEUpYTXY8Fw-1; Sat, 15 Feb 2020 05:39:18 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDC8F477;
 Sat, 15 Feb 2020 10:39:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-234.ams2.redhat.com
 [10.36.117.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E05B87B34;
 Sat, 15 Feb 2020 10:39:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 139EC11385C9; Sat, 15 Feb 2020 11:39:16 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Faisal Al-Humaimidi <falhumai96@gmail.com>
Subject: Re: QEMU Sockets Networking Backend Multicast Networking Fix
References: <CAMx8kb2aJ2OOHx6GG9qmXOoSXdQrzQ9+fsK=JR7pM-bJA4QOzg@mail.gmail.com>
Date: Sat, 15 Feb 2020 11:39:16 +0100
In-Reply-To: <CAMx8kb2aJ2OOHx6GG9qmXOoSXdQrzQ9+fsK=JR7pM-bJA4QOzg@mail.gmail.com>
 (Faisal Al-Humaimidi's message of "Fri, 14 Feb 2020 10:51:17 -0800")
Message-ID: <87mu9knnhn.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: DTE3uQHdNYenEUpYTXY8Fw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Jason, please have a look.

Faisal Al-Humaimidi <falhumai96@gmail.com> writes:

> Hello QEMU developers,
>
> I have noticed a bug in the `mcast` option of the `socket` networking
> backend, where I simply cannot join a multicast group (tested in Windows =
10
> with QEMU 4.2.0 release). I have found a fix to the problem. The problem
> was mainly due to the fact that QEMU was binding to the multicast address=
,
> and not the local address or the default INADDR_ANY (0.0.0.0) if no local
> address is used.
>
> Here's the patch text (as well as attached with this email), that outline=
s
> my fix:
>
> ```
> diff -uarN qemu-4.2.0.original/net/socket.c qemu-4.2.0.modified/net/socke=
t.c
> --- qemu-4.2.0.original/net/socket.c 2019-12-12 10:20:48.000000000 -0800
> +++ qemu-4.2.0.modified/net/socket.c 2020-02-14 10:30:16.395973453 -0800
> @@ -253,6 +253,15 @@
>          goto fail;
>      }
>
> +    /* Preserve the multicast address, and bind to a non-multicast group
> (e.g. a
> +     * local address).
> +     */
> +    struct in_addr group_addr =3D mcastaddr->sin_addr;
> +    if (localaddr) {
> +        mcastaddr->sin_addr =3D *localaddr;
> +    } else {
> +        mcastaddr->sin_addr.s_addr =3D htonl(INADDR_ANY);
> +    }
>      ret =3D bind(fd, (struct sockaddr *)mcastaddr, sizeof(*mcastaddr));
>      if (ret < 0) {
>          error_setg_errno(errp, errno, "can't bind ip=3D%s to socket",
> @@ -260,7 +269,10 @@
>          goto fail;
>      }
>
> -    /* Add host to multicast group */
> +    /* Restore the multicast address. */
> +    mcastaddr->sin_addr =3D group_addr;
> +
> +    /* Add host to multicast group. */
>      imr.imr_multiaddr =3D mcastaddr->sin_addr;
>      if (localaddr) {
>          imr.imr_interface =3D *localaddr;
> @@ -277,7 +289,7 @@
>          goto fail;
>      }
>
> -    /* Force mcast msgs to loopback (eg. several QEMUs in same host */
> +    /* Force mcast msgs to loopback (eg. several QEMUs in same host). */
>      loop =3D 1;
>      ret =3D qemu_setsockopt(fd, IPPROTO_IP, IP_MULTICAST_LOOP,
>                            &loop, sizeof(loop));
> @@ -287,7 +299,7 @@
>          goto fail;
>      }
>
> -    /* If a bind address is given, only send packets from that address *=
/
> +    /* If a bind address is given, only send packets from that address. =
*/
>      if (localaddr !=3D NULL) {
>          ret =3D qemu_setsockopt(fd, IPPROTO_IP, IP_MULTICAST_IF,
>                                localaddr, sizeof(*localaddr));
> ```
>
> Regards,
> Faisal Al-Humaimidi


