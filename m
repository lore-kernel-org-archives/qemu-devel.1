Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F2DC4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 02:16:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC54620773
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 02:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="V3+PxB+z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC54620773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNRfD-0002rI-4v
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 22:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangjiachen.jaycee@bytedance.com>)
 id 1kNRde-0002Qr-RG
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 22:14:39 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:35635)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangjiachen.jaycee@bytedance.com>)
 id 1kNRdZ-0000Di-Bd
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 22:14:37 -0400
Received: by mail-qt1-x841.google.com with SMTP id o21so91099qtp.2
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 19:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HocTmxiuyOJ1tnzKeTyr2i/cFTJ+/rUD0ji2hKW0hWw=;
 b=V3+PxB+zA2/M+UKycvzVNRvQaeH8+ziOOmUJWatj8t/HKFrCtf8nPaAdS1sNTY7XUJ
 Y38LfpTkFlDxk3/+ttc+z6UBwNPAwIh9lME+IVCA0TRibUf/bqhjKL8b+HQyrYBB51lH
 weKz3gNBGp36Ak4I3VkDvq7vLvsU3ZH2iAOmk58paw02T8yKjvcgTEvgztK0OPWh4Lwg
 oCvXZxlAfPxSNpPhgNoBUf0zX/k7AvWYZL2ucywmX6XMRYcEPJ+MXm/eUTQzrAktc+SC
 2eLo/gtSdIoSEU4lqu9LpvsQh1BxMkgR7RyOVgv7nTUgcJiUU2qq/vMareJA8K8HpkMY
 sYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HocTmxiuyOJ1tnzKeTyr2i/cFTJ+/rUD0ji2hKW0hWw=;
 b=bvQmoitoWeO5HO+nT2meEW0OlMc58NWHmTmQYQGXCqRi4DBYzJMqV0P2Ij5JX1j1ZW
 ue38ZWtAeRWfoCqQWEurSnhIWqOySENEkRmaJjMl8EQ20GNnnVByxZjTZ9maTMvZ7p2h
 2rmamhAeypprp1cmAm4z0lxSN5moZ6fGSjvLMm5Y6YWRWV+dxCrdBRhfFy1pKLR8Wv1m
 8rLeNEy2HGZzk7ZvATGevF3VHsHWgtny0bRWTdwhVI0fekNXAcGUXrUYWKUbaSRqdYLQ
 m57VjxaBs+ntHCNsl1oNMS9VJIGTetWU4w0Vw50E3MWk09TFCdi9fl0h9x4S1MMPgCdH
 8zaA==
X-Gm-Message-State: AOAM533GxdZF8el2+IIMvgZnvljIOoop9TPcIKQXGNi1QB86i0q6odgT
 1N+ITgN/d9tF0oC3hI9siopf1cDFFFJ+4z9dX9wLAw==
X-Google-Smtp-Source: ABdhPJxPuN6JBhBMhqWzo2JQMAYcxhMHk4dBAsiuhSpEAXs3pg1JUT9A+F4v3JhmLWGx0vtB5RNZGPHgjG/Nuq/26Lw=
X-Received: by 2002:ac8:6f1c:: with SMTP id g28mr123693qtv.225.1601432070325; 
 Tue, 29 Sep 2020 19:14:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200925120655.295142-1-dgilbert@redhat.com>
 <20200925120655.295142-27-dgilbert@redhat.com>
 <20200929215319.GI220516@redhat.com>
In-Reply-To: <20200929215319.GI220516@redhat.com>
From: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Date: Wed, 30 Sep 2020 10:14:19 +0800
Message-ID: <CAFQAk7hdpb4iRoFjXUOP6otDE=4PDJU1tYa3rFLOMgwzsvj1xg@mail.gmail.com>
Subject: Re: [External] Re: [PULL 26/26] virtiofsd: Add -o
 allow_direct_io|no_allow_direct_io options
To: Vivek Goyal <vgoyal@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000af2e2505b07e7500"
Received-SPF: pass client-ip=2607:f8b0:4864:20::841;
 envelope-from=zhangjiachen.jaycee@bytedance.com; helo=mail-qt1-x841.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: lvivier@redhat.com, quintela@redhat.com, hgcoin@gmail.com,
 "Dr. David Alan Gilbert \(git\)" <dgilbert@redhat.com>, peterx@redhat.com,
 qemu-devel@nongnu.org, zhengchuan@huawei.com,
 Yongji Xie <xieyongji@bytedance.com>, dovmurik@linux.vnet.ibm.com,
 ann.zhuangyanying@huawei.com, Stefan Hajnoczi <stefanha@redhat.com>,
 jinyan12@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000af2e2505b07e7500
