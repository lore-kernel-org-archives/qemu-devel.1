Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877F0C1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 21:18:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 500D220738
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 21:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N3PQ2wkV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 500D220738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEJbA-0000K5-D7
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 17:18:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56361)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jEJPN-0008N5-7Y
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 17:05:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jEJPL-00072J-Oq
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 17:05:53 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:39382)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jEJPL-0006xA-IA
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 17:05:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584479151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LCyQlP5WQig87n4l4RlZlHJCGddOMZXdG/uFkKJzNAI=;
 b=N3PQ2wkVZm/uwHvitYd1JeVdpJxJH+jgopLoZolFCOSdjn1zf0qYB1ax53+flpv4rbvnv7
 +8sqNVnJYyvC1FsaIuZRS4IEJbhCh+rk1H12gFZXd04JHvZPpj3aCh5oowvNJhZUPXOBYw
 ZReoGPzzjztNG9v5n66hCoax+92goBI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-bwlbzSrdODiGVNwN3ojaqQ-1; Tue, 17 Mar 2020 17:05:49 -0400
X-MC-Unique: bwlbzSrdODiGVNwN3ojaqQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84570800EB6;
 Tue, 17 Mar 2020 21:05:48 +0000 (UTC)
Received: from [10.3.112.193] (ovpn-112-193.phx2.redhat.com [10.3.112.193])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F90092D0E;
 Tue, 17 Mar 2020 21:05:48 +0000 (UTC)
Subject: Re: [PATCH v4 27/34] qemu-options: New -compat to set policy for
 deprecated interfaces
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200317115459.31821-1-armbru@redhat.com>
 <20200317115459.31821-28-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <f2466af3-a20d-94f7-950c-2d2cd2e919ae@redhat.com>
Date: Tue, 17 Mar 2020 16:05:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200317115459.31821-28-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: marcandre.lureau@gmail.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/17/20 6:54 AM, Markus Armbruster wrote:
> Policy is separate for input and output.
> 
> Input policy can be "accept" (accept silently), or "reject" (reject
> the request with an error).
> 
> Output policy can be "accept" (pass on unchanged), or "hide" (filter
> out the deprecated parts).
> 
> Default is "accept".  Policies other than "accept" are implemented
> later in this series.
> 
> For now, -compat covers only syntactic aspects of QMP, i.e. stuff
> tagged with feature 'deprecated'.  We may want to extend it to cover
> semantic aspects, CLI, and experimental features.
> 
> The option is experimental.

On IRC, we decided that it's probably not worth shoe-horning this (and 
the rest of the series) into 5.0, given the experimental nature.  Still, 
I'll go ahead and review, so we can settle on things early in 5.1.

> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

> +++ b/qapi/compat.json
> @@ -0,0 +1,51 @@
> +# -*- Mode: Python -*-
> +
> +##
> +# = Compatibility policy
> +##
> +
> +##
> +# @CompatPolicyInput:
> +#
> +# Policy for handling "funny" input.
> +#
> +# @accept: Accept silently
> +# @reject: Reject with an error
> +#
> +# Since: 5.0

Of course, now that we're slipping this, you'll have to s/5.0/5.1/g over 
the remaining patches.  I won't point it out further.

> +##
> +# @CompatPolicy:
> +#
> +# Policy for handling deprecated management interfaces.
> +#
> +# This is intended for testing users of the management interfaces.
> +#
> +# Limitation: covers only syntactic aspects of QMP, i.e. stuff tagged
> +# with feature 'deprecated'.  We may want to extend it to cover
> +# semantic aspects, CLI, and experimental features.

Hiding/rejecting x- interfaces is probably the easiest of these, but I 
agree that leaving this open-ended to add further coverage (or even 
additional modes) is still reasonable.

> +#
> +# @deprecated-input: how to handle deprecated input (default 'accept')
> +# @deprecated-output: how to handle deprecated output (default 'accept')
> +#
> +# Since: 5.0
> +##
> +{ 'struct': 'CompatPolicy',
> +  'data': { '*deprecated-input': 'CompatPolicyInput',
> +            '*deprecated-output': 'CompatPolicyOutput' } }

For example, adding
'*experimental-input': 'CompatPolicyInput'
would make it easy to hard-code failure on attempt to use x-* commands.


> +++ b/include/qapi/compat-policy.h
> @@ -0,0 +1,20 @@
> +/*
> + * Policy for handling "funny" management interfaces
> + *
> + * Copyright (C) 2019 Red Hat, Inc.

You've had this in-tree for a while. I'll leave it up to you if you want 
to add 2020.

> + *
> + * Authors:
> + *  Markus Armbruster <armbru@redhat.com>,
> + *

Ending with a comma is odd.  Is the Authors: snippet even necessary, or 
are we better off relying on git history (which tends to be more 
accurate anyway)?

> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * later.  See the COPYING file in the top-level directory.
> + */

Are we trying to use SPDX tags in more files?

> +++ b/qemu-options.hx
> @@ -3357,6 +3357,26 @@ DEFHEADING()
>   
>   DEFHEADING(Debug/Expert options:)
>   
> +DEF("compat", HAS_ARG, QEMU_OPTION_compat,
> +    "-compat [deprecated-input=accept|reject][,deprecated-output=accept|hide]\n"
> +    "                Policy for handling deprecated management interfaces\n",
> +    QEMU_ARCH_ALL)
> +SRST
> +``-compat [deprecated-input=@var{input-policy}][,deprecated-output=@var{output-policy}]``
> +    Set policy for handling deprecated management interfaces (experimental):

We'll eventually want to drop (experimental), especially if we get all 
the rest of this into 5.1.

But for now this looks like a good start.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


