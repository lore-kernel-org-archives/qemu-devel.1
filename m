Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02D5C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 19:14:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D3F320830
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 19:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLDXT/Un"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D3F320830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9wSY-0001jO-DT
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 15:14:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45964)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1i9wRP-0001CC-NG
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 15:13:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1i9wRJ-0006lh-GP
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 15:13:39 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36256)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1i9wRJ-0006kp-15
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 15:13:33 -0400
Received: by mail-wm1-x342.google.com with SMTP id t3so490006wmj.1
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 12:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ii0LBZ4BW4bRFdrxv21hMzIjyRBFyPtw/aEWJDXB55Q=;
 b=JLDXT/Un8FDk+Pr8sBXnZ6fo+SC/1wxFIyAJ0HVy2atlN8B8B3I/sQkq02fqzqKePJ
 MuMHf2/2gcGUvrsP7WxUnLOVvRl4bumMVbPH9l0a7HRcvk1ZRsYrRhgSSO+X6SpfFfeu
 xtbmF70mLsCz5EMfmHhUV/koUCcb0dyL8xuPUV1lfBNMDg5chKDWwXhPbu2Zqaizm/2w
 vccl1QrcNjt/R8TjJPjnkWlyJPM7pKgdoux8TnRlH5THdMJFUkNNUxGwzO13aeQHab+P
 xfnR+mrGlcM3c3VIljtc0CQZ4zZQxO9rH1rdZOoZfpBl/Iey81sqEKJzxnm51360Abjq
 fAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ii0LBZ4BW4bRFdrxv21hMzIjyRBFyPtw/aEWJDXB55Q=;
 b=ckwXiuocQjuqAJJe52wMaFOpLS5DU04zIhCVm2hZWZMIGnen8Dy5P/Pe511kt2OfMU
 qUKWLIlw/JMgGVDvqR3wrcCICn/8zZaNHDJ5kZ9ZdcRNKtHhYzmoLg/IpUHg0mJmFlwc
 BT88mNGCoIi79XxTCpeCGNsSwSkP6Tovt3LY3+2PaP6k6ce/etVyrwVszykJKHZS6diV
 My5nrbMCc4LknfIGwAMEukzsZvlSShogfHU/hFVhCc6vu/Sqr6VhG3dhizL9ghgyBSGo
 /f4IOPJZhdTKwNtzJriYysdwff4zdhrsOOIbS8bKu+A4i8tzbq1Pcsrp4XzhYD/cFXiT
 2EHQ==
X-Gm-Message-State: APjAAAVkBNWbMDPzvMEibZyXjNerfnHSB4Ge0QCaPuVIUYWzjYIQPrhJ
 MB9tFCGGcnSMbpQ53j9+Eipa7hwgZA71Mhhncjw=
X-Google-Smtp-Source: APXvYqwdeV1Q0dUm75LeJ2wDL+69JRpxhIhSXaE+ucpuBDTsp//TEzi3Fp7h0xniaGN6Db0cBz1HSufVpyTtKQSLXmA=
X-Received: by 2002:a1c:c789:: with SMTP id x131mr494804wmf.20.1568661211529; 
 Mon, 16 Sep 2019 12:13:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190912122514.22504-1-marcandre.lureau@redhat.com>
 <20190912122514.22504-6-marcandre.lureau@redhat.com>
 <20190916100035.GC2887@work-vm>
 <CAJ+F1C+GAJc8vYVLzBZWonVkjp-rdWFemAdwgE2sbxJDFKp0Uw@mail.gmail.com>
 <20190916131514.GG2887@work-vm>
In-Reply-To: <20190916131514.GG2887@work-vm>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 16 Sep 2019 23:13:18 +0400
Message-ID: <CAJ+F1C+mbPHHO_Oet-CxUsfAxTrLvezvcV=+0KG+Rv2za=-arg@mail.gmail.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v3 5/6] docs: start a document to describe
 D-Bus usage
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Michal Privoznik <mprivozn@redhat.com>,
 QEMU <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Mon, Sep 16, 2019 at 5:15 PM Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
