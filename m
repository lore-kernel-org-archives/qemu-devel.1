Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1216C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 18:03:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A54B82158A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 18:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iMe7FaBj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A54B82158A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iakcU-000260-Mg
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 13:03:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55818)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iaka5-0000qT-0P
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 13:01:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iakZz-00023U-8V
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 13:01:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43725
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iakZw-0001xz-84
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 13:01:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575050468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X5u1/UP9ViJmraIHgBX1gw8H4uE9NUjyP4nOUVJwPFY=;
 b=iMe7FaBjnn3JV+I7GOT2rDiliAERE2MChGblhAqXdSYywQMOGDCr+dAurPhB3Uq3a36XHp
 MFzuwtMi0i1KIOkuk+0Q3QTb66PkxcoPrI+ncLD+1NYR3qK/DpQowIPtEfuBgyldtQZ5nY
 oE6muigfCzKG5KyB48pUxGmS+080+rk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-x_j8Ii5APySfMLHZ76lc9w-1; Fri, 29 Nov 2019 13:01:07 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9CF7880183C
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 18:01:06 +0000 (UTC)
Received: from work-vm (ovpn-117-253.ams2.redhat.com [10.36.117.253])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 730CE60904;
 Fri, 29 Nov 2019 18:01:05 +0000 (UTC)
Date: Fri, 29 Nov 2019 18:01:03 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: libcap vs libcap-ng mess
Message-ID: <20191129180103.GA2840@work-vm>
References: <20191128190408.GC3294@work-vm>
 <20191129093409.GB2260471@redhat.com>
 <98520a07-cf5d-a2a9-cfa4-944839b94c7c@redhat.com>
MIME-Version: 1.0
In-Reply-To: <98520a07-cf5d-a2a9-cfa4-944839b94c7c@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: x_j8Ii5APySfMLHZ76lc9w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: thuth@redhat.com,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Paolo Bonzini (pbonzini@redhat.com) wrote:
> On 29/11/19 10:34, Daniel P. Berrang=E9 wrote:
> >>   y) Should we flip over to only using one or the other - what
> >>      are the advantages?
> > In libvirt we use libcap-ng. We picked this originally as its API
> > design allows you do write simpler code than libcap in some cases
> > You can see some docs & examples here:
> >=20
> >   https://people.redhat.com/sgrubb/libcap-ng/
> >=20
> > So I vote for changing the 9p code to use libcap-ng.
>=20
> It's not entirely trivial because fsdev-proxy-helper wants to keep the
> effective set and clear the permitted set; in libcap-ng you can only
> apply both sets at once, and you cannot choose only one of them in
> capng_clear/capng_get_caps_process.  But it's doable, I'll take a look.

I'm having some difficulties making the same conversion for virtiofsd;
all it wants to do is drop (and later recover) CAP_FSETID
from it's effective set;  so I'm calling capng_get_caps_process
(it used to be cap_get_proc).  While libcap survives just using the
capget syscall, libcap-ng wants to read /proc/<TID>/status - and
that's a problem because we're in a sandbox without /proc mounted
at that point.

Dave

> In the meanwhile, if someone else wants to look at the CI I would
> appreciate that.
>=20
> Paolo
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


