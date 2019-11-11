Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F50EC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:24:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C424F20679
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cJouNjbm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C424F20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUCUR-0000VV-G3
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 11:24:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41399)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iUCM7-0007fT-NE
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:15:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iUCM5-0008Ly-Ur
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:15:55 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20934
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iUCM5-0008LX-Qq
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:15:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573488952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hjsmy45hpgnurMR/SBuemcdL6YSmRV5q9hRpufVI87s=;
 b=cJouNjbmrI9UrVeeNcX2T2NWdWJTNNfQaLC0QJRYb7+yBY9C9Vo2YxbJMAGhF5j7z8uMz6
 Y97i5agYs3jQpMyT53Jn0wWgxrV5gTg04TGqK9ro7+nSv4VY5/B8IRuAg/yM0nBPly55GL
 iIwr3m+9mfwQECkPRF6afxrUyLYQJOI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-QG5p25MYOA-x6QV5EtglTA-1; Mon, 11 Nov 2019 11:15:51 -0500
X-MC-Unique: QG5p25MYOA-x6QV5EtglTA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A71E4DBF3;
 Mon, 11 Nov 2019 16:15:49 +0000 (UTC)
Received: from localhost (ovpn-117-169.ams2.redhat.com [10.36.117.169])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DA7E24145;
 Mon, 11 Nov 2019 16:15:43 +0000 (UTC)
Date: Mon, 11 Nov 2019 16:15:42 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [RFC v4 PATCH 47/49] multi-process: Enable support for multiple
 devices in remote
Message-ID: <20191111161542.GF402228@stefanha-x1.localdomain>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <c67656abcd0e41278710460d2920036254ecffb7.1571905346.git.jag.raman@oracle.com>
MIME-Version: 1.0
In-Reply-To: <c67656abcd0e41278710460d2920036254ecffb7.1571905346.git.jag.raman@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="aPdhxNJGSeOG9wFI"
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, thuth@redhat.com,
 john.g.johnson@oracle.com, ehabkost@redhat.com, konrad.wilk@oracle.com,
 quintela@redhat.com, berrange@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, armbru@redhat.com, ross.lagerwall@citrix.com,
 kanth.ghatraju@oracle.com, kraxel@redhat.com, kwolf@redhat.com,
 pbonzini@redhat.com, liran.alon@oracle.com, marcandre.lureau@gmail.com,
 mreitz@redhat.com, dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--aPdhxNJGSeOG9wFI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2019 at 05:09:28AM -0400, Jagannathan Raman wrote:
> @@ -93,7 +94,8 @@ static void process_config_write(MPQemuMsg *msg)
>      struct conf_data_msg *conf =3D (struct conf_data_msg *)msg->data2;
> =20
>      qemu_mutex_lock_iothread();
> -    pci_default_write_config(remote_pci_dev, conf->addr, conf->val, conf=
->l);
> +    pci_default_write_config(remote_pci_devs[msg->id], conf->addr, conf-=
>val,
> +                             conf->l);
>      qemu_mutex_unlock_iothread();
>  }
> =20
> @@ -106,7 +108,8 @@ static void process_config_read(MPQemuMsg *msg)
>      wait =3D msg->fds[0];
> =20
>      qemu_mutex_lock_iothread();
> -    val =3D pci_default_read_config(remote_pci_dev, conf->addr, conf->l)=
;
> +    val =3D pci_default_read_config(remote_pci_devs[msg->id], conf->addr=
,
> +                                  conf->l);
>      qemu_mutex_unlock_iothread();
> =20
>      notify_proxy(wait, val);

msg->id was read from a socket and hasn't been validated before indexing
into remote_pci_devs[].

--aPdhxNJGSeOG9wFI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3JiS4ACgkQnKSrs4Gr
c8iqqggAuvr+9sYr+rlrI9/WtCUGcnp/tybpl+ei2J0Hy8xfYIYG6tDO9Zho8f13
4Ik4CiUESw3oHbdw1Rrgprkm2AjBjbVQcx+lzC8X1M/ssLo55bm9NXsZ5nm1FuU1
dc1F4Ianfue7eBukyNtOvkCW4MOYlBR0ELTwilJWz7ffeY6CjXX02Up6geo4hLwM
4HAoa1/sZavQgL1avlCZRtqpIQ1RIQTZDWuHmuhHSpo4HGZKh+mPQBkGe0ie85Jl
d+JmtCR/LiYMs6GZxarRPSpBfjIdHH1CAxghdNgzs+1ej9zUR0tFCxThKG1LBxF7
0ld8GL+4J0snLAM3zLhcY63zWWAnRQ==
=E4Mr
-----END PGP SIGNATURE-----

--aPdhxNJGSeOG9wFI--


