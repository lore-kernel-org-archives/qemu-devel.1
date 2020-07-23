Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF2BC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:51:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECA6E20768
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y2wbib1z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECA6E20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyah8-0003h4-7W
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 08:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jyag2-0002kK-EE
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 08:50:22 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45446
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jyag0-0007B9-J6
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 08:50:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595508619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xpWQa6+CL5lg1MaENFD6TyJMCqCme0AksyrnzvZiKkE=;
 b=Y2wbib1zoEb+RR80N2S5I6dVCHT8pHVqGY7VwjSZ7oF930a/5vr05PEHindNGEEhD182xp
 l36lb3fdtmLLoUebedSGEibuGXsrRWTBMkA8YLsHWDQSNu3iB5TLPJ+oY72gkF6yrPMn4t
 CQcBXAj3O+b3IBfRjJsViiTUFYGEZh0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-4lrNltGdNIKM7oPkvgU4_Q-1; Thu, 23 Jul 2020 08:50:18 -0400
X-MC-Unique: 4lrNltGdNIKM7oPkvgU4_Q-1
Received: by mail-wm1-f72.google.com with SMTP id u68so2327402wmu.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 05:50:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=xpWQa6+CL5lg1MaENFD6TyJMCqCme0AksyrnzvZiKkE=;
 b=JDrJiclXYRRRDlkwlHTYb7GZYpSlJ1Af1yfZvErMEwAWItDr1cdQhchrhpnQVILcGt
 pf5f5WKbH5qe23Iv74fxDwqTwpQnspQY1X9hbjqyn5yy+HmXmbI9nYqjdDWC2tW8cC4e
 1gdc7C24F2CvjPZEiHeiquWAB90W6CAAxYO361Kv+9yUKK+QGdfglMldkP2xwr/1nspl
 Ka6oqHNLU2vMRGIcy9gqvaIPI2pv0q1/SY0L0JgXuJjXZe2w2gdQVyftgzrR8983rxDB
 63jygjaHq2YroBgL3oWRZwstgnbojXE0DFW4DppiM9JjsTYxz4BHttmT3R2NR61nk5U1
 Dp/Q==
X-Gm-Message-State: AOAM530yjkSY/v2KjGqq9d9LeUr+LqC6/z8bAlsUiK9oUjvqBFW5w6Kq
 jL1AAJjKtVxawMoW5zHIjWF0JOjuMUz5lmYXfQmLcubc5/g5QrmAjbN8pjutmK9YixwoEd0hbF5
 HELGPSWEQEqGUAa0=
X-Received: by 2002:a5d:658a:: with SMTP id q10mr3081838wru.1.1595508616602;
 Thu, 23 Jul 2020 05:50:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyIq+pCs3p0ISKoS0Nud+rj+i+Pn7Dc/dwbEbEXCYHrREPfZHqZ1o94RAv1MxWmrSsa3zgAhQ==
X-Received: by 2002:a5d:658a:: with SMTP id q10mr3081829wru.1.1595508616305;
 Thu, 23 Jul 2020 05:50:16 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id b139sm3675091wmd.19.2020.07.23.05.50.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2020 05:50:15 -0700 (PDT)
Subject: Re: [PATCH for-5.1 1/2] Revert "tpm: Clean up error reporting in
 tpm_init_tpmdev()"
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200723115845.1865886-1-armbru@redhat.com>
 <20200723115845.1865886-2-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <9b3d805f-6cb2-35ff-4f5d-879d3bbc00ab@redhat.com>
