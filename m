Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E79C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:19:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C52C020684
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HykKMDOc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C52C020684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKqck-0003rk-Tw
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 18:18:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKpl5-000652-QP
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 17:23:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56148)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKpl3-0007GV-QI
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 17:23:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600809808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sE5yVc/6dVjkT+RhyvXoRRYr/aG9Vr28Pb6GoJx1yJg=;
 b=HykKMDOcUc0Wj/FPaHCvfbmMdj2/cfcQlG7/j5nnnp44G8K/bVfm5b4At5w/9maiELbFti
 RnHTazRheyHzC92FMZkgBVwTE1AbBDGHKYmxsh3SLI9lf6sH9jNUuzfShR00OvE/rt+aVx
 E8mNohXY7WwflYlciT0Gf71VfzccCn8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-X9KncfemNGCwxXyslZ23wQ-1; Tue, 22 Sep 2020 17:23:25 -0400
X-MC-Unique: X9KncfemNGCwxXyslZ23wQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8F991005E5E;
 Tue, 22 Sep 2020 21:23:23 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6BD2A55767;
 Tue, 22 Sep 2020 21:23:23 +0000 (UTC)
Date: Tue, 22 Sep 2020 17:23:22 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 03/38] qapi: move generator entrypoint into module
Message-ID: <20200922212322.GD2044576@habkost.net>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-4-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922210101.4081073-4-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 22, 2020 at 05:00:26PM -0400, John Snow wrote:
> As part of delinting and adding type hints to the QAPI generator, it's
> helpful for the entrypoint to be part of the package, only leaving a
> very tiny entrypoint shim outside of the module.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi-gen.py  | 90 +++----------------------------------------
>  scripts/qapi/main.py | 91 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 97 insertions(+), 84 deletions(-)
>  create mode 100644 scripts/qapi/main.py
>
[...]
> diff --git a/scripts/qapi/main.py b/scripts/qapi/main.py
> new file mode 100644
> index 0000000000..18c246bbb4
> --- /dev/null
> +++ b/scripts/qapi/main.py
> @@ -0,0 +1,91 @@
> +# This work is licensed under the terms of the GNU GPL, version 2 or later.
> +# See the COPYING file in the top-level directory.
> +
> +"""
> +QAPI Generator
> +
> +This is the main entry point for generating C code from the QAPI schema.
> +"""
> +
> +import argparse
> +import re
> +import sys
> +
> +from qapi.commands import gen_commands
> +from qapi.doc import gen_doc
> +from qapi.error import QAPIError
> +from qapi.events import gen_events
> +from qapi.introspect import gen_introspect
> +from qapi.schema import QAPISchema
> +from qapi.types import gen_types
> +from qapi.visit import gen_visit

Do you plan to change this to use relative imports eventually?

In either case:

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo


