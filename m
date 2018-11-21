Received: from eggs.gnu.org ([2001:4830:134:3::10]:60341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gPR3T-0002Ay-VB
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 06:52:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gPR3Q-0007Qp-OY
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 06:52:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43216)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gPR3Q-0007Og-Gx
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 06:52:24 -0500
Date: Wed, 21 Nov 2018 17:22:18 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <nycvar.YSQ.7.76.1811202318190.17923@xnncv>
Message-ID: <nycvar.YSQ.7.76.1811211720220.4176@xnncv>
References: <20181120072239.512-1-ppandit@redhat.com>
	<ea6eb292-53d6-9bf0-98b9-8b53c44e77c8@linux.ibm.com>
	<nycvar.YSQ.7.76.1811202318190.17923@xnncv>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@gmail.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Cheng Feng <PSIRT@huawei.com>

  Hello Stefan, Marc,

+-- On Tue, 20 Nov 2018, P J P wrote --+
| | On 11/20/18 2:22 AM, P J P wrote:
| | > From: Prasad J Pandit <pjp@fedoraproject.org>
| | > While performing mmio device r/w operations, guest could set 'addr'
| | > parameter such that 'locty' index exceeds TPM_TIS_NUM_LOCALITIES=3D=
5
| | > after setting new 'locty' via 'tpm_tis_new_active_locality'.
| | > Add check to avoid OOB access.
| |=20
| | Do you have test code that can set the memory to such a locality or i=
s this
| | purely hypothetical at the moment?
|=20
| It's not hypothetical, reporter used tpm-emulator below
|=20
|   -> https://github.com/PeterHuewe/tpm-emulator
|=20
| with an old version of QEMU. I shared the details with Marc-Andre earli=
er=20
| today.
|=20
| | We are registering this MMIO area:
| |=20
| | =C2=A0=C2=A0=C2=A0 memory_region_init_io(&s->mmio, OBJECT(s), &tpm_ti=
s_memory_ops,
| | =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 s, "tpm-tis-mmio",
| | =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 TPM_TIS_NUM_LOCALITIES <<=20
| | TPM_TIS_LOCALITY_SHIFT);
| |=20
| | #define TPM_TIS_NUM_LOCALITIES=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5
| |=20
| | #define TPM_TIS_LOCALITY_SHIFT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 12
| |=20
| | --> 5 << 12 =3D 0x5000, thus we get memory locations [0 .. 0x4fff]
| |=20
| |=20
| | We have the following code to get from an address to the locality:
| |=20
| | static uint8_t tpm_tis_locality_from_addr(hwaddr addr)
| | {
| | =C2=A0=C2=A0=C2=A0 return (uint8_t)((addr >> TPM_TIS_LOCALITY_SHIFT) =
& 0x7);
| | }
| |=20
| | With this we would get localities of [0x0 .. 0x4] following the memor=
y
| | locations [0 .. 0x4fff] above.
|=20
|   Right. IIUC mmio r/w routines called with 'addr' value like 0x07000 m=
ay set=20
| 'locty' to > TPM_TIS_NUM_LOCALITIES. Also in mmio_write at one point,=20
| 'active_locty' is set to TPM_TIS_NO_LOCALITY(=3D0xff), which may be use=
d to set=20
| 'new_locty'.
|=20
| tpm_tis_mmio_write
|    ...
|    active_locty =3D TPM_TIS_NO_LOCALITY(=3D0xff);
|    ...
|    tpm_tis_new_active_locality(s, active_locty);
|=20
|=20
| tpm_tis_new_active_locality(TPMState *s, uint8_t new_active_locty)
|    ...
|    s->active_locty =3D new_active_locty;
|=20

To confirm,
  is the proposed patch v1 good/ack'ed for upstream?

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
