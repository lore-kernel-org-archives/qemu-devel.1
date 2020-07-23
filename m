Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDACDC433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 16:16:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A853922B43
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 16:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dm3GqQ3R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A853922B43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jydts-0005M0-0N
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 12:16:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jydsT-0004ii-Oz
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 12:15:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21515
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jydsQ-0000NW-GR
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 12:15:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595520921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dUQfytWB5RavO7AbIQI+aiVluR7N+hCEzw+nNNK2ytg=;
 b=Dm3GqQ3RvgHvy4yY//Vw6Upj+AZFEi/jhnurAz1UT0lwvWiYAzv/l6qFFsojZk0lgsJGbz
 MXtwnGtq+VZ7/p2+1KHaPA5N8hdXItnxIGz6Jc5iNvn9Tfrvf/UkzIy9ApjjF+nx3SM5tG
 OBzFrPjR27XKdSklpKwmSZ9ZiE+EM0M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-xpaG0aC1Muq8bEHUVHQs9A-1; Thu, 23 Jul 2020 12:15:16 -0400
X-MC-Unique: xpaG0aC1Muq8bEHUVHQs9A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9257100AA2D;
 Thu, 23 Jul 2020 16:15:15 +0000 (UTC)
Received: from turbo.dinechin.lan (ovpn-113-141.ams2.redhat.com
 [10.36.113.141])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8311E8BEE9;
 Thu, 23 Jul 2020 16:15:10 +0000 (UTC)
References: <20200626162706.3304357-1-dinechin@redhat.com>
 <20200626162706.3304357-3-dinechin@redhat.com>
 <20200630130257.GP1370404@redhat.com> <7ha6zq2zxr.fsf@turbo.dinechin.lan>
 <87mu3qgwbx.fsf@dusky.pond.sub.org>
User-agent: mu4e 1.5.5; emacs 26.3
From: Christophe de Dinechin <dinechin@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 2/3] trace: Add support for recorder back-end
In-reply-to: <87mu3qgwbx.fsf@dusky.pond.sub.org>
Date: Thu, 23 Jul 2020 18:15:08 +0200
Message-ID: <7ha6zq2ooj.fsf@turbo.dinechin.lan>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dinechin@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dinechin@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 06:04:25
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
Cc: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, "Dr.
 David Alan Gilbert" <dgilbert@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020-07-23 at 16:06 CEST, Markus Armbruster wrote...
