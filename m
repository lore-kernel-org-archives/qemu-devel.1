Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767AEC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 09:15:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D40F20756
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 09:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HvtgLeMQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D40F20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZsP6-00006U-Ea
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 04:15:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mszeredi@redhat.com>)
 id 1kZsOT-00087i-Pr
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 04:14:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48341)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mszeredi@redhat.com>)
 id 1kZsOR-0000Qm-8w
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 04:14:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604394857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3+rqaK9mP9eJ9kkpvL44YAR367ZKdHD8xoYou82O0bE=;
 b=HvtgLeMQqjTzdOWXtr0dVkyFVzoGbo8xYTD0nvuxWPO3k5Xv9X1glWNX2uCAVCiQJShIQf
 mXz2P1FiP+VMH4wYVPYDlFlHbeZ11XNXcqKA2pwBC60iozDTqc59jJilnHQ+2XbEnGoMrE
 TecPkX1RktAKjLVUHSOlEEB6ewIABiQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-CFYFl2h8PYCaoovlK01OKw-1; Tue, 03 Nov 2020 04:14:15 -0500
X-MC-Unique: CFYFl2h8PYCaoovlK01OKw-1
Received: by mail-qt1-f197.google.com with SMTP id f10so9577830qtv.6
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 01:14:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=3+rqaK9mP9eJ9kkpvL44YAR367ZKdHD8xoYou82O0bE=;
 b=LIi1JJtYHCEMteubYC1xW5oLjshXbGDnc8CKlP+r47V/Cm/NlYHDQNR52hY5SpkAm5
 qrFwzXDeyQF6hIEL1fJ55TNxQ1RkUkWyOjjCVM9MBrMF8A9fq74okUp2S0WtsT+gSjSe
 W5Jy151cshsDwp83kCybWJhkPMhImjy2K4Ufsu3KgagXSqNc4O+VBaErkA9q23uEEut1
 mmY1aYj7fv0W8MvLVF8ahuWr0deZvj4PKWoSVvr3vpVrKaal1gl0mefAv5eT3zd3vV7y
 blYO8tvf7bwbJ6KrspeLnkc+5fbY+S5yOGdlUb9f++UsvYHjGdJXhK6775SjtzBN86Wg
 /hHg==
X-Gm-Message-State: AOAM530X1hfFLa/dfZtAlgXkKgyG8rP4hWFOOp5yXsc+/kUbpDeDA1Pr
 STg2WgX3GRFxqXZ4CpzWwxCvfBqyCIV8dFOS7Rq3EvzXizLy88YVmWzUbBiGH7opowboDc+kIj7
 W3NxhYxDBl2EGLlUs8MWcM9RRM5HKF8Y=
X-Received: by 2002:a05:620a:1265:: with SMTP id
 b5mr18139873qkl.27.1604394854877; 
 Tue, 03 Nov 2020 01:14:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxJi6wseuscgn4MT4BYRmm/sJPn9ipZyC04/Q000/ESMdQFng2NyJGKNAj2MZZQ4vKxngkjRjnPdCtXXq/m0es=
X-Received: by 2002:a05:620a:1265:: with SMTP id
 b5mr18139856qkl.27.1604394854549; 
 Tue, 03 Nov 2020 01:14:14 -0800 (PST)
MIME-Version: 1.0
References: <20201102161859.156603-1-mreitz@redhat.com>
 <20201102161859.156603-6-mreitz@redhat.com>
 <CAOssrKdrRV6vbooVnMH2Hrq3XPAG6uX4N8nxgwxRDzAyKF1A1g@mail.gmail.com>
 <cecb2ca8-d15a-76e7-a34d-c37b85929961@redhat.com>
