Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDB3C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 10:44:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77C582086A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 10:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fetqjT66"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77C582086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyYiK-0004oh-OQ
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 06:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jyYek-0000NU-Hk
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 06:40:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29490
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jyYei-0006ez-Ut
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 06:40:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595500851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NF1hf5qXACuNCy0TasfhLA3upu814D2oay6owP6yVhw=;
 b=fetqjT66XwhsZH7k6+ovfAFrE0M74UMXsrBjKoT1/7pnlmyJ6tOxNqPX39hi6tfEEGqEnR
 R8Z6jAAi7bvq0s+wp5BTMl56/VtgEhfA6gLNg9bgE2uF/XwNFx3BU8r6qH7H59kx1nc3eI
 kXcDC7mvbfidFFlS/TCbQIZ76F5TlZg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-_HGKT6VUNyKLrmiuXLdtBQ-1; Thu, 23 Jul 2020 06:40:47 -0400
X-MC-Unique: _HGKT6VUNyKLrmiuXLdtBQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 156038015CE;
 Thu, 23 Jul 2020 10:40:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D6DCC61983;
 Thu, 23 Jul 2020 10:40:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7526E111CA26; Thu, 23 Jul 2020 12:40:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.1 1/2] tpm: Display when no backend is available
References: <20200722112333.29966-1-philmd@redhat.com>
 <20200722112333.29966-2-philmd@redhat.com>
Date: Thu, 23 Jul 2020 12:40:45 +0200
In-Reply-To: <20200722112333.29966-2-philmd@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 22 Jul 2020 13:23:32
 +0200")
Message-ID: <87r1t2ldjm.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 06:04:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Display "No TPM backend available in this binary." error when
> no backend is available.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  tpm.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/tpm.c b/tpm.c
> index fe03b24858..e36803a64d 100644
> --- a/tpm.c
> +++ b/tpm.c
> @@ -41,6 +41,22 @@ tpm_be_find_by_type(enum TpmType type)
>      return TPM_BACKEND_CLASS(oc);
>  }
> =20
> +/*
> + * Walk the list of available TPM backend drivers and count them.
> + */
> +static int tpm_backend_drivers_count(void)
> +{
> +    int count =3D 0, i;
> +
> +    for (i =3D 0; i < TPM_TYPE__MAX; i++) {
> +        const TPMBackendClass *bc =3D tpm_be_find_by_type(i);
> +        if (bc) {
> +            count++;
> +        }
> +    }
> +    return count;
> +}
> +
>  /*
>   * Walk the list of available TPM backend drivers and display them on th=
e
>   * screen.
> @@ -87,6 +103,11 @@ static int tpm_init_tpmdev(void *dummy, QemuOpts *opt=
s, Error **errp)
>      TPMBackend *drv;
>      int i;
> =20
> +    if (!tpm_backend_drivers_count()) {
> +        error_setg(errp, "No TPM backend available in this binary.");

Scratch the '.', please.  From error_setg()'s contract:

 * The resulting message should be a single phrase, with no newline or
 * trailing punctuation.

> +        return 1;
> +    }
> +
>      if (!QLIST_EMPTY(&tpm_backends)) {
>          error_setg(errp, "Only one TPM is allowed.");
>          return 1;

This works, but it's more code than I'd like to see for the purpose.

Moreover, it's tied to the error handling issue discussed in

    Subject: Re: What is TYPE_TPM_TIS_ISA? (Not an ISA Device)
    Message-ID: <87tuxyoauy.fsf@dusky.pond.sub.org>

If we revert flawed commit d10e05f15d5, then your patch needs a v2.
Your PATCH 2 might become unnecessary.  I'll give it a quick try to see
how it comes out.


