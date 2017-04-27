Received: from eggs.gnu.org ([2001:4830:134:3::10]:58065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d3k3K-0004zN-Df
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 10:05:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d3k3H-0004fR-4o
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 10:05:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d3k3G-0004f4-SL
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 10:05:47 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1493260558-20728-1-git-send-email-he.chen@linux.intel.com>
	<24766133-5384-09fd-a24a-8acf964c9367@redhat.com>
	<20170427153222.5d991d2b@nial.brq.redhat.com>
Date: Thu, 27 Apr 2017 16:05:42 +0200
In-Reply-To: <20170427153222.5d991d2b@nial.brq.redhat.com> (Igor Mammedov's
	message of "Thu, 27 Apr 2017 15:32:22 +0200")
Message-ID: <874lxa2bex.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v9] Allow setting NUMA distance for
 different NUMA nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Andrew Jones <drjones@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, He Chen <he.chen@linux.intel.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Igor Mammedov <imammedo@redhat.com> writes:

> On Thu, 27 Apr 2017 07:54:31 -0500
> Eric Blake <eblake@redhat.com> wrote:
>
>> On 04/26/2017 09:35 PM, He Chen wrote:
>> > This patch is going to add SLIT table support in QEMU, and provides
>> > additional option `dist` for command `-numa` to allow user set vNUMA
>> > distance by QEMU command.
>> > 
>> > With this patch, when a user wants to create a guest that contains
>> > several vNUMA nodes and also wants to set distance among those nodes,
>> > the QEMU command would like:
>> > 
>> > ```
>> > -numa node,nodeid=0,cpus=0 \
>> > -numa node,nodeid=1,cpus=1 \
>> > -numa node,nodeid=2,cpus=2 \
>> > -numa node,nodeid=3,cpus=3 \
>> > -numa dist,src=0,dst=1,val=21 \
>> > -numa dist,src=0,dst=2,val=31 \
>> > -numa dist,src=0,dst=3,val=41 \
>> > -numa dist,src=1,dst=2,val=21 \
>> > -numa dist,src=1,dst=3,val=31 \
>> > -numa dist,src=2,dst=3,val=21 \
>> > ```
>> > 
>> > Signed-off-by: He Chen <he.chen@linux.intel.com>
>> > 
>> > ---
>> > Changes since v8:
>> > * numa_{node, distance}_parse --> parse_numa_{node, distance}
>> > * Comments refinement.  
>> 
>> 
>> > ---
>> >  hw/acpi/aml-build.c         |  26 +++++++++
>> >  hw/i386/acpi-build.c        |   4 ++
>> >  include/hw/acpi/aml-build.h |   1 +
>> >  include/sysemu/numa.h       |   2 +
>> >  include/sysemu/sysemu.h     |   4 ++
>> >  numa.c                      | 137 +++++++++++++++++++++++++++++++++++++++++++-
>> >  qapi-schema.json            |  30 +++++++++-
>> >  qemu-options.hx             |  16 +++++-
>> >  8 files changed, 215 insertions(+), 5 deletions(-)  
>> 
>> Markus has asked that all new QMP commands have some testsuite exposure;
>> he may have some advice on what test would be best to modify to give us
>> some coverage of this feature.

I can't see the QMP command here, but...

> Since it's basically validation of SLIT table, the test case
> should be added to tests/bios-tables-test.c

... I figure there's new stuff to test all the same.
