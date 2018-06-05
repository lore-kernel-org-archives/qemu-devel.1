Received: from eggs.gnu.org ([2001:4830:134:3::10]:60687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1fQGU6-00031j-F2
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 14:15:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1fQGU5-0004cr-BW
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 14:15:06 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:44107)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1fQGU5-0004Xx-4G
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 14:15:05 -0400
Received: by mail-oi0-x242.google.com with SMTP id c128-v6so2954010oig.11
	for <qemu-devel@nongnu.org>; Tue, 05 Jun 2018 11:15:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180605164205.GA21034@linux.intel.com>
References: <20180521163203.26590-1-ross.zwisler@linux.intel.com>
	<20180521163203.26590-4-ross.zwisler@linux.intel.com>
	<20180605182243-mutt-send-email-mst@kernel.org>
	<20180605164205.GA21034@linux.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 5 Jun 2018 11:15:00 -0700
Message-ID: <CAPcyv4jSoFifTc05WGgxkEX6i7b12zYyB+VchJVW_+QPQzO7Fg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [qemu PATCH v4 3/4] nvdimm,
 acpi: support NFIT platform capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Qemu Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On Tue, Jun 5, 2018 at 9:42 AM, Ross Zwisler
<ross.zwisler@linux.intel.com> wrote:
> On Tue, Jun 05, 2018 at 06:25:27PM +0300, Michael S. Tsirkin wrote:
>> On Mon, May 21, 2018 at 10:32:02AM -0600, Ross Zwisler wrote:
>> > Add a machine command line option to allow the user to control the Platform
>> > Capabilities Structure in the virtualized NFIT.  This Platform Capabilities
>> > Structure was added in ACPI 6.2 Errata A.
>> >
>> > Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
>>
>> I tried playing with it and encoding the capabilities is
>> quite awkward.
>>
>> Can we add bits for specific capabilities instead of nvdimm-cap?
>>
>> How about:
>>
>> "cpu-flush-on-power-loss-cap"
>> "memory-flush-on-power-loss-cap"
>> "byte-addressable-mirroring-cap"
>
> Hmmm...I don't like that as much because:
>
> a) It's very verbose.  Looking at my current qemu command line few other
>    options require that many characters, and you'd commonly be defining more
>    than one of these for a given VM.
>
> b) It means that the QEMU will need to be updated if/when new flags are added,
>    because we'll have to have new options for each flag.  The current
>    implementation is more future-proof because you can specify any flags
>    value you want.
>
> However, if you feel strongly about this, I'll make the change.

Straw-man: Could we do something similar with what we are doing in ndctl?

enum ndctl_persistence_domain {
        PERSISTENCE_NONE = 0,
        PERSISTENCE_MEM_CTRL = 10,
        PERSISTENCE_CPU_CACHE = 20,
        PERSISTENCE_UNKNOWN = INT_MAX,
};

...and have the command line take a number where "10" and "20" are
supported today, but allows us to adapt to new persistence domains in
the future.
