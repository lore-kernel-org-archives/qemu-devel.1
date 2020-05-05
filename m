Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAF6C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 16:07:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7A75206A4
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 16:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f0nho7of"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7A75206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jW06k-00071U-Rq
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 12:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jW039-0003jP-Rb
 for qemu-devel@nongnu.org; Tue, 05 May 2020 12:04:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21205
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jW038-0003BX-GY
 for qemu-devel@nongnu.org; Tue, 05 May 2020 12:04:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588694640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ChWxYjSJ64StPyrPvIDghwL7bKLhjAL5hiKJT3YK/U8=;
 b=f0nho7ofY4i7W50KNLKPS/TcvMBiNviMIuEeaMgoaG9ZFLFqwz4V6xoHFj4mo+yLjfg2iX
 DpZO1zu7xbjjojP/OLMM6FjbtCAkaIVp0lh+3C1fKIIgzU/y+/3N5VopjrPc2DlIvkIaV7
 Y1puf5bSaeoBoIg4BFni+PNmbpOcpuE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-YirWmDPDPtu4_8stGpgH0g-1; Tue, 05 May 2020 12:03:58 -0400
X-MC-Unique: YirWmDPDPtu4_8stGpgH0g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95C7A805EE0
 for <qemu-devel@nongnu.org>; Tue,  5 May 2020 16:03:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 629F55C1B2;
 Tue,  5 May 2020 16:03:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E748111358BC; Tue,  5 May 2020 18:03:25 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Infinite loop in bus_unparent(), qdev bug or qdev misuse?
References: <87tv0vzrwj.fsf@dusky.pond.sub.org>
 <6fc8633a-6d91-b83a-e6cd-5f714ccaf9ea@redhat.com>
Date: Tue, 05 May 2020 18:03:25 +0200
In-Reply-To: <6fc8633a-6d91-b83a-e6cd-5f714ccaf9ea@redhat.com> (Paolo
 Bonzini's message of "Mon, 4 May 2020 16:58:54 +0200")
Message-ID: <875zda8j3m.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:38
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 04/05/20 16:38, Markus Armbruster wrote:
>> makes no progreess because OBJECT(dev)->parent is still null, and
>> therefore object_unparent() does nothing.
>>=20
>> Possible culprit: qdev_try_create() calls qdev_set_parent_bus(), which
>> adds the device to the bus, but leaves ->parent null.  If this isn't
>> wrong outright, it's at least a dangerous state.
>>=20
>> Work-around: call qdev_set_id(dev, NULL) right after qdev_create().
>> This sets ->parent.
>
> That's a good one, and especially a safe one, since it matches
> qdev_device_add.  It has the disadvantage of having to touch all
> qdev_create() calls.

Also, it moves onboard devices from /machine/unattached/ to
/machine/peripheral-anon/.

I really regard it as a work-around, not a proper solution.

> Even better however would be to move the bus argument (and thus
> qdev_set_parent_bus) to qdev_init, and likewise in qdev_device_add move
> qdev_set_id after qemu_opt_foreach.  I looked at the property setters
> and couldn't find anything suspicious (somewhat to my surprise), but I
> haven't honestly tried.

Thus, we satisfy bus_unparent()'s precondition "bus children have a QOM
parent"[*] by moving "add to parent bus" next to the place where we
ensure "has QOM parent" by putting orphans under /machine/unattached/.
Makes sense.

If we add to the bus first, the precondition ceases to hold until we
realize.  Ugly, but harmless unless we manage to actually call the
function then.

I suspect we can't realize first, because the realize method may want to
use the parent bus.

We could lift putting orphans under /machine/unattached from
device_set_realized() into those callers that don't already assign a QOM
parent.  Possibly hundreds of places, hmm.

We could factor it out into a helper, and call it right before we add to
the parent bus.  Orphans with a parent bus would get adopted ealier,
orphans without one would still get adopted at realize time.

I'll play with it.


[*] Confusing terminology; two separate parent-child relationships


