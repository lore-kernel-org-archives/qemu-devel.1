Received: from eggs.gnu.org ([2001:4830:134:3::10]:35518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dIvFn-0001VQ-Aq
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 07:05:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dIvFi-0000Zc-CB
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 07:05:27 -0400
Received: from us-smtp-delivery-101.mimecast.com ([63.128.21.101]:44988)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1dIvFi-0000ZP-31
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 07:05:22 -0400
From: Felipe Franciosi <felipe@nutanix.com>
Date: Thu, 8 Jun 2017 11:05:16 +0000
Message-ID: <7A6952CE-E364-4265-A3B9-9BAB7CA620D2@nutanix.com>
References: <20170607152825.12081-1-pbonzini@redhat.com>
	<20170607152825.12081-2-pbonzini@redhat.com>
	<CAFEAcA8CppP6YEPkGxVEyLnO=Kk1qirpGk2sh0bXedscxct8Jg@mail.gmail.com>
	<8229C6EB-56EA-475E-99D4-6D9B36B5D0A7@nutanix.com>
	<7a06506e-20ba-66b8-8c69-c500efe86301@redhat.com>
	<0281E149-DE28-4D6D-80E0-1132CAB8ABDB@nutanix.com>
	<1265195474.6852496.1496859744613.JavaMail.zimbra@redhat.com>
	<20170607212825-mutt-send-email-mst@kernel.org>
	<1191656469.6862786.1496861817272.JavaMail.zimbra@redhat.com>
	<20170608032440-mutt-send-email-mst@kernel.org>
In-Reply-To: <20170608032440-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-ID: <1DA68980DBBDAD4495C96EB79F6B235E@namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 18/33] vhost-user-scsi: Introduce
 vhost-user-scsi host device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>


> On 8 Jun 2017, at 01:31, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Wed, Jun 07, 2017 at 02:56:57PM -0400, Paolo Bonzini wrote:
>>=20
>>>> This could be documented,
>>>=20
>>> It is documented AFAIK. Pls take a look at the spec documentation.
>>=20
>> Found it now.  It's not under GET_VRING_BASE, it's under "starting
>> and stopping rings"---fair enough.
>>=20
>> In the case of vhost-user-scsi, however, QEMU also must not proceed
>> until vhost-user-scsi has drained the pending I/O---and this pending
>> I/O would be completed _after_ QEMU has sent GET_VRING_BASE.
>=20
> Weird.  Doesn't QEMU wait for response to GET_VRING_BASE?
> I think it does since we migrate the returned value.

It does and that's what I said on my first message. On GET_VRING_BASE, a vh=
ost-user-scsi backend application will stop picking up new requests and, _a=
dditionally_, quiesce the VQ (by waiting for any outstanding I/O to complet=
e or cancelling them) before returning the last_avail_idx.

Such an application therefore doesn't _necessarily_ need a drain call. Howe=
ver, we could extend vhost-user to include a message for draining (which ca=
n be implemented as "wait for pending I/O to complete" or "cancel all outst=
anding" depending on the implementation).

>=20
> Spec says:
> =09Client must only process each ring when it is started.
> so this isn't expected. I guess whoever wrote vhost-user-scsi
> understood "process" as "start processing".
> What was intended is reading or writing any part of ring.
> The used ring must not be updated after ring is stopped.
> A spec clarification might in order.
>=20
>> Is this handled by VHOST_USER_PROTOCOL_F_REPLY_ACK already?  If so,
>> migration would be denied if the server lacks that protocol feature.
>>=20
>> Paolo
>=20
> GET_VRING_BASE does not need an ack, after respoding ring should
> be stopped.

Precisely. To clarify further: the REPLY_ACK feature was added as an extens=
ion only for messages that do not demand a reply. This is to cope with a vh=
ost-user protocol deficiency where commands like SET_MEM_TABLE are asynchro=
nous. Qemu sends them and carry on executing before the backend can ACK new=
 regions were configured. The original vhost(-kernel) doesn't suffer that p=
roblem as messages are sent via an ioctl() which blocks until the backend i=
s done.

>>>> but perhaps it's best to add a START_STOP
>>>> feature and message to the vhost-user protocol?
>>>=20
>>> We just never need to GET_VRING_BASE if ring keeps going -
>>> makes no sense since base gets invalidated immediately.
>>>=20
>>>=20
>>>=20
>>>> The feature then can be optional for vhost-user-net and mandatory for
>>>> vhost-user-scsi.  When this is done we can remove .unmigratable.
>>>>=20
>>>> Thanks,
>>>>=20
>>>> Paolo
>>>=20
>>> If vhost-user-scsi does not stop the ring after responding to
>>> GET_VRING_BASE, it's just a bug that needs to be fixed.

Any backend application written for vhost-user-scsi needs to adhere to the =
spec and stop picking up new requests upon a GET_VRING_BASE. Depending on t=
he storage backend, it can decide whether to also quiesce the VQ or potenti=
ally cancel any outstanding request.

Worth noting, this is very different in networking as packets can just be d=
ropped.

Thanks,
Felipe