>
> * Marc-Andr=C3=A9 Lureau (marcandre.lureau@gmail.com) wrote:
> > Hi
> >
> > On Mon, Sep 16, 2019 at 2:02 PM Dr. David Alan Gilbert
> > <dgilbert@redhat.com> wrote:
> > >
> > > (Copying in Stefan since he was looking at DBus for virtiofs)
> > >
> > > * Marc-Andr=C3=A9 Lureau (marcandre.lureau@redhat.com) wrote:
> > > > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > > ---
> > > >  docs/interop/dbus.rst  | 73 ++++++++++++++++++++++++++++++++++++++=
++++
> > > >  docs/interop/index.rst |  1 +
> > > >  2 files changed, 74 insertions(+)
> > > >  create mode 100644 docs/interop/dbus.rst
> > > >
> > > > diff --git a/docs/interop/dbus.rst b/docs/interop/dbus.rst
> > > > new file mode 100644
> > > > index 0000000000..c08f026edc
> > > > --- /dev/null
> > > > +++ b/docs/interop/dbus.rst
> > > > @@ -0,0 +1,73 @@
> > > > +=3D=3D=3D=3D=3D
> > > > +D-Bus
> > > > +=3D=3D=3D=3D=3D
> > > > +
> > > > +Introduction
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +
> > > > +QEMU may be running with various helper processes involved:
> > > > + - vhost-user* processes (gpu, virtfs, input, etc...)
> > > > + - TPM emulation (or other devices)
> > > > + - user networking (slirp)
> > > > + - network services (DHCP/DNS, samba/ftp etc)
> > > > + - background tasks (compression, streaming etc)
> > > > + - client UI
> > > > + - admin & cli
> > > > +
> > > > +Having several processes allows stricter security rules, as well a=
s
> > > > +greater modularity.
> > > > +
> > > > +While QEMU itself uses QMP as primary IPC (and Spice/VNC for remot=
e
> > > > +display), D-Bus is the de facto IPC of choice on Unix systems. The
> > > > +wire format is machine friendly, good bindings exist for various
> > > > +languages, and there are various tools available.
> > > > +
> > > > +Using a bus, helper processes can discover and communicate with ea=
ch
> > > > +other easily, without going through QEMU. The bus topology is also
> > > > +easier to apprehend and debug than a mesh. However, it is wise to
> > > > +consider the security aspects of it.
> > > > +
> > > > +Security
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +
> > > > +A QEMU D-Bus bus should be private to a single VM. Thus, only
> > > > +cooperative tasks are running on the same bus to serve the VM.
> > > > +
> > > > +D-Bus, the protocol and standard, doesn't have mechanisms to enfor=
ce
> > > > +security between peers once the connection is established. Peers m=
ay
> > > > +have additional mechanisms to enforce security rules, based for
> > > > +example on UNIX credentials.
> > > > +
> > > > +dbus-daemon can enforce various policies based on the UID/GID of t=
he
> > > > +processes that are connected to it. It is thus a good idea to run
> > > > +helpers as different UID from QEMU and set appropriate policies (s=
o
> > > > +helper processes are only allowed to talk to qemu for example).
> > > > +
> > > > +For example, this allows only ``qemu`` user to talk to ``qemu-help=
er``
> > > > +``org.qemu.Helper1`` service:
> > > > +
> > > > +.. code:: xml
> > > > +
> > > > +  <policy user=3D"qemu">
> > > > +     <allow send_destination=3D"org.qemu.Helper1"/>
> > > > +     <allow receive_sender=3D"org.qemu.Helper1"/>
> > > > +  </policy>
> > > > +
> > > > +  <policy user=3D"qemu-helper">
> > > > +     <allow own=3D"org.qemu.Helper1"/>
> > > > +  </policy>
> > > > +
> > > > +
> > > > +dbus-daemon can also perfom SELinux checks based on the security
> > > > +context of the source and the target. For example, ``virtiofs_t``
> > > > +could be allowed to send a message to ``svirt_t``, but ``virtiofs_=
t``
> > > > +wouldn't be allowed to send a message to ``virtiofs_t``.
> > >
> > > I think we need to start thinking about this more now rather than
> > > 'can'. .
> >
> > Do you have a specific question we can answer or guide for qemu? Is
> > there something we have to document or implement?
> >
> > Since qemu is not managing the extra processes or applying policies, I
> > don't know what else could be done. From qemu pov, it can rely on
> > management layer to trust the bus and the helpers, similar to trusting
> > the system in general.
>
> Well pretty much the same questions I asked in the discussion on v2;
> what is the supported configuration to ensure that one helper that's
> been compromised can't attack the others and qemu?

I thought I gave the answer to that question above. What is missing? I
don't think one can generalize it here, it will be a case by case for
each helper, how they interact with each other and qemu.

>
> Dave
>
> > > Dave
> > >
> > > > +Guidelines
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +
> > > > +When implementing new D-Bus interfaces, it is recommended to follo=
w
> > > > +the "D-Bus API Design Guidelines":
> > > > +https://dbus.freedesktop.org/doc/dbus-api-design.html
> > > > +
> > > > +The "org.qemu*" prefix is reserved for the QEMU project.
> > > > diff --git a/docs/interop/index.rst b/docs/interop/index.rst
> > > > index b4bfcab417..fa4478ce2e 100644
> > > > --- a/docs/interop/index.rst
> > > > +++ b/docs/interop/index.rst
> > > > @@ -13,6 +13,7 @@ Contents:
> > > >     :maxdepth: 2
> > > >
> > > >     bitmaps
> > > > +   dbus
> > > >     live-block-operations
> > > >     pr-helper
> > > >     vhost-user
> > > > --
> > > > 2.23.0
> > > >
> > > --
> > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > >
> >
> >
> > --
> > Marc-Andr=C3=A9 Lureau
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK



--=20
Marc-Andr=C3=A9 Lureau

