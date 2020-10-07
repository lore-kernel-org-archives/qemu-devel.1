Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29333C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 09:26:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9273D2080A
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 09:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dg/uWpbW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9273D2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ5iF-0007r4-Fg
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 05:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQ5hJ-0006xX-GJ
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 05:25:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33658)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQ5hH-0007fT-Ja
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 05:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602062718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KqcWTlNtLQQGCPrOMvFxh+Bg9REuhPBTph1QQGHcQZc=;
 b=dg/uWpbWQbaOzeZ7Ew7wuoJ+M/zWYz3zt97JmWokFF5a+FDSoaCDl6ZFDXN/bXe7J+F5NB
 lcmAFrs3VR3ILK/O5y/UcFuRHSTmKjrzA+BlPHHSkRbNTfOYqTA9XUt/JOvdiAmkvowKAo
 FOs4Xc/VMt/grk/QVURMpI4sTCuzN98=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-nFHHoxRmPdiPoxAVe0DN2g-1; Wed, 07 Oct 2020 05:25:16 -0400
X-MC-Unique: nFHHoxRmPdiPoxAVe0DN2g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2890802B46
 for <qemu-devel@nongnu.org>; Wed,  7 Oct 2020 09:25:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A8CA255783;
 Wed,  7 Oct 2020 09:25:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 230FA11329C1; Wed,  7 Oct 2020 11:25:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v5 18/36] qapi: establish mypy type-checking baseline
References: <20201005195158.2348217-1-jsnow@redhat.com>
 <20201005195158.2348217-19-jsnow@redhat.com>
Date: Wed, 07 Oct 2020 11:25:12 +0200
In-Reply-To: <20201005195158.2348217-19-jsnow@redhat.com> (John Snow's message
 of "Mon, 5 Oct 2020 15:51:40 -0400")
Message-ID: <87pn5ugzgn.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:44:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
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
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> Fix two very minor issues,

What are the two issues?  I'm asking because I can see only one.

>                            and then establish a mypy type-checking
> baseline.

Any particular reason this can't go before PATCH 15 "qapi/common.py: add
type hint annotations".

> Like pylint, this should be run from the folder above:
>
>  > mypy --config-file=qapi/mypy.ini qapi/
>
> This is designed and tested for mypy 0.770 or greater.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> Tested-by: Eduardo Habkost <ehabkost@redhat.com>
> Reviewed-by: Cleber Rosa <crosa@redhat.com>
> Tested-by: Cleber Rosa <crosa@redhat.com>
> ---
>  scripts/qapi/mypy.ini  | 60 ++++++++++++++++++++++++++++++++++++++++++
>  scripts/qapi/schema.py |  3 ++-
>  2 files changed, 62 insertions(+), 1 deletion(-)
>  create mode 100644 scripts/qapi/mypy.ini
>
> diff --git a/scripts/qapi/mypy.ini b/scripts/qapi/mypy.ini
> new file mode 100644
> index 00000000000..00fac15dc6e
> --- /dev/null
> +++ b/scripts/qapi/mypy.ini
> @@ -0,0 +1,60 @@
> +[mypy]
> +strict = True
> +strict_optional = False
> +disallow_untyped_calls = False
> +python_version = 3.6
> +
> +[mypy-qapi.commands]
> +disallow_untyped_defs = False
> +disallow_incomplete_defs = False
> +check_untyped_defs = False
> +
> +[mypy-qapi.error]
> +disallow_untyped_defs = False
> +disallow_incomplete_defs = False
> +check_untyped_defs = False
> +
> +[mypy-qapi.events]
> +disallow_untyped_defs = False
> +disallow_incomplete_defs = False
> +check_untyped_defs = False
> +
> +[mypy-qapi.expr]
> +disallow_untyped_defs = False
> +disallow_incomplete_defs = False
> +check_untyped_defs = False
> +
> +[mypy-qapi.gen]
> +disallow_untyped_defs = False
> +disallow_incomplete_defs = False
> +check_untyped_defs = False
> +
> +[mypy-qapi.introspect]
> +disallow_untyped_defs = False
> +disallow_incomplete_defs = False
> +check_untyped_defs = False
> +
> +[mypy-qapi.parser]
> +disallow_untyped_defs = False
> +disallow_incomplete_defs = False
> +check_untyped_defs = False
> +
> +[mypy-qapi.schema]
> +disallow_untyped_defs = False
> +disallow_incomplete_defs = False
> +check_untyped_defs = False
> +
> +[mypy-qapi.source]
> +disallow_untyped_defs = False
> +disallow_incomplete_defs = False
> +check_untyped_defs = False
> +
> +[mypy-qapi.types]
> +disallow_untyped_defs = False
> +disallow_incomplete_defs = False
> +check_untyped_defs = False
> +
> +[mypy-qapi.visit]
> +disallow_untyped_defs = False
> +disallow_incomplete_defs = False
> +check_untyped_defs = False
> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> index 74c6b96d391..483b4b68dff 100644
> --- a/scripts/qapi/schema.py
> +++ b/scripts/qapi/schema.py
> @@ -17,6 +17,7 @@
>  from collections import OrderedDict
>  import os
>  import re
> +from typing import Optional
>  
>  from .common import POINTER_SUFFIX, c_name
>  from .error import QAPIError, QAPISemError
> @@ -25,7 +26,7 @@
>  
>  
>  class QAPISchemaEntity:
> -    meta = None
> +    meta: Optional[str] = None
>  
>      def __init__(self, name, info, doc, ifcond=None, features=None):
>          assert name is None or isinstance(name, str)


