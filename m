Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38088C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 08:00:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9120206D7
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 08:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SnYi2gs+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9120206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0h0i-0005Ev-5d
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 04:00:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rmohr@redhat.com>) id 1k0gzl-0004nO-7q
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 03:59:25 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:41614)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <rmohr@redhat.com>) id 1k0gzh-0005sP-NJ
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 03:59:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596009560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PhZrBtipWnzSgzKfxO5C1uodv4miVdfOo9yFWSKS7R4=;
 b=SnYi2gs+iHW9O0xPeUGqKrA+ImVVJDevADpmZVCdmWBj8X8eCfxK6IMjVA4xdy7Ev0R6IY
 rD9g2wYtGGFmGr6hJR129BXoaBSHalvmLMovLZgC2a3sPmBYnrUtQupdVG7QNP5nAfbTgi
 SSVUpXcNVwXGIh38NTJrTJqDfV1J0DE=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-NoI9TtG5MoWG90GyufPkwA-1; Wed, 29 Jul 2020 03:59:14 -0400
X-MC-Unique: NoI9TtG5MoWG90GyufPkwA-1
Received: by mail-oo1-f69.google.com with SMTP id d67so4850933oob.11
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 00:59:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PhZrBtipWnzSgzKfxO5C1uodv4miVdfOo9yFWSKS7R4=;
 b=QfQBye+xvHlEcudX8FpoCBM0yL2glZn/iqQqGAqVregJBlZlVHnqJYbVN/Us98xKZS
 CfBbwRWXX+im9xfRQIUri1R5GX6XowZxts0WgD3oZCOziFH9/6ykPo4Gx+Zuy7zW540v
 H2Ud7PKUQ5jXbKztRQ9GOyKeWNleZucsVz41n6GnmgqGuC6pN6m7I6vCvniYru5an0x8
 quakj4kg1mGJZugawkj3brLYXPFKSDhJ3/xr/nO8RJAtbYvmywnb70LJQDsG3Y0fOuaq
 vmXnS5KDw8F5LRruNhjY084Bc+E7ayOpgp0fBFzCXqSgRP/5OnY/yDemEr7wzhe5CKhu
 3n/w==
X-Gm-Message-State: AOAM533RZotYonvnUE9RkZVCSB0lVa/lklwrEwuaFLo3gREFi/rnSLTO
 TLIs9nYbcQvV1wOcLftQvYvPIv2n1+aQxWFSr58ETsRTHthztrM0DGa6RHNQkpab5IqaZ0+zi9K
 QqtW2IF2TXqheVYi0GZroTP1sB9vDc1U=
X-Received: by 2002:a4a:8dc1:: with SMTP id a1mr24640705ool.69.1596009553377; 
 Wed, 29 Jul 2020 00:59:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCDhp/zCVcAR1UniKtEWU0XLI3EE6JflnK3ldtMNNxA+eez5n2zfahhxLWyr7g4qlXLhqUp2PUgSwOvoCBEds=
X-Received: by 2002:a4a:8dc1:: with SMTP id a1mr24640690ool.69.1596009553094; 
 Wed, 29 Jul 2020 00:59:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200727190223.422280-1-stefanha@redhat.com>
 <20200727190223.422280-4-stefanha@redhat.com>
 <OSBPR01MB45826073E5A54CF869E56721E5730@OSBPR01MB4582.jpnprd01.prod.outlook.com>
 <CALDPj7syG0KPhtZEma5n403=YFZ2ptcD4MtP=GdrY9n1eUs5Eg@mail.gmail.com>
 <20200728131250.GB78409@redhat.com>
In-Reply-To: <20200728131250.GB78409@redhat.com>
From: Roman Mohr <rmohr@redhat.com>
Date: Wed, 29 Jul 2020 09:59:01 +0200
Message-ID: <CALDPj7uvquu=YWX_Ve7ROdj=LZWjkgPOm+wvEAynGvjeF4Xivg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] virtiofsd: probe unshare(CLONE_FS) and print an
 error
To: Vivek Goyal <vgoyal@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="00000000000078858c05ab8fee64"
Received-SPF: pass client-ip=63.128.21.74; envelope-from=rmohr@redhat.com;
 helo=us-smtp-delivery-74.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 01:09:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "vromanso@redhat.com" <vromanso@redhat.com>,
 Daniel Walsh <dwalsh@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "virtio-fs@redhat.com" <virtio-fs@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>,
 "mpatel@redhat.com" <mpatel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000078858c05ab8fee64
Content-Type: text/plain; charset="UTF-8"

On Tue, Jul 28, 2020 at 3:13 PM Vivek Goyal <vgoyal@redhat.com> wrote:

