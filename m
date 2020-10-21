Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DA6C4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 03:32:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 140E821707
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 03:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HPfHm71O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 140E821707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV4rm-0003oY-Uq
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 23:32:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kV4rC-0003Fb-6F
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 23:32:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23443)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kV4r9-0001BV-CP
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 23:32:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603251124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BOO4PSXhDHmdUjOeLv7s8gEff9JvuiOTMk3nu4q2Rlc=;
 b=HPfHm71OZIDq/htO3sQJGgo5vUxQ4gN/GMHseMkHQOqndEKDCJjuH69lkWyCHm2irgk1Zp
 Hg1rjMgJYH9juEtVV9DyxrKOu7pDFCxWfd8cfNthyIKCjER4eLG6s8mEUmgUoJJATAJe+k
 iqoQ9k5Jf82WiJpRvOzggQURW/nzV2c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-DnQq47r9Oaek-hC5_U-6HQ-1; Tue, 20 Oct 2020 23:32:02 -0400
X-MC-Unique: DnQq47r9Oaek-hC5_U-6HQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC0BB803F6A;
 Wed, 21 Oct 2020 03:32:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BC5BD5C1C2;
 Wed, 21 Oct 2020 03:31:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 352081132A08; Wed, 21 Oct 2020 05:31:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: BALATON Zoltan via <qemu-devel@nongnu.org>
Subject: Re: [PATCH] hw/pci-host/grackle: Verify PIC link is properly set
References: <20201011190332.3189611-1-f4bug@amsat.org>
 <20201011223446.GA4787@yekko.fritz.box>
 <369509c1-2e90-13cf-8845-892e754516d1@amsat.org>
 <20201012065436.GB71119@yekko.fritz.box>
 <9f7e4847-801d-dcd3-b876-bf2d276251@eik.bme.hu>
 <6e587154-4bc5-c44c-0c85-b46e0dddd3aa@amsat.org>
 <87k0vm1wny.fsf@dusky.pond.sub.org>
 <24bcd4-fde2-22a2-d3f4-cd42d9ee13c6@eik.bme.hu>
 <87d01e48pa.fsf@dusky.pond.sub.org>
 <9968e60e-99fd-3777-62ca-57decb716886@ilande.co.uk>
 <877drl1n2x.fsf@dusky.pond.sub.org>
 <8f27b2b4-1937-305e-af22-2378d1fb3a8@eik.bme.hu>
Date: Wed, 21 Oct 2020 05:31:58 +0200
In-Reply-To: <8f27b2b4-1937-305e-af22-2378d1fb3a8@eik.bme.hu> (BALATON Zoltan
 via's message of "Tue, 20 Oct 2020 13:37:07 +0200 (CEST)")
Message-ID: <87v9f4qmoh.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 22:12:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

BALATON Zoltan via <qemu-devel@nongnu.org> writes:

> On Tue, 20 Oct 2020, Markus Armbruster wrote:
>> Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:
>>
>>> One thing I have thought about is being able to mark a link property
>>> as mandatory so if a value hasn't been set before realize then you
>>
>> A non-null value, I presume.
>
> Do you mean something like distinguish between NULL and INVALID_VALUE
> where setting the latter as initial value means property is mandatory?

I doubt "somebody must have set some value (which could be null)" is
useful here.  I believe Mark was thinking about "somebody must have
connected the link (i.e. set a non-null value)".

>>> receive a fatal error. This would be for cases like this where 2
>>> internal devices are connected together without any formal interface,
>>> i.e. in cases where -device wouldn't work anyway.
>>
>> Moves the check from code one step closer to data: from the realize
>> method to the object_property_add_link() call.
>>
>> I like doing things in data, because data is easier to reason about than
>> code.
>
> Except when object initialisation is scattered around in boiler plate
> code as in QEMU where it may not be obvious why a realize method fails
> due to something set/documented in a class_init method elsewhere,
> whereas an assert in the realize method is quite self evident and
> would document the same requirements.

Two aspects.

One, making sense of an assertion failure.  Whether some ad hoc

    assert(s->some_other_object);

in the device realize method crashes, or a generic

    if (!object_property_get_link(s, prop->name, &error_abort)) {
        error_setg(errp, "link %s must be connected", prop->name);
    }

crashes in the error_setg() is all the same to me.  Some developers may
find the latter's crash message superior (I don't care).

Two, making sense of the code.  You have to consider property definition
(which might be code in .class_init(), code in .instance_init(), or data
passed to .device_class_set_props()), property use (in the code that
sets up the device), and property value checking (generic checks in
qom/object.c, specific checks in .realize()).  Moving one check from
"specific" to "generic" won't make much of a difference.


