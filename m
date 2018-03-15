Received: from eggs.gnu.org ([2001:4830:134:3::10]:48153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jack.schwartz@oracle.com>) id 1ewWAP-0002Yk-B1
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 12:55:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jack.schwartz@oracle.com>) id 1ewWAM-0000xr-5M
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 12:55:49 -0400
References: <20180314173213.18563-1-kwolf@redhat.com>
	<20180314173213.18563-2-kwolf@redhat.com>
	<4ab6eff1-f4c2-1e04-5fa8-cc71c3bf308d@oracle.com>
	<20180315155415.GA3876@localhost.localdomain>
From: Jack Schwartz <jack.schwartz@oracle.com>
Message-ID: <821bfa6e-9ad5-f486-49a1-f306696992ec@oracle.com>
Date: Thu, 15 Mar 2018 09:55:49 -0700
MIME-Version: 1.0
In-Reply-To: <20180315155415.GA3876@localhost.localdomain>
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
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, anatol.pomozov@gmail.com, ppandit@redhat.com

On 03/15/18 08:54, Kevin Wolf wrote:
> Am 15.03.2018 um 06:19 hat Jack Schwartz geschrieben:
>> Hi Kevin.
>>
>> My comments are inline...
>>
>> On 2018-03-14 10:32, Kevin Wolf wrote:
>>> The code path with a manually set mh_load_addr in the Multiboot heade=
r
>>> checks that load_end_addr <=3D load_addr, but the path where load_end=
_addr
>>> is automatically detected if 0 is given in the header misses the
>>> corresponding check.
>> 1) The code checks that load_end_addr >=3D load_addr (before letting i=
t
>> through).
>>
>> 2) load_end_addr is used only when it is read in as non-zero, so no ch=
eck is
>> needed if zero.=C2=A0 (It gets debug-printed even when zero, but is us=
ed only to
>> calculate mb_load_size and only when non-zero.)
> Oops, good point. I'll change the start of the commit message as follow=
s:
>
>      The code path with a manually set mh_load_end_addr in the Multiboo=
t
>      header checks that mh_load_end_addr >=3D mh_load_addr, but the pat=
h where
>      mh_load_end_addr is 0 in the header and therefore automatically
>      calculated from the file size misses the corresponding check.
>
> Does this look better?

mb_load_size is calculated from the file size, not mh_load_end_addr, so
I think you mean mb_load_size rather than mh_load_end_addr.=C2=A0 Do you=20
intend to say:

 =C2=A0 The code path where mh_load_end_addr is non-zero in the Multiboot
 =C2=A0 header checks that mh_load_end_addr >=3D mh_load_addr and so
 =C2=A0 mb_load_size ischecked.=C2=A0 However, mb_load_size is not checke=
d when
 =C2=A0 calculated from thefile size, when mh_load_end_addr is 0.

Also, if this is what you intend to say, would the following code change=20
be more ofwhat you want:

Remove this:

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mb_lo=
ad_size =3D kernel_file_size - mb_kernel_text_offset;
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (mb_load_size > UINT32_MAX - mh_=
load_addr) {
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_repor=
t("kernel does not fit in address space");
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(1);
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (mh_bss_end_addr) {

and instead do this a few lines further down:

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mb_kernel_s=
ize =3D mh_bss_end_addr - mh_load_addr;
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mb_ke=
rnel_size =3D mb_load_size;
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }

+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (mb_kernel_size > UINT32_MAX - m=
h_load_addr) {
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_repor=
t("kernel does not fit in address space");
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(1);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mb_debug("multiboot: header_a=
ddr =3D %#x", mh_header_addr);
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mb_debug("multiboot: load_add=
r =3D %#x", mh_load_addr);

The reason would be to include the bss area in the calculation, when
mh_bss_end_addr is non-zero.

 =C2=A0=C2=A0=C2=A0 Thanks,
 =C2=A0=C2=A0=C2=A0 Jack

>
>>> If the kernel binary size is larger than can fit in
>>> the address space after load_addr, we ended up with a kernel_size tha=
t
>>> is smaller than load_size, which means that we read the file into a t=
oo
>>> small buffer.
>>>
>>> Add a check to reject kernel files with such Multiboot headers.
>> Code itself looks fine.
>>
>> Modulo above comments:
>>  =C2=A0=C2=A0=C2=A0 Reviewed-by: Jack Schwartz <jack.schwartz@oracle.c=
om>
> Thanks for your review of the series!
>
> Kevin
