Received: from eggs.gnu.org ([2001:4830:134:3::10]:39603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eRe4e-0006Q9-0G
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 08:06:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eRe4Z-0005WI-0Z
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 08:06:15 -0500
Date: Wed, 20 Dec 2017 13:05:51 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171220130550.GA2349@work-vm>
References: <1513542355-28203-1-git-send-email-jan.dakinevich@virtuozzo.com>
	<1513542355-28203-2-git-send-email-jan.dakinevich@virtuozzo.com>
	<87k1xig3zl.fsf@dusky.pond.sub.org>
	<20171220034730.696c3ceb@virtuozzo.com>
	<873745d7qp.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <873745d7qp.fsf@dusky.pond.sub.org>
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
Cc: Jan Dakinevich <jan.dakinevich@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>, "Denis V. Lunev" <den@virtuozzo.com>, qemu-block@nongnu.org, Amit Shah <amit@kernel.org>, Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>

* Markus Armbruster (armbru@redhat.com) wrote:
> Jan Dakinevich <jan.dakinevich@virtuozzo.com> writes:
> 
> > On Tue, 19 Dec 2017 15:57:18 +0100
> > Markus Armbruster <armbru@redhat.com> wrote:
> >
> >> QAPI/QMP interface review only.
> >> 
> >> You neglected to cc: the maintainers of qapi-schema.json, so I'm doing
> >> that for you.
> >> 
> >
> > Thank you so much. I screwed up with this patchset at least twice: with
> > list of maintainers and with my own e-mail.
> >
> >> Jan Dakinevich <jan.dakinevich@virtuozzo.com> writes:
> >> 
> >> > The command is intended for gathering virtio information such as
> >> > status, feature bits, negotiation status. It is convenient and
> >> > useful for debug purpose.
> >> >
> >> > The commands returns generic virtio information for virtio such as
> >> > common feature names and status bits names and information for all
> >> > attached to current machine devices.
> >> >
> >> > To retrieve names of device-specific features `tell_feature_name'
> >> > callback in VirtioDeviceClass also was introduced.
> >> >
> >> > Cc: Denis V. Lunev <den@virtuozzo.com>
> >> > Signed-off-by: Jan Dakinevich <jan.dakinevich@virtuozzo.com>
> >> [...]
> >> > diff --git a/qapi-schema.json b/qapi-schema.json
> >> > index 1845795..51cd0f3 100644
> >> > --- a/qapi-schema.json
> >> > +++ b/qapi-schema.json
> >> > @@ -3200,3 +3200,73 @@
> >> >  # Since: 2.11
> >> >  ##
> >> >  { 'command': 'watchdog-set-action', 'data' : {'action':
> >> > 'WatchdogAction'} } +
> >> > +##
> >> > +# @VirtioFeature:
> >> > +#
> >> > +# Virtio feature bit with negotiation status
> >> > +#
> >> > +# @name: name of feature bit
> >> > +#
> >> > +# @acked: negotiation status, `true' if guest acknowledged the
> >> > feature +#
> >> > +# Since: 2.12
> >> > +##
> >> > +{
> >> > +    'struct': 'VirtioFeature',
> >> > +    'data': {
> >> > +        'name': 'str',
> >> > +        'acked': 'bool'
> >> > +    }
> >> > +}
> >> > +
> >> > +##
> >> > +# @VirtioInfo:
> >> > +#
> >> > +# Information about virtio device
> >> > +#
> >> > +# @qom-path: QOM path of the device
> >> > +#
> >> > +# @status: status bitmask
> >> > +#
> >> > +# @host-features: bitmask of features, exposed by device
> >> > +#
> >> > +# @guest-features: bitmask of features, acknowledged by guest
> >> 
> >> Quoting my review of v4: "Unsigned integer interpreted as combination
> >> of well-known bit-valued symbols" is a fine C interface, but a pretty
> >> horrid QMP interface.  What's wrong with doing a set the
> >> straightforward way as "array of enum"?  As far as I can see, I
> >> didn't get a reply back then.  You'll have to give one to get the
> >> patch accepted.
> >> 
> >
> > Most probably, I didn't understand you last time. Although, I'm still
> > far from correct understanding.
> >
> > About 'array of enum', I could make the following description:
> >
> > {
> >   'enum': 'VirtioFeatureScsiBit',
> >   'data': ['inout', 'hotplug', 'change', 'ta10_pi']
> > }
> >
> > {
> >   'struct': 'VirtioFeatureScsi',
> >   'data' : {
> >       'bit': 'VirtioFeatureScsiBit',
> >       'acked': 'bool'
> >   }
> > }
> >
> > {
> >   'enum': 'VirtioFeatureSerialBit',
> >   'data': ['size', 'multiport', 'emerg-write']
> > }
> >
> > {
> >   'struct': 'VirtioFeatureSerial',
> >   'data' : {
> >       'bit': 'VirtioFeatureSerialBit',
> >       'acked': 'bool'
> >   }
> > }
> >
> > { 
> >   'enum': 'VirtioFeatureCategory',
> >   'data': ['scsi', 'serial'] 
> > }
> >
> > {
> >   'union': 'VirtioFeature',
> >   'base': {
> >     'category': 'VirtioFeatureCategory'
> >   },
> >   'discriminator': 'categoty',
> >   'data': {
> >     'scsi': 'VirtioFeatureScsi',
> >     'serial': 'VirtioFeatureSerial'
> >   }
> > }
> >
> > {
> >   'union': 'VirtioInfo',
> >   'data': {
> >     'qom-path': 'str',
> >     'device-features': ['VirtioFeature']
> >     ...
> >   }
> > }
> >
> > But IMO, it only increases complexity without any benefit. To use this
> > description, at first it should be listed all features names in enums.
> > Then, these enums should be mapped into bit numbers and differently for
> > each virtio device. I expect something like this:
> >
> > VirtioFeatureScsiBit bit = ...
> >
> > switch (bit) {
> > case VIRTIO_FEATURE_SCSI_BIT_INOUT:
> >     return VIRTIO_SCSI_F_INOUT;
> > case VIRTIO_FEATURE_SERIAL_BIT_HOTPLUG:
> >     return VIRTIO_SCSI_F_HOTPLUG;
> > case VIRTIO_FEATURE_SERIAL_BIT_CHANGE:
> >     return VIRTIO_SCSI_F_CHANGE;
> > case VIRTIO_FEATURE_SERIAL_BIT_T10_PI:
> >     return VIRTIO_SCSI_F_T10_PI;
> > }
> >
> > So, boilerplate for mapping between bit numbers and and theirs names
> > will not go away.
> 
> No argument.  It's not about simplifying the implementation, it's about
> finding the appropriate QMP interface.
> 
> > Furthermore, HMP command should produce readable output from QMP data,
> > features's enum values should be converted to strings from json
> > description. For that, for each possible VirtioFeatureCategary should
> > be called respective VirtioFeature*_str macro to resolve enum value.
> >
> > So, all my attempts to declare bit names within QAPI brings me to
> > familiar solutions.
> 
> QMP prefers symbols (strings on the wire, preferably enums in the
> schema) over magic numbers.
> 
> That said, numbers may be okay in certain cases, say when they're
> sufficiently well-known and QEMU only passes them along.  Drawback:
> defeats introspection; you can't see what bits this QEMU supports.  Why
> is that not interesting?

The point of having the numbers though was to allow presentation of
state even if the qemu doesn't know about it.

> Taking a step back: what's the intended purpose of query-virtio?  The
> cover letter doesn't really say:
> 
>     After some discussion, I am going to suggest reworked QMP/HMP for
>     gathering virtio info. It would provide the following monitor output.
> 
>     (qemu) info virtio
>     virtio-blk-device at 0000:00:02.0
>       QOM path: /machine/peripheral-anon/device[0]/virtio-backend
>       status: 0x0f
>         VIRTIO_CONFIG_S_ACKNOWLEDGE
>         VIRTIO_CONFIG_S_DRIVER
>         VIRTIO_CONFIG_S_DRIVER_OK
>         VIRTIO_CONFIG_S_FEATURES_OK
>       host features:  0x0000000179000e54
>       guest features: 0x0000000130000e54
>       common features:
>         VIRTIO_F_NOTIFY_ON_EMPTY
>         VIRTIO_F_ANY_LAYOUT
>         VIRTIO_RING_F_INDIRECT_DESC              acked
>         VIRTIO_RING_F_EVENT_IDX                  acked
>         VIRTIO_F_BAD_FEATURE
>         VIRTIO_F_VERSION_1                       acked
>       device features:
>         VIRTIO_BLK_F_SEG_MAX                     acked
>         VIRTIO_BLK_F_BLK_SIZE                    acked
>         VIRTIO_BLK_F_FLUSH                       acked
>         VIRTIO_BLK_F_TOPOLOGY                    acked
> 
> The first sentence carries no useful information; suggest to scratch it.
> The rest is an HMP example.  Examples are great, but we really need to
> understand *why* you need this command.

Lets go all the way back to v1; this was just for debug;
  http://lists.nongnu.org/archive/html/qemu-devel/2017-09/msg07247.html

the qmp interface is only there because people said that that having
QMP is the norm, and now it's dragged on for ages now trying to
come up with a way to get a stable interface for something that
was only intended as a useful bit of debug!

> >> In case symbolic names may not be known at QEMU compile time (me
> >> having to wonder at v6 is a sign of rather ineffective patch review,
> >> sorry about that): you have to explain this in the doc comment, with a
> >> reference to where the bits are specified.
> >> 
> >
> > ok
> 
> Can you think of a scenario where status or feature bits occur that are
> not known to QEMU at compile time?

Can't that happen when a newer guest driver asks for features the host
doesn't have? Or do those bits get masked off before we get to see
them?
IMHO it would be wrong to ignore bits you didn't know about; you want
to flag them up at least for someone to go 'that's odd...' - and what's
the best way to represent bits you didn't know about other than a good
old integer?

Dave

> >> > +#
> >> > +# @status-names: names of checked bits in status bitmask
> >> 
> >> How are the strings in @status-names connected to the bits in @status?
> >> Spell it out in this doc string, please.
> >> 
> >
> > ok
> >
> > ...but, strictly saying, I was not going to show in QAPI how these names
> > are mapped into bits, QMP answer would not contain how these names are
> > connected to bits. Otherwise, It would be reinvention of v4.
> 
> To avoid going in circles some more, let's take a step back and examine
> what exactly you're trying to accomplish.  Give us use cases: this is my
> need, and this is how you use the proposed command to satisfy my need.
> Also give us design limitations: what the command is *not* trying to do.
> 
> >> > +#
> >> > +# @common-features-names: names exposed features and negotiation
> >> > status, +# that are common to all devices
> >> > +#
> >> > +# @device-features-names: names exposed features and negotiation
> >> > status, +# that are specific to this device
> >> 
> >> Likewise.
> >> 
> >
> > ok
> >
> >> > +#
> >> > +# Since: 2.12
> >> > +##
> >> > +{
> >> > +    'struct': 'VirtioInfo',
> >> > +    'data': {
> >> > +        'qom-path': 'str',
> >> > +
> >> > +        'status': 'uint8',
> >> > +        'host-features': 'uint64',
> >> > +        'guest-features': 'uint64',
> >> > +
> >> > +        'status-names': ['str'],
> >> > +        'common-features-names': ['VirtioFeature'],
> >> > +        'device-features-names': ['VirtioFeature']
> >> > +    }
> >> > +}
> >> > +
> >> > +##
> >> > +# @query-virtio:
> >> > +#
> >> > +# Returns virtio information such as device status and features
> >> > +#
> >> > +# Since: 2.12
> >> > +##
> >> > +{
> >> > +    'command': 'query-virtio',
> >> > +    'data': {'*path': 'str'},
> >> > +    'returns': ['VirtioInfo']
> >> > +}
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
