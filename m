Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MISSING_SUBJECT,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CD7C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 11:24:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1CB420709
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 11:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BqTaIHez"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1CB420709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyZKg-0006cE-Ts
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 07:24:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jyZJy-0006AO-NU
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 07:23:30 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46738
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jyZJw-0007iU-1m
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 07:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595503406;
 h=from:from:reply-to:subject:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Mx1bnJqu1stucVZawxXWyIAgIHsL20SwpSdv9Bsbnk=;
 b=BqTaIHez6xz8awwkOgrqVpHnywbPJ6dVFflz2IdZYkcHCs8ph9AqheSkk2YAn+/8gi6sGd
 YeU0hk4y0qlvynCjsmAulrTl+6RDCyPYrmV52W4JRkQqxHb+g9jLGJSUkADE+vriibg+KV
 fejilwXI/VMX7DlItx8aNbI1HEGaLHA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-MAtNb1o3NzuQDCLGX6DteA-1; Thu, 23 Jul 2020 07:23:22 -0400
X-MC-Unique: MAtNb1o3NzuQDCLGX6DteA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D555891273;
 Thu, 23 Jul 2020 11:23:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AA4E017514;
 Thu, 23 Jul 2020 11:23:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 45C44111CA26; Thu, 23 Jul 2020 13:23:20 +0200 (CEST)
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
References: <20200723101453.11129-1-philmd@redhat.com>
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 23 Jul 2020 13:23:20 +0200
In-Reply-To: <20200723101453.11129-1-philmd@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 23 Jul 2020 12:14:53
 +0200")
Message-ID: <87a6zqjx07.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:26:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MISSING_SUBJECT=1.799, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> error_vprepend() is only used by util/error.c where it is
> defined. Make it static to reduce its scope.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  include/qapi/error.h | 6 ------
>  util/error.c         | 6 +++++-
>  2 files changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/include/qapi/error.h b/include/qapi/error.h
> index 7932594dce..fa2308dedd 100644
> --- a/include/qapi/error.h
> +++ b/include/qapi/error.h
> @@ -384,12 +384,6 @@ void error_propagate(Error **dst_errp, Error *local_=
err);
>  void error_propagate_prepend(Error **dst_errp, Error *local_err,
>                               const char *fmt, ...);
> =20
> -/*
> - * Prepend some text to @errp's human-readable error message.
> - * The text is made by formatting @fmt, @ap like vprintf().
> - */
> -void error_vprepend(Error *const *errp, const char *fmt, va_list ap);
> -
>  /*
>   * Prepend some text to @errp's human-readable error message.
>   * The text is made by formatting @fmt, ... like printf().
> diff --git a/util/error.c b/util/error.c
> index b6c89d1412..3990b741ff 100644
> --- a/util/error.c
> +++ b/util/error.c
> @@ -121,7 +121,11 @@ void error_setg_file_open_internal(Error **errp,
>                                "Could not open '%s'", filename);
>  }
> =20
> -void error_vprepend(Error *const *errp, const char *fmt, va_list ap)
> +/*
> + * Prepend some text to @errp's human-readable error message.
> + * The text is made by formatting @fmt, @ap like vprintf().
> + */
> +static void error_vprepend(Error *const *errp, const char *fmt, va_list =
ap)
>  {
>      GString *newmsg;

I prefer to keep error_vprepend() in error.h even though it's only used
in error.c at the moment.

In an external library interface, every ... function needs a va_list
buddy.

This is an internal interface, where providing only a ... function is
just fine.  I happily do that when I have no use fo the va_list
function.  But when the va_list function exists, hiding it buys us
nothing.


