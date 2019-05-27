Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA720C04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 16:37:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A711C20859
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 16:37:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A711C20859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48255 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVIco-00043P-SA
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 12:37:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hVIc1-0003lm-3K
	for qemu-devel@nongnu.org; Mon, 27 May 2019 12:36:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hVIc0-0005W4-40
	for qemu-devel@nongnu.org; Mon, 27 May 2019 12:36:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hVIbz-0005UU-RZ
	for qemu-devel@nongnu.org; Mon, 27 May 2019 12:36:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8E7FE300413C
	for <qemu-devel@nongnu.org>; Mon, 27 May 2019 16:36:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-250.ams2.redhat.com
	[10.36.117.250])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4585C608A4;
	Mon, 27 May 2019 16:36:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id B34501138648; Mon, 27 May 2019 18:36:25 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
References: <1558079119-320634-1-git-send-email-imammedo@redhat.com>
	<1558079119-320634-2-git-send-email-imammedo@redhat.com>
Date: Mon, 27 May 2019 18:36:25 +0200
In-Reply-To: <1558079119-320634-2-git-send-email-imammedo@redhat.com> (Igor
	Mammedov's message of "Fri, 17 May 2019 09:45:14 +0200")
Message-ID: <87imtvj1me.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Mon, 27 May 2019 16:36:31 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 1/6] pc: fix possible NULL pointer
 dereference in pc_machine_get_device_memory_region_size()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: libvir-list@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
	qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Igor Mammedov <imammedo@redhat.com> writes:

> QEMU will crash when device-memory-region-size property is read if ms->device_memory
> wasn't initialized yet (ex: property being inspected during preconfig time).

Reproduced:

    $ qemu-system-x86_64 -nodefaults -S -display none -preconfig -qmp stdio
    {"QMP": {"version": {"qemu": {"micro": 50, "minor": 0, "major": 4}, "package": "v4.0.0-828-ga7b21f6762"}, "capabilities": ["oob"]}}
    {"execute": "qmp_capabilities"}
    {"return": {}}
    {"execute": "qom-get", "arguments": {"path": "/machine", "property": "device-memory-region-size"}}
    Segmentation fault (core dumped)

First time I started looking at this series, I went "I'll need a
reproducer to fully understand what's up, and I don't feel like finding
one now; next series, please".  Second time, I had to spend a few
minutes on the reproducer.  Wasn't hard, since you provided a clue.
Still: make review easy, include a reproducer whenever you can.

> Instead of crashing return 0 if ms->device_memory hasn't been initialized.
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/i386/pc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index d98b737..de91e90 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -2461,7 +2461,11 @@ pc_machine_get_device_memory_region_size(Object *obj, Visitor *v,
>                                           Error **errp)
>  {
>      MachineState *ms = MACHINE(obj);
> -    int64_t value = memory_region_size(&ms->device_memory->mr);
> +    int64_t value = 0;
> +
> +    if (ms->device_memory) {
> +        memory_region_size(&ms->device_memory->mr);
> +    }
>  
>      visit_type_int(v, name, &value, errp);
>  }

This makes qom-get return 0 for the size of memory that doesn't exist,
yet.

A possible alternative would be setting an error.

Opinions?

