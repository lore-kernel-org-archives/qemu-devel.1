Received: from eggs.gnu.org ([2001:4830:134:3::10]:37672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dFdK7-0003bf-3e
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:20:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dFdK5-0002dD-Tl
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:20:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37776)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dFdK5-0002cj-Ls
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:20:17 -0400
Date: Tue, 30 May 2017 10:20:15 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170530092015.GD21566@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170526023213.18741-1-haozhong.zhang@intel.com>
	<CAPcyv4gp1CBFA+MMXSjxw1b3nSeHCYkMN1daMP2+r4DpfPmMug@mail.gmail.com>
	<20170526143843.GL24484@redhat.com>
	<CAPcyv4g-=VytzHCw8QzSq5yNW-PLPz0MNzT=vDqxTmEuF_DWHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPcyv4g-=VytzHCw8QzSq5yNW-PLPz0MNzT=vDqxTmEuF_DWHQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [RESEND PATCH 1/2] nvdimm: warn if the backend is
 not a DAX device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Haozhong Zhang <haozhong.zhang@intel.com>, Stefan Hajnoczi <stefanha@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <guangrong.xiao@gmail.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

On Fri, May 26, 2017 at 08:25:20AM -0700, Dan Williams wrote:
> On Fri, May 26, 2017 at 7:38 AM, Daniel P. Berrange <berrange@redhat.com> wrote:
> > On Thu, May 25, 2017 at 08:34:23PM -0700, Dan Williams wrote:
> >> On Thu, May 25, 2017 at 7:32 PM, Haozhong Zhang
> >> <haozhong.zhang@intel.com> wrote:
> >> > Applications in Linux guest that use device-dax never trigger flush
> >> > that can be trapped by KVM/QEMU. Meanwhile, if the host backend is not
> >> > device-dax, QEMU cannot guarantee the persistence of guest writes.
> >> > Before solving this flushing problem, QEMU should warn users if the
> >> > host backend is not device-dax.
> >>
> >> I think this needs to be stronger than a "warn" it needs to be
> >> explicitly forbidden when it is known to be unsafe.
> >
> > I think users should have the choice in what they want to do -
> > QEMU should not artifically block it.  There are plenty of things
> > in QEMU that are potentially unsafe in some usage scenarios, but
> > we just document how to use them in a safe manner & any caveats
> > that apply. Higher level applications above QEMU can then consider
> > how they want to apply a usage policy to meet the needs of their
> > usage scenario.
> >
> > Having an emulated DAX device that doesn't guarantee persistence
> > is no different to having an emulated disk device that never flushes
> > to underlying host storage.
> >
> 
> It is different in the sense that the contract of when the guest
> should assume persistence is specified by when the write completes to
> the virtual disk. In the case of the virtual NFIT we are currently
> lying to the guest about that platform persistence guarantee even if
> the hypervisor is emulating pmem with volatile memory.

We equally lie to the guest about persistence of disks, when the
disk is run with certain cache= settings, or when the disk backing file
is on tmpfs. It is simply a choice the mgmt application makes about
whether to provide backing storage that is capable of satsifying the
guarantees implied by the guest device model. So I'm still not seeing
a compelling reason to artifically block this with DAX.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
