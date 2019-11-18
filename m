Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6395C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 22:19:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFB13222DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 22:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g8M3IVpd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFB13222DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWpMb-00078F-TC
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 17:19:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43413)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iWpLZ-0006bY-L7
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 17:18:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iWpLV-0003OZ-7x
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 17:18:13 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58704
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iWpLV-0003O6-4R
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 17:18:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574115487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ILSV+Pg7J/yXbQE8yRS33IgC+0oUGHcSUHwYXAH/GYo=;
 b=g8M3IVpdog87eE66uK+VRjUZiFga0Od6aveUN9FNB6xEOCzYvZtFvpwAPlsqq2ZFh7FEX2
 CPhCRh58uBT/iCEkhM0+8me7JVnqXLIbiryucxQlovE35J4N6duD5E9Ese1rdJW1MWis80
 QyEWqSiyA7ZJJxeekpEa3LFdPfFjBYQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-4BusJUAVO_CS_CfuSVk-eA-1; Mon, 18 Nov 2019 17:18:04 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CACF78018A2;
 Mon, 18 Nov 2019 22:18:03 +0000 (UTC)
Received: from [10.3.116.221] (ovpn-116-221.phx2.redhat.com [10.3.116.221])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 578CF60561;
 Mon, 18 Nov 2019 22:18:02 +0000 (UTC)
Subject: Re: [PATCH v3 2/4] iotests: Switch nbd tests to use Unix rather than
 TCP
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
References: <20191114213415.23499-1-eblake@redhat.com>
 <20191114213415.23499-3-eblake@redhat.com>
 <db43e495-8a10-62af-624a-c09b42488232@redhat.com>
 <b5a6953b-48b7-19a0-a1ba-c266cc81ef02@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <aa6a8693-da5d-d12f-1dd9-ee98691c3b52@redhat.com>
Date: Mon, 18 Nov 2019 16:18:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <b5a6953b-48b7-19a0-a1ba-c266cc81ef02@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 4BusJUAVO_CS_CfuSVk-eA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/18/19 11:42 AM, Eric Blake wrote:

>>> -       =20
>>> TEST_IMG=3D"$DRIVER,file.driver=3Dnbd,file.host=3D127.0.0.1,file.port=
=3D10810"
>>> +       =20
>>> TEST_IMG=3D"$DRIVER,file.driver=3Dnbd,file.type=3Dunix,file.path=3D$SOC=
KDIR/$IMGFMT"=20
>>>
>>
>> Maybe nbd.$IMGFMT?
>=20
> At first glance, it seems reasonable.=C2=A0 But reading further,
>=20
>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 elif [ "$IMGPROTO" =3D "ssh" ]; then
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TEST_IMG_FILE=3D=
$TEST_DIR/t.$IMGFMT
>>>          =20
>>> TEST_IMG=3D"$DRIVER,file.driver=3Dssh,file.host=3D127.0.0.1,file.path=
=3D$TEST_IMG_FILE"=20
>>>
>>> @@ -233,7 +233,7 @@ else
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TEST_IMG=3D$TEST=
_DIR/t.$IMGFMT
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 elif [ "$IMGPROTO" =3D "nbd" ]; then
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TEST_IMG_FILE=3D=
$TEST_DIR/t.$IMGFMT
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TEST_IMG=3D"nbd:127.0.0.1:1=
0810"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TEST_IMG=3D"nbd+unix:///?so=
cket=3D$SOCK_DIR/nbd"
>>
>> Shouldn=E2=80=99t this be $IMGFMT, too (instead of nbd)?=C2=A0 (Or maybe=
 nbd.$IMGFMT)

>=20
> If anything, I'm inclined to use $SOCK_DIR/nbd.raw to indicate that the=
=20
> NBD client sees raw format, regardless of the format in use by the=20
> server, to leave the door open for $SOCK_DIR/nbd.qcow2 when we finally=20
> are happy to test qcow2 format over NBD.

Naming the socket $SOCK_DIR/nbd.raw means that filters tend to rename it=20
to $SOCK_DIR/nbd.IMGFMT before my attempt to rename everything to=20
TEST_DIR/t.IMGFMT.  So I'm now leaning towards just naming the socket=20
$SOCK_DIR/nbd and leave it at that.

>=20
> Or stick to just $SOCK_DIR/nbd hard-coded everywhere, and quit trying to=
=20
> use $IMGFMT in the socket name, to make all the usage consistent.
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


