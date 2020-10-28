Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4F9C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 07:44:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3943922245
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 07:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hEsUGCYp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3943922245
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXg83-0005gr-P4
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 03:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kXg6z-00058H-Ec
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 03:43:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52864)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kXg6x-0005py-0d
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 03:43:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603870989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6PfDJExiHPyyZpirnATi07bnmKhEJpeYQ3IGv/Rt1uQ=;
 b=hEsUGCYpHdZCd9h5ZeD60sKzex9ecOKEu3lfCYmk4C7Y6NzQIL4INJt8IaSSr3a1+z5FvS
 +KnKZBPO8RcUyRkooiugB3TMfCgEVZkNNfRx+UZYv48tr5mRkMdcI3mD4k+9SJS6FcHxqQ
 CfM4UfRoc5p+8/ew2UwsnRjlfJkjk+4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-S0_S6k6cPzyGQ43uzbVlxQ-1; Wed, 28 Oct 2020 03:43:05 -0400
X-MC-Unique: S0_S6k6cPzyGQ43uzbVlxQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2B47108E1A3;
 Wed, 28 Oct 2020 07:43:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B4851975F;
 Wed, 28 Oct 2020 07:43:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 86F99113865F; Wed, 28 Oct 2020 08:42:59 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 4/4] qemu-storage-daemon: QAPIfy --chardev
References: <20201026101005.2940615-1-armbru@redhat.com>
 <20201026101005.2940615-5-armbru@redhat.com>
 <d937d998-74d6-7f19-e21f-662a084f67b2@redhat.com>
Date: Wed, 28 Oct 2020 08:42:59 +0100
In-Reply-To: <d937d998-74d6-7f19-e21f-662a084f67b2@redhat.com> (Eric Blake's
 message of "Tue, 27 Oct 2020 13:59:26 -0500")
Message-ID: <87sg9y23uk.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:50:00
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
Cc: kwolf@redhat.com, marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 10/26/20 5:10 AM, Markus Armbruster wrote:
>> From: Kevin Wolf <kwolf@redhat.com>
>> 
>> This removes the dependency on QemuOpts from the --chardev option of
>> the storage daemon.
>> 
>> Help on option parameters is still wrong.  Marked FIXME.
>> 
>> There are quite a few differences between qemu-system-FOO -chardev,
>> QMP chardev-add, and qemu-storage-daemon --chardev:
>> 
>> * QMP chardev-add wraps arguments other than "id" in a "backend"
>>   object.  Parameters other than "type" are further wrapped in a
>>   "data" object.  Example:
>> 
>>         {"execute": "chardev-add",
>>          "arguments": {
>>              "id":"sock0",
>>              "backend": {
>>                  "type": "socket",
>>                  "data": {
>>                      "addr": {
>>                          "type": "inet",
>> 			 ...
>>         }}}}}
>> 
>>   qemu-system-FOO -chardev does not wrap.  Neither does
>>   qemu-storage-daemon --chardev.
>> 
>> * qemu-system-FOO -chardev parameter "backend" corresponds to QMP
>>   chardev-add "backend" member "type".  qemu-storage-daemon names it
>>   "backend".
>> 
>> * qemu-system-FOO -chardev parameter "backend" recognizes a few
>>   additional aliases for compatibility.  QMP chardev-add does not.
>>   Neither does qemu-storage-daemon --chardev.
>> 
>> * qemu-system-FOO -chardev' with types "serial", "parallel" and "pipe"
>>   parameter "path" corresponds to QMP chardev-add member "device".
>>   qemu-storage-daemon --chardev follows QMP.
>> 
>> * Backend type "socket":
>> 
>>   - Intentionally different defaults (documented as such):
>>     qemu-system-FOO -chardev defaults to server=false and
>>     wait=true (if server=true), but QMP chardev-add defaults to
>>     server=true and wait=false.  qemu-storage-daemon --chardev follows
>>     QMP.
>> 
>>   - Accidentally different defaults: qemu-system-FOO -chardev defaults
>>     to tight=true, QMP chardev-add defaults to tight=false in
>>     QMP (this is a bug in commit 776b97d3).  qemu-storage-daemon
>>     follows QMP.
>
> Should we be fixing that bug for 5.2?

On the one hand, it's in 5.1, which means we get to worry about
compatibility.

On the other hand, it is documented to default to true in QMP, which
means we can legitimately treat the change as bug fix.

