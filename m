Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A537C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 06:49:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D90F92075B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 06:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z0GxzCMb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D90F92075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsKwn-0001Ly-6z
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 02:49:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsKw7-0000wu-2t
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 02:49:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21114
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsKw4-0006Oc-Mi
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 02:49:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594018143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MWCehDOHwh+O9UiDQoP0kFz1+VI+8SC74uvCINoIsKI=;
 b=Z0GxzCMb3QWA/hn0gfRIjx8spRFG3XKQTkzTae0cKVB9zRhLPCpDoLNkYFfcXDADxN+nkq
 2F6jwrd1MeQnvBH3tHGwkyuSVCPuojphKCUj7IPvhbrQu7EhMWoxX5O0GEB/C/Q94qrccy
 6M6uhar2Za0aa6RKEfp798lLDAiT4XI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498--2nME6h8Nj6efnaVD4xwYQ-1; Mon, 06 Jul 2020 02:49:01 -0400
X-MC-Unique: -2nME6h8Nj6efnaVD4xwYQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9BB11107ACCA;
 Mon,  6 Jul 2020 06:49:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E5E810013D7;
 Mon,  6 Jul 2020 06:49:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DE4F01138648; Mon,  6 Jul 2020 08:48:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] hw/core/qdev: Increase qdev_realize() kindness
References: <20200620153837.14222-1-f4bug@amsat.org>
 <c0366cb5-fcb0-ff62-8ab5-92722a47d4e7@redhat.com>
 <65937a53-5430-e5df-a5f0-de93dad315f2@amsat.org>
 <CABgObfYbqHh6JZZ4z_KUovekUH2yac17oQr0WH6K9GkdEz6rkg@mail.gmail.com>
Date: Mon, 06 Jul 2020 08:48:58 +0200
In-Reply-To: <CABgObfYbqHh6JZZ4z_KUovekUH2yac17oQr0WH6K9GkdEz6rkg@mail.gmail.com>
 (Paolo Bonzini's message of "Sun, 5 Jul 2020 13:14:29 +0200")
Message-ID: <87k0zhgmud.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:22:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Markus Armbruster <armbru@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> Are we sure that qdev_realize is never called with user-provided input? I=
f

The only way to call qdev_realize() with a user-provided bus is -device
/ device_add via qdev_device_add().  qdev_device_add() carefully checks
the user-provided bus before passing it to qdev_realize().

> it's a programming error, the call chain will end up passing &error_abort
> anyway, won't it?

Correct.

>
> Paolo
>
> Il dom 5 lug 2020, 12:05 Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> ha
> scritto:
>
>> On 7/5/20 7:46 AM, Paolo Bonzini wrote:
>> > On 20/06/20 17:38, Philippe Mathieu-Daud=C3=A9 wrote:
>> >> -    } else {
>> >> -        assert(!DEVICE_GET_CLASS(dev)->bus_type);
>> >> +    } else if (DEVICE_GET_CLASS(dev)->bus_type) {
>> >> +        error_report("%s: Unexpected bus '%s' for device '%s'",
>> >> +                     __func__, DEVICE_GET_CLASS(dev)->bus_type,
>> >> +                     object_get_typename(OBJECT(dev)));
>> >> +        abort();
>> >>      }
>> >>
>> >
>> > Since there is an errp, should we use it and be even kinder?
>>
>> This is a programming error, not an user triggerable condition,
>> so I'm not sure. IOW this must not happen, but if it does, then
>> the error message helps the developer to notice the problem without
>> having to use gdb.

I don't bother with reporting impossible errors nicely.  Statement, not
objection.


