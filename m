Received: from eggs.gnu.org ([2001:4830:134:3::10]:55663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.kiszka@siemens.com>) id 1d0nft-0001rm-Sp
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 07:21:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.kiszka@siemens.com>) id 1d0nfq-0006H2-Jw
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 07:21:29 -0400
Received: from david.siemens.de ([192.35.17.14]:42457)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jan.kiszka@siemens.com>)
	id 1d0nfq-0006Go-9j
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 07:21:26 -0400
References: <286AC319A985734F985F78AFA26841F7391EF490@shsmsx102.ccr.corp.intel.com>
	<9ce5d497-c52a-23fc-a43d-ac7c895faedb@siemens.com>
	<58F722EE.7030300@intel.com>
	<d96b8097-b541-9908-8141-86267e726471@siemens.com>
	<58F72942.3030802@intel.com>
	<fcf62a96-b3fd-cffc-c784-7af46144cbb2@siemens.com>
	<58F735CF.7040404@intel.com>
	<13ccf73a-1553-ce8c-df4a-89c26cdc27b6@siemens.com>
	<58F745C9.9090106@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <abdb3dab-d96d-927a-3a63-92ade03afc5a@siemens.com>
Date: Wed, 19 Apr 2017 13:21:14 +0200
MIME-Version: 1.0
In-Reply-To: <58F745C9.9090106@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [virtio-dev] Re: Vhost-pci RFC2.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: Jailhouse <jailhouse-dev@googlegroups.com>

On 2017-04-19 13:11, Wei Wang wrote:
> On 04/19/2017 06:36 PM, Jan Kiszka wrote:
>> On 2017-04-19 12:02, Wei Wang wrote:
>>>>>>> The design presented here intends to use only one BAR to expose
>>>>>>> both TX and RX. The two VMs share an intermediate memory
>>>>>>> here, why couldn't we give the same permission to TX and RX?
>>>>>>>
>>>>>> For security and/or safety reasons: the TX side can then safely
>>>>>> prepare
>>>>>> and sign a message in-place because the RX side cannot mess around
>>>>>> with
>>>>>> it while not yet being signed (or check-summed). Saves one copy
>>>>>> from a
>>>>>> secure place into the shared memory.
>>>>> If we allow guest1 to write to RX, what safety issue would it cause=
 to
>>>>> guest2?
>>>> This way, guest1 could trick guest2, in a race condition, to sign a
>>>> modified message instead of the original one.
>>>>
>>> Just align the context that we are talking about: RX is the intermedi=
ate
>>> shared ring that guest1 uses to receive packets and guest2 uses to se=
nd
>>> packet.
>>>
>>> Seems the issue is that guest1 will receive a hacked message from RX
>>> (modified by itself). How would it affect guest2?
>> Retry: guest2 wants to send a signed/hashed message to guest1. For tha=
t
>> purpose, it starts to build that message inside the shared memory that
>> guest1 can at least read, then guest2 signs that message, also in-plac=
e.
>> If guest1 can modify the message inside the ring while guest2 has not
>> yet signed it, the result is invalid.
>>
>> Now, if guest2 is the final receiver of the message, nothing is lost,
>> guest2 just shot itself into the foot. However, if guest2 is just a
>> router (gray channel) and the message travels further, guest2 now has
>> corrupted that channel without allowing the final receive to detect
>> that. That's the scenario.
>=20
> If guest2 has been a malicious guest, I think it wouldn't make a
> difference whether we protect the shared RX or not. As a router,
> guest2 can play tricks on the messages after read it and then
> send the modified message to a third man, right?

It can swallow it, "steal" it (redirect), but it can't manipulate the
signed content without being caught, that's the idea. It's particularly
relevant for safety-critical traffic from one safe application to
another over unreliable channels, but it may also be relevant for the
integrity of messages in a secure setup.

