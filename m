Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFA2C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 05:42:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5895D21835
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 05:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QhmXyELf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5895D21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu8mU-0005UK-H6
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 00:42:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59066)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iu8le-00051w-UP
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 00:41:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iu8ld-0007at-Tc
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 00:41:30 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58169
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iu8ld-0007ab-Pt
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 00:41:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579671689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FCqpCK7eDbKnSy+yx7RGE/YpMEGlyc68dmPgwWQgaLA=;
 b=QhmXyELfPm/IrLz0+LGtZyk/nsThCJzpy/1eWc1EqOcZMN+mJmrqMr56O0UltNBIIRLuca
 jNq7cj+miWQIreoalwxylNTxhAWxnGAK599Drb47LGHSwB28Tpw37cKmNVClk+FUUco/2u
 unQV+a5x9F8YrnKY2uKOMm6QdEvULjA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-EjKc5pGUOAO5eg-O7-CsCg-1; Wed, 22 Jan 2020 00:41:25 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49E93107ACC7
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 05:41:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C78FE100164D;
 Wed, 22 Jan 2020 05:41:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5E5D51138600; Wed, 22 Jan 2020 06:41:20 +0100 (CET)
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
Date: Wed, 22 Jan 2020 06:41:20 +0100
In-Reply-To: <CABgObfaPrbbx6Bw0Cj14evAvA_TSUo-+iOCkBzEBfPVn6qDLBg@mail.gmail.com>
 (Paolo Bonzini's message of "Tue, 21 Jan 2020 21:44:01 +0100")
Message-ID: <87tv4oyrnj.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: EjKc5pGUOAO5eg-O7-CsCg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

> Il mar 21 gen 2020, 15:22 Markus Armbruster <armbru@redhat.com> ha scritt=
o:
>
>> > To see it a different way, these are the "C bindings" to QMP, just tha=
t
>> > the implementation is an in-process call rather than RPC.  If the QAPI
>> > code generator was also able to generate Python bindings and the like,
>> > they would have to be the same for all QEMU binaries, wouldn't they?
>>
>> Ommitting the kind of #if we've been discussing is relatively harmless
>> but what about this one, in qapi-types-block-core.h:
>>
>>     typedef enum BlockdevDriver {
>>         BLOCKDEV_DRIVER_BLKDEBUG,
>>         [...]
>>     #if defined(CONFIG_REPLICATION)
>>         BLOCKDEV_DRIVER_REPLICATION,
>>     #endif /* defined(CONFIG_REPLICATION) */
>>         [...]
>>         BLOCKDEV_DRIVER__MAX,
>>     } BlockdevDriver;
>>
>
> Well, I don't think this should be conditional at all. Introspection is a
> tool to detect unsupported features, not working features.

Isn't this what it does?  To detect "replication" is unsupported, check
whether it's absent, and "supported" does not imply "works".

>                                                            KVM will be
> present in introspection data even if /dev/kvm doesn't exist on your
> machine or you don't have permission to access it.

Yes.

Likewise, "nfs" is present in introspection data even if no NFS server
exists on your network, or you don't have permission to use it.

QAPI/QMP introspection is compile-time static by design.  It can't tell
you more than "this QEMU build supports X".  That's it's mission.

>                                                    I would restrict very
> much #if usage in QAPI to the very minimum necessary.

I'm not sure I understand how you propose to change introspection.


