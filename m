Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B70CC17460
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 14:56:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E90A221D6C
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 14:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z4SHkOTg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E90A221D6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS0Fa-0000va-4l
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 09:56:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58038)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iS0Ew-0000PC-5i
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 09:55:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iS0Et-00085Z-4C
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 09:55:24 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60589
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iS0Es-00084j-WA
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 09:55:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572965721;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7UdZG6IFkrI1ioyNoi+m3sm1fA5C97/+mk5JqyaHzBg=;
 b=Z4SHkOTgC8JwvdLfTPFuaRlIEQ40/ZE09J9h95I9TPPT+RKAVH7b7y0UpzAbzZxXNCiJQg
 /PD3BNXYL59DlESBzUdDU0fyfcMorwh8usBjmoYu42v+YKJXsgpbdDhmrGCnYjqa8pbjRr
 uIed7c9/uoNz3tAevIhcj7EM+HMg+9Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-LQ4I26OzOKuyk1PZ7BfWJg-1; Tue, 05 Nov 2019 09:55:17 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7D8E1005500;
 Tue,  5 Nov 2019 14:55:15 +0000 (UTC)
Received: from redhat.com (ovpn-112-59.ams2.redhat.com [10.36.112.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 602C946;
 Tue,  5 Nov 2019 14:55:06 +0000 (UTC)
Date: Tue, 5 Nov 2019 14:55:03 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] Makefile: Fix config-devices.mak not regenerated when
 Kconfig updated
Message-ID: <20191105145503.GE42501@redhat.com>
References: <20191104095530.22091-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191104095530.22091-1-philmd@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: LQ4I26OzOKuyk1PZ7BfWJg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 04, 2019 at 10:55:30AM +0100, Philippe Mathieu-Daud=C3=A9 wrote=
:
> When hw/$DIR/Kconfig is changed, the corresponding generated
> hw/$DIR/config-devices.mak is not being updated.
> Fix this by including all the hw/*/Kconfig files to the prerequisite
> names of the rule generating the config-devices.mak files.
>=20
> Fixes: e0e312f3525a (build: switch to Kconfig)
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> If OK, I plan to include this fix in the "hw/i386/pc: Split PIIX3
> southbridge from i440FX northbridge" pull request.
> ---
>  Makefile | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/Makefile b/Makefile
> index 0e994a275d..c1461b21e8 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -384,7 +384,10 @@ MINIKCONF_ARGS =3D \
>      CONFIG_LINUX=3D$(CONFIG_LINUX) \
>      CONFIG_PVRDMA=3D$(CONFIG_PVRDMA)
> =20
> -MINIKCONF_INPUTS =3D $(SRC_PATH)/Kconfig.host $(SRC_PATH)/hw/Kconfig
> +MINIKCONF_INPUTS =3D $(SRC_PATH)/Kconfig.host $(SRC_PATH)/hw/Kconfig \
> +                   $(patsubst %,$(SRC_PATH)/hw/%,$(shell sed -ne \
> +                                                    's/source \(.*\)/\1/=
p' \
> +                                                    < $(SRC_PATH)/hw/Kco=
nfig))

Why can't we use the simpler wildcard statement:

   $(wildcard $(SRC_PATH)/hw/*/Kconfig)

instead of reading the file names from the hw/Kconfig file ?

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


