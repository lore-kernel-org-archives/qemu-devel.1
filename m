Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5988DC33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 12:36:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22828206E6
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 12:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XraR7ilb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22828206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isQrE-0001mV-6a
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 07:36:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42716)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1isQqQ-0000nl-7c
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 07:35:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1isQqK-0004gE-TT
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 07:35:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38769
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1isQqK-0004ea-Oz
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 07:35:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579264515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wIj+MczCG4WSldzv1cpuWJYm1AJ4IdHHZXML962KjOw=;
 b=XraR7ilb/w19GdonU2lITXyfaTFC51ilbWQY0XQ07gCQj/ioTSAd61geH5BU5Xo7JO70lt
 qn1mFNudQek3DiIK4sWUyKki4wNm37ptTwOWRXRPBKI+qHgT5sRxBMfr1f/b6lDoGhNl2p
 7itqH9XKj/XoYeDJF9wTqXPyDnTCOdI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-ZEnuW-tyPsuI7IMKqjtLjw-1; Fri, 17 Jan 2020 07:35:14 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 98F76800D4E
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 12:35:13 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5630B5DA60;
 Fri, 17 Jan 2020 12:35:07 +0000 (UTC)
Date: Fri, 17 Jan 2020 12:35:04 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 0/3] exclude hyperv synic sections from vhost
Message-ID: <20200117123504.GF3209@work-vm>
References: <20200113173647.84842-1-dgilbert@redhat.com>
 <1bab529a-8655-ee28-f137-0311fb7839ff@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1bab529a-8655-ee28-f137-0311fb7839ff@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: ZEnuW-tyPsuI7IMKqjtLjw-1
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
Cc: jasowang@redhat.com, vkuznets@redhat.com, qemu-devel@nongnu.org,
 mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Paolo Bonzini (pbonzini@redhat.com) wrote:
> On 13/01/20 18:36, Dr. David Alan Gilbert (git) wrote:
> >=20
> > Hyperv's synic (that we emulate) is a feature that allows the guest
> > to place some magic (4k) pages of RAM anywhere it likes in GPA.
> > This confuses vhost's RAM section merging when these pages
> > land over the top of hugepages.
>=20
> Can you explain what is the confusion like?  The memory API should just
> tell vhost to treat it as three sections (RAM before synIC, synIC
> region, RAM after synIC) and it's not clear to me why postcopy breaks
> either.

See my v3 I posted yesterday; I've made this a lot simpler by just
turning the alignment off for vhost-kernel and only enabling it for
vhost-user;  vhost-user skips any section without a backing fd anyway,
so the synic problem goes away, as does another problem reported by
Peter Lieven that he was seeing that seemed like one of the VGA regions
getting in the way (which I'd not seen before).

Dave

> Paolo
>=20
> > Since they're not normal RAM, and they shouldn't have vhost DMAing
> > into them, exclude them from the vhost set.
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


