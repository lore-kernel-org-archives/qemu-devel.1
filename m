Received: from eggs.gnu.org ([2001:4830:134:3::10]:37651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gPSfz-0001YR-Kt
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 08:36:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gPSfw-0006zK-Bt
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 08:36:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38376)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
	id 1gPSfw-0006yx-3b
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 08:36:16 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wALDZLY2068733
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 08:36:14 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2nw5p4yyv6-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 08:36:14 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.ibm.com>;
	Wed, 21 Nov 2018 13:36:12 -0000
References: <20181120072239.512-1-ppandit@redhat.com>
	<ea6eb292-53d6-9bf0-98b9-8b53c44e77c8@linux.ibm.com>
	<nycvar.YSQ.7.76.1811202318190.17923@xnncv>
From: Stefan Berger <stefanb@linux.ibm.com>
Date: Wed, 21 Nov 2018 08:36:07 -0500
MIME-Version: 1.0
In-Reply-To: <nycvar.YSQ.7.76.1811202318190.17923@xnncv>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Message-Id: <00888856-0af3-7b1a-4622-3edbac9fe77f@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1] tpm: check localities index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Cheng Feng <PSIRT@huawei.com>

On 11/20/18 1:06 PM, P J P wrote:
>    Hello Stefan,
>
> +-- On Tue, 20 Nov 2018, Stefan Berger wrote --+
> | On 11/20/18 2:22 AM, P J P wrote:
> | > From: Prasad J Pandit <pjp@fedoraproject.org>
> | >
> | > While performing mmio device r/w operations, guest could set 'addr'
> | > parameter such that 'locty' index exceeds TPM_TIS_NUM_LOCALITIES=3D=
5
> | > after setting new 'locty' via 'tpm_tis_new_active_locality'.
> | > Add check to avoid OOB access.
> |
> | Do you have test code that can set the memory to such a locality or i=
s this
> | purely hypothetical at the moment?
>
> It's not hypothetical, reporter used tpm-emulator below
>
>    -> https://github.com/PeterHuewe/tpm-emulator
>
> with an old version of QEMU. I shared the details with Marc-Andre earli=
er
> today.
>
> | We are registering this MMIO area:
> |
> | =C2=A0=C2=A0=C2=A0 memory_region_init_io(&s->mmio, OBJECT(s), &tpm_ti=
s_memory_ops,
> | =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 s, "tpm-tis-mmio",
> | =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 TPM_TIS_NUM_LOCALITIES <<
> | TPM_TIS_LOCALITY_SHIFT);
> |
> | #define TPM_TIS_NUM_LOCALITIES=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5
> |
> | #define TPM_TIS_LOCALITY_SHIFT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 12
> |
> | --> 5 << 12 =3D 0x5000, thus we get memory locations [0 .. 0x4fff]
> |
> |
> | We have the following code to get from an address to the locality:
> |
> | static uint8_t tpm_tis_locality_from_addr(hwaddr addr)
> | {
> | =C2=A0=C2=A0=C2=A0 return (uint8_t)((addr >> TPM_TIS_LOCALITY_SHIFT) =
& 0x7);
> | }
> |
> | With this we would get localities of [0x0 .. 0x4] following the memor=
y
> | locations [0 .. 0x4fff] above.
>
>    Right. IIUC mmio r/w routines called with 'addr' value like 0x07000 =
may set
> 'locty' to > TPM_TIS_NUM_LOCALITIES. Also in mmio_write at one point,

offsets >=3D 0x5000 would never reach the tpm_tis emulator. If 0x7000 was=
=20
to reach it, why not 0x70000 also or any other offset ?


> 'active_locty' is set to TPM_TIS_NO_LOCALITY(=3D0xff), which may be use=
d to set
> 'new_locty'.

There's no 'new_locty'. These variables are critical, so which one do=20
you mean?

I audited all functions yesterday and my proposed patches are on the=20
mailing list. The abort related ones seem most critical but they are all=20
passed values they can handle. I do not think that an out-of-bounds=20
access can occur with the current code.


I concur with Marc's comments that an=20
'assert(TPM_TIS_IS_VALID_LOCTY(locty));' on a preceding ' uint8_t locty=20
=3D tpm_tis_locality_from_addr(addr);' isn't necessary unless something i=
n=20
the core code is seriously broken. tpm_tis covers address offsets of=20
[0x0 .. 0x4fff] from its base address , which maps to localities 0..4.

>  =20
>
> tpm_tis_mmio_write
>     ...
>     active_locty =3D TPM_TIS_NO_LOCALITY(=3D0xff);
>     ...
>     tpm_tis_new_active_locality(s, active_locty);

And this particular function can handle active_locty =3D 0xff:

static void tpm_tis_new_active_locality(TPMState *s, uint8_t=20
new_active_locty)
{
 =C2=A0=C2=A0=C2=A0 bool change =3D (s->active_locty !=3D new_active_loct=
y);
 =C2=A0=C2=A0=C2=A0 bool is_seize;
 =C2=A0=C2=A0=C2=A0 uint8_t mask;

 =C2=A0=C2=A0=C2=A0 if (change && TPM_TIS_IS_VALID_LOCTY(s->active_locty)=
) {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 is_seize =3D TPM_TIS_IS_VALID=
_LOCTY(new_active_locty) &&
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->loc[new_active_locty].access & TP=
M_TIS_ACCESS_SEIZE;

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (is_seize) {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask =
=3D ~(TPM_TIS_ACCESS_ACTIVE_LOCALITY);
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask =
=3D ~(TPM_TIS_ACCESS_ACTIVE_LOCALITY|
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TPM_TIS_ACCESS_REQUEST_U=
SE);
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* reset flags on the old act=
ive locality */
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->loc[s->active_locty].acces=
s &=3D mask;

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (is_seize) {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->lo=
c[s->active_locty].access |=3D TPM_TIS_ACCESS_BEEN_SEIZED;
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 =C2=A0=C2=A0=C2=A0 }

 =C2=A0=C2=A0=C2=A0 s->active_locty =3D new_active_locty;

 =C2=A0=C2=A0=C2=A0 trace_tpm_tis_new_active_locality(s->active_locty);

 =C2=A0=C2=A0=C2=A0 if (TPM_TIS_IS_VALID_LOCTY(new_active_locty)) {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* set flags on the new activ=
e locality */
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->loc[new_active_locty].acce=
ss |=3D TPM_TIS_ACCESS_ACTIVE_LOCALITY;
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->loc[new_active_locty].acce=
ss &=3D ~(TPM_TIS_ACCESS_REQUEST_USE |
TPM_TIS_ACCESS_SEIZE);
 =C2=A0=C2=A0=C2=A0 }

 =C2=A0=C2=A0=C2=A0 if (change) {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tpm_tis_raise_irq(s, s->activ=
e_locty,=20
TPM_TIS_INT_LOCALITY_CHANGED);
 =C2=A0=C2=A0=C2=A0 }
}

There's no out-of-bounds access possible in this function if=20
new_active_locty =3D 0xff. tpm_tis_raise_irq is protecting itself.

 =C2=A0The function may set the active_locty to 0xff, meaning there's no=20
active locality. From what I can see all functions using active_locty=20
with 0xff afterwards can handle it.


>
>
> tpm_tis_new_active_locality(TPMState *s, uint8_t new_active_locty)
>     ...
>     s->active_locty =3D new_active_locty;
>
>
> Thank you.
> --
> Prasad J Pandit / Red Hat Product Security Team
> 47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
