Received: from eggs.gnu.org ([2001:4830:134:3::10]:33480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jack.schwartz@oracle.com>) id 1ewYsy-0007Ib-PF
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 15:50:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jack.schwartz@oracle.com>) id 1ewYsv-0005yP-Lv
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 15:50:00 -0400
References: <20180314173213.18563-1-kwolf@redhat.com>
	<20180314173213.18563-2-kwolf@redhat.com>
	<4ab6eff1-f4c2-1e04-5fa8-cc71c3bf308d@oracle.com>
	<20180315155415.GA3876@localhost.localdomain>
	<821bfa6e-9ad5-f486-49a1-f306696992ec@oracle.com>
	<20180315171811.GF3876@localhost.localdomain>
From: Jack Schwartz <jack.schwartz@oracle.com>
Message-ID: <679a02f8-6e3c-c86b-cea1-d670b65f4081@oracle.com>
Date: Thu, 15 Mar 2018 12:50:00 -0700
MIME-Version: 1.0
In-Reply-To: <20180315171811.GF3876@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/5] multiboot: Reject kernels exceeding
 the address space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: ppandit@redhat.com, qemu-devel@nongnu.org, anatol.pomozov@gmail.com, qemu-stable@nongnu.org

On 03/15/18 10:18, Kevin Wolf wrote:
> Am 15.03.2018 um 17:55 hat Jack Schwartz geschrieben:
>> On 03/15/18 08:54, Kevin Wolf wrote:
>>> Am 15.03.2018 um 06:19 hat Jack Schwartz geschrieben:
>>>> Hi Kevin.
>>>>
>>>> My comments are inline...
>>>>
>>>> On 2018-03-14 10:32, Kevin Wolf wrote:
>>>>> The code path with a manually set mh_load_addr in the Multiboot hea=
der
>>>>> checks that load_end_addr <=3D load_addr, but the path where load_e=
nd_addr
>>>>> is automatically detected if 0 is given in the header misses the
>>>>> corresponding check.
>>>> 1) The code checks that load_end_addr >=3D load_addr (before letting=
 it
>>>> through).
>>>>
>>>> 2) load_end_addr is used only when it is read in as non-zero, so no =
check is
>>>> needed if zero.=C2=A0 (It gets debug-printed even when zero, but is =
used only to
>>>> calculate mb_load_size and only when non-zero.)
>>> Oops, good point. I'll change the start of the commit message as foll=
ows:
>>>
>>>       The code path with a manually set mh_load_end_addr in the Multi=
boot
>>>       header checks that mh_load_end_addr >=3D mh_load_addr, but the =
path where
>>>       mh_load_end_addr is 0 in the header and therefore automatically
>>>       calculated from the file size misses the corresponding check.
>>>
>>> Does this look better?
>> mb_load_size is calculated from the file size, not mh_load_end_addr, s=
o
>> I think you mean mb_load_size rather than mh_load_end_addr.=C2=A0 Do y=
ou intend
>> to say:
>>
>>  =C2=A0 The code path where mh_load_end_addr is non-zero in the Multib=
oot
>>  =C2=A0 header checks that mh_load_end_addr >=3D mh_load_addr and so
>>  =C2=A0 mb_load_size is checked.=C2=A0 However, mb_load_size is not ch=
ecked when
>>  =C2=A0 calculated from the file size, when mh_load_end_addr is 0.
> Ok, technically that's more accurate.
OK.=C2=A0 Note that I fixed a couple of missing spaces if you decide to u=
se=20
it...
>> Also, if this is what you intend to say, would the following code chan=
ge be
>> more ofwhat you want:
>>
>> Remove this:
>>
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mb=
_load_size =3D kernel_file_size - mb_kernel_text_offset;
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (mb_load_size > UINT32_MAX - =
mh_load_addr) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_re=
port("kernel does not fit in address space");
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(1);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (mh_bss_end_addr) {
>>
>> and instead do this a few lines further down:
>>
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mb_kerne=
l_size =3D mh_bss_end_addr - mh_load_addr;
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mb=
_kernel_size =3D mb_load_size;
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (mb_kernel_size > UINT32_MAX =
- mh_load_addr) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_re=
port("kernel does not fit in address space");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(1);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mb_debug("multiboot: heade=
r_addr =3D %#x", mh_header_addr);
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mb_debug("multiboot: load_=
addr =3D %#x", mh_load_addr);
>>
>> The reason would be to include the bss area in the calculation, when
>> mh_bss_end_addr is non-zero.
> Ultimately, mb_load_size > mb_kernel_size is what kills us,
Right.
>   so maybe we
> could add an assertion for that.
>
> But the reason why this condition could ever be true is the integer
> overflow in this line:
>
>      if (mh_bss_end_addr < (mh_load_addr + mb_load_size))
>
> It's generally better to check for integer overflows before they happen
> than trying to infer them from the result. In fact, your condition
> wouldn't catch the error of test scenario 9:
>
>      kernel_file_size        =3D 0x2035
>      mh_header_addr          =3D 0xfffff000
>      mh_load_addr            =3D 0xfffff000
>      mh_load_end_addr        =3D 0
>      mh_bss_end_addr         =3D 0xfffff001
>
>      mb_kernel_text_offset   =3D i - (mh_header_addr - mh_load_addr)
>                              =3D 0
>
>      mb_load_size            =3D kernel_file_size - mb_kernel_text_offs=
et
>                              =3D 0x2035
>                              > UINT32_MAX - mh_load_addr
>
>      mb_kernel_size          =3D mh_bss_end_addr - mh_load_addr
>                              =3D 1
>                              < UINT32_MAX - mh_load_addr
OK, fair enough...

One other suggestion, would be to move what you added up by one line,=20
into the "else" clause.=C2=A0 This moves the check to run only where it i=
s=20
needed.=C2=A0 This is cleaner as it does the check only where mb_load_siz=
e is=20
based on the kernel_file_size.

Reason: it doesn't make sense to do it for the "if" clause as it will=20
never be true anyway:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (mh_load_end_addr) {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mb_load_siz=
e =3D mh_load_end_addr - mh_load_addr;
 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (mb_load_size > UI=
NT32_MAX - mh_load_addr) {
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 bomb();

 =C2=A0=C2=A0=C2=A0 Thanks,
 =C2=A0=C2=A0=C2=A0 Jack
>
> Kevin
>
