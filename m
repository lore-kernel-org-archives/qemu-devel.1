Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD386C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 07:40:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77F3520825
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 07:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ie9oqTCc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77F3520825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0ghE-0008Lg-MW
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 03:40:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k0ggY-0007wi-6e
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 03:39:34 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:57934)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k0ggW-0003Hs-6A
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 03:39:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596008370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bK12oYdQvyrxyqX3brUZh/HjuLKkHipfD3Z0GaIgtao=;
 b=ie9oqTCcUfVffYiNj9nhYhPEQ/QcXZmOhlI9UrRO+VDEXyz3OSPzAoSXtHoJXwINns4xA6
 zvuyFo7h2jc5SInqSGWTAi2bqUY6MlsAI8zxVC1xxiXs3JiAWfggF2Z3i+VtnPQgC8YZ9X
 WzntE4cG2Zm1uQJt2gmX822FgI4luRY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-kF8ZDmh5NByQ0c-PfAKBDA-1; Wed, 29 Jul 2020 03:39:28 -0400
X-MC-Unique: kF8ZDmh5NByQ0c-PfAKBDA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64144800471;
 Wed, 29 Jul 2020 07:39:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 19A7D7556B;
 Wed, 29 Jul 2020 07:39:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A5F591132FD2; Wed, 29 Jul 2020 09:39:25 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH-for-5.2 v4] hw/core/qdev: Increase qdev_realize() kindness
References: <20200727175112.6820-1-f4bug@amsat.org>
 <87d04gf5i4.fsf@dusky.pond.sub.org>
 <b5cd0d50-c0a6-afee-5b63-80bb83e7e001@redhat.com>
Date: Wed, 29 Jul 2020 09:39:25 +0200
In-Reply-To: <b5cd0d50-c0a6-afee-5b63-80bb83e7e001@redhat.com> (Paolo
 Bonzini's message of "Tue, 28 Jul 2020 10:21:18 +0200")
Message-ID: <87r1suahxu.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.74; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-74.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 03:32:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: "Daniel P. =?utf-8?Q?Berrang?= =?utf-8?Q?=C3=A9?=" <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 28/07/20 09:44, Markus Armbruster wrote:
>>> -        assert(!DEVICE_GET_CLASS(dev)->bus_type);
>>> +    } else if (DEVICE_GET_CLASS(dev)->bus_type) {
>>> +        error_setg(errp, "Unexpected bus '%s' for bus-less device '%s'",
>>> +                   DEVICE_GET_CLASS(dev)->bus_type,
>>> +                   object_get_typename(OBJECT(dev)));
>>> +        return false;
>>>      }
>>>  
>>>      object_property_set_bool(OBJECT(dev), true, "realized", &err);
>> Objection.  This turns an abort into something else unless the caller
>> passes &error_abort.  The caller in your commit message's example does,
>> others don't.
>> 
>> Keep the unconditional abort, please.  Feel free to print something kind
>> right before.  I doubt it's all that useful, as I believe whoever gets
>> to fix the bug will have to figure out the code anyway, but I could be
>> wrong.
>> 
>
> This was my request, actually.  We have an Error**, we should use it in
> case this code is reached via device_add.

That's not actually possible.  qdev_device_add():

    path = qemu_opt_get(opts, "bus");
    if (path != NULL) {

If user passed bus=...,

        bus = qbus_find(path, errp);
        if (!bus) {
            return NULL;
        }
        if (!object_dynamic_cast(OBJECT(bus), dc->bus_type)) {
            error_setg(errp, "Device '%s' can't go on %s bus",
                       driver, object_get_typename(OBJECT(bus)));

but the device is bus-less, error out.

            return NULL;
        }
    } else if (dc->bus_type != NULL) {


If user did not pass bus=..., but the device needs one,

        bus = qbus_find_recursive(sysbus_get_default(), NULL, dc->bus_type);

pick a default bus, or else ...

        if (!bus || qbus_is_full(bus)) {
            error_setg(errp, "No '%s' bus found for device '%s'",
                       dc->bus_type, driver);
            return NULL;

error out.

        }
    }

Taking a step back, I disagree with the notion that assertions should be
avoided just because we have an Error **.  A programming error doesn't
become less wrong, and continuing when the program is in disorder
doesn't become any safer when you add an Error ** parameter to a
function.

If you're calling for recovering from programming errors where that can
be done safely, we can talk about creating the necessary infrastructure.
Handling them as if they were errors the user can do something about can
only lead to confusion.


