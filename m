Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86CEC606BF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 14:58:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A405421537
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 14:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eA+gpvjy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A405421537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkV6H-00011M-Ht
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 10:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49487)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent.desnogues@gmail.com>) id 1hkV4n-0000Yr-N4
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 10:57:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent.desnogues@gmail.com>) id 1hkV4l-0005ro-Ni
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 10:57:09 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:46296)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent.desnogues@gmail.com>)
 id 1hkV4c-0005Rg-5G
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 10:57:02 -0400
Received: by mail-io1-xd41.google.com with SMTP id i10so35828309iol.13
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2019 07:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/rRKzhyGWKOD7mZw2Ana2bXzl4VgoPxKy6pQ3ErWFuc=;
 b=eA+gpvjyWtTLBO9cC7mr1YQM5DXwuNnlOWNlT1dT8l8MksnJL925gb78+BNX3mccFf
 fAo1SP/0NWfkplm9R7GJNLjjF610eUoVrdX2a5q2+k4AZkWnncIqAUYU2Fcy3HWn2LC6
 cWYoqsFY2EV+RBB2Z3IBbEj1koobRWi+bDBYEZHmfmo75/44kTN5erKLcb0lIiD+Klqj
 HxZv4IAvD0GZFLjiBa8JDLErtZuq3hFVkl6k+F7ImblDFJ0tpd3D7bN1Wu52JrX/13Nr
 8Oi72N9dkThGvFsG3lH1mpjYZ13odvdOEDc4r3YVndpswwj3GwD8DNysnJIBpq8Cg9VE
 V6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/rRKzhyGWKOD7mZw2Ana2bXzl4VgoPxKy6pQ3ErWFuc=;
 b=RBYIz6YEucb3LHAgrCqKVsnLokHLlbBSmfCZu6Hhf2MOYNqV3BIqvsvf+1id8xKf0P
 nuB9fuKHoQlcRe7AF/mF5PAgukmqhCG15915+cwy4ZYm1GDg8iawUw+qoyEeNre1SY2p
 ks1RzfxaDjaMMdL1n6puNaaIwpu30lwVPEqrZfWH+YYH4L3cXNUmzgdEiqdDFq9ulEQ/
 xgjaROTrjJwX93F7XVALBMLnVXziwnMHER1u8afH2cmFUlkQBVn1Cx2wyOwNqQW+rw3v
 hHTxu++0YJmXYjJ4EtkfMt2ckv4vZBP4y85E3gHja9avOBPjINZjwrl1rbuejfD9m0o3
 ifAA==
X-Gm-Message-State: APjAAAWG/AfJQjYOB18TZixLfgIdj3VoAdViInhzPJVsOQXDk/ujNcrC
 kM/xaYjFwEX0RMT0ViW5PJVPsCUKkbjw9j+yPsI=
X-Google-Smtp-Source: APXvYqzPN+Nfq+BFwZSOcfqmKHE6Q9uDrR+7LnrNvKOKB67vcTFKzi0ow860Nmv5EtsXMq5ZTpbp8oY3O/rtL3dO0/k=
X-Received: by 2002:a5d:80cd:: with SMTP id h13mr20591074ior.259.1562597816143; 
 Mon, 08 Jul 2019 07:56:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190705221504.25166-1-ehabkost@redhat.com>
 <20190705221504.25166-11-ehabkost@redhat.com>
In-Reply-To: <20190705221504.25166-11-ehabkost@redhat.com>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Mon, 8 Jul 2019 16:56:56 +0200
Message-ID: <CABoDooPx3i4RhsXLJoca83ghN-ejhBbLGj3ZTJXvvdkZKCbbNg@mail.gmail.com>
To: Eduardo Habkost <ehabkost@redhat.com>, Like Xu <like.xu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d41
Subject: Re: [Qemu-devel] [PULL v6 10/42] vl.c: Replace smp global variables
 with smp machine properties
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <rth@twiddle.net>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On Sat, Jul 6, 2019 at 12:40 AM Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> From: Like Xu <like.xu@linux.intel.com>
>
> The global smp variables in vl.c are completely replaced with machine properties.
>
> Form this commit, the smp_cpus/smp_cores/smp_threads/max_cpus are deprecated
> and only machine properties within MachineState are fully applied and enabled.

Wouldn't it make sense to now remove the declarations in
include/sysemu/cpus.h and include/sysemu/sysemu.h?

Thanks,

Laurent

