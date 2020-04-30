Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5931AC83000
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:40:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20CE32051A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NvEu6wj7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20CE32051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUAM9-0005uo-9i
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 10:40:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34250)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jUAKR-0004Ht-VL
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:38:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jUAKR-0001F7-0q
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:38:19 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26060
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jUAKQ-0001Bc-HD
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:38:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588257496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bv5LpNXXaaI5E8o8sw1ehE6hr9HchQRYqEQBv0ZWjrI=;
 b=NvEu6wj7fQRNKzZ1ImaR4X1kIAyeMiuexQF2nMuxvKv6/WX6TMeN2dZ9qxDhZY7xUpJyk8
 jxebJ2BDo6Fckk3QsbmpXLbxNza2Tl8xZMMrXaoGFSYKEe4DGzQFPb5C9+gTtGAy6QkV70
 IuL9l0IdnUECrVzCa1zJGJx1iyDUW0U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-s4QtjkqkMkKwgNiHdluDcg-1; Thu, 30 Apr 2020 10:38:15 -0400
X-MC-Unique: s4QtjkqkMkKwgNiHdluDcg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECB591009600;
 Thu, 30 Apr 2020 14:38:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D26AF38A;
 Thu, 30 Apr 2020 14:38:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5FBF811358BC; Thu, 30 Apr 2020 16:38:09 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: Configuring onboard devices
References: <87mu6uia5i.fsf@dusky.pond.sub.org>
 <20200429155719.GL1495129@redhat.com>
 <87k11xh2kq.fsf@dusky.pond.sub.org>
 <CAFEAcA9-oxkMD-kJ1z12d4K1S_Jaz7Wj6_38Ah7ChSaBfQNkkA@mail.gmail.com>
 <87tv11e1en.fsf_-_@dusky.pond.sub.org>
 <20200430103437.GI2084570@redhat.com>
 <CAFEAcA_1BB6qCpP+yAOKBeryxCZk5aC-YAw+KbGLFm2zCVL2oQ@mail.gmail.com>
 <20200430105303.GK2084570@redhat.com>
Date: Thu, 30 Apr 2020 16:38:09 +0200
In-Reply-To: <20200430105303.GK2084570@redhat.com> ("Daniel P. =?utf-8?Q?B?=
 =?utf-8?Q?errang=C3=A9=22's?=
 message of "Thu, 30 Apr 2020 11:53:03 +0100")
Message-ID: <87o8r9ca3y.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:31:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Apr 30, 2020 at 11:45:40AM +0100, Peter Maydell wrote:
>> On Thu, 30 Apr 2020 at 11:34, Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om> wrote:
>> > We "merely" need a new query language targetted to QEMU's qtree
>> > structure, which we can expose in the CLI that gives unique access
>> > to every possible property.
>>=20
>> Past resistance to this has been grounded in not wanting to
>> expose the exact arrangement of the qtree as a user-facing
>> thing that needs to be maintained for back-compat reasons.
>
> I could be missing a key difference, but I thought we already exposed
> the qtree in QMP  via qom-list, qom-get, qom-set ?  Libvirt uses
> these commands for reading various properties.  I guess 'qom-set' is
> really defining the kind of query string language I was illustrating
> already. So mapping qom-set to the CLI as-is would not be worse than
> what we already support in QMP

We like to pretend QOM introspection is not a stable interface.  Except
for the parts that have to be, because they're the only way to probe for
certain things.  We're not telling you which parts, because we have no
idea ourselves.

>> Eg in your example the i440fx-pcihost sits directly on the
>> 'system bus', but this is an odd artefact of the old qbus/qdev
>> system and doesn't really reflect the way the system is built
>> up in terms of QOM components; we might one day want to
>> restructure things there, which would AIUI break a
>> command line like

If we replace qdev paths by QOM paths, the "doesn't really reflect the
way the system is built up in terms of QOM components" goes away.

However, the "we might one day want to restructure things" argument also
applies to QOM.

At some point we need to decide which part of the cake to feed to users,
and which part to keep for developers to mess with.

>> > To uniquely identify this we can have a string:
>> >
>> >  /dev[1]/bus[pci/0]/dev[id=3Dballoon0]/bus[virtio-bus]/dev[0]/deflate-=
on-oom=3Dtrue
>
> Regards,
> Daniel


