Received: from eggs.gnu.org ([2001:4830:134:3::10]:43499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eRJKl-0006Qy-F2
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 09:57:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eRJKk-000328-Fx
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 09:57:31 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1513542355-28203-1-git-send-email-jan.dakinevich@virtuozzo.com>
	<1513542355-28203-2-git-send-email-jan.dakinevich@virtuozzo.com>
Date: Tue, 19 Dec 2017 15:57:18 +0100
In-Reply-To: <1513542355-28203-2-git-send-email-jan.dakinevich@virtuozzo.com>
	(Jan Dakinevich's message of "Sun, 17 Dec 2017 23:25:54 +0300")
Message-ID: <87k1xig3zl.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Jan Dakinevich <jan.dakinevich@virtuozzo.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, "Denis V. Lunev" <den@virtuozzo.com>, qemu-block@nongnu.org, Amit Shah <amit@kernel.org>, Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

QAPI/QMP interface review only.

You neglected to cc: the maintainers of qapi-schema.json, so I'm doing
that for you.

Jan Dakinevich <jan.dakinevich@virtuozzo.com> writes:

> The command is intended for gathering virtio information such as status,
> feature bits, negotiation status. It is convenient and useful for debug
> purpose.
>
> The commands returns generic virtio information for virtio such as
> common feature names and status bits names and information for all
> attached to current machine devices.
>
> To retrieve names of device-specific features `tell_feature_name'
> callback in VirtioDeviceClass also was introduced.
>
> Cc: Denis V. Lunev <den@virtuozzo.com>
> Signed-off-by: Jan Dakinevich <jan.dakinevich@virtuozzo.com>
[...]
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 1845795..51cd0f3 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -3200,3 +3200,73 @@
>  # Since: 2.11
>  ##
>  { 'command': 'watchdog-set-action', 'data' : {'action': 'WatchdogAction'} }
> +
> +##
> +# @VirtioFeature:
> +#
> +# Virtio feature bit with negotiation status
> +#
> +# @name: name of feature bit
> +#
> +# @acked: negotiation status, `true' if guest acknowledged the feature
> +#
> +# Since: 2.12
> +##
> +{
> +    'struct': 'VirtioFeature',
> +    'data': {
> +        'name': 'str',
> +        'acked': 'bool'
> +    }
> +}
> +
> +##
> +# @VirtioInfo:
> +#
> +# Information about virtio device
> +#
> +# @qom-path: QOM path of the device
> +#
> +# @status: status bitmask
> +#
> +# @host-features: bitmask of features, exposed by device
> +#
> +# @guest-features: bitmask of features, acknowledged by guest

Quoting my review of v4: "Unsigned integer interpreted as combination of
well-known bit-valued symbols" is a fine C interface, but a pretty
horrid QMP interface.  What's wrong with doing a set the straightforward
way as "array of enum"?  As far as I can see, I didn't get a reply back
then.  You'll have to give one to get the patch accepted.

In case symbolic names may not be known at QEMU compile time (me having
to wonder at v6 is a sign of rather ineffective patch review, sorry
about that): you have to explain this in the doc comment, with a
reference to where the bits are specified.

> +#
> +# @status-names: names of checked bits in status bitmask

How are the strings in @status-names connected to the bits in @status?
Spell it out in this doc string, please.

> +#
> +# @common-features-names: names exposed features and negotiation status,
> +# that are common to all devices
> +#
> +# @device-features-names: names exposed features and negotiation status,
> +# that are specific to this device

Likewise.

> +#
> +# Since: 2.12
> +##
> +{
> +    'struct': 'VirtioInfo',
> +    'data': {
> +        'qom-path': 'str',
> +
> +        'status': 'uint8',
> +        'host-features': 'uint64',
> +        'guest-features': 'uint64',
> +
> +        'status-names': ['str'],
> +        'common-features-names': ['VirtioFeature'],
> +        'device-features-names': ['VirtioFeature']
> +    }
> +}
> +
> +##
> +# @query-virtio:
> +#
> +# Returns virtio information such as device status and features
> +#
> +# Since: 2.12
> +##
> +{
> +    'command': 'query-virtio',
> +    'data': {'*path': 'str'},
> +    'returns': ['VirtioInfo']
> +}
