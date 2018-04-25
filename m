Received: from eggs.gnu.org ([2001:4830:134:3::10]:53412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBJdG-0003b4-JL
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 08:34:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBJdB-0003Cs-Fb
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 08:34:46 -0400
References: <1524647323-6449-1-git-send-email-thuth@redhat.com>
	<1524647323-6449-3-git-send-email-thuth@redhat.com>
	<60dc9968-58fd-46e3-b471-7a0b7093ba15@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <775de9f5-7da0-45fa-da32-edceac7cf258@redhat.com>
Date: Wed, 25 Apr 2018 14:34:36 +0200
MIME-Version: 1.0
In-Reply-To: <60dc9968-58fd-46e3-b471-7a0b7093ba15@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/3] pc-bios/s390-ccw/net: Use diag308
 to reset machine before jumping to the OS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Farhan Ali <alifm@linux.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>

On 25.04.2018 14:18, Christian Borntraeger wrote:
>=20
> On 04/25/2018 11:08 AM, Thomas Huth wrote:
>=20
>> --- a/pc-bios/s390-ccw/netmain.c
>> +++ b/pc-bios/s390-ccw/netmain.c
>> @@ -283,6 +283,15 @@ void panic(const char *string)
>>      }
>>  }
>> =20
>> +void write_subsystem_identification(void)
>> +{
>> +    uint32_t *schid =3D (uint32_t *) 184;
>> +    uint32_t *zeroes =3D (uint32_t *) 188;
>> +
>> +    *schid =3D 0;         /* We must not set this for virtio-net */
>> +    *zeroes =3D 0;
>> +}
>> +
>=20
> I think we actually want to have the CCW devno of that network device
> stored. It has some value to know which CCW device we bootet from, no?

Actually, I tried that first (and it took quite some time to debug it),
but the Linux kernel then bails out quite early, without any error
message. The trace looks like this:

0x0000000007801802:  diag	%r1,%r1,776
0x0000000007801780:  larl	%r2,0x7831004
0x0000000007801786:  llgf	%r1,8
0x000000000780178c:  mvc	0(12,%r0),0(%r2)
0x0000000007801792:  br	%r1
0x0000000000000418:  bas	%r14,512
0x0000000000000200:  mvi	163,1
0x0000000000000204:  slr	%r0,%r0
0x0000000000000206:  lhi	%r1,2
0x000000000000020a:  sigp	%r1,%r0,18
0x000000000000020e:  bras	%r13,0x252
0x0000000000000252:  lmh	%r0,%r15,0(%r13)
0x0000000000000258:  sam31
0x000000000000025a:  br	%r14
0x000000000000041c:  lh	%r1,184
0x0000000000000420:  bct	%r1,1322
0x0000000000000424:  l	%r1,184
0x0000000000000428:  la	%r2,1840
0x000000000000042c:  bas	%r14,640
0x0000000000000280:  la	%r4,0(%r14)
0x0000000000000284:  la	%r3,792
0x0000000000000288:  la	%r5,804
0x000000000000028c:  la	%r6,888
0x0000000000000290:  la	%r7,20
0x0000000000000294:  st	%r2,4(%r6)
0x0000000000000298:  la	%r2,80(%r2)
0x000000000000029c:  la	%r6,8(%r6)
0x00000000000002a0:  bct	%r7,660
0x00000000000002a4:  lctl	%c6,%c6,868
0x00000000000002a8:  slr	%r2,%r2
0x00000000000002aa:  ssch	0(%r3)
0x00000000000002ae:  bne	786
0x0000000000000312:  lpsw	880
Guest crashed on cpu 0: disabled-wait
PSW: 0x000a000000000000 0x0000000000000000

That's the Lloader function in arch/s390/kernel/head.S which is failing
here, so seems like Linux tries to load from a block device in case
there is a value in 184. Thus I assume that 184 has to contain 0 in this
case.

 Thomas
