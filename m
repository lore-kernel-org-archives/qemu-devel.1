Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DB9C54FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 15:50:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DFE52064C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 15:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UtTpQgjK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DFE52064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQv9y-0001ZG-Ud
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 11:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48158)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jQv7x-0008CD-Bs
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 11:48:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jQv7v-0008T6-MN
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 11:48:01 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57526
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jQv7v-0008Sg-91
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 11:47:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587484077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wPwb4x4cd+R4RX8OqtFGynxiKePNqZR0NvZBNGYP3jQ=;
 b=UtTpQgjKS4mCNXyXZJkf8reZRiMhZo1Pw9UG2QNRJtfbFhpuTTAdXVXWJ121rgqIe7lKYZ
 oPgZ5wsGKuvwHaSC6St+q2os9xFZCjk99rdn93COwh5FvOxOkLHYCXht5bysveKQqVP2hy
 uLYIA8eAZ0+aSR+Z2kl+HMyp82w/tqk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-alZCC0GiMcqXaa89HOIS-A-1; Tue, 21 Apr 2020 11:47:55 -0400
X-MC-Unique: alZCC0GiMcqXaa89HOIS-A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F414DB60;
 Tue, 21 Apr 2020 15:47:54 +0000 (UTC)
Received: from linux.fritz.box (ovpn-112-155.ams2.redhat.com [10.36.112.155])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2629B5C1B2;
 Tue, 21 Apr 2020 15:47:51 +0000 (UTC)
Date: Tue, 21 Apr 2020 17:47:50 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Klaus Birkelund Jensen <its@irrelevant.dk>
Subject: Re: [PATCH v2 00/16] nvme: refactoring and cleanups
Message-ID: <20200421154750.GC22440@linux.fritz.box>
References: <20200415130159.611361-1-its@irrelevant.dk>
 <20200420173832.GA10592@redsun51.ssa.fujisawa.hgst.com>
 <20200421063850.wayw2eytcywio6tr@apples.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200421063850.wayw2eytcywio6tr@apples.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 01:28:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Beata Michalska <beata.michalska@linaro.org>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 21.04.2020 um 08:38 hat Klaus Birkelund Jensen geschrieben:
> On Apr 21 02:38, Keith Busch wrote:
> > The series looks good to me.
> >=20
> > Reviewed-by: Keith Busch <kbusch@kernel.org>
>=20
> Thanks for the review Keith!
>=20
> Kevin, should I rebase this on block-next? I think it might have some
> conflicts with the PMR patch that went in previously.

The series doesn't apply at the moment anyway, I assume it's because of
the PMR patch. So yes, I would appreciate a rebase.

Kevin


