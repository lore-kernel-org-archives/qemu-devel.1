Received: from eggs.gnu.org ([2001:4830:134:3::10]:35769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duiCm-0000Mp-Eq
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 12:50:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duiCi-0005BA-Be
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 12:50:32 -0400
References: <1495613046-6430-1-git-send-email-thuth@redhat.com>
	<5e647277-d688-071d-7def-bd8d57dd7e66@redhat.com>
	<deb2e9b4-686d-1a5a-0aba-0c404183ae9a@redhat.com>
	<6518e022-d9ef-5cf6-625b-9cbd7c106d2e@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <57408be4-6e66-7cb3-fc30-1ae43ef9d5b9@redhat.com>
Date: Wed, 20 Sep 2017 18:50:21 +0200
MIME-Version: 1.0
In-Reply-To: <6518e022-d9ef-5cf6-625b-9cbd7c106d2e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] net: Mark the 'hubport' netdev as
 deprecated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 20/09/2017 13:57, Thomas Huth wrote:
> On 20.09.2017 13:07, Paolo Bonzini wrote:
>> On 20/09/2017 09:45, Thomas Huth wrote:
>>> On 24.05.2017 10:04, Thomas Huth wrote:
>>>> The 'hubport' netdev is closely tied to the 'vlan' concept which
>>>> has been marked as deprecated in commit a2dbe1356faff3cb6 already.
>>>> Thus we should also mark the hubport netdevs as deprecated to make
>>>> the remaining users aware that they should not use this anymore.
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>
>> What is the replacement for VLANs?
>>
>> The point of hub/hubport was to implement this without needing
>> special-casing of VLANs everywhere in the net/ directory.  VLANs remai=
n
>> messy in terms of command-line expression for -net, but that's where t=
he
>> problems end.
>=20
> The QEMU "VLAN"s are a complete PITA for the users, they are causing
> confusion (e.g. https://bugs.launchpad.net/qemu/+bug/658904) and
> mis-configurations (see e.g.
> http://lists.gnu.org/archive/html/qemu-discuss/2017-08/msg00031.html).
> So I hope you agree that we should get rid of this "vlan" stuff in QEMU
> (no matter whether we continue to provide some kind of "hub" or "switch=
"
> instead or completely remove it).
>=20
>> In fact, while there are some uses of VLANs that have been replaced by
>> filters, VLANs are still needed to place 2 NICs to be on the same gues=
t
>> network without using a host bridge.  This should be a supported use
>> case for e.g. L2TP backends, and it can be important for users that
>> don't have the ability to configure a host bridge.
>=20
> I don't think that anybody really wants to connect two NICs of one
> machine to a *hub* - all the network traffic of one NIC will go to the
> other, too! That might only make sense if you want to do some basic
> network driver tests in your guest, but for every normal OS, this is
> nonsense. You normally are also not doing this with real hardware (note
> that we're talking about hubs, not switches!).

Whether it's a hub or switch is an implementation detail; currently QEMU
supports hubs, which is probably a good idea because this _is_ a
somewhat fringe use and performance isn't super important.

> While that looks at least way more logical than the "vlan" parameter, I
> really doubt that we need a *hub* within QEMU. Emulating a switch might
> make at least a little bit more sense ... but still, do we really need
> this? Do you have any real world example where somebody is using QEMU
> for a configuration like this?

If you have two NICs and SLIRP, for example, the two NICs will be in
entirely different subnets and cannot talk to each other without setting
up something like proxy ARP in the guest.

> PS: Or are you just afraid that we might finally get rid of the short
> "-net nic -net tap" syntax, which is way easier to type than its -netde=
v
> equivalent? Well, I'd say that's a different topic, and we should come
> up with a new convenience option instead before we remove the old one.

No, this is a different topic.  It's just about hubs and providing a
replacement for these four lines of net/net.c:

     if (netdev->type !=3D NET_CLIENT_DRIVER_NIC ||
         !opts->u.nic.has_netdev) {
         peer =3D net_hub_add_port(net->has_vlan ? net->vlan : 0, NULL);
     }

Regarding "-net", a replacement for "-net nic,vlan=3D0 -net tap,vlan=3D0
-net nic,vlan=3D1 -net tap,vlan=3D1" (where the connection is point-to-po=
int
and vlans are pointless) already exists using "-net nic,netdev".  If you
removed VLANs then "-net nic -net tap" could be kept as syntactic sugar,
but "-net nic -net nic -net tap" would not.  Instead, you'd have to
declare the three hubports manually and use "-net nic,netdev=3DhubportN".

Paolo
