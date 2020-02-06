Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31849C33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 15:53:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F16A020838
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 15:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F30pYhJb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F16A020838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izjTY-0001H5-5U
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 10:53:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53075)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1izjSn-0000oC-QU
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 10:53:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1izjSm-0001hR-Pb
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 10:53:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21932
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1izjSm-0001b3-Lm
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 10:53:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581004388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SrlzXqAgS43yvtiF0w/W/U7K6rGo5MPYAv+baJk1XeY=;
 b=F30pYhJbInfJfmX/TOh77wXn03dKyPzZpLjn46aP8zG/+bUJd6oqreSpg5bu9fUlAAPD3P
 Uwk0+1RgVg6QYGzIXsPZ7BVO/0XZCd4MGGXwDI734Uu6P1Xe0xvhyFQFI9sinv6XOflMNU
 Wd1xszPmVGa4XlhSGUhBmWT7X5z4wLc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-oohe3vy7Ory6dr9mksbSZw-1; Thu, 06 Feb 2020 10:52:52 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53A9C10054E3;
 Thu,  6 Feb 2020 15:52:51 +0000 (UTC)
Received: from localhost (unused-10-15-17-6.yyz.redhat.com [10.15.17.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2010560C05;
 Thu,  6 Feb 2020 15:52:51 +0000 (UTC)
Date: Thu, 6 Feb 2020 10:52:50 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
To: "Moger, Babu" <Babu.Moger@amd.com>
Subject: Re: [PATCH] i386: pass CLZERO to guests with EPYC CPU model on AMD
 ZEN platform
Message-ID: <20200206155250.GA25446@habkost.net>
References: <1576659933-37123-1-git-send-email-ani.sinha@nutanix.com>
 <2883fd0e-191a-c5a4-be1c-04442c8de1c9@redhat.com>
 <20191218151144.GN498046@habkost.net>
 <D67E411E-4398-4F1B-A397-E637BCD4F666@nutanix.com>
 <20200205223731.GY25446@habkost.net>
 <CY4PR12MB157489B70F2AD26C97779E40951D0@CY4PR12MB1574.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <CY4PR12MB157489B70F2AD26C97779E40951D0@CY4PR12MB1574.namprd12.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: oohe3vy7Ory6dr9mksbSZw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani.sinha@nutanix.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Singh,
 Brijesh" <brijesh.singh@amd.com>, "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 06, 2020 at 12:00:04AM +0000, Moger, Babu wrote:
> [AMD Official Use Only - Internal Distribution Only]

Considering that this was posted to qemu-devel, I'm assuming this
notice was added by accident.

>=20
[...]
> Eduardo,  I am still waiting for your feedback on this series.
> https://lore.kernel.org/qemu-devel/abd39b75-0a12-5198-5815-dd51a3d5c901@a=
md.com/
>=20
> I have added all the missing feature bits for EPYC models(as
> EPYC-v3) and also added EPYC-Rome model.

I'm still catching up on email and my review queue, but this is
on my list.  Sorry for the long delay!

--=20
Eduardo


