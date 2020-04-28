Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14E9C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 10:21:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7524206C0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 10:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JVZFNWTS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7524206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTNMl-0001uR-R2
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 06:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42762)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jTNLP-0008TY-Ig
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 06:20:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jTNLK-00034D-Bt
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 06:20:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35246
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jTNLJ-00033t-Ut
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 06:19:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588069197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hIe0ksCo4mVfbtq8gjJ4IQ2AS7HDyCeWEbgJ9chK5LQ=;
 b=JVZFNWTSiFvB7ZrK7ybJPmkMXNW8R9hwqAtDTbt/mSCkSc5UTMRXWv+uKXcBbbnLQygCLN
 NWwy5syFmTr5thKgr31d6gGW7e2BpyNethOiSwPpwRPUj028vVPMZD5i9qbhvu/FqPgvHR
 Fs5Eq2wWsQmot19t1bDn25bsSeC2f/4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-MNmunedGNU-WFJSwL9tnNw-1; Tue, 28 Apr 2020 06:19:55 -0400
X-MC-Unique: MNmunedGNU-WFJSwL9tnNw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6EED919200C2
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 10:19:54 +0000 (UTC)
Received: from work-vm (ovpn-113-77.ams2.redhat.com [10.36.113.77])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B873E1001B0B;
 Tue, 28 Apr 2020 10:19:47 +0000 (UTC)
Date: Tue, 28 Apr 2020 11:19:45 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH] virtiofsd: Show submounts
Message-ID: <20200428101945.GB2794@work-vm>
References: <20200424133516.73077-1-mreitz@redhat.com>
 <20200427175902.GM2923@work-vm>
 <8aa9aea2-cc5d-f9b5-5cdb-b5e596ef89aa@redhat.com>
 <20200428095935.GA2794@work-vm>
 <537eb3fe-d930-1d8e-1597-1b73831d0623@redhat.com>
MIME-Version: 1.0
In-Reply-To: <537eb3fe-d930-1d8e-1597-1b73831d0623@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:16:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Max Reitz (mreitz@redhat.com) wrote:
> On 28.04.20 11:59, Dr. David Alan Gilbert wrote:
> > * Max Reitz (mreitz@redhat.com) wrote:
> >> On 27.04.20 19:59, Dr. David Alan Gilbert wrote:
> >>> * Max Reitz (mreitz@redhat.com) wrote:
> >>>> Currently, setup_mounts() bind-mounts the shared directory without
> >>>> MS_REC.  This makes all submounts disappear.
> >>>>
> >>>> Pass MS_REC so that the guest can see submounts again.
> >>>
> >>> Thanks!
> >>>
> >>>> Fixes: 3ca8a2b1c83eb185c232a4e87abbb65495263756
> >>>
> >>> Should this actually be 5baa3b8e95064c2434bd9e2f312edd5e9ae275dc ?
> >>
> >> Well, I bisected it and landed at 3ca8a2b1.  So while the problematic
> >> line may have been introduced by 5baa3b8e, it wasn=E2=80=99t used unti=
l 3ca8a2b1.
> >=20
> > OK, I'd rather stick with the Fixes: for the patch that was actually
> > wrong.
>=20
> Why not both? :)
>=20
> >>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >>>> ---
> >>>>  tools/virtiofsd/passthrough_ll.c | 2 +-
> >>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/pass=
through_ll.c
> >>>> index 4c35c95b25..9d7f863e66 100644
> >>>> --- a/tools/virtiofsd/passthrough_ll.c
> >>>> +++ b/tools/virtiofsd/passthrough_ll.c
> >>>> @@ -2643,7 +2643,7 @@ static void setup_mounts(const char *source)
> >>>>      int oldroot;
> >>>>      int newroot;
> >>>> =20
> >>>> -    if (mount(source, source, NULL, MS_BIND, NULL) < 0) {
> >>>> +    if (mount(source, source, NULL, MS_BIND | MS_REC, NULL) < 0) {
> >>>>          fuse_log(FUSE_LOG_ERR, "mount(%s, %s, MS_BIND): %m\n", sour=
ce, source);
> >>>>          exit(1);
> >>>>      }
> >>>
> >>> Do we want MS_SLAVE to pick up future mounts that might happenf rom t=
he
> >>> host?
> >>
> >> Hm.  So first it looks to me from the man page like one shouldn=E2=80=
=99t give
> >> MS_SLAVE on the first mount() call but kind of only use it for remount=
s
> >> (in the list at the start, =E2=80=9CCreate a bind mount=E2=80=9D is se=
parate from
> >> =E2=80=9CChange the propagation type of an existing mount=E2=80=9D, an=
d the man page
> >> later says =E2=80=9CThe only other flags that can be specified while c=
hanging
> >> the propagation type are MS_REC (described below) and MS_SILENT (which
> >> is ignored).=E2=80=9D).
> >>
> >> Second, even if I do change the propagation type to MS_SLAVE in a seco=
nd
> >> call, mounts done after qemu has been started don=E2=80=99t show up in=
 the guest
> >> (for me).
> >>
> >> So while it sounds correct, I can=E2=80=99t see it having an effect, a=
ctually.
> >=20
> > That's unfortunate; but I guess we can debug that separately
> >=20
> >>> What's the interaction between this and the MS_REC|MS_SLAVE that we h=
ave
> >>> a few lines above for / ?
> >>
> >> Good question.  It would seem to me that there isn=E2=80=99t any.  Tha=
t previous
> >> mount call just sets MS_REC | MS_SLAVE for the whole mount namespace,
> >> and then we do a new mount here (by default from / to /) that needs it=
s
> >> own flags.
> >>
> >> (More interesting is perhaps why we have that other mount() call below=
,
> >> which again sets MS_REC | MS_SLAVE for the old (not-yet-bind-mounted) =
/.
> >>  I can=E2=80=99t imagine that to have any effect.)
> >=20
> > Is that just trying to be careful before the umount2 so it doesn't try
> > to unmount something useful?
>=20
> Perhaps, but still, it shouldn=E2=80=99t matter.  I rather suspect that
> setup_namespaces() and setup_mounts() were developed (or taken from
> elsewhere) independently, so they both have to work independently, and
> thus they do overlapping stuff.

Yep, agreed.

Dave

> Max
>=20



--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


