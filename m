Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE99C33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 08:22:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A735724125
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 08:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="haB5QFP3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A735724125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuXl3-0000aF-Q9
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 03:22:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55543)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iuXjs-00080q-QB
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:21:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iuXjq-0001hm-80
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:21:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60963
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iuXjq-0001h6-3G
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:21:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579767677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ILqPFNt0idVIU2/k8UfJS2Y/3wTjfynlJ4HusQkCCZ8=;
 b=haB5QFP3JvcCRB9dlt9WcnRFAik2Vj5RW16rfdgZ0eTbpDVFc/NwBxGZQXEutrmOW+gwG0
 2OwYsIaiDYgX42dE0T38UIJWwFUYvdScjdgF7WH+JzvvJp9QZBXej2EeDw+YaEzzwYcg+m
 zdQCLxbHtVnJdPQTXw2TYB4QxmgXFeo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-U7Y41MzrPqqW0S5RBx-hww-1; Thu, 23 Jan 2020 03:21:15 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2AA1C107ACC4
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 08:21:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A91B25C298;
 Thu, 23 Jan 2020 08:21:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3B12B1138600; Thu, 23 Jan 2020 09:21:10 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH] qapi: Incorrect attempt to fix building with
 MC146818RTC=n
References: <20191231184916.10235-1-philmd@redhat.com>
 <875zhfzc9l.fsf@dusky.pond.sub.org>
 <a06fd97c-b149-2f24-1180-4e4efa8ff79d@redhat.com>
 <87wo9ll5on.fsf@dusky.pond.sub.org>
 <b0559940-7b97-901b-5729-587d8649eede@redhat.com>
 <87lfq0c2jq.fsf@dusky.pond.sub.org>
 <CABgObfaPrbbx6Bw0Cj14evAvA_TSUo-+iOCkBzEBfPVn6qDLBg@mail.gmail.com>
 <87tv4oyrnj.fsf@dusky.pond.sub.org>
 <3b991266-de2a-a9a6-ef68-1791f7bd838b@redhat.com>
Date: Thu, 23 Jan 2020 09:21:10 +0100
In-Reply-To: <3b991266-de2a-a9a6-ef68-1791f7bd838b@redhat.com> (Paolo
 Bonzini's message of "Wed, 22 Jan 2020 15:30:59 +0100")
Message-ID: <878slybn2h.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: U7Y41MzrPqqW0S5RBx-hww-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 22/01/20 06:41, Markus Armbruster wrote:
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>=20
>>> Il mar 21 gen 2020, 15:22 Markus Armbruster <armbru@redhat.com> ha scri=
tto:
>>>
>>>>> To see it a different way, these are the "C bindings" to QMP, just th=
at
>>>>> the implementation is an in-process call rather than RPC.  If the QAP=
I
>>>>> code generator was also able to generate Python bindings and the like=
,
>>>>> they would have to be the same for all QEMU binaries, wouldn't they?
>>>>
>>>> Ommitting the kind of #if we've been discussing is relatively harmless
>>>> but what about this one, in qapi-types-block-core.h:
>>>>
>>>>     typedef enum BlockdevDriver {
>>>>         BLOCKDEV_DRIVER_BLKDEBUG,
>>>>         [...]
>>>>     #if defined(CONFIG_REPLICATION)
>>>>         BLOCKDEV_DRIVER_REPLICATION,
>>>>     #endif /* defined(CONFIG_REPLICATION) */
>>>>         [...]
>>>>         BLOCKDEV_DRIVER__MAX,
>>>>     } BlockdevDriver;
>>>>
>>>
>>> Well, I don't think this should be conditional at all. Introspection is=
 a
>>> tool to detect unsupported features, not working features.
>>=20
>> Isn't this what it does?  To detect "replication" is unsupported, check
>> whether it's absent, and "supported" does not imply "works".
>
> Indeed...
>
>>>                                                            KVM will be
>>> present in introspection data even if /dev/kvm doesn't exist on your
>>> machine or you don't have permission to access it.
>>=20
>> Yes.
>>=20
>> QAPI/QMP introspection is compile-time static by design.  It can't tell
>> you more than "this QEMU build supports X".
>
> ... and I think it would be fine even if it told you less: "this QEMU
> will not give a parse error if X appears in QMP syntax".  For example,
> QEMU could accept "replication" even if CONFIG_REPLICATION is not
> defined and therefore using it would always fail.  This would allow
> limiting even more use of conditional compilation.

This is effectively how things worked before we added 'if' to the QAPI
schema language.

A feature F may

(1) not exist in this version of QEMU

(2) exist, but configured off for this build of QEMU

(3) be present in this build of QEMU

When the management application sees (1) or (2), it knows that using F
cannot possibly work no matter what you do to the host short of using
another build of QEMU.  The management application can then reject
attempts to use F with a useful error message, or make such attempts
impossible (think graying out menu entries).

When the management application sees (3), it still needs to be prepared
for actual use to fail.  Possible failures depend on the feature.
Identifying the various kinds of failures can be awkward and/or brittle.
Useful error reporting is often hard.

A management application doesn't care for the difference between (1) and
(2).  We added 'if' to the QAPI schema language in part to make the
difference disappear.

Without it, introspection munges together (2) and (3) instead.  The
management application's information degrades from "the QEMU I have does
not provide F" to "something went wrong".  Perhaps the management
application can figure out what went wrong, perhaps it can't.  Perhaps
it doesn't need to know.

My point is: we trade away information at the external interface for the
benefit of "limiting even more use of conditional compilation".  I doubt
that's a good trade, not least because I can't quite see how exactly the
benefit is, well, beneficial[*].

Anyway, we've had introspection reflect compile time configuration since
v3.0.0.  I don't think we can break that now.



[*] It saves us including headers we really should be including.
Anything else?


