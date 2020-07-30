Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE54C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 10:03:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D9D0206F5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 10:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aBknsmAc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D9D0206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k15Pi-0004bE-Al
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 06:03:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k15P6-0004Br-V5
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 06:03:13 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22522
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k15P3-00023p-VN
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 06:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596103388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C0vuhEHlLFczNTcXv5VaQdz4cjcuoSixLx72FdCdiyg=;
 b=aBknsmAcKwJh6j1+lJ+GPKWSPnHwvIS/ZQ0Z1djD3oUzPN+R0GrXu7zWqe3FIeE3cc1Tyn
 olPSV5AK+C9oykiJRXuvrKFdCYuBaerY9aq7+wHU4HYpMlh2OouiyI+9C+/3wPrJRsXLU5
 wTjdQXkRJiUC3ZS7acV1M1JTXzyrzfI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-Cqn_dxmWM2mogBhyq46kOA-1; Thu, 30 Jul 2020 06:03:05 -0400
X-MC-Unique: Cqn_dxmWM2mogBhyq46kOA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00B8D107ACCA;
 Thu, 30 Jul 2020 10:03:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9898E5F7D8;
 Thu, 30 Jul 2020 10:03:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 10F281132FD2; Thu, 30 Jul 2020 12:03:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: sysbus_create_simple Vs qdev_create
References: <87lfjkvo81.fsf@dusky.pond.sub.org>
 <20200716222130.GO1274972@habkost.net>
 <87tuy6k9pa.fsf@dusky.pond.sub.org>
 <20200717162312.GR1274972@habkost.net>
 <87r1t6hc0f.fsf@dusky.pond.sub.org>
 <20200720155955.GV1274972@habkost.net>
 <87v9ihbe6u.fsf@dusky.pond.sub.org>
 <50e31ece-215c-a632-e5a2-86ae7ab3abab@redhat.com>
 <87lfj4f6nz.fsf@dusky.pond.sub.org>
 <759959d1-f320-734a-ac5e-a60db6b1bc23@redhat.com>
 <20200728224733.GP225270@habkost.net>
 <422d7879-3fdc-d38e-259f-2477b9d3c169@redhat.com>
 <87zh7i5uj5.fsf@dusky.pond.sub.org>
 <6ee49ad2-8b6b-cb6f-c3c9-b440631cfc75@redhat.com>
Date: Thu, 30 Jul 2020 12:03:01 +0200
In-Reply-To: <6ee49ad2-8b6b-cb6f-c3c9-b440631cfc75@redhat.com> (Paolo
 Bonzini's message of "Wed, 29 Jul 2020 18:08:17 +0200")
Message-ID: <87sgd91fsa.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 03:51:24
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
Cc: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Pratik Parvati <pratikp@vayavyalabs.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 29/07/20 15:18, Markus Armbruster wrote:
>>> Even code riddled by backwards-compatibility special cases, such as
>>> -accel and -machine, can share code between themselves and -object to
>>> some extent; this is thanks to functions such as object_property_parse,
>>> whose parsing is deferred to visitors and hence to QAPI.
>>
>> QOM relies on QAPI visitors to access properties.  There is no
>> integration with the QAPI schema.
>
> Indeed it doesn't use _all_ of the QAPI goodies.  It does use visitors
> and it's a major feature of QOM.

No argument.

>> Going through a visitor enables property access from QMP, HMP and CLI.
>> 
>> Access from C *also* goes through a visitor.  We typically go from C
>> type to QObject and back.  Comically inefficient (which hardly matters),
>> verbose to use and somewhat hard to understand (which does).
>
> It's verbose in the getters/setters, but we have wrappers such as
> object_property_set_str, object_property_set_bool etc. that do not make
> it too hard to understand.

qdev C layer:

    frob->prop = 42;

Least cognitive load.

QOM has no C layer.

qdev property layer works even when @frob has incomplete type:

    qdev_prop_set_int32(DEVICE(frob), "prop", 42);

This used to map property name to struct offset & copy the value.
Simple, stupid.

Nowadays, it is the same as

    object_property_set_int(OBJECT(frob), "frob", 42, &error_abort);

which first converts the int to a QObject, then uses a QObject input
visitor with a virtual walk to convert it back to int and store it in
@frob.  It's quite a sight in the debugger.

qdev "text" layer is really a QemuOpts layer (because that's what we had
back then).  If we have prop=42 in a QemuOpts, it calls

    set_property("prop", "42", frob, &err);

Nowadays, this is a thin wrapper around object_property_parse(),
basically

    object_property_parse(frob, "prop", 42, &err);

Fine print: except set_property() does nothing for @prop "driver" and
"bus", which look just like properties in -device / device-add, but
aren't.

object_property_parse() uses the string input visitor, which I loathe.

>> Compare to what QOM replaced: qdev.  Properties are a layer on top of
>> ordinary C.  From C, you can either use the C layer (struct members,
>> basically), or the property layer for C (functions taking C types, no
>> conversion to string and back under the hood), or the "text" layer
>> (parse from text / format to text).
>> 
>> My point is not that qdev was great and QOM is terrible.  There are
>> reasons we replaced qdev with QOM.  My point is QOM doesn't *have* to be
>> the way it is.  It is the way it is because we made it so.
>
> QOM didn't only replace qdev: it also removed the need to have a command
> line option du jour for any new concept, e.g. all the TLS stuff, RNG
> backends, RAM backends, etc.

Yes.  There are good reasons for QOM.

> It didn't succeed (at all) in deprecating chardev/netdev/device etc.,
> but this is a very underappreciated part of QOM, and this is why I think
> it's appropriate to say QOM is "C with classes and CLI/RPC
> serialization", as opposed for example to "C with classes and multi
> programming language interface" that is GObject.

That's fair.

>> I've long had the nagging feeling that if we had special-cased
>> containers, children and links, we could have made a QOM that was easier
>> to reason about, and much easier to integrate with a QAPI schema.
>
> That's at least plausible.  But I have a nagging feeling that it would
> only cover 99% of what we're doing with QOM. :)

The question is whether that 1% really should be done the way it is done
:)


