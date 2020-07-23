Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F280DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:12:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B985920709
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RSCvzHa7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B985920709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jya5q-00089Y-Vl
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 08:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57116)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jya5E-0007Vx-1f
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 08:12:20 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60431
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jya5B-0001AX-AH
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 08:12:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595506335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OfZDwSa4BRktp47b014BP2vtbxq8eKCl02t4bWnPmrs=;
 b=RSCvzHa76vyPyl2P0s7/sCTNqZ7a7Ls2sR9Q4VMIewBvMagFuX74rNIdspqRsrpI/nJwvR
 2MPNryQebpWdau+KMqYEJtO+hGXFwdaMrZbF8V/mUuQQ210Cl0I8/xXqEqlyLDyGMoZ+He
 iluyvhExuUmETaE01HIWgRfx5u7Owfk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-0WBrqFAnPkCqa0vPvGX0og-1; Thu, 23 Jul 2020 08:12:12 -0400
X-MC-Unique: 0WBrqFAnPkCqa0vPvGX0og-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9296519057A1;
 Thu, 23 Jul 2020 12:12:11 +0000 (UTC)
Received: from turbo.dinechin.lan (ovpn-113-141.ams2.redhat.com
 [10.36.113.141])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 57D7359;
 Thu, 23 Jul 2020 12:12:03 +0000 (UTC)
References: <20200626162706.3304357-1-dinechin@redhat.com>
 <20200626162706.3304357-3-dinechin@redhat.com>
 <20200630130257.GP1370404@redhat.com>
User-agent: mu4e 1.5.5; emacs 26.3
From: Christophe de Dinechin <dinechin@redhat.com>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v2 2/3] trace: Add support for recorder back-end
In-reply-to: <20200630130257.GP1370404@redhat.com>
Date: Thu, 23 Jul 2020 14:12:00 +0200
Message-ID: <7ha6zq2zxr.fsf@turbo.dinechin.lan>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dinechin@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:33:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Markus Armbruster <armbru@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020-06-30 at 15:02 CEST, Daniel P. Berrang=C3=A9 wrote...
> On Fri, Jun 26, 2020 at 06:27:05PM +0200, Christophe de Dinechin wrote:
>> The recorder library provides support for low-cost continuous
>> recording of events, which can then be replayed. This makes it
>> possible to collect data "after the fact",for example to show the
>> events that led to a crash.
>>
>> Recorder support in qemu is implemented using the existing tracing
>> interface. In addition, it is possible to individually enable
>> recorders that are not traces, although this is probably not
>> recommended.
>>
>> HMP COMMAND:
>> The 'recorder' hmp command has been added, which supports two
>> sub-commands:
>> - recorder dump: Dump the current state of the recorder. You can
>> - recorder trace: Set traces using the recorder_trace_set() syntax.
>>   You can use "recorder trace help" to list all available recorders.
>>
>> Signed-off-by: Christophe de Dinechin <dinechin@redhat.com>
>> ---
>>  configure                             |  5 +++
>>  hmp-commands.hx                       | 19 ++++++++--
>>  monitor/misc.c                        | 27 ++++++++++++++
>>  scripts/tracetool/backend/recorder.py | 51 +++++++++++++++++++++++++++
>>  trace/Makefile.objs                   |  2 ++
>>  trace/control.c                       |  7 ++++
>>  trace/recorder.c                      | 22 ++++++++++++
>>  trace/recorder.h                      | 34 ++++++++++++++++++
>>  util/module.c                         |  8 +++++
>>  9 files changed, 173 insertions(+), 2 deletions(-)
>>  create mode 100644 scripts/tracetool/backend/recorder.py
>>  create mode 100644 trace/recorder.c
>>  create mode 100644 trace/recorder.h
>
>> +RECORDER_CONSTRUCTOR
>> +void recorder_trace_init(void)
>> +{
>> +    recorder_trace_set(getenv("RECORDER_TRACES"));
>> +
>> +    // Allow a dump in case we receive some unhandled signal
>> +    // For example, send USR2 to a hung process to get a dump
>> +    if (getenv("RECORDER_TRACES"))
>> +        recorder_dump_on_common_signals(0,0);
>> +}
>
> What is the syntax of this RECORDER_TRACES env variable,

