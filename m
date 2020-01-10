Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E61C282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 19:01:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E7DE205F4
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 19:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sg7UgUKW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E7DE205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipzXG-0005RR-4c
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 14:01:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36924)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1ipzW9-0004Zz-An
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 14:00:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1ipzW6-0005A4-Jr
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 14:00:19 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36565
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ipzW6-00051A-Ce
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 14:00:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578682816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DlcQRnVUORNXZR2fpnSJgWZbRHGrhKOeAjd1daVQ97E=;
 b=Sg7UgUKWFO6a8nFE0PqyzFm4eYtIxk4XAHQlMT3Pi8eAMuY+PCYYnc8yf7FhXgcJ5w5Afm
 p2MZ9cLEt6b8JNgr3DU9NdJQHdsxsYTzpUstyMzIOmEOqBDQks0ffs32/g9It9pixMx5ZG
 +K8lDBh8vJ2/pYxUnwTRt4TyLkcn36k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-gTiJESpcOaO-yJbOF6NMxA-1; Fri, 10 Jan 2020 14:00:15 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE2E3613BC;
 Fri, 10 Jan 2020 19:00:13 +0000 (UTC)
Received: from [10.3.117.16] (ovpn-117-16.phx2.redhat.com [10.3.117.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D1C9C19C4F;
 Fri, 10 Jan 2020 19:00:12 +0000 (UTC)
Subject: Re: [PATCH 1/4] qapi: Add a 'coroutine' flag for commands
To: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
References: <20200109183545.27452-1-kwolf@redhat.com>
 <20200109183545.27452-2-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <947485af-1862-2834-7a0f-f8db811268d5@redhat.com>
Date: Fri, 10 Jan 2020 13:00:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200109183545.27452-2-kwolf@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: gTiJESpcOaO-yJbOF6NMxA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: marcandre.lureau@gmail.com, armbru@redhat.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/9/20 12:35 PM, Kevin Wolf wrote:
> This patch adds a new 'coroutine' flag to QMP command definitions that
> tells the QMP dispatcher than the command handler is safe to be run in a

s/than/that/

> coroutine.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   tests/qapi-schema/qapi-schema-test.json |  1 +
>   docs/devel/qapi-code-gen.txt            |  4 ++++
>   include/qapi/qmp/dispatch.h             |  1 +
>   tests/test-qmp-cmds.c                   |  4 ++++
>   scripts/qapi/commands.py                | 17 +++++++++++------
>   scripts/qapi/doc.py                     |  2 +-
>   scripts/qapi/expr.py                    |  4 ++--
>   scripts/qapi/introspect.py              |  2 +-
>   scripts/qapi/schema.py                  |  9 ++++++---
>   tests/qapi-schema/qapi-schema-test.out  |  2 ++
>   tests/qapi-schema/test-qapi.py          |  7 ++++---
>   11 files changed, 37 insertions(+), 16 deletions(-)
> 
> diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/qapi-schema-test.json
> index 9abf175fe0..55f596dbaa 100644
> --- a/tests/qapi-schema/qapi-schema-test.json
> +++ b/tests/qapi-schema/qapi-schema-test.json
> @@ -147,6 +147,7 @@
>     'returns': 'UserDefTwo' }
>   
>   { 'command': 'cmd-success-response', 'data': {}, 'success-response': false }
> +{ 'command': 'coroutine_cmd', 'data': {}, 'coroutine': true }

Not user-visible (it's the testsuite), but why not follow our naming 
convention of 'coroutine-cmd'?


> +++ b/docs/devel/qapi-code-gen.txt
> @@ -457,6 +457,7 @@ Syntax:
>                   '*gen': false,
>                   '*allow-oob': true,
>                   '*allow-preconfig': true,
> +                '*coroutine': true,
>                   '*if': COND,
>                   '*features': FEATURES }
>   
> @@ -581,6 +582,9 @@ before the machine is built.  It defaults to false.  For example:
>   QMP is available before the machine is built only when QEMU was
>   started with --preconfig.
>   
> +Member 'coroutine' tells the QMP dispatcher whether the command handler
> +is safe to be run in a coroutine. It defaults to false.
> +
>   The optional 'if' member specifies a conditional.  See "Configuring

Maybe "The optional 'coroutine' member tells..." for symmetry with the 
next paragraph.

> +++ b/scripts/qapi/commands.py
> @@ -15,6 +15,7 @@ See the COPYING file in the top-level directory.
>   
>   from qapi.common import *
>   from qapi.gen import QAPIGenCCode, QAPISchemaModularCVisitor, ifcontext
> +from typing import List
>   
>   
>   def gen_command_decl(name, arg_type, boxed, ret_type):
> @@ -194,8 +195,9 @@ out:
>       return ret
>   
>   
> -def gen_register_command(name, success_response, allow_oob, allow_preconfig):
> -    options = []
> +def gen_register_command(name: str, success_response: bool, allow_oob: bool,
> +                         allow_preconfig: bool, coroutine: bool) -> str:
> +    options = [] # type: List[str]

Aha - now that we require python 3, you're going to exploit it ;)


> +++ b/scripts/qapi/introspect.py
> @@ -212,7 +212,7 @@ const QLitObject %(c_name)s = %(c_string)s;
>   
>       def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
>                         success_response, boxed, allow_oob, allow_preconfig,
> -                      features):
> +                      coroutine, features):
>           arg_type = arg_type or self._schema.the_empty_object_type
>           ret_type = ret_type or self._schema.the_empty_object_type
>           obj = {'arg-type': self._use_type(arg_type),

I'm assuming the new flag is internal only, and doesn't affect behavior 
seen by the user, and thus nothing to change in the introspection output.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


