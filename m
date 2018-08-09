Received: from eggs.gnu.org ([2001:4830:134:3::10]:37736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fnhwh-0008CX-UM
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 06:13:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fnhwd-0007kE-0I
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 06:13:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58190 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fnhwc-0007jq-Qo
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 06:13:26 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 77F127B2B1
	for <qemu-devel@nongnu.org>; Thu,  9 Aug 2018 10:13:26 +0000 (UTC)
Date: Thu, 9 Aug 2018 12:13:24 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180809121324.65f741c1@redhat.com>
In-Reply-To: <20180808231810-mutt-send-email-mst@kernel.org>
References: <1533741349-199141-1-git-send-email-imammedo@redhat.com>
	<20180808231810-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 0/4] "pc: acpi: _CST support"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org

On Wed, 8 Aug 2018 23:20:25 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Aug 08, 2018 at 05:15:45PM +0200, Igor Mammedov wrote:
> > It's an alternative approach to
> >  1) [PATCH hack dontapply v2 0/7] Dynamic _CST generation
> > which instead of dynamic AML loading uses static AML with
> > dynamic values.  It allows us to keep firmware blob static and
> > to avoid split firmware issue (1) in case of cross version migration.  
> 
> I think there's a misunderstanding. That patch only declares a couple of
> states but that is just for debugging/demonstration purposes.  A typical
> real CPU has more states (e.g. some intel CPUs have ~10 levels).
yep, baremetal has more CStates, but that depends on what we are trying to
achieve here. If goal is to use mwait/monitor instead o halt when idle
to reduce wakeup latencies then 1 entry in _CST is sufficient.
If target is reduce power consumption than we would need more entries.
In the later case _CST is probably not sufficient as it provides only
power/latency pair while intel_idle also provides target residence.
So if power mgmt target is considered, we need to use new _LPI
which means guest will need support for it as well, not sure if x86
kernel supports it nor aware of such support in Windows (hopefully it 
would just ignore unknown method)

> 
> > ABI in this case is confined to cpu hotplug IO registers
> > (i.e. do it old school way, like we used to do so far).
> > This way we don't have to add yet another ABI to keep dynamic
> > AML code under control (1).
> > 
> > Tested  with: XPsp3 - ws2106 guests.
> > 
> > CC: "Michael S. Tsirkin" <mst@redhat.com>
> > 
> > 
> > Igor Mammedov (3):
> >   acpi: add aml_create_byte_field()
> >   pc: acpi: add _CST support
> >   acpi: add support for CST update notification
> > 
> > Michael S. Tsirkin (1):
> >   acpi: aml: add aml_register()
> > 
> >  include/hw/acpi/aml-build.h     |   6 ++
> >  include/hw/acpi/cpu.h           |  10 +++
> >  docs/specs/acpi_cpu_hotplug.txt |  21 +++++-
> >  hw/acpi/aml-build.c             |  28 +++++++
> >  hw/acpi/cpu.c                   | 158 +++++++++++++++++++++++++++++++++++++++-
> >  hw/acpi/piix4.c                 |   2 +
> >  hw/i386/acpi-build.c            |   5 +-
> >  tests/bios-tables-test.c        |   1 +
> >  8 files changed, 225 insertions(+), 6 deletions(-)
> > 
> > -- 
> > 2.7.4  
