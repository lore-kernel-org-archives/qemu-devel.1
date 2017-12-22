Received: from eggs.gnu.org ([2001:4830:134:3::10]:60105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eSHL4-0004vC-2B
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 02:01:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eSHL1-0004iK-0C
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 02:01:50 -0500
Received: from 6.mo177.mail-out.ovh.net ([46.105.51.249]:48511)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eSHL0-0004hK-MT
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 02:01:46 -0500
Received: from player779.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 0C9628F4BB
	for <qemu-devel@nongnu.org>; Fri, 22 Dec 2017 08:01:44 +0100 (CET)
References: <20171221165456.8609-1-clg@kaod.org>
	<20171222003906.GA26042@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <edb67b7f-7592-d21c-901a-1d4671903d65@kaod.org>
Date: Fri, 22 Dec 2017 08:01:41 +0100
MIME-Version: 1.0
In-Reply-To: <20171222003906.GA26042@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] target/ppc: more use of the PPC_*() macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 12/22/2017 01:39 AM, David Gibson wrote:
> On Thu, Dec 21, 2017 at 05:54:56PM +0100, C=E9dric Le Goater wrote:
>> Also introduce utilities to manipulate bitmasks (originaly from OPAL)
>> which be will be used in the model of the XIVE interrupt controller.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> Applied to ppc-for-2.12, thanks.  Unfortunately getting my tree pulled
> is held up because something is breaking on arm.

yes. I saw. I gave it a try on ppc64,pp64el,x86-64 hosts and didn't=20
see anything wrong. I also have a raspberrypi3. Would that be a good=20
candidate ?

C.
 =20

>> ---
>>  hw/ppc/pnv_lpc.c        | 10 +++++-----
>>  target/ppc/cpu.h        | 49 +++++++++++++++++++++++++++-------------=
---------
>>  target/ppc/int_helper.c |  2 +-
>>  3 files changed, 33 insertions(+), 28 deletions(-)
>>
>> diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
>> index b777b78e1837..c42b4a8f6c0f 100644
>> --- a/hw/ppc/pnv_lpc.c
>> +++ b/hw/ppc/pnv_lpc.c
>> @@ -146,13 +146,13 @@ static bool opb_write(PnvLpcController *lpc, uin=
t32_t addr, uint8_t *data,
>>      return success;
>>  }
>> =20
>> -#define ECCB_CTL_READ           (1ull << (63 - 15))
>> +#define ECCB_CTL_READ           PPC_BIT(15)
>>  #define ECCB_CTL_SZ_LSH         (63 - 7)
>> -#define ECCB_CTL_SZ_MASK        (0xfull << ECCB_CTL_SZ_LSH)
>> -#define ECCB_CTL_ADDR_MASK      0xffffffffu;
>> +#define ECCB_CTL_SZ_MASK        PPC_BITMASK(4, 7)
>> +#define ECCB_CTL_ADDR_MASK      PPC_BITMASK(32, 63)
>> =20
>> -#define ECCB_STAT_OP_DONE       (1ull << (63 - 52))
>> -#define ECCB_STAT_OP_ERR        (1ull << (63 - 52))
>> +#define ECCB_STAT_OP_DONE       PPC_BIT(52)
>> +#define ECCB_STAT_OP_ERR        PPC_BIT(52)
>>  #define ECCB_STAT_RD_DATA_LSH   (63 - 37)
>>  #define ECCB_STAT_RD_DATA_MASK  (0xffffffff << ECCB_STAT_RD_DATA_LSH)
>> =20
>> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
>> index 370b05e76ede..894fb76fabe1 100644
>> --- a/target/ppc/cpu.h
>> +++ b/target/ppc/cpu.h
>> @@ -93,6 +93,12 @@
>>  #define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_BI=
T(bs))
>>  #define PPC_BITMASK32(bs, be)   ((PPC_BIT32(bs) - PPC_BIT32(be)) | \
>>                                   PPC_BIT32(bs))
>> +#define PPC_BITMASK8(bs, be)    ((PPC_BIT8(bs) - PPC_BIT8(be)) | PPC_=
BIT8(bs))
>> +
>> +#define MASK_TO_LSH(m)          (__builtin_ffsl(m) - 1)
>> +#define GETFIELD(m, v)          (((v) & (m)) >> MASK_TO_LSH(m))
>> +#define SETFIELD(m, v, val)                             \
>> +        (((v) & ~(m)) | ((((typeof(v))(val)) << MASK_TO_LSH(m)) & (m)=
))
>> =20
>>  /********************************************************************=
*********/
>>  /* Exception vectors definitions                                     =
        */
