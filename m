Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7622C83000
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:37:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2BBD2072A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cWIb9oDR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2BBD2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUAJC-00022F-PG
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 10:37:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33304)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jUAFF-0004pP-72
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:32:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jUAFE-0005i7-3b
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:32:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31708
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jUAFD-0005hk-N6
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:32:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588257174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I5TkZOqHbTzzm/QsUOjbLvPPxG0Sfhg1x9WzxeFTqY0=;
 b=cWIb9oDRo8c5Z6FRRvyWF5oI3fCbKtvHIkXM5mrq4U+ewE54K9PCCWYuMWwDHwYQ/WVL3v
 wQzRl6GpLg6bf/6dBiYX76IzeTxTmUEokDvy9gOdbSer1D63XZmwYPYe0MQfcPIZuMc92H
 f0LD98sQQOwMw2OEu+fCG56oz9mo5Z4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-4omgGzAOOTqY2GONuM6_qg-1; Thu, 30 Apr 2020 10:32:53 -0400
X-MC-Unique: 4omgGzAOOTqY2GONuM6_qg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A74B9107B265;
 Thu, 30 Apr 2020 14:32:49 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-60.ams2.redhat.com [10.36.114.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C29F10013BD;
 Thu, 30 Apr 2020 14:32:48 +0000 (UTC)
Date: Thu, 30 Apr 2020 16:32:46 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 2/6] vmdk: Fix zero cluster allocation
Message-ID: <20200430143246.GC6578@linux.fritz.box>
References: <20200430133007.170335-1-kwolf@redhat.com>
 <20200430133007.170335-3-kwolf@redhat.com>
 <80e85c9e-8f3a-7e65-252d-da625a7e077f@redhat.com>
MIME-Version: 1.0
In-Reply-To: <80e85c9e-8f3a-7e65-252d-da625a7e077f@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 23:34:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 30.04.2020 um 16:19 hat Eric Blake geschrieben:
> On 4/30/20 8:30 AM, Kevin Wolf wrote:
> > m_data must be contain valid data even for zero clusters when no cluste=
r
> > was allocated in the image file. Without this, zero writes segfault wit=
h
> > images that have zeroed_grain=3Don.
>=20
> zero_grained=3Don ?

No, zeroed_grain is the actual name of the option.

I don't really know what a grain is in VMDK terminology, but about the
only thing that felt healthy about the code I touched was that it has
whole-grain buffers. :-)

Kevin


