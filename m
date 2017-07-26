Received: from eggs.gnu.org ([2001:4830:134:3::10]:60269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1daSoG-0001BN-0O
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 16:21:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1daSoD-0002WK-BC
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 16:21:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1daSoD-0002TB-2E
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 16:21:29 -0400
Date: Wed, 26 Jul 2017 16:21:23 -0400 (EDT)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1419439438.19249924.1501100483485.JavaMail.zimbra@redhat.com>
In-Reply-To: <20170726191252.GA8769@morn.lan>
References: <CAGCz3vu5x59+mKg8011=DRyZQKbuBV2F20ZpPnG1TOCxsOb+mQ@mail.gmail.com>
	<CAGCz3vvBDC0cYY_kmgoCn1D1j9RLAda646n_NTuVq6PQF1qNmw@mail.gmail.com>
	<9767baed-582d-8aab-f9a6-0d04d7ec9d23@redhat.com>
	<165445ef-c2fb-f49e-8185-2a8af0e27bf2@redhat.com>
	<a92581c5-87b8-26d0-15d3-33ea6e87d442@redhat.com>
	<20170725220150.GA2891@morn.lan>
	<8ce79be9-5512-148d-f2d4-3bb8c04d6eda@redhat.com>
	<20170726191252.GA8769@morn.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
To: Kevin O'Connor <kevin@koconnor.net>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, seabios@seabios.org, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Programmingkid <programmingkidx@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Phil Dennis-Jordan <lists@philjordan.eu>, Igor Mammedov <imammedo@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Richard Henderson <rth@twiddle.net>

> > (4) would be acceptable I guess.  However I think it's a bit worse
> > because fw-cfg files are a somewhat scarce resource.  The "legacy"
> > aspect is something that SeaBIOS is in the best position to address,
> > because it knows what OSes are running on it; QEMU instead only takes
> > care of describing the hardware.
> 
> SeaBIOS is used with both modern and legacy OSes, and it doesn't have
> any knowledge about what kind of OS will be used.  If anything, I'd
> argue that QEMU has more knowledge about the guest OS than SeaBIOS
> does (due to command-line options like machine version).

No, the machine type is independent from the guest OS.  The aim is to
let "qemu-system-x86_64 -m MEMORYSZ image.qcow2" work just fine with
every guest OS.

> As I see it, fundamentally the proposal here is to deploy different
> ACPI tables when using SeaBIOS then when using OVMF.  I think that's
> fine, but I think we should directly address that issue then.

The different ACPI tables are essentially a bug in OVMF.  They can be
fixed to be the same.

> Specifically, I have the following concerns with the original approach:
> 
> A - It would require deploying SeaBIOS and QEMU in lock-step.  To get
>     this in for QEMU v2.10 would require making QEMU changes during
>     the soft freeze and would require a SeaBIOS "stable" release that
>     introduces ACPI table manipulation.

Yes.

> B - I don't have full confidence the proposed ACPI changes wont expose
>     a quirk in some obscure OS from the last 25 years.  If it does
>     expose a quirk, any work-around would likely require deploying a
>     new SeaBIOS and QEMU in lock-step.

Well, the solution is proposed by ACPI itself, and the worst that can
happen is that some OS prefers the RSDT to the XSDT (which we already
test on Windows 2000).

> C - We'd be introducing "shared ownership" of the acpi tables.  Some
>     of the tables would be produced by QEMU and some of them by
>     SeaBIOS.  Explaining when and why to future developers would be a
>     challenge.

The advantage is that the same shared ownership is already present in
OVMF.  The RSDP/RSDT/XSDT are entirely created by the firmware in OVMF.
(The rev1 FADT isn't but that's just missing code; the table manager
in general would be ready for that).  In any case this doesn't seem
like something that cannot be solved by code comments.

Paolo
