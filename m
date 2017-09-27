Received: from eggs.gnu.org ([2001:4830:134:3::10]:45493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dx7zs-0007lq-FV
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 04:47:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dx7zm-0006TO-Kx
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 04:47:12 -0400
Date: Wed, 27 Sep 2017 10:46:49 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170927104649.004e80cd.cohuck@redhat.com>
In-Reply-To: <20170926172020.GC14717@localhost.localdomain>
References: <1506442418-26026-1-git-send-email-jan.dakinevich@virtuozzo.com>
	<20170926172020.GC14717@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] virtio: introduce `info virtio' hmp command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Jan Dakinevich <jan.dakinevich@virtuozzo.com>, "Denis V. Lunev" <den@virtuozzo.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, Jason Wang <jasowang@redhat.com>, Amit Shah <amit@kernel.org>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Tue, 26 Sep 2017 19:20:20 +0200
Kevin Wolf <kwolf@redhat.com> wrote:

> Am 26.09.2017 um 18:13 hat Jan Dakinevich geschrieben:
> > The command is intended for exposing device specific virtio feature bits
> > and their negotiation status. It is convenient and useful for debug
> > purpose.
> > 
> > Names of features are taken from a devices via get_feature_name() within
> > VirtioDeviceClass. If certain device doesn't implement it, the command
> > will print only hexadecimal value of feature mask.
> > 
> > Cc: Denis V. Lunev <den@virtuozzo.com>
> > Signed-off-by: Jan Dakinevich <jan.dakinevich@virtuozzo.com>
> > ---
> > The patch suggests an another approach for this:
> > 
> > "virtio: show guest features in 'info qtree'"
> > http://lists.nongnu.org/archive/html/qemu-devel/2016-05/msg01609.html  
> 
> Actually, I think the original approach is much nicer because it uses
> generic infrastructure rather than introducing a one-off monitor command
> that is specific to a certain class of devices.

Probably unsurprisingly, I like this approach much better.

> 
> But at the same time I can see Cornelia's point that this would create a
> whole lot of properties and if we did the same thing consistently for
> all devices, the output of 'info qtree' would be completely cluttered
> up.
> 
> Maybe it would make sense to have properties that can be queried with
> QOM, but that don't show up in 'info qtree'? If we then add some HMP
> 'qom-get' command that allows dumping a whole device as a QOM object
> instead of having to query property by property, it should be quite
> convenient to use.

It's not just that you have to add a property for every feature bit.
They would also need either more state (to cover host offered and guest
accepted bits), or they would need to be duplicated for host and guest
bits. Additionally, we need to consider that feature negotiation is only
final for virtio-1 devices if the feature accepted status has been set
-- that's why I think providing the current status makes sense as well.

I do like your idea of queryable properties and HMP-driven qom-get,
though.
