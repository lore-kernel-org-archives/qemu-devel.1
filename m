Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D5BC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 11:06:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD51C208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 11:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DqU6gO1g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD51C208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iae6Q-0005s9-UB
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 06:06:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39511)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iadrw-0004er-8I
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 05:51:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iadrt-0002sp-HG
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 05:51:22 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54922
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iadrt-0002nc-AB
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 05:51:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575024679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bw//ENZSYb7bv4eiJ2sK4DXn745/JVqd7uEYOq+Rzss=;
 b=DqU6gO1g20d89vJQvu4kkV53lcmPkt6Jv+USdEpbMzey2jjsLn/z5U9DLz3d21VRi2nyiV
 uGjb0lsUHKeVdMr2iVQ4IlOTeiTawcaOzdZuoGnBEIz74iDhz/lerKauBJcXgvNKisNyr3
 ZwHI+w0Jr2FXMx9qyCXo+hhEBUQW2tw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-o86BfraNMQ-poprlGIlUIg-1; Fri, 29 Nov 2019 05:51:15 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D59D0800D41
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 10:51:14 +0000 (UTC)
Received: from work-vm (ovpn-117-253.ams2.redhat.com [10.36.117.253])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 93B5560900;
 Fri, 29 Nov 2019 10:51:13 +0000 (UTC)
Date: Fri, 29 Nov 2019 10:51:11 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: libcap vs libcap-ng mess
Message-ID: <20191129105111.GA2837@work-vm>
References: <20191128190408.GC3294@work-vm>
 <20191129093409.GB2260471@redhat.com>
 <98520a07-cf5d-a2a9-cfa4-944839b94c7c@redhat.com>
MIME-Version: 1.0
In-Reply-To: <98520a07-cf5d-a2a9-cfa4-944839b94c7c@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: o86BfraNMQ-poprlGIlUIg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
>=20
> In the meanwhile, if someone else wants to look at the CI I would
> appreciate that.

Yeh I'll fix up the config and ci.

Dave

> Paolo
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


