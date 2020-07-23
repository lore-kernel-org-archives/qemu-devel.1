Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E5EC433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 11:00:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3075F2080D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 11:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d0uNMEtK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3075F2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyYy6-0004tU-G1
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 07:00:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jyYx1-0003yH-5u
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 06:59:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39974
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jyYwz-0002zA-Ce
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 06:59:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595501982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Av9BmIrcdzJU+qaIfcx2RianPEeOvp0pfBgXmcfok7M=;
 b=d0uNMEtKbVXK0CDEhrm479iDRLKzV8RDAyx562JaveuVz3jX58ks14yjm8VOodlrhiBnSf
 9m7MS0mhehytnFfZU6NOvvVxXYGzQo4kuA3EBMH58zVmvlaojNTqjtPQtrRimpqDo03npE
 qBJ/XVAVJ3XMtTPtJpfdJ+QkD6JLP88=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-BshrVbbxP9yGU_C9Dl3Jvg-1; Thu, 23 Jul 2020 06:59:40 -0400
X-MC-Unique: BshrVbbxP9yGU_C9Dl3Jvg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB48091273;
 Thu, 23 Jul 2020 10:59:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AE2AA5D9D3;
 Thu, 23 Jul 2020 10:59:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4446A111CA26; Thu, 23 Jul 2020 12:59:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [RFC PATCH-for-5.1 2/2] tpm: List the available TPM backends
References: <20200722112333.29966-1-philmd@redhat.com>
 <20200722112333.29966-3-philmd@redhat.com>
Date: Thu, 23 Jul 2020 12:59:38 +0200
In-Reply-To: <20200722112333.29966-3-philmd@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 22 Jul 2020 13:23:33
 +0200")
Message-ID: <87k0yulco5.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

> When an incorrect backend is selected, tpm_display_backend_drivers()
> is supposed to list the available backends. However the error is
> directly propagated, and we never display the list. The user only
> gets "Parameter 'type' expects a TPM backend type" error.
>
> Convert the fprintf(stderr,) calls to error hints propagated with
> the error.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> RFC because this is now odd in tpm_config_parse():
>
>   tpm_list_backend_drivers_hint(&error_fatal);
>   return -1;
> ---
>  tpm.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/tpm.c b/tpm.c
> index e36803a64d..358566cb10 100644
> --- a/tpm.c
> +++ b/tpm.c
> @@ -58,23 +58,21 @@ static int tpm_backend_drivers_count(void)
>  }
> =20
>  /*
> - * Walk the list of available TPM backend drivers and display them on th=
e
> - * screen.
> + * Walk the list of available TPM backend drivers and list them as Error=
 hint.
>   */
> -static void tpm_display_backend_drivers(void)
> +static void tpm_list_backend_drivers_hint(Error **errp)
>  {
>      int i;
> =20
> -    fprintf(stderr, "Supported TPM types (choose only one):\n");
> +    error_append_hint(errp, "Supported TPM types (choose only one):\n");
> =20
>      for (i =3D 0; i < TPM_TYPE__MAX; i++) {
>          const TPMBackendClass *bc =3D tpm_be_find_by_type(i);
>          if (!bc) {
>              continue;
>          }
> -        fprintf(stderr, "%12s   %s\n", TpmType_str(i), bc->desc);
> +        error_append_hint(errp, "%12s   %s\n", TpmType_str(i), bc->desc)=
;
>      }
> -    fprintf(stderr, "\n");
>  }
> =20
>  /*
> @@ -97,6 +95,7 @@ TPMBackend *qemu_find_tpm_be(const char *id)
> =20
>  static int tpm_init_tpmdev(void *dummy, QemuOpts *opts, Error **errp)
>  {
> +    ERRP_GUARD();
>      const char *value;
>      const char *id;
>      const TPMBackendClass *be;
> @@ -122,7 +121,7 @@ static int tpm_init_tpmdev(void *dummy, QemuOpts *opt=
s, Error **errp)
>      value =3D qemu_opt_get(opts, "type");
>      if (!value) {
>          error_setg(errp, QERR_MISSING_PARAMETER, "type");
> -        tpm_display_backend_drivers();
> +        tpm_list_backend_drivers_hint(errp);
>          return 1;
>      }
> =20

Yes, this is how we should list available backends together with
error_setg().  Simply printing them to stderr is wrong then.

> @@ -131,7 +130,7 @@ static int tpm_init_tpmdev(void *dummy, QemuOpts *opt=
s, Error **errp)
>      if (be =3D=3D NULL) {
>          error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "type",
>                     "a TPM backend type");
> -        tpm_display_backend_drivers();
> +        tpm_list_backend_drivers_hint(errp);
>          return 1;
>      }
> =20
> @@ -184,7 +183,7 @@ int tpm_config_parse(QemuOptsList *opts_list, const c=
har *optarg)
>      QemuOpts *opts;
> =20
>      if (!strcmp(optarg, "help")) {
> -        tpm_display_backend_drivers();
> +        tpm_list_backend_drivers_hint(&error_fatal);
>          return -1;
>      }
>      opts =3D qemu_opts_parse_noisily(opts_list, optarg, true);

A bit worse than weird:

    $ qemu-system-x86_64 -tpmdev help
    upstream-qemu: /work/armbru/qemu/util/error.c:158: error_append_hint: A=
ssertion `err && errp !=3D &error_abort && errp !=3D &error_fatal' failed.
    Aborted (core dumped)

If we choose to use Error here, then I'd recommend two functions:

1. One to append a *short* hint.  Something like this:

    qemu-system-x86_64: -tpmdev xxx,id=3Dtpm0: Parameter 'type' expects a T=
PM backend type
    Supported TPM types are passthrough, emulator.

   Actually, I wouldn't even make it a function, but simply do it inline
   for the "invalid value" case.  The missing value case can do without.
   Matter of taste.

2. Another one to print help.

Let's first decide whether to revert commit d10e05f15d5 instead.


