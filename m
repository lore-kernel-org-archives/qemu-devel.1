Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FD9C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 18:59:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68EAE21721
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 18:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bsjFeMuQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68EAE21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ialUU-00049a-Kp
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 13:59:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34826)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ialPg-0002iF-UD
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 13:54:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ialP5-0002Gr-Pc
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 13:54:09 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58544
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ialP5-00028X-Gt
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 13:54:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575053646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GM/hza6bN8BbX6DuTaJLZyYJODxj/MiNEx50kxizkuw=;
 b=bsjFeMuQ+Y048aLnHQLcxlZFYNjgRi8a9OgPiA3neavbEkFH6aefOXwKwD7L6twtYOogVb
 9Pod/fNlEnUUu+96yXyZHUOExSxsmWL9ZO9GJtUyDUndJgu+x0b3MUBSbMZbyJiqOlACA3
 rYsJhxULkE1Qv7LauYUHdoyStB7Qbdo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-3MB2UtGgOouQ_kAvBOpKZQ-1; Fri, 29 Nov 2019 13:54:05 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7615EDB21
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 18:54:04 +0000 (UTC)
Received: from work-vm (ovpn-117-253.ams2.redhat.com [10.36.117.253])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 50E235D6D2;
 Fri, 29 Nov 2019 18:54:03 +0000 (UTC)
Date: Fri, 29 Nov 2019 18:54:00 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: libcap vs libcap-ng mess
Message-ID: <20191129185400.GF2837@work-vm>
References: <20191128190408.GC3294@work-vm>
 <20191129093409.GB2260471@redhat.com>
 <98520a07-cf5d-a2a9-cfa4-944839b94c7c@redhat.com>
 <20191129180103.GA2840@work-vm>
 <1e59f880-1a62-3230-c56a-533f2b797525@redhat.com>
 <20191129182021.GD2837@work-vm>
 <c024ad69-2b94-cdd0-e9d3-617188d82bc3@redhat.com>
MIME-Version: 1.0
In-Reply-To: <c024ad69-2b94-cdd0-e9d3-617188d82bc3@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 3MB2UtGgOouQ_kAvBOpKZQ-1
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
> On 29/11/19 19:20, Dr. David Alan Gilbert wrote:
> > * Paolo Bonzini (pbonzini@redhat.com) wrote:
> >> On 29/11/19 19:01, Dr. David Alan Gilbert wrote:
> >>>> It's not entirely trivial because fsdev-proxy-helper wants to keep t=
he
> >>>> effective set and clear the permitted set; in libcap-ng you can only
> >>                      ^^^^^
> >>
> >> (Wrong, this is "modify" the permitted set.  The permitted set is
> >> already cleared by setresuid/setresgid).
> >>
> >>>> apply both sets at once, and you cannot choose only one of them in
> >>>> capng_clear/capng_get_caps_process.  But it's doable, I'll take a lo=
ok.
> >>> I'm having some difficulties making the same conversion for virtiofsd=
;
> >>> all it wants to do is drop (and later recover) CAP_FSETID
> >>> from it's effective set;  so I'm calling capng_get_caps_process
> >>> (it used to be cap_get_proc).  While libcap survives just using the
> >>> capget syscall, libcap-ng wants to read /proc/<TID>/status - and
> >>> that's a problem because we're in a sandbox without /proc mounted
> >>> at that point.
> >>
> >> The state of libcap-ng persists after capng_apply.  So you can just ca=
ll
> >> capng_update({CAP_ADD,CAP_DROP}) followed by capng_apply.
> >=20
> > But the internal state needs initialising doesn't it? So that when you
> > capng_update it tweaks a set that was originally read from somewhere?
> > (and that's per-thread?)
>=20
> Yes, it's per thread.  The state can be built from
> capng_clear/capng_get_caps_process + capng_update, and left in there
> forever.  There is also capng_save_state/capng_restore_state which, as
> far as I can see from the sources, can be used across threads.

OK that's a lot more complex than the current code, and a bit fragile -
but probably more efficient.
So, I think what you're saying is I need to:
  a) Before we sandbox do the capng_get_caps_process
  b) Before we start a new thread do a capng_save_state and restore it
in the thread

I've got to be pretty careful that I do (a) at the write point so
I've not gained anything we later try and drop.
(But we do save doing the capget() on every time we do this drop/restore
dance).

> >> Does virtiofsd have to do uid/gid dances like virtfs-proxy-helper?
> >=20
> > It looks like it; I can see setresuid calls to save and restore
> > euid/egid.
>=20
> Ok, then perhaps you can take a look at my virtfs-proxy-helper patch.
> The important part is that after setresuid/setresgid PERM=3DEFF if
> uid=3D0/gid=3D0 and PERM=3D0 otherwise.

I think we're ok because:
  a) This code is very local - it does a drop FSETID, a write, restore
FSETID
  b) I'm not sure but I suspect it's used only in the non-uid=3D0 case;=20
the whole thing is just a hack to cause setuid/setgid to be dropped
in the case where it's written by a process that doesn't have FSETID
(hmm I guess if the guest was root but didn't have fsetid then it would
be 0?)

But are you suggesting I need to change something other than the
effective caps in that case?

Dave

> Paolo
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


