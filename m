Received: from eggs.gnu.org ([2001:4830:134:3::10]:45429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1ethTv-00076x-8Z
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 17:24:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1ethTq-0001iO-Bf
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 17:24:19 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:52692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1ethTq-0001hp-59
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 17:24:14 -0500
Date: Wed, 7 Mar 2018 23:24:09 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20180307222409.v35wtkgcd3iyfcr4@var.youpi.perso.aquilenet.fr>
References: <20180201093651.33801-1-aik@ozlabs.ru>
	<daf0cada-23d2-6dcb-3d6a-022ac646b492@ozlabs.ru>
	<3c55c2a3-a40a-86f0-8c5f-ea14826220ae@ozlabs.ru>
	<6e341ebb-bd1b-10c8-4092-e31acd5fe6b7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e341ebb-bd1b-10c8-4092-e31acd5fe6b7@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH qemu] slirp: Update forwarding IP
 address if guest receiver non-default IP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org, Jan Kiszka <jan.kiszka@siemens.com>

Hello,

Thomas Huth, on mer. 07 mars 2018 07:30:29 +0100, wrote:
> On 07.03.2018 04:39, Alexey Kardashevskiy wrote:
> > On 08/02/18 15:29, Alexey Kardashevskiy wrote:
> >> On 01/02/18 20:36, Alexey Kardashevskiy wrote:
> >>> If we run QEMU with -netdev user,id=USER0,hostfwd=tcp::2222-:22, it starts
> >>> a DHCP server and starts allocating client IPs from 10.0.2.15 so
> >>> this is what the guest normally receives. Since QEMU automatically adds
> >>> the DHCP starting address into the forwarding table, everything works.
> >>> This is the table before guest started:
> >>>
> >>> (qemu) info usernet
> >>> VLAN -1 (USER0):
> >>>   Protocol[State]    FD  Source Address  Port   Dest. Address  Port RecvQ SendQ
> >>>   TCP[HOST_FORWARD]  11               *  2222       10.0.2.15    22     0     0
> >>>
> >>> However if the guest happens to have DHCP lease (for example, 10.0.2.16),
> >>> the forwarding stops working. The guest can still reach the outer world
> >>> (which is expected).
> >>>
> >>> This updates the forwarding table when QEMU confirms the requested IP
> >>> to the guest.
> >>>
> >>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>> ---
> >>>
> >>> Does this look any useful?
> > 
> > Ping, anyone?
> 
> Maybe you should make sure to put the SLIRP maintainer on CC: ?

That would work much better to catch my attention indeed :)

I'm afraid this will be a nack. What you basically propose is "the last
DHCP lease wins". There can be setups where it is expected that it's the
first DHCP lease which should get the forward, as documented actually
("If guestaddr is not specified, its value is x.x.x.15"). In your case,
you can always set to hostfwd=tcp::2222-10.0.2.16:22. If your guest
doesn't have predictable DHCP behavior, better use a static IP
assignment rather than introducing into qemu something which looks
rather undefined to me ("last DHCP lease wins").

Samuel
