Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A71FC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 08:42:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 254F62070E
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 08:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JiI1mQFH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 254F62070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY4Wi-00036q-8H
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 03:42:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46948)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iY4VY-0002KP-I2
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 03:41:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iY4VU-0004Kx-VA
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 03:41:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32273
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iY4VU-0004KX-Ik
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 03:41:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574412095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KSjdyxaV2gRgkaPYSd3+D/cvskribw9Hcq62oNQoyYA=;
 b=JiI1mQFHf9wIWNEux1wMJJgKm0DzuKwqdjYd+C+UBDjGwyLFeCmm8ohiY+a2SaEKdQTSb6
 rpwocbx6n5z+nEUwGH7R998LJQtfUbqvLYcbnvx8B6hG8ZZQSTVe1xMvOsO54VcaJGax6t
 cZZ6leUN8z0uEpS850rtlUbOXzoTO+A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-f3AsZv-COjWx6jj0PSSXrg-1; Fri, 22 Nov 2019 03:41:32 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 131E38018A1;
 Fri, 22 Nov 2019 08:41:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F2F6C60141;
 Fri, 22 Nov 2019 08:41:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 60E4B1138606; Fri, 22 Nov 2019 09:41:21 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Christophe de Dinechin <dinechin@redhat.com>
Subject: Re: [Qemu-devel] [libvirt] [PATCH 2/2] qapi: deprecate implicit
 filters
References: <20190814100735.24234-1-vsementsov@virtuozzo.com>
 <20190814100735.24234-3-vsementsov@virtuozzo.com>
 <3eded188-0161-d494-194c-9d67da644eb1@redhat.com>
 <20190815104928.GC7415@linux.fritz.box>
 <20190815114553.GQ300@andariel.pipo.sk>
 <87d0h6zfrt.fsf@dusky.pond.sub.org> <m1lfvbex92.fsf@redhat.com>
Date: Fri, 22 Nov 2019 09:41:21 +0100
In-Reply-To: <m1lfvbex92.fsf@redhat.com> (Christophe de Dinechin's message of
 "Thu, 29 Aug 2019 18:45:29 +0200")
Message-ID: <87blt4s3pq.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: f3AsZv-COjWx6jj0PSSXrg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, libvir-list@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, den@openvz.org, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviving this old thread, because I'd like to connect it to more recent
discussions.

Christophe de Dinechin <dinechin@redhat.com> writes:

> Markus Armbruster writes:
>
>> Peter Krempa <pkrempa@redhat.com> writes:
>>
> [...]
>>> From my experience users report non-fatal messages mostly only if it is
>>> spamming the system log. One of instances are very unlikely to be
>>> noticed.
>>>
>>> In my experience it's better to notify us in libvirt of such change and
>>> we will try our best to fix it.
>>
>> How to best alert the layers above QEMU was one of the topic of the KVM
>> Forum 2018 BoF on deprecating stuff.  Minutes:
>>
>>     Message-ID: <87mur0ls8o.fsf@dusky.pond.sub.org>
>>     https://lists.nongnu.org/archive/html/qemu-devel/2018-10/msg05828.ht=
ml
>>
>> Relevant part:
>>
>> * We need to communicate "you're using something that is deprecated".
>>   How?  Right now, we print a deprecation message.  Okay when humans use
>>   QEMU directly in a shell.  However, when QEMU sits at the bottom of a
>>   software stack, the message will likely end up in a log file that is
>>   effectively write-only.
>>
>>   - The one way to get people read log files is crashing their
>>     application.  A command line option --future could make QEMU crash
>>     right after printing a deprecation message.  This could help with
>>     finding use of deprecated features in a testing environment.
>>
>>   - A less destructive way to grab people's attention is to make things
>>     run really, really slow: have QEMU go to sleep for a while after
>>     printing a deprecation message.
>>
>>   - We can also pass the buck to the next layer up: emit a QMP event.
>>
>>     Sadly, by the time the next layer connects to QMP, plenty of stuff
>>     already happened.  We'd have to buffer deprecation events somehow.
>>
>>     What would libvirt do with such an event?  Log it, taint the domain,
>>     emit a (libvirt) event to pass it on to the next layer up.
>>
>>   - A completely different idea is to have a configuratin linter.  To
>>     support doing this at the libvirt level, QEMU could expose "is
>>     deprecated" in interface introspection.  Feels feasible for QMP,
>>     where we already have sufficiently expressive introspection.  For
>>     CLI, we'd first have to provide that (but we want that anyway).
>>
>>   - We might also want to dispay deprecation messages in QEMU's GUI
>>     somehow, or on serial consoles.
>
> Sorry for catching up late, this mail thread happened during my PTO.
>
> I remember bringing up at the time [1] that the correct solution needs
> to take into account usage models that vary from
>
> - a workstation case, where displaying an error box is easy and
>   convenient,
>
> - to local headless VMs where system-level notification would do the job
>   better, allowing us to leverage things like system-wide email notificat=
ions
>
> - to large-scale collections of VMs managed by some layered product,
>   where the correct reporting would be through something like Insights,
>   i.e. you don't scan individual logs, you want something like "913 VMs
>   are using deprecated X"
>
> To me, that implies that we need to have a clear division of roles, with
> a standard way to
>
> a) produce the errors,
> b) propagate them,
> c) consume them (at least up to libvirt)
>
> Notice that this work has already been done for "real" errors,
> i.e. there is a real QAPI notion of "errors". AFAICT, warn_report does
> not connect to it, though, it goes through error_vprintf which is really
> just basic logging.
>
> So would it make sense to:
>
> 1. Add a deprecation_report() alongside warn_report()?