> Christophe de Dinechin <dinechin@redhat.com> writes:
>
>> On 2020-06-30 at 15:02 CEST, Daniel P. Berrang=C3=A9 wrote...
>>> On Fri, Jun 26, 2020 at 06:27:05PM +0200, Christophe de Dinechin wrote:
>>>> The recorder library provides support for low-cost continuous
>>>> recording of events, which can then be replayed. This makes it
>>>> possible to collect data "after the fact",for example to show the
>>>> events that led to a crash.
>>>>
>>>> Recorder support in qemu is implemented using the existing tracing
>>>> interface. In addition, it is possible to individually enable
>>>> recorders that are not traces, although this is probably not
>>>> recommended.
>>>>
>>>> HMP COMMAND:
>>>> The 'recorder' hmp command has been added, which supports two
>>>> sub-commands:
>>>> - recorder dump: Dump the current state of the recorder. You can
>>>> - recorder trace: Set traces using the recorder_trace_set() syntax.
>>>>   You can use "recorder trace help" to list all available recorders.
>>>>
>>>> Signed-off-by: Christophe de Dinechin <dinechin@redhat.com>
>>>> ---
>>>>  configure                             |  5 +++
>>>>  hmp-commands.hx                       | 19 ++++++++--
>>>>  monitor/misc.c                        | 27 ++++++++++++++
>>>>  scripts/tracetool/backend/recorder.py | 51 ++++++++++++++++++++++++++=
+
>>>>  trace/Makefile.objs                   |  2 ++
>>>>  trace/control.c                       |  7 ++++
>>>>  trace/recorder.c                      | 22 ++++++++++++
>>>>  trace/recorder.h                      | 34 ++++++++++++++++++
>>>>  util/module.c                         |  8 +++++
>>>>  9 files changed, 173 insertions(+), 2 deletions(-)
>>>>  create mode 100644 scripts/tracetool/backend/recorder.py
>>>>  create mode 100644 trace/recorder.c
>>>>  create mode 100644 trace/recorder.h
>>>
>>>> +RECORDER_CONSTRUCTOR
>>>> +void recorder_trace_init(void)
>>>> +{
>>>> +    recorder_trace_set(getenv("RECORDER_TRACES"));
>>>> +
>>>> +    // Allow a dump in case we receive some unhandled signal
>>>> +    // For example, send USR2 to a hung process to get a dump
>>>> +    if (getenv("RECORDER_TRACES"))
>>>> +        recorder_dump_on_common_signals(0,0);
>>>> +}
>>>
>>> What is the syntax of this RECORDER_TRACES env variable,
>>
>> It's basically a colon-separated list of regexps,
>> e.g. ".*_error:.*_warning", with special syntax for some additional
>> functionality such as real-time graphing.
>>
>> Here are a few examples:
>>
>> - Activate the foo, bar and baz traces:
>>       foo:bar:baz
>>
>> - Activate all traces that contain "lock", as well as "recorder" trace:
>>       *lock.*:recorder
>>
>> - Deactivate traces ending in _error
>>       .*_error=3D0
>>
>> There are also a few tweaks and special names, for example you can adjus=
t
>> the output to show the function name and source code location as follows=
::
>>
>> - Show source information in the traces
>>       recorder_function:recorder_location
>>
>>   As is not very useful in qemu because it sohws the wrapper location:
>>      % RECORDER_TRACES=3Dvm_state_notify qemu-system-x86_64
>>      [35225 7.092175] vm_state_notify: running 1 reason 9 (running)
>>
>>      % RECORDER_TRACES=3Dvm_state_notify:recorder_function:recorder_loca=
tion qemu-system-x86_64
>>      /home/ddd/Work/qemu/trace-root.h:346:_nocheck__trace_vm_state_notif=
y:[94277 0.294906] vm_state_notify: running 1 reason 9 (running)
>>
>>   This is not as good as what you get with "real" record entries:
>>      % RECORDER_TRACES=3Drecorder_function:recorder_location:recorder qe=
mu-system-x86_64
>>      recorder.c:2036:recorder_allocate_alt_stack:[29561 0.006434] record=
er: Set alt stack to 0x7fc567b87000 size 8192
>>
>> - Get some help on available traces:
>>       help
>>
>> - Enable real-time graphing for trace "perfdata"
>>       perfdata=3Dbytes,loops
>>
>> The last one assumes that you would have a record that looks like:
>>
>>      record(perfdata, "Transferred %lu bytes in %lu iterations",
>>             bytes, itercount);
>>
>> You could then have a real-time graph of the values for variables "bytes=
"
>> and "itercount" using the recorder_scope program, and using the names yo=
u
>> gave to the channels in your RECORDER_TRACES variable, i.e. bytes and lo=
ops:
>>
>>      recorder_scope bytes loops
>>
>> See man recorder_trace_set(3), recorder_scope(1) or
>> https://github.com/c3d/recorder#recorder-tracing for more information.
>>
>>
>>> and perhaps more importantly should we have this modelled as a command
>>> line arg instead of an env variable. We've generally been aiming to get
>>> rid of env variables and have QAPI modelled CLI. QAPI modelling would b=
e
>>> particularly important if we want to expose the ablity to change settin=
gs
>>> on the fly via QMP.
>>
>> The rationale for the recorder using an environment variable is that it =
was
>> initially designed to be able to trace libraries, notably SPICE or the
>> recorder library itself. A single environment variable can be used to
>> activate traces in the main binary as well as in the libraries.
>
> Makes sense.
>
>> I'm certainly not against adding a command-line option to activate recor=
der
>> options specifically, but as I understand, the option -trace already exi=
sts,
>> and its semantics is sufficiently different from the one in recorder
>> patterns that I decided to not connect the two for now. For example, to
>> disable trace foo, you'd pass "-foo" to the -trace option, but "foo=3D0"=
 to
