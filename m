Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E66C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 18:24:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E89D21736
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 18:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cVEfI9ky"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E89D21736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iakwi-0003dR-MX
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 13:24:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34203)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iaksg-0002j0-AA
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 13:20:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iaksX-00027u-W9
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 13:20:31 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49923)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iaksX-000233-R3
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 13:20:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575051628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7f76va/W8GqafPCpbkjbcbHwllHVm+aQ8mBHggg2PrA=;
 b=cVEfI9kyV8nIYxAeoLUvctOyqBesizyfFwZFhkDv5EGFiAk2gKusVogc8tj8Dg4mEi8/rz
 QPxDHokQ5D/igo216BqY960vAxdWsfIJt+6DI2z14KFMXpPfl8hYG5Cbi01Z1yFGMgjFE+
 r/6vYZKeg01ItzaRHmjmY70YD5igRKg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-nxrqzeumPzazHXFyFpTvxg-1; Fri, 29 Nov 2019 13:20:25 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D81EF10054E3
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 18:20:24 +0000 (UTC)
Received: from work-vm (ovpn-117-253.ams2.redhat.com [10.36.117.253])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 997E75D9C9;
 Fri, 29 Nov 2019 18:20:23 +0000 (UTC)
Date: Fri, 29 Nov 2019 18:20:21 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: libcap vs libcap-ng mess
Message-ID: <20191129182021.GD2837@work-vm>
References: <20191128190408.GC3294@work-vm>
 <20191129093409.GB2260471@redhat.com>
 <98520a07-cf5d-a2a9-cfa4-944839b94c7c@redhat.com>
 <20191129180103.GA2840@work-vm>
 <1e59f880-1a62-3230-c56a-533f2b797525@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1e59f880-1a62-3230-c56a-533f2b797525@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: nxrqzeumPzazHXFyFpTvxg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
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
Cc: thuth@redhat.com,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Paolo Bonzini (pbonzini@redhat.com) wrote:
> On 29/11/19 19:01, Dr. David Alan Gilbert wrote:
> >> It's not entirely trivial because fsdev-proxy-helper wants to keep the
> >> effective set and clear the permitted set; in libcap-ng you can only
>                      ^^^^^
>=20
> (Wrong, this is "modify" the permitted set.  The permitted set is
> already cleared by setresuid/setresgid).
>=20
> >> apply both sets at once, and you cannot choose only one of them in
> >> capng_clear/capng_get_caps_process.  But it's doable, I'll take a look=
.
> > I'm having some difficulties making the same conversion for virtiofsd;
> > all it wants to do is drop (and later recover) CAP_FSETID
> > from it's effective set;  so I'm calling capng_get_caps_process
> > (it used to be cap_get_proc).  While libcap survives just using the
> > capget syscall, libcap-ng wants to read /proc/<TID>/status - and
> > that's a problem because we're in a sandbox without /proc mounted
> > at that point.
>=20
> The state of libcap-ng persists after capng_apply.  So you can just call
> capng_update({CAP_ADD,CAP_DROP}) followed by capng_apply.

But the internal state needs initialising doesn't it? So that when you
capng_update it tweaks a set that was originally read from somewhere?
(and that's per-thread?)

> Does virtiofsd have to do uid/gid dances like virtfs-proxy-helper?

It looks like it; I can see setresuid calls to save and restore
euid/egid.

Dave

> Thanks,
>=20
> Paolo
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