In-Reply-To: <cecb2ca8-d15a-76e7-a34d-c37b85929961@redhat.com>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Tue, 3 Nov 2020 10:14:03 +0100
Message-ID: <CAOssrKcqyQyYrsR9wxGKjeJ7KMAEuZ=avW3u9bhg2fhB1Y4Ypg@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] virtiofsd: Announce sub-mount points
To: Max Reitz <mreitz@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mszeredi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mszeredi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: virtio-fs-list <virtio-fs@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 3, 2020 at 10:00 AM Max Reitz <mreitz@redhat.com> wrote:
>
> On 03.11.20 09:10, Miklos Szeredi wrote:
> > On Mon, Nov 2, 2020 at 5:19 PM Max Reitz <mreitz@redhat.com> wrote:
> >>
> >> Whenever we encounter a directory with an st_dev or mount ID that
> >> differs from that of its parent, we set the FUSE_ATTR_SUBMOUNT flag so
> >> the guest can create a submount for it.
> >>
> >> We only need to do so in lo_do_lookup().  The following functions retu=
rn
> >> a fuse_attr object:
> >> - lo_create(), though fuse_reply_create(): Calls lo_do_lookup().
> >> - lo_lookup(), though fuse_reply_entry(): Calls lo_do_lookup().
> >> - lo_mknod_symlink(), through fuse_reply_entry(): Calls lo_do_lookup()=
.
> >> - lo_link(), through fuse_reply_entry(): Creating a link cannot create=
 a
