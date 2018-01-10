Received: from eggs.gnu.org ([2001:4830:134:3::10]:42694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eZHxK-0000uP-Ln
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 10:06:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eZHxG-0000E1-IY
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 10:06:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59176)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eZHxG-0000Cr-9d
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 10:06:14 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 86392C059B81
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 15:06:13 +0000 (UTC)
References: <1515594755-12138-1-git-send-email-thuth@redhat.com>
	<0a4ce09b-560b-1ef7-492c-aa88cf805fcc@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3d066900-62c6-dfb4-20e1-2c37d3b391df@redhat.com>
Date: Wed, 10 Jan 2018 16:06:09 +0100
MIME-Version: 1.0
In-Reply-To: <0a4ce09b-560b-1ef7-492c-aa88cf805fcc@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>

On 10.01.2018 15:47, Paolo Bonzini wrote:
> On 10/01/2018 15:32, Thomas Huth wrote:
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
>>
>> To bundle up the output of multiple NICs into one socket netdev, you c=
an
>> now run QEMU with these parameters for example:
>>
>> qemu-system-ppc64 ... -netdev socket,id=3Ds1,connect=3D:11122 \
>>     -netdev hubport,hubid=3D1,id=3Dh1,netdev=3Ds1 \
>>     -netdev hubport,hubid=3D1,id=3Dh2 -device e1000,netdev=3Dh2 \
>>     -netdev hubport,hubid=3D1,id=3Dh3 -device virtio-net-pci,netdev=3D=
h3
>>
>> For using the socket netdev, you have got to start another QEMU as the
>> receiving side first, for example with network dumping enabled:
>>
>> qemu-system-x86_64 -M isapc -netdev socket,id=3Ds0,listen=3D:11122 \
>>     -device ne2k_isa,netdev=3Ds0 \
>>     -object filter-dump,id=3Df1,netdev=3Ds0,file=3D/tmp/dump.dat
>>
>> After the ppc64 guest tried to boot from both NICs, you can see in the
>> dump file (using Wireshark, for example), that the output of both NICs
>> (the e1000 and the virtio-net-pci) has been successfully transfered
>> via the socket netdev in this case.
>>
>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  See also the original discussion here for some more information:
>>  https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg05650.html
>>
>>  net/hub.c       | 23 ++++++++++++++++++++++-
>>  qapi/net.json   |  4 +++-
>>  qemu-options.hx |  8 +++++---
>>  3 files changed, 30 insertions(+), 5 deletions(-)
>>
>> diff --git a/net/hub.c b/net/hub.c
>> index 14b4eec..0638729 100644
>> --- a/net/hub.c
>> +++ b/net/hub.c
>> @@ -13,6 +13,7 @@
>>   */
>> =20
>>  #include "qemu/osdep.h"
>> +#include "qapi/error.h"
>>  #include "monitor/monitor.h"
>>  #include "net/net.h"
>>  #include "clients.h"
>> @@ -286,12 +287,32 @@ int net_init_hubport(const Netdev *netdev, const=
 char *name,
>>                       NetClientState *peer, Error **errp)
>>  {
>>      const NetdevHubPortOptions *hubport;
>> +    NetClientState *hubncs;
>> =20
>>      assert(netdev->type =3D=3D NET_CLIENT_DRIVER_HUBPORT);
>>      assert(!peer);
>>      hubport =3D &netdev->u.hubport;
>> =20
>> -    net_hub_add_port(hubport->hubid, name);
>> +    hubncs =3D net_hub_add_port(hubport->hubid, name);
>> +    if (!hubncs) {
>> +        error_setg(errp, "failed to add port to hub %i with id '%s'",
>> +                   hubport->hubid, name);
>> +        return -1;
>> +    }
>> +
>> +    if (hubport->has_netdev) {
>> +        NetClientState *hubpeer;
>> +
>> +        hubpeer =3D qemu_find_netdev(hubport->netdev);
>> +        if (!hubpeer) {
>> +            error_setg(errp, "netdev '%s' not found", hubport->netdev=
);
>> +            return -1;
>> +        }
>> +        assert(!hubncs->peer && !hubpeer->peer);
>> +        hubncs->peer =3D hubpeer;
>> +        hubpeer->peer =3D hubncs;
>> +    }
>> +
>>      return 0;
>>  }
>> =20
>> diff --git a/qapi/net.json b/qapi/net.json
>> index 4beff5d..e41e046 100644
>> --- a/qapi/net.json
>> +++ b/qapi/net.json
>> @@ -410,12 +410,14 @@
>>  # Connect two or more net clients through a software hub.
>>  #
>>  # @hubid: hub identifier number
>> +# @netdev: used to connect hub to a netdev instead of a device (since=
 2.12)
