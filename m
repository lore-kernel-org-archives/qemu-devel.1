Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7060C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 16:32:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18CEA20720
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 16:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WHX8OXKl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18CEA20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUY5F-0006kT-RD
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 12:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wrampazz@redhat.com>)
 id 1kUY3O-0005ut-Mr
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 12:30:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33226)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wrampazz@redhat.com>)
 id 1kUY3L-0005Mb-DZ
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 12:30:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603125029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/+FqXz4nFmZv9FUmVBzkVYH9lx3xLzyMxMJx2ReA7DM=;
 b=WHX8OXKlvaxTPrUUan9sFRCLi9AxbDJtZ/MJYVXbxGWa3epc4/ganroZ18w5KOe5WI9Mdl
 OKrx+XuAv7S+WO+4ubObPAeLtyCDKKr6M0AwMSn4pSAhLXNGcNiTYynuZuqB4KrACZ6gbD
 eYfNliNHS7TYrAtBZaTgIv7myuAsoJ8=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-yMUojgUtNlShY6_alKkfRQ-1; Mon, 19 Oct 2020 12:30:27 -0400
X-MC-Unique: yMUojgUtNlShY6_alKkfRQ-1
Received: by mail-ua1-f69.google.com with SMTP id 107so34086uak.12
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 09:30:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/+FqXz4nFmZv9FUmVBzkVYH9lx3xLzyMxMJx2ReA7DM=;
 b=mfdOAFon1/3ECWaiFQ+IrHbxIVyDSrQZ8fRgo7z4g4QTgHi2qGsOjFabiWy/+lRDmW
 CT+V9TKFlzPjkyA8xMhvOG5dmSYyvaM7DCtFuKGgouXCKvpocyKuNlPDpLLHokXPwlIs
 kXlLD/eG4fOIhki1pTQXOt/mn2cKU+tkt/x4fnmBDpDcPC6djIYdSWcoSp6JhC7LiWow
 5gfPxNvXjpHppGCVzZMM6F0mTN40Ju0vlgfg3VmL8GqbNpV0MsAl5/u1nqYQEGJU6yVn
 F0rZHLcFHLZIU/GSxc9G9aZFZLkxZuKQNpGdctYcOfnkSDXdBDv/6yMtVm43Czr1LDRe
 p3HQ==
X-Gm-Message-State: AOAM531sNryMnC9LvtdDedReDNaNxPNwAepCA+LPNqN39U0YT0HTOlAc
 Lvr15wcJDjl0Lgshvpdg6Mop1w4FGa9Dgh7czH1WFKrhiTAHSSa3SG8R+GGHGA0wvPkICVE/OTy
 IPA8FCEfk+u1A/ycKh0CiYNXxXDX7olU=
X-Received: by 2002:ab0:4906:: with SMTP id z6mr206477uac.133.1603125026925;
 Mon, 19 Oct 2020 09:30:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzW4dKBZYIdLGKo6yXysgSUcy9nxURlFlk7OT44fwdWY8DZhPoOatsYu8QXBfqCWqtzxyJFQpghTYsNlt0NE5w=
X-Received: by 2002:ab0:4906:: with SMTP id z6mr206458uac.133.1603125026706;
 Mon, 19 Oct 2020 09:30:26 -0700 (PDT)
MIME-Version: 1.0
References: <20201012033507.906096-1-crosa@redhat.com>
 <20201012033507.906096-2-crosa@redhat.com>
In-Reply-To: <20201012033507.906096-2-crosa@redhat.com>
From: Willian Rampazzo <wrampazz@redhat.com>
Date: Mon, 19 Oct 2020 13:30:15 -0300
Message-ID: <CAKJDGDZZLK6Sp0HtHA7roGuWMJYmcd6ytjf_rdn5N=oSuE9LEg@mail.gmail.com>
Subject: Re: [PATCH 1/1] hw/i386: prevent crash when an invalid number of dies
 is given
To: Cleber Rosa <crosa@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=wrampazz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=wrampazz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 01:44:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 12, 2020 at 12:35 AM Cleber Rosa <crosa@redhat.com> wrote:
>
> When parsing the topology, the right default value of 1 is given to
> dies, but if an invalid number such as 0 is given, QEMU will crash
> with a floating point exception.
>
> The alternative approach is to silently set dies to a valid value,
> as it's done with cores and threads.
>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  hw/i386/pc.c                          |  5 +++++
>  tests/acceptance/cpu_topology_dies.py | 31 +++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+)
>  create mode 100644 tests/acceptance/cpu_topology_dies.py
>
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index e87be5d29a..209e44663d 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -713,6 +713,11 @@ void pc_smp_parse(MachineState *ms, QemuOpts *opts)
>          unsigned cores   = qemu_opt_get_number(opts, "cores", 0);
>          unsigned threads = qemu_opt_get_number(opts, "threads", 0);
>
> +        if (dies <= 0) {
> +            error_report("Invalid CPU topology: dies must be 1 or greater");
> +            exit(1);
> +        }
> +
>          /* compute missing values, prefer sockets over cores over threads */
>          if (cpus == 0 || sockets == 0) {
>              cores = cores > 0 ? cores : 1;
> diff --git a/tests/acceptance/cpu_topology_dies.py b/tests/acceptance/cpu_topology_dies.py
> new file mode 100644
> index 0000000000..d73b7b30a2
> --- /dev/null
> +++ b/tests/acceptance/cpu_topology_dies.py
> @@ -0,0 +1,31 @@
> +# Check for crash when using invalid dies value for -smp
> +#
> +# Copyright (c) 2020 Red Hat, Inc.
> +#
> +# Author:
> +#  Cleber Rosa <crosa@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +from avocado_qemu import Test
> +
> +class CPUTolopogyDies(Test):
> +    """
> +    :avocado: tags=arch:x86_64
> +    :avocado: tags=machine:pc
> +    """
> +    def test_invalid(self):
> +        self.vm.add_args('-S', '-display', 'none', '-smp', '1,dies=0')
> +        self.vm.set_qmp_monitor(enabled=False)
> +        self.vm.launch()
> +        self.vm.wait()
> +        self.assertEquals(self.vm.exitcode(), 1, "QEMU exit code should be 1")
> +        self.assertRegex(self.vm.get_log(),
> +                         r'Invalid CPU topology: dies must be 1 or greater')
> +
> +    def test_valid(self):
> +        self.vm.add_args('-S', '-display', 'none', '-smp', '1,dies=1')
> +        self.vm.launch()
> +        self.vm.command('quit')
> +        self.vm.wait()
> +        self.assertEquals(self.vm.exitcode(), 0, "QEMU exit code should be 0")
> --
> 2.25.4
>

Reviewed-by: Willian Rampazzo <willianr@redhat.com>


