Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23A0C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 10:08:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B9A1217D9
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 10:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YqdYXI51"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B9A1217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibid5-00009o-OU
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 05:08:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59588)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ibicH-0007kA-9f
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 05:07:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ibicF-0003lf-Sc
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 05:07:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44522
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ibicF-0003l8-Op
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 05:07:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575281257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kyI8l8wqUY7ICon+CFSZrZH3K6oRjmtumQ//+v7q3PA=;
 b=YqdYXI51ndmK9BjoYl24HU8AXTv3FtU5lTjxq7MEVvVEdxFh2NRbr1q76mHukqhl9OWa/M
 QrMFN0MPf6R4nIDt8tz/18tBQKNnNW8iwALFcsKAl7uXqOjERfXgEtAldkNKyMb7PO7OyB
 ZaTY13CccE+zndVlH7SM7Y11alAAjDg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-8K3rSoDvO4WijdtKjuoVhw-1; Mon, 02 Dec 2019 05:07:36 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED9F610054E3
 for <qemu-devel@nongnu.org>; Mon,  2 Dec 2019 10:07:35 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.18])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C001467648;
 Mon,  2 Dec 2019 10:07:33 +0000 (UTC)
Date: Mon, 2 Dec 2019 10:07:31 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: libcap vs libcap-ng mess
Message-ID: <20191202100731.GB2904@work-vm>
References: <20191128190408.GC3294@work-vm>
 <20191129093409.GB2260471@redhat.com>
 <98520a07-cf5d-a2a9-cfa4-944839b94c7c@redhat.com>
 <20191129180103.GA2840@work-vm>
 <1e59f880-1a62-3230-c56a-533f2b797525@redhat.com>
 <20191129182021.GD2837@work-vm>
 <c024ad69-2b94-cdd0-e9d3-617188d82bc3@redhat.com>
 <20191129185400.GF2837@work-vm>
 <CABgObfZjz=5vWs+-DHTaxfOEu+9Vw1+SuZLSpzxZpRNFRzNKEQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CABgObfZjz=5vWs+-DHTaxfOEu+9Vw1+SuZLSpzxZpRNFRzNKEQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 8K3rSoDvO4WijdtKjuoVhw-1
X-Mimecast-Spam-Score: 0
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
Cc: Thomas Huth <thuth@redhat.com>, "P. Berrange, Daniel" <berrange@redhat.com>,
 qemu-devel@nongnu.org, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Paolo Bonzini (pbonzini@redhat.com) wrote:
> Il ven 29 nov 2019, 19:54 Dr. David Alan Gilbert <dgilbert@redhat.com> ha
> scritto:
>=20
> > > Yes, it's per thread.  The state can be built from
> > > capng_clear/capng_get_caps_process + capng_update, and left in there
> > > forever.  There is also capng_save_state/capng_restore_state which, a=
s
> > > far as I can see from the sources, can be used across threads.
> >
> > So, I think what you're saying is I need to:
> >   a) Before we sandbox do the capng_get_caps_process
> >
>=20
> Why not after sandboxing?

Because in our sandbox we don't have /proc and capng_get_caps_process
tries to read /proc/.../status and fails. The old libcap code doesn't
use /proc, it just uses capget (which the new one also uses).

> If the code is in any way similar to the 9p
> proxy, you have two states, "sandboxed with capabilities" and "sandboxed
> without capabilities". The former (permitted=3Deffective) is what you get
> after setresuid/setresgid, the other can be computed after sandboxing and
> saved using capng_save_state. The FSETID capability can be updated
> explicitly before/after capng_apply.
>=20
>   b) Before we start a new thread do a capng_save_state and restore it
> > in the thread
> >
>=20
> Or just save after (a), and restore always before capng_apply.

Hmm yes, that's easier.

>   a) This code is very local - it does a drop FSETID, a write, restore
> > FSETID
> >   b) I'm not sure but I suspect it's used only in the non-uid=3D0 case;
> > the whole thing is just a hack to cause setuid/setgid to be dropped
> > in the case where it's written by a process that doesn't have FSETID
> > (hmm I guess if the guest was root but didn't have fsetid then it would
> > be 0?)
> >
>=20
> Yes it would. For uid!=3D0 the kernel clears the effective capabilities s=
o it
> shouldn't need to do anything, unless virtiodsd restores capabilities aft=
er
> setresuid/setresgid.
>=20
> But are you suggesting I need to change something other than the
> > effective caps in that case?
> >
>=20
> No, only the effective caps.

OK, thanks.

Dave

> Paolo
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