> On Tue, Jul 28, 2020 at 12:00:20PM +0200, Roman Mohr wrote:
> > On Tue, Jul 28, 2020 at 3:07 AM misono.tomohiro@fujitsu.com <
> > misono.tomohiro@fujitsu.com> wrote:
> >
> > > > Subject: [PATCH v2 3/3] virtiofsd: probe unshare(CLONE_FS) and print
> an
> > > error
> > > >
> > > > An assertion failure is raised during request processing if
> > > > unshare(CLONE_FS) fails. Implement a probe at startup so the problem
> can
> > > > be detected right away.
> > > >
> > > > Unfortunately Docker/Moby does not include unshare in the
> seccomp.json
> > > > list unless CAP_SYS_ADMIN is given. Other seccomp.json lists always
> > > > include unshare (e.g. podman is unaffected):
> > > >
> > >
> https://raw.githubusercontent.com/seccomp/containers-golang/master/seccomp.json
> > > >
> > > > Use "docker run --security-opt seccomp=path/to/seccomp.json ..." if
> the
> > > > default seccomp.json is missing unshare.
> > >
> > > Hi, sorry for a bit late.
> > >
> > > unshare() was added to fix xattr problem:
> > >
> > >
> https://github.com/qemu/qemu/commit/bdfd66788349acc43cd3f1298718ad491663cfcc#
> > > In theory we don't need to call unshare if xattr is disabled, but it is
> > > hard to get to know
> > > if xattr is enabled or disabled in fv_queue_worker(), right?
> > >
> > >
> > In kubevirt we want to run virtiofsd in containers. We would already not
> > have xattr support for e.g. overlayfs in the VM after this patch series
> (an
> > acceptable con at least for us right now).
> > If we can get rid of the unshare (and potentially of needing root) that
> > would be great. We always assume that everything which we run in
> containers
> > should work for cri-o and docker.
>
> But cri-o and docker containers run as root, isn't it? (or atleast have
> the capability to run as root). Havind said that, it will be nice to be
> able
> to run virtiofsd without root.
>

Yes they can run as root. I can tell you what we plan to do with the
containerized virtiofsd: We run it as part of the user-owned pod (a set of
containers).
One of our main goals at the moment is to run VMs in a user-owned pod
without additional privileges.
So that in case the user (VM-creator/owner) enters the pod or something
breaks out of the VM they are just in the unprivileged container sandbox.
As part of that we try to get also rid of running containers in the
user-context with the root user.

One possible scenario which I could think of as being desirable from a
kubevirt perspective:
We would run the VM in one container and have an unprivileged
virtiofsd container in parallel.
This container already has its own mount namespace and it is not that
critical if something manages to enter this sandbox.

But we are not as far yet as getting completely rid of root right now in
kubevirt, so if as a temporary step it needs root, the current proposed
changes would still be very useful for us.

Best Regards,
Roman

There are few hurdles though.
>
> - For file creation, we switch uid/gid (seteuid/setegid) and that seems
>   to require root. If we were to run unpriviliged, probably all files
>   on host will have to be owned by unpriviliged user and guest visible
>   uid/gid will have to be stored in xattrs. I think virtfs supports
>   something similar.


