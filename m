Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A64C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 12:37:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81B5420829
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 12:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D0c1kvoV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81B5420829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k17oR-0008NX-Rg
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 08:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k17nq-0007wz-1b
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 08:36:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27986
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k17nn-00076d-Fy
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 08:36:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596112609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MVINQ4U00qUSX5sWafsKfFcXCNRmGfs4kwSMkfPQqL8=;
 b=D0c1kvoVkuJrrAazvJNDGq0WD4Qo5Lo4+5ZhefydON/FJIJ+gR9Ynw9wEM2MuCGWOdWTjX
 aM8TqFWj/jA59021xj2s4WBLMhL0whESVNMoo3VZNTeb+XnFV7dpCD9VECYWodX5pYJ1VJ
 6O2YcSA20KiW5+3JNJgPqc41aogh0w4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-dS_U46YmOdOtSLDDS3k0Kg-1; Thu, 30 Jul 2020 08:36:48 -0400
X-MC-Unique: dS_U46YmOdOtSLDDS3k0Kg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FB3F1005504;
 Thu, 30 Jul 2020 12:36:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C83E319D9E;
 Thu, 30 Jul 2020 12:36:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4D1B81132FD2; Thu, 30 Jul 2020 14:36:45 +0200 (CEST)
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
 <87sgd91fsa.fsf@dusky.pond.sub.org>
 <0d7a9407-1df6-0c9b-0695-2f438f0de129@redhat.com>
Date: Thu, 30 Jul 2020 14:36:45 +0200
In-Reply-To: <0d7a9407-1df6-0c9b-0695-2f438f0de129@redhat.com> (Paolo
 Bonzini's message of "Thu, 30 Jul 2020 13:09:58 +0200")
Message-ID: <87zh7hxjqa.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 23:51:30
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Pratik Parvati <pratikp@vayavyalabs.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 30/07/20 12:03, Markus Armbruster wrote:
>> qdev C layer:
>> 
>>     frob->prop = 42;
>> 
>> Least cognitive load.
>> 
>> QOM has no C layer.
>
> Not really, a QOM object is totally free to do frob->prop = 42.  And
> just like we didn't do that outside device implementation in qdev as our
> tithe to the Church of Information Hiding; the same applies to QOM.

I screwed up the part of my argument that actually has a hope to be
valid, let me try again.

With qdev, you can always do frob->prop = 42, because properties are
always backed by a struct member.

With QOM, properties are built around visitor-based getters and setters.
This means you can always do (but never actually would do) something
like

    fortytwo = qnum_from_int(42);
    v = qobject_input_visitor_new(fortytwo);
    set_prop(OBJECT(frob), v, "prop", cookie, &err);
    visit_free(v);
    qobject_unref(fortytwo);

where set_prop() is the setter you passed to object_property_add(), and
@cookie is the opaque value you passed along with it.

*Maybe* set_prop() wraps around a simpler setter you can call directly,
or even a struct member you can set directy.  QOM does not care.

And that's my point: QOM does not care for the C layer.

>> qdev property layer works even when @frob has incomplete type:
>> 
>>     qdev_prop_set_int32(DEVICE(frob), "prop", 42);
>> 
>> This used to map property name to struct offset & copy the value.
>> Simple, stupid.
>> 
>> Nowadays, it is the same as
>> 
>>     object_property_set_int(OBJECT(frob), "frob", 42, &error_abort);
>> 
>> which first converts the int to a QObject, then uses a QObject input
>> visitor with a virtual walk to convert it back to int and store it in
>> @frob.  It's quite a sight in the debugger.
>
> Yes, but thatt's just because we never bothered to create single-type
> visitors.  For a good reason though: I don't think the extra QAPI code
> is worth (not even that much) nicer backtraces when we already have a
> QObject as a battle-tested variant type.
>
>> qdev "text" layer is really a QemuOpts layer (because that's what we had
>> back then).  If we have prop=42 in a QemuOpts, it calls
>> 
>>     set_property("prop", "42", frob, &err);
>> 
>> Nowadays, this is a thin wrapper around object_property_parse(),
>> basically
>> 
>>     object_property_parse(frob, "prop", 42, &err);
>> 
>> Fine print: except set_property() does nothing for @prop "driver" and
>> "bus", which look just like properties in -device / device-add, but
>> aren't.
>
> Ugly indeed.  They should be special cased up in the caller, probably,
> or use the long-discussed "remainder" feature of the QAPI schema.

qdev_device_add() is still stuck in the QemuOpts age.

>> object_property_parse() uses the string input visitor, which I loathe.
>
> Apart from the list syntax, the string input visitor is decent I think.

It's a death trap:

/*
 * The string input visitor does not implement support for visiting
 * QAPI structs, alternates, null, or arbitrary QTypes. Only flat lists
 * of integers (except type "size") are supported.
 */

"Does not implement support for visiting" is polite language for
"crashes when you dare to visit".

>>>> I've long had the nagging feeling that if we had special-cased
>>>> containers, children and links, we could have made a QOM that was easier
>>>> to reason about, and much easier to integrate with a QAPI schema.
>>>
>>> That's at least plausible.  But I have a nagging feeling that it would
>>> only cover 99% of what we're doing with QOM. :)
>> 
>> The question is whether that 1% really should be done the way it is done
>> :)
>
> And that's a very fair question, but it implies non-trivial design work,
> so the smiley changes to a frown. :(

True!


