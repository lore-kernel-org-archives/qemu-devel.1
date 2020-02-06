Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB84CC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 08:22:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B01EF206CC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 08:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T/iVFsjK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B01EF206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izcQy-0005d1-SZ
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 03:22:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55641)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1izcQ3-0004gs-LZ
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 03:21:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1izcQ2-0003V6-J6
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 03:21:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40291
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1izcQ2-0003Ta-FV
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 03:21:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580977310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=Svt3OhLXhjZrtoDmVyOWrYlykg3MANsPLMLSNro1SiY=;
 b=T/iVFsjKw0j4Kpacu/brK6qp/fCt6zGhLLqJhDvb4ogYeyyuBJfarl9dkNWa0w5I3GWmGT
 kpjWNwpNFsmmFFm+bXjHiIlALXxcb53Uy7CH/tyTTBRZ4n6xgJ3ZBgpoGKMHkTNSW2u7rV
 r6ETAX6FQl4dF8glViyQjxkj+S+TK+M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-rRpghXC3Py-__HNT1RnkZg-1; Thu, 06 Feb 2020 03:21:46 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E99F88010D6;
 Thu,  6 Feb 2020 08:21:44 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-151.ams2.redhat.com [10.36.116.151])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BC4025DA7C;
 Thu,  6 Feb 2020 08:21:42 +0000 (UTC)
Subject: Re: [PATCH] aspeed/i2c:fix uninitialized variable warning
To: kuhn.chenqun@huawei.com, qemu-devel@nongnu.org, clg@kaod.org,
 peter.maydell@linaro.org
References: <20200206040753.42252-1-kuhn.chenqun@huawei.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <3b091938-34a4-0a75-3a86-93195a2382e2@redhat.com>
Date: Thu, 6 Feb 2020 09:21:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200206040753.42252-1-kuhn.chenqun@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: rRpghXC3Py-__HNT1RnkZg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: qemu-trivial@nongnu.org, andrew@aj.id.au,
 Miroslav Rezanina <mrezanin@redhat.com>, zhang.zhanghailiang@huawei.com,
 joel@jms.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/02/2020 05.07, kuhn.chenqun@huawei.com wrote:
> From: Chen Qun <kuhn.chenqun@huawei.com>
>=20
> Fix warning:
> hw/i2c/aspeed_i2c.c: In function =E2=80=98aspeed_i2c_bus_write=E2=80=99:
> glib/glib-autocleanups.h:28:3: warning: =E2=80=98cmd_flags=E2=80=99 may b=
e
> used uninitialized in this function [-Wmaybe-uninitialized]
>    g_free (*pp);
>    ^~~~~~~~~~~~
> hw/i2c/aspeed_i2c.c:403:22: note: =E2=80=98cmd_flags=E2=80=99 was declare=
d here
>      g_autofree char *cmd_flags;
>                       ^~~~~~~~~
>=20
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> ---
>  hw/i2c/aspeed_i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
> index 9cda968501..fb973a983d 100644
> --- a/hw/i2c/aspeed_i2c.c
> +++ b/hw/i2c/aspeed_i2c.c
> @@ -400,7 +400,7 @@ static bool aspeed_i2c_check_sram(AspeedI2CBus *bus)
> =20
>  static void aspeed_i2c_bus_cmd_dump(AspeedI2CBus *bus)
>  {
> -    g_autofree char *cmd_flags;
> +    g_autofree char *cmd_flags =3D NULL;
>      uint32_t count;
> =20
>      if (bus->cmd & (I2CD_RX_BUFF_ENABLE | I2CD_RX_BUFF_ENABLE)) {
>=20

Thanks. Looks like the same patch that has been reported already here:

https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg04492.html

Could someone please pick this up (e.g. qemu-trivial?)?

 Thomas


