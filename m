Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29236C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 12:11:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0AE8206A4
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 12:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HIlo4hpK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0AE8206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVwPo-00075I-2Y
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 08:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jVwP5-0006b8-KG
 for qemu-devel@nongnu.org; Tue, 05 May 2020 08:10:27 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42521
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jVwP4-00050I-NR
 for qemu-devel@nongnu.org; Tue, 05 May 2020 08:10:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588680625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4rvkycHLd0dtr2wb2Q8NmoVQu+pDZL75e9l/4dBiiWc=;
 b=HIlo4hpKa1cWgROoJrrRhdQw0y1bW0beH5ab/p/wy7Pb+4pgkAnkmajStq2QDEkBV789Kk
 AqSS0SyIv+hJJYuUQySvJornusPMBHB7/H4JmWh1UmJ0hEGk3ls+Lk+Op1J61dSP8crI1u
 JMEnOQpeE6xoT2OzkVeFoPZ9xAnRLLA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-cbA3BEwpPJ20cAUxCi9HlQ-1; Tue, 05 May 2020 08:10:24 -0400
X-MC-Unique: cbA3BEwpPJ20cAUxCi9HlQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A914107ACF5;
 Tue,  5 May 2020 12:10:22 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.34])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C021760C80;
 Tue,  5 May 2020 12:10:16 +0000 (UTC)
Message-ID: <9b2ebceafa7a5c6598cfcb32120569b656f21fad.camel@redhat.com>
Subject: Re: [PATCH v5 06/18] nvme: refactor nvme_addr_read
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
Date: Tue, 05 May 2020 15:10:15 +0300
In-Reply-To: <20200505055252.dtk3w355nrcfmszs@apples.localdomain>
References: <20200505054840.186586-1-its@irrelevant.dk>
 <20200505054840.186586-7-its@irrelevant.dk>
 <20200505055252.dtk3w355nrcfmszs@apples.localdomain>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-05-05 at 07:52 +0200, Klaus Jensen wrote:
> On May  5 07:48, Klaus Jensen wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> >=20
> > Pull the controller memory buffer check to its own function. The check
> > will be used on its own in later patches.
> >=20
> > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > Reviewed-by: Maxim Levitsky <mlevitsky@redhat.com>
> > Reviewed-by: Keith Busch <kbusch@kernel.org>
> > ---
> >  hw/block/nvme.c | 16 ++++++++++++----
> >  1 file changed, 12 insertions(+), 4 deletions(-)
> >=20
>=20
> Woops, noticed that Maxim's R-b is wrong here, please update it to
>=20
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
>=20
> (without the 'y') when merging.
>=20
Well. When I worked for Intel, my email used to be mlevtsky@intel.com,
because I misspelled my private email (maximlevitsky@gmail.com) in my CV, a=
nd somehow this got
propagated to my username there.

Sure enough when I applied to work for Red Hat, I triple checked this to av=
oid such a mistake.
Well.... our usernames are limited to 8 characters.

Best regards,
=09Maxim Levitsky