It's basically a colon-separated list of regexps,
e.g. ".*_error:.*_warning", with special syntax for some additional
functionality such as real-time graphing.

Here are a few examples:

- Activate the foo, bar and baz traces:
      foo:bar:baz

- Activate all traces that contain "lock", as well as "recorder" trace:
      *lock.*:recorder

- Deactivate traces ending in _error
      .*_error=3D0

There are also a few tweaks and special names, for example you can adjust
the output to show the function name and source code location as follows::

- Show source information in the traces
      recorder_function:recorder_location

  As is not very useful in qemu because it sohws the wrapper location:
     % RECORDER_TRACES=3Dvm_state_notify qemu-system-x86_64
     [35225 7.092175] vm_state_notify: running 1 reason 9 (running)

     % RECORDER_TRACES=3Dvm_state_notify:recorder_function:recorder_locatio=
n qemu-system-x86_64
     /home/ddd/Work/qemu/trace-root.h:346:_nocheck__trace_vm_state_notify:[=
94277 0.294906] vm_state_notify: running 1 reason 9 (running)

  This is not as good as what you get with "real" record entries:
     % RECORDER_TRACES=3Drecorder_function:recorder_location:recorder qemu-=
system-x86_64
     recorder.c:2036:recorder_allocate_alt_stack:[29561 0.006434] recorder:=
 Set alt stack to 0x7fc567b87000 size 8192

- Get some help on available traces:
      help

- Enable real-time graphing for trace "perfdata"
      perfdata=3Dbytes,loops

The last one assumes that you would have a record that looks like:

     record(perfdata, "Transferred %lu bytes in %lu iterations",
            bytes, itercount);

You could then have a real-time graph of the values for variables "bytes"
and "itercount" using the recorder_scope program, and using the names you
gave to the channels in your RECORDER_TRACES variable, i.e. bytes and loops=
:

     recorder_scope bytes loops

See man recorder_trace_set(3), recorder_scope(1) or
https://github.com/c3d/recorder#recorder-tracing for more information.


> and perhaps more importantly should we have this modelled as a command
> line arg instead of an env variable. We've generally been aiming to get
> rid of env variables and have QAPI modelled CLI. QAPI modelling would be
> particularly important if we want to expose the ablity to change settings
> on the fly via QMP.

The rationale for the recorder using an environment variable is that it was
initially designed to be able to trace libraries, notably SPICE or the
recorder library itself. A single environment variable can be used to
activate traces in the main binary as well as in the libraries.

I'm certainly not against adding a command-line option to activate recorder
options specifically, but as I understand, the option -trace already exists=
,
and its semantics is sufficiently different from the one in recorder
patterns that I decided to not connect the two for now. For example, to
disable trace foo, you'd pass "-foo" to the -trace option, but "foo=3D0" to
RECORDER_TRACES. The parsing of graphing options and other related
recorder-specific stuff is a bit difficult to integrate with -trace too.

>
>
>> diff --git a/trace/recorder.h b/trace/recorder.h
>> new file mode 100644
>> index 0000000000..00b11a2d2f
>> --- /dev/null
>> +++ b/trace/recorder.h
>> @@ -0,0 +1,34 @@
>> +/*
>> + * Recorder-based trace backend
>> + *
>> + * Copyright Red Hat 2020
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2.  Se=
e
>> + * the COPYING file in the top-level directory.
>
> Why "version 2" (only), instead of "version 2 or later" ? QEMU generally
> expects the latter for any new code, unless it is derived from existing
> v2-only code in QEMU.

Good catch. I copied that straight from trace/simple.h. No problem changing
it as you suggest. I don't think that whatever inspiration I took from the
existing trace code is sufficient to stick to 2-only.

>
> Regards,
> Daniel


--
Cheers,
Christophe de Dinechin (IRC c3d)


