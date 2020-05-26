Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2802C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 05:15:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89523207D8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 05:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HhG2gXGx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89523207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdRvy-000272-O0
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 01:15:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jdRvO-0001gV-NN
 for qemu-devel@nongnu.org; Tue, 26 May 2020 01:14:50 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45417
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jdRvM-0007hO-WE
 for qemu-devel@nongnu.org; Tue, 26 May 2020 01:14:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590470087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IPMoPIzZHA6/KmvuoGuBB/vTk1uiT6AAuVSESomK3bU=;
 b=HhG2gXGx925WTfVbfjAioxFDsgmYBsoKNzsSKGATqEL4jGgiSScIcRrlQSxUIEtR7GEe3H
 eH49K0oqwyJErGUaAx0gYBq2bfmw8QDPeoSj9GEc7Lv76usS9+zHGKU5ay7TdBIMdM9H0G
 yo+hCXA7hwIvJarEENVGnBQVdr7e0yE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-ho2XKpOqOU-1LycDsLtHpQ-1; Tue, 26 May 2020 01:14:45 -0400
X-MC-Unique: ho2XKpOqOU-1LycDsLtHpQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3CD53835B40
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 05:14:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DA5CE10013D7;
 Tue, 26 May 2020 05:14:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4FC3C113864A; Tue, 26 May 2020 07:14:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 51/55] qdev: Make qdev_realize() support bus-less devices
References: <20200519145551.22836-1-armbru@redhat.com>
 <20200519145551.22836-52-armbru@redhat.com>
 <b0188311-e138-cf55-c0e9-52313b5aa906@redhat.com>
 <87lflmps2w.fsf@dusky.pond.sub.org>
 <1b43c6cb-ac47-1fcb-72b4-e96ae00141b1@redhat.com>
 <87mu5wfrj8.fsf@dusky.pond.sub.org>
 <a3b09578-c164-22a0-8a52-3a4bd5513ef2@redhat.com>
Date: Tue, 26 May 2020 07:14:42 +0200
In-Reply-To: <a3b09578-c164-22a0-8a52-3a4bd5513ef2@redhat.com> (Paolo
 Bonzini's message of "Mon, 25 May 2020 12:11:50 +0200")
Message-ID: <87y2pf9t19.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:14:47
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
Cc: berrange@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 25/05/20 08:38, Markus Armbruster wrote:
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>> 
>>> On 20/05/20 17:02, Markus Armbruster wrote:
>>>>>>
>>>>>> qdev_realize_and_unref() remains restricted, because its reference
>>>>>> counting would become rather confusing for bus-less devices.
>>>>> I think it would be fine, you would just rely on the reference held by
>>>>> the QOM parent (via the child property).
>>>> I took one look at the contract I wrote for it, and balked :)
>>>>
>>>> qdev_realize()'s contract before this patch:
>>>>
>>>>     /*
>>>>      * Realize @dev.
>>>>      * @dev must not be plugged into a bus.
>>>>      * Plug @dev into @bus.  This takes a reference to @dev.
>>>>      * If @dev has no QOM parent, make one up, taking another reference.
>>>>      * On success, return true.
>>>>      * On failure, store an error through @errp and return false.
>>>>      */
>>>>     bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp)
>>>>
>>>> Simple enough.
>>>>
>>>> This patch merely adds "If @bus, " before "plug".  Still simple enough.
>>>>
>>>> qdev_realize_and_unref()'s contract:
>>>>
>>>>     /*
>>>>      * Realize @dev and drop a reference.
>>>>      * This is like qdev_realize(), except it steals a reference rather
>>>>      * than take one to plug @dev into @bus.  On failure, it drops that
>>>>      * reference instead.  @bus must not be null.  Intended use:
>>>>      *     dev = qdev_new();
>>>>      *     [...]
>>>>      *     qdev_realize_and_unref(dev, bus, errp);
>>>>      * Now @dev can go away without further ado.
>>>>      */
>>>>     bool qdev_realize_and_unref(DeviceState *dev, BusState *bus, Error **errp)
>>>>
>>>> If @bus is null, who gets to hold the stolen reference?
>>>>
>>>> You seem to suggest the QOM parent.  What if @dev already has a parent?
>>>
>>> The caller would still hold the stolen reference, and it would be
>>> dropped.
>> 
>> I read this sentence three times, and still don't get it.  Is the
>> reference held or is it dropped?
>
> To call qdev_realize_and_unref, you need to have your own reference,
> which you probably got from qdev_new.
>
> The function might add one via object_property_add_child or it might
> not; it might add one via qdev_set_parent_bus or it might not.  But in
> any case, when it returns you won't have a reference anymore.
>
> One possibility is to think of it in terms of stealing the reference and
> passing it to the bus.  However, as in the lifetime phases that I posted
> earlier, once you realize a device you are no longer in charge of its
> lifetime.  Instead, the unparent callback will take care of unrealizing
> the device and dropping all outstanding long-living references.
>
> So...
>
>>> Or alternatively, ignore all the stolen references stuff, and merely see
>>> qdev_realize_and_unref as a shortcut for qdev_realize+object_unref,
>>> because it's a common idiom.
>> 
>> Even common idioms need to make sense :)
>
> ... that's why the common idiom makes sense.
>
>> The contract must specify exactly what happens to the reference count,
>> case by case.
>
> For both qdev_realize and qdev_realize_and_unref, on return the caller
> need not care about keeping alive the device in the long-term.
>
> For qdev_realize_and_unref, the caller must _also_ have a "private"
> reference to the object, which will be dropped on return.
>
> For qdev_realize, the caller _can_ have a private reference that it has
> to later drop at a convenient time, but it could also ensure that the
> device has a long-term reference via object->parent instead.

I need a contract.  The difficulty of writing a clear contract, caused
by a case that doesn't actually occur, is what made me limit null bus to
qdev_realize().  I admittedly didn't try hard.  Next try:

    /*
     * Realize @dev and drop a reference.
     * This is like qdev_realize(), except the caller must hold a
     * (private) reference, which is dropped on return regardless of
     * success or failure.  Intended use:
     *     dev = qdev_new();
     *     [...]
     *     qdev_realize_and_unref(dev, bus, errp);
     * Now @dev can go away without further ado.
     */

> Perhaps this tells us that the /machine/unattached automation actually
> shouldn't be moved to qdev_realize, but rather to
> qdev_realize_and_unref, and qdev_realize could assert that there is a
> parent already at the time of the call.  However it is probably too
> early to make a decision on that.

The common pairings are qdev_new() with qdev_realize_and_unref(), and
object_initialize_child() with qdev_realize().  Your idea obviously
works for these.  Whether there are other uses where it might not work,
I can't say offhand.


