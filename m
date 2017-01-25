Received: from eggs.gnu.org ([2001:4830:134:3::10]:47938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cWIXD-0008T9-W7
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 03:02:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cWIX8-0001pF-EC
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 03:02:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cWIX8-0001p5-6L
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 03:02:22 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4C03B3DBC5
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 08:02:22 +0000 (UTC)
References: <1485250969-5472-1-git-send-email-thuth@redhat.com>
	<a144d9c8-8b55-d98a-45e9-d35d8db9a852@redhat.com>
	<15a24b41-d104-4074-dcaa-9c53c7b018d5@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <6295b628-2a1c-2bef-aa21-eb752f450c9c@redhat.com>
Date: Wed, 25 Jan 2017 16:02:16 +0800
MIME-Version: 1.0
In-Reply-To: <15a24b41-d104-4074-dcaa-9c53c7b018d5@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] net: Mark 'vlan' parameter as deprecated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org



On 2017=E5=B9=B401=E6=9C=8825=E6=97=A5 15:54, Thomas Huth wrote:
> On 25.01.2017 08:50, Jason Wang wrote:
>>
>> On 2017=E5=B9=B401=E6=9C=8824=E6=97=A5 17:42, Thomas Huth wrote:
>>> The 'vlan' parameter is a continuous source of confusion for the user=
s,
>>> many people mix it up with the more common term VLAN (the link layer
>>> packet encapsulation), and even if they realize that the QEMU 'vlan' =
is
>>> rather some kind of network hub emulation, there is still a high risk
>>> that they configure their QEMU networking in a wrong way with this
>>> parameter (e.g. by hooking NICs together, so they get a 'loopback'
>>> between one and the other NIC).
>>> Thus at one point in time, we should finally get rid of the 'vlan'
>>> feature in QEMU. Let's do a first step in this direction by declaring
>>> the 'vlan' parameter as deprecated and informing the users to use the
>>> 'netdev' parameter instead.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>    net/net.c | 6 ++++++
>>>    1 file changed, 6 insertions(+)
>>>
>>> diff --git a/net/net.c b/net/net.c
>>> index 939fe31..fb7af3a 100644
>>> --- a/net/net.c
>>> +++ b/net/net.c
>>> @@ -970,6 +970,7 @@ static int net_client_init1(const void *object,
>>> bool is_netdev, Error **errp)
>>>        const Netdev *netdev;
>>>        const char *name;
>>>        NetClientState *peer =3D NULL;
>>> +    static bool vlan_warned;
>>>          if (is_netdev) {
>>>            netdev =3D object;
>>> @@ -1050,6 +1051,11 @@ static int net_client_init1(const void *object=
,
>>> bool is_netdev, Error **errp)
>>>                !opts->u.nic.data->has_netdev) {
>>>                peer =3D net_hub_add_port(net->has_vlan ? net->vlan : =
0,
>>> NULL);
>>>            }
>>> +
>>> +        if (net->has_vlan && !vlan_warned) {
>>> +            error_report("'vlan' is deprecated. Please use 'netdev'
>>> instead.");
>>> +            vlan_warned =3D true;
>>> +        }
>>>        }
>>>          if (net_client_init_fun[netdev->type](netdev, name, peer,
>>> errp) < 0) {
>> Looks good, but do really want only warn once? Consider we have monito=
r
>> command e.g "host_net_add".
> I don't mind ... I can remove the "vlan_warned" check, but then you'll
> get a lot of error messages at once if you start QEMU with multiple
> "-net" parameters that use "vlan=3D...". Is that ok for you? If yes, I'=
ll
> send an updated v2 of my patch without that "vlan_warned" check.
>
>   Thomas
>

You're right, this version looks better, applied to -net.

Thanks
