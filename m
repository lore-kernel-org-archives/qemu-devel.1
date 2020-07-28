Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F48C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 07:20:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91CDD207F5
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 07:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DDct2mh5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91CDD207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0JuW-0005Jz-Rh
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 03:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k0Jth-0004sN-8m
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 03:19:37 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55835
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k0Jtf-0000Tu-Jm
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 03:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595920773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=etsKp6eUHvowZpjko+WHii8IkNFTldq5c81krElRdoU=;
 b=DDct2mh5OJ6oGrpf9vYz1N30ERI0ZrTQU9g0XWnPO9voh0V2lwF931+Ta72qotEbR3cCba
 +NkbePJG5wafhKWfsSaxGvJ6FaaW5CqaK0PGzorW+M3z9QTZzrjZKbu8xNGqDIVY/oPj12
 eOdLzEjmc/A5Ub13bHiHG76l2IkIEGw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-WYehxzBXMGiaRgiYBGYhPw-1; Tue, 28 Jul 2020 03:19:31 -0400
X-MC-Unique: WYehxzBXMGiaRgiYBGYhPw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC9D458;
 Tue, 28 Jul 2020 07:19:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 68C8019C66;
 Tue, 28 Jul 2020 07:19:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E290F1132FD2; Tue, 28 Jul 2020 09:19:28 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: sysbus_create_simple Vs qdev_create
References: <CA+aXn+EkkyiXmKpNhbggy0pjKVpiHxa+TUqEnZLB4v_D=T+7tA@mail.gmail.com>
 <CA+aXn+HHXAmT6Ljj2tpovGAYSurHKSdtUL3y-89t31B0e7jpsA@mail.gmail.com>
 <adb25c78-2edc-115a-5264-ca9f97864ec7@redhat.com>
 <87365t18mp.fsf@dusky.pond.sub.org>
 <CA+aXn+Guvt34PDD=N3FsD5w1C-aDXZ7gS8H_AZN-JEM8j8wBiQ@mail.gmail.com>
 <87lfjkvo81.fsf@dusky.pond.sub.org>
 <20200716222130.GO1274972@habkost.net>
 <87tuy6k9pa.fsf@dusky.pond.sub.org>
 <20200717162312.GR1274972@habkost.net>
 <87r1t6hc0f.fsf@dusky.pond.sub.org>
 <20200720155955.GV1274972@habkost.net>
 <87v9ihbe6u.fsf@dusky.pond.sub.org>
 <50e31ece-215c-a632-e5a2-86ae7ab3abab@redhat.com>
Date: Tue, 28 Jul 2020 09:19:28 +0200
In-Reply-To: <50e31ece-215c-a632-e5a2-86ae7ab3abab@redhat.com> (Paolo
 Bonzini's message of "Mon, 27 Jul 2020 16:29:43 +0200")
Message-ID: <87lfj4f6nz.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 00:06:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: "Daniel P. =?utf-8?Q?Berrang?= =?utf-8?Q?=C3=A9?=" <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Dau?= =?utf-8?Q?d=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Pratik Parvati <pratikp@vayavyalabs.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 21/07/20 08:00, Markus Armbruster wrote:
>>> They are already mirrored as links, and guess what's the link
>>> name: "child[...]".
>> You're right, except for the link name: it's parent_bus.
>
> There's links in both directions.
>
>> So the qtree is actually embedded in the QOM graph: it's the device and
>> bus nodes connected by the child edges from device to provided bus and
>> parent_bus link egdes from device to bus it's plugged into, except the
>> latter are backward rather than forward.
>> 
>> Strange: even bus-less devices have this parent_bus link, and its value
>> is "" (the underlying pointer is null, and null gets mapped to "", for
>> better or worse).
>> 
>> Should the property be limited to devices that actually have a parent
>> bus?
>
> Yes, it could be done.
>
>>>> I don't know why the rebase of qdev onto QOM was done that way.  Perhaps
>>>> Paolo remembers.
>>> I'm guessing this is because QOM parent/child relationships
>>> represent ownership, while there's no ownership relationship
>>> between buses and devices.
>>
>> Plausible.  I guess the separate qtree was kept even though it's
>> redundant with the QOM graph because switching its users to the QOM
>> graph would be work.
>
> No, it was kept because:
>
> 1) the QOM graph wasn't embedding the qdev tree at the time.  That was
> added later.
>
> 2) the composition tree generally mirrors things that are born and die
> at the same time, and creating children is generally reserved to the
> object itself.

Yes.  Notable exceptions: containers /machine/peripheral,
/machine/peripheral-anon, /machine/unattached.

>                 Children are usually embedded directly in a struct, for
> example.

We sometimes use object_new() + object_property_add_child() instead.
Extra indirection.  I guess we'd be better off without the extra
indirection most of the time.  Implementation detail.

We sometimes use object_new() without object_property_add_child(), and
have qdev_realize() put the device in the /machine/unattached orphanage.
Meh.  I guess the orphanage feature exists to make conversion to QOM
slightly easier.  Could we ban its use for new boards at least?

>           Instead, peripherals are not created by the bus, they are
> created by the device_add monitor command and the like.

Plugged devices (the ones created with -device / device_add) have
/machine/peripheral or /machine/peripheral-anon as QOM parent.

> 3) accessing the QOM graph is slow (it requires hash table lookups,
> string comparisons and all that), so the pointers that cache the
> parent-child links are needed for use in hot paths.

True, but only because QOM's design opts for generality, efficiency be
damned :)

The QOM graph's edges are properties.

The child edges form the QOM composition tree.  The property contains
the child in ObjectProperty member @opaque.  To go from parent to child,
you have to get the property by name (hash table lookup), then follow
@opaque.  Except that would be too simple (and way too efficient), so we
convert pointers to QOM path names and back with visitors for accessing
a single child, or iterate over all properties (hash table iteration)
for accessing all children.

There is also a pointer from child back to parent, which is not a
property.  That one is actually fast and easy to use from C.

The remaining QOM graph edges are link edges.  Compared to child edges,
there's a further indirection through the LinkProperty struct, and no
support for iterating over link edge targets.

This design supports adding arbitrary children and links at run time,
with the actual object none the wiser.

A less general and more efficient design would put pointers right into
the objects' structs, then wrap what we call class properties around the
pointers.  C code for specific objects could then simply follow the
pointers.  Generic code could still use properties.  If efficiency
matters there, we could avoid the detour through path names.

Properties backed by a (pointer-valued) struct member are less general,
of course: you can't add this kind of property without first adding the
struct member.  The property needs to be declared at compile time rather
than built at run time.

I never quite understood why we need to build properties at run time.
It's makes reasoning about properties harder, and introspection brittle.