>>  #
>>  # Since: 1.2
>>  ##
>>  { 'struct': 'NetdevHubPortOptions',
>>    'data': {
>> -    'hubid':     'int32' } }
>> +    'hubid':     'int32',
>> +    '*netdev':    'str' } }
>> =20
>>  ##
>>  # @NetdevNetmapOptions:
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index 678181c..9ec4af7 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -2017,7 +2017,7 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
>>  #endif
>>      "-netdev vhost-user,id=3Dstr,chardev=3Ddev[,vhostforce=3Don|off]\=
n"
>>      "                configure a vhost-user network, backed by a char=
dev 'dev'\n"
>> -    "-netdev hubport,id=3Dstr,hubid=3Dn\n"
>> +    "-netdev hubport,id=3Dstr,hubid=3Dn[,netdev=3Dnd]\n"
>>      "                configure a hub port on QEMU VLAN 'n'\n", QEMU_A=
RCH_ALL)
>>  DEF("net", HAS_ARG, QEMU_OPTION_net,
>>      "-net nic[,vlan=3Dn][,netdev=3Dnd][,macaddr=3Dmac][,model=3Dtype]=
[,name=3Dstr][,addr=3Dstr][,vectors=3Dv]\n"
>> @@ -2445,13 +2445,15 @@ vde_switch -F -sock /tmp/myswitch
>>  qemu-system-i386 linux.img -net nic -net vde,sock=3D/tmp/myswitch
>>  @end example
>> =20
>> -@item -netdev hubport,id=3D@var{id},hubid=3D@var{hubid}
>> +@item -netdev hubport,id=3D@var{id},hubid=3D@var{hubid}[,netdev=3D@va=
r{nd}]
>> =20
>>  Create a hub port on QEMU "vlan" @var{hubid}.
>> =20
>>  The hubport netdev lets you connect a NIC to a QEMU "vlan" instead of=
 a single
>>  netdev.  @code{-net} and @code{-device} with parameter @option{vlan} =
create the
>> -required hub automatically.
>> +required hub automatically. Alternatively, you can also connect the h=
ubport
>> +to another netdev with ID @var{nd} by using the @option{netdev=3D@var=
{nd}}
>> +option.
>> =20
>>  @item -netdev vhost-user,chardev=3D@var{id}[,vhostforce=3Don|off][,qu=
eues=3Dn]
>=20
> Thank you very much!
>=20
> What is the next step for deprecating vlans?  I guess
>=20
> 1) removing the vlan property from DEFINE_NIC_PROPERTIES
>=20
> 2) removing the vlan property from -net, defaulting to vlan 0

Yes.

> 3) only allow exactly two -net options, one for the backend (creating a
> netdev) and one from the front-end (filling in nd_table)

I see multiple options here:

a) Only allow one pair of -net options. That's likely bad if there is a
board with more than one embedded NIC, since "-net" is the only way to
configure them right now.

b) Keep the current way (just without the 'vlan' parameter), so that all
-net front- and back-ends are always connected to "vlan 0". We'd stay as
compatible as possible this way, but actually this is also the way that
regularly confuses the users - they do not expect that everything ends
up on one hub!

c) Introduce a slightly new behaviour, so that if you specify -net
nic,id=3Da1 -net user,id=3Da2 -net nic,id=3Db1 -net user,id=3Db2 then QEM=
U
connects a1 with a2, and b1 with b2 directly, without a hub in between.
That's likely the behaviour that most users expect, but it's also a
slight change in behavior compared to the previous QEMU versions.

d) Finally get rid of the ugly "-net" parameter (or maybe rather limit
it to option a) and introduce a new "-n" convenience parameter instead
which can be used to configure the default/embedded NICs. With that new
convenience parameter, you don't have to specify it twice anymore like
in "-net nic -net tap", but you could simply specify "-n tap" and QEMU
then configures a tap interface for the default NIC of the current
machine for you. (I'd drop the possibility to change the NIC model here,
but in case it is still required, I'd go for something like "-n
tap,model=3De1000" or so)

Opinions?

 Thomas
