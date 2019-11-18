Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807A2C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 22:36:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A702222EF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 22:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QyOEpapv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A702222EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWpdg-0007W5-E2
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 17:36:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46023)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iWpd2-00073J-7f
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 17:36:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iWpd1-0002wA-2v
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 17:36:16 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43727
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iWpd0-0002w2-Vn
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 17:36:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574116574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yfv83myNzXRDvq8bXPFxYIjRvaGkOC1J3nKntq9z5fI=;
 b=QyOEpapvPZMMqzB+5mKyioYb+j0oikzTfdNQQUveXDXtqf3xJsZWnEoQXpp+8WLpOmH4j7
 mXrBkNrW0xo8/3VyZvk8Q9OHXodbO/Z5+F892fCRfDCgrY/x4WGbBwxkQOp/VrvFljGFOX
 qAvpq/WPcmhLqcoQiKFIlzx4y/Q6OrE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-2tchTTO8M0izWBbQdq4bFg-1; Mon, 18 Nov 2019 17:36:11 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56DFF107ACC4;
 Mon, 18 Nov 2019 22:36:10 +0000 (UTC)
Received: from [10.3.116.221] (ovpn-116-221.phx2.redhat.com [10.3.116.221])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F2C465DE56;
 Mon, 18 Nov 2019 22:36:09 +0000 (UTC)
Subject: Re: [PATCH v3 2/4] iotests: Switch nbd tests to use Unix rather than
 TCP
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
References: <20191114213415.23499-1-eblake@redhat.com>
 <20191114213415.23499-3-eblake@redhat.com>
 <db43e495-8a10-62af-624a-c09b42488232@redhat.com>
 <b5a6953b-48b7-19a0-a1ba-c266cc81ef02@redhat.com>
 <aa6a8693-da5d-d12f-1dd9-ee98691c3b52@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <d1a92f5b-b752-747e-cb2c-f98ffb26d53a@redhat.com>
Date: Mon, 18 Nov 2019 16:36:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <aa6a8693-da5d-d12f-1dd9-ee98691c3b52@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 2tchTTO8M0izWBbQdq4bFg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/18/19 4:18 PM, Eric Blake wrote:

>>
>> If anything, I'm inclined to use $SOCK_DIR/nbd.raw to indicate that=20
>> the NBD client sees raw format, regardless of the format in use by the=
=20
>> server, to leave the door open for $SOCK_DIR/nbd.qcow2 when we finally=
=20
>> are happy to test qcow2 format over NBD.
>=20
> Naming the socket $SOCK_DIR/nbd.raw means that filters tend to rename it=
=20
> to $SOCK_DIR/nbd.IMGFMT before my attempt to rename everything to=20
> TEST_DIR/t.IMGFMT.=C2=A0 So I'm now leaning towards just naming the socke=
t=20
> $SOCK_DIR/nbd and leave it at that.
>=20
>>
>> Or stick to just $SOCK_DIR/nbd hard-coded everywhere, and quit trying=20
>> to use $IMGFMT in the socket name, to make all the usage consistent.

In order to get my NBD 4.2-rc2 pull request out, I'll be squashing this=20
in (having tested that my usual iotest configurations still pass)::

diff --git i/tests/qemu-iotests/common.rc w/tests/qemu-iotests/common.rc
index f772dcb67322..0cc8acc9edd2 100644
--- i/tests/qemu-iotests/common.rc
+++ w/tests/qemu-iotests/common.rc
@@ -217,7 +217,7 @@ if [ "$IMGOPTSSYNTAX" =3D "true" ]; then
          TEST_IMG=3D"$DRIVER,file.filename=3D$TEST_DIR/t.$IMGFMT"
      elif [ "$IMGPROTO" =3D "nbd" ]; then
          TEST_IMG_FILE=3D$TEST_DIR/t.$IMGFMT
-=20
TEST_IMG=3D"$DRIVER,file.driver=3Dnbd,file.type=3Dunix,file.path=3D$SOCKDIR=
/$IMGFMT"
+=20
TEST_IMG=3D"$DRIVER,file.driver=3Dnbd,file.type=3Dunix,file.path=3D$SOCKDIR=
/nbd"
      elif [ "$IMGPROTO" =3D "ssh" ]; then
          TEST_IMG_FILE=3D$TEST_DIR/t.$IMGFMT
=20
TEST_IMG=3D"$DRIVER,file.driver=3Dssh,file.host=3D127.0.0.1,file.path=3D$TE=
ST_IMG_FILE"
@@ -349,7 +349,10 @@ _make_test_img()
       fi
      ) | _filter_img_create

-    # Start an NBD server on the image file, which is what we'll be=20
talking to
+    # Start an NBD server on the image file, which is what we'll be=20
talking to.
+    # Once NBD gains resize support, we may also want to use -f raw at the
+    # server and interpret format over NBD, but for now, the format is
+    # interpreted at the server and raw data sent over NBD.
      if [ $IMGPROTO =3D "nbd" ]; then
          # Pass a sufficiently high number to -e that should be enough=20
for all
          # tests



--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