Content-Type: text/plain; charset="UTF-8"

On Wed, Sep 30, 2020 at 5:53 AM Vivek Goyal <vgoyal@redhat.com> wrote:

> On Fri, Sep 25, 2020 at 01:06:55PM +0100, Dr. David Alan Gilbert (git)
> wrote:
> > From: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
> >
> > Due to the commit 65da4539803373ec4eec97ffc49ee90083e56efd, the O_DIRECT
> > open flag of guest applications will be discarded by virtiofsd. While
> > this behavior makes it consistent with the virtio-9p scheme when guest
> > applications use direct I/O, we no longer have any chance to bypass the
> > host page cache.
> >
> > Therefore, we add a flag 'allow_direct_io' to lo_data. If '-o
> >  no_allow_direct_io' option is added, or none of '-o allow_direct_io' or
> >  '-o no_allow_direct_io' is added, the 'allow_direct_io' will be set to
> >  0, and virtiofsd discards O_DIRECT as before. If '-o allow_direct_io'
> > is added to the starting command-line, 'allow_direct_io' will be set to
> > 1, so that the O_DIRECT flags will be retained and host page cache can
> > be bypassed.
>
> Hi Jiachen,
>
> Curious that in what cases you want to bypass host page cache.
>
> Thanks
> Vivek
>

Hi Vivek,

Some apps like DBMS may allocate their own file cache in userspace, so they
may want to bypass kernel page cache by using O_DIRECT. When these apps are
running in guest and access virtio-fs files, we'd better obey these needs.
This can also eliminate the host memory usage.

Another case is when we perform file I/O benchmarks on different storage
devices (like HDD and SSD), it's not that fair to introduce ram caches. By
using "cache=none" with "allow_direct_io", we can bypass guest and host page
caches, and access the storage devices directly.

Best wishes,
Jiachen


