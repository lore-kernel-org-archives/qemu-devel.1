Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5D2C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 19:01:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FA8A21556
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 19:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TvWnWkUj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FA8A21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXUEE-0005ur-8W
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 15:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kXUC3-0004mH-2O
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 14:59:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24522)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kXUC0-0000Do-EZ
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 14:59:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603825174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=11ORZMpUEWSBHa1uYN4H+eZV+XHwqGhMkm9lop9elQs=;
 b=TvWnWkUjqgF1U5xf5fKPiL5FnEa1dVFHfzdPY0xG5qSYAoObVxEqw6Qn4cWPHC3bBf4iIW
 lo1yQNWUhkcr932+3m/htta1J5ZVtg1NvPoWMC8dSI2fCPgKR+NeKfQNxK1L8DOaCEZzIE
 fbnMHt0ZV+jx47OgHPZ4IlhH0lKVDRE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-0nlVgyjJMGSmFh7YEOHh5w-1; Tue, 27 Oct 2020 14:59:31 -0400
X-MC-Unique: 0nlVgyjJMGSmFh7YEOHh5w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB32618C89C4;
 Tue, 27 Oct 2020 18:59:30 +0000 (UTC)
Received: from [10.3.112.145] (ovpn-112-145.phx2.redhat.com [10.3.112.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 26F5760C07;
 Tue, 27 Oct 2020 18:59:27 +0000 (UTC)
Subject: Re: [PATCH 4/4] qemu-storage-daemon: QAPIfy --chardev
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20201026101005.2940615-1-armbru@redhat.com>
 <20201026101005.2940615-5-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <d937d998-74d6-7f19-e21f-662a084f67b2@redhat.com>
Date: Tue, 27 Oct 2020 13:59:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201026101005.2940615-5-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: kwolf@redhat.com, marcandre.lureau@redhat.com, qemu-block@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/26/20 5:10 AM, Markus Armbruster wrote:
> From: Kevin Wolf <kwolf@redhat.com>
> 
> This removes the dependency on QemuOpts from the --chardev option of
> the storage daemon.
> 
> Help on option parameters is still wrong.  Marked FIXME.
> 
> There are quite a few differences between qemu-system-FOO -chardev,
> QMP chardev-add, and qemu-storage-daemon --chardev:
> 
> * QMP chardev-add wraps arguments other than "id" in a "backend"
>   object.  Parameters other than "type" are further wrapped in a
>   "data" object.  Example:
> 
>         {"execute": "chardev-add",
>          "arguments": {
>              "id":"sock0",
>              "backend": {
>                  "type": "socket",
>                  "data": {
>                      "addr": {
>                          "type": "inet",
> 			 ...
>         }}}}}
> 
>   qemu-system-FOO -chardev does not wrap.  Neither does
>   qemu-storage-daemon --chardev.
> 
> * qemu-system-FOO -chardev parameter "backend" corresponds to QMP
>   chardev-add "backend" member "type".  qemu-storage-daemon names it
>   "backend".
> 
> * qemu-system-FOO -chardev parameter "backend" recognizes a few
>   additional aliases for compatibility.  QMP chardev-add does not.
>   Neither does qemu-storage-daemon --chardev.
> 
> * qemu-system-FOO -chardev' with types "serial", "parallel" and "pipe"
>   parameter "path" corresponds to QMP chardev-add member "device".
>   qemu-storage-daemon --chardev follows QMP.
> 
> * Backend type "socket":
> 
>   - Intentionally different defaults (documented as such):
>     qemu-system-FOO -chardev defaults to server=false and
>     wait=true (if server=true), but QMP chardev-add defaults to
>     server=true and wait=false.  qemu-storage-daemon --chardev follows
>     QMP.
> 
>   - Accidentally different defaults: qemu-system-FOO -chardev defaults
>     to tight=true, QMP chardev-add defaults to tight=false in
>     QMP (this is a bug in commit 776b97d3).  qemu-storage-daemon
>     follows QMP.

Should we be fixing that bug for 5.2?

> 
>   - QMP chardev-add wraps socket address arguments "path", "host",
>     "port", etc in a "data" object.  qemu-system-FOO -chardev does not
>     wrap.  Neither does qemu-storage-daemon --chardev.
> 
>   - qemu-system-FOO -chardev parameter "delay" corresponds to QMP
>     chardev-add member "nodelay" with the sense reversed.
>     qemu-storage-daemon --chardev follows QMP.
> 
> * Backend type "udp":
> 
>   - QMP chardev-add wraps remote and local address arguments in a
>     "remote" and a "local" object, respectively.  qemu-system-FOO
>     -chardev does not wrap, but prefixes the local address parameter
>     names with "local" instead.
> 
>   - QMP chardev-add wraps socket address arguments in a "data" object.
>     qemu-system-FOO -chardev does not wrap.  Neither does
>     qemu-storage-daemon --chardev.  Same as for type "socket".
> 
> * I'm not sure qemu-system-FOO -chardev supports everything QMP
>   chardev-add does.  I am sure qemu-storage-daemon --chardev does.

Quite the list, but it is a good start for what remains to merge things
in the correct direction for 6.0.

> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  storage-daemon/qemu-storage-daemon.c | 37 +++++++++++++++++++++-------
>  1 file changed, 28 insertions(+), 9 deletions(-)
> 
> diff --git a/storage-daemon/qemu-storage-daemon.c b/storage-daemon/qemu-storage-daemon.c
> index e419ba9f19..f1f3bdc320 100644
> --- a/storage-daemon/qemu-storage-daemon.c
> +++ b/storage-daemon/qemu-storage-daemon.c
> @@ -37,10 +37,13 @@
>  #include "qapi/error.h"
>  #include "qapi/qapi-visit-block-core.h"
>  #include "qapi/qapi-visit-block-export.h"
> +#include "qapi/qapi-visit-char.h"
> +#include "qapi/qapi-visit-char.h"

Duplicate.

>  #include "qapi/qapi-visit-control.h"
>  #include "qapi/qmp/qdict.h"
>  #include "qapi/qmp/qstring.h"
>  #include "qapi/qobject-input-visitor.h"
> +#include "qapi/qobject-output-visitor.h"
>  
>  #include "qemu-common.h"
>  #include "qemu-version.h"
> @@ -207,18 +210,34 @@ static void process_options(int argc, char *argv[])
>              }
>          case OPTION_CHARDEV:
>              {
> -                /* TODO This interface is not stable until we QAPIfy it */
> -                QemuOpts *opts = qemu_opts_parse_noisily(&qemu_chardev_opts,
> -                                                         optarg, true);
> -                if (opts == NULL) {
> -                    exit(EXIT_FAILURE);
> -                }
> +                QDict *args;
> +                Visitor *v;
> +                ChardevOptions *chr;
> +                q_obj_chardev_add_arg *arg;
> +                bool help;
>  
> -                if (!qemu_chr_new_from_opts(opts, NULL, &error_fatal)) {
> -                    /* No error, but NULL returned means help was printed */
> +                args = keyval_parse(optarg, "backend", &help, &error_fatal);
> +                if (help) {
> +                    if (qdict_haskey(args, "backend")) {
> +                        /* FIXME wrong where QAPI differs from QemuOpts */
> +                        qemu_opts_print_help(&qemu_chardev_opts, true);
> +                    } else {
> +                        qemu_chr_print_types();
> +                    }
>                      exit(EXIT_SUCCESS);
>                  }
> -                qemu_opts_del(opts);
> +
> +                v = qobject_input_visitor_new_keyval(QOBJECT(args));
> +                visit_type_ChardevOptions(v, NULL, &chr, &error_fatal);
> +                visit_free(v);
> +
> +                arg = chardev_options_crumple(chr);
> +
> +                qmp_chardev_add(arg->id, arg->backend, &error_fatal);
> +                g_free(arg->id);
> +                qapi_free_ChardevBackend(arg->backend);
> +                qapi_free_ChardevOptions(chr);
> +                qobject_unref(args);
>                  break;
>              }
>          case OPTION_EXPORT:
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