>> RECORDER_TRACES. The parsing of graphing options and other related
>> recorder-specific stuff is a bit difficult to integrate with -trace too.
>
> We need proper integration with the existing trace UI.

I agree, but I don't think this belongs to this particular patch series.
See below why.

>
> In particular, the ability to enable and disable trace events
> dynamically provided by QMP commands trace-event-get-state,
> trace-event-set-state, and HMP command trace-event is really useful.

That ability exists, but given the many differences between the
recorder and other tracing mechanisms, I found it useful to add a specific
"recorder" command.

For example, assuming I built with both recorder and log trace backends,
from the monitor, I can type:

  trace-event kvm_run_exit on

What I get then is something like that:

  2091091@1595518935.441273:kvm_run_exit cpu_index 0, reason 2
  2091091@1595518935.441292:kvm_run_exit cpu_index 0, reason 2
  2091091@1595518935.441301:kvm_run_exit cpu_index 0, reason 2
  2091091@1595518935.441309:kvm_run_exit cpu_index 0, reason 2
  2091091@1595518935.441254:kvm_run_exit cpu_index 0, reason 2

It would not be very useful to activate recorder traces as well when that
happens, which would have the undesired side effect of purging any
corresponding entry from a following recorder dump.

There are, however, new monitor commands, so now I can do:

  recorder trace kvm_run_exit

I now get an output where each trace shows up twice.

  [120139718 137.127269] kvm_run_exit: cpu_index 0, reason 2
  2091091@1595518954.209803:kvm_run_exit cpu_index 0, reason 2
  [120139734 137.127281] kvm_run_exit: cpu_index 0, reason 2
  2091091@1595518954.209814:kvm_run_exit cpu_index 0, reason 2
  [120139751 137.127293] kvm_run_exit: cpu_index 0, reason 2

 I don't find particularly useful, so I don't think having that as the
normal behaviour would qualify as what you called proper integration.

Having a separate recorder command, OTOH, allows me to also do things
that are not possible with other trace back-ends, and presumably never will
be, like:

    recorder trace kvm_run_exit=3Dcpu,reason

That configures things so that I can now do real-time graphing using
recorder-scope. The only output from qemu will be:

  Creating new /tmp/recorder_share

But I can now run somewhere else:

   recorder_scope cpu reason

and have a real-time view of what is happening in my qemu. Not particularly
interesting with existing instrumentation, which was not designed for
graphing, but that's easily changed.

Another key feature I get from the new monitor command is

  recorder dump

Now the output will be something like (cut for brevity)

  [150261271 461.814366] lock: Locked state 2 for 0x55d842d66d18
  [150261272 461.814366] qemu_mutex_unlock: released mutex 0x55d842d66d18 (=
0x55d840d032c0:119)
  [150261273 461.814366] lock: Unkocked state 0 for 0x55d842d66d18
  [150261274 461.814367] lockcnt_fast_path_attempt: lockcnt 0x55d842b630ec =
fast path 0->4
  [150261275 461.814367] lockcnt_fast_path_success: lockcnt 0x55d842b630ec =
fast path 0->4 succeeded
  [150261276 461.814515] qemu_mutex_lock: waiting on mutex 0x55d842ded590 (=
0x55d840c63019:161)
  [150261277 461.814515] lock: Locking state 1 for 0x55d842ded590
  [150261278 461.814515] qemu_mutex_locked: taken mutex 0x55d842ded590 (0x5=
5d840c63019:161)
  [150261279 461.814515] lock: Locked state 2 for 0x55d842ded590
  [150261280 461.814517] object_class_dynamic_cast_assert: 0x55d842dea5e0->=
