Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D99C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 16:48:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4F392072E
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 16:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EvWGkaFS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4F392072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIxag-0007Tw-QP
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 12:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53015)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jIxZg-0005vt-R5
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:47:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jIxZf-0002NT-B2
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:47:44 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:21463)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jIxZf-0002Mc-7x
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:47:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585586863;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ym37JE5enVAknrnE2wg3qqSd8h24RLRhQtcuZhBHU3c=;
 b=EvWGkaFSu6pqR52qVneld3CgpWVqwKC0mRboMA6g+m7SF1b6jVOS2rGHtT+RexAGOxkXyH
 wBq9+yKb3UrbxXV6L1hxtFjKuTkAzN/KRTV81m/SkNtxRsIv8DHmqC6ijMXOyijegwlXOV
 XOOl+D8bViRcMbhdSpAuycEVA6HcuwI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-yNv7LZjrPoGLW_aoScFitA-1; Mon, 30 Mar 2020 12:47:38 -0400
X-MC-Unique: yNv7LZjrPoGLW_aoScFitA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1A621005516;
 Mon, 30 Mar 2020 16:47:36 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C3CB6100EBB3;
 Mon, 30 Mar 2020 16:47:27 +0000 (UTC)
Date: Mon, 30 Mar 2020 17:47:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH-for-5.0] qga-posix: Avoid crashing process when failing
 to allocate memory
Message-ID: <20200330164724.GS236854@redhat.com>
References: <20200324194836.21539-1-philmd@redhat.com>
 <1242083041.1.1585117162620@webmail.proxmox.com>
 <6be54d1f-e5fc-5b34-ba4d-fa050029f26b@redhat.com>
 <87mu7yue35.fsf@dusky.pond.sub.org>
 <81317f7f-7de9-f616-27dc-c389f06792c3@redhat.com>
 <20200330163805.GB2843@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200330163805.GB2843@work-vm>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-stable@nongnu.org,
 Fakhri Zulkifli <mohdfakhrizulkifli@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Basil Salman <basil@daynix.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sameeh Jubran <sjubran@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Dietmar Maurer <dietmar@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 30, 2020 at 05:38:05PM +0100, Dr. David Alan Gilbert wrote:
> * Philippe Mathieu-Daud=C3=A9 (philmd@redhat.com) wrote:
> > Cc'ing the ppl who responded the thread you quoted.
> >=20
> > On 3/30/20 4:11 PM, Markus Armbruster wrote:
> > > Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
> > > ---
> > >   qga/commands-posix.c | 8 +++++++-
> > >   1 file changed, 7 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> > > index 93474ff770..8f127788e6 100644
> > > --- a/qga/commands-posix.c
> > > +++ b/qga/commands-posix.c
> > > @@ -493,7 +493,13 @@ struct GuestFileRead *qmp_guest_file_read(int64_=
t
> > handle, bool has_count,
> > >           gfh->state =3D RW_STATE_NEW;
> > >       }
> > >
> > > -    buf =3D g_malloc0(count+1);
> > > +    buf =3D g_try_malloc0(count + 1);
> > > +    if (!buf) {
> > > +        error_setg(errp,
> > > +                   "failed to allocate sufficient memory "
> > > +                   "to complete the requested service");
> > > +        return NULL;
> > > +    }
> > >       read_count =3D fread(buf, 1, count, fh);
> > >       if (ferror(fh)) {
> > >           error_setg_errno(errp, errno, "failed to read file");
> > >
> >=20
> > > > On 3/25/20 7:19 AM, Dietmar Maurer wrote:
> > > > > but error_setg() also calls malloc, so this does not help at all?
> > > >=20
> > > > IIUC the problem, you can send a QMP command to ask to read let's s=
ay
> > > > 3GB of a file, and QEMU crashes. But this doesn't mean there the .h=
eap
> > > > is empty, there is probably few bytes still available, enough to
> > > > respond with an error message.
> > >=20
> > > We've discussed how to handle out-of-memory conditions many times.
> > > Here's one instance:
> > >=20
> > >      Subject: When it's okay to treat OOM as fatal?
> > >      Message-ID: <87efcqniza.fsf@dusky.pond.sub.org>
> > >      https://lists.nongnu.org/archive/html/qemu-devel/2018-10/msg0321=
2.html
> > >=20
> > > No improvement since then; there's no guidance on when to check for O=
OM.
> > > Actual code tends to check only "large" allocations (for subjective
> > > values of "large").
> > >=20
> > > I reiterate my opinion that whatever OOM handling we have is too
> > > unreliable to be worth much, since it can only help when (1) allocati=
ons
> > > actually fail (they generally don't[*]), and (2) the allocation that
> > > fails is actually handled (they generally aren't), and (3) the handli=
ng
> > > actually works (we don't test OOM, so it generally doesn't).
> > >=20
> > >=20
> > > [*] Linux overcommits memory, which means malloc() pretty much always
> > > succeeds, but when you try to use "too much" of the memory you
> > > supposedly allocated, a lethal signal is coming your way.  Reasd the
> > > thread I quoted for examples.
> >=20
> > So this patch takes Stefan reasoning:
> > https://lists.nongnu.org/archive/html/qemu-devel/2018-10/msg03525.html
> >=20
> >   My thinking has been to use g_new() for small QEMU-internal structure=
s
> >   and g_try_new() for large amounts of memory allocated in response to
> >   untrusted inputs.  (Untrusted inputs must never be used for unbounded
> >   allocation sizes but those bounded sizes can still be large.)
> >=20
> > In any cases (malloc/malloc_try) we have a denial of service
> > (https://www.openwall.com/lists/oss-security/2018/10/17/4) and the serv=
ice
> > is restarted.
> >=20
> > Daniel suggests such behavior should be catched by external firewall gu=
ard
> > (either on the process or on the network). This seems out of scope of Q=
EMU
> > and hard to fix.
> >=20
> > So, can we improve something? Or should we let this code as it?
>=20
> I'll agree with Stefan's description; we should use 'try' for anything
> 'large' (badly defined) or user controlled.
>=20
> So I think this should switch to having the try.

IMHO it is pointless to use try here as its not really solving the
problem. This is just the first of several mallocs in the process
of running this command. Consider the size is large, but still small
enough for the first g_try_malloc() to succeed. Soon after GLib is
going to g_malloc an even larger bock of (count / 3 + 1) * 4 + 1) bytes
in order to base64 encode this data, and that can push us over into OOM
again.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


