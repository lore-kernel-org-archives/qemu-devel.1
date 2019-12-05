Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91E6C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 14:50:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2C7E2245C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 14:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y6ms4vMJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2C7E2245C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icsSP-0003kr-QH
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 09:50:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1icsR9-0002pY-Gm
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 09:49:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1icsR6-0004cO-R7
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 09:48:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48245
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1icsR6-0004Xm-Em
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 09:48:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575557335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=W9hFwCJdj0olIjCa06RnUIZy1n5wb60wg5egL1IJY/0=;
 b=Y6ms4vMJ/E2m6XA1UXpVuTYyoCPAAd6X26FPZCk1ZpHboT9muGOIy8cu2aeVYlZFrghb74
 fNSnFDYJrmBACwHAQSNvhHbzb8yeBZYqIWvCxoeqrDUmV/1JLzoiQKHDXeWKLjroJEkDiL
 ko4HeKr73JatS4vUBrSPrwp/MKUp1YE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-BBefBAc_PHiPBr0dMJ8e9Q-1; Thu, 05 Dec 2019 09:48:52 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 667DD183B700;
 Thu,  5 Dec 2019 14:48:50 +0000 (UTC)
Received: from [10.36.116.252] (ovpn-116-252.ams2.redhat.com [10.36.116.252])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D40AE5D6A5;
 Thu,  5 Dec 2019 14:48:47 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] s390x/cpumodel: Introduce dynamic feature groups
To: Eduardo Habkost <ehabkost@redhat.com>
References: <b062f580-d664-f68c-2364-1f65df6ee265@de.ibm.com>
 <C829F458-099D-4E95-B835-67F008E60B13@redhat.com>
 <b4f4546d-b620-0428-40bf-59f4584a80f3@de.ibm.com>
 <b4ee8526-b1e3-21ee-5e1e-b22520e29339@redhat.com>
 <20191129193317.GE14595@habkost.net>
 <a5ae30ef-e193-fd22-b3e2-a7626e82d9b1@redhat.com>
 <20191205143506.GG498046@habkost.net>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <b0467d48-1fff-e2ae-4866-1c9dbe03fb6c@redhat.com>
Date: Thu, 5 Dec 2019 15:48:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191205143506.GG498046@habkost.net>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: BBefBAc_PHiPBr0dMJ8e9Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

On 05.12.19 15:35, Eduardo Habkost wrote:
> On Mon, Dec 02, 2019 at 10:15:12AM +0100, David Hildenbrand wrote:
>>
>>>> Say the user has the option to select a model (zEC12, z13, z14), upper
>>>> layers always want to have a model that includes all backported securi=
ty
>>>> features. While the host model can do that, CPU definitions can't. You
>>>> can't change default models within a QEMU release, or for older releas=
es
>>>> (e.g., a z13).
>>>>
>>>
>>> This is a good description of the main use case we're worried
>>> about in x86 too, and the main reason we have added versioned CPU
>>> models.
>>>
>>> I remember I was planning to use `query-cpu-model-expansion` for
>>> "please give me the best configuration for this specific CPU
>>> model" (which would be very similar to the approach used in this
>>> series).  Now, I need to refresh my memory and try to remember
>>> why I concluded this approach wouldn't work for x86.
>>
>> I would be interested in that - I don't really think exposing CPU
>> versions to the user is necessary here.
>>
>> E.g., you can maintain the versions internally and enable the stored
>> features of the fitting one with "recommended-features=3Don...".
>=20
> I was re-reading some code and threads, and now I remember: the
> main obstacle for using query-cpu-model-expansion for CPU model
> version resolution in x86 is the fact that the x86 CPU models
> aren't static yet.  (type=3Dfull expansion isn't useful for CPU the
> use case above; type=3Dstatic expansion requires static CPU models
> to be useful)


I think, you could if you would expand "best X" to something like

-cpu X,all-features=3Doff,featX=3Don,featY=3Don ...

The "all-features" part would need a better name as discussed. Such a
model would always have a defined feature set (all listed features) =3D=3D
static. The list could get a little longer, which is why s390x has these
static "base" features. But that's not a road blocker.

>=20
> I was planning to make x86 CPU models static, then I noticed we
> do have lots of feature flags that depend on the current
> accelerator (set by kvm_default_props) or current machine (set
> by compat_props).  This breaks the rules for static CPU models.

The static models we have (e.g., z13-base) contain a minimum set of
features we expect to be around in every environment (but doesn't have
to). It's just a way to make the featX=3Don,featY=3Don ... list shorter.

X would be expanded to e.g.,

-cpu X-base,featX=3Don,featY=3Don ...

But nothing speaks against having

-cpu X-base,featX=3Doff,featY=3Don ...

A very simplistic base model would be a model without any features.
(like -cpu X,all-features=3Doff), but then it would be set in stone.

>=20
> We can still try to provide useful static CPU models in x86 in
> the future (I want to).  But I don't want to make this an
> obstacle for providing a CPU model update mechanism that works
> for x86 (which is more urgent).
>=20
>>
>>>
>>>
>>>>>
>>>>> Maybe its just the interface or the name. But I find this very non-in=
tuitive
>>>>
>>>> I'm open for suggestions.
>>>>
>>>>>
>>>>> e.g. you wrote
>>>>>
>>>>>     Get the maximum possible feature set (e.g., including deprecated
>>>>>     features) for a CPU definition in the configuration ("everything =
that
>>>>>     could be enabled"):
>>>>>         -cpu z14,all-features=3Doff,available-features=3Don
>>>>>
>>>>>     Get all valid features for a CPU definition:
>>>>>         -cpu z14,all-features=3Don
>>>>>
>>>>> What is the point of this? It is either the same as the one before, o=
r it wont
>>>>> be able to start.=20
>>>>
>>>> valid !=3D available, all !=3D available. Yes, the model won't run unl=
ess
>>>> you are on pretty good HW :)
>>>>
>>>> Maybe I should just have dropped the last example, as it seems to
>>>> confuse people - it's mostly only relevant for introspection via CPU
>>>> model expansion.
>>>>
>>>> I am open for better names. e.g. all-features -> valid-features.
>>>
>>> "all" is not a meaningful name to me.  It surely doesn't mean
>>> "all features in the universe", so it means a more specific set
>>> of features.  How is that set defined?
>>>
>>> "valid" seems clearer, but we still need a description of what
>>> "valid" means exactly.
>>>
>>
>> So, we have
>>
>> +static S390DynFeatGroupDef s390_dyn_feature_groups[] =3D {
>> +    /* "all" corresponds to our "full" definitions */
>> +    DYN_FEAT_GROUP_INIT("all-features", ALL, "Features valid for a CPU
>> definition"),
>> [...]
>> +};
>>
>> it includes features that are not available - all features that could
>> theoretically be enabled for that CPU definition.
>>
>> (e.g., "vx" was introduced with z13 and cannot be enabled for the z12.
>> It's part of the full model of a z13, but not of a z12)
>=20
> Isn't this something already returned by device-list-properties?
>=20

We do register all feature properties for all models. So, yes, it would
have been possible if we (I) would have implemented that differently. We
could (and maybe should) still change that - only register the features
that are part of the "full" model.

--=20
Thanks,

David / dhildenb


