Return-Path: <SRS0=t3yw=6Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4F9C3A5A9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 06:07:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECF172137B
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 06:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hlI8qw3+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECF172137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUlJ4-0007Mn-0l
	for qemu-devel@archiver.kernel.org; Sat, 02 May 2020 02:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jUlIO-0006N6-Gu
 for qemu-devel@nongnu.org; Sat, 02 May 2020 02:06:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jUlEv-0005DT-3U
 for qemu-devel@nongnu.org; Sat, 02 May 2020 02:06:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21794
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jUlEu-0005DM-M1
 for qemu-devel@nongnu.org; Sat, 02 May 2020 02:03:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588399383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/xoTNJ3k/HqkTYQk7gJBN/zKC/e3kYW2nnY5/KQcPaY=;
 b=hlI8qw3+O+ZPcBXAZYGpXUsst5MWhgmYHZmGC8MqYXWJZdvDO2dg6tOXXZpoSgtCY0sJE3
 Ji/aqMw0A++JXflqxRxDqiUqR2CTPdHcsy0QVdoGmPEair+gihRQzaf5wQPMwst5NwDjX+
 thXiJnSVoewHAzZnsLo7Wngpbcr3Dqg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-zZVFs2zbNYa6TU58QXJL1A-1; Sat, 02 May 2020 02:02:46 -0400
X-MC-Unique: zZVFs2zbNYa6TU58QXJL1A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40C9F19200C0;
 Sat,  2 May 2020 06:02:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B52405C1BE;
 Sat,  2 May 2020 06:02:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2F40F11358BC; Sat,  2 May 2020 08:02:43 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Subject: Re: [RFC PATCH] qom: Implement qom-get HMP command
References: <20200407114449.482532-1-clg@kaod.org>
Date: Sat, 02 May 2020 08:02:43 +0200
In-Reply-To: <20200407114449.482532-1-clg@kaod.org> (=?utf-8?Q?=22C=C3=A9d?=
 =?utf-8?Q?ric?= Le Goater"'s
 message of "Tue, 7 Apr 2020 13:44:49 +0200")
Message-ID: <87a72q6fi4.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/02 02:03:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: "Daniel P . =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

C=C3=A9dric Le Goater <clg@kaod.org> writes:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Reimplement it based on qmp_qom_get() to avoid converting QObjects back
> to strings.
>
> Inspired-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>
>
> Slight fix for bit-rot:
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> [clg: updates for QEMU 5.0 ]
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>
>  I would like to restart the discussion on qom-get command to understand
>  what was the conclusion and see if things have changed since.

I've since learned more about QOM.  I believe we should do HMP qom-get,
but not quite like this patch does.  Let me explain.

A QOM property has ->get() and ->set() methods to expose the property
via the Visitor interface.

->get() works with an output visitor.  With the QObject output visitor,
you can get the property value as a QObject.  QMP qom-get uses this.
With the string output visitor, you can get it as a string.  Your
proposed HMP qom-get uses this.

->set() works with an input visitor.  With the QObject input visitor,
you can set the property value from a QObject.  QMP qom-set uses this.
With the string input visitor, you can set it from a string.  HMP
qom-set uses this.  With the options visitor, you can set it from a
QemuOpts.  CLI -object uses this.

The Visitor interface supports arbitrary QAPI types.  The ->get() and
->set() methods can use them all.

Some visitors, howerver, carry restrictions:

 * The string output visitor does not implement support for visiting
 * QAPI structs, alternates, null, or arbitrary QTypes.  It also
 * requires a non-null list argument to visit_start_list().

 * The string input visitor does not implement support for visiting
 * QAPI structs, alternates, null, or arbitrary QTypes. Only flat lists
 * of integers (except type "size") are supported.

 * The Opts input visitor does not implement support for visiting QAPI
 * alternates, numbers (other than integers), null, or arbitrary
 * QTypes.  It also requires a non-null list argument to
 * visit_start_list().

If you try to qom-set a property whose ->set() uses something the string
input visitor doesn't support, QEMU crashes.  Same for -object, and your
proposed qom-get.

I'm not aware of such a ->set(), but this is a death trap all the same.

The obvious way to disarm it is removing the restrictions.

One small step we took towards that goal is visible in the comments
above: support for flat lists of integers.  The code for that will make
your eyes bleed.  It's been a thorn in my side ever since I inherited
QAPI.  Perhaps it could be done better.  But there's a reason why it
should not be done at all: it's language design.

The QObject visitors translate between QAPI types and our internal
representation of JSON.  The JSON parser and formatter complete the
translation to and from JSON.  Sensible enough.

The string visitors translate between QAPI and ...  well, a barely
documented language of our own "design".  Tolerable when the language it
limited to numbers, booleans and strings.  Foolish when it grows into
something isomorphic to JSON.

This is a dead end.

Can we still implement a safe and tolerably useful HMP qom-get and
qom-set?  I think we can.  Remember the basic rule of HMP command
implementation: wrap around the QMP command.  So let's try that.

hmp_qom_get() calls qmp_qom_get() and formats the resulting QObject with
qobject_to_json_pretty().

hmp_qom_get() parses the value with qobject_from_json(), and feeds the
resulting QObject to qmp_qom_set().  To avoid interference with the HMP
parser, we probably want argument type 'S'.

The two commands then parse / print JSON instead of the string visitors'
language.  Is that bad?

* Integers: qom-set loses support for hexadecimal and octal.

* Bools: qom-set loses alternate spellings of true and false.

* Floating-point numbers: no change

* Strings: gain enclosing quotes.

* List of integers: gain enclosing square brackets.  qom-set loses
  support for ranges.

  The only use of lists I can find is memory-backend property
  host-nodes.

* Everything else: lose support for crashing QEMU.

  Again, I'm not aware of properties that crash now.

I think these changes are just fine.  If you disagree, you could try to
mitigate with convenience magic like "if it doesn't parse as JSON, and
it looks hexadecimal, convert to decimal and try again", or "looks kind
of stringy, enclose in double-quotes and try again".  Bad idea if you
ask me, but I'm not the HMP maintainer anymore.

Here's an idea I hate less.  Remember, since the opts visitor also has
restrictions, -object is also prone to crashing.  But that's an instance
of a problem we've thought about at some depth, and where we have a
plan: we intend to replace QemuOpts with QObject (which means we can
switch to the QObject visitors), and have CLI options take either JSON
or a relatively simple KEY=3DVALUE,... language similar to what QemuOpts
accepts now.

Yes, that's also a language of our own design, but it comes with a few
excuses:

0. It lets us avoid radical change of QEMU's CLI.

1. It's fairly simple.  It does not try to be isomorphic to JSON.  It
doesn't have to, because you can always fall back to JSON when things
get wonky.

2. It's documented.  So far only in util/keyval.c.  No good for users
there, but at least it demonstrates we know what language we're parsing
(modulo parser bugs).  More than what can be said for many ad hoc
languages...

We could use this for a friendlier qom-set.  I'm not sure it's worth the
trouble at this time.


