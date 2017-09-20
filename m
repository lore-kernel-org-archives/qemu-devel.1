Received: from eggs.gnu.org ([2001:4830:134:3::10]:44702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1duerF-0002c8-80
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:16:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1duer9-0000r3-3w
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:16:05 -0400
References: <1495613046-6430-1-git-send-email-thuth@redhat.com>
	<5e647277-d688-071d-7def-bd8d57dd7e66@redhat.com>
	<deb2e9b4-686d-1a5a-0aba-0c404183ae9a@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6518e022-d9ef-5cf6-625b-9cbd7c106d2e@redhat.com>
Date: Wed, 20 Sep 2017 13:57:21 +0200
MIME-Version: 1.0
In-Reply-To: <deb2e9b4-686d-1a5a-0aba-0c404183ae9a@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 20.09.2017 13:07, Paolo Bonzini wrote:
> On 20/09/2017 09:45, Thomas Huth wrote:
>> On 24.05.2017 10:04, Thomas Huth wrote:
>>> The 'hubport' netdev is closely tied to the 'vlan' concept which
>>> has been marked as deprecated in commit a2dbe1356faff3cb6 already.
>>> Thus we should also mark the hubport netdevs as deprecated to make
>>> the remaining users aware that they should not use this anymore.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>=20
> What is the replacement for VLANs?
>=20
> The point of hub/hubport was to implement this without needing
> special-casing of VLANs everywhere in the net/ directory.  VLANs remain
> messy in terms of command-line expression for -net, but that's where th=
e
> problems end.

The QEMU "VLAN"s are a complete PITA for the users, they are causing
confusion (e.g. https://bugs.launchpad.net/qemu/+bug/658904) and
mis-configurations (see e.g.
http://lists.gnu.org/archive/html/qemu-discuss/2017-08/msg00031.html).
So I hope you agree that we should get rid of this "vlan" stuff in QEMU
(no matter whether we continue to provide some kind of "hub" or "switch"
instead or completely remove it).

> In fact, while there are some uses of VLANs that have been replaced by
> filters, VLANs are still needed to place 2 NICs to be on the same guest
> network without using a host bridge.  This should be a supported use
> case for e.g. L2TP backends, and it can be important for users that
> don't have the ability to configure a host bridge.

I don't think that anybody really wants to connect two NICs of one
machine to a *hub* - all the network traffic of one NIC will go to the
other, too! That might only make sense if you want to do some basic
network driver tests in your guest, but for every normal OS, this is
nonsense. You normally are also not doing this with real hardware (note
that we're talking about hubs, not switches!).

> Rather than deprecating hubport, we need a mechanism to define a hubpor=
t
> for the back-end side.  For example:
>=20
>    -netdev l2tp,...,id=3Dl2tp-backend
>    -netdev hubport,hubid=3D0,netdev=3Dl2tp-backend,id=3Dl2tp-hub
>    -netdev hubport,hubid=3D0,id=3Dnic0 -device virtio-net-pci,netdev=3D=
nic0
>    -netdev hubport,hubid=3D0,id=3Dnic1 -device virtio-net-pci,netdev=3D=
nic1
>=20
> This would normalize the topology
>=20
>    NIC      NIC      L2TP
>     |        |        |
>    hubport  hubport   |
>     |        |        |
>     '--------'--------'-------- hub
>=20
> to
>=20
>    NIC      NIC      L2TP
>     |        |        |
>    hubport  hubport  hubport
>     |        |        |
>     '--------'--------'-------- hub
>=20
> and would let us drop vlan from the command-line options.  Even
> immediately in 2.11.

While that looks at least way more logical than the "vlan" parameter, I
really doubt that we need a *hub* within QEMU. Emulating a switch might
make at least a little bit more sense ... but still, do we really need
this? Do you have any real world example where somebody is using QEMU
for a configuration like this?

 Thomas


PS: Or are you just afraid that we might finally get rid of the short
"-net nic -net tap" syntax, which is way easier to type than its -netdev
equivalent? Well, I'd say that's a different topic, and we should come
up with a new convenience option instead before we remove the old one.
