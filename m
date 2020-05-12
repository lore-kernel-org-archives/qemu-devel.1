Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40ED0CA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:59:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F12C02054F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XZYPIrNC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F12C02054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYXJj-0008I0-4w
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 11:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jYXIr-0007GQ-Qf
 for qemu-devel@nongnu.org; Tue, 12 May 2020 11:58:45 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42358
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jYXIq-0003aA-UC
 for qemu-devel@nongnu.org; Tue, 12 May 2020 11:58:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589299123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jvnz7FX33H6HQ6Cb1lKhjYigd52Yp7dFl7bV/HpbkeA=;
 b=XZYPIrNCYGAKX1yIMPlMursakIIs6bOCuV0nZfQ6nlvvJ0uUWFByNKhkwol6h/HYjLfJNs
 kjAovxkndCJO75I6vXw39MzW8VRDAyUCMTLx4CW8j2+m8ImH7BJQGo7lI2JlmTLQck4EAD
 xSOTWVA2ODHMGCGZAYeDHYjPEwlB5QI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-SnIlkeh5Msmtrbxsj3yW1w-1; Tue, 12 May 2020 11:58:41 -0400
X-MC-Unique: SnIlkeh5Msmtrbxsj3yW1w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F9148005B7
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 15:58:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6CD665C1B2;
 Tue, 12 May 2020 15:58:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EFA4F11358BC; Tue, 12 May 2020 17:58:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Infinite loop in bus_unparent(), qdev bug or qdev misuse?
References: <87tv0vzrwj.fsf@dusky.pond.sub.org>
 <6fc8633a-6d91-b83a-e6cd-5f714ccaf9ea@redhat.com>
 <875zda8j3m.fsf@dusky.pond.sub.org>
 <a4df3ba3-4759-56ac-68f8-f75eea93e27e@redhat.com>
 <87zhal4lef.fsf@dusky.pond.sub.org>
Date: Tue, 12 May 2020 17:58:38 +0200
In-Reply-To: <87zhal4lef.fsf@dusky.pond.sub.org> (Markus Armbruster's message
 of "Wed, 06 May 2020 08:39:36 +0200")
Message-ID: <87o8qttaa9.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 01:41:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> writes:

> Paolo Bonzini <pbonzini@redhat.com> writes:
>
>> On 05/05/20 18:03, Markus Armbruster wrote:
>>>> That's a good one, and especially a safe one, since it matches
>>>> qdev_device_add.  It has the disadvantage of having to touch all
>>>> qdev_create() calls.
>>> 
>>> Also, it moves onboard devices from /machine/unattached/ to
>>> /machine/peripheral-anon/.
>>
>> Uh indeed.  No that's too ugly.
>>
>>>> Even better however would be to move the bus argument (and thus
>>>> qdev_set_parent_bus) to qdev_init, and likewise in qdev_device_add move
>>>> qdev_set_id after qemu_opt_foreach.  I looked at the property setters
>>>> and couldn't find anything suspicious (somewhat to my surprise), but I
>>>> haven't honestly tried.
>>> 
>>> Thus, we satisfy bus_unparent()'s precondition "bus children have a QOM
>>> parent"[*] by moving "add to parent bus" next to the place where we
>>> ensure "has QOM parent" by putting orphans under /machine/unattached/.
>>> Makes sense.
>>> 
>>> If we add to the bus first, the precondition ceases to hold until we
>>> realize.  Ugly, but harmless unless we manage to actually call the
>>> function then.
>>
>> Shouldn't be a big deal, since users should call either qdev_set_id or
>> object_property_add_child before device_set_realized.
>
> The issue isn't neglecting to set a QOM parent, it's destroying a device
> before its bus children get their QOM parent.
>
> Mostly harmless: by delaying "add to bus" until right before realize, we
> narrow the window where the trap is armed, and keep it completely within
> qdev_init_nofail(), qdev_device_add(), and possibly code that duplicates
> their work.  Ensuring qdev_init_nofail() and qdev_device_add() don't
> fail in this window should be easy enough (except for writing the
> comment explaining it).  The duplicates, though... I guess we need to
> double-check users of qdev_set_parent_bus().
>
> Ugly: yes, compared to the pretty invariant "bus children all have QOM
> parents".
>
>>> I suspect we can't realize first, because the realize method may want to
>>> use the parent bus.
>>
>> Right.
>>
>> Moving the bus to qdev_init would be quite large but hopefully scriptable.
>
> Feels feasible.

Look, a rabbit hole :)

I got rough patches, with several more to do.

There's one thing worth mentioning.  Unrealize is recursive: unrealizing
a qdev recurses into its qbuses, and unrealizing a qbus recurses into
its qdevs.  Realize, however, is TODO recursive :)  See your commit
5942a19040 "qdev: recursively unrealize devices when unrealizing bus",
2014-06-19.

Moving "put on qbus" from qdev_create() (and its wrappers) to
qdev_init_nofail() means we put on bus by realizing.  No use to
recursive realization then,

> [*] We might want to look into deduplicating: the string "realized"
> occurs more than 450 times, and I figure almost always as property name.

I wield a sharp hatchet.


