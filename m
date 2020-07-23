Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3E0C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 14:07:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47B6C20709
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 14:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XpLUY7cU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47B6C20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jybsR-0007UN-G1
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 10:07:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jybrk-0006dJ-KJ
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 10:06:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44410
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jybrh-0003fy-Fh
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 10:06:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595513187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K96yXGuAHMt/ZTwMwwknNjsZGyVp96lBALrHCYdVtLI=;
 b=XpLUY7cUDtSVOyNVkx9yIf/vbVV3VYftb+OvMeqdJGwE7EZRJ3zgg8z5f0Rg3Ush+jx9Wr
 Q7nRINjgudWW+Ve5NOQLsMegEgxNQRPf1C4gT0W+s13PWmcmKsPqkEay3P7ZeqstozyBZI
 ry4JKuruSmPa8JOLz72km4ud7XHc2Vw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-bcnt1RyIPAGAemaWJtM5BQ-1; Thu, 23 Jul 2020 10:06:19 -0400
X-MC-Unique: bcnt1RyIPAGAemaWJtM5BQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9D91800C64;
 Thu, 23 Jul 2020 14:06:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9137D60CC0;
 Thu, 23 Jul 2020 14:06:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 15EBD111CA26; Thu, 23 Jul 2020 16:06:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Christophe de Dinechin <dinechin@redhat.com>
Subject: Re: [PATCH v2 2/3] trace: Add support for recorder back-end
References: <20200626162706.3304357-1-dinechin@redhat.com>
 <20200626162706.3304357-3-dinechin@redhat.com>
 <20200630130257.GP1370404@redhat.com>
 <7ha6zq2zxr.fsf@turbo.dinechin.lan>
Date: Thu, 23 Jul 2020 16:06:10 +0200
In-Reply-To: <7ha6zq2zxr.fsf@turbo.dinechin.lan> (Christophe de Dinechin's
 message of "Thu, 23 Jul 2020 14:12:00 +0200")
Message-ID: <87mu3qgwbx.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 22:13:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, "Dr.
 David Alan Gilbert" <dgilbert@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Christophe de Dinechin <dinechin@redhat.com> writes:

