Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49352C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 15:55:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8ACC20716
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 15:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpQuCgNX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8ACC20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwpgj-00067z-OU
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 10:55:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55618)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iwpg3-0005jJ-HK
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 10:54:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iwpg1-0007gI-RS
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 10:54:51 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40453)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iwpg1-0007c9-K7
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 10:54:49 -0500
Received: by mail-wr1-x441.google.com with SMTP id j104so4896780wrj.7
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 07:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=lfQrDiALMX9IUmzHstEmBYeZCsqg5OQtuntLV+G8qd8=;
 b=MpQuCgNX5JbgyhxJbTNk+ggZkXW8THxWUn4I9QzrupDKXeJuNW9UnPCDip6TvdbLeD
 LrPo5BAKl+KxguvrLnxpEZzv4LikK6wuM6Tv5hGyTET7JRzRwPzkW/L3KSz+xKymfit3
 C9gjoQ/it45B4efHh6x+4L9d2fJtiOkiX6oxlaYr7JU5O0t1Y16zjYCmxE5Myv/01QUp
 fR8XqvS+1FxpacN42dp0e0Zc3AB3t5p4tdRv3QrzJL3C2Vonbb2ChRiRbtbE1i7qXHc/
 ZRx7Vybaj277+wRCmoU1wYP8wNEATjjwwuNqatRnaVgp5Vj70+989z9qVYlvxrG/M4TX
 ww2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lfQrDiALMX9IUmzHstEmBYeZCsqg5OQtuntLV+G8qd8=;
 b=LgNn1Pe3so4l6lwOHbbPV6DOQQ5rze0MOR6W3UKgaUv7Ug/5IF2IlHUVcZQvQc2bIW
 OmPjQs69NCLufNhUMN+VfUu349lLNHgD/XscLZL+BgS33Tq1hDRxc0TjsqzJmX6wNhKz
 rcOySiX8+oUQkd29JXcoN0vWSTm+zXvoT2/chPcngi/iLK2H4G0lCBTDS3Rem+wyKm/n
 bRfBwJkDaDSazHDVpQzbRcRiENemjssu2n4sRQQKDieRmKL3DNVgRWjtsEZhfpAKyTKA
 z9hwNPB1q06coO6vEd7rv6KIVoKQHJQCet7UOQRkbqaRY1HcoRZ3op8FOsJghEgY59jH
 /otw==
X-Gm-Message-State: APjAAAV3QhV7Or85Fc4Qxw7BvBBSwmfOfarqpb+VsmFuoib+zZCiaEnK
 QL3Mx2LDCMUaVBOlg6DWfpYigTlkVJgS1XroPYk=
X-Google-Smtp-Source: APXvYqw1O1V5uTubslQLOB19vZ1frDnVjyXP5sj6ETglGSZPVpm/6IOlC5m4rpGlj8Wd35J93xyeey1z0TAPoU5IqTM=
X-Received: by 2002:a5d:43c7:: with SMTP id v7mr34696369wrr.32.1580313288150; 
 Wed, 29 Jan 2020 07:54:48 -0800 (PST)
MIME-Version: 1.0
References: <20200127162514.56784-1-stefanha@redhat.com>
 <m1r1zil1a6.fsf@redhat.com>
