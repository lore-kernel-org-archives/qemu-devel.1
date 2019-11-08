Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C249FC6196
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 21:21:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E82E6207FA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 21:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="diOEJ5xJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E82E6207FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iTBh0-0002Cz-Vp
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 16:21:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57254)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iTBf0-00004u-5W
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 16:19:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iTBex-0001wQ-7K
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 16:19:12 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52669
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iTBew-0001vl-P6
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 16:19:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573247949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6s3ITbJGajhFHbc7AlBEtLO1ct+RyjyTG2G0SU4xjDU=;
 b=diOEJ5xJPOD0km9rPhN2H//Zq1PLiZPChApB5ZmTx4h2ajsBQr/sj2c6IYzQm0bzXXC/Et
 MXPoUGguGsR5kZd2TrpOsGh71eHFsSjkpPVTJW/4BJNB/XXNsBkspcc/g2ar8JYOBkqRMm
 TZ8ZH7vBVDAWxM9kuxd2BwWSrD+sUmI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-HeSrCRy9OU-nYK0G9SOr1A-1; Fri, 08 Nov 2019 16:19:06 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 288D62A3;
 Fri,  8 Nov 2019 21:19:05 +0000 (UTC)
Received: from [10.36.116.65] (ovpn-116-65.ams2.redhat.com [10.36.116.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D1A21177DD;
 Fri,  8 Nov 2019 21:18:57 +0000 (UTC)
Subject: Re: [PATCH v1 2/2] s390x/cpumodel: Introduce "best" model variants
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20191108110714.7475-1-david@redhat.com>
 <20191108110714.7475-3-david@redhat.com> <20191108195106.GA3812@habkost.net>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <2bebdcd5-799a-8c8b-62fa-455cf284f6ad@redhat.com>
Date: Fri, 8 Nov 2019 22:18:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191108195106.GA3812@habkost.net>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: HeSrCRy9OU-nYK0G9SOr1A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
 Michael Mueller <mimu@linux.ibm.com>, Jiri Denemark <jdenemar@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08.11.19 20:51, Eduardo Habkost wrote:
> On Fri, Nov 08, 2019 at 12:07:14PM +0100, David Hildenbrand wrote:
>> For a specific CPU model, we have a lot of feature variability depending=
 on
>> - The microcode version of the HW
>> - The hypervisor we're running on (LPAR vs. KVM vs. z/VM)
>> - The hypervisor version we're running on
>> - The KVM version
>> - KVM module parameters (especially, "nested=3D1")
>> - The accelerator
>>
>> Our default models are migration safe, however can only be changed
>> between QEMU releases (glued to QEMU machine). This somewhat collides
>> with the feature variability we have. E.g., the z13 model will not run
>> under TCG. There is the demand from higher levels in the stack to "have =
the
>> best CPU model possible on a given accelerator, firmware and HW", which
>> should especially include all features that fix security issues.
>> Especially, if we have a new feature due to a security flaw, we want to
>> have a way to backport this feature to older QEMU versions and a way to
>> automatically enable it when asked.
>>
>> This is where "best" CPU models come into play. If upper layers specify
>> "z14-best" on a z14, they will get the best possible feature set in that
>> configuration. "best" usually means "maximum features", besides deprecat=
ed
>> features. This will then, for example, include nested virtualization
>> ("SIE" feature) when KVM+HW support is enabled, or fixes via
>> microcode updates (e.g., spectre)
>>
>> "best" models are not migration safe. Upper layers can expand these
>> models to migration-safe and static variants, allowing them to be
>> migrated.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>=20
> Makes sense to me, and the code looks good.  I just have one
> question below:
>=20
>> ---
> [...]
>> +static void s390_best_cpu_model_initfn(Object *obj)
>> +{
>> +    const S390CPUModel *max_model;
>> +    S390CPU *cpu =3D S390_CPU(obj);
>> +    S390CPUClass *xcc =3D S390_CPU_GET_CLASS(cpu);
>> +    Error *local_err =3D NULL;
>> +    int i;
>> +
>> +    if (kvm_enabled() && !kvm_s390_cpu_models_supported()) {
>> +        return;
>> +    }
>> +
>> +    max_model =3D get_max_cpu_model(&local_err);
>> +    if (local_err) {
>> +        /* we expect errors only under KVM, when actually querying the =
kernel */
>> +        g_assert(kvm_enabled());
>> +        error_report_err(local_err);
>> +        return;
>> +    }
>> +
>> +    /*
>> +     * Similar to baselining against the "max" model. However, features
>> +     * are handled differently and are not used for the search for a de=
finition.
>> +     */
>> +    if (xcc->cpu_def->gen =3D=3D max_model->def->gen) {
>> +        if (xcc->cpu_def->ec_ga > max_model->def->ec_ga) {
>> +            return;
>> +        }
>> +    } else if (xcc->cpu_def->gen > max_model->def->gen) {
>> +        return;
>> +    }
>=20
> What exactly is expected to happen if we return from the function
> here?

cpu->model is NULL. That fact (and xcc->is_best) is checked when the=20
model is to be used (e.g., via qmp or when creating VCPUs), and a rather=20
generic error is reported. This is suboptimal and ...

>=20
> (In x86, we worked around the inability to report errors inside
> instance_init by adding another step to CPU object initialization
> called "CPU expansion", implemented by
> x86_cpu_expand_features().)

... doing something like that makes a lot of sense. We also have to=20
rework this for the "host" and "max" model.

I'll look into that when I'm back from holidays in one week.

Thanks!

--=20

Thanks,

David / dhildenb


