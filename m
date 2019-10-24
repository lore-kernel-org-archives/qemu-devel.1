Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF457CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:25:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73AB92070B
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iEQaeF/5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73AB92070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNe3X-00063b-0P
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 10:25:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56200)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iNd2H-0001A6-Pi
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:20:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iNd2G-0004WT-KL
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:20:17 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59810
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iNd2G-0004WC-G2
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:20:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571923215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dFQoGfpS1HQXwntdG/VX1KVG538kYO/FgEKROyAQN3s=;
 b=iEQaeF/5eNC6VYeWyxpwR2upzM5nHSWRSJrJBjT/poPNeTl1KtF8l3dzUbvyL9DlDvOYhj
 gRVn1j6+Sz1ZaUTZ231E/Cf3s1XDTb++AaXqm1sL5SOHMkRIbd+S2sqkjYGM4O49wIE/Fx
 od5ZczKlluK/g9B/1NirWdrXSad9e6w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-RsMl1G9nOzui0Yugpi__4A-1; Thu, 24 Oct 2019 09:20:10 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87F1F5E4;
 Thu, 24 Oct 2019 13:20:08 +0000 (UTC)
Received: from localhost (ovpn-116-62.gru2.redhat.com [10.97.116.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1DE005D9CA;
 Thu, 24 Oct 2019 13:20:07 +0000 (UTC)
Date: Thu, 24 Oct 2019 10:20:07 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v13 01/12] util/cutils: Add qemu_strtotime_ps()
Message-ID: <20191024132007.GP6744@habkost.net>
References: <20191020111125.27659-1-tao3.xu@intel.com>
 <20191020111125.27659-2-tao3.xu@intel.com>
 <20191024095457.GD3700@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191024095457.GD3700@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: RsMl1G9nOzui0Yugpi__4A-1
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
Cc: jingqi.liu@intel.com, Tao Xu <tao3.xu@intel.com>, fan.du@intel.com,
 qemu-devel@nongnu.org, jonathan.cameron@huawei.com, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 24, 2019 at 10:54:57AM +0100, Daniel P. Berrang=E9 wrote:
> On Sun, Oct 20, 2019 at 07:11:14PM +0800, Tao Xu wrote:
> > To convert strings with time suffixes to numbers, support time unit are
> > "ps" for picosecond, "ns" for nanosecond, "us" for microsecond, "ms"
> > for millisecond or "s" for second.
> >=20
> > Signed-off-by: Tao Xu <tao3.xu@intel.com>
> > ---
> >=20
> > No changes in v13.
> > ---
> >  include/qemu/cutils.h |  1 +
> >  util/cutils.c         | 82 +++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 83 insertions(+)
>=20
> This really ought to have an addition to the unit tests to validating
> the parsing, both success and error scenarios, so that we're clear on
> exactly what strings are accepted & rejected.

Unit tests are in patch 02/12.  It's a good idea to squash
patches 01 and 02 together.

--=20
Eduardo