Date: Thu, 23 Jul 2020 14:50:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200723115845.1865886-2-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:26:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: stefanb@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/23/20 1:58 PM, Markus Armbruster wrote:
> This reverts commit d10e05f15d5c3dd5e5cc59c5dfff460d89d48580.
> 
> We report some -tpmdev failures, but then continue as if all was fine.
> Reproducer:
> 
>     $ qemu-system-x86_64 -nodefaults -S -display none -monitor stdio -chardev null,id=tpm0 -tpmdev emulator,id=tpm0,chardev=chrtpm -device tpm-tis,tpmdev=tpm0
>     qemu-system-x86_64: -tpmdev emulator,id=tpm0,chardev=chrtpm: tpm-emulator: tpm chardev 'chrtpm' not found.
>     qemu-system-x86_64: -tpmdev emulator,id=tpm0,chardev=chrtpm: tpm-emulator: Could not cleanly shutdown the TPM: No such file or directory
>     QEMU 5.0.90 monitor - type 'help' for more information
>     (qemu) qemu-system-x86_64: -device tpm-tis,tpmdev=tpm0: Property 'tpm-tis.tpmdev' can't find value 'tpm0'
>     $ echo $?
>     1
> 
> This is a regression caused by commit d10e05f15d "tpm: Clean up error
> reporting in tpm_init_tpmdev()".  It's incomplete: be->create(opts)
> continues to use error_report(), and we don't set an error when it
> fails.
> 
> I figure converting the create() methods to Error would make some
> sense, but I'm not sure it's worth the effort right now.  Revert the
> broken commit instead, and add a comment to tpm_init_tpmdev().
> 
> Straightforward conflict in tpm.c resolved.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  include/sysemu/tpm.h |  2 +-
>  softmmu/vl.c         |  4 +++-
>  stubs/tpm.c          |  3 ++-
>  tpm.c                | 30 +++++++++++++++++++++---------
>  4 files changed, 27 insertions(+), 12 deletions(-)
> 
> diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
> index 03fb25941c..730c61ac97 100644
> --- a/include/sysemu/tpm.h
> +++ b/include/sysemu/tpm.h
> @@ -16,7 +16,7 @@
>  #include "qom/object.h"
>  
>  int tpm_config_parse(QemuOptsList *opts_list, const char *optarg);
> -void tpm_init(void);
> +int tpm_init(void);
>  void tpm_cleanup(void);
>  
>  typedef enum TPMVersion {
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index f476ef89ed..2c06cf0513 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -4262,7 +4262,9 @@ void qemu_init(int argc, char **argv, char **envp)
>                        user_creatable_add_opts_foreach,
>                        object_create_delayed, &error_fatal);
>  
> -    tpm_init();
> +    if (tpm_init() < 0) {
> +        exit(1);
> +    }
>  
>      blk_mig_init();
>      ram_mig_init();
> diff --git a/stubs/tpm.c b/stubs/tpm.c
> index 66c99d667d..9bded191d9 100644
> --- a/stubs/tpm.c
> +++ b/stubs/tpm.c
> @@ -10,8 +10,9 @@
>  #include "sysemu/tpm.h"
>  #include "hw/acpi/tpm.h"
>  
> -void tpm_init(void)
> +int tpm_init(void)
>  {
> +    return 0;
>  }
>  
>  void tpm_cleanup(void)
> diff --git a/tpm.c b/tpm.c
> index fe03b24858..f6045bb6da 100644
> --- a/tpm.c
> +++ b/tpm.c
> @@ -81,26 +81,33 @@ TPMBackend *qemu_find_tpm_be(const char *id)
>  
>  static int tpm_init_tpmdev(void *dummy, QemuOpts *opts, Error **errp)
>  {
> +    /*
> +     * Use of error_report() in a function with an Error ** parameter
> +     * is suspicious.  It is okay here.  The parameter only exists to
> +     * make the function usable with qemu_opts_foreach().  It is not
> +     * actually used.
> +     */
>      const char *value;
>      const char *id;
>      const TPMBackendClass *be;
>      TPMBackend *drv;
> +    Error *local_err = NULL;
>      int i;
>  
>      if (!QLIST_EMPTY(&tpm_backends)) {
> -        error_setg(errp, "Only one TPM is allowed.");
> +        error_report("Only one TPM is allowed.");
>          return 1;
>      }
>  
>      id = qemu_opts_id(opts);
>      if (id == NULL) {
> -        error_setg(errp, QERR_MISSING_PARAMETER, "id");
> +        error_report(QERR_MISSING_PARAMETER, "id");
>          return 1;
>      }
>  
>      value = qemu_opt_get(opts, "type");
>      if (!value) {
> -        error_setg(errp, QERR_MISSING_PARAMETER, "type");
> +        error_report(QERR_MISSING_PARAMETER, "type");
>          tpm_display_backend_drivers();
>          return 1;
>      }
> @@ -108,14 +115,15 @@ static int tpm_init_tpmdev(void *dummy, QemuOpts *opts, Error **errp)
>      i = qapi_enum_parse(&TpmType_lookup, value, -1, NULL);
>      be = i >= 0 ? tpm_be_find_by_type(i) : NULL;
>      if (be == NULL) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "type",
> -                   "a TPM backend type");
> +        error_report(QERR_INVALID_PARAMETER_VALUE,
> +                     "type", "a TPM backend type");
>          tpm_display_backend_drivers();
>          return 1;
>      }
>  
>      /* validate backend specific opts */
> -    if (!qemu_opts_validate(opts, be->opts, errp)) {
> +    if (!qemu_opts_validate(opts, be->opts, &local_err)) {
> +        error_report_err(local_err);
>          return 1;
>      }
>  
> @@ -148,10 +156,14 @@ void tpm_cleanup(void)
>   * Initialize the TPM. Process the tpmdev command line options describing the
>   * TPM backend.
>   */
> -void tpm_init(void)
> +int tpm_init(void)
>  {
> -    qemu_opts_foreach(qemu_find_opts("tpmdev"),
> -                      tpm_init_tpmdev, NULL, &error_fatal);
> +    if (qemu_opts_foreach(qemu_find_opts("tpmdev"),
> +                          tpm_init_tpmdev, NULL, NULL)) {
> +        return -1;
> +    }
> +
> +    return 0;
>  }
>  
>  /*
> 


