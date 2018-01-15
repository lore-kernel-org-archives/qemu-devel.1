Received: from eggs.gnu.org ([2001:4830:134:3::10]:45219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eb8gQ-0008Up-AH
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 12:36:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eb8gM-0003fQ-6r
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 12:36:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:3768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eb8gL-0003er-Ug
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 12:36:26 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D8C5B1A4094
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 17:36:24 +0000 (UTC)
References: <1515594755-12138-1-git-send-email-thuth@redhat.com>
	<73e534aa-ba61-e3ca-6730-3382f1c1ce1a@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <848373da-2010-d38b-fd88-91cd61dec91e@redhat.com>
Date: Mon, 15 Jan 2018 18:36:18 +0100
MIME-Version: 1.0
In-Reply-To: <73e534aa-ba61-e3ca-6730-3382f1c1ce1a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] net: Allow hubports to connect to other
 netdevs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>

On 15.01.2018 08:40, Jason Wang wrote:
>=20
> On 2018=E5=B9=B401=E6=9C=8810=E6=97=A5 22:32, Thomas Huth wrote:
>> QEMU can emulate hubs to connect NICs and netdevs. This is currently
>> primarily used for the mis-named 'vlan' feature of the networking
>> subsystem. Now the 'vlan' feature has been marked as deprecated, since
>> its name is rather confusing and the users often rather mis-configure
>> their network when trying to use it. But while the 'vlan' parameter
>> should be removed at one point in time, the basic idea of emulating
>> a hub in QEMU is still good: It's useful for bundling up the output of
>> multiple NICs into one single l2tp netdev for example.
>>
>> Now to be able to use the hubport feature without 'vlan's, there is on=
e
>> missing piece: The possibility to connect a hubport to a netdev, too.
>> This patch adds this possibility by introducing a new "netdev=3D..."
>> parameter to the hubports.
[...]
>> @@ -286,12 +287,32 @@ int net_init_hubport(const Netdev *netdev, const
>> char *name,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NetClientSta=
te *peer, Error **errp)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const NetdevHubPortOptions *hubport;
>> +=C2=A0=C2=A0=C2=A0 NetClientState *hubncs;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(netdev->type =3D=3D NET_C=
LIENT_DRIVER_HUBPORT);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(!peer);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hubport =3D &netdev->u.hubport;
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 net_hub_add_port(hubport->hubid, name);
>> +=C2=A0=C2=A0=C2=A0 hubncs =3D net_hub_add_port(hubport->hubid, name);
>> +=C2=A0=C2=A0=C2=A0 if (!hubncs) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "failed t=
o add port to hub %i with id '%s'",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hubport->hubid, name);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 if (hubport->has_netdev) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NetClientState *hubpeer;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hubpeer =3D qemu_find_netd=
ev(hubport->netdev);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!hubpeer) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 er=
ror_setg(errp, "netdev '%s' not found", hubport->netdev);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn -1;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(!hubncs->peer && !h=
ubpeer->peer);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hubncs->peer =3D hubpeer;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hubpeer->peer =3D hubncs;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>=20
> Instead of open coding here, maybe you can pass peer to
> net_hub_port_new() and let qemu_new_net_client() do this for you.

Sure. I'll send a v2.

> And since it was a hub, do we need to send to its netdev too inside
> net_hub_receive()?

I currently don't think so, but I'll check again...

 Thomas
