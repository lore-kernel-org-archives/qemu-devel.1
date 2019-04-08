Received: from eggs.gnu.org ([209.51.188.92]:36542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1hDcqz-0004Ru-0a
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 18:35:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1hDcqx-0005FP-Ql
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 18:35:00 -0400
Sender: fluxion <flukshun@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20190408183156.1f71c21d@bahia.lan>
References: <20190327204102.20925-1-maxiwell@linux.ibm.com>
	<20190328142151.7b0e00dd@bahia.lab.toulouse-stg.fr.ibm.com>
	<20190328183923.lcd3p6fpy4qvvxoo@maxibm>
	<20190329132951.451d4ef0@bahia.lan>
	<20190408042149.GH16627@umbus.fritz.box>
	<20190408183156.1f71c21d@bahia.lan>
Message-ID: <155476288881.5793.5351161802797300445@sif>
Date: Mon, 08 Apr 2019 17:34:48 -0500
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v7 0/2] spapr-rtas: add ibm,
 get-vpd RTAS interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>

Quoting Greg Kurz (2019-04-08 11:31:56)
> On Mon, 8 Apr 2019 14:21:50 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
> =

> > On Fri, Mar 29, 2019 at 01:29:51PM +0100, Greg Kurz wrote:
> > > On Thu, 28 Mar 2019 15:39:45 -0300
> > > "Maxiwell S. Garcia" <maxiwell@linux.ibm.com> wrote:
> > >   =

> > > > Hi,
> > > > =

> > > > On Thu, Mar 28, 2019 at 02:21:51PM +0100, Greg Kurz wrote:  =

> > > > > On Wed, 27 Mar 2019 17:41:00 -0300
> > > > > "Maxiwell S. Garcia" <maxiwell@linux.ibm.com> wrote:
> > > > >     =

> > > > > > Here are two patches to add a handler for ibm,get-vpd RTAS call=
s.
> > > > > > This RTAS exposes host information in case of set QEMU options
> > > > > > 'host-serial' and 'host-model' as 'passthrough'.
> > > > > > =

> > > > > > The patch 1 creates helper functions to get valid 'host-serial'
> > > > > > and 'host-model' parameters, guided by QEMU command line. These
> > > > > > parameters are useful to build the guest device tree and to ret=
urn
> > > > > > get-vpd RTAS calls. The patch 2 adds the ibm,get-vpd itself.
> > > > > > =

> > > > > > Update v7:
> > > > > > * rtas_get_vpd_fields as a static array in spapr machine state
> > > > > > =

> > > > > > Maxiwell S. Garcia (2):
> > > > > >   spapr: helper functions to get valid host fields
> > > > > >   spapr-rtas: add ibm,get-vpd RTAS interface
> > > > > > =

> > > > > >  hw/ppc/spapr.c         | 48 +++++++++++----------
> > > > > >  hw/ppc/spapr_rtas.c    | 96 ++++++++++++++++++++++++++++++++++=
++++++++
> > > > > >  include/hw/ppc/spapr.h | 14 +++++-
> > > > > >  3 files changed, 135 insertions(+), 23 deletions(-)
> > > > > >     =

> > > > > =

> > > > > Hi Maxiwell,
> > > > > =

> > > > > David sent a patch to rework how the host data is exposed to the =
guest.
> > > > > Especially, the special casing of the "none" and "passthrough" st=
rings
> > > > > is no more... I'm afraid you'll have to rework your patches accor=
dingly:
> > > > > code+changelog in patch 1 and at least changelog in patch 2.
> > > > > =

> > > > > Cheers,    =

> > > > =

> > > > IIUC, the 'ibm,get-vpd' RTAS should return information about the
> > > > platform/cabinet. Thus, it's not necessary to add new nodes in the =
guest
> > > > device tree to export information like that.  =

> > > =

> > > I agree that these "host-model" and "host-serial" props, which aren't
> > > described anywhere and not used by either the linux kernel or the
> > > powerpc-utils, look like a QEMU-specific poor man's version of VPD.
> > > =

> > > Not quite sure why they were even created since this is the purpose
> > > of "system-id" and "model" as explained in PAPR, and supposedly
> > > exposed in /proc/ppc64/lparcfg according to the LPARCFG(5) manual
> > > page:  =

> > =

> > Yeah, I'm not sure why they were created either.  I rather suspect
> > nothing much is using them, and I'd kind of like to just kill them.
> > But Daniel Berrange (and maybe others) are paranoid about this
> > breaking things.
> > =

> =

> Speaking of that. The "host-model"/"host-serial" fix is associated to a
> CVE which affects QEMU versions currently shipped by downstream vendors.
> Isn't a good enough reason to break things in existing unsecure setups ?
> Should we add this patch to Mike's patch round-up for stable 3.0.1 (and
> therefore break something that used to _work_ with 3.0.0) ?

Just for confirm: is the suggestion to backport 27461d69a? IIUC the fix
would involve utilizing new command-line options to override the default
"passthrough" mode for host-model/host-serial.

If so, I think an argument could be made, but I generally try to avoid
anything relying on new command-line options since they're unlikely to be
utilized unless the distro/vendor are likely to have specific plans to use
them and implement the appropriate changes elsewhere in their stack to do
so (e.g.  stuff like Spectre mitigations). And, worst case, downstreams
would still have the option of backporting the QEMU fixes as part of the
overall CVE fix, so I'd probably opt to leave this one to the downstreams
to consider.
