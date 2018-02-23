Received: from eggs.gnu.org ([2001:4830:134:3::10]:36066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1epAGe-0002Sk-Kg
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 05:07:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1epAGb-00040H-Ex
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 05:07:52 -0500
References: <1519241752-28083-1-git-send-email-walling@linux.vnet.ibm.com>
	<29048432-906e-5fbe-d927-0814b0c24e4d@de.ibm.com>
	<d31eb692-fd5e-7e83-1fa3-66d66f631043@linux.vnet.ibm.com>
	<25e410d1-3b6a-1178-d46c-87f247eacea9@linux.vnet.ibm.com>
	<11d66e11-7a56-c5d0-f285-2a532e85fcf8@de.ibm.com>
	<450ee50a-660b-6ec8-7de4-e5c9ce8fa26a@linux.vnet.ibm.com>
	<173adc8c-f251-73e4-9cda-f278b2483186@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f599e3d7-0c82-f841-ae18-9a6a3a010030@redhat.com>
Date: Fri, 23 Feb 2018 11:07:28 +0100
MIME-Version: 1.0
In-Reply-To: <173adc8c-f251-73e4-9cda-f278b2483186@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v8 00/13] Interactive Boot
 Menu for DASD and SCSI Guests on s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: alifm@linux.vnet.ibm.com, frankja@linux.vnet.ibm.com, cohuck@redhat.com, david@redhat.com

On 22.02.2018 20:40, Collin L. Walling wrote:
> On 02/22/2018 11:45 AM, Collin L. Walling wrote:
>> On 02/22/2018 10:44 AM, Christian Borntraeger wrote:
>>>
>>> On 02/22/2018 04:40 PM, Collin L. Walling wrote:
>>>> On 02/22/2018 07:23 AM, Viktor Mihajlovski wrote:
>>>>> On 22.02.2018 12:51, Christian Borntraeger wrote:
>>>>>> Series
>>>>>> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>>> Thanks!!!
>>>>
>>>>>>
>>>>>> menu on scsi and dasd bootmaps tested successfully.
>>>>>>
>>>>>> There is one thing that we might want to fix (can be an addon
>>>>>> patch since this is a non-customer
>>>>>> scenario (no libvirt)).
>>>>>>
>>>>>> If you start QEMU manually without a bootindex, the -boot menu=3Do=
n
>>>>>> is ignored
>>>>>> if no drive has a bootindex.
>>>>>>
>>>>>> For example:
>>>>>>
>>>>>> -drive file=3D/dev/dasda,if=3Dnone,id=3Dd1 -device
>>>>>> virtio-blk-ccw,drive=3Dd1,bootindex=3D1 -boot menu=3Don
>>>>>> does work
>>>>>>
>>>>>> -drive file=3D/dev/dasda -boot menu=3Don
>>>>>> does not
>>>>>>
>>>>>> instead it prints:
>>>>>> qemu-system-s390x: boot menu is not supported for this device type=
.
>>>>>>
>>>>>> and the boots up the default entry.
>>>>>>
>>>>> That should indeed be a separate patch, as it would move logic
>>>>> currently
>>>>> in the BIOS up to QEMU (find the first defined virtio disk and
>>>>> select it
>>>>> as boot disk).
>>>>> In fact it's more complicated than that, because it would have to
>>>>> properly account for -boot order=3D[acdn] and produce the respectiv=
e
>>>>> IPLB.
>>>>> While it makes sense, I wouldn't rush that in but rather change the
>>>>> error message to indicate that -device bootindex is needed to activ=
ate
>>>>> the menu, at least for the time being.
>>>>> [...]
>>>>>
>>>> I can look into it.=C2=A0 Theoretically, the easier fix should just
>>>> involve parsing all
>>>> of the -device commands and looking for a "bootindex=3D1" field. The
>>>> Qemu options
>>>> code already handles a bulk of this work, so it's just a matter of
>>>> putting it all
>>>> together.
>>>>
>>>> Shall I whip something up and post what I have as a reply to this
>>>> email chain?
>>> In fact, it should already be there.
>>>
>>> static bool s390_gen_initial_iplb(S390IPLState *ipl)
>>> {
>>> =C2=A0=C2=A0=C2=A0=C2=A0 DeviceState *dev_st;
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 dev_st =3D get_boot_device(0);
>>>
>>> --> if this returns 0 we have no bootindex statement anywhere and the
>>> BIOS will IPL the default
>>> disk.
>>>
>>>
>> Makes sense.=C2=A0 I'm working on making this patch look as clean as
>> possible. The fact that no boot menu
>> options present means we fallback to using zipl values for CCW being
>> tied into the switch statement
>> is making things a bit tricky. Just have to think the logic through a
>> bit.=C2=A0 Will get back to you once
>> I have something good.
>>
> This should do the trick (this can also be squished painlessly into 6/1=
3
> if desired)

Patch looks fine to me. I can either take it directly like this, or in
case you have to respin (depends on the problem that Christian reported
with the Ubuntu guest), I'm also fine if you squash it into an earlier
patch instead.

 Thomas
