Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD49C5517A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:32:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE37121655
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PuZzQEC3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE37121655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXO99-0003YJ-Kc
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 08:32:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kXNJg-00067c-9O
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:39:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27374)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kXNJZ-0002XL-7I
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:39:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603798733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9/Lk0Z/abYuMGYWcNvroMVff2Hjn9nClvaQd6Mb+XZI=;
 b=PuZzQEC3Lnmtt1PLn16YlMFeuwJhewIyiTIgDWxYTh+JDPPr6ss/5ApqbbB/GxExOItfad
 UAwemskiaA7emOTSpaSKALqZ9nDz/fZhuY2It3/A+4tVgul5RvggEf5FGEHRrxiOwB7k6n
 MH2du3AChrl2OzgNwgI9Bx7rrJxLGPc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-PVborCGLMP-w3avOdfXIRg-1; Tue, 27 Oct 2020 07:38:52 -0400
X-MC-Unique: PVborCGLMP-w3avOdfXIRg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6EE664096;
 Tue, 27 Oct 2020 11:38:50 +0000 (UTC)
Received: from gondolin (ovpn-113-207.ams2.redhat.com [10.36.113.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4ADC65D9DD;
 Tue, 27 Oct 2020 11:38:49 +0000 (UTC)
Date: Tue, 27 Oct 2020 12:38:46 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 2/6] configure: avoid new clang 11+ warnings
Message-ID: <20201027123846.18dd5c91.cohuck@redhat.com>
In-Reply-To: <4ca1ef0b-fe52-a5e5-485a-2827fda58f4d@redhat.com>
References: <20201023200645.1055-1-dbuono@linux.vnet.ibm.com>
 <20201023200645.1055-3-dbuono@linux.vnet.ibm.com>
 <96d4c76c-dfbb-f985-2718-0892ea1b83d4@redhat.com>
 <a5a32430-6eaa-1734-a402-4b0a3e079827@linux.vnet.ibm.com>
 <98a03470-4694-f63a-7104-ae576e4799ce@redhat.com>
 <4ca1ef0b-fe52-a5e5-485a-2827fda58f4d@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Daniel P . =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org,
 Alexander Bulekov <alxndr@bu.edu>, Paolo Bonzini <pbonzini@redhat.com>,
 Daniele Buono <dbuono@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 27 Oct 2020 12:26:21 +0100
Thomas Huth <thuth@redhat.com> wrote:

> On 26/10/2020 16.12, Paolo Bonzini wrote:
> > On 26/10/20 16:03, Daniele Buono wrote: =20
> >> Hi Paolo,
> >> I reorganized UASStatus to put uas_iu at the end and it works fine.
> >> Unfortunately, this uncovered another part of the code with a similar
> >> issue (variable sized type not at the end of the struct), here:
> >>
> >> In file included from ../qemu-cfi-v3/target/s390x/diag.c:21:
> >> ../qemu-cfi-v3/hw/s390x/ipl.h:161:23: error: field 'iplb' with variabl=
e
> >> sized type 'IplParameterBlock' (aka 'union IplParameterBlock') not at
> >> the end of a struct or class is a GNU extension
> >> [-Werror,-Wgnu-variable-sized-type-not-at-end]
> >> =C2=A0=C2=A0=C2=A0 IplParameterBlock iplb;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
> >> ../qemu-cfi-v3/hw/s390x/ipl.h:162:23: error: field 'iplb_pv' with
> >> variable sized type 'IplParameterBlock' (aka 'union IplParameterBlock'=
)
> >> not at the end of a struct or class is a GNU extension
> >> [-Werror,-Wgnu-variable-sized-type-not-at-end]
> >> =C2=A0=C2=A0=C2=A0 IplParameterBlock iplb_pv;
> >>
> >> My understanding is that each of these IplParameterBlock may contain
> >> either a IPLBlockPV or a IplBlockFcp, which both end with a variable
> >> sized field (an array).
> >>
> >> Adding maintainers of s390x to see if they have a suggested solution t=
o
> >> avoid disabling the warning. =20
> >=20
> > This one seems okay because the union constrains the size to 4K. If
> > "[0]" is enough to shut up the compiler, I'd say do that. =20
>=20
> The "IplBlockFcp fcp" part seems to be completely unused, so I think you
> could even remove that IplBlockFcp struct. For IPLBlockPV I agree with
> Paolo, it's likely easiest to use [0] for that struct.

The fcp block had probably been added for completeness' sake, but we do
not support list-directed IPL anyway. Not sure if we actually want it,
as we use a different mechanism for IPLing from SCSI devices. So yes,
maybe we should just drop it.


