Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482BBC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 09:52:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1370520656
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 09:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HNSZuVw/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1370520656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUSqA-0005jJ-60
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 04:52:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51254)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iUSpS-0004uo-8d
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 04:51:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iUSpQ-0005vl-FN
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 04:51:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26183
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iUSpQ-0005vX-Bu
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 04:51:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573552275;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IUrBt6Z8YT3OCPILCb5VdeEDG5vDPhgYmmE1TKoajaw=;
 b=HNSZuVw/qi5jUM0O5dc0hUKgW/K2ctcMP8tZu38O8ecxKie1Aq9hXDZYOo1sDhbYHUVg7O
 tumKtoadtF11Q+6vs4oUm/EpSeyQU8aaPR+fQujecqrq4KOIT20qM5NmL5c1FrSMMekLb3
 /45jeyV005VA/J6DaBTvhkaucwaKES0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-Le-xX2s5N-GuFLFQItg-1g-1; Tue, 12 Nov 2019 04:51:13 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5415C800C61;
 Tue, 12 Nov 2019 09:51:12 +0000 (UTC)
Received: from redhat.com (ovpn-112-58.ams2.redhat.com [10.36.112.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C57761F58;
 Tue, 12 Nov 2019 09:51:10 +0000 (UTC)
Date: Tue, 12 Nov 2019 09:51:08 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kyle Copperfield <kmcopper@danwin1210.me>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] i386: define the 'flush_l1d' CPUID feature bit
 (CVE-2018-3646)
Message-ID: <20191112095108.GL2366658@redhat.com>
References: <20191112035043.54600-1-kmcopper@danwin1210.me>
MIME-Version: 1.0
In-Reply-To: <20191112035043.54600-1-kmcopper@danwin1210.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: Le-xX2s5N-GuFLFQItg-1g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 12, 2019 at 03:50:43AM +0000, Kyle Copperfield via wrote:
> New microcode introduces the "Flush L1D Cache" CPUID feature bit.
> This needs to be exposed to guest OS to allow them to protect against
> CVE-2018-3646.

My understanding was that this is only required in the L0 hypervisor,
not the guests or nested hypervisors, which is why QEMU hadn't already
exposed this feature when L1TF first went public.

Copying Paolo for a definitive answer on that though....

>=20
> Signed-off-by: Kyle Copperfield <kmcopper@danwin1210.me>
> ---
>  docs/qemu-cpu-models.texi | 7 +++++++
>  target/i386/cpu.c         | 2 +-
>  2 files changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/docs/qemu-cpu-models.texi b/docs/qemu-cpu-models.texi
> index f88a1def0d..1b5349d86a 100644
> --- a/docs/qemu-cpu-models.texi
> +++ b/docs/qemu-cpu-models.texi
> @@ -180,6 +180,13 @@ Must be explicitly turned on for all Intel CPU model=
s.
>  Requires the host CPU microcode to support this feature before it
>  can be used for guest CPUs.
> =20
> +@item @code{flush_l1d}
> +
> +Required to enable strong Foreshadow-NG (VMM) (CVE-2018-3646) fixes in
> +guests.
> +
> +Requires the host CPU microcode to support this feature before it
> +can be used for guest CPUs.
> =20
>  @item @code{ssbd}
> =20
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index a624163ac2..1fb6d677e2 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1083,7 +1083,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WO=
RDS] =3D {
>              NULL, NULL, NULL /* pconfig */, NULL,
>              NULL, NULL, NULL, NULL,
>              NULL, NULL, "spec-ctrl", "stibp",
> -            NULL, "arch-capabilities", "core-capability", "ssbd",
> +            "flush_l1d", "arch-capabilities", "core-capability", "ssbd",
>          },
>          .cpuid =3D {
>              .eax =3D 7,
> --=20
> 2.24.0
>=20
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


