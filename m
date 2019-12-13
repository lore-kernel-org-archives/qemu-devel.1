Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFD7C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 10:59:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA3B42073D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 10:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VpQ5rB/w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA3B42073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifif8-0004bH-1y
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 05:59:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42491)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1ifieH-00049W-Nh
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 05:58:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1ifieG-0004Pp-Mi
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 05:58:17 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59003
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ifieG-0004Ob-IC
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 05:58:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576234696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WcwDSIEVYb5M/qdDapHPjyXBPTo+1Lk/4FWa6kFValU=;
 b=VpQ5rB/wsdIoOq2wteWPidi6zzMHD5Q/S+aLh09Z09IjsXD3iL6W1SK9kiwXJpWTQFMJ9S
 KZ+S3S2NGFmvMZW98LuJgkfnNiQsydJPESgHQ3z94OxHSD/3SdGOZ45uxJRsT6qhN9G0Ls
 XkFToHQuO8T5GZp1rMtxNtLFRr95A+8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-LH-3h8WJOJ6cI1BMPqwduw-1; Fri, 13 Dec 2019 05:58:12 -0500
X-MC-Unique: LH-3h8WJOJ6cI1BMPqwduw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD822DB60;
 Fri, 13 Dec 2019 10:58:11 +0000 (UTC)
Received: from localhost (unknown [10.36.118.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3D34960148;
 Fri, 13 Dec 2019 10:58:11 +0000 (UTC)
Date: Fri, 13 Dec 2019 10:58:10 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Coiby Xu <coiby.xu@gmail.com>
Subject: Re: How to extend QEMU's vhost-user tests after implementing
 vhost-user-blk device backend
Message-ID: <20191213105810.GD1180977@stefanha-x1.localdomain>
References: <CAJAkqrXyeVn4iy7NzkR__BS9q9xT4ZWcjJszNBaSKH0U57c4hw@mail.gmail.com>
 <20191114111429.GC580024@stefanha-x1.localdomain>
 <CAJAkqrULM=wjDEVV8kZBU4u1ag4ERiKq3z5yzRus3vqwsx_a4A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJAkqrULM=wjDEVV8kZBU4u1ag4ERiKq3z5yzRus3vqwsx_a4A@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OROCMA9jn6tkzFBc"
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--OROCMA9jn6tkzFBc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2019 at 11:25:32PM +0800, Coiby Xu wrote:
> I'm now writing the tests for vhost-user-blk device based on
> tests/virtio-blk-test.c. But block_resize command doesn't apply to
> vhost-user-blk device.
>=20
> After launching vhost-user backend server, I type the following
> command to connect to it
>=20
> (qemu) chardev-add socket,id=3Dchar1,path=3D/tmp/vhost-user-blk_vhost.soc=
ket
> (qemu) object_add memory-backend-memfd,id=3Dmem,size=3D256M,share=3Don
> (qemu) device_add vhost-user-blk-pci,id=3Dblk0,chardev=3Dchar1
> (qemu) block_resize blk0 512
> Error: Cannot find device=3Dblk0 nor node_name=3D
>=20
> QEMU can't find the device although in the guest OS I can already
> mount /dev/vda. And `info block` doesn't list the newly added
> vhost-user-blk device,
> (qemu) info block
> disk (#block154): dpdk.img (raw)
>     Attached to:      /machine/peripheral-anon/device[0]
>     Cache mode:       writeback
>=20
> floppy0: [not inserted]
>     Attached to:      /machine/unattached/device[17]
>     Removable device: not locked, tray closed
>=20
> sd0: [not inserted]
>     Removable device: not locked, tray close
>=20
> It seems `info block` and `block_resize` only work with `drive_add`
> which is not necessary for vhost-user-blk device.

Yes, -device vhost-user-blk doesn't have a BlockDriverState (-drive or
-blockdev) because it communicates with the vhost-user device backend
over a character device instead.

> Should I let QEMU
> support adding vhost-user backend device in the way similar to adding
> NBD device(`drive_add -n buddy
> file.driver=3Dnbd,file.host=3Dlocalhost,file.port=3D49153,file.export=3Dd=
isk,node-name=3Dnbd_client1`),
> i.e., a drive can be added via `drive_add -n buddy
> file.driver=3Dvhost-user,file.sock=3D/tmp/vhost-user-blk_vhost.socket,nod=
e-name=3Dvhost_user_client1`?

That is probably too much work.  It's fine to skip test cases that
resize the disk.

Stefan

--OROCMA9jn6tkzFBc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3zbsIACgkQnKSrs4Gr
c8isTgf/QKyEnMFmgvLz+6i0ToFDWKsqJPRijtM/twCjVwWIcTwbQSUnHp7+QgUy
rEs8moO2MAfoL66EeAwaRG833DWF/U+M1p/q/7PQTcz9OYJm8rOFxYdqx7f1Xauf
fCzDwELF8kM0bGnbUGLcDGwkP4nHcDe2/ZhDtqsdshfyqOpbvJDEXOBwGCqCHPvP
a+TW7D+k8fX48v5AIwsKOFEJIewGvGYHCYH9RvSh9keSv5+enx8iLoi2n8gg+Emi
e/MY8GnBqu98WfcBIEmxnEb9M6RLcKMGfmKCt0frsvcnoaR4OMlr5EzF1C3xuY+G
kP6d1/aijJx0cxj8LDgt2zj553xkmQ==
=npFQ
-----END PGP SIGNATURE-----

--OROCMA9jn6tkzFBc--


