Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7EAC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 15:27:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D48FA206A5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 15:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XbuzcXmD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D48FA206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifQNg-0000LD-1s
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 10:27:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59732)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1ifQN3-0008Fz-0M
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 10:27:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1ifQMz-0004tD-Mu
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 10:27:15 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41891
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1ifQMz-0004qF-Ax
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 10:27:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576164432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1hSFe55XyhL47fXpeRZhvfg04b/9QXj6GU+RtTcqhcs=;
 b=XbuzcXmDtC+BZrOu2d2IM5+YanHoOIvSrtfPp1IVnbhOctKyva9U6duZYWNoCc72r2gofs
 qnlrz1kmDM/qKltiMcPXOP16+vU2OaLjp642aTX5c9GWetKPbjTwNUeHKyLcA0Gp2yJetp
 38PJcvA5H93mX9EmbHGoj+Gm/+9cv0M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-wI_9uEr5OJK114pvmkn3cg-1; Thu, 12 Dec 2019 10:27:09 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0C849124E;
 Thu, 12 Dec 2019 15:27:07 +0000 (UTC)
Received: from [10.36.117.65] (ovpn-117-65.ams2.redhat.com [10.36.117.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4BCB75D9E2;
 Thu, 12 Dec 2019 15:27:05 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] s390x/cpumodel: Introduce dynamic feature groups
To: Eduardo Habkost <ehabkost@redhat.com>
References: <b062f580-d664-f68c-2364-1f65df6ee265@de.ibm.com>
 <C829F458-099D-4E95-B835-67F008E60B13@redhat.com>
 <b4f4546d-b620-0428-40bf-59f4584a80f3@de.ibm.com>
 <b4ee8526-b1e3-21ee-5e1e-b22520e29339@redhat.com>
 <20191129193317.GE14595@habkost.net>
 <a5ae30ef-e193-fd22-b3e2-a7626e82d9b1@redhat.com>
 <20191205143506.GG498046@habkost.net>
 <b0467d48-1fff-e2ae-4866-1c9dbe03fb6c@redhat.com>
 <20191209232912.GM498046@habkost.net>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <9e10c050-d207-4448-e1d8-d1b428b78c01@redhat.com>
Date: Thu, 12 Dec 2019 16:27:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191209232912.GM498046@habkost.net>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: wI_9uEr5OJK114pvmkn3cg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Jiri Denemark <jdenemar@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

>> I think, you could if you would expand "best X" to something like
>>
>> -cpu X,all-features=3Doff,featX=3Don,featY=3Don ...
>>
>> The "all-features" part would need a better name as discussed. Such a
>> model would always have a defined feature set (all listed features) =3D=
=3D
>> static. The list could get a little longer, which is why s390x has these
>> static "base" features. But that's not a road blocker.
>>
>>>
>>> I was planning to make x86 CPU models static, then I noticed we
>>> do have lots of feature flags that depend on the current
>>> accelerator (set by kvm_default_props) or current machine (set
>>> by compat_props).  This breaks the rules for static CPU models.
>>
>> The static models we have (e.g., z13-base) contain a minimum set of
>> features we expect to be around in every environment (but doesn't have
>> to). It's just a way to make the featX=3Don,featY=3Don ... list shorter.
>>
>> X would be expanded to e.g.,
>>
>> -cpu X-base,featX=3Don,featY=3Don ...
>>
>> But nothing speaks against having
>>
>> -cpu X-base,featX=3Doff,featY=3Don ...
>>
>> A very simplistic base model would be a model without any features.
>> (like -cpu X,all-features=3Doff), but then it would be set in stone.
>=20
> x86 has only one static CPU model, called "base", just to make
> type=3Dstatic expansion work.  Having multiple "<model>-base" CPU
> models would help make the extra feature list shorter, yes.

On s390x, we also glue some magic numbers to the models (e.g., CPU ID,
IBC value, HW generation). IOW, you can't
make a z12 to a z13 just by adding features. The guest is able to
observe these magic numbers. That's also one reason we need distinct
base models.

>=20
> But we would still need to decide how to handle the
> accel-specific code in x86_cpu_load_model(), including:
> * kvm_default_props/tcg_default_props;
> * x2apic special case for !kvm_irqchip_in_kernel();
> * host vendor ID special case for KVM.

What would happen right now if you would do a static expansion of e.g.,
"SandyBridge" or of "host"? wouldn't all these knobs also have to be
expanded as well?

>=20
> If we include that in static expansion, it would be a large
> number of user-visible side effects for something that was
> supposed to just add/remove a tiny set of CPU features to an
> existing configuration.  If we don't, we are breaking the rules
> of static expansion (aren't we?).

I guess we would have to include - but a long list of features wouldn't
really be problematic, right? (at least when tooling just expands and
passes on whatever it gets). Same as when expanding "host".

>=20
> We can still try to address this and make
> "query-cpu-model-expansion type=3Dstatic ...,recommended-features=3Don"
> work on x86, and see it is usable by libvirt in x86.  I'm just
> worried that the interface may become complex, easy to get wrong,
> and hard to validate until full libvirt support is implemented.
> query-cpu-model-expansion is very extensible and flexible, but
> hard to explain and reason about.
>=20

I don't see a real alternative to get "the best model of a specific
generation for the current accel+hw+firmware". Ack that we should
clarify all implications (and requirements) first, before taking that path.

At least the concept of feature groups should be easy to explain.

[...]
>>>> +static S390DynFeatGroupDef s390_dyn_feature_groups[] =3D {
>>>> +    /* "all" corresponds to our "full" definitions */
>>>> +    DYN_FEAT_GROUP_INIT("all-features", ALL, "Features valid for a CP=
U
>>>> definition"),
>>>> [...]
>>>> +};
>>>>
>>>> it includes features that are not available - all features that could
>>>> theoretically be enabled for that CPU definition.
>>>>
>>>> (e.g., "vx" was introduced with z13 and cannot be enabled for the z12.
>>>> It's part of the full model of a z13, but not of a z12)
>>>
>>> Isn't this something already returned by device-list-properties?
>>>
>>
>> We do register all feature properties for all models. So, yes, it would
>> have been possible if we (I) would have implemented that differently. We
>> could (and maybe should) still change that - only register the features
>> that are part of the "full" model.
>=20
> Understood.  When exactly would all-features=3Don be useful for
> management software?
>=20

I guess "all-features=3Don"  would only be useful for some sort of
introspection (or testing), but not actually for something else I guess.

One interesting use case of "all-features=3Doff/recommended-features=3Don"
could be

-cpu host,all-features=3Doff,recommended-features=3Don

Would allow us to disable all deprecated features when starting a new VM
that we have to keep in the "host" model to keep baseline/runnability
tests working and migration of old VMs unchanged.

--=20
Thanks,

David / dhildenb


