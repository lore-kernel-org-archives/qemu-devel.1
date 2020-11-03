Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0106FC388F7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 10:41:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5444F20756
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 10:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CbaOm9kc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5444F20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZtl8-0004Gi-7k
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 05:41:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52136)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZtk9-0003jV-2a
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 05:40:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57788)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZtk6-0006bU-M5
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 05:40:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604400044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vw3YUeVMtzf1SkaVFrgAGdqlDUkIwUKADGwfmbkro0s=;
 b=CbaOm9kcIrZEjZTxq1zvTdREe8f3Zyf92lQ/qbiHH9GpnEqEySBGaN8t//7Q8L5Za1J1+r
 2ukZ2BCzZu7XBhKioJy2mMddAwJucgnEtdBqghCmm2o7Vv2heiGs++auNJZJBnQZwEhQ8V
 Q/u6MmBZrKfiMGL+mDbjRKWF45aWDx0=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-UY8RX5ugPJ6sySSDHF3m8w-1; Tue, 03 Nov 2020 05:40:43 -0500
X-MC-Unique: UY8RX5ugPJ6sySSDHF3m8w-1
Received: by mail-ot1-f71.google.com with SMTP id q8so7668532otk.6
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 02:40:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Vw3YUeVMtzf1SkaVFrgAGdqlDUkIwUKADGwfmbkro0s=;
 b=LAciKlPyHxOERVhr5lGcDAXfF/N3cQDyGBRhlm6C49cyVsuK9pzUZlzfN9hMD0tkiJ
 KlDfcB5qRIy9bZ51i3UtXvZ/cf8jPAfY0MzjXoA02AJoXwa3zXINsHZnVafdnEPJHjBW
 7mTUpbDGrX7s30NaGcXagmp+9NVLmAIDPJFVWt4eYdCKal6kwGGk/LV2D3pFGJ5g5jaR
 aEkeCkur7ifSYvfWLJmknyy68VTSmzMdcpy5EjBNECOs3xMt2+XGNRz9Bj+pNbrsJ6rg
 E/BXS00Rb31ZRVrE6BM+iV5q7F7YgSqUP7UidUrtZvGpSyAtqAQfCVmZWwa1puWsg2q8
 1hpQ==
X-Gm-Message-State: AOAM531BPVW/UgRUNvWrBc1vWkVuvLpJQ/MUvElxihNT/+LrWKv+51Xf
 bakvJnacVw/3IlDfP72Gf3R0rX/83Ptq8IA0h8Dw40uix952aZKtVJa0ENk4RBN4S7FMc7QJq8B
 F73lAw2PWtaBCb7mZoOKAZV21QURa+Pw=
X-Received: by 2002:a9d:2206:: with SMTP id o6mr13609034ota.244.1604400042262; 
 Tue, 03 Nov 2020 02:40:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJycR0h8nIB7WlyzUGuTPhL9xe9kFnyoB4dAwcRFbNbUyRB3Em20r3Rg+XiH8Dcxnt26/VNShe8suWSDqP/sby0=
X-Received: by 2002:a9d:2206:: with SMTP id o6mr13609022ota.244.1604400042052; 
 Tue, 03 Nov 2020 02:40:42 -0800 (PST)
MIME-Version: 1.0
References: <20190222194146.13102-1-crosa@redhat.com>
 <20190222194146.13102-6-crosa@redhat.com>
In-Reply-To: <20190222194146.13102-6-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Tue, 3 Nov 2020 11:40:30 +0100
Message-ID: <CAP+75-UtiMFdp=ReaH0Vn7OD60hS+ZNsSvJyvVp1948Syn=ZGQ@mail.gmail.com>
Subject: Re: [PULL 5/7] tests.acceptance: adds simple migration test
To: Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, 
 Wainer Moschetta <wainersm@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Qemu-block <qemu-block@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Caio Carrara <ccarrara@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On Fri, Feb 22, 2019 at 8:42 PM Cleber Rosa <crosa@redhat.com> wrote:
>
> From: Caio Carrara <ccarrara@redhat.com>
>
> This change adds the simplest possible migration test. Beyond the test
> purpose itself it's also useful to exercise the multi virtual machines
> capabilities from base avocado qemu test class.
>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> Signed-off-by: Caio Carrara <ccarrara@redhat.com>
> Reviewed-by: Cleber Rosa <crosa@redhat.com>
> Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> Message-Id: <20190212193855.13223-3-ccarrara@redhat.com>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  tests/acceptance/migration.py | 53 +++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 tests/acceptance/migration.py
>
> diff --git a/tests/acceptance/migration.py b/tests/acceptance/migration.py
> new file mode 100644
> index 0000000000..6115cf6c24
> --- /dev/null
> +++ b/tests/acceptance/migration.py
> @@ -0,0 +1,53 @@
> +# Migration test
> +#
> +# Copyright (c) 2019 Red Hat, Inc.
> +#
> +# Authors:
> +#  Cleber Rosa <crosa@redhat.com>
> +#  Caio Carrara <ccarrara@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +
> +from avocado_qemu import Test
> +
> +from avocado.utils import network
> +from avocado.utils import wait
> +
> +
> +class Migration(Test):
> +    """
> +    :avocado: enable
> +    """
> +
> +    timeout = 10
> +
> +    @staticmethod
> +    def migration_finished(vm):
> +        return vm.command('query-migrate')['status'] in ('completed', 'failed')
> +
> +    def _get_free_port(self):
> +        port = network.find_free_port()
> +        if port is None:
> +            self.cancel('Failed to find a free port')
> +        return port

This method doesn't seem to work when running with -j2: 2 tests started
with different arch configurations get the same port... Is this a known issue?

> +
> +
> +    def test_migration_with_tcp_localhost(self):
> +        source_vm = self.get_vm()
> +        dest_uri = 'tcp:localhost:%u' % self._get_free_port()
> +        dest_vm = self.get_vm('-incoming', dest_uri)
> +        dest_vm.launch()
> +        source_vm.launch()
> +        source_vm.qmp('migrate', uri=dest_uri)
> +        wait.wait_for(
> +            self.migration_finished,
> +            timeout=self.timeout,
> +            step=0.1,
> +            args=(source_vm,)
> +        )
> +        self.assertEqual(dest_vm.command('query-migrate')['status'], 'completed')
> +        self.assertEqual(source_vm.command('query-migrate')['status'], 'completed')
> +        self.assertEqual(dest_vm.command('query-status')['status'], 'running')
> +        self.assertEqual(source_vm.command('query-status')['status'], 'postmigrate')
> --
> 2.20.1
>


