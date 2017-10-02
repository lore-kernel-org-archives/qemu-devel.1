Received: from eggs.gnu.org ([2001:4830:134:3::10]:49376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dywpg-0000cK-C3
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:16:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dywpc-0002R5-6g
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:16:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58122)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dywpb-0002Qs-TV
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:16:08 -0400
Date: Mon, 2 Oct 2017 10:15:56 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171002091556.GB27086@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <69fd8746-b2bd-31d0-4d70-792f40ef2d79@amd.com>
	<20170926170901-mutt-send-email-mst@kernel.org>
	<2fb6e86d-5afa-d7f0-6f62-8f81db5a5419@amd.com>
	<20170927190724-mutt-send-email-mst@kernel.org>
	<927fedc3-a2c8-d37c-930e-11cecb7b0149@amd.com>
	<20170929223152-mutt-send-email-mst@kernel.org>
	<05b3c915-d7c1-2d73-1579-68d5f3bcc3d7@amd.com>
	<20170930000900-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170930000900-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] libvirt/QEMU/SEV interaction
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Richard Relph <richard.relph@amd.com>, libvir-list@redhat.com, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, Brijesh Singh <brijesh.singh@amd.com>, qemu-devel@nongnu.org
List-ID: <qemu-devel.nongnu.org>

On Sat, Sep 30, 2017 at 12:16:55AM +0300, Michael S. Tsirkin wrote:
> On Fri, Sep 29, 2017 at 02:48:45PM -0500, Richard Relph wrote:
> > On 9/29/17 2:34 PM, Michael S. Tsirkin wrote:
> > > On Wed, Sep 27, 2017 at 02:06:10PM -0500, Richard Relph wrote:
> > > > Whether the "BIOS" is a "static shim" as Michael suggests, or a full BIOS,
> > > > or even a BIOS+kernel+initrd is really not too significant. What is
> > > > significant is that the GO has a basis for trusting all code that is
> > > > imported in to their VM by the CP. And that NONE of the code provided by the
> > > > CP is "unknown" and unauditable by the GO. If the CP has a way to inject
> > > > code unknown to the GO in to the guest VM, the trust model is broken and
> > > > both GO and CP suffer the consequences.
> > > 
> > > Absolutely.
> > > 
> > > > When the CP needs to update the BIOS image, they will have to inform the GO
> > > > and allow the GO to establish trust in the CP's new BIOS image somehow.
> > > 
> > > This GO update on every BIOS change is imho is not a workable model. You
> > > want something like checking the BIOS signature instead. And since
> > > hardware is all hash based, you need the shim to do it in software.
> > 
> > A BIOS "signed" by the CP doesn't meet the security requirement. It is code
> > that is "unknown" to the GO.
> 
> There is a misunderstanding here.
> 
> BIOS would not be signed by a CP. It would be signed by a trusted
> software vendor e.g. by Red Hat.
> 
> > The (legitimate) CP does NOT want to be in that position of trust. If they
> > are, then some government somewhere is going to insist that they sign a BIOS
> > that allows the government to spy on the GO's VMs, and steal secrets from
> > it. Or some hacker admin will do it "for fun".
> > 
> > How often do large public CPs really change their BIOSes? My sense is that
> > large public CPs prefer stability over "latest and greatest".
> 
> CPs just do dnf update. Software vendors change BIOSes.

No they really don't do that.   Cloud providers will stick on a golden image
of RHEL. If and when they need to do an upgrade, they won't usually do a
'dnf update' because that imposes risk of breaking VMs on that node with no
fallback path. Instead they would usually deploy brand new nodes with the new
software version, and then live migrate VMs off the old hosts.

> And we do change them. Look at number of revisions for seabios in e.g.
> Fedora. More importantly we might need to change them quickly e.g.
> because of a security issue. Adding the need to coordinate with all GOs
> is not going to work. Neither can QEMU support booting old BIOS
> versions on new machine types indefinitely.

I don't think Fedora is a good fit for SEV - a long term supported distro
like RHEL is the more apt target, and there you are looking at 6 months
lifetime, except in rare cases of having a BIOS security flaw to pyush
out.

> 
> > And, perhaps more importantly, if a CP are able to sell a "more secure" VM,
> > one that justifies a higher price per vCPU hour, wouldn't that warrant some
> > changes in the "insecure" model being used today?
> > 
> > Richard
> 
> Absolutely. CPs have no business signing images. But it is just not
> really feasible for software vendors to distribute hashes.

Why can't software vendors distribute hashes - they are best placed to,
particularly when a single vendor is supplying the whole stack of base
OS, virt and OpenStack as a single coordinated product.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