> >>   submount, so there is no need to check for it.
> >> - lo_getattr(), through fuse_reply_attr(): Announcing submounts when t=
he
> >>   node is first detected (at lookup) is sufficient.  We do not need to
> >>   return the submount attribute later.
> >> - lo_do_readdir(), through fuse_add_direntry_plus(): Calls
> >>   lo_do_lookup().
> >>
> >> Make announcing submounts optional, so submounts are only announced to
> >> the guest with the announce_submounts option.  Some users may prefer t=
he
> >> current behavior, so that the guest learns nothing about the host moun=
t
> >> structure.
> >>
> >> (announce_submounts is force-disabled when the guest does not present
> >> the FUSE_SUBMOUNTS capability, or when there is no statx().)
> >>
> >> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> >> ---
> >>  tools/virtiofsd/helper.c         |  1 +
> >>  tools/virtiofsd/passthrough_ll.c | 22 ++++++++++++++++++++++
> >>  2 files changed, 23 insertions(+)
> >>
> >> diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
> >> index 2e181a49b5..4433724d3a 100644
> >> --- a/tools/virtiofsd/helper.c
> >> +++ b/tools/virtiofsd/helper.c
> >> @@ -190,6 +190,7 @@ void fuse_cmdline_help(void)
> >>             "                               retain/discard O_DIRECT fl=
ags passed down\n"
> >>             "                               to virtiofsd from guest ap=
plications.\n"
> >>             "                               default: no_allow_direct_i=
o\n"
> >> +           "    -o announce_submounts      Announce sub-mount points =
to the guest\n"
> >>             );
> >>  }
> >>
> >> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passth=
rough_ll.c
> >> index 34d107975f..ec1008bceb 100644
> >> --- a/tools/virtiofsd/passthrough_ll.c
> >> +++ b/tools/virtiofsd/passthrough_ll.c
> >> @@ -40,6 +40,7 @@
> >>  #include "fuse_virtio.h"
> >>  #include "fuse_log.h"
> >>  #include "fuse_lowlevel.h"
> >> +#include "standard-headers/linux/fuse.h"
> >>  #include <assert.h>
> >>  #include <cap-ng.h>
> >>  #include <dirent.h>
> >> @@ -167,6 +168,7 @@ struct lo_data {
> >>      int readdirplus_set;
> >>      int readdirplus_clear;
> >>      int allow_direct_io;
> >> +    int announce_submounts;
> >>      bool use_statx;
> >>      struct lo_inode root;
> >>      GHashTable *inodes; /* protected by lo->mutex */
> >> @@ -207,6 +209,7 @@ static const struct fuse_opt lo_opts[] =3D {
> >>      { "no_readdirplus", offsetof(struct lo_data, readdirplus_clear), =
1 },
> >>      { "allow_direct_io", offsetof(struct lo_data, allow_direct_io), 1=
 },
> >>      { "no_allow_direct_io", offsetof(struct lo_data, allow_direct_io)=
, 0 },
> >> +    { "announce_submounts", offsetof(struct lo_data, announce_submoun=
ts), 1 },
> >>      FUSE_OPT_END
> >>  };
> >>  static bool use_syslog =3D false;
> >> @@ -601,6 +604,20 @@ static void lo_init(void *userdata, struct fuse_c=
onn_info *conn)
> >>          fuse_log(FUSE_LOG_DEBUG, "lo_init: disabling readdirplus\n");
> >>          conn->want &=3D ~FUSE_CAP_READDIRPLUS;
> >>      }
> >> +
> >> +    if (!(conn->capable & FUSE_CAP_SUBMOUNTS) && lo->announce_submoun=
ts) {
> >> +        fuse_log(FUSE_LOG_WARNING, "lo_init: Cannot announce submount=
s, client "
> >> +                 "does not support it\n");
> >> +        lo->announce_submounts =3D false;
> >> +    }
> >> +
> >> +#ifndef CONFIG_STATX
> >> +    if (lo->announce_submounts) {
> >> +        fuse_log(FUSE_LOG_WARNING, "lo_init: Cannot announce submount=
s, there "
> >> +                 "is no statx()\n");
> >> +        lo->announce_submounts =3D false;
> >
> > Minor issue: this warns only when libc doesn't have statx, and not
> > when kernel doesn't have it.
> >
> >> +    }
> >> +#endif
> >>  }
> >>
> >>  static void lo_getattr(fuse_req_t req, fuse_ino_t ino,
> >> @@ -877,6 +894,11 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_=
t parent, const char *name,
> >>          goto out_err;
> >>      }
> >>
> >> +    if (S_ISDIR(e->attr.st_mode) && lo->announce_submounts &&
> >> +        (e->attr.st_dev !=3D dir->key.dev || mnt_id !=3D dir->key.mnt=
_id)) {
> >> +        e->attr_flags |=3D FUSE_ATTR_SUBMOUNT;
> >> +    }
> >
> > ... and since announce_submounts isn't turned off in case the kernel
> > doesn't have STATX_MNT_ID, this will trigger a submount when crossing
> > into a different filesystem.
>
> Oh.  Yes.  I totally forgot that when writing the warning.
>
> > Possible solutions:
> >
> > a) test and warn at startup in case kernel doesn't have statx
> >
> > b) do not test st_dev, only mnt_id (which will always be zero if not su=
pported)
> >
> > c) merge announce_submounts and use_statx, which are basically doing
> > the same thing
>
> Isn=E2=80=99t that a single thing?  I.e., if we decide not to test st_dev=
, then
> we should do all of these, I think.
>
> OTOH, we could also just drop the warning (that statx()) isn=E2=80=99t
> available, because as the code is, we can still announce submounts.  The
> only problem is that we=E2=80=99ll suffer from the bug fixed by patch 4
> (different mounts with the same st_dev being treated as the same tree),
> but that=E2=80=99s unrelated to announcing submounts.
>
> (Well, to be fair, not having statx() does break one thing about
> submounts: I suppose you could mount a device inside of its own mount
> (=E2=80=9Cmount $mount_opts $dir; mount $mount_opts $dir/sub=E2=80=9D =E2=
=80=93 then $dir/sub
> wouldn=E2=80=99t be marked as a submount without statx()), but that proba=
bly
> yields a host of other problems besides not announcing the nested mount
> as a submount (virtiofsd would treat $dir/sub as the same node as $dir,
> I think), so again, I wouldn=E2=80=99t worry too much about not getting t=
he
> FUSE_SUBMOUNT flag right.)
>
> So I think I=E2=80=99d rather just drop the warning and leave the rest as=
 it is.
>  Not least because STATX_MNT_ID is rather new.

Okay, makes sense.   The nested  bind mount case is likely not very
likely to turn up in real life, and if it does, submounts can still be
disabled explicitly.

Thanks,
Miklos


