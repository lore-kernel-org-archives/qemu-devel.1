Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BA3C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 05:55:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7354C2078B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 05:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fHcrvgjT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7354C2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJsod-0000Bk-HZ
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 01:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41950)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jJsnz-0008CR-GK
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 01:54:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jJsny-0007eF-5n
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 01:54:19 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34276
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jJsny-0007ad-1l
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 01:54:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585806856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w+8l5AZwU4kBukbo3rgZU4xOirZHabTV4Y0p8dHV8h4=;
 b=fHcrvgjTlX1SOos6DnnyDcjzjhEgLDn2UEkEY5hnA3nkdQ48L5bHYw5zqUhwL0IgrfJd4f
 6edE/ZSPkmaO4/Fgk/ojBtsipcS3llc5zI6iorN2oZmQpkELIlVX3c9nY81SEp3EeorZWh
 VXOoCVXa8gTDA9zs37uyYZxlM7oUNOU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-Nc6sZ1YLPza7RoKr7_5GJg-1; Thu, 02 Apr 2020 01:54:14 -0400
X-MC-Unique: Nc6sZ1YLPza7RoKr7_5GJg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D32A11005516;
 Thu,  2 Apr 2020 05:54:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-69.ams2.redhat.com
 [10.36.112.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 87E1D60BF4;
 Thu,  2 Apr 2020 05:54:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1048F11385E2; Thu,  2 Apr 2020 07:54:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: Questionable aspects of QEMU Error's design
References: <87o8sblgto.fsf@dusky.pond.sub.org>
 <CAFEAcA_b1gZ-B4NaEdQS2zffdvobW=FUx4ysEgXVAz+=cZ+R3Q@mail.gmail.com>
Date: Thu, 02 Apr 2020 07:54:11 +0200
In-Reply-To: <CAFEAcA_b1gZ-B4NaEdQS2zffdvobW=FUx4ysEgXVAz+=cZ+R3Q@mail.gmail.com>
 (Peter Maydell's message of "Wed, 1 Apr 2020 21:15:32 +0100")
Message-ID: <87sghmbfgc.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Wed, 1 Apr 2020 at 10:03, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> QEMU's Error was patterned after GLib's GError.  Differences include:
>
> From my POV the major problem with Error as we have it today
> is that it makes the simple process of writing code like
> device realize functions horrifically boilerplate heavy;
> for instance this is from hw/arm/armsse.c:
>
>         object_property_set_link(cpuobj, OBJECT(&s->cpu_container[i]),
>                                  "memory", &err);
>         if (err) {
>             error_propagate(errp, err);
>             return;
>         }
>         object_property_set_link(cpuobj, OBJECT(s), "idau", &err);
>         if (err) {
>             error_propagate(errp, err);
>             return;
>         }
>         object_property_set_bool(cpuobj, true, "realized", &err);
>         if (err) {
>             error_propagate(errp, err);
>             return;
>         }
>
> 16 lines of code just to set 2 properties on an object
> and realize it. It's a lot of boilerplate and as
> a result we frequently get it wrong or take shortcuts
> (eg forgetting the error-handling entirely, calling
> error_propagate just once for a whole sequence of
> calls, taking the lazy approach and using err_abort
> or err_fatal when we ought really to be propagating
> an error, etc). I haven't looked at 'auto propagation'
> yet, hopefully it will help?

With that, you can have

        object_property_set_link(cpuobj, OBJECT(&s->cpu_container[i]),
                                 "memory", errp);
        if (*errp) {
            return;
        }
        object_property_set_link(cpuobj, OBJECT(s), "idau", errp);
        if (*errp) {
            return;
        }
        object_property_set_bool(cpuobj, true, "realized", errp);
        if (*errp) {
            return;
        }

but you have to add

        ERRP_AUTO_PROPAGATE();

right at the beginning of the function.

It's a small improvement.  A bigger one is

        if (object_property_set_link(cpuobj, OBJECT(&s->cpu_container[i]),
                                     "memory", errp)) {
            return;
        }
        if (object_property_set_link(cpuobj, OBJECT(s), "idau", errp)) {
            return;
        }
        if (object_property_set_bool(cpuobj, true, "realized", errp)) {
            return;
        }

This is item "Return value conventions" in the message you replied to.

Elsewhere in this thread, I discussed the difficulties of automating the
conversion to this style.  I think I know how to automate converting the
calls to use the bool return value, but converting the functions to
return it looks hard.  We could do that manually for a modest set of
frequently used functions.  object.h would top my list.