>=20
>>>>>>>>>      Fig. 4 shows the inter-VM notification path for 2.0 (2.1 i=
s
>>>>>>>>> similar).
>>>>>>>>> The four eventfds are allocated by virtio-net, and shared with
>>>>>>>>> vhost-pci-net:
>>>>>>>>> Uses virtio-net=92s TX/RX kickfd as the vhost-pci-net=92s RX/TX=
 callfd
>>>>>>>>> Uses virtio-net=92s TX/RX callfd as the vhost-pci-net=92s RX/TX=
 kickfd
>>>>>>>>> Example of how it works:
>>>>>>>>> After packets are put into vhost-pci-net=92s TX, the driver kic=
ks
>>>>>>>>> TX,
>>>>>>>>> which
>>>>>>>>> causes the an interrupt associated with fd3 to be injected to
>>>>>>>>> virtio-net
>>>>>>>>>      The draft code of the 2.0 design is ready, and can be foun=
d
>>>>>>>>> here:
>>>>>>>>> Qemu: _https://github.com/wei-w-wang/vhost-pci-device_
>>>>>>>>> Guest driver: _https://github.com/wei-w-wang/vhost-pci-driver_
>>>>>>>>>      We tested the 2.0 implementation using the Spirent packet
>>>>>>>>> generator to transmit 64B packets, the results show that the
>>>>>>>>> throughput of vhost-pci reaches around 1.8Mpps, which is around
>>>>>>>>> two times larger than the legacy OVS+DPDK. Also, vhost-pci show=
s
>>>>>>>>> better scalability than OVS+DPDK.
>>>>>>>>>     =20
>>>>>>>> Do you have numbers for the symmetric 2.1 case as well? Or is th=
e
>>>>>>>> driver
>>>>>>>> not yet ready for that yet? Otherwise, I could try to make it wo=
rk
>>>>>>>> over
>>>>>>>> a simplistic vhost-pci 2.1 version in Jailhouse as well. That wo=
uld
>>>>>>>> give
>>>>>>>> a better picture of how much additional complexity this would me=
an
>>>>>>>> compared to our ivshmem 2.0.
>>>>>>>>
>>>>>>> Implementation of 2.1 is not ready yet. We can extend it to 2.1
>>>>>>> after
>>>>>>> the common driver frame is reviewed.
>>>>>> Can you you assess the needed effort?
>>>>>>
>>>>>> For us, this is a critical feature, because we need to decide if
>>>>>> vhost-pci can be an option at all. In fact, the "exotic ring" will=
 be
>>>>>> the only way to provide secure inter-partition communication on
>>>>>> Jailhouse.
>>>>>>
>>>>> If what is here for 2.0 is suitable to be upstream-ed, I think it w=
ill
>>>>> be easy
>>>>> to extend it to 2.1 (probably within 1 month).
>>>> Unfortunate ordering here, though. Specifically if we need to modify
>>>> existing things instead of just adding something. We will need 2.1
>>>> prior
>>>> to committing to 2.0 being the right thing.
>>>>
>>> If you want, we can get the common part of design ready first,
>>> then we can start to build on the common part at the same time.
>>> The draft code of 2.0 is ready. I can clean it up, making it easier f=
or
>>> us to continue and change.
>> Without going into details yet, a meta requirement for us will be to
>> have advanced features optional, negotiable. Basically, we would like =
to
>> minimize the interface to an equivalent of what the ivshmem 2.0 is abo=
ut
>> (there is no need for more in a safe/secure partitioning scenario). At
>> the same time, the complexity for a guest should remain low as well.
>>
>>  From past experience, the only way to ensure that is having a working
>> prototype. So I will have to look into enabling that.
>>
>=20
> OK. Looks like the ordering needs to be changed. This doesn't appear
> to be a problem to me.
>=20
> If the final design doesn't deviate a lot from what's presented here,
> I think it should be easy to get 2.1 implemented quickly.
> Let's first get the design ready, then assess the effort for
> implementation.
>=20

OK, thanks.

Jan

--=20
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