> On 2020-06-30 at 15:02 CEST, Daniel P. Berrang=C3=A9 wrote...
>> On Fri, Jun 26, 2020 at 06:27:05PM +0200, Christophe de Dinechin wrote:
>>> The recorder library provides support for low-cost continuous
>>> recording of events, which can then be replayed. This makes it
>>> possible to collect data "after the fact",for example to show the
>>> events that led to a crash.
>>>
>>> Recorder support in qemu is implemented using the existing tracing
>>> interface. In addition, it is possible to individually enable
>>> recorders that are not traces, although this is probably not
>>> recommended.
>>>
>>> HMP COMMAND:
>>> The 'recorder' hmp command has been added, which supports two
>>> sub-commands:
>>> - recorder dump: Dump the current state of the recorder. You can
>>> - recorder trace: Set traces using the recorder_trace_set() syntax.
>>>   You can use "recorder trace help" to list all available recorders.
>>>
>>> Signed-off-by: Christophe de Dinechin <dinechin@redhat.com>
>>> ---
>>>  configure                             |  5 +++
>>>  hmp-commands.hx                       | 19 ++++++++--
>>>  monitor/misc.c                        | 27 ++++++++++++++
>>>  scripts/tracetool/backend/recorder.py | 51 +++++++++++++++++++++++++++
>>>  trace/Makefile.objs                   |  2 ++
>>>  trace/control.c                       |  7 ++++
>>>  trace/recorder.c                      | 22 ++++++++++++
>>>  trace/recorder.h                      | 34 ++++++++++++++++++
>>>  util/module.c                         |  8 +++++
>>>  9 files changed, 173 insertions(+), 2 deletions(-)
>>>  create mode 100644 scripts/tracetool/backend/recorder.py
>>>  create mode 100644 trace/recorder.c
>>>  create mode 100644 trace/recorder.h
>>
>>> +RECORDER_CONSTRUCTOR
>>> +void recorder_trace_init(void)
>>> +{
>>> +    recorder_trace_set(getenv("RECORDER_TRACES"));
>>> +
>>> +    // Allow a dump in case we receive some unhandled signal
>>> +    // For example, send USR2 to a hung process to get a dump
>>> +    if (getenv("RECORDER_TRACES"))
>>> +        recorder_dump_on_common_signals(0,0);
>>> +}
>>
>> What is the syntax of this RECORDER_TRACES env variable,
>
> It's basically a colon-separated list of regexps,
> e.g. ".*_error:.*_warning", with special syntax for some additional
> functionality such as real-time graphing.
>
> Here are a few examples:
>
> - Activate the foo, bar and baz traces:
>       foo:bar:baz
>
> - Activate all traces that contain "lock", as well as "recorder" trace:
>       *lock.*:recorder
>
> - Deactivate traces ending in _error
>       .*_error=3D0
>
> There are also a few tweaks and special names, for example you can adjust
> the output to show the function name and source code location as follows:=
:
>
> - Show source information in the traces
>       recorder_function:recorder_location
>
>   As is not very useful in qemu because it sohws the wrapper location:
>      % RECORDER_TRACES=3Dvm_state_notify qemu-system-x86_64
>      [35225 7.092175] vm_state_notify: running 1 reason 9 (running)
>
>      % RECORDER_TRACES=3Dvm_state_notify:recorder_function:recorder_locat=
ion qemu-system-x86_64
>      /home/ddd/Work/qemu/trace-root.h:346:_nocheck__trace_vm_state_notify=
:[94277 0.294906] vm_state_notify: running 1 reason 9 (running)
>
>   This is not as good as what you get with "real" record entries:
>      % RECORDER_TRACES=3Drecorder_function:recorder_location:recorder qem=
u-system-x86_64
>      recorder.c:2036:recorder_allocate_alt_stack:[29561 0.006434] recorde=
r: Set alt stack to 0x7fc567b87000 size 8192
>
> - Get some help on available traces:
>       help
>
> - Enable real-time graphing for trace "perfdata"
>       perfdata=3Dbytes,loops
>
> The last one assumes that you would have a record that looks like:
>
>      record(perfdata, "Transferred %lu bytes in %lu iterations",
>             bytes, itercount);
>
> You could then have a real-time graph of the values for variables "bytes"
> and "itercount" using the recorder_scope program, and using the names you
> gave to the channels in your RECORDER_TRACES variable, i.e. bytes and loo=
ps:
>
>      recorder_scope bytes loops
>
> See man recorder_trace_set(3), recorder_scope(1) or
> https://github.com/c3d/recorder#recorder-tracing for more information.
>
>
>> and perhaps more importantly should we have this modelled as a command
>> line arg instead of an env variable. We've generally been aiming to get
>> rid of env variables and have QAPI modelled CLI. QAPI modelling would be
>> particularly important if we want to expose the ablity to change setting=
s
>> on the fly via QMP.
>
> The rationale for the recorder using an environment variable is that it w=
as
> initially designed to be able to trace libraries, notably SPICE or the
> recorder library itself. A single environment variable can be used to
> activate traces in the main binary as well as in the libraries.

Makes sense.

> I'm certainly not against adding a command-line option to activate record=
er
> options specifically, but as I understand, the option -trace already exis=
ts,
> and its semantics is sufficiently different from the one in recorder
> patterns that I decided to not connect the two for now. For example, to
> disable trace foo, you'd pass "-foo" to the -trace option, but "foo=3D0" =
to
> RECORDER_TRACES. The parsing of graphing options and other related
> recorder-specific stuff is a bit difficult to integrate with -trace too.

We need proper integration with the existing trace UI.

In particular, the ability to enable and disable trace events
dynamically provided by QMP commands trace-event-get-state,
trace-event-set-state, and HMP command trace-event is really useful.

Integration need not mean implement the existing interface slavishly!
Feel free to evolve it.  For instance, the QMP commands provide
"case-sensitive glob", while you have full regexps.  You could extend
the commands to also accept regexps.

We can talk about leaving gaps for later.

I recommend to start with QMP.

[...]


