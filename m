Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BC4C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 11:00:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AED7620730
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 11:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i6yzi5qA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AED7620730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWelk-0000nZ-5o
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 06:00:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45760)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iWejw-0007Uj-T5
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 05:58:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iWejv-0000Rn-Dt
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 05:58:40 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54043
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iWejv-0000PD-8I
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 05:58:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574074716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FCBKW2xKWLtfQCtme/NQ8EP4WP4Ndf8NS2vzk3+ZRus=;
 b=i6yzi5qAqqq8haWrOIFU+iVoBf6OIjdXYiuH5u3rxfxZJ3RVcQHPvJyKh3dZTCxdHX1TKv
 /QvMQtfdLeCKmDIySy8IsYkO2ehmcDn4/bKJB7KXNw+5aq9TLime+CvkZpvvm4pOb1o8N+
 0KxQcul2aM0y1/kW9czDcwi6LMjQF6o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-IQ6pw-0FOgOuJuinvxyIhQ-1; Mon, 18 Nov 2019 05:58:34 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65BD69376F
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 10:58:33 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-200.ams2.redhat.com
 [10.36.116.200])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 92E452AABC;
 Mon, 18 Nov 2019 10:58:32 +0000 (UTC)
Subject: Re: [PATCH 02/16] vl: extract accelerator option processing to a
 separate function
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1573655945-14912-1-git-send-email-pbonzini@redhat.com>
 <1573655945-14912-3-git-send-email-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5e5a4b1e-4ada-11f6-c551-c15de2404e7f@redhat.com>
Date: Mon, 18 Nov 2019 11:58:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <1573655945-14912-3-git-send-email-pbonzini@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: IQ6pw-0FOgOuJuinvxyIhQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/11/2019 15.38, Paolo Bonzini wrote:
> As a first step towards supporting multiple "-accel" options, push -icoun=
t
> and -accel semantics into a new function, and use qemu_opts_foreach to
> retrieve the key/value lists instead of stashing them into globals.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  vl.c | 40 ++++++++++++++++++++++++++++------------
>  1 file changed, 28 insertions(+), 12 deletions(-)
>=20
> diff --git a/vl.c b/vl.c
> index 841fdae..5367f23 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2827,6 +2827,33 @@ static void user_register_global_props(void)
>                        global_init_func, NULL, NULL);
>  }
> =20
> +static int do_configure_icount(void *opaque, QemuOpts *opts, Error **err=
p)
> +{
> +    if (tcg_enabled()) {
> +        configure_icount(opts, errp);
> +    } else {
> +        error_setg(errp, "-icount is not allowed with hardware virtualiz=
ation");
> +    }
> +    return 0;
> +}
> +
> +static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error =
**errp)
> +{
> +    if (tcg_enabled()) {
> +        qemu_tcg_configure(opts, &error_fatal);
> +    }
> +    return 0;
> +}
> +
> +static void configure_accelerators(void)
> +{
> +    qemu_opts_foreach(qemu_find_opts("icount"),
> +                      do_configure_icount, NULL, &error_fatal);
> +
> +    qemu_opts_foreach(qemu_find_opts("accel"),
> +                      do_configure_accelerator, NULL, &error_fatal);
> +}

vl.c is already quite overcrowded ... maybe you could add the new code
to accel/accel.c instead? Just my 0.02 =80.

 Thomas