"Grepability" alone would make that worthwhile, I think.

> 2. Connect warn_report() and all the error_vprintf output to QAPI,
>    e.g. using John's suggestion of adding the messages using some
>    "warning" or "deprecated" tag?

This is the difficult part.  See my "Exposing feature deprecation to
machine clients (was: [Qemu-devel] [PATCH 2/2] qapi: deprecate implicit
filters)" in this thread.  Quote:

    Propagating errors is painful.  It has caused massive churn all over th=
e
    place.

    I don't think we can hitch deprecation info to the existing error
    propagation, since we need to take the success path back to the QMP
    core, not an error path.

    Propagating a second object for warnings... thanks, but no thanks.

    The QMP core could provide a function for recording deprecation info fo=
r
    the currently executing QMP command.  This is how we used to record
    errors in QMP commands, until Anthony rammed through what we have now.
    The commit messages (e.g. d5ec4f27c38) provide no justification.  I
    dimly recall adamant (oral?) claims that recording errors in the Monito=
r
    object cannot work for us.

    I smell a swamp.

    Can we avoid plumbing deprecation info from command code to QMP core?
    Only if the QMP core itself can recognize deprecated interfaces.  I
    believe it can for the cases we can expose in introspecion.  Let me
    explain.

    Kevin recently added "features" to the QAPI schema language.  The
    implementation is incomplete, but that's detail.  The idea is to tack a
    "deprecated" feature to deprecated stuff in the QAPI schema.

    Commands and arguments need to support features for that.
    Implementation should be relatively straightforward.

    Deprecating an argument's optionalness may require a
    "optional-deprecated" feature.  I've seen more elegant designs, but I'v=
e
    also seen plenty of uglier ones.

    Note that features are tied to schema syntax.  To express semantically
    conditional deprecation like "if you specify argument FOO, then not
    specifying argument BAR is deprecated", we'd have to add a language for
    these conditions.  Uh, not now, maybe never.

    The primary use of having deprecation defined in the QAPI schema is
    introspection.  The BoF minutes mention this, too.

    A secondary use could be detecting use of deprecated features right in
    the QMP core.  No need for ad hoc code in commands, no need for plumbin=
g
    information from there to the QMP core.

    I'd like to pursue this idea, then see how well it suits our deprecatio=
n
    needs.

I've since explored this idea in

    [RFC PATCH 00/19] Configurable policy for handling deprecated interface=
s
    Message-Id: <20191024123458.13505-1-armbru@redhat.com>
    https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg06534.html   =
=20

> 3. Teach libvirt how to consume that new tag and pass it along?

Pertinent:
Message-ID: <20191024140146.GC8381@redhat.com>
https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg06604.html

Quoting Dan's conclusion:

    In summary, it is probably reasonable to include this info in the QMP
    command reply, but don't expect much to be done with it beyond possibly
    writing it to a log file.

> [1] https://lists.nongnu.org/archive/html/qemu-devel/2018-10/msg06131.htm=
l
>
>
> --
> Cheers,
> Christophe de Dinechin (IRC c3d)


