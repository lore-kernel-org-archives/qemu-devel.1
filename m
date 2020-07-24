Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDE6C433EB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 14:02:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE1162065C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 14:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IahKhlEV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE1162065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyyH2-0006OE-0c
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 10:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jyyFx-0005A2-Hc
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 10:01:01 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25267
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jyyFv-0007io-4x
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 10:01:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595599257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ryg0DZxXFokpZBcEo6g7c2rib3ZXyT+n+eULTXnW5KA=;
 b=IahKhlEVrGouNZvpGzOILg+R7niajd4f6uW9E59jI13n+OcUXksWLWHxJSrnKQ5VJn9B4Q
 JxL1fi7JX15XQi9fDNgwRl/I0MlI+sc2TRXU97hCCzktyh+Bmo/Vve3ob3hbCytKxAZcUY
 OnmQp13XXRSkDRPplrJXtvmBYr9B8F8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-HptjuMXXNSi9qVar7UUw1Q-1; Fri, 24 Jul 2020 10:00:55 -0400
X-MC-Unique: HptjuMXXNSi9qVar7UUw1Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1ACB80BCAC;
 Fri, 24 Jul 2020 14:00:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8BF19710AC;
 Fri, 24 Jul 2020 14:00:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F0CD41138648; Fri, 24 Jul 2020 16:00:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: Re: [PATCH] tpm_emulator: Report an error if chardev is missing
References: <20200724133011.2488055-1-stefanb@linux.vnet.ibm.com>
Date: Fri, 24 Jul 2020 16:00:49 +0200
In-Reply-To: <20200724133011.2488055-1-stefanb@linux.vnet.ibm.com> (Stefan
 Berger's message of "Fri, 24 Jul 2020 09:30:11 -0400")
Message-ID: <874kpx9fn2.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 06:44:00
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
Cc: marcandre.lureau@redhat.com, philmd@redhat.com, qemu-devel@nongnu.org,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Stefan Berger <stefanb@linux.vnet.ibm.com> writes:

> This patch fixes the odd error reporting when trying to send a file
> descriptor to the TPM emulator if one has not passed a valid chardev.
>
> $ x86_64-softmmu/qemu-system-x86_64 -tpmdev emulator,id=tpm0
> qemu-system-x86_64: -tpmdev emulator,id=tpm0: tpm-emulator: Failed to send CMD_SET_DATAFD: Success
> qemu-system-x86_64: -tpmdev emulator,id=tpm0: tpm-emulator: Could not cleanly shutdown the TPM: Success
>
> This is the new error report:
>
> $ x86_64-softmmu/qemu-system-x86_64 -tpmdev emulator,id=tpm0
> qemu-system-x86_64: -tpmdev emulator,id=tpm0: tpm-emulator: missing chardev
                                                ~~~~~~~~~~~~~~

The "tpm-emulator: " part looks superfluous.

Hmm, many error messages in this file have it.  Feel free to keep it
now for consistency, and clean it up later.

We usually report missing option parameters like "parameter 'chardev' is
missing".  Please consider sticking to that.

>
> This change does not hide the display of supported TPM types if a non-existent type is passed:
>
> $ x86_64-softmmu/qemu-system-x86_64 -tpmdev nonexistent,id=tpm0
> qemu-system-x86_64: -tpmdev nonexistent,id=tpm0: Parameter 'type' expects a TPM backend type
> Supported TPM types (choose only one):
>  passthrough   Passthrough TPM backend driver
>     emulator   TPM emulator backend driver
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  backends/tpm/tpm_emulator.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
> index 9605339f93..55cbc9c60e 100644
> --- a/backends/tpm/tpm_emulator.c
> +++ b/backends/tpm/tpm_emulator.c
> @@ -568,6 +568,9 @@ static int tpm_emulator_handle_device_opts(TPMEmulator *tpm_emu, QemuOpts *opts)
>          }
>  
>          tpm_emu->options->chardev = g_strdup(value);
> +    } else {
> +        error_report("tpm-emulator: missing chardev");
> +        goto err;
>      }
>  
>      if (tpm_emulator_prepare_data_fd(tpm_emu) < 0) {

This is minimally invasive.

I'd prefer

       Error *err = NULL;
       const char *value;
       Chardev *dev;

       value = qemu_opt_get(opts, "chardev");
       if (!value) {
           error_report("tpm-emulator: missing chardev");
           goto err;
       }

       dev = qemu_chr_find(value);
       if (!dev) {
           error_report("tpm-emulator: tpm chardev '%s' not found.", value);
           goto err;
       }

Your choice.

> @@ -925,6 +928,11 @@ static void tpm_emulator_shutdown(TPMEmulator *tpm_emu)
>  {
>      ptm_res res;
>  
> +    if (!tpm_emu->options->chardev) {
> +        /* was never properly initialized */
> +        return;
> +    }
> +

Is this still reachable?  If yes, how?

If not, drop the hunk and have my
Reviewed-by: Markus Armbruster <armbru@redhat.com>

>      if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SHUTDOWN, &res, 0, sizeof(res)) < 0) {
>          error_report("tpm-emulator: Could not cleanly shutdown the TPM: %s",
>                       strerror(errno));


