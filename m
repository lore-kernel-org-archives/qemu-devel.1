Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84780C33CAA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 05:55:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E16D22314
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 05:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pt5t9VHd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E16D22314
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itmVu-0002zR-DD
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 00:55:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40201)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1itmV5-0002TT-OF
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 00:54:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1itmV4-0007YW-Cv
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 00:54:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35066
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1itmV4-0007Y5-9R
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 00:54:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579586093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+qIyQWCSfZFWbNjRLzwoExhlVLnWGx7lSSwnub0bv/o=;
 b=Pt5t9VHdtWgX9I5mRJ2fsWCgBvNHI7ymJwO4oxyvOU/mxIoHzhXUQ9ajHJW0000oZ1R6Us
 W4+MdZ4Z/YAoNC5d77ETD4nt5G2DTh3KIY9gdTnNem4P2t8zSNo11gQe3C2Ywkbu+tQjCj
 WmI6SFDR/KNqRA73IsVjNhPYV9Inilg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-B4TcKBnPOk6CDFBGX3Cvrw-1; Tue, 21 Jan 2020 00:54:50 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9ECE800D55;
 Tue, 21 Jan 2020 05:54:49 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-106.ams2.redhat.com
 [10.36.116.106])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 23CD75C290;
 Tue, 21 Jan 2020 05:54:47 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 53C8616E36; Tue, 21 Jan 2020 06:54:46 +0100 (CET)
Date: Tue, 21 Jan 2020 06:54:46 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 3/3] hw/display/qxl.c: Use trace_event_get_state_backends()
Message-ID: <20200121055446.5kzjxo4sh2dldpor@sirius.home.kraxel.org>
References: <20200120151142.18954-1-peter.maydell@linaro.org>
 <20200120151142.18954-4-peter.maydell@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20200120151142.18954-4-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: B4TcKBnPOk6CDFBGX3Cvrw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jan 20, 2020 at 03:11:42PM +0000, Peter Maydell wrote:
> The preferred way to test whether a trace event is enabled is to
> use trace_event_get_state_backends(), because this will give the
> correct answer (allowing expensive computations to be skipped)
> whether the trace event is compile-time or run-time disabled.
> Convert the old-style direct use of TRACE_FOO_ENABLED.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/display/qxl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/display/qxl.c b/hw/display/qxl.c
> index 6d43b7433cf..80a4dcc40e4 100644
> --- a/hw/display/qxl.c
> +++ b/hw/display/qxl.c
> @@ -1764,7 +1764,7 @@ async_common:
>          qxl_set_mode(d, val, 0);
>          break;
>      case QXL_IO_LOG:
> -        if (TRACE_QXL_IO_LOG_ENABLED || d->guestdebug) {
> +        if (trace_event_get_state_backends(TRACE_QXL_IO_LOG) || d->guest=
debug) {

Acked-by: Gerd Hoffmann <kraxel@redhat.com>

>              /* We cannot trust the guest to NUL terminate d->ram->log_bu=
f */
>              char *log_buf =3D g_strndup((const char *)d->ram->log_buf,
>                                        sizeof(d->ram->log_buf));
> --=20
> 2.20.1
>=20


