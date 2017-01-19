Received: from eggs.gnu.org ([2001:4830:134:3::10]:54494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <phil@philjordan.eu>) id 1cUHA1-0004rD-TW
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 13:10:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <phil@philjordan.eu>) id 1cUHA0-0007NH-Vz
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 13:10:09 -0500
Received: from mail-ot0-x22a.google.com ([2607:f8b0:4003:c0f::22a]:36044)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <phil@philjordan.eu>) id 1cUHA0-0007Mb-Pk
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 13:10:08 -0500
Received: by mail-ot0-x22a.google.com with SMTP id 104so37991136otd.3
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 10:10:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170118175335-mutt-send-email-mst@kernel.org>
References: <1484739954-86833-1-git-send-email-phil@philjordan.eu>
	<20170118175335-mutt-send-email-mst@kernel.org>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Thu, 19 Jan 2017 19:09:47 +0100
Message-ID: <CAAibmn3GJWWun69KCHp+0qCBo=fjg1_xg+R_o+Qyro48a7Y_zQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH RFC] acpi: add reset register to fadt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On 18 January 2017 at 17:30, Michael S. Tsirkin <mst@redhat.com> wrote:
> I think what's important is the Fadt format revision. That one was 1 for 1.0b and 3 for 2.0.
>
> See page 112, Table 5-5 Fixed ACPI Description Table Format in acpi spec
> 1.0b.
>
> Now look at page 110 in spec 2.0, this time
> "Table 5-8 Fixed ACPI Description Table (FADT) Format".
>
> You will see that FADT revision is now 3, and there are a bunch of new
> fields after the reset register. I think you have to fill them in,
> you probably can get away with copying the non-extended values.


I've just spent a few hours fiddling around with this, and the results
aren't good. WinXP and 7 seem absolutely fine with a rev3 (or rev5)
FADT, presumably because they ignore it. macOS 10.12 hangs on boot
with a fully filled out r3/5 FADT. If I skip filling out the
Xdsdt/Xfacs addresses and just leave them at 0 it boots OK. Windows 10
hangs or bluescreens ("ACPI BIOS ERROR") in either case. (I tested
UEFI boot with OVMF, did not try legacy BIOS.)

Just in case I'd messed up the code, I also tried this FADT patch
https://lists.gnu.org/archive/html/qemu-devel/2016-08/msg02216.html
from some months ago which evidently never got accepted. It yielded
the same result as my independently developed implementation.

I don't really know enough about ACPI to have an intuition for what to
try next. Unfortunately, macOS's ACPI table parser does not appear to
be in any of the open source bits of the xnu kernel, otherwise I'd be
looking there for hints.

For reference, my approach to filling out the Xdsdt/Xfacs fields in
build_fadt() is essentially the same as for the 32-bit variants from
rev1:

unsigned xfacs_offset = (char *)&fadt->Xfacs - table_data->data;
bios_linker_loader_add_pointer(linker,
        ACPI_BUILD_TABLE_FILE, xfacs_offset, sizeof(fadt->Xfacs),
        ACPI_BUILD_TABLE_FILE, facs_tbl_offset);

Suggestions welcome.

Thanks,
Phil
