Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFF2C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 16:39:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA3DA20578
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 16:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cb+CKW7W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA3DA20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIxRd-0006nI-0R
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 12:39:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51290)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jIxQr-0005rV-70
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:38:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jIxQp-0008U1-Cq
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:38:36 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:41115)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jIxQp-0008Sz-7Q
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:38:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585586314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Eqh6QkStzsumL9GQqhPS/drHtOb2t7poIGAncc6tEY4=;
 b=cb+CKW7Wb/sYM1NUVgxjBuhdtI/htyGmghPQ8plRSHC1UnVvH5oKBRZua5tDvB78RlHrUX
 vHs7IDmO7ZGZ1W09+/kFEF142qTOi63t1+xKVhcJisDjWzx2whZLXtxjzNxVUa6P79BhA8
 Ph3eoauddEanh1JqS24U+ovO821gC0o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-EEZRb2YxNIuwqxABoGK7kA-1; Mon, 30 Mar 2020 12:38:30 -0400
X-MC-Unique: EEZRb2YxNIuwqxABoGK7kA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94927802563;
 Mon, 30 Mar 2020 16:38:28 +0000 (UTC)
Received: from work-vm (ovpn-114-162.ams2.redhat.com [10.36.114.162])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0629A96B60;
 Mon, 30 Mar 2020 16:38:08 +0000 (UTC)
Date: Mon, 30 Mar 2020 17:38:05 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.0] qga-posix: Avoid crashing process when failing
 to allocate memory
Message-ID: <20200330163805.GB2843@work-vm>
References: <20200324194836.21539-1-philmd@redhat.com>
 <1242083041.1.1585117162620@webmail.proxmox.com>
 <6be54d1f-e5fc-5b34-ba4d-fa050029f26b@redhat.com>
 <87mu7yue35.fsf@dusky.pond.sub.org>
 <81317f7f-7de9-f616-27dc-c389f06792c3@redhat.com>
MIME-Version: 1.0
In-Reply-To: <81317f7f-7de9-f616-27dc-c389f06792c3@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: "Daniel P . Berrange" <berrange@redhat.com>, qemu-trivial@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Fakhri Zulkifli <mohdfakhrizulkifli@gmail.com>, qemu-stable@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sameeh Jubran <sjubran@redhat.com>, Basil Salman <basil@daynix.com>,
 Dietmar Maurer <dietmar@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Philippe Mathieu-Daud=E9 (philmd@redhat.com) wrote:
> Cc'ing the ppl who responded the thread you quoted.
>=20
> On 3/30/20 4:11 PM, Markus Armbruster wrote:
> > Philippe Mathieu-Daud=E9 <philmd@redhat.com> writes:
> > ---
> >   qga/commands-posix.c | 8 +++++++-
> >   1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> > index 93474ff770..8f127788e6 100644
> > --- a/qga/commands-posix.c
> > +++ b/qga/commands-posix.c
> > @@ -493,7 +493,13 @@ struct GuestFileRead *qmp_guest_file_read(int64_t
> handle, bool has_count,
> >           gfh->state =3D RW_STATE_NEW;
> >       }
> >
> > -    buf =3D g_malloc0(count+1);
> > +    buf =3D g_try_malloc0(count + 1);
> > +    if (!buf) {
> > +        error_setg(errp,
> > +                   "failed to allocate sufficient memory "
> > +                   "to complete the requested service");
> > +        return NULL;
> > +    }
> >       read_count =3D fread(buf, 1, count, fh);
> >       if (ferror(fh)) {
> >           error_setg_errno(errp, errno, "failed to read file");
> >
>=20
> > > On 3/25/20 7:19 AM, Dietmar Maurer wrote:
> > > > but error_setg() also calls malloc, so this does not help at all?
> > >=20
> > > IIUC the problem, you can send a QMP command to ask to read let's say
> > > 3GB of a file, and QEMU crashes. But this doesn't mean there the .hea=
p
> > > is empty, there is probably few bytes still available, enough to
> > > respond with an error message.
> >=20
> > We've discussed how to handle out-of-memory conditions many times.
> > Here's one instance:
> >=20
> >      Subject: When it's okay to treat OOM as fatal?
> >      Message-ID: <87efcqniza.fsf@dusky.pond.sub.org>
> >      https://lists.nongnu.org/archive/html/qemu-devel/2018-10/msg03212.=
html
> >=20
> > No improvement since then; there's no guidance on when to check for OOM=
.
> > Actual code tends to check only "large" allocations (for subjective
> > values of "large").
> >=20
> > I reiterate my opinion that whatever OOM handling we have is too
> > unreliable to be worth much, since it can only help when (1) allocation=
s
> > actually fail (they generally don't[*]), and (2) the allocation that
> > fails is actually handled (they generally aren't), and (3) the handling
> > actually works (we don't test OOM, so it generally doesn't).
> >=20
> >=20
> > [*] Linux overcommits memory, which means malloc() pretty much always
> > succeeds, but when you try to use "too much" of the memory you
> > supposedly allocated, a lethal signal is coming your way.  Reasd the
> > thread I quoted for examples.
>=20
> So this patch takes Stefan reasoning:
> https://lists.nongnu.org/archive/html/qemu-devel/2018-10/msg03525.html
>=20
>   My thinking has been to use g_new() for small QEMU-internal structures
>   and g_try_new() for large amounts of memory allocated in response to
>   untrusted inputs.  (Untrusted inputs must never be used for unbounded
>   allocation sizes but those bounded sizes can still be large.)
>=20
> In any cases (malloc/malloc_try) we have a denial of service
> (https://www.openwall.com/lists/oss-security/2018/10/17/4) and the servic=
e
> is restarted.
>=20
> Daniel suggests such behavior should be catched by external firewall guar=
d
> (either on the process or on the network). This seems out of scope of QEM=
U
> and hard to fix.
>=20
> So, can we improve something? Or should we let this code as it?

I'll agree with Stefan's description; we should use 'try' for anything
'large' (badly defined) or user controlled.

So I think this should switch to having the try.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