I'll look into it.

>>   - QMP chardev-add wraps socket address arguments "path", "host",
>>     "port", etc in a "data" object.  qemu-system-FOO -chardev does not
>>     wrap.  Neither does qemu-storage-daemon --chardev.
>> 
>>   - qemu-system-FOO -chardev parameter "delay" corresponds to QMP
>>     chardev-add member "nodelay" with the sense reversed.
>>     qemu-storage-daemon --chardev follows QMP.
>> 
>> * Backend type "udp":
>> 
>>   - QMP chardev-add wraps remote and local address arguments in a
>>     "remote" and a "local" object, respectively.  qemu-system-FOO
>>     -chardev does not wrap, but prefixes the local address parameter
>>     names with "local" instead.
>> 
>>   - QMP chardev-add wraps socket address arguments in a "data" object.
>>     qemu-system-FOO -chardev does not wrap.  Neither does
>>     qemu-storage-daemon --chardev.  Same as for type "socket".
>> 
>> * I'm not sure qemu-system-FOO -chardev supports everything QMP
>>   chardev-add does.  I am sure qemu-storage-daemon --chardev does.
>
> Quite the list, but it is a good start for what remains to merge things
> in the correct direction for 6.0.
>
>> 
>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  storage-daemon/qemu-storage-daemon.c | 37 +++++++++++++++++++++-------
>>  1 file changed, 28 insertions(+), 9 deletions(-)
>> 
>> diff --git a/storage-daemon/qemu-storage-daemon.c b/storage-daemon/qemu-storage-daemon.c
>> index e419ba9f19..f1f3bdc320 100644
>> --- a/storage-daemon/qemu-storage-daemon.c
>> +++ b/storage-daemon/qemu-storage-daemon.c
>> @@ -37,10 +37,13 @@
>>  #include "qapi/error.h"
>>  #include "qapi/qapi-visit-block-core.h"
>>  #include "qapi/qapi-visit-block-export.h"
>> +#include "qapi/qapi-visit-char.h"
>> +#include "qapi/qapi-visit-char.h"
>
> Duplicate.

Yes.

>>  #include "qapi/qapi-visit-control.h"
>>  #include "qapi/qmp/qdict.h"
>>  #include "qapi/qmp/qstring.h"
>>  #include "qapi/qobject-input-visitor.h"
>> +#include "qapi/qobject-output-visitor.h"
>>  
>>  #include "qemu-common.h"
>>  #include "qemu-version.h"
>> @@ -207,18 +210,34 @@ static void process_options(int argc, char *argv[])
>>              }
>>          case OPTION_CHARDEV:
>>              {
>> -                /* TODO This interface is not stable until we QAPIfy it */
>> -                QemuOpts *opts = qemu_opts_parse_noisily(&qemu_chardev_opts,
>> -                                                         optarg, true);
>> -                if (opts == NULL) {
>> -                    exit(EXIT_FAILURE);
>> -                }
>> +                QDict *args;
>> +                Visitor *v;
>> +                ChardevOptions *chr;
>> +                q_obj_chardev_add_arg *arg;
>> +                bool help;
>>  
>> -                if (!qemu_chr_new_from_opts(opts, NULL, &error_fatal)) {
>> -                    /* No error, but NULL returned means help was printed */
>> +                args = keyval_parse(optarg, "backend", &help, &error_fatal);
>> +                if (help) {
>> +                    if (qdict_haskey(args, "backend")) {
>> +                        /* FIXME wrong where QAPI differs from QemuOpts */
>> +                        qemu_opts_print_help(&qemu_chardev_opts, true);
>> +                    } else {
>> +                        qemu_chr_print_types();
>> +                    }
>>                      exit(EXIT_SUCCESS);
>>                  }
>> -                qemu_opts_del(opts);
>> +
>> +                v = qobject_input_visitor_new_keyval(QOBJECT(args));
>> +                visit_type_ChardevOptions(v, NULL, &chr, &error_fatal);
>> +                visit_free(v);
>> +
>> +                arg = chardev_options_crumple(chr);
>> +
>> +                qmp_chardev_add(arg->id, arg->backend, &error_fatal);
>> +                g_free(arg->id);
>> +                qapi_free_ChardevBackend(arg->backend);
>> +                qapi_free_ChardevOptions(chr);
>> +                qobject_unref(args);
>>                  break;
>>              }
>>          case OPTION_EXPORT:
>> 
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!


