Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA18C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 14:14:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AE1B2070B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 14:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E7dZkH6k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE1B2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0mqZ-00047K-8n
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 10:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k0mps-0003N1-LP
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 10:13:36 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60109
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k0mpr-0007qE-2O
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 10:13:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596032014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LkpExYASefjD0aVFXZE7XEC+qHvyOuMRWnzeKWia/OA=;
 b=E7dZkH6kQ/hX3ekxd4AQgZEhHvleNkooM38YL7aQ0fk337WqHyMUcJnUcHN0PDL2DHJ/T9
 SFlnhSUu1FPfxaJZXdLCtgPcbspCCaIeXhv/PkU9YiECGR5MWd5r1W9iMHr9b095dOgE1f
 485DmrASdxhntEW4j6uDauPK0kNhjXo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-zfqrVICiPKaFrlt3eCerFA-1; Wed, 29 Jul 2020 10:13:31 -0400
X-MC-Unique: zfqrVICiPKaFrlt3eCerFA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BAF9C80183C;
 Wed, 29 Jul 2020 14:13:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 856BC709E4;
 Wed, 29 Jul 2020 14:13:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 010411132FD2; Wed, 29 Jul 2020 16:13:28 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH-for-5.2 v4] hw/core/qdev: Increase qdev_realize() kindness
References: <20200727175112.6820-1-f4bug@amsat.org>
 <87d04gf5i4.fsf@dusky.pond.sub.org>
 <b5cd0d50-c0a6-afee-5b63-80bb83e7e001@redhat.com>
 <87r1suahxu.fsf@dusky.pond.sub.org>
 <a73edd14-ab57-0072-36cb-91222a9a1638@amsat.org>
 <87d04e7b94.fsf@dusky.pond.sub.org>
 <7c44649f-ebd3-4f99-ce4c-a085bbe20ad5@amsat.org>
Date: Wed, 29 Jul 2020 16:13:28 +0200
In-Reply-To: <7c44649f-ebd3-4f99-ce4c-a085bbe20ad5@amsat.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 29 Jul 2020 14:49:13
 +0200")
Message-ID: <87ft9a5rzr.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 09:18:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Daniel P. =?utf-8?Q?Berrang?= =?utf-8?Q?=C3=A9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> On 7/29/20 2:32 PM, Markus Armbruster wrote:
>> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:
>>=20
>>> On 7/29/20 9:39 AM, Markus Armbruster wrote:
>>>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>>>
>>>>> On 28/07/20 09:44, Markus Armbruster wrote:
>>>>>>> -        assert(!DEVICE_GET_CLASS(dev)->bus_type);
>>>>>>> +    } else if (DEVICE_GET_CLASS(dev)->bus_type) {
>>>>>>> +        error_setg(errp, "Unexpected bus '%s' for bus-less device =
'%s'",
>>>>>>> +                   DEVICE_GET_CLASS(dev)->bus_type,
>>>>>>> +                   object_get_typename(OBJECT(dev)));
>>>>>>> +        return false;
>>>>>>>      }
>>>>>>> =20
>>>>>>>      object_property_set_bool(OBJECT(dev), true, "realized", &err);
>>>>>> Objection.  This turns an abort into something else unless the calle=
r
>>>>>> passes &error_abort.  The caller in your commit message's example do=
es,
>>>>>> others don't.
>>>>>>
>>>>>> Keep the unconditional abort, please.  Feel free to print something =
kind
>>>>>> right before.  I doubt it's all that useful, as I believe whoever ge=
ts
>>>>>> to fix the bug will have to figure out the code anyway, but I could =
be
>>>>>> wrong.
>>>>>>
>>>>>
>>>>> This was my request, actually.  We have an Error**, we should use it =
in
>>>>> case this code is reached via device_add.
>>>>
>>>> That's not actually possible.
>>>
>>> I agree this condition is not possible in current mainstream.
>>>
>>> What I'm working on is:
>>>
>>> qmp command that:
>>> - create a SDCard or FloppyDisk medium
>>> - eventually link a block driver to it
>>> - insert the medium into a slot
>>>
>>> then another qmp command that
>>> - eject the medium
>>> - unlink the block driver
>>> - destroy the medium
>>>
>>> second step is a command that takes as argument
>>> (block driver, bus endpoint) and automatically
>>> creates the envelope media and insert it to the bus.
>>=20
>> If this makes the error possible, then your code fails to establish
>> qdev_realize()'s precondition, and therefore needs fixing.
>
> Yes, because I try to create a bus-ful device without plugging it on
> the bus (I want to set the block driver link before plugging it).

You need to set properties *before* you realize!

[...]


