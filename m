Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773BBC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 06:57:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4323C20679
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 06:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AolksHfG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4323C20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZ8JK-0001R1-QF
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 01:57:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41277)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iZ8Ii-0000zs-8B
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 01:56:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iZ8Ig-0000GT-GQ
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 01:56:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55260
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iZ8Ig-0000E0-CP
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 01:56:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574665005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=17WZpp0myQvUFO3Lr8y8h2xcIRgCcxD50RjCcpSW9Fs=;
 b=AolksHfGLENot2n987FC6YdXtoMxc1MghjCoQ2erdQMdoxTz3aEVJMDTQsIJyNZl0zhq7P
 B1wqigIMu/ArCFOBSJGSiShT8+scVrS2VfUvDCLThx8YPz4rdc0/PPi24WzCl+2ExzQKjh
 aB0pKwEr4WUwWfcLQYfytkDgW0AQQ4I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-uggpDr6iNtSXD8ToLMoK-g-1; Mon, 25 Nov 2019 01:56:42 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F55A800EBA;
 Mon, 25 Nov 2019 06:56:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 313C560863;
 Mon, 25 Nov 2019 06:56:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A94491138606; Mon, 25 Nov 2019 07:56:33 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v17 02/14] util/cutils: Use qemu_strtold_finite to parse
 size
References: <20191122074826.1373-1-tao3.xu@intel.com>
 <20191122074826.1373-3-tao3.xu@intel.com>
Date: Mon, 25 Nov 2019 07:56:33 +0100
In-Reply-To: <20191122074826.1373-3-tao3.xu@intel.com> (Tao Xu's message of
 "Fri, 22 Nov 2019 15:48:14 +0800")
Message-ID: <87tv6sjvfi.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: uggpDr6iNtSXD8ToLMoK-g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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
Cc: lvivier@redhat.com, thuth@redhat.com, ehabkost@redhat.com, mst@redhat.com,
 jonathan.cameron@huawei.com, sw@weilnetz.de, fan.du@intel.com,
 mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org, jingqi.liu@intel.com,
 imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Tao Xu <tao3.xu@intel.com> writes:

> Support full 64bit precision, modify related test cases.

That's not true in general: long double need not be any wider than
double.

It might be true on the host machines we support, but I don't know.  If
we decide to rely on it, we better make the build fail when the host
machine doesn't meet our expectations, preferably in configure.

>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
[...]
> diff --git a/util/cutils.c b/util/cutils.c
> index 5db3b2add5..d94a468954 100644
> --- a/util/cutils.c
> +++ b/util/cutils.c
> @@ -216,13 +216,13 @@ static int do_strtosz(const char *nptr, const char =
**end,
>      const char *endptr;
>      unsigned char c;
>      int mul_required =3D 0;
> -    double val, mul, integral, fraction;
> +    long double val, mul, integral, fraction;
> =20
> -    retval =3D qemu_strtod_finite(nptr, &endptr, &val);
> +    retval =3D qemu_strtold_finite(nptr, &endptr, &val);
>      if (retval) {
>          goto out;
>      }
> -    fraction =3D modf(val, &integral);
> +    fraction =3D modfl(val, &integral);
>      if (fraction !=3D 0) {
>          mul_required =3D 1;
>      }
> @@ -238,11 +238,8 @@ static int do_strtosz(const char *nptr, const char *=
*end,
>          retval =3D -EINVAL;
>          goto out;
>      }
> -    /*
> -     * Values >=3D 0xfffffffffffffc00 overflow uint64_t after their trip
> -     * through double (53 bits of precision).
> -     */
> -    if ((val * mul >=3D 0xfffffffffffffc00) || val < 0) {
> +    /* Values > UINT64_MAX overflow uint64_t */
> +    if ((val * mul > UINT64_MAX) || val < 0) {
>          retval =3D -ERANGE;
>          goto out;
>      }

Not portable.  If it was, we'd have made this changd long ago :)


