Received: from eggs.gnu.org ([2001:4830:134:3::10]:56655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1da7tu-0005Hf-UE
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 18:01:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1da7tq-0006fP-2E
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 18:01:58 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:34129)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kevin@koconnor.net>) id 1da7tp-0006f0-To
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 18:01:53 -0400
Received: by mail-qt0-x242.google.com with SMTP id i19so5527693qte.1
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 15:01:52 -0700 (PDT)
Date: Tue, 25 Jul 2017 18:01:50 -0400
From: Kevin O'Connor <kevin@koconnor.net>
Message-ID: <20170725220150.GA2891@morn.lan>
References: <3E24AFDE-D25A-416B-A600-3C2221C3A9F1@gmail.com>
	<CAGCz3vu5x59+mKg8011=DRyZQKbuBV2F20ZpPnG1TOCxsOb+mQ@mail.gmail.com>
	<20170721110636.19412e6c@nial.brq.redhat.com>
	<20170721092338.GE17693@redhat.com>
	<20170721143432.0e888800@nial.brq.redhat.com>
	<CAGCz3vvBDC0cYY_kmgoCn1D1j9RLAda646n_NTuVq6PQF1qNmw@mail.gmail.com>
	<9767baed-582d-8aab-f9a6-0d04d7ec9d23@redhat.com>
	<165445ef-c2fb-f49e-8185-2a8af0e27bf2@redhat.com>
	<a92581c5-87b8-26d0-15d3-33ea6e87d442@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a92581c5-87b8-26d0-15d3-33ea6e87d442@redhat.com>
Subject: Re: [Qemu-devel] [SeaBIOS] Commit
 77af8a2b95b79699de650965d5228772743efe84 breaks Windows 2000 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Phil Dennis-Jordan <lists@philjordan.eu>, Igor Mammedov <imammedo@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>, "seabios@seabios.org" <seabios@seabios.org>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Programmingkid <programmingkidx@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Richard Henderson <rth@twiddle.net>

On Tue, Jul 25, 2017 at 07:10:21PM +0200, Paolo Bonzini wrote:
> On 25/07/2017 18:23, Paolo Bonzini wrote:
> > On 25/07/2017 18:14, Laszlo Ersek wrote:
> >>   "No regressions became apparent in tests with a range of Windows
> >>    (XP-10)"
> >>
> >> In theory, w2k falls within that range.
> > 
> > Nope, Windows 2000 is like NT 5.0, XP is like NT 5.1. :(
> > 
> > One possibility is to fix it in SeaBIOS instead: if you get a 2.0 FADT
> > and an XSDT and no RSDT, it can build an RSDT and a 1.0 FADT itself,
> > patching the RSDT to point to it.
> > 
> > It's a hack, but it's the only place I see to make it "just work".  And
> > it could be extended nicely in the future.

It's an impressive hack!

> > 
> > All QEMU would have to do is to provide an XSDT _instead_ of an RSDT.
[...]
> SeaBIOS:
> 
> From 73b0facdb7349f5dbf24dc675647b68eeeec0ff4 Mon Sep 17 00:00:00 2001
> From: Paolo Bonzini <pbonzini@redhat.com>
> Date: Tue, 25 Jul 2017 18:50:19 +0200
> Subject: [PATCH 1/2] seabios: build RSDT from XSDT
> 
> Old operating systems would like to have a v1 FADT, but new
> operating systems would like to have v3.
> 
> Since old operating systems do not know about XSDTs, the
> solution is to point the RSDT to a v1 FADT and the XSDT to a
> v3 FADT.
> 
> But, OVMF is not able to do that and barfs when it sees the
> second FADT---plus really it's only BIOS operating systems
> such as win2k that complain.  So instead: 1) make QEMU provide
> an XSDT only; 2) build the RSDT and v1 FADT in SeaBIOS.
> 
> This patch makes SeaBIOS build an RSDT out of an existing XSDT.

I'd really prefer not to have SeaBIOS go back to producing ACPI
tables.

As an alternative, how about some other possible hacks:

1 - ovmf filters out the extra tables that it barfs on.

2 - change ovmf to read the fw_cfg linker script
    'etc/table-loader-ovmf' instead of '/etc/table-loader' and change
    qemu to generate two linker scripts - one for seabios and one for
    ovmf.

3 - same as 2, but change seabios to use 'etc/table-loader-seabios'
    and leave ovmf unchanged.

4 - change seabios to read both the linker script 'etc/table-loader'
    _and_ some new linker script '/etc/table-loader-legacy'.  Have
    qemu introduce the RSDT/FADTv1 in the "legacy" linker script.

-Kevin
