Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C12C17441
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:34:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB1E820674
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G260L135"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB1E820674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUCdq-0001id-GH
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 11:34:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42214)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iUCQ6-0003qT-Mw
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:20:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iUCQ5-0001vA-JG
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:20:02 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24170
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iUCQ5-0001un-F7
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:20:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573489200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PWVJF0BLdrdpKoolfvFvz3kjNK7SmAmCis5z+0qb/AU=;
 b=G260L135XkxyS6Ww6hLa2Ykg/lGUP3sdc35e/xaInEeNyj5eEogvrXLwDvkTaotMdzmZWP
 aKgli9HodiQ9w/EGC7bTEdrQVFzviAkIwLWFkkZSIEB1H4DYcfFfWcuB++UQOJYzzQQkeC
 O9BOFjudHYtQjLjy/WQjGXZjkztpw2c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-wSXHzsx1MLCs0Yi1bAUi_Q-1; Mon, 11 Nov 2019 11:20:00 -0500
X-MC-Unique: wSXHzsx1MLCs0Yi1bAUi_Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 791A118B9F80;
 Mon, 11 Nov 2019 16:19:58 +0000 (UTC)
Received: from localhost (ovpn-117-169.ams2.redhat.com [10.36.117.169])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7DE8110027B3;
 Mon, 11 Nov 2019 16:19:52 +0000 (UTC)
Date: Mon, 11 Nov 2019 16:19:51 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [RFC v4 PATCH 33/49] multi-process: perform device reset in the
 remote process
Message-ID: <20191111161951.GH402228@stefanha-x1.localdomain>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <7579c5df98f9c09933685209395aa4a0e0ceb857.1571905346.git.jag.raman@oracle.com>
MIME-Version: 1.0
In-Reply-To: <7579c5df98f9c09933685209395aa4a0e0ceb857.1571905346.git.jag.raman@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cW+P/jduATWpL925"
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

--cW+P/jduATWpL925
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 24, 2019 at 05:09:14AM -0400, Jagannathan Raman wrote:
> +void proxy_device_reset(DeviceState *dev)
> +{
> +    PCIProxyDev *pdev = PCI_PROXY_DEV(dev);
> +    MPQemuMsg msg;
> +
> +    memset(&msg, 0, sizeof(MPQemuMsg));
> +
> +    msg.bytestream = 0;
> +    msg.size = sizeof(msg.data1);
> +    msg.cmd = DEVICE_RESET;
> +
> +    mpqemu_msg_send(pdev->mpqemu_link, &msg, pdev->mpqemu_link->com);
> +}

Device reset must wait for the remote process to finish reset, otherwise
the remote device could still be running after proxy_device_reset()
returns from sending the message.

Stefan

--cW+P/jduATWpL925
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3JiicACgkQnKSrs4Gr
c8g5uQf/ewoEkftvQGEMqFnS/b0KI9DpMmH8XcpWHhbGKVVn+GtR3d2UQhQYSzQC
mOE9BxmSFTDnsjuHPp8amKD36l/n+CzNKEd6QB4sXNiWQAUyhwqnwsq58a3LNyw7
IRMAXv5Sv2kdxAO+d6fc1u+FRD30I3VXf96sjyQEmae0owfYl+nQ4tauEIQdV59B
O0YY1+FJiLfGBmq509LnJ/a682i5FqbXJfk7nK8KMPzgUkKXR4la2EgexEeNcpLv
WC33C0sscQhrTckTXFLT53/h+bHusA/BNRLW+zTfuBl3LunMKyEBr+5+/5T09luF
kF2zXcf+gbtEKJ2XLD4vPFMNE4JKIA==
=kzga
-----END PGP SIGNATURE-----

--cW+P/jduATWpL925--


