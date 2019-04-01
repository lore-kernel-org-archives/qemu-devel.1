Received: from eggs.gnu.org ([209.51.188.92]:40889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hAzHP-0007wH-OO
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 11:55:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hAzHM-0001qz-St
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 11:55:22 -0400
References: <1552494682-16788-1-git-send-email-jjherne@linux.ibm.com>
	<1552494682-16788-16-git-send-email-jjherne@linux.ibm.com>
	<fd2f7e0d-cfab-245e-8c06-9b9ed424b7e4@redhat.com>
	<2b819e81-b308-6989-1724-4d7fca7296e1@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <34ac2b7e-7e11-c5c9-f1ea-020aa52c1613@redhat.com>
Date: Mon, 1 Apr 2019 17:55:04 +0200
MIME-Version: 1.0
In-Reply-To: <2b819e81-b308-6989-1724-4d7fca7296e1@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v5 15/15] s390-bios: Support
 booting from real dasd device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jjherne@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

On 01/04/2019 17.35, Jason J. Herne wrote:
> On 3/29/19 4:33 AM, Thomas Huth wrote:
>> On 13/03/2019 17.31, Jason J. Herne wrote:
[...]
>>> +static void ipl1_fixup(void)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 Ccw0 *ccwSeek =3D (Ccw0 *) 0x08;
>>> +=C2=A0=C2=A0=C2=A0 Ccw0 *ccwSearchID =3D (Ccw0 *) 0x10;
>>> +=C2=A0=C2=A0=C2=A0 Ccw0 *ccwSearchTic =3D (Ccw0 *) 0x18;
>>> +=C2=A0=C2=A0=C2=A0 Ccw0 *ccwRead =3D (Ccw0 *) 0x20;
>>> +=C2=A0=C2=A0=C2=A0 CcwSeekData *seekData =3D (CcwSeekData *) 0x30;
>>> +=C2=A0=C2=A0=C2=A0 CcwSearchIdData *searchData =3D (CcwSearchIdData =
*) 0x38;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* move IPL1 CCWs to make room for CCWs needed to=
 locate record
>>> 2 */
>>> +=C2=A0=C2=A0=C2=A0 memcpy(ccwRead, (void *)0x08, 16);
>>
>> lowcore->ccw1 ?
>>
>=20
> All the other CCWs in this section still need to use the numeric memory
> references. I think it makes it slightly more confusing to switch just
> the one to using the struct. For this reason I prefer it the way it is,
> if you're okay with that.

Fine for me.

> ...
>>> +static void lpsw(void *psw_addr)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 PSWLegacy *pswl =3D (PSWLegacy *) psw_addr;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 pswl->mask |=3D PSW_MASK_EAMODE;=C2=A0=C2=A0 /* F=
orce z-mode */
>>> +=C2=A0=C2=A0=C2=A0 pswl->addr |=3D PSW_MASK_BAMODE;
>>> +=C2=A0=C2=A0=C2=A0 asm volatile("=C2=A0 llgtr 0,0\n llgtr 1,1\n"=C2=A0=
=C2=A0=C2=A0=C2=A0 /* Some OS's expect
>>> to be */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 "=C2=A0 llgtr 2,2\n llgtr 3,3\n"=C2=A0=C2=A0=C2=
=A0=C2=A0 /* in 32-bit mode.
>>> Clear=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 "=C2=A0 llgtr 4,4\n llgtr 5,5\n"=C2=A0=C2=A0=C2=
=A0=C2=A0 /* high part of
>>> regs to=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 "=C2=A0 llgtr 6,6\n llgtr 7,7\n"=C2=A0=C2=A0=C2=
=A0=C2=A0 /* avoid messing
>>> up=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 "=C2=A0 llgtr 8,8\n llgtr 9,9\n"=C2=A0=C2=A0=C2=
=A0=C2=A0 /* instructions
>>> that work */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 "=C2=A0 llgtr 10,10\n llgtr 11,11\n" /* in bo=
th
>>> addressing=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 "=C2=A0 llgtr 12,12\n llgtr 13,13\n" /* modes=
, like
>>> servc.=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 "=C2=A0 llgtr 14,14\n llgtr 15,15\n"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 "=C2=A0 lpsw %0\n"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 : : "Q" (*pswl) : "cc");
>>> +}
>>
>> Have you tried to use jump_to_low_kernel() already? ... it might be
>> cleaner to do the diag 0x308 reset here, too, to avoid that some part =
of
>> the machine is in an unexpected state...
>=20
> I had not tried jump_to_low_kernel() until just now. It *does* seem to
> work... and eliminates the need for the manual register clearing. I
> assume the diag 308 reset baked into the jump_to_low_kernel() is
> responsible for that? I guess switching to jump_to_low_kernel() would b=
e
> a good thing ... I'll admit I'm slightly uneasy about it since I've bee=
n
> testing my way for so long :) But jump_to_low_kernel() works for all of
> my manual test cases.

I originally used lpsw in the netboot code, too, but there was the risk
that some device activity in the background could confuse the OS kernel
later ... so Christian pointed me to the diag diag 308 reset code, which
is certainly the better way to hand over the control to the OS. Thus if
it passes your test cases, I'd say let's try to do it the better way
here right from the start and switch to jump_to_low_kernel() instead.

 Thomas
