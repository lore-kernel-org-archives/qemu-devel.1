Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69EBC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 07:52:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B32092068D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 07:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IylwyrmA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B32092068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWbq3-0005mN-U7
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 02:52:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46168)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1iWbpO-0005JH-29
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 02:52:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1iWbpK-0007ai-SH
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 02:52:03 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28301
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1iWbpK-0007ZA-6M
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 02:52:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574063520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyAwD1+k13v8Hz8j0BmKEU56VVvTNwnr20Nb5ovSsUg=;
 b=IylwyrmA5ORELBG6Ri+fXBkQs/3aGs/CZgvW+Y6AxPR7jp3VZkoDH3c7i9JAvSDt9BZ30l
 NrnEa/fp2u/l5+JHRogUP+ZykKsZPceWi/aJkxIFBjuS3KSLNqZeqqur8MrIy1PSFzRvI+
 IgxHGJMtxMJ9xKgs/j153G/zWgYa4rI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-r4m2nfQlNjaUVWqI-7rRLA-1; Mon, 18 Nov 2019 02:51:59 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8651F8048F3;
 Mon, 18 Nov 2019 07:51:58 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A23CC2A881;
 Mon, 18 Nov 2019 07:51:57 +0000 (UTC)
Date: Mon, 18 Nov 2019 08:51:55 +0100
From: Andrew Jones <drjones@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH] target/arm: Clean up arm_cpu_vq_map_next_smaller asserts
Message-ID: <20191118075155.slvqe3lqlmyykm3s@kamzik.brq.redhat.com>
References: <20191115131623.322-1-richard.henderson@linaro.org>
 <20191115160630.ofkre7rp5gszbpcd@kamzik.brq.redhat.com>
 <989b6a18-9391-7351-74f5-9cd012f6aaa2@linaro.org>
MIME-Version: 1.0
In-Reply-To: <989b6a18-9391-7351-74f5-9cd012f6aaa2@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: r4m2nfQlNjaUVWqI-7rRLA-1
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 15, 2019 at 06:45:51PM +0100, Richard Henderson wrote:
> On 11/15/19 5:06 PM, Andrew Jones wrote:
> >>      bitnum =3D find_last_bit(cpu->sve_vq_map, vq - 1);
> >> -    return bitnum =3D=3D vq - 1 ? 0 : bitnum + 1;
> >> +
> >> +    /* We always have vq =3D=3D 1 present in sve_vq_map.  */
> >=20
> > This is true with TCG and 99.9999% likely to be true with KVM...
>=20
> Eh?  It's required by the spec that 128-bit vectors are always supported.

If some vendor messes things up with SVE in a way that makes it impossible
to configure all should-be-supported lengths, then there's a chance KVM
will simply not advertise the lengths that cannot be configured as a
workaround. This may be quite unlikely, but when KVM is in use, IMO, it
should be the sole authority on what lengths are available. Assuming
lengths are available because the spec says so should work, but then
'hardware' is just another way to spell 'errata'...

>=20
>=20
> > Maybe we should just remove this function and put the
> > find_last_bit() call and all input/output validation directly in
> > sve_zcr_get_valid_len() ?
>=20
> But that makes sense all on its own, so we don't do quite so much +1/-1 f=
affing
> about.
>

Thanks,
drew=20


