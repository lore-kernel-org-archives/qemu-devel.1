Received: from eggs.gnu.org ([2001:4830:134:3::10]:59843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1dakGH-0008HC-5T
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:59:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1dakGE-0001Zg-3B
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:59:37 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:32854)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kevin@koconnor.net>) id 1dakGD-0001VN-SK
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:59:34 -0400
Received: by mail-qk0-x242.google.com with SMTP id d145so16005474qkc.0
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 07:59:32 -0700 (PDT)
Date: Thu, 27 Jul 2017 10:59:29 -0400
From: Kevin O'Connor <kevin@koconnor.net>
Message-ID: <20170727145929.GA14721@morn.lan>
References: <CAGCz3vu5x59+mKg8011=DRyZQKbuBV2F20ZpPnG1TOCxsOb+mQ@mail.gmail.com>
	<CAGCz3vvBDC0cYY_kmgoCn1D1j9RLAda646n_NTuVq6PQF1qNmw@mail.gmail.com>
	<9767baed-582d-8aab-f9a6-0d04d7ec9d23@redhat.com>
	<165445ef-c2fb-f49e-8185-2a8af0e27bf2@redhat.com>
	<a92581c5-87b8-26d0-15d3-33ea6e87d442@redhat.com>
	<20170725220150.GA2891@morn.lan>
	<8ce79be9-5512-148d-f2d4-3bb8c04d6eda@redhat.com>
	<20170726191252.GA8769@morn.lan>
	<1419439438.19249924.1501100483485.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1419439438.19249924.1501100483485.JavaMail.zimbra@redhat.com>
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
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, seabios@seabios.org, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Programmingkid <programmingkidx@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Phil Dennis-Jordan <lists@philjordan.eu>, Igor Mammedov <imammedo@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Richard Henderson <rth@twiddle.net>

On Wed, Jul 26, 2017 at 04:21:23PM -0400, Paolo Bonzini wrote:
> > As I see it, fundamentally the proposal here is to deploy different
> > ACPI tables when using SeaBIOS then when using OVMF.  I think that's
> > fine, but I think we should directly address that issue then.
> 
> The different ACPI tables are essentially a bug in OVMF.  They can be
> fixed to be the same.
> 
> > Specifically, I have the following concerns with the original approach:
> > 
> > A - It would require deploying SeaBIOS and QEMU in lock-step.  To get
> >     this in for QEMU v2.10 would require making QEMU changes during
> >     the soft freeze and would require a SeaBIOS "stable" release that
> >     introduces ACPI table manipulation.
> 
> Yes.
> 
> > B - I don't have full confidence the proposed ACPI changes wont expose
> >     a quirk in some obscure OS from the last 25 years.  If it does
> >     expose a quirk, any work-around would likely require deploying a
> >     new SeaBIOS and QEMU in lock-step.
> 
> Well, the solution is proposed by ACPI itself, and the worst that can
> happen is that some OS prefers the RSDT to the XSDT (which we already
> test on Windows 2000).

Parsing the XSDT is a different code path in the OSes - it could
expose a quirk.  I'm fine with the new layout of the ACPI tables, but
I think we need to be prepared that the change could have a ripple
effect.

> > C - We'd be introducing "shared ownership" of the acpi tables.  Some
> >     of the tables would be produced by QEMU and some of them by
> >     SeaBIOS.  Explaining when and why to future developers would be a
> >     challenge.
> 
> The advantage is that the same shared ownership is already present in
> OVMF.  The RSDP/RSDT/XSDT are entirely created by the firmware in OVMF.
> (The rev1 FADT isn't but that's just missing code; the table manager
> in general would be ready for that).  In any case this doesn't seem
> like something that cannot be solved by code comments.

I'd argue that the shared ownership in the EDK2 code was a poor design
choice.  Case in point - we're only having this conversation because
of its limitations - SeaBIOS is capable of deploying the acpi tables
in the proposed layout without any code changes today.  I'm not
against changing SeaBIOS, but it's a priority for me that we continue
to make it possible to deploy future ACPI table changes (no matter how
quirky) in a way that does not require future SeaBIOS releases.

-Kevin
