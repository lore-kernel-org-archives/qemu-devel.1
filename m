Received: from eggs.gnu.org ([2001:4830:134:3::10]:34617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.dakinevich@virtuozzo.com>) id 1eRSWS-0000Pc-DB
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 19:46:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.dakinevich@virtuozzo.com>) id 1eRSWO-0004iC-F9
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 19:46:12 -0500
Date: Wed, 20 Dec 2017 03:47:30 +0300
From: Jan Dakinevich <jan.dakinevich@virtuozzo.com>
Message-ID: <20171220034730.696c3ceb@virtuozzo.com>
In-Reply-To: <87k1xig3zl.fsf@dusky.pond.sub.org>
References: <1513542355-28203-1-git-send-email-jan.dakinevich@virtuozzo.com>
	<1513542355-28203-2-git-send-email-jan.dakinevich@virtuozzo.com>
	<87k1xig3zl.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v6 1/2] virtio: introduce `query-virtio' QMP
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, "Denis V. Lunev" <den@virtuozzo.com>, qemu-block@nongnu.org, Amit Shah <amit@kernel.org>, Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, "Dr.
	David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

On Tue, 19 Dec 2017 15:57:18 +0100
Markus Armbruster <armbru@redhat.com> wrote:

> QAPI/QMP interface review only.
> 
> You neglected to cc: the maintainers of qapi-schema.json, so I'm doing
> that for you.
> 

Thank you so much. I screwed up with this patchset at least twice: with
list of maintainers and with my own e-mail.

> Jan Dakinevich <jan.dakinevich@virtuozzo.com> writes:
> 
> > The command is intended for gathering virtio information such as
> > status, feature bits, negotiation status. It is convenient and
> > useful for debug purpose.
> >
> > The commands returns generic virtio information for virtio such as
> > common feature names and status bits names and information for all
> > attached to current machine devices.
> >
> > To retrieve names of device-specific features `tell_feature_name'
> > callback in VirtioDeviceClass also was introduced.
> >
> > Cc: Denis V. Lunev <den@virtuozzo.com>
> > Signed-off-by: Jan Dakinevich <jan.dakinevich@virtuozzo.com>
> [...]
> > diff --git a/qapi-schema.json b/qapi-schema.json
> > index 1845795..51cd0f3 100644
> > --- a/qapi-schema.json
> > +++ b/qapi-schema.json
> > @@ -3200,3 +3200,73 @@
> >  # Since: 2.11
> >  ##
> >  { 'command': 'watchdog-set-action', 'data' : {'action':
> > 'WatchdogAction'} } +
> > +##
> > +# @VirtioFeature:
> > +#
> > +# Virtio feature bit with negotiation status
> > +#
> > +# @name: name of feature bit
> > +#
> > +# @acked: negotiation status, `true' if guest acknowledged the
> > feature +#
> > +# Since: 2.12
> > +##
> > +{
> > +    'struct': 'VirtioFeature',
> > +    'data': {
> > +        'name': 'str',
> > +        'acked': 'bool'
> > +    }
> > +}
> > +
> > +##
> > +# @VirtioInfo:
> > +#
> > +# Information about virtio device
> > +#
> > +# @qom-path: QOM path of the device
> > +#
> > +# @status: status bitmask
> > +#
> > +# @host-features: bitmask of features, exposed by device
> > +#
> > +# @guest-features: bitmask of features, acknowledged by guest
> 
> Quoting my review of v4: "Unsigned integer interpreted as combination
> of well-known bit-valued symbols" is a fine C interface, but a pretty
> horrid QMP interface.  What's wrong with doing a set the
> straightforward way as "array of enum"?  As far as I can see, I
> didn't get a reply back then.  You'll have to give one to get the
> patch accepted.
> 

Most probably, I didn't understand you last time. Although, I'm still
far from correct understanding.

About 'array of enum', I could make the following description:

{
  'enum': 'VirtioFeatureScsiBit',
  'data': ['inout', 'hotplug', 'change', 'ta10_pi']
}

