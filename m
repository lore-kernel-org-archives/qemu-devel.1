Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E3AC8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 08:39:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8956E20838
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 08:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RrXJZi6c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8956E20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU4jO-0008QH-Pn
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 04:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42360)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jU4hL-0007ai-TZ
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 04:39:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jU4fh-0001qu-Rm
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 04:37:35 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60913
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jU4fh-0001qh-CO
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 04:35:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588235751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w1K8EJQLnnMbCMYinyZFYkcTDxf+nNkahZ+YlemEzAw=;
 b=RrXJZi6c4qkyRbup8R/xuuOzy6X+XN1lCCBZczBVFcK2LjkLNeTDqEwGQ1eDL86vvuFGrB
 qMyH2DXYR5Hid2btCLD8IUgWG9mVjM1Ze2QTanA8LLDTYgaIEud5dRWVk56R0GzEjqEHhn
 9qg/aAwZCo/pdT/QJL1xXyLeUbOjb5Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-fPxB_E2iPCaRiy5Dto5TSg-1; Thu, 30 Apr 2020 04:35:49 -0400
X-MC-Unique: fPxB_E2iPCaRiy5Dto5TSg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 331DD800D24;
 Thu, 30 Apr 2020 08:35:48 +0000 (UTC)
Received: from localhost (ovpn-114-71.ams2.redhat.com [10.36.114.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DD09E66083;
 Thu, 30 Apr 2020 08:35:44 +0000 (UTC)
Date: Thu, 30 Apr 2020 09:35:43 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Catherine Ho <catherine.hecx@gmail.com>
Subject: Re: [PATCH v2] virtiofsd/passthrough_ll: don't remove O_DIRECT when
 cache=none
Message-ID: <20200430083543.GB160930@stefanha-x1.localdomain>
References: <1586585997-24446-1-git-send-email-catherine.hecx@gmail.com>
 <1586594144-24605-1-git-send-email-catherine.hecx@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1586594144-24605-1-git-send-email-catherine.hecx@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:04:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: virtio-fs@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 11, 2020 at 04:35:44AM -0400, Catherine Ho wrote:
> @@ -1702,10 +1703,11 @@ static void update_open_flags(int writeback, stru=
ct fuse_file_info *fi)
> =20
>      /*
>       * O_DIRECT in guest should not necessarily mean bypassing page
> -     * cache on host as well. If somebody needs that behavior, it
> -     * probably should be a configuration knob in daemon.
> +     * cache on host as well. If cache=3Dnone, keep the flag unchanged
>       */
> -    fi->flags &=3D ~O_DIRECT;
> +    if (cache_mode !=3D CACHE_NONE) {
> +        fi->flags &=3D ~O_DIRECT;
> +    }
>  }
> =20

Thanks for the patch!  I have CCed the virtio-fs mailing list so more
people see it.

Please add a new command-line option to control O_DIRECT behavior.

There are two cases:

1. O_DIRECT bypasses the guest page cache but not the host page cache.
   This makes sense when the DAX feature is enabled.

2. O_DIRECT bypasses both the guest and host page cache.  This make
   sense for non-DAX and for I/O performance benchmarking.

Today only #1 is supported.

Your patch makes the behavior dependent on the cache mode option, but
the cache mode doesn't necessarily determine how O_DIRECT should be
handled.  For example, in the DAX case the guest page cache is bypassed
and cache=3Dnone can be used, but we do want to use the host page cache.

You can add a new option so that O_DIRECT handling is configurable for
all cases.

Stefan

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6qjd8ACgkQnKSrs4Gr
c8i7Nwf+MMH9Ye5CS+QppXcXKW3UqQpB3DUj2lrsJk0j2qZ31AVSnEXw2MSrXwvr
6ApcGNGTQS6g5t8plZFruCbKnQvS19xsbW7J4uHGviTLqQ4X0L+vks/Z9meGmBPr
3C1FZRdIy68dXhxrK8xeqNxqIPoK8N8aB6fQjMoiue/wXnoNl9euLvnDBrV0pjs0
DdS6O0mc6A3ZlNeUBExtbzrxwwdti6NxUa4FdIZFZVHthKVpUP8XFGUbqlFjNkwl
eZeK7kZWycQWjm5TIbDNchyegs1mxtQayQF38gpIkMOxTlJQFdmRknnGVCgPJ6qz
I3s8kGoGy7kWrE/YPKYlnp2jkw+5Wg==
=h2l4
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--


