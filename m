Received: from eggs.gnu.org ([2001:4830:134:3::10]:39509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dzQ4i-0004pn-9G
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 12:29:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dzQ4h-0006kI-1t
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 12:29:40 -0400
Date: Tue, 3 Oct 2017 17:29:22 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171003162921.GB2335@work-vm>
References: <1507034861-4661-1-git-send-email-jan.dakinevich@virtuozzo.com>
	<1507034861-4661-2-git-send-email-jan.dakinevich@virtuozzo.com>
	<e77d7b78-a2ff-51a3-360e-c7d5d4e7006b@redhat.com>
	<7735fee8-dcc0-edc1-2fd3-f2aee7fe2df1@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7735fee8-dcc0-edc1-2fd3-f2aee7fe2df1@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v4 1/2] virtio: introduce `query-virtio'
 QMP command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Dakinevich <jan.dakinevich@virtuozzo.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, Amit Shah <amit@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Denis V. Lunev" <den@virtuozzo.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org

* Jan Dakinevich (jan.dakinevich@virtuozzo.com) wrote:
> 
> 
> On 10/03/2017 05:02 PM, Eric Blake wrote:
> > On 10/03/2017 07:47 AM, Jan Dakinevich wrote:
> >> The command is intended for gathering virtio information such as status,
> >> feature bits, negotiation status. It is convenient and useful for debug
> >> purpose.
> >>
> >> The commands returns generic virtio information for virtio such as
> >> common feature names and status bits names and information for all
> >> attached to current machine devices.
> >>
> >> To retrieve names of device-specific features `get_feature_name'
> >> callback in VirtioDeviceClass also was introduced.
> >>
> >> Cc: Denis V. Lunev <den@virtuozzo.com>
> >> Signed-off-by: Jan Dakinevich <jan.dakinevich@virtuozzo.com>
> >> ---
> >>  hw/block/virtio-blk.c       |  21 +++++++++
> >>  hw/char/virtio-serial-bus.c |  15 +++++++
> >>  hw/display/virtio-gpu.c     |  13 ++++++
> >>  hw/net/virtio-net.c         |  35 +++++++++++++++
> >>  hw/scsi/virtio-scsi.c       |  16 +++++++
> >>  hw/virtio/Makefile.objs     |   2 +
> >>  hw/virtio/virtio-balloon.c  |  15 +++++++
> >>  hw/virtio/virtio-stub.c     |   9 ++++
> >>  hw/virtio/virtio.c          | 101 ++++++++++++++++++++++++++++++++++++++++++++
> >>  include/hw/virtio/virtio.h  |   2 +
> >>  qapi-schema.json            |   1 +
> >>  qapi/virtio.json            |  94 +++++++++++++++++++++++++++++++++++++++++
> >>  12 files changed, 324 insertions(+)
> >>  create mode 100644 hw/virtio/virtio-stub.c
> >>  create mode 100644 qapi/virtio.json
> > 
> > This creates a new .json file, but does not touch MAINTAINERS.  Our idea
> > in splitting the .json files was to make it easier for each sub-file
> > that needs a specific maintainer in addition to the overall *.json line
> > for QAPI maintainers, so this may deserve a MAINTAINERS entry.
> > 
> 
> Ok.
> 
> >> +++ b/qapi/virtio.json
> >> @@ -0,0 +1,94 @@
> >> +# -*- Mode: Python -*-
> >> +#
> >> +
> >> +##
> >> +# = Virtio devices
> >> +##
> >> +
> >> +{ 'include': 'common.json' }
> >> +
> >> +##
> >> +# @VirtioInfoBit:
> >> +#
> >> +# Named virtio bit
> >> +#
> >> +# @bit: bit number
> >> +#
> >> +# @name: bit name
> >> +#
> >> +# Since: 2.11.0
> >> +#
> >> +##
> >> +{
> >> +    'struct': 'VirtioInfoBit',
> >> +    'data': {
> >> +        'bit': 'uint64',
> > 
> > Why is this a 64-bit value? Are the values 0-63, or are they 1, 2, 4, 8,
> > ...?  The documentation on 'bit number' is rather sparse.
> 
> I would prefer `uint' here, but I don't see generic unsigned type (may
> be, I am mistaken). I could use uint8 here, though.
> 
> > 
> >> +        'name': 'str'
> > 
> > Wouldn't an enum type be better than an open-ended string?
> > 
> 
> Bit names are not known here, they are obtained from virtio device
> implementations.
> 
> >> +    }
> >> +}
> >> +
> >> +##
> >> +# @VirtioInfoDevice:
> >> +#
> >> +# Information about specific virtio device
> >> +#
> >> +# @qom_path: QOM path of the device
> > 
> > Please make this 'qom-path' - new interfaces should prefer '-' over '_'.
> 
> Ok.
> 
> >> +#
> >> +# @feature-names: names of device-specific features
> >> +#
> >> +# @host-features: bitmask of features, provided by devices
> >> +#
> >> +# @guest-features: bitmask of features, acknowledged by guest
> >> +#
> >> +# @status: virtio device status bitmask
> >> +#
> >> +# Since: 2.11.0
> >> +#
> >> +##
> >> +{
> >> +    'struct': 'VirtioInfoDevice',
> >> +    'data': {
> >> +        'qom_path': 'str',
> >> +        'feature-names': ['VirtioInfoBit'],
> >> +        'host-features': 'uint64',
> >> +        'guest-features': 'uint64',
> >> +        'status': 'uint64'
> > 
> > I'm wondering if this is the best representation (where the caller has
> > to parse the integer and then lookup in feature-names what each bit of
> > the integer represents).  But I'm not sure I have anything better off
> > the top of my head.
> > 
> 
> Consider it as way to tell caller about names of supported features.
> 
> >> +    }
> >> +}
> >> +
> >> +##
> >> +# @VirtioInfo:
> >> +#
> >> +# Information about virtio devices
> >> +#
> >> +# @feature-names: names of common virtio features
> >> +#
> >> +# @status-names: names of bits which represents virtio device status
> >> +#
> >> +# @devices: list of per-device virtio information
> >> +#
> >> +# Since: 2.11.0
> >> +#
> >> +##
> >> +{
> >> +    'struct': 'VirtioInfo',
> >> +    'data': {
> >> +        'feature-names': ['VirtioInfoBit'],
> > 
> > Why is feature-names listed at two different nestings of the return value?
> > 
> 
> These are different feature names. First names are common and predefined
> for all devices. Second names are device-specific.

If you can turn these into enums (union'd enums?) then you might
be able to get rid of a lot of your array filling/naming conversion
boilerplate. (Not sure if it's worth it, but it's worth looking).

Dave

> >> +        'status-names': ['VirtioInfoBit'],
> >> +        'devices': ['VirtioInfoDevice']
> >> +    }
> >> +}
> >> +
> >> +
> >> +##
> >> +# @query-virtio:
> >> +#
> >> +# Returns generic and per-device virtio information
> >> +#
> >> +# Since: 2.11.0
> >> +#
> >> +##
> >> +{
> >> +    'command': 'query-virtio',
> >> +    'returns': 'VirtioInfo'
> >> +}
> >>
> > 
> 
> -- 
> Best regards
> Jan Dakinevich
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
