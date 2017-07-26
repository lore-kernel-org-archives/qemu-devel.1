Received: from eggs.gnu.org ([2001:4830:134:3::10]:44094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1daMot-0001xH-38
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 09:57:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1daMoq-0001Up-29
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 09:57:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42165)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1daMop-0001Ub-Pc
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 09:57:44 -0400
Date: Wed, 26 Jul 2017 16:57:26 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170726165545-mutt-send-email-mst@kernel.org>
References: <CAGCz3vu5x59+mKg8011=DRyZQKbuBV2F20ZpPnG1TOCxsOb+mQ@mail.gmail.com>
	<20170721110636.19412e6c@nial.brq.redhat.com>
	<20170721092338.GE17693@redhat.com>
	<20170721143432.0e888800@nial.brq.redhat.com>
	<CAGCz3vvBDC0cYY_kmgoCn1D1j9RLAda646n_NTuVq6PQF1qNmw@mail.gmail.com>
	<9767baed-582d-8aab-f9a6-0d04d7ec9d23@redhat.com>
	<165445ef-c2fb-f49e-8185-2a8af0e27bf2@redhat.com>
	<20170726150810.3a48d5f0@nial.brq.redhat.com>
	<95a701f0-c693-e1f7-be52-36f05bfc856a@redhat.com>
	<20170726153020.4c20b279@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170726153020.4c20b279@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] Commit 77af8a2b95b79699de650965d5228772743efe84
 breaks Windows 2000 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Phil Dennis-Jordan <lists@philjordan.eu>, "Daniel P. Berrange" <berrange@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>, ehabkost@redhat.com, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Programmingkid <programmingkidx@gmail.com>, Richard Henderson <rth@twiddle.net>

On Wed, Jul 26, 2017 at 03:30:20PM +0200, Igor Mammedov wrote:
> On Wed, 26 Jul 2017 15:10:40 +0200
> Paolo Bonzini <pbonzini@redhat.com> wrote:
> 
> > On 26/07/2017 15:08, Igor Mammedov wrote:
> > > On Tue, 25 Jul 2017 18:23:22 +0200
> > > Paolo Bonzini <pbonzini@redhat.com> wrote:
> > >   
> > >> On 25/07/2017 18:14, Laszlo Ersek wrote:  
> > >>>   "No regressions became apparent in tests with a range of Windows
> > >>>    (XP-10)"
> > >>>
> > >>> In theory, w2k falls within that range.    
> > >>
> > >> Nope, Windows 2000 is like NT 5.0, XP is like NT 5.1. :(
> > >>
> > >> One possibility is to fix it in SeaBIOS instead: if you get a 2.0 FADT
> > >> and an XSDT and no RSDT, it can build an RSDT and a 1.0 FADT itself,
> > >> patching the RSDT to point to it.
> > >>
> > >> It's a hack, but it's the only place I see to make it "just work".  And
> > >> it could be extended nicely in the future.
> > >>
> > >> All QEMU would have to do is to provide an XSDT _instead_ of an RSDT.  
> > > I'd support it, however it would break migrated guests with old BIOS
> > > image in RAM on reboot.  
> > 
> > Why?  Shouldn't the old ACPI tables get migrated together with the old
> > BIOS?  Or are they rebuilt after reset?
> they are rebuild on reset, but I've been wrong
> Looking at SeaBIOS something similar to your suggestion also should work,
>  if 
>     RsdpAddr = find_acpi_rsdp();
>  fails, current SeaBIOS falls back to its own ACPI tables.
> 
> but it seems that we don't even need to go to that extent,
> all user have to do is to use "-no-acpi" CLI option with QEMU
> for any SeaBIOS to fallback to embedded legacy ACPI tables.
> 
> Maybe we should just fix wiki
>   http://wiki.qemu.org/Windows2000
> to recommend using '-no-acpi' option when running w2k and
> leave PC machine at rev3 and mention it in release notes.
> 
> Opinions?

I really don't want to go back and have to support the builtin ACPI
tables. Not worth the small hassle of maintaining RSDP in QEMU.

At some point we will want to split up ACPI code, leave PC
alone and add stuff for Q35 only. Maybe not yet though.


> > Paolo
> > 
> > > Legacy users have an option to build SeaBIOS without ACPI from QEMU
> > > support by turning off CONFIG_FW_ROMFILE_LOAD (or use old SeaBIOS)
> > > which leads to using legacy tables included in SeaBIOS.
> > > Then mgmt layer above libvirt which knows what guest OS it's
> > > going to run can pick legacy BIOS image for it.
> > > 
> > > But the testing issue will still stay as normally it's not tested
> > > path.
> > > 
> > > PS:
> > > For now we are going to revert PC machine to rev1 and leave q35 at rev3
> > > as Michael suggested to keep both w2k and macos happy.
> > >   
> > >>
> > >> Paolo
> > >>  
> > >>> In practice, it is impossible to
> > >>> test *all* Windows versions against ACPI generator changes, even if you
> > >>> try to be thorough (which Phil was). One might not even *know about*
> > >>> "all" Windows versions. So people using w2k and similar should
> > >>> co-maintain the ACPI stuff and report back with testing on the fly;
> > >>> otherwise regressions are impossible to avoid.    
> > >>  
> > >   
> > 
