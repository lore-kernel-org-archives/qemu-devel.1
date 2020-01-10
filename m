Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95E9C33CA2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 13:06:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B603F2072A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 13:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BWz+R90z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B603F2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iptzK-0003K9-S8
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 08:06:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42426)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iptyX-0002hu-RJ
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 08:05:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iptyU-00036e-S0
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 08:05:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41509
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iptyU-00030f-Mq
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 08:05:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578661513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kgrEt+FvBB/6+IO3osBNiD9sUA4+YSQqtZ9DHhl2xWI=;
 b=BWz+R90z9bSSi93e7rxuWn7LdTbL3vnghRpsyEHGVu6HvA7veLMtO94yinG4rYNA9gFwxK
 ldDVADvaRnhj3f83+V7VNWDXAOPkSaloA0IfoRRqkf89kwxHlBAFe6v/YotWf1vp//G11V
 F1JDRIsq50RASUTaYolynOfyIFLvxv4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-6azGhjCINbqh8cUKLEtj1g-1; Fri, 10 Jan 2020 08:05:12 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F008DB23
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 13:05:11 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.36])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 90C6F5C1D4;
 Fri, 10 Jan 2020 13:05:02 +0000 (UTC)
Date: Fri, 10 Jan 2020 13:05:00 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH 032/104] virtiofsd: passthrough_ll: create new files in
 caller's context
Message-ID: <20200110130500.GE3901@work-vm>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-33-dgilbert@redhat.com>
 <20200106143011.GK2930416@redhat.com>
 <20200106190041.GO2798@work-vm> <20200106190843.GP2798@work-vm>
 <20200107092231.GA3368802@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200107092231.GA3368802@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 6azGhjCINbqh8cUKLEtj1g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Daniel P. Berrang=C3=A9 (berrange@redhat.com) wrote:
> On Mon, Jan 06, 2020 at 07:08:43PM +0000, Dr. David Alan Gilbert wrote:
> > * Dr. David Alan Gilbert (dgilbert@redhat.com) wrote:
> > > * Daniel P. Berrang=C3=A9 (berrange@redhat.com) wrote:
> > > > On Thu, Dec 12, 2019 at 04:37:52PM +0000, Dr. David Alan Gilbert (g=
it) wrote:
> > > > > From: Vivek Goyal <vgoyal@redhat.com>
> > > > >=20
> > > > > We need to create files in the caller's context. Otherwise after
> > > > > creating a file, the caller might not be able to do file operatio=
ns on
> > > > > that file.
> > > > >=20
> > > > > Changed effective uid/gid to caller's uid/gid, create file and th=
en
> > > > > switch back to uid/gid 0.
> > > > >=20
> > > > > Use syscall(setresuid, ...) otherwise glibc does some magic to ch=
ange EUID
> > > > > in all threads, which is not what we want.
> > > > >=20
> > > > > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > > > > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > > > > ---
> > > > >  tools/virtiofsd/passthrough_ll.c | 79 ++++++++++++++++++++++++++=
++++--
> > > > >  1 file changed, 74 insertions(+), 5 deletions(-)
> > > > >=20
> > > > > diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/p=
assthrough_ll.c
> > > > > index 68bacb6fc5..0188cd9ad6 100644
> > > > > --- a/tools/virtiofsd/passthrough_ll.c
> > > > > +++ b/tools/virtiofsd/passthrough_ll.c
> > > >=20
> > > >=20
> > > > > +static int lo_change_cred(fuse_req_t req, struct lo_cred *old)
> > > > > +{
> > > > > +    int res;
> > > > > +
> > > > > +    old->euid =3D geteuid();
> > > > > +    old->egid =3D getegid();
> > > > > +
> > > > > +    res =3D syscall(SYS_setresgid, -1, fuse_req_ctx(req)->gid, -=
1);
> > > >=20
> > > > Do we need to be using  SYS_setres[u,g]id32 instead...
> > > >=20
> > > > [quote setresgid(2)]
> > > >        The original Linux setresuid() and setresgid() system  calls
> > > >        supported  only  16-bit  user  and group IDs.  Subsequently,
> > > >        Linux 2.4 added setresuid32() and setresgid32(),  supporting
> > > >        32-bit  IDs.   The glibc setresuid() and setresgid() wrapper
> > > >        functions transparently deal with the variations across ker=
=E2=80=90
> > > >        nel versions.
> > > > [/quote]
> > >=20
> > > OK, updated.
> >=20
> > Hmm hang on; this is messy.  x86-64 only seems to have setresuid
> > where as some architectures have both;  If I'm reading this right, all
> > 64 bit machines have setresuid/gid calling the code that takes the
> > 32bit ID; some have compat entries for 32bit syscalls.
>=20
> Oh yuk.
>=20
> > I think it's probably more correct to call setresuid here; except
> > for 32 bit platforms - but how do we tell?
>=20
> Is it possible to just do an #ifdef SYS_setresgid32 check to see
> if the wider variant exists ?

I've ended up with:

+/*
+ * On some archs, setres*id is limited to 2^16 but they
+ * provide setres*id32 variants that allow 2^32.
+ * Others just let setres*id do 2^32 anyway.
+ */
+#ifdef SYS_setresgid32
+#define OURSYS_setresgid SYS_setresgid32
+#else
+#define OURSYS_setresgid SYS_setresgid
+#endif
+
+#ifdef SYS_setresuid32
+#define OURSYS_setresuid SYS_setresuid32
+#else
+#define OURSYS_setresuid SYS_setresuid
+#endif
+
+/*
+ * Change to uid/gid of caller so that file is created with
+ * ownership of caller.
+ * TODO: What about selinux context?
+ */
+static int lo_change_cred(fuse_req_t req, struct lo_cred *old)
+{
+    int res;
+
+    old->euid =3D geteuid();
+    old->egid =3D getegid();
+
+    res =3D syscall(OURSYS_setresgid, -1, fuse_req_ctx(req)->gid, -1);
+    if (res =3D=3D -1) {
+        return errno;
+    }
+
+    res =3D syscall(OURSYS_setresuid, -1, fuse_req_ctx(req)->uid, -1);
+    if (res =3D=3D -1) {
+        int errno_save =3D errno;
+
+        syscall(OURSYS_setresgid, -1, old->egid, -1);
+        return errno_save;
+    }

and in the seccomp:

#ifdef __NR_setresgid32
    SCMP_SYS(setresgid32),
#endif
#ifdef __NR_setresuid32
    SCMP_SYS(setresuid32),
#endif

Dave

>=20
> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


