Received: from eggs.gnu.org ([2001:4830:134:3::10]:46402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1cTBzy-0001St-Q9
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 13:27:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1cTBzv-0000bI-L7
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 13:27:18 -0500
Received: from mail-sn1nam01on0099.outbound.protection.outlook.com
	([104.47.32.99]:12448
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1cTBzv-0000aw-3m
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 13:27:15 -0500
From: Felipe Franciosi <felipe@nutanix.com>
Date: Mon, 16 Jan 2017 18:27:12 +0000
Message-ID: <A2D5F9F5-0EB2-4295-9233-FB1A28E8A2F3@nutanix.com>
References: <1484270047-24579-1-git-send-email-felipe@nutanix.com>
	<20170116202220-mutt-send-email-mst@kernel.org>
In-Reply-To: <20170116202220-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8339648D7401004F8A145D4114313201@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] libvhost-user: Start VQs on SET_VRING_CALL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Marc-Andre Lureau <marcandre.lureau@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Hi Michael,

> On 16 Jan 2017, at 10:22, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Thu, Jan 12, 2017 at 05:14:07PM -0800, Felipe Franciosi wrote:
>> Currently, VQs are started as soon as a SET_VRING_KICK is received. That
>> is too early in the VQ setup process, as the backend might not yet have
>> a callfd to notify in case it received a kick and fully processed the
>> request/command. This patch only starts a VQ when a SET_VRING_CALL is
>> received.
>>=20
>> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
>=20
> Doesn't look right to me.
> It should happen when the fd supplies becomes readable.

Apologies, but I'm confused now. What should happen when which fd becomes r=
eadable? I thought we were discussing this further down in the thread. My l=
ast comments are here:

http://lists.nongnu.org/archive/html/qemu-devel/2017-01/msg02755.html

I pointed out what appears to be a race and am looking forward to your comm=
ents. There is definitely a problem with the current code, so it's a matter=
 of finding out exactly what's happening and what's the correct (and spec-c=
ompliant) way to fix it.

Felipe

>=20
>> ---
>> contrib/libvhost-user/libvhost-user.c | 26 +++++++++++++-------------
>> 1 file changed, 13 insertions(+), 13 deletions(-)
>>=20
>> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-us=
er/libvhost-user.c
>> index af4faad..a46ef90 100644
>> --- a/contrib/libvhost-user/libvhost-user.c
>> +++ b/contrib/libvhost-user/libvhost-user.c
>> @@ -607,19 +607,6 @@ vu_set_vring_kick_exec(VuDev *dev, VhostUserMsg *vm=
sg)
>>         DPRINT("Got kick_fd: %d for vq: %d\n", vmsg->fds[0], index);
>>     }
>>=20
>> -    dev->vq[index].started =3D true;
>> -    if (dev->iface->queue_set_started) {
>> -        dev->iface->queue_set_started(dev, index, true);
>> -    }
>> -
>> -    if (dev->vq[index].kick_fd !=3D -1 && dev->vq[index].handler) {
>> -        dev->set_watch(dev, dev->vq[index].kick_fd, VU_WATCH_IN,
>> -                       vu_kick_cb, (void *)(long)index);
>> -
>> -        DPRINT("Waiting for kicks on fd: %d for vq: %d\n",
>> -               dev->vq[index].kick_fd, index);
>> -    }
>> -
>>     return false;
>> }
>>=20
>> @@ -661,6 +648,19 @@ vu_set_vring_call_exec(VuDev *dev, VhostUserMsg *vm=
sg)
>>=20
>>     DPRINT("Got call_fd: %d for vq: %d\n", vmsg->fds[0], index);
>>=20
>> +    dev->vq[index].started =3D true;
>> +    if (dev->iface->queue_set_started) {
>> +        dev->iface->queue_set_started(dev, index, true);
>> +    }
>> +
>> +    if (dev->vq[index].kick_fd !=3D -1 && dev->vq[index].handler) {
>> +        dev->set_watch(dev, dev->vq[index].kick_fd, VU_WATCH_IN,
>> +                       vu_kick_cb, (void *)(long)index);
>> +
>> +        DPRINT("Waiting for kicks on fd: %d for vq: %d\n",
>> +               dev->vq[index].kick_fd, index);
>> +    }
>> +
>>     return false;
>> }
>>=20
>> --=20
>> 1.9.4
