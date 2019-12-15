Return-Path: <SRS0=VgCP=2F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FC7C43603
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2019 09:59:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD71421D7E
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2019 09:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YkS0Gx6a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD71421D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igQgJ-00074p-3n
	for qemu-devel@archiver.kernel.org; Sun, 15 Dec 2019 04:59:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50694)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1igQfg-0006cE-FU
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 04:58:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1igQff-0001yc-3T
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 04:58:40 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55780
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1igQfe-0001w6-Ti
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 04:58:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576403918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ojwrHY0zHg+5NLkr12eP+nk8VjcM3a/wtoqud6h53+8=;
 b=YkS0Gx6afGZrCP9Qobodd5GAzQpNjg7xqeK33cPJkIxsrrhy+CQElM4/HumfpuL3nk+Si2
 N1XE2sdYh0JTQpRnmVe88I9p5Pw5KPeK0br6ydB0D1XOYqHwX33g8bsQ5DGh2E+24kWCNf
 yH0e+TitHYW2JEyIK20o+qxNelOfIVg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-Cjy0qfHDMHCIFWU0-UCN_A-1; Sun, 15 Dec 2019 04:58:34 -0500
Received: by mail-qt1-f198.google.com with SMTP id b24so2653559qtp.1
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2019 01:58:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=uglnVCAjnaUsXT9ZTT7mKFQQrU34w0ggWLPMx7AnQTk=;
 b=QcC0rk/Z2pCbhgiM6yXqNOmSGjqsjiqaJTvoy108lQc7TMRgGZaxWpW1rJBjo1/NrT
 q8e+YtcMGLzVp4zOBhTEoKl2AsEn1S27PSO/V7C+s97aUL4XnUDybTXGy9mbjXgw9bk9
 hnxs4VCIgebUMlUaRIm0yML/DJCi+SL2PA8XkFOI2v2IHw4rK0+fny194GKlWpctuQZ9
 +pghJm0p5EaSpLyM0heLYCoA4ciOOOYtOtIuwPoDPDmCWEyuYqgKDS/forSYJ15KkFWx
 6cTB43RmDLXnwjTZkoToc+Br8zgthpFzG2lumS+7z1Bsd8q+2WmONcbm5WNbcbl0/cCK
 m9uQ==
X-Gm-Message-State: APjAAAWSfzwnqJLrcMvVvuSYFdIy6tb9nO5wdMm2ggsSdQ1npHgA5z3P
 v7uD/qZnweWdICWobGjDU0FxvaxIW+Ib6B1J/+en4hdZn/sU3lsNRp/QSJedj5G/8+iTe3BHysG
 hBB35J1RRAnzQXis=
X-Received: by 2002:ac8:2bb9:: with SMTP id m54mr20346506qtm.150.1576403914504; 
 Sun, 15 Dec 2019 01:58:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqxShGzMmQTP0GPg+U7XkjAABhRbEWqYV30OwRBbm04m47kjZ2QozlKgsELOkgUl7CsWCeS0Iw==
X-Received: by 2002:ac8:2bb9:: with SMTP id m54mr20346493qtm.150.1576403914297; 
 Sun, 15 Dec 2019 01:58:34 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
 by smtp.gmail.com with ESMTPSA id 184sm4752304qke.73.2019.12.15.01.58.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2019 01:58:33 -0800 (PST)
Date: Sun, 15 Dec 2019 04:58:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 12/12] hw/i386/pc: Move PC-machine specific declarations
 to 'pc_internal.h'
Message-ID: <20191215045812-mutt-send-email-mst@kernel.org>
References: <20191213161753.8051-1-philmd@redhat.com>
 <20191213161753.8051-13-philmd@redhat.com>
 <d9792ff4-bada-fbb9-301d-aeb19826235c@redhat.com>
MIME-Version: 1.0
In-Reply-To: <d9792ff4-bada-fbb9-301d-aeb19826235c@redhat.com>
X-MC-Unique: Cjy0qfHDMHCIFWU0-UCN_A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
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
Cc: Stefano Stabellini <sstabellini@kernel.org>, Sergio Lopez <slp@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Paul Durrant <paul@xen.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org,
 Anthony Perard <anthony.perard@citrix.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Dec 13, 2019 at 05:47:28PM +0100, Philippe Mathieu-Daud=E9 wrote:
> On 12/13/19 5:17 PM, Philippe Mathieu-Daud=E9 wrote:
> > Historically, QEMU started with only one X86 machine: the PC.
> > The 'hw/i386/pc.h' header was used to store all X86 and PC
> > declarations. Since we have now multiple machines based on the
> > X86 architecture, move the PC-specific declarations in a new
> > header.
> > We use 'internal' in the name to explicit this header is restricted
> > to the X86 architecture. Other architecture can not access it.
> >=20
> > Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> > ---
> > Maybe name it 'pc_machine.h'?
>=20
> I forgot to describe here (and in the cover), what's follow after this
> patch.
>=20
> Patch #13 moves PCMachineClass to
>=20
> If you ignore PCMachineState, "hw/i386/pc.h" now only contains 76 lines, =
and
> it is easier to see what is PC machine specific, what is X86 specific, an=
d
> what is device generic (not X86 related at all):
>=20
> - GSI is common to X86 (Paolo sent [3], [6])
> - IOAPIC is common to X86
> - i8259 is multiarch (Paolo [2])
> - PCI_HOST definitions and pc_pci_hole64_start() are X86
> - pc_machine_is_smm_enabled() is X86 (Paolo sent [5])
> - hpet
> - tsc (Paolo sent [3])
> - 3 more functions
>=20
> So we can move half of this file to "pc_internal.h" and the other to
>=20
> One problem is the Q35 MCH north bridge which directly sets the PCI
> PCMachineState->bus in q35_host_realize(). This seems a QOM violation and=
 is
> probably easily fixable.
>=20
> Maybe I can apply Paolo's patches instead of this #12, move X86-generic
> declarations to "hw/i386/x86.h", and directly git-move what's left of
> "hw/i386/pc.h" to "pc_internal.h".

Yea that sounds a bit better.

> [3] https://www.mail-archive.com/qemu-devel@nongnu.org/msg664627.html
> [2] https://www.mail-archive.com/qemu-devel@nongnu.org/msg664765.html
> [5] https://www.mail-archive.com/qemu-devel@nongnu.org/msg664754.html
> [6] https://www.mail-archive.com/qemu-devel@nongnu.org/msg664766.html
>=20
> > ---
> >   hw/i386/pc_internal.h | 144 +++++++++++++++++++++++++++++++++++++++++=
+
> >   include/hw/i386/pc.h  | 128 -------------------------------------
> >   hw/i386/acpi-build.c  |   1 +
> >   hw/i386/pc.c          |   1 +
> >   hw/i386/pc_piix.c     |   1 +
> >   hw/i386/pc_q35.c      |   1 +
> >   hw/i386/pc_sysfw.c    |   1 +
> >   hw/i386/xen/xen-hvm.c |   1 +
> >   8 files changed, 150 insertions(+), 128 deletions(-)
> >   create mode 100644 hw/i386/pc_internal.h


