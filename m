Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B481C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 06:40:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04704206E6
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 06:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E5zoreIw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04704206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWDjd-0002EQ-35
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 02:40:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jWDib-0001VR-Dq
 for qemu-devel@nongnu.org; Wed, 06 May 2020 02:39:45 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44049
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jWDiY-0006tH-R5
 for qemu-devel@nongnu.org; Wed, 06 May 2020 02:39:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588747180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uHEDi7QUzdfPppoODZMKZNkQcWEBzFTL5ac4jf/Q5iI=;
 b=E5zoreIwyg/JVZzm+Yi6wMlBUjuu8QJk2D2Yf751c40X2uArMEUdTaFCLHDUUGHYbx/ab/
 /A2vL0mWQvdDO+DbCvYf4SZuu023j3wbqxj2KymUNNxrBTmxfUtb11p4faM8S6nSzMqU+X
 yp2oZf4anCG8YNRgerGeD26c6v6/vSY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-q7-Cs1zMPSuh4h5c3CMk_w-1; Wed, 06 May 2020 02:39:39 -0400
X-MC-Unique: q7-Cs1zMPSuh4h5c3CMk_w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46CAE100CCC2
 for <qemu-devel@nongnu.org>; Wed,  6 May 2020 06:39:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 134DB25277;
 Wed,  6 May 2020 06:39:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 81C3E11358BC; Wed,  6 May 2020 08:39:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Infinite loop in bus_unparent(), qdev bug or qdev misuse?
References: <87tv0vzrwj.fsf@dusky.pond.sub.org>
 <6fc8633a-6d91-b83a-e6cd-5f714ccaf9ea@redhat.com>
 <875zda8j3m.fsf@dusky.pond.sub.org>
 <a4df3ba3-4759-56ac-68f8-f75eea93e27e@redhat.com>
Date: Wed, 06 May 2020 08:39:36 +0200
In-Reply-To: <a4df3ba3-4759-56ac-68f8-f75eea93e27e@redhat.com> (Paolo
 Bonzini's message of "Tue, 5 May 2020 18:26:57 +0200")
Message-ID: <87zhal4lef.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 02:39:40
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 05/05/20 18:03, Markus Armbruster wrote:
>>> That's a good one, and especially a safe one, since it matches
>>> qdev_device_add.  It has the disadvantage of having to touch all
>>> qdev_create() calls.
>>=20
>> Also, it moves onboard devices from /machine/unattached/ to
>> /machine/peripheral-anon/.
>
> Uh indeed.  No that's too ugly.
>
>>> Even better however would be to move the bus argument (and thus
>>> qdev_set_parent_bus) to qdev_init, and likewise in qdev_device_add move
>>> qdev_set_id after qemu_opt_foreach.  I looked at the property setters
>>> and couldn't find anything suspicious (somewhat to my surprise), but I
>>> haven't honestly tried.
>>=20
>> Thus, we satisfy bus_unparent()'s precondition "bus children have a QOM
>> parent"[*] by moving "add to parent bus" next to the place where we
>> ensure "has QOM parent" by putting orphans under /machine/unattached/.
>> Makes sense.
>>=20
>> If we add to the bus first, the precondition ceases to hold until we
>> realize.  Ugly, but harmless unless we manage to actually call the
>> function then.
>
> Shouldn't be a big deal, since users should call either qdev_set_id or
> object_property_add_child before device_set_realized.

The issue isn't neglecting to set a QOM parent, it's destroying a device
before its bus children get their QOM parent.

Mostly harmless: by delaying "add to bus" until right before realize, we
narrow the window where the trap is armed, and keep it completely within
qdev_init_nofail(), qdev_device_add(), and possibly code that duplicates
their work.  Ensuring qdev_init_nofail() and qdev_device_add() don't
fail in this window should be easy enough (except for writing the
comment explaining it).  The duplicates, though... I guess we need to
double-check users of qdev_set_parent_bus().

Ugly: yes, compared to the pretty invariant "bus children all have QOM
parents".

>> I suspect we can't realize first, because the realize method may want to
>> use the parent bus.
>
> Right.
>
> Moving the bus to qdev_init would be quite large but hopefully scriptable=
.

Feels feasible.


[*] We might want to look into deduplicating: the string "realized"
occurs more than 450 times, and I figure almost always as property name.


