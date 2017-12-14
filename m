Received: from eggs.gnu.org ([2001:4830:134:3::10]:33230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePRL8-0005QB-G5
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 06:06:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePRKX-0008Cn-Te
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 06:06:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ePRKW-00087I-PR
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 06:05:33 -0500
Date: Thu, 14 Dec 2017 12:05:19 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171214120519.48edb873.cohuck@redhat.com>
In-Reply-To: <20171212165450.6b6e823f@virtuozzo.com>
References: <1508867404-18046-1-git-send-email-jan.dakinevich@virtuozzo.com>
	<20171212165450.6b6e823f@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v5 0/2] virtio: introduce `info virtio' hmp
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
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Denis V. Lunev" <den@virtuozzo.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, 12 Dec 2017 16:54:50 +0300
Jan Dakinevich <jan.dakinevich@virtuozzo.com> wrote:

> I am going to reanimate works under this QMP/HMP. First of all, it
> could be meaningful to settle what output would provide the QMP. I would
> like to suggest the following description:
> 
> ##
> # @VirtioFeature:
> ##
> {
>     'struct': 'VirtioFeature',
>     'data': {
>         'name': 'str',
>         'acked': 'bool'
>     }
> }
> 
> ##
> # @VirtioInfo:
> ##
> {
>     'struct': 'VirtioInfo',
>     'data': {
>         'qom-path': 'str',
>         
>         'status': 'uint8',
>         'host-features': 'uint64',
>         'guest-features': 'uint64',
> 
>         'status-names': ['str'],
>         'common-features-names': ['VirtioFeature'],
>         'device-features-names': ['VirtioFeature']
>     }
> }
> 
> ##
> # @query-virtio:
> ##
> {
>     'command': 'query-virtio',
>     'data': {'*path': 'str'},
>     'returns': ['VirtioInfo']
> }
> 
> My final goal is to implement HMP which will print all exposed virtio
> features (both common and device-specific) with their acknowledgements,
> and virtio device configuration status. These are provided by last 3
> fields in @VirtioInfo.
> 
> For these who are going make own decision on features and status
> bitmask, respective fields with raw values are preserved.

Looks sensible. What will you return an for the *-features-names fields
if the status field indicates that negotiation is not yet done?
(This has some fun interaction with the VERSION_1 feature bit...)

> 
> So, I expect following data on the wire in response to `query-virtio'
> command:
> 
> {
>     "return": [
>         {
>             "qom-path": "/machine/peripheral-anon/device[0]/virtio-backend", "status": 15,
>             "host-features": 6325010438,
>             "guest-features": 5100273670,
>             "status-names": [
>                 "acknowledge", 
>                 "driver", 
>                 "driver-ok", 
>                 "features-ok"
>             ],
>             "common-features-names": [
>                 {"name": "notify-on-empty", "acked": false},
>                 {"name": "any-layout", "acked": false},
>                 {"name": "indirect-desc", "acked": true},
>                 {"name": "event-idx", "acked": true},
>                 {"name": "bad-feature", "acked": false},
>                 {"name": "version-1", "acked": true}
>             ],
>             "device-features-names": [
>                 {"name": "hotplug", "acked": true},
>                 {"name": "change", "acked": true}

I suggest to use the #defines as names, especially as they are also
used in the spec. Makes grepping easier.

>             ]
>         }
>     ]
> }
> 
> 
> Eric Blake, returning to your question which would probably appear again
> after this mail:
> 
> >> +##
> >> +# @query-virtio:
> >> ...
> >> +##
> >> +{
> >> +    'command': 'query-virtio',
> >> +    'data': { '*path': 'str' },    
> >
> > Do we need filterable queries, or is it better to just have the
> > command return info on all virtio devices at once and let the client
> > filter the results as desired?  
> 
> I think it would be better to do here. I suppose, the client which uses
> HMP will not be happy on filtering monitor output.

I think being able to optionally specify a path is the most flexible
solution.
