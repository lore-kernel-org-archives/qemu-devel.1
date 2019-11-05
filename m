Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA78DC5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 16:07:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EBC0214B2
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 16:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZQvXhoe9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EBC0214B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45765 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS1MB-0003FS-Kf
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 11:06:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50564)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iS1Kg-0001D3-1X
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 11:05:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iS1Ke-0007h1-LN
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 11:05:25 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43464
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iS1Ke-0007gk-Fj
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 11:05:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572969924;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J+/oEDOM8gObPPNsK0OjXuh8yeE9Y3pgBcFos/rAZ1s=;
 b=ZQvXhoe9wNTXCt5IIWiZa4iikan73BN7jNeJesk5vXIcInyEaB3pSLJjwASgvzawE43QEZ
 ZBjmCG/3byvCYIXb+N+6axLvE4PXNaX8KmXo0tDMgiudkZqPu0K8hHE+QSv/ebSDTNhmFe
 lk9QbjIRX3Y++AVp8vDQGKK81c+s/AQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-dkYk25YbNRKHZv7_UZbyGQ-1; Tue, 05 Nov 2019 11:05:19 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28067477;
 Tue,  5 Nov 2019 16:05:18 +0000 (UTC)
Received: from redhat.com (ovpn-112-59.ams2.redhat.com [10.36.112.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E25B8600F6;
 Tue,  5 Nov 2019 16:05:11 +0000 (UTC)
Date: Tue, 5 Nov 2019 16:05:08 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v2] Makefile: Fix config-devices.mak not regenerated when
 Kconfig updated
Message-ID: <20191105160508.GF42501@redhat.com>
References: <20191105151209.1814-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191105151209.1814-1-philmd@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: dkYk25YbNRKHZv7_UZbyGQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 05, 2019 at 04:12:09PM +0100, Philippe Mathieu-Daud=C3=A9 wrote=
:
> When hw/$DIR/Kconfig is changed, the corresponding generated
> hw/$DIR/config-devices.mak is not being updated.
> Fix this by including all the hw/*/Kconfig files to the prerequisite
> names of the rule generating the config-devices.mak files.
>=20
> Fixes: e0e312f3525a (build: switch to Kconfig)
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v2:
> Simplify using the wildcard() function instead of calling `sed` (danpb)
>=20
> You can see this tread where Peter reported the failure:
> https://lists.gnu.org/archive/html/qemu-devel/2019-11/msg00125.html
>=20
> How to reproduce:
>=20
>   $ git checkout branch_modifying_kconfig
>   $ make i386-softmmu/all
>   $ make clean
>   $ git checkout prev_branch
>   $ make clean
>   $ make i386-softmmu/all
>     # error
>=20
> If OK, I plan to include this fix in the "hw/i386/pc: Split PIIX3
> southbridge from i440FX northbridge" pull request.
> ---
>  Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


