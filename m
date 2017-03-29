Received: from eggs.gnu.org ([2001:4830:134:3::10]:48279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ct5XF-00041l-3Z
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 00:48:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ct5XC-00005A-0E
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 00:48:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37150)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1ct5XB-000050-NF
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 00:48:37 -0400
References: <20170324234646.15264-1-Andrew.Baumann@microsoft.com>
	<5b6dc1d9-996a-66fe-7142-2c9be4670540@weilnetz.de>
	<DM2PR21MB0060C4ECE3B5CEF456AE03AB9E320@DM2PR21MB0060.namprd21.prod.outlook.com>
	<2695069b-5704-536d-33e3-66e8d014475c@redhat.com>
	<DM2PR21MB0060292DE51C857400F27CA49E350@DM2PR21MB0060.namprd21.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <fce92185-0695-44b3-cfa0-1d10e194fa74@redhat.com>
Date: Wed, 29 Mar 2017 12:48:29 +0800
MIME-Version: 1.0
In-Reply-To: <DM2PR21MB0060292DE51C857400F27CA49E350@DM2PR21MB0060.namprd21.prod.outlook.com>
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



On 2017=E5=B9=B403=E6=9C=8829=E6=97=A5 12:13, Andrew Baumann via Qemu-dev=
el wrote:
>> From: Jason Wang [mailto:jasowang@redhat.com]
>> Sent: Tuesday, 28 March 2017 19:39
>>
>> On 2017=E5=B9=B403=E6=9C=8829=E6=97=A5 02:55, Andrew Baumann wrote:
>>>> From: Stefan Weil [mailto:sw@weilnetz.de]
>>>> Sent: Tuesday, 28 March 2017 11:28
>>>> Am 25.03.2017 um 00:46 schrieb Andrew Baumann:
>>>>> The docs generally steer users away from using the legacy -net
>>>>> parameter, however on win32 attempting to enable a tap device using
>>>>> -netdev tap fails at an abort() in tap_enable(). Removing the abort=
()s
>>>>> seems to be enough to get everything working, so do that.
>>>>>
>>>>> Signed-off-by: Andrew Baumann<Andrew.Baumann@microsoft.com>
> [...]
>>>> Jason, what is the use of tap_enable, tap_disable?
>> It should be only used when we want to enable and disable a specific
>> queue of a multiqueue supported tap.
>>
>>>>    Is it fine
>>>> to simply do nothing on Windows here?
>> Unless windows support multiqueue tap, we should keep the assert here.
>>
>>> I was also hoping for a review -- I'm no expert on this stuff either,=
 but my
>> quick reading of those code paths is that they issue ioctls to enable/=
disable
>> packet reception on the underlying tap device. As win32 TAP is impleme=
nted,
>> that is already enabled from start of day.
>>> It's possible this patch still does not permit dynamic reconfiguratio=
n of tap
>> devices (e.g. from the monitor console). However, it does work with th=
e -
>> netdev tap option on the command-line.
>>>> And is this something for QEMU=E2=80=8C 2.9 (I added question to sub=
ject line)?
>>> Ideally, yes. If not, -netdev tap will continue to blow up in the abo=
rt as it does
>> today...
>>> Andrew
>> Yes, so the problem is we should prevent tap_enable() and tap_disable(=
)
>> from being called if multiqueue is disabled.
>>
>> I believe the following patch can fix this issue, could you give a try
>> on this?
>>
>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>> index c321680..7d091c9 100644
>> --- a/hw/net/virtio-net.c
>> +++ b/hw/net/virtio-net.c
>> @@ -510,6 +510,10 @@ static int peer_attach(VirtIONet *n, int index)
>>            return 0;
>>        }
>>
>> +    if (n->max_queues =3D=3D 1) {
>> +        return 0;
>> +    }
>> +
>>        return tap_enable(nc->peer);
>>    }
>>
> Yep, this works. Thanks!
>
> Andrew

Thanks, queued this for 2.9.
