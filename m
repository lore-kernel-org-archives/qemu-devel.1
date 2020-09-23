Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19621C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 16:47:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8964720936
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 16:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gslxBaJu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8964720936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL7uy-00051t-OG
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 12:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kL7t9-00043A-EI
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 12:45:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33474)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kL7t7-0004ON-H7
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 12:45:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600879500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wc6SuxQt6xddj1O7Zvt4atLv/11XMD1yPuRgdDUg71Q=;
 b=gslxBaJurwUQsNJu5JEbbAMuUBP8lNeKTgip/BUELAjKW/sMaE1x5yrl7I0AW/owlZGEGb
 vUvV2Ut9cmo7nqAj3/ZFoj4Q6nkKFQHV37phx5Ud2hfZpO7Kg8NWKKYYiCvP3iiezcu0A+
 bD3kr997rLjp7cVG3/48K+BlUWm8Scw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-BA-XynrSOP6H-YmZw9DWfw-1; Wed, 23 Sep 2020 12:44:56 -0400
X-MC-Unique: BA-XynrSOP6H-YmZw9DWfw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A7B61017DC7;
 Wed, 23 Sep 2020 16:44:55 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-112-233.ams2.redhat.com
 [10.36.112.233])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E57155C1DC;
 Wed, 23 Sep 2020 16:44:50 +0000 (UTC)
Subject: Re: [PATCH v6 00/11] x86: fix cpu hotplug with secure boot
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200923094650.1301166-1-imammedo@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <f416b0ff-f5d9-b303-e561-755819866dda@redhat.com>
Date: Wed, 23 Sep 2020 18:44:50 +0200
MIME-Version: 1.0
In-Reply-To: <20200923094650.1301166-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: ankur.a.arora@oracle.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/23/20 11:46, Igor Mammedov wrote:
> v6:
>   - [9/10] Add comment explaining why while_ctx2 restarts from the last processed CPU.
>   - rebase on top of current master, due to non trivial conflict
>     caused by microvm series, which moved/renamed pc_cpu_pre_plug()

So, I went back to my local branch where I had applied your v5, *plus*
the comment fixup ("[PATCH v5 9/10] fixup! x68: acpi: trigger SMI before
sending hotplug Notify event to OSPM") on top. I rebased that branch to
its *same* base commit, only squashing the comment fixup into patch#9.

Then I applied your v6 series on top of current master, using a
different (new) local branch.

Then I ran git-range-diff on these two local branches.

In patches 6, 7, 8, and 9, you've picked up my feedback tags from the v5
review session; that's good, there was nothing else to do.

There is a trivial difference in patch 2 -- trivial to review, that is;
I'm not saying that it's so trivial that git-rebase should have coped
with it automatically on your end. Here's the git-range-diff output:

>  2:  e606a75432a8 !  2:  94702d2e3125 x86: cpuhp: prevent guest crash on CPU hotplug when broadcast SMI is in use
>     @@ -12,7 +12,7 @@
>          Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>          Reviewed-by: Laszlo Ersek <lersek@redhat.com>
>          Tested-by: Laszlo Ersek <lersek@redhat.com>
>     -    Message-Id: <20200907112348.530921-3-imammedo@redhat.com>
>     +    Message-Id: <20200923094650.1301166-3-imammedo@redhat.com>
>
>      diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
>      --- a/hw/acpi/ich9.c
>     @@ -40,17 +40,17 @@
>
>       void ich9_pm_device_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
>
>     -diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>     ---- a/hw/i386/pc.c
>     -+++ b/hw/i386/pc.c
>     +diff --git a/hw/i386/x86.c b/hw/i386/x86.c
>     +--- a/hw/i386/x86.c
>     ++++ b/hw/i386/x86.c
>      @@
>               return;
>           }
>
>     -+    if (pcms->acpi_dev) {
>     ++    if (x86ms->acpi_dev) {
>      +        Error *local_err = NULL;
>      +
>     -+        hotplug_handler_pre_plug(HOTPLUG_HANDLER(pcms->acpi_dev), dev,
>     ++        hotplug_handler_pre_plug(HOTPLUG_HANDLER(x86ms->acpi_dev), dev,
>      +                                 &local_err);
>      +        if (local_err) {
>      +            error_propagate(errp, local_err);

Meaning that, in v6, you had to refer to "x86ms", rather than to "pcms",
and that the code had to be introduced in a different file / function.

The need for that originates from 0cca1a918b85 ("x86: move cpu hotplug
from pc to x86", 2020-09-17).

It looks innocent enough, but I should still retest patch#2. I'll report
back under that patch in this series.

Thanks
Laszlo


