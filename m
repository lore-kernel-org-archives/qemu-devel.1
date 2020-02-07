Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E52C2D0B1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 07:38:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DD2C20726
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 07:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZKeu/18R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DD2C20726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izyE1-0007jV-ID
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 02:38:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35638)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1izyDA-0007CC-PJ
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 02:38:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1izyD8-0006T1-MI
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 02:37:59 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32341
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1izyD8-0006RW-EL
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 02:37:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581061077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Pum9DLoPcluppoVUR9e3hm+aPXS0TbibkrITFC+2VM=;
 b=ZKeu/18Ri28c58yRFT1m79cCDXoWcQTkPA0FoTZTeDJLD9Jr2AoFnCm7r3v5qQb3hc53IW
 qkdpRAqhURaWCn0u6GcyKFAWa1al1w4FRcpYKGzQhQNCUb1tfLpbhBS/EFNZL549CHpQwW
 +NaZ4yBLGAHc1k55v+biBI0btpWpk08=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-SXhL_bQ-MbqcyIHfJuLpjQ-1; Fri, 07 Feb 2020 02:37:56 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A190DB60;
 Fri,  7 Feb 2020 07:37:54 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F1705790EA;
 Fri,  7 Feb 2020 07:37:49 +0000 (UTC)
Date: Fri, 7 Feb 2020 08:37:47 +0100
From: Andrew Jones <drjones@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [RFC PATCH v2 5/5] target/arm/cpu: Add the kvm-no-adjvtime CPU
 property
Message-ID: <20200207073747.x3rsqxtfbmtlfqws@kamzik.brq.redhat.com>
References: <20191212173320.11610-1-drjones@redhat.com>
 <20191212173320.11610-6-drjones@redhat.com>
 <CAP+75-Vt3apV8i64oFTC6pAATXkrE1g+tVskr_3ohBHtZ1LNdQ@mail.gmail.com>
 <20200206124047.o4sy52jgbkqeravd@kamzik.brq.redhat.com>
 <2522956e-5dae-3ebc-76d2-010a918e0d19@redhat.com>
MIME-Version: 1.0
In-Reply-To: <2522956e-5dae-3ebc-76d2-010a918e0d19@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: SXhL_bQ-MbqcyIHfJuLpjQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Peter Maydell <peter.maydell@linaro.org>, bijan.mottahedeh@oracle.com,
 Marc Zyngier <maz@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 guoheyi@huawei.com, msys.mizuma@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 06, 2020 at 11:46:49PM +0100, Philippe Mathieu-Daud=E9 wrote:
> On 2/6/20 1:40 PM, Andrew Jones wrote:
> > On Thu, Feb 06, 2020 at 01:08:53PM +0100, Philippe Mathieu-Daud=E9 wrot=
e:
> > ...
> > > > +/* KVM VCPU properties should be prefixed with "kvm-". */
> > > > +void kvm_arm_add_vcpu_properties(Object *obj)
> > > > +{
> > > > +    if (!kvm_enabled()) {
> > >=20
> > > This can't happen, right? Can we turn that into an assertion, or
> > > remove the check?
> >=20
> > You're right. An assert would be more appropriate. Will you send a patc=
h?
>=20
> Apparently this can be called with KVM_CONFIG && !kvm_enabled():
>=20
> See kvm_arm_set_cpu_features_from_host()
> {
>     if (!arm_host_cpu_features.dtb_compatible) {
>         if (!kvm_enabled() ||
>             !kvm_arm_get_host_cpu_features(&arm_host_cpu_features)) {
>             /* We can't report this error yet, so flag that we need to
>              * in arm_cpu_realizefn().
>              */
>=20
> I won't modify your patch (until I have a better understanding of
> TYPE_ARM_HOST_CPU).
>

Just grepped around and talked to Igor. Indeed we need to be able
to do the host cpu init without erroring out (even if we know we
will in realize) and, as cpu instance_init should add the properties,
then I don't really see a cleaner way to do it than what we already
have.

Thanks,
drew