{
  'struct': 'VirtioFeatureScsi',
  'data' : {
      'bit': 'VirtioFeatureScsiBit',
      'acked': 'bool'
  }
}

{
  'enum': 'VirtioFeatureSerialBit',
  'data': ['size', 'multiport', 'emerg-write']
}

{
  'struct': 'VirtioFeatureSerial',
  'data' : {
      'bit': 'VirtioFeatureSerialBit',
      'acked': 'bool'
  }
}

{ 
  'enum': 'VirtioFeatureCategory',
  'data': ['scsi', 'serial'] 
}

{
  'union': 'VirtioFeature',
  'base': {
    'category': 'VirtioFeatureCategory'
  },
  'discriminator': 'categoty',
  'data': {
    'scsi': 'VirtioFeatureScsi',
    'serial': 'VirtioFeatureSerial'
  }
}

{
  'union': 'VirtioInfo',
  'data': {
    'qom-path': 'str',
    'device-features': ['VirtioFeature']
    ...
  }
}

But IMO, it only increases complexity without any benefit. To use this
description, at first it should be listed all features names in enums.
Then, these enums should be mapped into bit numbers and differently for
each virtio device. I expect something like this:

VirtioFeatureScsiBit bit = ...

switch (bit) {
case VIRTIO_FEATURE_SCSI_BIT_INOUT:
    return VIRTIO_SCSI_F_INOUT;
case VIRTIO_FEATURE_SERIAL_BIT_HOTPLUG:
    return VIRTIO_SCSI_F_HOTPLUG;
case VIRTIO_FEATURE_SERIAL_BIT_CHANGE:
    return VIRTIO_SCSI_F_CHANGE;
case VIRTIO_FEATURE_SERIAL_BIT_T10_PI:
    return VIRTIO_SCSI_F_T10_PI;
}

So, boilerplate for mapping between bit numbers and and theirs names
will not go away.

Furthermore, HMP command should produce readable output from QMP data,
features's enum values should be converted to strings from json
description. For that, for each possible VirtioFeatureCategary should
be called respective VirtioFeature*_str macro to resolve enum value.

So, all my attempts to declare bit names within QAPI brings me to
familiar solutions.

> In case symbolic names may not be known at QEMU compile time (me
> having to wonder at v6 is a sign of rather ineffective patch review,
> sorry about that): you have to explain this in the doc comment, with a
> reference to where the bits are specified.
> 

ok

> > +#
> > +# @status-names: names of checked bits in status bitmask
> 
> How are the strings in @status-names connected to the bits in @status?
> Spell it out in this doc string, please.
> 

ok

...but, strictly saying, I was not going to show in QAPI how these names
are mapped into bits, QMP answer would not contain how these names are
connected to bits. Otherwise, It would be reinvention of v4.

> > +#
> > +# @common-features-names: names exposed features and negotiation
> > status, +# that are common to all devices
> > +#
> > +# @device-features-names: names exposed features and negotiation
> > status, +# that are specific to this device
> 
> Likewise.
> 

ok

> > +#
> > +# Since: 2.12
> > +##
> > +{
> > +    'struct': 'VirtioInfo',
> > +    'data': {
> > +        'qom-path': 'str',
> > +
> > +        'status': 'uint8',
> > +        'host-features': 'uint64',
> > +        'guest-features': 'uint64',
> > +
> > +        'status-names': ['str'],
> > +        'common-features-names': ['VirtioFeature'],
> > +        'device-features-names': ['VirtioFeature']
> > +    }
> > +}
> > +
> > +##
> > +# @query-virtio:
> > +#
> > +# Returns virtio information such as device status and features
> > +#
> > +# Since: 2.12
> > +##
> > +{
> > +    'command': 'query-virtio',
> > +    'data': {'*path': 'str'},
> > +    'returns': ['VirtioInfo']
> > +}



-- 
Best regards
Jan Dakinevich