0x55d840cdfcc0 (0x55d840cdfcb1:114:0x55d840ce02a0)
  [150261281 461.814518] qemu_mutex_lock: waiting on mutex 0x55d842db27b8 (=
0x55d840cdfcb1:118)
  [150261282 461.814518] lock: Locking state 1 for 0x55d842db27b8
  [150261283 461.814518] qemu_mutex_locked: taken mutex 0x55d842db27b8 (0x5=
5d840cdfcb1:118)
  [150261284 461.814518] lock: Locked state 2 for 0x55d842db27b8
  [150261285 461.814518] object_dynamic_cast_assert: 0x55d842dea5e0->0x7f7f=
88f304d9 (0x7f7f88f304d0:1668:0x7f7f88f308c0)
  [150261286 461.814521] qemu_mutex_unlock: released mutex 0x55d842db27b8 (=
0x55d840cdfcb1:143)
  [150261287 461.814521] lock: Unkocked state 0 for 0x55d842db27b8
  [150261288 461.814523] qemu_mutex_unlock: released mutex 0x55d842ded590 (=
0x55d840c63019:172)
  [150261289 461.814523] lock: Unkocked state 0 for 0x55d842ded590
  [150261290 461.814524] monitor_suspend: mon 0x55d842ded530: 1
  [150261291 461.814525] handle_hmp_command: mon 0x55d842ded530 cmdline: 0x=
55d842e18d50
  [150261292 461.814537] recorder: Recorder dump

Of course, in general, you will probably want to focus on some particular
trace after an event happened, e.g.

  recorder dump qemu_mutex_unlock

which will get you:

  [150617808 508.134486] qemu_mutex_unlock: released mutex 0x55d842d66898 (=
0x55d840d032c0:119)
  [150617814 508.134487] qemu_mutex_unlock: released mutex 0x55d842d66918 (=
0x55d840d032c0:119)
  [150617820 508.134489] qemu_mutex_unlock: released mutex 0x55d842d66d18 (=
0x55d840d032c0:119)
  [150617822 508.134494] qemu_mutex_unlock: released mutex 0x55d841360500 (=
0x55d840b85f40:1790)
  [150617834 508.136546] qemu_mutex_unlock: released mutex 0x55d842d66d18 (=
0x55d840d032c0:119)
  [150617848 508.136630] qemu_mutex_unlock: released mutex 0x55d842db27b8 (=
0x55d840cdfcb1:143)
  [150617850 508.136631] qemu_mutex_unlock: released mutex 0x55d842ded590 (=
0x55d840c63019:172)

So as you can see, the usage pattern is IMO sufficiently different from the
existing tracing mechanism that slightly different commands and usage model=
s
may be warranted.

Does that interface make sense?


As an aside, if you have activated the recorder sharing mechanism by using
some "recorder_name=3Drecorder_field,recorder_field" option, then you can
remote-control some aspects of qemu as well using recorder_scope. For
example, instead of using the monitor, you can use:

  recorder_scope -c qemu_mutex_unlock

Or

  recorder_scope -c dump

>
> Integration need not mean implement the existing interface slavishly!
> Feel free to evolve it.  For instance, the QMP commands provide
> "case-sensitive glob", while you have full regexps.  You could extend
> the commands to also accept regexps.

Yes, as I have indicated in the cover letter, further integration is a topi=
c
of interest. This is likely to require some relatively "minor" changes like
the one you mentioned, as well as more significant ones.

What I want to avoid is shooting for some "lowest common denominator" by
constraining the recorder library to just tracing. If this was just
functionally equivalent to the log trace backend, the recorder trace backen=
d
would add very little value and not be worth integrating.

>
> We can talk about leaving gaps for later.
>
> I recommend to start with QMP.

Does the existing qmp integration work for you, or do you have suggestions
for reworking it?

>
> [...]


--
Cheers,
Christophe de Dinechin (IRC c3d)


