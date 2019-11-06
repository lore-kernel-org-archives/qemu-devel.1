Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F5EC5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 16:44:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20A1C2087E
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 16:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KOPZKzjG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20A1C2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSOPl-0000sd-6T
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 11:44:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37898)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iSOOy-0008V9-LL
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 11:43:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iSOOw-0007Rn-Hq
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 11:43:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47309
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iSOOw-0007Qr-AB
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 11:43:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573058601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iwocsOP5rhvMkkxppm42laPpCF3KdEWYxiboPm4oDbg=;
 b=KOPZKzjGf5rEABRkbrHKbyN1rEsahL3kPEvc5bUYWdCwQjNvNdm9gSKl4Mt29Wfq2ygHBT
 cxChzYJNuax49ugBat1o/aIkuoJpudbpos4Bgb9eJzA3Yg279H0sIAOG9b2O7CI7XwAG/K
 H/h9AaPY4m+QuV/Hh5CYu4Rutt4cZ40=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-H5mdFFipPv28r_ugv2-lDA-1; Wed, 06 Nov 2019 11:43:13 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 606FE2A3;
 Wed,  6 Nov 2019 16:43:12 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 37AA55D70D;
 Wed,  6 Nov 2019 16:43:08 +0000 (UTC)
Message-ID: <3a91aed3b2145167e649c0b85f97c394a9c16434.camel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 00/11] RFC crypto/luks: encryption key
 managment using amend interface
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Date: Wed, 06 Nov 2019 18:43:06 +0200
In-Reply-To: <871rvpj7z0.fsf@dusky.pond.sub.org>
References: <20190912223028.18496-1-mlevitsk@redhat.com>
 <632e3a8b-ee54-50e0-83a2-ea82ad8e061f@redhat.com>
 <d371336cfe6b8428ebc9a68a9787c19082e9f0de.camel@redhat.com>
 <871rvpj7z0.fsf@dusky.pond.sub.org>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: H5mdFFipPv28r_ugv2-lDA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2019-10-07 at 10:05 +0200, Markus Armbruster wrote:
> Maxim Levitsky <mlevitsk@redhat.com> writes:
>=20
> > On Fri, 2019-09-20 at 17:14 -0400, John Snow wrote:
> > >=20
> > > On 9/12/19 6:30 PM, Maxim Levitsky wrote:
> > > > This patch series is continuation of my work to add encryption
> > > > key managment to luks/qcow2 with luks.
> > > >=20
> > > > This is second version of this patch set.
> > > > The changes are mostly addressing the review feedback,
> > > > plus I tested (and fixed sadly) the somewhat ugly code
> > > > that allows to still write share a raw luks device,
> > > > while preveting the key managment from happening in this case,
> > > > as it is unsafe.
> > > > I added a new iotest dedicated to that as well.
> > > >=20
> > > > Best regards,
> > > > =09Maxim Levitsky
> > > >=20
> > >=20
> > > What branch is this based on?
> > > It doesn't seem to apply to origin/master.
> > >=20
> > > --js
> >=20
> > It is based on refactoring patch series I send before,
> > which is also under review:
> > "[PATCH v2 00/13] RFC crypto/luks: preparation for encryption key manag=
ment"
>=20
> Recommend to note such dependencies in the cover letter as
>=20
> Based-on: <message-id>
I'll take a note!
Note that now all these patches are merged thus,
this patch series should more or less apply on
top of master branch.
I'll probably resend a V3 after I finish going
over the review of this series.


Best regards,
=09Maxim Levitsky


