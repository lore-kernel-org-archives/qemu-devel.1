Received: from eggs.gnu.org ([2001:4830:134:3::10]:45661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eRfds-0004Hb-Ab
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 09:46:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eRfdn-00005Z-SO
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 09:46:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1eRfdn-0008WD-KS
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 09:46:39 -0500
References: <20171217125457.3429-1-marcel@redhat.com>
	<20171217125457.3429-5-marcel@redhat.com>
	<CAAdtpL5XgR5wvJzfLHdtdR00fm9VPU50yycG-pdeL4i8-9Hsmw@mail.gmail.com>
	<20171220060700-mutt-send-email-mst@kernel.org>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <f918b1c8-fd16-59ad-5015-6607563d6191@redhat.com>
Date: Wed, 20 Dec 2017 16:46:38 +0200
MIME-Version: 1.0
In-Reply-To: <20171220060700-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V2 4/5] pvrdma: initial implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>, Yuval Shaia <yuval.shaia@oracle.com>, Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On 20/12/2017 6:08, Michael S. Tsirkin wrote:
> On Tue, Dec 19, 2017 at 04:13:18PM -0300, Philippe Mathieu-Daud=C3=A9 w=
rote:
>> Hi Marcel, Yuval,
>>
>> On Sun, Dec 17, 2017 at 9:54 AM, Marcel Apfelbaum <marcel@redhat.com> =
wrote:
>>> From: Yuval Shaia <yuval.shaia@oracle.com>
>>>
>>> PVRDMA is the QEMU implementation of VMware's paravirtualized RDMA de=
vice.
>>> It works with its Linux Kernel driver AS IS, no need for any special =
guest
>>> modifications.
>>>
>>> While it complies with the VMware device, it can also communicate wit=
h bare
>>> metal RDMA-enabled machines and does not require an RDMA HCA in the h=
ost, it
>>> can work with Soft-RoCE (rxe).
>>>
>>> It does not require the whole guest RAM to be pinned allowing memory
>>> over-commit and, even if not implemented yet, migration support will =
be
>>> possible with some HW assistance.
>>>
>>> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
>>> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
>>> ---
>> [...]
>>>   28 files changed, 5132 insertions(+), 4 deletions(-)
>>>   create mode 100644 hw/net/pvrdma/pvrdma.h
>>>   create mode 100644 hw/net/pvrdma/pvrdma_backend.c
>>>   create mode 100644 hw/net/pvrdma/pvrdma_backend.h
>>>   create mode 100644 hw/net/pvrdma/pvrdma_backend_defs.h
>>>   create mode 100644 hw/net/pvrdma/pvrdma_cmd.c
>>>   create mode 100644 hw/net/pvrdma/pvrdma_defs.h
>>>   create mode 100644 hw/net/pvrdma/pvrdma_dev_api.h
>>>   create mode 100644 hw/net/pvrdma/pvrdma_dev_ring.c
>>>   create mode 100644 hw/net/pvrdma/pvrdma_dev_ring.h
>>>   create mode 100644 hw/net/pvrdma/pvrdma_ib_verbs.h
>>>   create mode 100644 hw/net/pvrdma/pvrdma_main.c
>>>   create mode 100644 hw/net/pvrdma/pvrdma_qp_ops.c
>>>   create mode 100644 hw/net/pvrdma/pvrdma_qp_ops.h
>>>   create mode 100644 hw/net/pvrdma/pvrdma_ring.h
>>>   create mode 100644 hw/net/pvrdma/pvrdma_rm.c
>>>   create mode 100644 hw/net/pvrdma/pvrdma_rm.h
>>>   create mode 100644 hw/net/pvrdma/pvrdma_rm_defs.h
>>>   create mode 100644 hw/net/pvrdma/pvrdma_types.h
>>>   create mode 100644 hw/net/pvrdma/pvrdma_utils.c
>>>   create mode 100644 hw/net/pvrdma/pvrdma_utils.h
>>>   create mode 100644 hw/net/pvrdma/trace-events
>> [...]
>>
>> Since we already have a hw/xenpv/ directory,
>=20
> But e.g. xen nic is under hw/net/
>=20
>> can we place these files
>> into hw/vmwarepv/ rather than hw/net/pvrdma/?
>>
>> A smarter move might be to create a hw/pv/ dir and have hw/pv/{xen,vmw=
are}.
>>
>> Regards,
>>
>> Phil.
>=20
> That's not how we layout things. We group them by function not by
> interface. Thus I think that hw/rdma/ is better.
>=20


Hi Philippe and Michael,

Thanks for the suggestion, we will move the code to hw/rdma.
Marcel