> >
> > Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Message-Id: <20200824105957.61265-1-zhangjiachen.jaycee@bytedance.com>
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  tools/virtiofsd/helper.c         |  4 ++++
> >  tools/virtiofsd/passthrough_ll.c | 20 ++++++++++++++------
> >  2 files changed, 18 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
> > index 7bc5d7dc5a..85770d63f1 100644
> > --- a/tools/virtiofsd/helper.c
> > +++ b/tools/virtiofsd/helper.c
> > @@ -178,6 +178,10 @@ void fuse_cmdline_help(void)
> >             "                               (0 leaves rlimit
> unchanged)\n"
> >             "                               default: min(1000000,
> fs.file-max - 16384)\n"
> >             "                                        if the current
> rlimit is lower\n"
> > +           "    -o allow_direct_io|no_allow_direct_io\n"
> > +           "                               retain/discard O_DIRECT
> flags passed down\n"
> > +           "                               to virtiofsd from guest
> applications.\n"
> > +           "                               default:
> no_allow_direct_io\n"
> >             );
> >  }
> >
> > diff --git a/tools/virtiofsd/passthrough_ll.c
> b/tools/virtiofsd/passthrough_ll.c
> > index 784330e0e4..0b229ebd57 100644
> > --- a/tools/virtiofsd/passthrough_ll.c
> > +++ b/tools/virtiofsd/passthrough_ll.c
> > @@ -151,6 +151,7 @@ struct lo_data {
> >      int timeout_set;
> >      int readdirplus_set;
> >      int readdirplus_clear;
> > +    int allow_direct_io;
> >      struct lo_inode root;
> >      GHashTable *inodes; /* protected by lo->mutex */
> >      struct lo_map ino_map; /* protected by lo->mutex */
> > @@ -179,6 +180,8 @@ static const struct fuse_opt lo_opts[] = {
> >      { "cache=always", offsetof(struct lo_data, cache), CACHE_ALWAYS },
> >      { "readdirplus", offsetof(struct lo_data, readdirplus_set), 1 },
> >      { "no_readdirplus", offsetof(struct lo_data, readdirplus_clear), 1
> },
> > +    { "allow_direct_io", offsetof(struct lo_data, allow_direct_io), 1 },
> > +    { "no_allow_direct_io", offsetof(struct lo_data, allow_direct_io),
> 0 },
> >      FUSE_OPT_END
> >  };
> >  static bool use_syslog = false;
> > @@ -1516,7 +1519,8 @@ static void lo_releasedir(fuse_req_t req,
> fuse_ino_t ino,
> >      fuse_reply_err(req, 0);
> >  }
> >
> > -static void update_open_flags(int writeback, struct fuse_file_info *fi)
> > +static void update_open_flags(int writeback, int allow_direct_io,
> > +                              struct fuse_file_info *fi)
> >  {
> >      /*
> >       * With writeback cache, kernel may send read requests even
> > @@ -1541,10 +1545,13 @@ static void update_open_flags(int writeback,
> struct fuse_file_info *fi)
> >
> >      /*
> >       * O_DIRECT in guest should not necessarily mean bypassing page
> > -     * cache on host as well. If somebody needs that behavior, it
> > -     * probably should be a configuration knob in daemon.
> > +     * cache on host as well. Therefore, we discard it by default
> > +     * ('-o no_allow_direct_io'). If somebody needs that behavior,
> > +     * the '-o allow_direct_io' option should be set.
> >       */
> > -    fi->flags &= ~O_DIRECT;
> > +    if (!allow_direct_io) {
> > +        fi->flags &= ~O_DIRECT;
> > +    }
> >  }
> >
> >  static void lo_create(fuse_req_t req, fuse_ino_t parent, const char
> *name,
> > @@ -1576,7 +1583,7 @@ static void lo_create(fuse_req_t req, fuse_ino_t
> parent, const char *name,
> >          goto out;
> >      }
> >
> > -    update_open_flags(lo->writeback, fi);
> > +    update_open_flags(lo->writeback, lo->allow_direct_io, fi);
> >
> >      fd = openat(parent_inode->fd, name, (fi->flags | O_CREAT) &
> ~O_NOFOLLOW,
> >                  mode);
> > @@ -1786,7 +1793,7 @@ static void lo_open(fuse_req_t req, fuse_ino_t
> ino, struct fuse_file_info *fi)
> >      fuse_log(FUSE_LOG_DEBUG, "lo_open(ino=%" PRIu64 ", flags=%d)\n",
> ino,
> >               fi->flags);
> >
> > -    update_open_flags(lo->writeback, fi);
> > +    update_open_flags(lo->writeback, lo->allow_direct_io, fi);
> >
> >      sprintf(buf, "%i", lo_fd(req, ino));
> >      fd = openat(lo->proc_self_fd, buf, fi->flags & ~O_NOFOLLOW);
> > @@ -2823,6 +2830,7 @@ int main(int argc, char *argv[])
> >          .debug = 0,
> >          .writeback = 0,
> >          .posix_lock = 0,
> > +        .allow_direct_io = 0,
> >          .proc_self_fd = -1,
> >      };
> >      struct lo_map_elem *root_elem;
> > --
> > 2.26.2
> >
>
>

--000000000000af2e2505b07e7500
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div class=3D"gmail_quote"><div=
 class=3D"gmail_attr" dir=3D"ltr">On Wed, Sep 30, 2020 at 5:53 AM Vivek Goy=
al &lt;<a href=3D"mailto:vgoyal@redhat.com">vgoyal@redhat.com</a>&gt; wrote=
:<br></div><blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex" class=3D"gmail_quote">On Fri, Sep 25=
, 2020 at 01:06:55PM +0100, Dr. David Alan Gilbert (git) wrote:<br>
&gt; From: Jiachen Zhang &lt;<a target=3D"_blank" href=3D"mailto:zhangjiach=
en.jaycee@bytedance.com">zhangjiachen.jaycee@bytedance.com</a>&gt;<br>
&gt; <br>
&gt; Due to the commit 65da4539803373ec4eec97ffc49ee90083e56efd, the O_DIRE=
CT<br>
&gt; open flag of guest applications will be discarded by virtiofsd. While<=
br>
&gt; this behavior makes it consistent with the virtio-9p scheme when guest=
<br>
&gt; applications use direct I/O, we no longer have any chance to bypass th=
e<br>
&gt; host page cache.<br>
&gt; <br>
&gt; Therefore, we add a flag &#39;allow_direct_io&#39; to lo_data. If &#39=
;-o<br>
&gt;=C2=A0 no_allow_direct_io&#39; option is added, or none of &#39;-o allo=
w_direct_io&#39; or<br>
&gt;=C2=A0 &#39;-o no_allow_direct_io&#39; is added, the &#39;allow_direct_=
io&#39; will be set to<br>
&gt;=C2=A0 0, and virtiofsd discards O_DIRECT as before. If &#39;-o allow_d=
irect_io&#39;<br>
&gt; is added to the starting command-line, &#39;allow_direct_io&#39; will =
be set to<br>
&gt; 1, so that the O_DIRECT flags will be retained and host page cache can=
<br>
&gt; be bypassed.<br>
<br>
Hi Jiachen,<br>
<br>
Curious that in what cases you want to bypass host page cache.<br>
<br>
Thanks<br>
Vivek<br></blockquote><div>=C2=A0<br></div><div>Hi Vivek,</div><div><br></d=
iv><div>Some apps like DBMS may allocate their own file cache in userspace,=
 so they<br>may want to bypass kernel page cache by using O_DIRECT. When th=
ese apps are<br>running in guest and access virtio-fs files, we&#39;d bette=
r obey these needs.<br>This can also eliminate the host memory usage.<br><b=
r>Another case is when we perform=C2=A0file I/O benchmarks on different sto=
rage<br>devices (like HDD and SSD), it&#39;s not that fair to introduce ram=
 caches. By<br>using &quot;cache=3Dnone&quot; with &quot;allow_direct_io&qu=
ot;, we can bypass guest and host page<br>caches, and access the storage de=
vices directly.<br></div><div><br></div><div>Best wishes,</div><div>Jiachen=
</div><div>=C2=A0</div><blockquote style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex" class=3D"gmail_quote">
&gt; <br>
&gt; Signed-off-by: Jiachen Zhang &lt;<a target=3D"_blank" href=3D"mailto:z=
hangjiachen.jaycee@bytedance.com">zhangjiachen.jaycee@bytedance.com</a>&gt;=
<br>
&gt; Reviewed-by: Stefan Hajnoczi &lt;<a target=3D"_blank" href=3D"mailto:s=
tefanha@redhat.com">stefanha@redhat.com</a>&gt;<br>
&gt; Message-Id: &lt;<a target=3D"_blank" href=3D"mailto:20200824105957.612=
65-1-zhangjiachen.jaycee@bytedance.com">20200824105957.61265-1-zhangjiachen=
.jaycee@bytedance.com</a>&gt;<br>
&gt; Signed-off-by: Dr. David Alan Gilbert &lt;<a target=3D"_blank" href=3D=
"mailto:dgilbert@redhat.com">dgilbert@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 tools/virtiofsd/helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 4 ++++<br>
&gt;=C2=A0 tools/virtiofsd/passthrough_ll.c | 20 ++++++++++++++------<br>
&gt;=C2=A0 2 files changed, 18 insertions(+), 6 deletions(-)<br>
&gt; <br>
&gt; diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c<br>
&gt; index 7bc5d7dc5a..85770d63f1 100644<br>
&gt; --- a/tools/virtiofsd/helper.c<br>
&gt; +++ b/tools/virtiofsd/helper.c<br>
&gt; @@ -178,6 +178,10 @@ void fuse_cmdline_help(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0(0 leaves rlimit unchanged)\n&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0default: min(1000000, fs.file-max - 16384)\n&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if the current rlimit is l=
ower\n&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 =C2=A0 -o allow=
_direct_io|no_allow_direct_io\n&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0retain/discard O_DIRECT flags passed down\n&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0to virtiofsd from guest applications.\n&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0default: no_allow_direct_io\n&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0);<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passth=
rough_ll.c<br>
&gt; index 784330e0e4..0b229ebd57 100644<br>
&gt; --- a/tools/virtiofsd/passthrough_ll.c<br>
&gt; +++ b/tools/virtiofsd/passthrough_ll.c<br>
&gt; @@ -151,6 +151,7 @@ struct lo_data {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int timeout_set;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int readdirplus_set;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int readdirplus_clear;<br>
&gt; +=C2=A0 =C2=A0 int allow_direct_io;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 struct lo_inode root;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 GHashTable *inodes; /* protected by lo-&gt;mutex *=
/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 struct lo_map ino_map; /* protected by lo-&gt;mute=
x */<br>
&gt; @@ -179,6 +180,8 @@ static const struct fuse_opt lo_opts[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 { &quot;cache=3Dalways&quot;, offsetof(struct lo_d=
ata, cache), CACHE_ALWAYS },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 { &quot;readdirplus&quot;, offsetof(struct lo_data=
, readdirplus_set), 1 },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 { &quot;no_readdirplus&quot;, offsetof(struct lo_d=
ata, readdirplus_clear), 1 },<br>
&gt; +=C2=A0 =C2=A0 { &quot;allow_direct_io&quot;, offsetof(struct lo_data,=
 allow_direct_io), 1 },<br>
&gt; +=C2=A0 =C2=A0 { &quot;no_allow_direct_io&quot;, offsetof(struct lo_da=
ta, allow_direct_io), 0 },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 FUSE_OPT_END<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 static bool use_syslog =3D false;<br>
&gt; @@ -1516,7 +1519,8 @@ static void lo_releasedir(fuse_req_t req, fuse_i=
no_t ino,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 fuse_reply_err(req, 0);<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -static void update_open_flags(int writeback, struct fuse_file_info *f=
i)<br>
&gt; +static void update_open_flags(int writeback, int allow_direct_io,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct fuse_file_info *fi)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* With writeback cache, kernel may send read=
 requests even<br>
&gt; @@ -1541,10 +1545,13 @@ static void update_open_flags(int writeback, s=
truct fuse_file_info *fi)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 /*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* O_DIRECT in guest should not necessarily m=
ean bypassing page<br>
&gt; -=C2=A0 =C2=A0 =C2=A0* cache on host as well. If somebody needs that b=
ehavior, it<br>
&gt; -=C2=A0 =C2=A0 =C2=A0* probably should be a configuration knob in daem=
on.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* cache on host as well. Therefore, we discard it=
 by default<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* (&#39;-o no_allow_direct_io&#39;). If somebody =
needs that behavior,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* the &#39;-o allow_direct_io&#39; option should =
be set.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; -=C2=A0 =C2=A0 fi-&gt;flags &amp;=3D ~O_DIRECT;<br>
&gt; +=C2=A0 =C2=A0 if (!allow_direct_io) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 fi-&gt;flags &amp;=3D ~O_DIRECT;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static void lo_create(fuse_req_t req, fuse_ino_t parent, const c=
har *name,<br>
&gt; @@ -1576,7 +1583,7 @@ static void lo_create(fuse_req_t req, fuse_ino_t=
 parent, const char *name,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 update_open_flags(lo-&gt;writeback, fi);<br>
&gt; +=C2=A0 =C2=A0 update_open_flags(lo-&gt;writeback, lo-&gt;allow_direct=
_io, fi);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 fd =3D openat(parent_inode-&gt;fd, name, (fi-&gt;f=
lags | O_CREAT) &amp; ~O_NOFOLLOW,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mode);<b=
r>
&gt; @@ -1786,7 +1793,7 @@ static void lo_open(fuse_req_t req, fuse_ino_t i=
no, struct fuse_file_info *fi)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 fuse_log(FUSE_LOG_DEBUG, &quot;lo_open(ino=3D%&quo=
t; PRIu64 &quot;, flags=3D%d)\n&quot;, ino,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fi-&gt;flags);<b=
r>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 update_open_flags(lo-&gt;writeback, fi);<br>
&gt; +=C2=A0 =C2=A0 update_open_flags(lo-&gt;writeback, lo-&gt;allow_direct=
_io, fi);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 sprintf(buf, &quot;%i&quot;, lo_fd(req, ino));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 fd =3D openat(lo-&gt;proc_self_fd, buf, fi-&gt;fla=
gs &amp; ~O_NOFOLLOW);<br>
&gt; @@ -2823,6 +2830,7 @@ int main(int argc, char *argv[])<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .debug =3D 0,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .writeback =3D 0,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .posix_lock =3D 0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .allow_direct_io =3D 0,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .proc_self_fd =3D -1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 };<br>
&gt;=C2=A0 =C2=A0 =C2=A0 struct lo_map_elem *root_elem;<br>
&gt; -- <br>
&gt; 2.26.2<br>
&gt; <br>
<br>
</blockquote></div></div>

--000000000000af2e2505b07e7500--

