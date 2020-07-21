Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E2BC433E6
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 06:01:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 637E0207DD
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 06:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T+ypNdvc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 637E0207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxlLR-0008Qv-IX
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 02:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jxlK5-0007XN-Is
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 02:00:17 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57619
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jxlK3-000897-5E
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 02:00:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595311213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3Te48weVWuC0XQ6RBGxvjRNCY3rXjKOanolc0Iw5ql0=;
 b=T+ypNdvcFLO6h5w+IEZWv1noaXn36m+nBUUY2wC76fk7OfPDcnYV4kU+0MTWkjJkuY2v1t
 qa1oQ038UUJsqvOC2/+DYDuU1V2JzSosiwKgEi+oXGr2lpSfOEzMp8m2nDkrZ6VmdMGeNU
 Qtpsv/TVdgHfTj1rUjVuzPuCQeIec0g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358--u32GA2mMQecdQVmBRA71A-1; Tue, 21 Jul 2020 02:00:12 -0400
X-MC-Unique: -u32GA2mMQecdQVmBRA71A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1BD821005510;
 Tue, 21 Jul 2020 06:00:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D851519C66;
 Tue, 21 Jul 2020 06:00:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5B20B111CA27; Tue, 21 Jul 2020 08:00:09 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
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
Date: Tue, 21 Jul 2020 08:00:09 +0200
In-Reply-To: <20200720155955.GV1274972@habkost.net> (Eduardo Habkost's message
 of "Mon, 20 Jul 2020 11:59:55 -0400")
Message-ID: <87v9ihbe6u.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 01:26:46
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang?= =?utf-8?Q?=C3=A9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, Pratik Parvati <pratikp@vayavyalabs.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Mon, Jul 20, 2020 at 09:38:24AM +0200, Markus Armbruster wrote:
>> Eduardo Habkost <ehabkost@redhat.com> writes:
>> 
>> > On Fri, Jul 17, 2020 at 07:10:57AM +0200, Markus Armbruster wrote:
>> >> Eduardo Habkost <ehabkost@redhat.com> writes:
>> >> 
>> >> > I'd also note that the use of "parent" in the code is also
>> >> > ambiguous.  It can mean:
>> >> >
>> >> > * QOM parent type, i.e. TypeInfo.parent.  Related fields:
>> >> >   * parent_class members of class structs
>> >> >   * parent_obj members of object structs
>> >> 
>> >> I hate the use of "parent" and "child" for a super- / subtype relation.
>> >> 
>> >> Correcting the terminology there would be short term pain for long term
>> >> gain.  Worthwhile?
>> >
>> > I don't know.  It looks like the terminology came from GObject.
>> >
>> >> 
>> >> > * QOM composition tree parent object, i.e. Object::parent
>> >> > * qdev device parent bus, i.e. DeviceState::parent_bus
>> >> > * parent device of of qdev bus, i.e. BusState::parent
>> >> 
>> >> These are tree relations.  Use of "parent" and "child" is perfectly
>> >> fine.
>> >
>> > The terms are fine but still ambiguous, as devices belong to two
>> > separate trees at the same time (the QOM composition tree, and
>> > the qdev tree).
>> >
>> > I never understood why we have two separate independent object
>> > trees.
>> 
>> When we rebased qdev onto QOM, we left the qdev tree alone, we did not
>> embed it into the QOM composition tree.
>> 
>> The qdev tree edge from bus to device providing the bus is commonly
>> mirrored in the QOM composition tree: both are QOM objects, and the bus
>> is commonly a QOM composition child of the device providing it.  I hedge
>> with "commonly", because nothing enforces this as far as I know.
>> 
>> We do not mirror the edge from device to the bus it's plugged into.  I
>> believe we could have.  I guess we could mirror it as a link even now
>> (but note links are not children).
>
> They are already mirrored as links, and guess what's the link
> name: "child[...]".

You're right, except for the link name: it's parent_bus.

So the qtree is actually embedded in the QOM graph: it's the device and
bus nodes connected by the child edges from device to provided bus and
parent_bus link egdes from device to bus it's plugged into, except the
latter are backward rather than forward.

Strange: even bus-less devices have this parent_bus link, and its value
is "" (the underlying pointer is null, and null gets mapped to "", for
better or worse).

Should the property be limited to devices that actually have a parent
bus?

>> I don't know why the rebase of qdev onto QOM was done that way.  Perhaps
>> Paolo remembers.
>
> I'm guessing this is because QOM parent/child relationships
> represent ownership, while there's no ownership relationship
> between buses and devices.

Plausible.  I guess the separate qtree was kept even though it's
redundant with the QOM graph because switching its users to the QOM
graph would be work.


