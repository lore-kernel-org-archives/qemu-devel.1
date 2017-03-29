Received: from eggs.gnu.org ([2001:4830:134:3::10]:57898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ct3Vr-0005ql-2k
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 22:39:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ct3Vm-0006t8-0m
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 22:39:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1ct3Vl-0006sw-Pd
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 22:39:01 -0400
References: <20170324234646.15264-1-Andrew.Baumann@microsoft.com>
	<5b6dc1d9-996a-66fe-7142-2c9be4670540@weilnetz.de>
	<DM2PR21MB0060C4ECE3B5CEF456AE03AB9E320@DM2PR21MB0060.namprd21.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2695069b-5704-536d-33e3-66e8d014475c@redhat.com>
Date: Wed, 29 Mar 2017 10:38:54 +0800
MIME-Version: 1.0
In-Reply-To: <DM2PR21MB0060C4ECE3B5CEF456AE03AB9E320@DM2PR21MB0060.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for 2.9?] tap-win32: don't abort in
 tap_enable(); enables -netdev tap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Baumann <Andrew.Baumann@microsoft.com>, Stefan Weil <sw@weilnetz.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>



On 2017=E5=B9=B403=E6=9C=8829=E6=97=A5 02:55, Andrew Baumann wrote:
>> From: Stefan Weil [mailto:sw@weilnetz.de]
>> Sent: Tuesday, 28 March 2017 11:28
>> Am 25.03.2017 um 00:46 schrieb Andrew Baumann:
>>> The docs generally steer users away from using the legacy -net
>>> parameter, however on win32 attempting to enable a tap device using
>>> -netdev tap fails at an abort() in tap_enable(). Removing the abort()=
s
>>> seems to be enough to get everything working, so do that.
>>>
>>> Signed-off-by: Andrew Baumann <Andrew.Baumann@microsoft.com>
>>> ---
>>>   net/tap-win32.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/net/tap-win32.c b/net/tap-win32.c
>>> index 662f9b6..3620843 100644
>>> --- a/net/tap-win32.c
>>> +++ b/net/tap-win32.c
>>> @@ -811,10 +811,10 @@ int net_init_tap(const Netdev *netdev, const ch=
ar
>> *name,
>>>   int tap_enable(NetClientState *nc)
>>>   {
>>> -    abort();
>>> +    return 0;
>>>   }
>>>
>>>   int tap_disable(NetClientState *nc)
>>>   {
>>> -    abort();
>>> +    return 0;
>>>   }
>> As I never worked with TAP on Windows, I cannot say much to this fix.
>>
>> Jason, what is the use of tap_enable, tap_disable?

It should be only used when we want to enable and disable a specific=20
queue of a multiqueue supported tap.

>>   Is it fine
>> to simply do nothing on Windows here?

Unless windows support multiqueue tap, we should keep the assert here.

> I was also hoping for a review -- I'm no expert on this stuff either, b=
ut my quick reading of those code paths is that they issue ioctls to enab=
le/disable packet reception on the underlying tap device. As win32 TAP is=
 implemented, that is already enabled from start of day.
>
> It's possible this patch still does not permit dynamic reconfiguration =
of tap devices (e.g. from the monitor console). However, it does work wit=
h the -netdev tap option on the command-line.
>
>> And is this something for QEMU=E2=80=8C 2.9 (I added question to subje=
ct line)?
> Ideally, yes. If not, -netdev tap will continue to blow up in the abort=
 as it does today...
>
> Andrew

Yes, so the problem is we should prevent tap_enable() and tap_disable()=20
from being called if multiqueue is disabled.

I believe the following patch can fix this issue, could you give a try=20
on this?

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index c321680..7d091c9 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -510,6 +510,10 @@ static int peer_attach(VirtIONet *n, int index)
          return 0;
      }

+    if (n->max_queues =3D=3D 1) {
+        return 0;
+    }
+
      return tap_enable(nc->peer);
  }
