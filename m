Received: from eggs.gnu.org ([2001:4830:134:3::10]:54184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eJDAq-0004Ne-Bx
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 01:45:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eJDAn-0007Zl-7a
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 01:45:48 -0500
References: <1511388334-16347-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1511388334-16347-3-git-send-email-pmorel@linux.vnet.ibm.com>
	<321b3e16-19bc-f519-4375-fe865ed64bad@redhat.com>
	<9658fc79-5925-5bc7-0aa6-d20d5ab07b84@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1efdadee-973f-5418-8f3c-b2a11e42aba2@redhat.com>
Date: Mon, 27 Nov 2017 07:45:39 +0100
MIME-Version: 1.0
In-Reply-To: <9658fc79-5925-5bc7-0aa6-d20d5ab07b84@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/7] s390x/pci: rework PCI STORE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, cohuck@redhat.com, zyimin@linux.vnet.ibm.com, agraf@suse.de, qemu-s390x@nongnu.org

On 25.11.2017 11:39, Pierre Morel wrote:
> On 23/11/2017 10:01, Thomas Huth wrote:
>> On 22.11.2017 23:05, Pierre Morel wrote:
>>> Enhance the fault detection, correction of the fault reporting.
>>>
>>> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
>>> Reviewed-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
>>> ---
>>> =C2=A0 hw/s390x/s390-pci-inst.c | 39 ++++++++++++++++++++++----------=
-------
>>> =C2=A0 1 file changed, 22 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
>>> index 3e1f1a0..930c197 100644
>>> --- a/hw/s390x/s390-pci-inst.c
>>> +++ b/hw/s390x/s390-pci-inst.c
>>> @@ -470,6 +470,12 @@ int pcistg_service_call(S390CPU *cpu, uint8_t
>>> r1, uint8_t r2)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcias =3D (env->regs[r2] >> 16) & 0xf;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 len =3D env->regs[r2] & 0xf;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 offset =3D env->regs[r2 + 1];
>>> +=C2=A0=C2=A0=C2=A0 data =3D env->regs[r1];
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (!(fh & FH_MASK_ENABLE)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 setcc(cpu, ZPCI_PCI_LS_IN=
VAL_HANDLE);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pbdev =3D s390_pci_find_dev_by_=
fh(s390_get_phb(), fh);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!pbdev) {
>>> @@ -479,12 +485,7 @@ int pcistg_service_call(S390CPU *cpu, uint8_t
>>> r1, uint8_t r2)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (pbdev->state) {
>>> -=C2=A0=C2=A0=C2=A0 case ZPCI_FS_RESERVED:
>>> -=C2=A0=C2=A0=C2=A0 case ZPCI_FS_STANDBY:
>>> -=C2=A0=C2=A0=C2=A0 case ZPCI_FS_DISABLED:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case ZPCI_FS_PERMANENT_ERROR:
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 setcc(cpu, ZPCI_PCI_LS_IN=
VAL_HANDLE);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case ZPCI_FS_ERROR:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 setcc(cpu, ZPC=
I_PCI_LS_ERR);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s390_set_statu=
s_code(env, r2, ZPCI_PCI_ST_BLOCKED);
>>
>> -EMISSINGPUBLICDOCUMENTATION
>=20
> Hi Thomas,
>=20
> I do not understand what you mean here

Not your fault, I just wanted to express that I can not really review
this part of the patch (and thus not provide a Reviewed-by) since there
is no public documentation available for zPCI :-(

 Thomas
