Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6419C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 15:25:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D72E20746
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 15:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M3hOyQac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D72E20746
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVzRY-0007ew-Gy
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 11:25:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jVzQV-0006dL-U1
 for qemu-devel@nongnu.org; Tue, 05 May 2020 11:24:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32110
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jVzQU-0002v5-Pn
 for qemu-devel@nongnu.org; Tue, 05 May 2020 11:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588692245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nX2oaopRE69VLjZ2lsaol24GZA4O8jo8qSTmlgELCMk=;
 b=M3hOyQacpwaxlcyWeefahBMk095sUaevrKHZA2lny3oU83P+y7SKbPm0czV4pyAYLvAmgT
 xsYoWwgNZTV2yItOk2NwvPZeZGKa82bjw53mBKtHMl8PxE400F8W1nLdieA3TfrJYCQdJN
 8Vp3v7kPSG+7uoyx/f+NPRpqnFXDjHw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-XSSgc8kbMI-rbV8us4pIWA-1; Tue, 05 May 2020 11:24:03 -0400
X-MC-Unique: XSSgc8kbMI-rbV8us4pIWA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A8921800D4A;
 Tue,  5 May 2020 15:24:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7DE395D9D5;
 Tue,  5 May 2020 15:23:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 09DD211358BC; Tue,  5 May 2020 17:23:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 08/17] s390x/cpumodel: Fix UI to CPU features
 pcc-cmac-{aes, eaes}-256
References: <20200428163419.4483-1-armbru@redhat.com>
 <20200428163419.4483-9-armbru@redhat.com>
 <7ed42e2f-e437-3d06-e46b-5416e4d2a6d3@redhat.com>
 <874kt0bzq8.fsf@dusky.pond.sub.org>
 <83638290-f00e-7d50-225b-efee0179ff9c@redhat.com>
 <87368i6eed.fsf@dusky.pond.sub.org>
 <68f9c124-aeea-4369-52bf-3f4c7f579a64@redhat.com>
 <87mu6ma29y.fsf@dusky.pond.sub.org>
 <b7a05485-34c3-3e3f-db73-96056ea7de62@redhat.com>
Date: Tue, 05 May 2020 17:23:58 +0200
In-Reply-To: <b7a05485-34c3-3e3f-db73-96056ea7de62@redhat.com> (David
 Hildenbrand's message of "Tue, 5 May 2020 16:46:42 +0200")
Message-ID: <87mu6m8kxd.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 03:48:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: berrange@redhat.com, ehabkost@redhat.com, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 pbonzini@redhat.com, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

David Hildenbrand <david@redhat.com> writes:

> [...]
>
>>           1                 "msa4-base": true,
>>           1                 "pcc-cmac-aes-256": false,
>>           1                 "pcc-cmac-eaes-256": false,
>>=20
>> The grouping and masking you described appears to apply to
>> query-cpu-model-expansion with type "static".  With type "full", I can
>> see the grouping, but not the masking.  With query-cpu-definitions, I
>> can't see either.
>>=20
>> I haven't played with query-cpu-model-comparison and
>> query-cpu-model-baseline.
>
> Grouping will be done whenever all features part of a group are to be
> reported. Please note that "msa4-base" is part of "msa4".
>
> You chose the only model where we do have msa4-base but none of the
> other msa4 features - the qemu model.

Ah, "lucky" random pick.

> So when you do a "query-cpu-definitions" under TCG (which basically maps
> to the qemu model and only has the msa4-base feature), then you do have
> msa4-base of all relevant models, but none of the other sub-features
> they define. That's why you don't see msa4 explicitly, but instead the
> subfeatures.
>
> query-cpu-model-expansion and the others behave similar the same way
> with the "qemu" model. Note that the qemu model is not really used under
> KVM on s390x. There, we use "host" as default.

Next random pick: z13.2 shows msa4 before and after.

>>>> But "'-cpu' setup" doesn't seem to be about reporting features.  Am I
>>>> confused?
>>>>
>>>
>>> Let me clarify. Any user input would be broken if the two sub-features
>>> would be specified explicitly, instead of the whole "msa4" group. This
>>> applies to any user input, also the user input for query-cpu-model-.
>>>
>>> In the usual cases, libvirt will expand a cpu model (e.g., "host",
>>> "z15") and start QEMU with that (-cpu ...). We will only have the
>>> complete msa4 group here in practice.
>>>
>>> Yes, if some user would pick and chose such features manually, it would
>>> be broken - it's just not the common on s390x with the huge amount of
>>> features. But that's why I thing stable backports still make sense.
>>=20
>> The commit message should be accurate and sufficiently precise.  The
>> "sufficiently" gives me some wiggle room to avoid inaccuracy due to my
>> ignorance.  Would the following be good enough?
>>=20
>>     Impact:
>>    =20
>>     * s390_feat_bitmap_to_ascii() misidentifies S390_FEAT_PCC_CMAC_AES_2=
56
>>       as "pcc-cmac-eaes-256".  Affects QMP commands query-cpu-definition=
s,
>>       query-cpu-model-expansion, query-cpu-model-baseline,
>>       query-cpu-model-comparison, and the error message when
>>       s390_realize_cpu_model() fails in check_compatibility().
>>    =20
>>     * s390_cpu_list() also misidentifies it.  Affects -cpu help.
>>    =20
>>     * s390_cpu_model_register_props() creates CPU property
>>       "pcc-cmac-eaes-256" twice.  The second one fails, but the error is
>>       ignored (a later commit will change that).  Results in a single
>>       property "pcc-cmac-eaes-256" with the description for
>>       S390_FEAT_PCC_CMAC_AES_256, and no property for
>>       S390_FEAT_PCC_CMAC_EAES_256.  CPU properties are visible in CLI -c=
pu
>>       and -device, QMP & HMP device_add, QMP device-list-properties, and
>>       QOM introspection.
>>=20
>>     The two features are almost always used via their group msa4.  Such
>>     use is not affected by this bug.
>
> Yeah, sounds good, thanks.

Excellent.


