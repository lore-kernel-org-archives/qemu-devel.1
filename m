Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F41C3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 15:33:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75BEE20838
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 15:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mfa/eyO9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75BEE20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iydj2-0004B2-NY
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 10:33:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59416)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iydiQ-0003Xe-4W
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:32:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iydiM-0008J8-Qz
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:32:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31900
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iydiM-0008IN-Mg
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:32:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580743961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hPUm+G72d3KpQXr5lxWrMSx55UskECvATVb/9dFJxJs=;
 b=Mfa/eyO9tFfkOJFnCdIucjEWowNecGo+WMgr6njx3oKN81Q7BJ31lWpw5Uqcr/PF1lgYcW
 iGJ0zMFw3m13dNc7/7ANOK18JjQeH5VV8E5AwJbxXVZI4hrDTLrUtosg6rXN/+wWpkMzjJ
 AbvQ+wGycA52XXNKeWl6x0uS9eAqoA4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310--btEwXSUN9iqReu1jJ4Ttw-1; Mon, 03 Feb 2020 10:32:31 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33DC4194E168;
 Mon,  3 Feb 2020 15:32:30 +0000 (UTC)
Received: from [10.3.116.181] (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B6BEB5DA84;
 Mon,  3 Feb 2020 15:32:29 +0000 (UTC)
Subject: Re: [PATCH] tests/qemu_iotests: Minimize usage of used ports
To: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 qemu-block@nongnu.org
References: <20200203075955.28861-1-ldoktor@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <fd77ffab-6c6c-03f2-2982-a6e14c1f16d4@redhat.com>
Date: Mon, 3 Feb 2020 09:32:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200203075955.28861-1-ldoktor@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: -btEwXSUN9iqReu1jJ4Ttw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/3/20 1:59 AM, Luk=C3=A1=C5=A1 Doktor wrote:
> Using a range of ports from 32768 to 65538 is dangerous as some
> application might already be listening there and interfere with the
> testing. There is no way to reserve ports, but let's decrease the chance
> of interactions by only using ports that were free at the time of
> importing this module.
>=20
> Without this patch CI occasionally fails with used ports. Additionally I
> tried listening on the first port to be tried via "nc -l localhost
> $port" and no matter how many other ports were available it always
> hanged for infinity.
>=20
> Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> ---
>   tests/qemu-iotests/147        | 43 ++++++++++++++++-------
>   tests/qemu-iotests/iotests.py | 64 +++++++++++++++++++++++++++++++++++
>   2 files changed, 94 insertions(+), 13 deletions(-)

Is it worth sharing the logic already present in common.nbd's=20
nbd_server_start_tcp_socket shell function?  (Oh right, that's shell,=20
this is python).  It seems like we keep reinventing logic to pick a safe=20
port.

>=20
> diff --git a/tests/qemu-iotests/147 b/tests/qemu-iotests/147
> index 2b6f859a09..4d0e1418bb 100755
> --- a/tests/qemu-iotests/147
> +++ b/tests/qemu-iotests/147
> @@ -26,10 +26,8 @@ import time
>   import iotests
>   from iotests import cachemode, aiomode, imgfmt, qemu_img, qemu_nbd, qem=
u_nbd_early_pipe
>  =20
> -NBD_PORT_START      =3D 32768
> -NBD_PORT_END        =3D NBD_PORT_START + 1024
> -NBD_IPV6_PORT_START =3D NBD_PORT_END
> -NBD_IPV6_PORT_END   =3D NBD_IPV6_PORT_START + 1024
> +NBD_PORTS =3D iotests.find_free_ports(32768, 65536, 1024)
> +NBD_IPV6_PORTS =3D iotests.find_free_ports(NBD_PORTS[-1] + 1, 65536, 102=
4)

The changes here look sane...

> +++ b/tests/qemu-iotests/iotests.py
> @@ -20,6 +20,7 @@ from __future__ import print_function
>   import errno
>   import os
>   import re
> +import socket
>   import subprocess
>   import string
>   import unittest
> @@ -75,6 +76,69 @@ luks_default_secret_object =3D 'secret,id=3Dkeysec0,da=
ta=3D' + \
>   luks_default_key_secret_opt =3D 'key-secret=3Dkeysec0'
>  =20
>  =20
> +def is_port_free(port, address):

...and I'm glad you're adding a reusable method here.

> +    """
> +    Return True if the given port is available for use.
> +
> +    Currently we only check for TCP/UDP connections on IPv4/6
> +    Backported from avocado.utils.network
> +
> +    :param port: Port number
> +    :param address: Socket address to bind or connect
> +    """
> +    families =3D (socket.AF_INET, socket.AF_INET6)
> +    if address =3D=3D "localhost" or not address:
> +        localhost =3D True
> +        protocols =3D (socket.SOCK_STREAM, socket.SOCK_DGRAM)
> +    else:
> +        localhost =3D False
> +        # sock.connect always connects for UDP
> +        protocols =3D (socket.SOCK_STREAM, )
> +    sock =3D None
> +    try:
> +        for family in families:
> +            for protocol in protocols:
> +                try:
> +                    sock =3D socket.socket(family, protocol)
> +                    if localhost:
> +                        sock.bind(("", port))
> +                    else:
> +                        sock.connect((address, port))
> +                        return False
> +                except socket.error as exc:
> +                    if exc.errno in (93, 94):   # Unsupported combinatio=
ns

Ouch - that seems rather hard-coded (not all the world uses the same=20
errno values as Linux).  Does python have symbolic names for=20
EPROTONOSUPPORT and ESOCKTNOSUPPORT?

> +                        continue
> +                    if localhost:
> +                        return False
> +                sock.close()
> +        return True
> +    finally:
> +        if sock is not None:
> +            sock.close()
> +
> +
> +def find_free_ports(start_port, end_port, count, address=3D"localhost"):
> +    """
> +    Return count of host free ports in the range [start_port, end_port].
> +
> +    Backported from avocado.utils.network
> +
> +    :param start_port: header of candidate port range
> +    :param end_port: ender of candidate port range

s/ender/end/

> +    :param count: Initial number of ports known to be free in the range.
> +    :param address: Socket address to bind or connect
> +    """
> +    ports =3D []
> +    port_range =3D range(start_port, end_port)
> +    for i in port_range:
> +        if is_port_free(i, address):
> +            ports.append(i)
> +        if len(ports) >=3D count:
> +            break
> +
> +    return ports
> +
> +
>   def qemu_img(*args):
>       '''Run qemu-img and return the exit code'''
>       devnull =3D open('/dev/null', 'r+')
>=20

I'd like a second review on this (my python is tolerable, but not=20
strong), but I'm happy to take it through my NBD tree if no one else=20
speaks up first.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


