Received: from eggs.gnu.org ([2001:4830:134:3::10]:59440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d0qgM-00009U-6z
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 10:34:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d0qgH-0006Tn-AC
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 10:34:10 -0400
Received: from mga04.intel.com ([192.55.52.120]:49839)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1d0qgG-0006T5-Gj
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 10:34:05 -0400
From: "Wang, Wei W" <wei.w.wang@intel.com>
Date: Wed, 19 Apr 2017 14:33:58 +0000
Message-ID: <286AC319A985734F985F78AFA26841F7391EFB38@shsmsx102.ccr.corp.intel.com>
References: <286AC319A985734F985F78AFA26841F7391EF490@shsmsx102.ccr.corp.intel.com>
	<9ce5d497-c52a-23fc-a43d-ac7c895faedb@siemens.com>
	<58F722EE.7030300@intel.com>
	<d96b8097-b541-9908-8141-86267e726471@siemens.com>
	<58F72942.3030802@intel.com>
	<fcf62a96-b3fd-cffc-c784-7af46144cbb2@siemens.com>
	<58F735CF.7040404@intel.com>
	<13ccf73a-1553-ce8c-df4a-89c26cdc27b6@siemens.com>
	<58F745C9.9090106@intel.com>
	<abdb3dab-d96d-927a-3a63-92ade03afc5a@siemens.com>
In-Reply-To: <abdb3dab-d96d-927a-3a63-92ade03afc5a@siemens.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [virtio-dev] Re: Vhost-pci RFC2.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: Jailhouse <jailhouse-dev@googlegroups.com>

On 04/19/2017 07:21 PM, Jan Kiszka wrote:
> On 2017-04-19 13:11, Wei Wang wrote:
> > On 04/19/2017 06:36 PM, Jan Kiszka wrote:
> >> On 2017-04-19 12:02, Wei Wang wrote:
> >>>>>>> The design presented here intends to use only one BAR to expose
> >>>>>>> both TX and RX. The two VMs share an intermediate memory here,
> >>>>>>> why couldn't we give the same permission to TX and RX?
> >>>>>>>
> >>>>>> For security and/or safety reasons: the TX side can then safely
> >>>>>> prepare and sign a message in-place because the RX side cannot
> >>>>>> mess around with it while not yet being signed (or check-summed).
> >>>>>> Saves one copy from a secure place into the shared memory.
> >>>>> If we allow guest1 to write to RX, what safety issue would it
> >>>>> cause to guest2?
> >>>> This way, guest1 could trick guest2, in a race condition, to sign a
> >>>> modified message instead of the original one.
> >>>>
> >>> Just align the context that we are talking about: RX is the
> >>> intermediate shared ring that guest1 uses to receive packets and
> >>> guest2 uses to send packet.
> >>>
> >>> Seems the issue is that guest1 will receive a hacked message from RX
> >>> (modified by itself). How would it affect guest2?
> >> Retry: guest2 wants to send a signed/hashed message to guest1. For
> >> that purpose, it starts to build that message inside the shared
> >> memory that
> >> guest1 can at least read, then guest2 signs that message, also in-plac=
e.
> >> If guest1 can modify the message inside the ring while guest2 has not
> >> yet signed it, the result is invalid.
> >>
> >> Now, if guest2 is the final receiver of the message, nothing is lost,
> >> guest2 just shot itself into the foot. However, if guest2 is just a
> >> router (gray channel) and the message travels further, guest2 now has
> >> corrupted that channel without allowing the final receive to detect
> >> that. That's the scenario.
> >
> > If guest2 has been a malicious guest, I think it wouldn't make a
> > difference whether we protect the shared RX or not. As a router,
> > guest2 can play tricks on the messages after read it and then send the
> > modified message to a third man, right?
>=20
> It can swallow it, "steal" it (redirect), but it can't manipulate the sig=
ned content
> without being caught, that's the idea. It's particularly relevant for saf=
ety-critical
> traffic from one safe application to another over unreliable channels, bu=
t it may
> also be relevant for the integrity of messages in a secure setup.
>=20

OK, I see most of your story, thanks. To get to the bottom of it, is it pos=
sible to
Sign the packet before put it onto the unreliable channel (e.g. the shared =
RX),
Instead of signing in-place? If that's doable, we can have a simpler shared=
 channel. =20


Best,
Wei
