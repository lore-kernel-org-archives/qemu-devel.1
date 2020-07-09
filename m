Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E42C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 10:28:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53D46206DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 10:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A4lQoZYK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D46206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtTmo-0000Zm-CS
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 06:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jtTlI-0007PN-IG
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 06:26:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44192
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jtTlG-0007t8-Q4
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 06:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594290398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YVUmwIpi6E/o0zrJW5+RX9yLNddeMRRce0vWpNcqtOk=;
 b=A4lQoZYK5LV1BoFZ7LjGFjkzDfifipAv/PDWDbGYEF6R/3SAqp6JkgTMCBPmg7wJjm+cn+
 cDTockvOKm6Y0GZwN4gmrLTJOmE4mfIzjs2CwmdfI8iCcVfCyNO4SkKhQEYeHsj8bOOJMw
 1nWu2zdFU+uoB6UNFjBjAXVpfkpYo74=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-hYQjpS6eMsK3D3EiEWR6zQ-1; Thu, 09 Jul 2020 06:26:36 -0400
X-MC-Unique: hYQjpS6eMsK3D3EiEWR6zQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60BD5107BEF6;
 Thu,  9 Jul 2020 10:26:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A01060C80;
 Thu,  9 Jul 2020 10:26:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8A7981132FD2; Thu,  9 Jul 2020 12:26:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PULL 13/29] qapi: Flatten object-add
References: <20200306171458.1848-1-kwolf@redhat.com>
 <20200306171458.1848-14-kwolf@redhat.com>
 <7dc27dad-7797-dc2a-9456-2a7aaf9a4e5c@redhat.com>
 <20200708160555.GE4902@linux.fritz.box>
 <a5693a1e-e891-efd2-6e8a-1302b7ca3332@redhat.com>
Date: Thu, 09 Jul 2020 12:26:33 +0200
In-Reply-To: <a5693a1e-e891-efd2-6e8a-1302b7ca3332@redhat.com> (Paolo
 Bonzini's message of "Wed, 8 Jul 2020 18:12:38 +0200")
Message-ID: <87sge1t25i.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 01:47:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, peter.maydell@linaro.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 08/07/20 18:05, Kevin Wolf wrote:
>> Markus was going to introduce new QAPI schema syntax that would allow to
>> specify a few options explicitly and then one option for "the rest" that
>> would just be mapped to a QDict like "any" or "gen": false, and that
>> wouldn't require any nesting.
>
> Oh, I wasn't aware of that.  That would be something like 'properties':
> 'remainder' I guess.  That would be fine too.

Glad I'm spared a design argument ;)

>> I'm not sure if any progress was made there, but making things

Not yet; error handling ate me whole, and spit me out only the day
before yesterday or so.

>> consistent between device_add, netdev_add and object_add was a step in
>> this direction anyway.

Yes.

Permit me to digress.

We ran into the "and also arbitray properties" need repeatedly, and
tried several solutions over time.  QAPI/QMP is big, and the left hand
often wasn't too interested in what the right hand had been doing.

If memory and my git archaeology skills serve, the first instance was
device_add:

    3418bd25e1 "qdev hotplug: infrastructure and monitor commands."
    2009-10-05

Simple adaption of the QemuOpts-based -device for HMP.  Since QemuOpts
is flat, so is device_add.  QAPI didn't exist, yet.  A QMP version
followed:

    8bc27249f0 "monitor: convert do_device_add() to QObject"
    2010-03-16

Just as flat.

Next was netdev_add:

    ae82d3242d "monitor: New commands netdev_add, netdev_del"
    2010-04-18

Flat for the same reason.

When QAPI came along in

    ebffe2afce "Merge remote-tracking branch 'qmp/queue/qmp' into
    staging"
    2011-10-10

these two commands were left unQAPIfied, as the schema language could
not express "and also arbitrary properties".  Soon "solved" with a cop
out:

    5dbee474f3 "qapi: allow a 'gen' key to suppress code generation"
    2011-12-15

A half-hearted QAPIfication of netdev_add followed:

    928059a37b "qapi: convert netdev_add"
    2012-06-04

QAPI schema:

    { 'command': 'netdev_add',
      'data': {'type': 'str', 'id': 'str', '*props': '**'},
      'gen': 'no' }

Note the bogus type '**', which only works because 'gen': 'no' also
bypasses type checking (which you wouldn't guess from the commit
message, documentation, or even the schema).  In fact, the whole 'props'
thing is a lie: there is no such parameter, the command is as flat as it
ever was.  Fixed in

    b8a98326d5 "qapi-schema: Fix up misleading specification of
    netdev_add"
    2015-09-21

    { 'command': 'netdev_add',
      'data': {'type': 'str', 'id': 'str'},
      'gen': false }

but by then it had already spread to object-add, with an equally bogus
type 'dict':

    cff8b2c6fc "monitor: add object-add (QMP) and object_add (HMP)
    command"
    2014-01-06

    { 'command': 'object-add',
      'data': {'qom-type': 'str', 'id': 'str', '*props': 'dict'},
      'gen': 'no' }

Only 'props' was real this time: you really had to wrap the properties
in "props": { ... }.  Non-flat.  Meh.

Eventually, even device_add made it into the schema:

    94cfd07f26 "qapi-schema: add 'device_add'"
    2016-09-19

    { 'command': 'device_add',
      'data': {'driver': 'str', 'id': 'str'},
      'gen': false } # so we can get the additional arguments

And netdev_add was finally done right:

    db2a380c84 "net: Complete qapi-fication of netdev_add"
    2020-03-17

    { 'command': 'netdev_add', 'data': 'Netdev', 'boxed': true }

Doing device_add and object-add right is harder (impractical?), because
their schema would be a union with one branch per device / object type.

End of digression.

>>> As an aside, it would have been nice to run this through Markus and me,
>>> though in all fairness I'm not sure I would have been responsive back
>>> in February.
>> It went through my tree because of the other patches in the series, but
>> I wrote this patch specifically at Markus's request.

Yes.  We discussed how to best satisfy Kevin's immediate needs without
making other problems harder.  Perhaps we should have posted a summary
to the list.

>>> I would like to un-deprecate this for 5.1, and revert it in either 5.1
>>> or 5.2.  (Also I will be away next week, so the decision would have to
>>> be taken quickly).
>> Please discuss it with Markus then.