> I am sure there are other restrictions but this probably is the biggest
> one to overcome.
>
>  >
> > "Just" pointing docker to a different seccomp.json file is something
> which
> > k8s users/admin in many cases can't do.
>
> Or may be issue is that standard seccomp.json does not allow unshare()
> and hence you are forced to use a non-standar seccomp.json.
>
> Vivek
>
> >
> > Best Regards,
> > Roman
> >
> >
> > > So, it looks good to me.
> > > Reviewed-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
> > >
> > > Regards,
> > > Misono
> > >
> > > >
> > > > Cc: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
> > > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > > ---
> > > >  tools/virtiofsd/fuse_virtio.c | 16 ++++++++++++++++
> > > >  1 file changed, 16 insertions(+)
> > > >
> > > > diff --git a/tools/virtiofsd/fuse_virtio.c
> > > b/tools/virtiofsd/fuse_virtio.c
> > > > index 3b6d16a041..9e5537506c 100644
> > > > --- a/tools/virtiofsd/fuse_virtio.c
> > > > +++ b/tools/virtiofsd/fuse_virtio.c
> > > > @@ -949,6 +949,22 @@ int virtio_session_mount(struct fuse_session
> *se)
> > > >  {
> > > >      int ret;
> > > >
> > > > +    /*
> > > > +     * Test that unshare(CLONE_FS) works. fv_queue_worker() will
> need
> > > it. It's
> > > > +     * an unprivileged system call but some Docker/Moby versions are
> > > known to
> > > > +     * reject it via seccomp when CAP_SYS_ADMIN is not given.
> > > > +     *
> > > > +     * Note that the program is single-threaded here so this syscall
> > > has no
> > > > +     * visible effect and is safe to make.
> > > > +     */
> > > > +    ret = unshare(CLONE_FS);
> > > > +    if (ret == -1 && errno == EPERM) {
> > > > +        fuse_log(FUSE_LOG_ERR, "unshare(CLONE_FS) failed with
> EPERM. If
> > > "
> > > > +                "running in a container please check that the
> container
> > > "
> > > > +                "runtime seccomp policy allows unshare.\n");
> > > > +        return -1;
> > > > +    }
> > > > +
> > > >      ret = fv_create_listen_socket(se);
> > > >      if (ret < 0) {
> > > >          return ret;
> > > > --
> > > > 2.26.2
> > >
> > >
>
>

--00000000000078858c05ab8fee64
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 28, 2020 at 3:13 PM Vivek=
 Goyal &lt;<a href=3D"mailto:vgoyal@redhat.com">vgoyal@redhat.com</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue, Ju=
l 28, 2020 at 12:00:20PM +0200, Roman Mohr wrote:<br>
&gt; On Tue, Jul 28, 2020 at 3:07 AM <a href=3D"mailto:misono.tomohiro@fuji=
tsu.com" target=3D"_blank">misono.tomohiro@fujitsu.com</a> &lt;<br>
&gt; <a href=3D"mailto:misono.tomohiro@fujitsu.com" target=3D"_blank">mison=
o.tomohiro@fujitsu.com</a>&gt; wrote:<br>
&gt; <br>
&gt; &gt; &gt; Subject: [PATCH v2 3/3] virtiofsd: probe unshare(CLONE_FS) a=
nd print an<br>
&gt; &gt; error<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; An assertion failure is raised during request processing if<=
br>
&gt; &gt; &gt; unshare(CLONE_FS) fails. Implement a probe at startup so the=
 problem can<br>
&gt; &gt; &gt; be detected right away.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Unfortunately Docker/Moby does not include unshare in the se=
ccomp.json<br>
&gt; &gt; &gt; list unless CAP_SYS_ADMIN is given. Other seccomp.json lists=
 always<br>
&gt; &gt; &gt; include unshare (e.g. podman is unaffected):<br>
&gt; &gt; &gt;<br>
&gt; &gt; <a href=3D"https://raw.githubusercontent.com/seccomp/containers-g=
olang/master/seccomp.json" rel=3D"noreferrer" target=3D"_blank">https://raw=
.githubusercontent.com/seccomp/containers-golang/master/seccomp.json</a><br=
>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Use &quot;docker run --security-opt seccomp=3Dpath/to/seccom=
p.json ...&quot; if the<br>
&gt; &gt; &gt; default seccomp.json is missing unshare.<br>
&gt; &gt;<br>
&gt; &gt; Hi, sorry for a bit late.<br>
&gt; &gt;<br>
&gt; &gt; unshare() was added to fix xattr problem:<br>
&gt; &gt;<br>
&gt; &gt; <a href=3D"https://github.com/qemu/qemu/commit/bdfd66788349acc43c=
d3f1298718ad491663cfcc#" rel=3D"noreferrer" target=3D"_blank">https://githu=
b.com/qemu/qemu/commit/bdfd66788349acc43cd3f1298718ad491663cfcc#</a><br>
&gt; &gt; In theory we don&#39;t need to call unshare if xattr is disabled,=
 but it is<br>
&gt; &gt; hard to get to know<br>
&gt; &gt; if xattr is enabled or disabled in fv_queue_worker(), right?<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; In kubevirt we want to run virtiofsd in containers. We would already n=
ot<br>
&gt; have xattr support for e.g. overlayfs in the VM after this patch serie=
s (an<br>
&gt; acceptable con at least for us right now).<br>
&gt; If we can get rid of the unshare (and potentially of needing root) tha=
t<br>
&gt; would be great. We always assume that everything which we run in conta=
iners<br>
&gt; should work for cri-o and docker.<br>
<br>
But cri-o and docker containers run as root, isn&#39;t it? (or atleast have=
<br>
the capability to run as root). Havind said that, it will be nice to be abl=
e<br>
to run virtiofsd without root. <br></blockquote><div><br></div><div>Yes the=
y can run as root. I can tell you what we plan to do with the containerized=
 virtiofsd: We run it as part of the user-owned pod (a set of containers).<=
br>One of our main goals at the moment is to run VMs in a user-owned pod wi=
thout additional privileges.</div><div>So that in case the user (VM-creator=
/owner) enters the pod or something breaks out of the VM they are just in t=
he unprivileged container sandbox.</div><div>As part of that we try to get =
also rid of running containers in the user-context with the root user.<br><=
br>One possible scenario which I could think of as being desirable from a k=
ubevirt perspective:=C2=A0</div><div>We would run the VM in one container a=
nd have an=C2=A0unprivileged virtiofsd=C2=A0container in parallel.<br>This =
container already has its own mount namespace and it is not that critical i=
f something manages to enter this sandbox.<br><br>But we are not as far yet=
 as getting completely rid of root right now in kubevirt, so if as a tempor=
ary step it needs root, the current proposed changes would still be very us=
eful for us.<br><br>Best Regards,</div><div>Roman<br><br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
There are few hurdles though.<br>
<br>
- For file creation, we switch uid/gid (seteuid/setegid) and that seems<br>
=C2=A0 to require root. If we were to run unpriviliged, probably all files<=
br>
=C2=A0 on host will have to be owned by unpriviliged user and guest visible=
<br>
=C2=A0 uid/gid will have to be stored in xattrs. I think virtfs supports<br=
>
=C2=A0 something similar.=C2=A0</blockquote><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
<br>
I am sure there are other restrictions but this probably is the biggest<br>
one to overcome.<br>
<br>
=C2=A0&gt; <br>
&gt; &quot;Just&quot; pointing docker to a different seccomp.json file is s=
omething which<br>
&gt; k8s users/admin in many cases can&#39;t do.<br>
<br>
Or may be issue is that standard seccomp.json does not allow unshare()<br>
and hence you are forced to use a non-standar seccomp.json.<br>
<br>
Vivek<br>
<br>
&gt; <br>
&gt; Best Regards,<br>
&gt; Roman<br>
&gt; <br>
&gt; <br>
&gt; &gt; So, it looks good to me.<br>
&gt; &gt; Reviewed-by: Misono Tomohiro &lt;<a href=3D"mailto:misono.tomohir=
o@jp.fujitsu.com" target=3D"_blank">misono.tomohiro@jp.fujitsu.com</a>&gt;<=
br>
&gt; &gt;<br>
&gt; &gt; Regards,<br>
&gt; &gt; Misono<br>
&gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Cc: Misono Tomohiro &lt;<a href=3D"mailto:misono.tomohiro@jp=
.fujitsu.com" target=3D"_blank">misono.tomohiro@jp.fujitsu.com</a>&gt;<br>
&gt; &gt; &gt; Signed-off-by: Stefan Hajnoczi &lt;<a href=3D"mailto:stefanh=
a@redhat.com" target=3D"_blank">stefanha@redhat.com</a>&gt;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt;=C2=A0 tools/virtiofsd/fuse_virtio.c | 16 ++++++++++++++++<br=
>
&gt; &gt; &gt;=C2=A0 1 file changed, 16 insertions(+)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; diff --git a/tools/virtiofsd/fuse_virtio.c<br>
&gt; &gt; b/tools/virtiofsd/fuse_virtio.c<br>
&gt; &gt; &gt; index 3b6d16a041..9e5537506c 100644<br>
&gt; &gt; &gt; --- a/tools/virtiofsd/fuse_virtio.c<br>
&gt; &gt; &gt; +++ b/tools/virtiofsd/fuse_virtio.c<br>
&gt; &gt; &gt; @@ -949,6 +949,22 @@ int virtio_session_mount(struct fuse_se=
ssion *se)<br>
&gt; &gt; &gt;=C2=A0 {<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 int ret;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 /*<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0* Test that unshare(CLONE_FS) works. fv=
_queue_worker() will need<br>
&gt; &gt; it. It&#39;s<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0* an unprivileged system call but some =
Docker/Moby versions are<br>
&gt; &gt; known to<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0* reject it via seccomp when CAP_SYS_AD=
MIN is not given.<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0*<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0* Note that the program is single-threa=
ded here so this syscall<br>
&gt; &gt; has no<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0* visible effect and is safe to make.<b=
r>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 ret =3D unshare(CLONE_FS);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 if (ret =3D=3D -1 &amp;&amp; errno =3D=3D EPE=
RM) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 fuse_log(FUSE_LOG_ERR, &quot;un=
share(CLONE_FS) failed with EPERM. If<br>
&gt; &gt; &quot;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &qu=
ot;running in a container please check that the container<br>
&gt; &gt; &quot;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &qu=
ot;runtime seccomp policy allows unshare.\n&quot;);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 ret =3D fv_create_listen_socket(se);<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0) {<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
&gt; &gt; &gt; --<br>
&gt; &gt; &gt; 2.26.2<br>
&gt; &gt;<br>
&gt; &gt;<br>
<br>
</blockquote></div></div>

--00000000000078858c05ab8fee64--