In-Reply-To: <m1r1zil1a6.fsf@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 29 Jan 2020 16:54:36 +0100
Message-ID: <CAJ+F1CLWYaV=Aiaw5hLA79mTOb_cy7LSNt15qBT2ykGL55DpyQ@mail.gmail.com>
Subject: Re: [PATCH] docs: add virtiofsd(1) man page
To: Christophe de Dinechin <dinechin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Wed, Jan 29, 2020 at 4:40 PM Christophe de Dinechin
<dinechin@redhat.com> wrote:
>
>
> Stefan Hajnoczi writes:
>
> > Document the virtiofsd(1) program and its command-line options.  This
> > man page is a rST conversion of the original texi documentation that I
> > wrote.
> >
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> > Based-on: 20200124162606.8787-1-peter.maydell@linaro.org
> >           ("[PATCH v2 0/8] qemu-img, qemu-trace-stap, virtfs-proxy-help=
er: convert to rST")
> > ---
> >  MAINTAINERS                |   1 +
> >  Makefile                   |   8 ++-
> >  docs/interop/conf.py       |   5 +-
> >  docs/interop/index.rst     |   1 +
> >  docs/interop/virtiofsd.rst | 123 +++++++++++++++++++++++++++++++++++++
> >  5 files changed, 136 insertions(+), 2 deletions(-)
> >  create mode 100644 docs/interop/virtiofsd.rst
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 83fb32b860..1da0709129 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1603,6 +1603,7 @@ S: Supported
> >  F: tools/virtiofsd/*
> >  F: hw/virtio/vhost-user-fs*
> >  F: include/hw/virtio/vhost-user-fs.h
> > +F: docs/interop/virtiofsd.rst
> >
> >  virtio-input
> >  M: Gerd Hoffmann <kraxel@redhat.com>
> > diff --git a/Makefile b/Makefile
> > index 539f9ef079..ecd26044bc 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -348,6 +348,9 @@ DOCS=3Dqemu-doc.html qemu-doc.txt qemu.1
> >  DOCS+=3D$(MANUAL_BUILDDIR)/interop/qemu-img.1
> >  DOCS+=3D$(MANUAL_BUILDDIR)/interop/qemu-nbd.8
> >  DOCS+=3D$(MANUAL_BUILDDIR)/interop/qemu-ga.8
> > +ifeq ($(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG),yyy)
> > +DOCS+=3D$(MANUAL_BUILDDIR)/interop/virtiofsd.1
> > +endif
> >  DOCS+=3D$(MANUAL_BUILDDIR)/system/qemu-block-drivers.7
> >  DOCS+=3Ddocs/interop/qemu-qmp-ref.html docs/interop/qemu-qmp-ref.txt d=
ocs/interop/qemu-qmp-ref.7
> >  DOCS+=3Ddocs/interop/qemu-ga-ref.html docs/interop/qemu-ga-ref.txt doc=
s/interop/qemu-ga-ref.7
> > @@ -861,6 +864,9 @@ ifdef CONFIG_VIRTFS
> >       $(INSTALL_DIR) "$(DESTDIR)$(mandir)/man1"
> >       $(INSTALL_DATA) $(MANUAL_BUILDDIR)/interop/virtfs-proxy-helper.1 =
"$(DESTDIR)$(mandir)/man1"
> >  endif
> > +ifeq ($(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG),yyy)
> > +     $(INSTALL_DATA) docs/interop/virtiofsd.1 "$(DESTDIR)$(mandir)/man=
1"
> > +endif
> >
> >  install-datadir:
> >       $(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)"
> > @@ -1052,7 +1058,7 @@ $(MANUAL_BUILDDIR)/system/index.html: $(call manu=
al-deps,system)
> >
> >  $(call define-manpage-rule,interop,\
> >         qemu-ga.8 qemu-img.1 qemu-nbd.8 qemu-trace-stap.1\
> > -       virtfs-proxy-helper.1,\
> > +       virtiofsd.1 virtfs-proxy-helper.1,\
> >         $(SRC_PATH/qemu-img-cmds.hx))
> >
> >  $(call define-manpage-rule,system,qemu-block-drivers.7)
> > diff --git a/docs/interop/conf.py b/docs/interop/conf.py
> > index b0f322207c..b3cda17042 100644
> > --- a/docs/interop/conf.py
> > +++ b/docs/interop/conf.py
> > @@ -27,5 +27,8 @@ man_pages =3D [
> >       [], 1),
> >      ('virtfs-proxy-helper', 'virtfs-proxy-helper',
> >       u'QEMU 9p virtfs proxy filesystem helper',
> > -     ['M. Mohan Kumar'], 1)
> > +     ['M. Mohan Kumar'], 1),
> > +    ('virtiofsd', 'virtiofsd', u'QEMU virtio-fs shared file system dae=
mon',
> > +     ['Stefan Hajnoczi <stefanha@redhat.com>',
> > +      'Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>'], 1),
> >  ]
> > diff --git a/docs/interop/index.rst b/docs/interop/index.rst
> > index 3b763b1eeb..e8455b4270 100644
> > --- a/docs/interop/index.rst
> > +++ b/docs/interop/index.rst
> > @@ -24,3 +24,4 @@ Contents:
> >     vhost-user
> >     vhost-user-gpu
> >     virtfs-proxy-helper
> > +   virtiofsd
> > diff --git a/docs/interop/virtiofsd.rst b/docs/interop/virtiofsd.rst
> > new file mode 100644
> > index 0000000000..51a657ac0c
> > --- /dev/null
> > +++ b/docs/interop/virtiofsd.rst
> > @@ -0,0 +1,123 @@
> > +QEMU virtio-fs shared file system daemon
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Synopsis
> > +--------
> > +
> > +**virtiofsd** [*OPTIONS*]
> > +
> > +Description
> > +-----------
> > +
> > +Share a host directory tree with a guest through a virtio-fs device.  =
This
> > +program is a vhost-user backend that implements the virtio-fs device. =
 Each
> > +virtio-fs device instance requires its own virtiofsd process.
> > +
> > +This program is designed to work with QEMU's ``--device vhost-user-fs-=
pci``
> > +but should work with any virtual machine monitor (VMM) that supports
> > +vhost-user.  See the Examples section below.
> > +
> > +This program must be run as the root user.  Upon startup the program w=
ill
> > +switch into a new file system namespace with the shared directory tree=
 as its
> > +root.  This prevents "file system escapes" due to symlinks and other f=
ile
> > +system objects that might lead to files outside the shared directory. =
 The
> > +program also sandboxes itself using seccomp(2) to prevent ptrace(2) an=
d other
> > +vectors that could allow an attacker to compromise the system after ga=
ining
> > +control of the virtiofsd process.
> > +
> > +Options
> > +-------
> > +
> > +.. program:: virtiofsd
> > +
> > +.. option:: -h, --help
> > +
> > +  Print help.
> > +
> > +.. option:: -V, --version
> > +
> > +  Print version.
> > +
> > +.. option:: -d
> > +
> > +  Enable debug output.
> > +
> > +.. option:: --syslog
> > +
> > +  Print log messages to syslog instead of stderr.
> > +
> > +.. option:: -o OPTION
> > +
> > +  * debug -
> > +    Enable debug output.
> > +
> > +  * flock|no_flock -
> > +    Enable/disable flock.  The default is ``no_flock``.
> > +
> > +  * log_level=3DLEVEL -
> > +    Print only log messages matching LEVEL or more severe.  LEVEL is o=
ne of
> > +    ``err``, ``warn``, ``info``, or ``debug``.  The default is ``info`=
`.
> > +
> > +  * norace -
> > +    Disable racy fallback.  The default is false.
>
> It's not a problem with the doc, but seeing it exposes that options are
> not overly consistent in their spelling. "norace" has no _ but no_flock
> does (as does no_writeback).
>
> > +
> > +  * posix_lock|no_posix_lock -
> > +    Enable/disable remote POSIX locks.  The default is ``posix_lock``.
> > +
> > +  * readdirplus|no_readdirplus -
> > +    Enable/disable readdirplus.  The default is ``readdirplus``.
> > +
> > +  * source=3DPATH -
> > +    Share host directory tree located at PATH.  This option is require=
d.
> > +
> > +  * timeout=3DTIMEOUT -
> > +    I/O timeout in seconds.  The default depends on cache=3D option.
> > +
> > +  * vhost_user_socket=3DPATH -
> > +    Listen on vhost-user UNIX domain socket at PATH.
>
> I believe that this option has been removed.
>
> > +
> > +  * writeback|no_writeback -
> > +    Enable/disable writeback cache. The cache alows the FUSE client to=
 buffer
> > +    and merge write requests.  The default is ``no_writeback``.
> > +
> > +  * xattr|no_xattr -
> > +    Enable/disable extended attributes (xattr) on files and directorie=
s.  The
> > +    default is ``no_xattr``.
> > +
> > +.. option:: --socket-path=3DPATH
> > +
> > +  Listen on vhost-user UNIX domain socket at PATH.
>
> Not related to the doc, but this looks like an option that might deserve
> a short form.
>
> > +
> > +.. option:: --fd=3DFDNUM
> > +
> > +  Accept connections from vhost-user UNIX domain socket file descripto=
r FDNUM.
> > +  The file descriptor must already be listening for connections.
>
> Not directly related to the manual itself, but any reason why it's
> "socket-path" and "fd" (as opposed e.g. to "socket-path" and
> "socket-fd"?


This dates back from commit 482580a658df58f5d9f91a87d957660637d59432
("vhost-user: define conventions for vhost-user backends"). I agree it
lacks some consistency. It's a bit late to change it though

>
>
> > +
> > +.. option:: --thread-pool-size=3DNUM
> > +
> > +  Restrict the number of worker threads per request queue to NUM.  The=
 default
> > +  is 64.
> > +
> > +.. option:: --cache=3Dnone|auto|always
> > +
> > +  Select the desired trade-off between coherency and performance.  ``n=
one``
> > +  forbids the FUSE client from caching to achieve best coherency at th=
e cost of
> > +  performance.  ``auto`` acts similar to NFS with a 1 second metadata =
cache
> > +  timeout.  ``always`` sets a long cache lifetime at the expense of co=
herency.
> > +
> > +Examples
> > +--------
> > +
> > +Export ``/var/lib/fs/vm001/`` on vhost-user UNIX domain socket
> > +``/var/run/vm001-vhost-fs.sock``:
> > +
> > +::
> > +
> > +  host# virtiofsd --socket-path=3D/var/run/vm001-vhost-fs.sock -o sour=
ce=3D/var/lib/fs/vm001
> > +  host# qemu-system-x86_64 \
> > +      -chardev socket,id=3Dchar0,path=3D/var/run/vm001-vhost-fs.sock \
> > +      -device vhost-user-fs-pci,chardev=3Dchar0,tag=3Dmyfs \
> > +      -object memory-backend-file,id=3Dmem,size=3D4G,mem-path=3D/dev/s=
hm,share=3Don \
> > +      -numa node,memdev=3Dmem \
> > +      ...
> > +  guest# mount -t virtio_fs myfs /mnt
>
>
> --
> Cheers,
> Christophe de Dinechin (IRC c3d)
>
>


--=20
Marc-Andr=C3=A9 Lureau

