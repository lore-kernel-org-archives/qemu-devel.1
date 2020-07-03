Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12589C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 10:16:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D189D20720
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 10:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dQQYEjeR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D189D20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrIkB-0003gF-2J
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 06:16:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jrIgF-0005Lx-0w
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 06:12:27 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48924
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jrIgC-00071B-W9
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 06:12:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593771143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0TrP3ssKKFIZoS+4N/flBtS06O8OncHtt88NIx4qZeI=;
 b=dQQYEjeRZPuRkZhY9dTM+08sGPkG6OSxBEu5XjePBzhR4QR4XT39rqK5Bd69mCtMzB3zHH
 nOCZ3BLeTPKpEFu9pEEKJBTHyUlmD6PnZpsRJfWe4CeS6mrx+F11pJfOnwxBTDm62P5nlk
 q/tHpW3vVlzKuI200ovP6/Yi2t0a+mY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-AdXJqLdBNZ6ds4_AK62ocQ-1; Fri, 03 Jul 2020 06:12:20 -0400
X-MC-Unique: AdXJqLdBNZ6ds4_AK62ocQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D898B1005510;
 Fri,  3 Jul 2020 10:12:17 +0000 (UTC)
Received: from titinator (ovpn-113-254.ams2.redhat.com [10.36.113.254])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C60E7610C;
 Fri,  3 Jul 2020 10:12:15 +0000 (UTC)
References: <20200626162706.3304357-1-dinechin@redhat.com>
 <20200626162706.3304357-4-dinechin@redhat.com>
 <20200630124136.GM1370404@redhat.com>
 <20200701160906.GT126613@stefanha-x1.localdomain>
 <20200701161501.GJ1427561@redhat.com>
 <20200702134713.GH152912@stefanha-x1.localdomain>
User-agent: mu4e 1.5.2; emacs 26.3
From: Christophe de Dinechin <dinechin@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 3/3] trace: Example of "centralized" recorder tracing
In-reply-to: <20200702134713.GH152912@stefanha-x1.localdomain>
Message-ID: <lywo3kc3gh.fsf@redhat.com>
Date: Fri, 03 Jul 2020 12:12:14 +0200
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dinechin@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dinechin@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 03:17:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Markus Armbruster <armbru@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020-07-02 at 15:47 CEST, Stefan Hajnoczi wrote...
> On Wed, Jul 01, 2020 at 05:15:01PM +0100, Daniel P. Berrang=C3=A9 wrote:
>> On Wed, Jul 01, 2020 at 05:09:06PM +0100, Stefan Hajnoczi wrote:
>> > On Tue, Jun 30, 2020 at 01:41:36PM +0100, Daniel P. Berrang=C3=A9 wrot=
e:
>> > > On Fri, Jun 26, 2020 at 06:27:06PM +0200, Christophe de Dinechin wro=
te:
>> > > IMHO the whole point of having the pluggable trace backend impls, is
>> > > precisely that we don't have to add multiple different calls in the
>> > > code. A single trace_qemu_mutex_unlock() is supposed to work with
>> > > any backend.
>> >
>> > I think an exception is okay when the other trace backends do not offe=
r
>> > equivalent functionality.
>> >
>> > Who knows if anyone other than Christophe will use this functionality,
>> > but it doesn't cost much to allow it.
>>
>> This patch is just an example though, suggesting this kind of usage is
>> expected to done in other current trace probe locations. The trace wrapp=
er
>> has most of the information required already including a format string,
>> so I'd think it could be wired up to the generator so we don't add extra
>> record() statements through the codebase.

The primary purpose of the recorder is post-mortem dumps, flight recorder
style. Tracing is only a secondary benefit. Not sure if it's worth making a
distinction between events you want to record and those you want to trace.
(Example: You might want to record all command line options, but almost
never trace them)

> At most it should require an
>> extra annotation in the trace-events file to take the extra parameter
>> for grouping, and other trace backends can ignore that.
>
> It's true, it may be possible to put this functionality in the
> trace-events.

Let me think more about integrating these features with other trace
backends. See below for short-term impact.

> Christophe: how does this differ from regular trace events and what
> extra information is needed?

- Grouping, as indicated above, mostly useful in practice to make selection
  of tracing topics easy (e.g. "modules") but also for real-time graphing,
  because typically a state change occurs in different functions, which is
  why I used locking as an example.

- Self-documentation. Right now, the recorder back-end generates rather
  unhelpful help messages.

- Trace buffer size. This is important to make post-mortem dumps usable if
  you record infrequent events alongside much higher-rate ones. For example=
,
  you may want a large buffer to record info about command-line option
  processing, the default 8 is definitely too small.

- Support for %+s, which tells that a string is safe to print later (e.g. i=
t
  is a compile-time constant, or never ever freed).

- Support for custom formats, e.g. I use %v in the XL compiler for LLVM
  value pointers. This is a bit more advanced, but it would be neat to be
  able to print out QOM objects using %q :-)

For the short term, what about providing trace-named wrappers around these
additional recorder features?

--
Cheers,
Christophe de Dinechin (IRC c3d)


