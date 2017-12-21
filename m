Received: from eggs.gnu.org ([2001:4830:134:3::10]:44498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eS6LQ-0006WU-Mq
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 14:17:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eS6LN-0007jF-5m
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 14:17:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1eS6LM-0007iz-Sa
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 14:17:25 -0500
From: Marcel Apfelbaum <marcel@redhat.com>
References: <20171208063113.20383-1-lprosek@redhat.com>
	<545999678.39861203.1512742146072.JavaMail.zimbra@redhat.com>
	<20171221155923-mutt-send-email-mst@kernel.org>
	<200a2a4e-e238-e427-d683-2e028ddeb167@redhat.com>
Message-ID: <88bff321-03c7-7320-0cd5-2b3c95473237@redhat.com>
Date: Thu, 21 Dec 2017 21:17:11 +0200
MIME-Version: 1.0
In-Reply-To: <200a2a4e-e238-e427-d683-2e028ddeb167@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] msix: don't mask already masked vectors
 on reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Ladi Prosek <lprosek@redhat.com>, qemu-devel@nongnu.org, geoff@hostfission.com, alex williamson <alex.williamson@redhat.com>

On 21/12/2017 17:08, Marcel Apfelbaum wrote:
> On 21/12/2017 16:01, Michael S. Tsirkin wrote:
>> On Fri, Dec 08, 2017 at 09:09:06AM -0500, Marcel Apfelbaum wrote:
>>>
>>>
>>> ----- Original Message -----
>>>> From: "Ladi Prosek" <lprosek@redhat.com>
>>>> To: qemu-devel@nongnu.org
>>>> Cc: marcel@redhat.com, geoff@hostfission.com, mst@redhat.com, "alex =
williamson" <alex.williamson@redhat.com>
>>>> Sent: Friday, December 8, 2017 8:31:13 AM
>>>> Subject: [PATCH v2] msix: don't mask already masked vectors on reset
>>>>
>>>> msix_mask_all() is supposed to invoke the release vector notifier if=
 the
>>>> state of the
>>>> respective vector changed from unmasked to masked. The way it's curr=
ently
>>>> called from
>>>> msix_reset(), though, may result in calling the release notifier eve=
n if the
>>>> vector
>>>> is already masked.
>>>>
>>>> 1) msix_reset() clears out the msix_cap field and the msix_table.
>>>> 2) msix_mask_all() runs with was_masked=3Dfalse for all vectors beca=
use of 1),
>>>> which
>>>> =C2=A0=C2=A0=C2=A0 results in calling the release notifier on all ve=
ctors.
>>>> 3) if msix_reset() is subsequently called again, it goes through the=
 same
>>>> steps and
>>>> =C2=A0=C2=A0=C2=A0 calls the release notifier on all vectors again.
>>>>
>>>> This commit moves msix_mask_all() up so it runs before the device st=
ate is
>>>> lost. And
>>>> it adds an assignment to msix_function_masked so that the device rem=
embers
>>>> that
>>>> MSI-X is masked.
>>>>
>>>> This is likely a low impact issue, found while debugging an already =
broken
>>>> device. It
>>>> is however easy to fix and the expectation that the use and release =
notifier
>>>> invocations
>>>> are always balanced is very natural.
>>>>
>>>> Signed-off-by: Ladi Prosek <lprosek@redhat.com>
>>>> ---
>>>>
>>>> v1->v2:
>>>> * fixed typo in commit message "or" -> "to" (Marcel)
>>>> * directly set msix_function_masked to true instead of calling
>>>> =C2=A0=C2=A0 msix_update_function_masked() (Marcel)
>>>>
>>>>
>>>> =C2=A0 hw/pci/msix.c | 3 ++-
>>>> =C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/pci/msix.c b/hw/pci/msix.c
>>>> index c944c02135..d6a4dbdb6b 100644
>>>> --- a/hw/pci/msix.c
>>>> +++ b/hw/pci/msix.c
>>>> @@ -500,11 +500,12 @@ void msix_reset(PCIDevice *dev)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msix_clear_all_vectors(dev);
>>>> +=C2=A0=C2=A0=C2=A0 msix_mask_all(dev, dev->msix_entries_nr);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev->config[dev->msix_cap + MSIX_CONT=
ROL_OFFSET] &=3D
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ~dev->wmask[d=
ev->msix_cap + MSIX_CONTROL_OFFSET];
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memset(dev->msix_table, 0, dev->msix_=
entries_nr * PCI_MSIX_ENTRY_SIZE);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memset(dev->msix_pba, 0, QEMU_ALIGN_U=
P(dev->msix_entries_nr, 64) / 8);
>>>> -=C2=A0=C2=A0=C2=A0 msix_mask_all(dev, dev->msix_entries_nr);
>>>> +=C2=A0=C2=A0=C2=A0 dev->msix_function_masked =3D true;
>>>> =C2=A0 }
>>>> =C2=A0 /* PCI spec suggests that devices make it possible for softwa=
re to configure
>>>> --=20
>>>> 2.13.6
>>>>
>>>>
>>>
>>> Thanks Ladi!
>>>
>>> Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
>>
>> This breaks make check though.
>>
>> Marcel - could you take a look please?
>>
>=20
> Sure

We have a problem with the patch.

Moving msix_mask_all before resetting the msix_table to 0
modifies behavior since we don't set the PCI_MSIX_ENTRY_CTRL_MASKBIT
for each vector anymore (the information is lost).

What we need (I think) is to run msix_mask_all again,
this time without calling msix_handle_mask_update (only setting the bit).
(I tested it and the make check passes after it)

I think is risky to use the patch for now.
Thanks,
Marcel


>=20
> Thanks,
> Marcel