> Signed-off-by: Like Xu <like.xu@linux.intel.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Message-Id: <20190518205428.90532-11-like.xu@linux.intel.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  vl.c | 53 ++++++++++++++++++++++++++---------------------------
>  1 file changed, 26 insertions(+), 27 deletions(-)
>
> diff --git a/vl.c b/vl.c
> index d657faec03..56aa221385 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -163,10 +163,6 @@ static Chardev **serial_hds;
>  Chardev *parallel_hds[MAX_PARALLEL_PORTS];
>  int win2k_install_hack = 0;
>  int singlestep = 0;
> -int smp_cpus;
> -unsigned int max_cpus;
> -int smp_cores = 1;
> -int smp_threads = 1;
>  int acpi_enabled = 1;
>  int no_hpet = 0;
>  int fd_bootchk = 1;
> @@ -1265,8 +1261,9 @@ static void smp_parse(QemuOpts *opts)
>                  sockets = sockets > 0 ? sockets : 1;
>                  cpus = cores * threads * sockets;
>              } else {
> -                max_cpus = qemu_opt_get_number(opts, "maxcpus", cpus);
> -                sockets = max_cpus / (cores * threads);
> +                current_machine->smp.max_cpus =
> +                        qemu_opt_get_number(opts, "maxcpus", cpus);
> +                sockets = current_machine->smp.max_cpus / (cores * threads);
>              }
>          } else if (cores == 0) {
>              threads = threads > 0 ? threads : 1;
> @@ -1283,34 +1280,37 @@ static void smp_parse(QemuOpts *opts)
>              exit(1);
>          }
>
> -        max_cpus = qemu_opt_get_number(opts, "maxcpus", cpus);
> +        current_machine->smp.max_cpus =
> +                qemu_opt_get_number(opts, "maxcpus", cpus);
>
> -        if (max_cpus < cpus) {
> +        if (current_machine->smp.max_cpus < cpus) {
>              error_report("maxcpus must be equal to or greater than smp");
>              exit(1);
>          }
>
> -        if (sockets * cores * threads > max_cpus) {
> +        if (sockets * cores * threads > current_machine->smp.max_cpus) {
>              error_report("cpu topology: "
>                           "sockets (%u) * cores (%u) * threads (%u) > "
>                           "maxcpus (%u)",
> -                         sockets, cores, threads, max_cpus);
> +                         sockets, cores, threads,
> +                         current_machine->smp.max_cpus);
>              exit(1);
>          }
>
> -        if (sockets * cores * threads != max_cpus) {
> +        if (sockets * cores * threads != current_machine->smp.max_cpus) {
>              warn_report("Invalid CPU topology deprecated: "
>                          "sockets (%u) * cores (%u) * threads (%u) "
>                          "!= maxcpus (%u)",
> -                        sockets, cores, threads, max_cpus);
> +                        sockets, cores, threads,
> +                        current_machine->smp.max_cpus);
>          }
>
> -        smp_cpus = cpus;
> -        smp_cores = cores;
> -        smp_threads = threads;
> +        current_machine->smp.cpus = cpus;
> +        current_machine->smp.cores = cores;
> +        current_machine->smp.threads = threads;
>      }
>
> -    if (smp_cpus > 1) {
> +    if (current_machine->smp.cpus > 1) {
>          Error *blocker = NULL;
>          error_setg(&blocker, QERR_REPLAY_NOT_SUPPORTED, "smp");
>          replay_add_blocker(blocker);
> @@ -4009,26 +4009,25 @@ int main(int argc, char **argv, char **envp)
>      machine_class->default_cpus = machine_class->default_cpus ?: 1;
>
>      /* default to machine_class->default_cpus */
> -    smp_cpus = machine_class->default_cpus;
> -    max_cpus = machine_class->default_cpus;
> +    current_machine->smp.cpus = machine_class->default_cpus;
> +    current_machine->smp.max_cpus = machine_class->default_cpus;
> +    current_machine->smp.cores = 1;
> +    current_machine->smp.threads = 1;
>
>      smp_parse(qemu_opts_find(qemu_find_opts("smp-opts"), NULL));
>
> -    current_machine->smp.cpus = smp_cpus;
> -    current_machine->smp.max_cpus = max_cpus;
> -    current_machine->smp.cores = smp_cores;
> -    current_machine->smp.threads = smp_threads;
> -
>      /* sanity-check smp_cpus and max_cpus against machine_class */
> -    if (smp_cpus < machine_class->min_cpus) {
> +    if (current_machine->smp.cpus < machine_class->min_cpus) {
>          error_report("Invalid SMP CPUs %d. The min CPUs "
> -                     "supported by machine '%s' is %d", smp_cpus,
> +                     "supported by machine '%s' is %d",
> +                     current_machine->smp.cpus,
>                       machine_class->name, machine_class->min_cpus);
>          exit(1);
>      }
> -    if (max_cpus > machine_class->max_cpus) {
> +    if (current_machine->smp.max_cpus > machine_class->max_cpus) {
>          error_report("Invalid SMP CPUs %d. The max CPUs "
> -                     "supported by machine '%s' is %d", max_cpus,
> +                     "supported by machine '%s' is %d",
> +                     current_machine->smp.max_cpus,
>                       machine_class->name, machine_class->max_cpus);
>          exit(1);
>      }
> --
> 2.18.0.rc1.1.g3f1ff2140
>
>

