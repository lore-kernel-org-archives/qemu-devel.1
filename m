Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2AEC5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 19:52:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB8722067B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 19:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MZPxwLGp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB8722067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iTAIr-0004WU-Vi
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 14:52:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36558)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iTAHt-0003EA-PN
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 14:51:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iTAHr-0008Ug-UO
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 14:51:17 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53506
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iTAHr-0008TF-K1
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 14:51:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573242674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2SDZFYxwjrS3u6TBjPbPWz4naZ+NLMQXcwfFOLH0NAE=;
 b=MZPxwLGpuh6OIzR5qrzXCW6tspsLxSeBffTI4gIEQ5gRhfjhPWGvboSHnuwdT6hucSns0x
 1t5ykevdij8QwR80XYshoxzYH3T8hMHDfIM6adNQ/F8imB21MJpBnjQII/GIvLU6bJ7C2B
 XzrvV62zxXwMQ4shkcuKgDzw7xY0owQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-drae5vaIOMG_38JOUhdkaw-1; Fri, 08 Nov 2019 14:51:12 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 96C38477;
 Fri,  8 Nov 2019 19:51:11 +0000 (UTC)
Received: from localhost (ovpn-116-57.gru2.redhat.com [10.97.116.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1AED55C298;
 Fri,  8 Nov 2019 19:51:08 +0000 (UTC)
Date: Fri, 8 Nov 2019 16:51:06 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1 2/2] s390x/cpumodel: Introduce "best" model variants
Message-ID: <20191108195106.GA3812@habkost.net>
References: <20191108110714.7475-1-david@redhat.com>
 <20191108110714.7475-3-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191108110714.7475-3-david@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: drae5vaIOMG_38JOUhdkaw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Thomas Huth <thuth@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Michael Mueller <mimu@linux.ibm.com>, Jiri Denemark <jdenemar@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 08, 2019 at 12:07:14PM +0100, David Hildenbrand wrote:
> For a specific CPU model, we have a lot of feature variability depending =
on
> - The microcode version of the HW
> - The hypervisor we're running on (LPAR vs. KVM vs. z/VM)
> - The hypervisor version we're running on
> - The KVM version
> - KVM module parameters (especially, "nested=3D1")
> - The accelerator
>=20
> Our default models are migration safe, however can only be changed
> between QEMU releases (glued to QEMU machine). This somewhat collides
> with the feature variability we have. E.g., the z13 model will not run
> under TCG. There is the demand from higher levels in the stack to "have t=
he
> best CPU model possible on a given accelerator, firmware and HW", which
> should especially include all features that fix security issues.
> Especially, if we have a new feature due to a security flaw, we want to
> have a way to backport this feature to older QEMU versions and a way to
> automatically enable it when asked.
>=20
> This is where "best" CPU models come into play. If upper layers specify
> "z14-best" on a z14, they will get the best possible feature set in that
> configuration. "best" usually means "maximum features", besides deprecate=
d
> features. This will then, for example, include nested virtualization
> ("SIE" feature) when KVM+HW support is enabled, or fixes via
> microcode updates (e.g., spectre)
>=20
> "best" models are not migration safe. Upper layers can expand these
> models to migration-safe and static variants, allowing them to be
> migrated.
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>

Makes sense to me, and the code looks good.  I just have one
question below:

> ---
[...]
> +static void s390_best_cpu_model_initfn(Object *obj)
> +{
> +    const S390CPUModel *max_model;
> +    S390CPU *cpu =3D S390_CPU(obj);
> +    S390CPUClass *xcc =3D S390_CPU_GET_CLASS(cpu);
> +    Error *local_err =3D NULL;
> +    int i;
> +
> +    if (kvm_enabled() && !kvm_s390_cpu_models_supported()) {
> +        return;
> +    }
> +
> +    max_model =3D get_max_cpu_model(&local_err);
> +    if (local_err) {
> +        /* we expect errors only under KVM, when actually querying the k=
ernel */
> +        g_assert(kvm_enabled());
> +        error_report_err(local_err);
> +        return;
> +    }
> +
> +    /*
> +     * Similar to baselining against the "max" model. However, features
> +     * are handled differently and are not used for the search for a def=
inition.
> +     */
> +    if (xcc->cpu_def->gen =3D=3D max_model->def->gen) {
> +        if (xcc->cpu_def->ec_ga > max_model->def->ec_ga) {
> +            return;
> +        }
> +    } else if (xcc->cpu_def->gen > max_model->def->gen) {
> +        return;
> +    }

What exactly is expected to happen if we return from the function
here?

(In x86, we worked around the inability to report errors inside
instance_init by adding another step to CPU object initialization
called "CPU expansion", implemented by
x86_cpu_expand_features().)

> +
> +    /* The model is theoretically runnable, construct the features. */
> +    cpu->model =3D g_new(S390CPUModel, 1);
> +    cpu->model->def =3D xcc->cpu_def;
> +    bitmap_copy(cpu->model->features, xcc->cpu_def->full_feat, S390_FEAT=
_MAX);
> +
> +    /* Mask of features that are not available in the "max" model */
> +    bitmap_and(cpu->model->features, cpu->model->features, max_model->fe=
atures,
> +               S390_FEAT_MAX);
> +
> +    /* Mask off deprecated features */
> +    clear_bit(S390_FEAT_CONDITIONAL_SSKE, cpu->model->features);
> +
> +    /* Make sure every model passes consistency checks */
> +    for (i =3D 0; i < ARRAY_SIZE(cpu_feature_dependencies); i++) {
> +        if (!test_bit(cpu_feature_dependencies[i][1], cpu->model->featur=
es)) {
> +            clear_bit(cpu_feature_dependencies[i][0], cpu->model->featur=
es);
> +        }
> +    }
> +}
[...]

--=20
Eduardo


