Received: from eggs.gnu.org ([2001:4830:134:3::10]:47239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1daMwA-0006VC-Ny
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 10:05:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1daMw7-0005vZ-Id
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 10:05:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35544)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1daMw7-0005uv-AQ
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 10:05:15 -0400
Date: Wed, 26 Jul 2017 15:04:59 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170726140459.GP7620@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170721092338.GE17693@redhat.com>
	<20170721143432.0e888800@nial.brq.redhat.com>
	<CAGCz3vvBDC0cYY_kmgoCn1D1j9RLAda646n_NTuVq6PQF1qNmw@mail.gmail.com>
	<9767baed-582d-8aab-f9a6-0d04d7ec9d23@redhat.com>
	<165445ef-c2fb-f49e-8185-2a8af0e27bf2@redhat.com>
	<20170726150810.3a48d5f0@nial.brq.redhat.com>
	<95a701f0-c693-e1f7-be52-36f05bfc856a@redhat.com>
	<20170726153020.4c20b279@nial.brq.redhat.com>
	<83edcc44-62ff-ff53-371d-efb4c0d10259@redhat.com>
	<20170726154343.122935dc@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170726154343.122935dc@nial.brq.redhat.com>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Phil Dennis-Jordan <lists@philjordan.eu>, Phil Dennis-Jordan <phil@philjordan.eu>, ehabkost@redhat.com, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Programmingkid <programmingkidx@gmail.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>

On Wed, Jul 26, 2017 at 03:43:43PM +0200, Igor Mammedov wrote:
> On Wed, 26 Jul 2017 15:33:37 +0200
> Paolo Bonzini <pbonzini@redhat.com> wrote:
> 
> > On 26/07/2017 15:30, Igor Mammedov wrote:
> > > On Wed, 26 Jul 2017 15:10:40 +0200
> > > Paolo Bonzini <pbonzini@redhat.com> wrote:
> > >   
> > >> On 26/07/2017 15:08, Igor Mammedov wrote:  
> > >>> On Tue, 25 Jul 2017 18:23:22 +0200
> > >>> Paolo Bonzini <pbonzini@redhat.com> wrote:
> > >>>     
> > >>>> On 25/07/2017 18:14, Laszlo Ersek wrote:    
> > >>>>>   "No regressions became apparent in tests with a range of Windows
> > >>>>>    (XP-10)"
> > >>>>>
> > >>>>> In theory, w2k falls within that range.      
> > >>>>
> > >>>> Nope, Windows 2000 is like NT 5.0, XP is like NT 5.1. :(
> > >>>>
> > >>>> One possibility is to fix it in SeaBIOS instead: if you get a 2.0 FADT
> > >>>> and an XSDT and no RSDT, it can build an RSDT and a 1.0 FADT itself,
> > >>>> patching the RSDT to point to it.
> > >>>>
> > >>>> It's a hack, but it's the only place I see to make it "just work".  And
> > >>>> it could be extended nicely in the future.
> > >>>>
> > >>>> All QEMU would have to do is to provide an XSDT _instead_ of an RSDT.    
> > >>> I'd support it, however it would break migrated guests with old BIOS
> > >>> image in RAM on reboot.    
> > >>
> > >> Why?  Shouldn't the old ACPI tables get migrated together with the old
> > >> BIOS?  Or are they rebuilt after reset?  
> > > they are rebuild on reset, but I've been wrong  
> > 
> > Hmm so we need this plus keeping old machine types fixed to rev1 and
> > RSDT.  Diffstat will get worse. :)
> Even though I'd prefer to tie revision switch to machine type+version,
> and kill rev1 support along with machine type when it's removed
> v1, https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg06822.html,

We're unlikely to be deleting machine types (and the features they
depend on) for as long as there's downstream vendors who need compat
with that vintage of features. So given RHEL lifetimes, a pc-2.8
machine type (and features it needs) will be around another 10-15
years. So making decisions based on an expectation of deleting
machine types any time soon is questionable.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
