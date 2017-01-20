Received: from eggs.gnu.org ([2001:4830:134:3::10]:47184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cUgLi-0001HL-9w
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 16:03:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cUgLf-000523-5z
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 16:03:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cUgLe-00051v-UC
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 16:03:51 -0500
Date: Fri, 20 Jan 2017 19:03:48 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170120210348.GB21555@thinpad.lan.raisama.net>
References: <20170113115651.17607-1-haozhong.zhang@intel.com>
	<20170113131727.GA10706@stefanha-x1.localdomain>
	<20170113180243.GA3565@thinpad.lan.raisama.net>
	<4ee4b67a-f00b-b2fd-f87b-4f0a74734412@linux.intel.com>
	<20170116110017.GC12351@stefanha-x1.localdomain>
	<20170120005558.iqroldufo64uow7i@hz-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170120005558.iqroldufo64uow7i@hz-desktop>
Subject: Re: [Qemu-devel] [PATCH] hw/i386: check if nvdimm is enabled before
 plugging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, Xiao Guangrong <guangrong.xiao@linux.intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, imammedo@redhat.com, Richard Henderson <rth@twiddle.net>

On Fri, Jan 20, 2017 at 08:55:58AM +0800, Haozhong Zhang wrote:
> On 01/16/17 11:00 +0000, Stefan Hajnoczi wrote:
> > On Mon, Jan 16, 2017 at 01:55:34PM +0800, Xiao Guangrong wrote:
> > > On 01/14/2017 02:02 AM, Eduardo Habkost wrote:
> > > > On Fri, Jan 13, 2017 at 01:17:27PM +0000, Stefan Hajnoczi wrote:
> > > > > On Fri, Jan 13, 2017 at 07:56:51PM +0800, Haozhong Zhang wrote:
> > > > > > The missing of 'nvdimm' in the machine type option '-M' means NVDIMM
> > > > > > is disabled. QEMU should refuse to plug any NVDIMM device in this case
> > > > > > and report the misconfiguration.
> > > > > >
> > > > > > Reported-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > > > > Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> > > > > > Message-Id: 20170112110928.GF4621@stefanha-x1.localdomain
> > > > > > Message-Id: 20170111093630.2088-1-stefanha@redhat.com
> > > > > > ---
> > > > > >  hw/i386/pc.c | 5 +++++
> > > > > >  1 file changed, 5 insertions(+)
> > > > > >
> > > > > > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > > > > > index 25e8586..3907609 100644
> > > > > > --- a/hw/i386/pc.c
> > > > > > +++ b/hw/i386/pc.c
> > > > > > @@ -1715,6 +1715,11 @@ static void pc_dimm_plug(HotplugHandler *hotplug_dev,
> > > > > >      }
> > > > > >
> > > > > >      if (object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM)) {
> > > > > > +        if (!pcms->acpi_nvdimm_state.is_enabled) {
> > > > > > +            error_setg(&local_err,
> > > > > > +                       "nvdimm is not enabled: missing 'nvdimm' in '-M'");
> > > > > > +            goto out;
> > > > > > +        }
> > > > >
> > > > > A warning is definitely useful to notify users of a possible
> > > > > configuration error.
> > > > >
> > > > > I wonder what happens when you plug an NVDIMM into a motherboard where
> > > > > the firmware lacks support.  Does it:
> > > > >  * Refuse to boot?
> > > > >  * Treat the DIMM as regular RAM?
> > > > >  * Boot but the DIMM will not be used by firmware and kernel?
> > > > >
> > > > > QEMU should act the same way as real hardware.
> > > >
> > > > If real hardware behavior is not useful in any way (e.g. first
> > > > and third options above), is there a good reason for QEMU to not
> > > > implement an additional safety mechanism preventing NVDIMM from
> > > > being connected to a machine that doesn't support it?
> > > >
> > > 
> > > Yes. i agree with Eduardo.
> > > 
> > > For the real hardware the behavior may be different between vendors, we
> > > are asking our HW people to check what will happen on Intel's hardware
> > > under this case.
> > 
> > Let's find out what real hardware/firmware does.  I guess it's the Intel
> > MRC component that handles memory initialization.
> > 
> 
> The behavior of NVDIMM on unsupported platform (HW/FW) is vendor
> specific. For some vendors, it's undefined and the platform may do
> anything (e.g. the three points Stefan listed above). Thus, I think
> QEMU is free to choose the implementation. Aborting QEMU
> (i.e. refusing to boot) is the easiest one.

I agree.

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
