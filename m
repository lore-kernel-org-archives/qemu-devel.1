Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF73EC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:28:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76E3720656
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O/7zZ+re"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76E3720656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUCYb-0004WU-5v
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 11:28:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iUCON-0001fz-Nb
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:18:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iUCOM-0000xB-Ol
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:18:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35098
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iUCOM-0000wp-Kb
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:18:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573489094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=otuJw9JNG82r6Yc5nqB2jJmjqORw95JnMfvnLN5/Wvc=;
 b=O/7zZ+recjg8bA2yeHFtemxCYtlJLMrCvMoz+k76FsJ4ooTtvuQ5xoBpe43Axg+VWz7vrK
 BSVJwwkje48UEmvlPTa+3dDQAWkEo9YAOyoVL9PRBu0ikILoCku1Eg3MMQ+q1BCL5EjF8A
 rxRfbjiEg5TaMWc3Zxi73UGx2ZLBnuk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-gFjAHk4XPeu8ntmt35iUpg-1; Mon, 11 Nov 2019 11:18:10 -0500
X-MC-Unique: gFjAHk4XPeu8ntmt35iUpg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84D00801E65;
 Mon, 11 Nov 2019 16:18:08 +0000 (UTC)
Received: from localhost (ovpn-117-169.ams2.redhat.com [10.36.117.169])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 44CD910027A5;
 Mon, 11 Nov 2019 16:18:00 +0000 (UTC)
Date: Mon, 11 Nov 2019 16:17:59 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [RFC v4 PATCH 45/49] multi-process/mig: Synchronize runstate of
 remote process
Message-ID: <20191111161759.GG402228@stefanha-x1.localdomain>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <5ef7500148d9c15b236f551f6af7b8a4a8d6e81d.1571905346.git.jag.raman@oracle.com>
MIME-Version: 1.0
In-Reply-To: <5ef7500148d9c15b236f551f6af7b8a4a8d6e81d.1571905346.git.jag.raman@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="aYDVKSzuImP48n7V"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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

--aYDVKSzuImP48n7V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2019 at 05:09:26AM -0400, Jagannathan Raman wrote:
> @@ -656,6 +657,19 @@ static void init_proxy(PCIDevice *dev, char *command=
, bool need_spawn, Error **e
>      }
>  }
> =20
> +static void proxy_vm_state_change(void *opaque, int running, RunState st=
ate)
> +{
> +    PCIProxyDev *dev =3D opaque;
> +    MPQemuMsg msg =3D { 0 };
> +
> +    msg.cmd =3D RUNSTATE_SET;
> +    msg.bytestream =3D 0;
> +    msg.size =3D sizeof(msg.data1);
> +    msg.data1.runstate.state =3D state;
> +
> +    mpqemu_msg_send(dev->mpqemu_link, &msg, dev->mpqemu_link->com);
> +}

Changing vm state is a barrier operation - devices must not dirty memory
afterwards.  This function doesn't have barrier semantics, it sends off
the message without waiting for the remote process to finish processing
it.  This means there is a race condition where QEMU has changes the vm
state but devices could still dirty memory.  Please wait for a reply to
prevent this.

Stefan

--aYDVKSzuImP48n7V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3JibcACgkQnKSrs4Gr
c8jQzwf/eb7ocs8qPPvhiZTUWwVvV4XzDAd53RqwVFp1SSPGt7WxxDNHcYNPiVbW
W5SWtl/WQUvjsaBuSf46WOf73Or830T8GN6EfulyuqiV2zx3wMZbMFnoSVGIYodm
b7qcvk3QOPMUDl940FgcA9D1vcIA0U9jEzxJfTkvkU+aDIv9mlY03uCOZ135UYe7
TZKdmEipJLGdfiJRUwvR/AtAb7+voIVCsJXgBPVFx6w4FTUCzXAPcLSXzBd7UE34
sJHKU+/vQGAZUCDTtJHrysjFBjTpkfnZ3/oLOEvduZcKCtVzb9zhlbg76pgdtvyP
n54Nmj1Yk4cLWFMZ+vzxXXQaFdWPGA==
=OYg2
-----END PGP SIGNATURE-----

--aYDVKSzuImP48n7V--


