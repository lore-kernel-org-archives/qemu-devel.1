Received: from eggs.gnu.org ([2001:4830:134:3::10]:38836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gQEuX-00039O-I2
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 12:06:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gQEuT-00005Q-Kt
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 12:06:33 -0500
Date: Fri, 23 Nov 2018 18:06:24 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20181123170624.GN1148@toto>
References: <20181123135450.24829-1-edgar.iglesias@gmail.com>
	<20181123135450.24829-2-edgar.iglesias@gmail.com>
	<75bcddbc-da2d-aeb3-71d3-52b635520d2a@redhat.com>
	<20181123165945.GM1148@toto> <20181123170225.GJ7447@toto>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181123170225.GJ7447@toto>
Subject: Re: [Qemu-devel] [PATCH v1 1/1] net: cadence_gem: Remove incorrect
 assert()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, muhammad_bilal@mentor.com, frederic.konrad@adacore.com, alistair@alistair23.me, frasse.iglesias@gmail.com, figlesia@xilinx.com, sstabellini@kernel.org, sai.pavan.boddu@xilinx.com

On Fri, Nov 23, 2018 at 06:02:25PM +0100, Edgar E. Iglesias wrote:
> On Fri, Nov 23, 2018 at 05:59:45PM +0100, Edgar E. Iglesias wrote:
> > On Fri, Nov 23, 2018 at 05:46:17PM +0100, Philippe Mathieu-Daudé wrote:
> > > Hi Edgar,
> > 
> > Hi Philippe,
> > 
> > > 
> > > On 23/11/18 14:54, Edgar E. Iglesias wrote:
> > > > From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> > > > 
> > > > Don't assert on RX descriptor settings when the receiver is
> > > > disabled. This fixes an issue with incoming packets on an
> > > > unused GEM.
> > > > 
> > > > Reported-by: mbilal <muhammad_bilal@mentor.com>
> > > > Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> > > > ---
> > > >  hw/net/cadence_gem.c | 1 -
> > > >  1 file changed, 1 deletion(-)
> > > > 
> > > > diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> > > > index d95cc27f58..7f63411430 100644
> > > > --- a/hw/net/cadence_gem.c
> > > > +++ b/hw/net/cadence_gem.c
> > > > @@ -979,7 +979,6 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
> > > >  
> > > >          /* Do nothing if receive is not enabled. */
> > > >          if (!gem_can_receive(nc)) {
> > > > -            assert(!first_desc);
> > > 
> > > Maybe worth:
> > > 
> > >                trace_gem_receive_packet_drop(size);
> > 
> > Or perhaps a generic tracepoint on packet drops for any device.
> > Anyway this is probably something for after the release.
> > 
> > Not sure if it's too late to even get the removal of the assert into this release? Peter?
> > 
> > > 
> > > >              return -1;
> > > 
> > > Shouldn't this be 'return 0'?
> > > 
> > > The "net/net.h" doc is scarce...
> > 
> > If we return 0 my understanding is that we later need to actively
> > call qemu_flush_or_purge_queued_packets() to renable the rx
> > path which the GEM model doesn't do. So that would mean
> > refactoring the model a bit.
> 
> Actually, the GEM model does do that, my bad, so yes return 0 seems to be the right thing to do here.

I take that back, the GEM model only handles some of the !can_receive cases
with qemu_flush_queued_packets(). Not all, so return -1 is correct I think.

Cheers,
Edgar