>> @@ -2349,32 +2355,31 @@ enum {
>> =20
>>  /* Processor Compatibility mask (PCR) */
>>  enum {
>> -    PCR_COMPAT_2_05     =3D 1ull << (63-62),
>> -    PCR_COMPAT_2_06     =3D 1ull << (63-61),
>> -    PCR_COMPAT_2_07     =3D 1ull << (63-60),
>> -    PCR_COMPAT_3_00     =3D 1ull << (63-59),
>> -    PCR_VEC_DIS         =3D 1ull << (63-0), /* Vec. disable (bit NA s=
ince POWER8) */
>> -    PCR_VSX_DIS         =3D 1ull << (63-1), /* VSX disable (bit NA si=
nce POWER8) */
>> -    PCR_TM_DIS          =3D 1ull << (63-2), /* Trans. memory disable =
(POWER8) */
>> +    PCR_COMPAT_2_05     =3D PPC_BIT(62),
>> +    PCR_COMPAT_2_06     =3D PPC_BIT(61),
>> +    PCR_COMPAT_2_07     =3D PPC_BIT(60),
>> +    PCR_COMPAT_3_00     =3D PPC_BIT(59),
>> +    PCR_VEC_DIS         =3D PPC_BIT(0), /* Vec. disable (bit NA since=
 POWER8) */
>> +    PCR_VSX_DIS         =3D PPC_BIT(1), /* VSX disable (bit NA since =
POWER8) */
>> +    PCR_TM_DIS          =3D PPC_BIT(2), /* Trans. memory disable (POW=
ER8) */
>>  };
>> =20
>>  /* HMER/HMEER */
>>  enum {
>> -    HMER_MALFUNCTION_ALERT      =3D 1ull << (63 - 0),
>> -    HMER_PROC_RECV_DONE         =3D 1ull << (63 - 2),
>> -    HMER_PROC_RECV_ERROR_MASKED =3D 1ull << (63 - 3),
>> -    HMER_TFAC_ERROR             =3D 1ull << (63 - 4),
>> -    HMER_TFMR_PARITY_ERROR      =3D 1ull << (63 - 5),
>> -    HMER_XSCOM_FAIL             =3D 1ull << (63 - 8),
>> -    HMER_XSCOM_DONE             =3D 1ull << (63 - 9),
>> -    HMER_PROC_RECV_AGAIN        =3D 1ull << (63 - 11),
>> -    HMER_WARN_RISE              =3D 1ull << (63 - 14),
>> -    HMER_WARN_FALL              =3D 1ull << (63 - 15),
>> -    HMER_SCOM_FIR_HMI           =3D 1ull << (63 - 16),
>> -    HMER_TRIG_FIR_HMI           =3D 1ull << (63 - 17),
>> -    HMER_HYP_RESOURCE_ERR       =3D 1ull << (63 - 20),
>> -    HMER_XSCOM_STATUS_MASK      =3D 7ull << (63 - 23),
>> -    HMER_XSCOM_STATUS_LSH       =3D (63 - 23),
>> +    HMER_MALFUNCTION_ALERT      =3D PPC_BIT(0),
>> +    HMER_PROC_RECV_DONE         =3D PPC_BIT(2),
>> +    HMER_PROC_RECV_ERROR_MASKED =3D PPC_BIT(3),
>> +    HMER_TFAC_ERROR             =3D PPC_BIT(4),
>> +    HMER_TFMR_PARITY_ERROR      =3D PPC_BIT(5),
>> +    HMER_XSCOM_FAIL             =3D PPC_BIT(8),
>> +    HMER_XSCOM_DONE             =3D PPC_BIT(9),
>> +    HMER_PROC_RECV_AGAIN        =3D PPC_BIT(11),
>> +    HMER_WARN_RISE              =3D PPC_BIT(14),
>> +    HMER_WARN_FALL              =3D PPC_BIT(15),
>> +    HMER_SCOM_FIR_HMI           =3D PPC_BIT(16),
>> +    HMER_TRIG_FIR_HMI           =3D PPC_BIT(17),
>> +    HMER_HYP_RESOURCE_ERR       =3D PPC_BIT(20),
>> +    HMER_XSCOM_STATUS_MASK      =3D PPC_BITMASK(21, 23),
>>  };
>> =20
>>  /* Alternate Interrupt Location (AIL) */
>> diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
>> index 1c013a0ee3f1..3a50f1e1b72c 100644
>> --- a/target/ppc/int_helper.c
>> +++ b/target/ppc/int_helper.c
>> @@ -183,7 +183,7 @@ uint64_t helper_bpermd(uint64_t rs, uint64_t rb)
>>      for (i =3D 0; i < 8; i++) {
>>          int index =3D (rs >> (i*8)) & 0xFF;
>>          if (index < 64) {
>> -            if (rb & (1ull << (63-index))) {
>> +            if (rb & PPC_BIT(index)) {
>>                  ra |=3D 1 << i;
>>              }
>>          }
>=20
