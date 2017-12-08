Received: from eggs.gnu.org ([2001:4830:134:3::10]:47911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eNNDh-00063J-RD
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 13:18:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eNNDe-0004GI-Jm
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 13:17:57 -0500
Received: from 1.mo6.mail-out.ovh.net ([46.105.56.136]:37804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eNNDe-0004B3-6j
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 13:17:54 -0500
Received: from player735.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 3F90F1274F6
	for <qemu-devel@nongnu.org>; Fri,  8 Dec 2017 19:17:41 +0100 (CET)
References: <1512506153-8011-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1512506153-8011-2-git-send-email-stefanb@linux.vnet.ibm.com>
	<d0eba370-dfa6-cb01-2137-2a2ec8d81158@kaod.org>
	<63ec1612-5998-4303-e1d9-16a2c37ac17d@linux.vnet.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <157332b2-bfc2-a99d-0bf1-577a1dda775e@kaod.org>
Date: Fri, 8 Dec 2017 19:17:34 +0100
MIME-Version: 1.0
In-Reply-To: <63ec1612-5998-4303-e1d9-16a2c37ac17d@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] tpm_spapr: Support TPM for ppc64 using
 CRQ based interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, qemu-ppc@nongnu.org, lo1@us.ibm.com, James.Bottomley@HansenPartnership.com

On 12/06/2017 12:53 PM, Stefan Berger wrote:
> On 12/06/2017 02:26 AM, C=C3=A9dric Le Goater wrote:
>> Hello Stefan,
>>
>> Some comments below. How do we populate the device tree ?
>=20
> Patched SLOF.


Ah. Isn't that a problem ? I thought QEMU was in charge of populating
the device tree.

>>
>> Thanks,
>=20
> Thanks for the review. I will process the comments. I have some respons=
es below.
>=20
> One thing I wasn't sure about is this here:
>=20
> //k->devnode =3D tpm_spapr_devnode;
>=20
>=20
> Is a function for this needed? If not, I will remove.


If you don't define one, it won't be used. I think this is old API=20
to populate the DT which is not used anymore. To be checked I might
be wrong.

>>
>> On 12/05/2017 09:35 PM, Stefan Berger wrote:
>>> Implement support for TPM on ppc64 by implementing the vTPM CRQ
>>> interface as a frontend.
>>>
>>> The Linux vTPM driver for ppc64 works with this emulation.
>>>
>>> This emualtor also handles the TPM 2 case.
>>>
>>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>>> ---
>>> =C2=A0 hw/tpm/Makefile.objs |=C2=A0=C2=A0 1 +
>>> =C2=A0 hw/tpm/tpm_spapr.c=C2=A0=C2=A0 | 380 +++++++++++++++++++++++++=
++++++++++++++++++++++++++
>>> =C2=A0 include/sysemu/tpm.h |=C2=A0=C2=A0 3 +
>>> =C2=A0 qapi/tpm.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 5 +-
>>> =C2=A0 4 files changed, 387 insertions(+), 2 deletions(-)
>>> =C2=A0 create mode 100644 hw/tpm/tpm_spapr.c
>>>
>>> diff --git a/hw/tpm/Makefile.objs b/hw/tpm/Makefile.objs
>>> index 41f0b7a..71ea63e 100644
>>> --- a/hw/tpm/Makefile.objs
>>> +++ b/hw/tpm/Makefile.objs
>>> @@ -1,3 +1,4 @@
>>> =C2=A0 common-obj-$(CONFIG_TPM_TIS) +=3D tpm_tis.o
>>> =C2=A0 common-obj-$(CONFIG_TPM_PASSTHROUGH) +=3D tpm_passthrough.o tp=
m_util.o
>>> =C2=A0 common-obj-$(CONFIG_TPM_EMULATOR) +=3D tpm_emulator.o tpm_util=
.o
>>> +obj-$(CONFIG_PSERIES) +=3D tpm_spapr.o
>>> diff --git a/hw/tpm/tpm_spapr.c b/hw/tpm/tpm_spapr.c
>>> new file mode 100644
>>> index 0000000..909aeeb
>>> --- /dev/null
>>> +++ b/hw/tpm/tpm_spapr.c
>>> @@ -0,0 +1,380 @@
>>> +/*
>>> + * QEMU PowerPC pSeries Logical Partition (aka sPAPR) hardware Syste=
m Emulator
>>> + *
>>> + * PAPR Virtual TPM
>>> + *
>>> + * Copyright (c) 2015, 2017 IBM Corporation.
>>> + *
>>> + * Authors:
>>> + *=C2=A0=C2=A0=C2=A0 Stefan Berger <stefanb@linux.vnet.ibm.com>
>>> + *
>>> + *
>>> + * Permission is hereby granted, free of charge, to any person obtai=
ning a copy
>>> + * of this software and associated documentation files (the "Softwar=
e"), to deal
>>> + * in the Software without restriction, including without limitation=
 the rights
>>> + * to use, copy, modify, merge, publish, distribute, sublicense, and=
/or sell
>>> + * copies of the Software, and to permit persons to whom the Softwar=
e is
>>> + * furnished to do so, subject to the following conditions:
>>> + *
>>> + * The above copyright notice and this permission notice shall be in=
cluded in
>>> + * all copies or substantial portions of the Software.
>>> + *
>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, E=
XPRESS OR
>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTA=
BILITY,
>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT=
 SHALL
>>> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR OTHER
>>> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, A=
RISING FROM,
>>> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEA=
LINGS IN
>>> + * THE SOFTWARE.
>> May be reduce a bit the header.
>=20
> Which part? I derived the header from spapr_vscsi.c ...


This should be enough :

/*
 * ....
 *
 * Copyright (c) 2015-2017, IBM Corporation.
 *
 * This code is licensed under the GPL version 2 or later. See the
 * COPYING file in the top-level directory.
 */


>=20
>>
>>> + */
>>> +
>>> +#include "qemu/osdep.h"
>>> +#include "qapi/error.h"
>>> +
>>> +#include "sysemu/tpm_backend.h"
>>> +#include "tpm_int.h"
>>> +#include "tpm_util.h"
>>> +
>>> +#include "hw/ppc/spapr.h"
>>> +#include "hw/ppc/spapr_vio.h"
>>> +
>>> +#define DEBUG_SPAPR_VTPM 0
>>> +
>>> +#define DPRINTF(fmt, ...) do { \
>>> +=C2=A0=C2=A0=C2=A0 if (DEBUG_SPAPR_VTPM) { \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf(fmt, ## __VA_ARGS_=
_); \
>>> +=C2=A0=C2=A0=C2=A0 } \
>>> +} while (0)
>> traces are prefered over printfs
>>
>>> +#define VIO_SPAPR_VTPM_DEVICE(obj) \
>> I think you can trim the _DEVICE
>=20
> Not sure what you mean.

I think VIO_SPAPR_VTPM is fine.

=20
>> .
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 OBJECT_CHECK(SPAPRvTPMState, (obj), TYPE_TP=
M_SPAPR)
>>> +
>>> +typedef struct vio_crq {
>> type definitions should always use CamelCase.
>=20
> Will fix. Derived from vscsi...
>=20
>>
>>> +=C2=A0=C2=A0=C2=A0 uint8_t valid;=C2=A0 /* 0x80: cmd; 0xc0: init crq
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x81-0x83=
: CRQ message response */
>>> +=C2=A0=C2=A0=C2=A0 uint8_t msg;=C2=A0=C2=A0=C2=A0 /* see below */
>>> +=C2=A0=C2=A0=C2=A0 uint16_t len;=C2=A0=C2=A0 /* len of TPM request; =
len of TPM response */
>>> +=C2=A0=C2=A0=C2=A0 uint32_t data;=C2=A0 /* rtce_dma_handle when send=
ing TPM request */
>>> +=C2=A0=C2=A0=C2=A0 uint64_t reserved;
>>> +} vio_crq;
>>> +
>>> +typedef union tpm_spapr_crq {
>> ditto.
>>
>>> +=C2=A0=C2=A0=C2=A0 vio_crq s;
>>> +=C2=A0=C2=A0=C2=A0 uint8_t raw[sizeof(vio_crq)];
>>> +} tpm_spapr_crq;
>>> +
>>> +#define SPAPR_VTPM_VALID_INIT_CRQ_COMMAND=C2=A0 0xC0
>>> +#define SPAPR_VTPM_VALID_COMMAND=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 0x80
>>> +#define SPAPR_VTPM_MSG_RESULT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x80
>>> +
>>> +/* msg types for valid =3D SPAPR_VTPM_VALID_INIT_CRQ */
>>> +#define SPAPR_VTPM_INIT_CRQ_RESULT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 0x1
>>> +#define SPAPR_VTPM_INIT_CRQ_COMPLETE_RESULT=C2=A0 0x2
>>> +
>>> +/* msg types for valid =3D SPAPR_VTPM_VALID_CMD */
>>> +#define SPAPR_VTPM_GET_VERSION=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x1
>>> +#define SPAPR_VTPM_TPM_COMMAND=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x2
>>> +#define SPAPR_VTPM_GET_RTCE_BUFFER_SIZE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 0x3
>>> +#define SPAPR_VTPM_PREPARE_TO_SUSPEND=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 0x4
>>> +
>>> +#define MAX_BUFFER_SIZE TARGET_PAGE_SIZE
>>> +
>>> +typedef struct {
>>> +=C2=A0=C2=A0=C2=A0 VIOsPAPRDevice vdev;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 tpm_spapr_crq crq; /* track single TPM command */
>>> +
>>> +=C2=A0=C2=A0=C2=A0 uint8_t state;
>>> +#define SPAPR_VTPM_STATE_NONE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 0
>>> +#define SPAPR_VTPM_STATE_EXECUTION=C2=A0=C2=A0=C2=A0 1
>>> +#define SPAPR_VTPM_STATE_COMPLETION=C2=A0=C2=A0 2
>>> +
>>> +=C2=A0=C2=A0=C2=A0 unsigned char buffer[MAX_BUFFER_SIZE];
>>> +
>>> +=C2=A0=C2=A0=C2=A0 TPMBackendCmd cmd;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 TPMBackend *be_driver;
>>> +=C2=A0=C2=A0=C2=A0 TPMVersion be_tpm_version;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 size_t be_buffer_size;
>>> +} SPAPRvTPMState;
>>> +
>>> +static void tpm_spapr_show_buffer(const unsigned char *buffer,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t buffer_len,=
 const char *string)
>>> +{
>>> +#if DEBUG_SPAPR_VTPM
>>> +=C2=A0=C2=A0=C2=A0 size_t i, len;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 len =3D MIN(tpm_cmd_get_size(buffer), buffer_len)=
;
>>> +=C2=A0=C2=A0=C2=A0 printf("spapr_vtpm: %s length =3D %zu\n", string,=
 len);
>>> +=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < len; i++) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (i && !(i % 16)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
rintf("\n");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("%.2X ", buffer[i]=
);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 printf("\n");
>>> +#endif
>>> +}
>>> +
>>> +/*
>>> + * Send a request to the TPM.
>>> + */
>>> +static void tpm_spapr_tpm_send(SPAPRvTPMState *s)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 tpm_spapr_show_buffer(s->buffer, sizeof(s->buffer=
), "spapr_vtpm: Tx TPM");
>>> +
>>> +=C2=A0=C2=A0=C2=A0 s->state =3D SPAPR_VTPM_STATE_EXECUTION;
>>> +=C2=A0=C2=A0=C2=A0 s->cmd =3D (TPMBackendCmd) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .locty =3D 0,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .in =3D s->buffer,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .in_len =3D MIN(tpm_cmd_g=
et_size(s->buffer), sizeof(s->buffer)),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .out =3D s->buffer,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .out_len =3D sizeof(s->bu=
ffer),
>>> +=C2=A0=C2=A0=C2=A0 };
>>> +
>>> +=C2=A0=C2=A0=C2=A0 tpm_backend_deliver_request(s->be_driver, &s->cmd=
);
>>> +}
>>> +
>>> +static void tpm_spapr_got_payload(SPAPRvTPMState *s, tpm_spapr_crq *=
crq)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 long rc;
>>> +=C2=A0=C2=A0=C2=A0 DPRINTF("tpm_spapr_got_payload: crq->s.data =3D 0=
x%x=C2=A0 crq->s.len =3D %d\n",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
rq->s.data, crq->s.len);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* a max. of be_buffer_size bytes can be transpor=
ted */
>>> +=C2=A0=C2=A0=C2=A0 rc =3D spapr_vio_dma_read(&s->vdev, crq->s.data,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 s->buffer, s->be_buffer_size);
>>> +=C2=A0=C2=A0=C2=A0 if (rc) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(stderr, "tpm_spap=
r_got_payload: DMA read failure !\n");
>> may be use error_report ? or error_setg()
>>
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* let vTPM handle any malformed request */
>>> +=C2=A0=C2=A0=C2=A0 tpm_spapr_tpm_send(s);
>> why not return rc ? tpm_spapr_do_crq() is a VIO 'crq.SendFunc' handler
>> which returns hcall errors.
>>
>>> +}
>>> +
>>> +static int tpm_spapr_do_crq(struct VIOsPAPRDevice *dev, uint8_t *crq=
_data)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 SPAPRvTPMState *s =3D VIO_SPAPR_VTPM_DEVICE(dev);
>>> +=C2=A0=C2=A0=C2=A0 tpm_spapr_crq local_crq;
>>> +=C2=A0=C2=A0=C2=A0 tpm_spapr_crq *crq =3D &s->crq; /* requests only =
*/
>>> +
>>> +=C2=A0=C2=A0=C2=A0 memcpy(&local_crq.raw, crq_data, sizeof(local_crq=
.raw));
>>> +
>>> +=C2=A0=C2=A0=C2=A0 DPRINTF("VTPM: do_crq %02x %02x ...\n",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 l=
ocal_crq.raw[0], local_crq.raw[1]);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 switch (local_crq.s.valid) {
>>> +=C2=A0=C2=A0=C2=A0 case SPAPR_VTPM_VALID_INIT_CRQ_COMMAND: /* Init c=
ommand/response */
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Respond to initializat=
ion request */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (local_crq.s.msg) =
{
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case SPAPR_VTPM_INIT_CRQ_=
RESULT:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 D=
PRINTF("vtpm_do_crq: SPAPR_VTPM_INIT_CRQ_RESULT\n");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 m=
emset(local_crq.raw, 0, sizeof(local_crq.raw));
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 l=
ocal_crq.s.valid =3D SPAPR_VTPM_VALID_INIT_CRQ_COMMAND;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 l=
ocal_crq.s.msg =3D SPAPR_VTPM_INIT_CRQ_RESULT;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
papr_vio_send_crq(dev, local_crq.raw);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b=
reak;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case SPAPR_VTPM_INIT_CRQ_=
COMPLETE_RESULT:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 D=
PRINTF("vtpm_do_crq: SPAPR_VTPM_INIT_CRQ_COMP_RESULT\n");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 m=
emset(local_crq.raw, 0, sizeof(local_crq.raw));
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 l=
ocal_crq.s.valid =3D SPAPR_VTPM_VALID_INIT_CRQ_COMMAND;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 l=
ocal_crq.s.msg =3D SPAPR_VTPM_INIT_CRQ_COMPLETE_RESULT;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
papr_vio_send_crq(dev, local_crq.raw);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b=
reak;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> +=C2=A0=C2=A0=C2=A0 case SPAPR_VTPM_VALID_COMMAND: /* Payloads */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (local_crq.s.msg) =
{
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case SPAPR_VTPM_TPM_COMMA=
ND:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 D=
PRINTF("vtpm_do_crq: got TPM command payload!\n");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
f (s->state =3D=3D SPAPR_VTPM_STATE_EXECUTION)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return H_BUSY;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /=
* this crq is tracked */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 m=
emcpy(crq->raw, crq_data, sizeof(crq->raw));
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
rq->s.valid =3D be16_to_cpu(0);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
rq->s.len =3D be16_to_cpu(crq->s.len);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
rq->s.data =3D be32_to_cpu(crq->s.data);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t=
pm_spapr_got_payload(s, crq);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b=
reak;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case SPAPR_VTPM_GET_RTCE_=
BUFFER_SIZE:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 D=
PRINTF("vtpm_do_crq: resp: buffer size is %zu\n",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->be_buffer_size);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 l=
ocal_crq.s.msg |=3D SPAPR_VTPM_MSG_RESULT;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 l=
ocal_crq.s.len =3D cpu_to_be16(s->be_buffer_size);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
papr_vio_send_crq(dev, local_crq.raw);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b=
reak;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case SPAPR_VTPM_GET_VERSI=
ON:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 l=
ocal_crq.s.msg |=3D SPAPR_VTPM_MSG_RESULT;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 l=
ocal_crq.s.len =3D cpu_to_be16(0);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
witch (s->be_tpm_version) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
ase TPM_VERSION_UNSPEC:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 local_crq.s.data =3D cpu_to_be32(0);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 break;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
ase TPM_VERSION_1_2:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 local_crq.s.data =3D cpu_to_be32(1);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 break;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
ase TPM_VERSION_2_0:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 local_crq.s.data =3D cpu_to_be32(2);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 break;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 D=
PRINTF("vtpm_do_crq: resp: version %u\n",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 local_crq.s.data);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
papr_vio_send_crq(dev, local_crq.raw);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b=
reak;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case SPAPR_VTPM_PREPARE_T=
O_SUSPEND:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 D=
PRINTF("vtpm_do_crq: resp: prep to suspend\n");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 l=
ocal_crq.s.msg |=3D SPAPR_VTPM_MSG_RESULT;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
papr_vio_send_crq(dev, local_crq.raw);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b=
reak;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 D=
PRINTF("vtpm_do_crq: Unknown message type %02x\n",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 crq->s.msg);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> +=C2=A0=C2=A0=C2=A0 default:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DPRINTF("vtpm_do_crq: unk=
nown CRQ %02x %02x ...\n",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 local_crq.raw[0], local_crq.raw[1]);
>>> +=C2=A0=C2=A0=C2=A0 };
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return 0;
>> shouldn't it be H_SUCCESS.
>=20
> True. Will fix.
>=20
>>
>>> +}
>>> +
>>> +static void tpm_spapr_request_completed(TPMIf *ti)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 SPAPRvTPMState *s =3D VIO_SPAPR_VTPM_DEVICE(ti);
>>> +=C2=A0=C2=A0=C2=A0 tpm_spapr_crq *crq =3D &s->crq;
>>> +=C2=A0=C2=A0=C2=A0 uint32_t len;
>>> +=C2=A0=C2=A0=C2=A0 int rc;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 tpm_spapr_show_buffer(s->buffer, sizeof(s->buffer=
), "spapr_vtpm: Rx TPM");
>>> +
>>> +=C2=A0=C2=A0=C2=A0 s->state =3D SPAPR_VTPM_STATE_COMPLETION;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* a max. of be_buffer_size bytes can be transpor=
ted */
>>> +=C2=A0=C2=A0=C2=A0 len =3D MIN(tpm_cmd_get_size(s->buffer), s->be_bu=
ffer_size);
>>> +=C2=A0=C2=A0=C2=A0 rc =3D spapr_vio_dma_write(&s->vdev, crq->s.data,=
 s->buffer, len);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 crq->s.valid =3D SPAPR_VTPM_MSG_RESULT;
>>> +=C2=A0=C2=A0=C2=A0 crq->s.msg =3D SPAPR_VTPM_TPM_COMMAND | SPAPR_VTP=
M_MSG_RESULT;
>>> +=C2=A0=C2=A0=C2=A0 crq->s.len =3D cpu_to_be16(len);
>>> +=C2=A0=C2=A0=C2=A0 crq->s.data =3D cpu_to_be32(crq->s.data);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (rc =3D=3D 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc =3D spapr_vio_send_crq=
(&s->vdev, crq->raw);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rc) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 D=
PRINTF("%s: Error sending response\n", __func__);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 } else {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DPRINTF("%s: Error with D=
MA write\n", __func__);
>>> +=C2=A0=C2=A0=C2=A0 }
>> These DPRINTF look like errors to me.
>=20
> Will convert to error_report()
>=20
>>
>>> +}
>>> +
>>> +static int tpm_spapr_do_startup_tpm(SPAPRvTPMState *s, size_t buffer=
size)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 return tpm_backend_startup_tpm(s->be_driver, buff=
ersize);
>>> +}
>>> +
>>> +static void tpm_spapr_reset(VIOsPAPRDevice *dev)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 SPAPRvTPMState *s =3D VIO_SPAPR_VTPM_DEVICE(dev);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 s->state =3D SPAPR_VTPM_STATE_NONE;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 s->be_tpm_version =3D tpm_backend_get_tpm_version=
(s->be_driver);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 s->be_buffer_size =3D MAX(ROUND_UP(tpm_backend_ge=
t_buffer_size(s->be_driver),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
TARGET_PAGE_SIZE),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 sizeof(s->buffer));
>>> +
>>> +=C2=A0=C2=A0=C2=A0 tpm_backend_reset(s->be_driver);
>>> +=C2=A0=C2=A0=C2=A0 tpm_spapr_do_startup_tpm(s, s->be_buffer_size);
>>> +}
>>> +
>>> +static enum TPMVersion tpm_spapr_get_version(TPMIf *ti)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 SPAPRvTPMState *s =3D VIO_SPAPR_VTPM_DEVICE(ti);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (tpm_backend_had_startup_error(s->be_driver)) =
{
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return TPM_VERSION_UNSPEC=
;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return tpm_backend_get_tpm_version(s->be_driver);
>>> +}
>>> +
>>> +static const VMStateDescription vmstate_spapr_vtpm =3D {
>>> +=C2=A0=C2=A0=C2=A0 .name =3D "tpm_spapr",
>>> +=C2=A0=C2=A0=C2=A0 .unmigratable =3D 1,
>>> +};
>>> +
>>> +static Property tpm_spapr_properties[] =3D {
>>> +=C2=A0=C2=A0=C2=A0 DEFINE_SPAPR_PROPERTIES(SPAPRvTPMState, vdev),
>>> +=C2=A0=C2=A0=C2=A0 DEFINE_PROP_TPMBE("tpmdev", SPAPRvTPMState, be_dr=
iver),
>>> +=C2=A0=C2=A0=C2=A0 DEFINE_PROP_END_OF_LIST(),
>>> +};
>>> +
>>> +static void tpm_spapr_realizefn(VIOsPAPRDevice *dev, Error **errp)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 SPAPRvTPMState *s =3D VIO_SPAPR_VTPM_DEVICE(dev);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (!tpm_find()) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "at most=
 one TPM device is permitted");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> +=C2=A0=C2=A0=C2=A0 }
>>>
>> tpm_find() does not exist anymore. It was replaced by tpm_get_version(=
)
>> AFAICT in commit 5cb18b3d7bff.
>=20
> tpm_find() will be introduced here : https://github.com/stefanberger/qe=
mu-tpm/commit/9d49eb48c8dc46fede713d5d1b3525b43686a692
>=20

You should send the full patchset rebased on QEMU's head or=20
on David's 2.12 branch else this patch won't apply or compile.

>>
>>> +=C2=A0=C2=A0=C2=A0 dev->crq.SendFunc =3D tpm_spapr_do_crq;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (!s->be_driver) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "'tpmdev=
' property is required");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +}
>>> +
>>> +static void tpm_spapr_class_init(ObjectClass *klass, void *data)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);
>>> +=C2=A0=C2=A0=C2=A0 VIOsPAPRDeviceClass *k =3D VIO_SPAPR_DEVICE_CLASS=
(klass);
>>> +=C2=A0=C2=A0=C2=A0 TPMIfClass *tc =3D TPM_IF_CLASS(klass);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 k->realize =3D tpm_spapr_realizefn;
>>> +=C2=A0=C2=A0=C2=A0 k->reset =3D tpm_spapr_reset;
>>> +=C2=A0=C2=A0=C2=A0 //k->devnode =3D tpm_spapr_devnode;
>=20
> I would remove this unless this is needed. Wasn't sure.
>
>=20
>>> +=C2=A0=C2=A0=C2=A0 k->dt_name =3D "vtpm";
>>> +=C2=A0=C2=A0=C2=A0 k->dt_type =3D "IBM,vtpm";
>>> +=C2=A0=C2=A0=C2=A0 k->dt_compatible =3D "IBM,vtpm";
>>> +=C2=A0=C2=A0=C2=A0 k->signal_mask =3D 0x00000001;
>>> +=C2=A0=C2=A0=C2=A0 set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>>> +=C2=A0=C2=A0=C2=A0 dc->props =3D tpm_spapr_properties;
>>> +=C2=A0=C2=A0=C2=A0 k->rtce_window_size =3D 0x10000000;
>>> +=C2=A0=C2=A0=C2=A0 dc->vmsd =3D &vmstate_spapr_vtpm;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 tc->model =3D TPM_MODEL_TPM_SPAPR;
>>> +=C2=A0=C2=A0=C2=A0 tc->get_version =3D tpm_spapr_get_version;
>>> +=C2=A0=C2=A0=C2=A0 tc->request_completed =3D tpm_spapr_request_compl=
eted;
>>> +}
>>> +
>>> +static const TypeInfo tpm_spapr_info =3D {
>>> +=C2=A0=C2=A0=C2=A0 .name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 =3D TYPE_TPM_SPAPR,
>>> +=C2=A0=C2=A0=C2=A0 .parent=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 =3D TYPE_VIO_SPAPR_DEVICE,
>>> +=C2=A0=C2=A0=C2=A0 .instance_size =3D sizeof(SPAPRvTPMState),
>>> +=C2=A0=C2=A0=C2=A0 .class_init=C2=A0=C2=A0=C2=A0 =3D tpm_spapr_class=
_init,
>>> +=C2=A0=C2=A0=C2=A0 .interfaces =3D (InterfaceInfo[]) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { TYPE_TPM_IF },
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { }
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +};
>>> +
>>> +static void tpm_spapr_register_types(void)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 type_register_static(&tpm_spapr_info);
>>> +}
>>> +
>>> +type_init(tpm_spapr_register_types)
>>> diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
>>> index 852e026..afefadd 100644
>>> --- a/include/sysemu/tpm.h
>>> +++ b/include/sysemu/tpm.h
>>> @@ -46,9 +46,12 @@ typedef struct TPMIfClass {
>>> =C2=A0 } TPMIfClass;
>>> =C2=A0 =C2=A0 #define TYPE_TPM_TIS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "tpm-tis"
>>> +#define TYPE_TPM_SPAPR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "tpm-spapr"
>>> =C2=A0 =C2=A0 #define TPM_IS_TIS(chr)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 object_dynamic_cast(OBJECT(chr), TYPE_=
TPM_TIS)
>>> +#define TPM_IS_SPAPR(chr)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>>> +=C2=A0=C2=A0=C2=A0 object_dynamic_cast(OBJECT(chr), TYPE_TPM_SPAPR)
>>> =C2=A0 =C2=A0 /* returns NULL unless there is exactly one TPM device =
*/
>>> =C2=A0 static inline TPMIf *tpm_find(void)
>>> diff --git a/qapi/tpm.json b/qapi/tpm.json
>>> index 7093f26..dfa6a32 100644
>>> --- a/qapi/tpm.json
>>> +++ b/qapi/tpm.json
>>> @@ -11,10 +11,11 @@
>>> =C2=A0 # An enumeration of TPM models
>>> =C2=A0 #
>>> =C2=A0 # @tpm-tis: TPM TIS model
>>> +# @tpm-spapr: TPM PAPR model (since 2.12)
>>> =C2=A0 #
>>> =C2=A0 # Since: 1.5
>>> =C2=A0 ##
>>> -{ 'enum': 'TpmModel', 'data': [ 'tpm-tis' ] }
>>> +{ 'enum': 'TpmModel', 'data': [ 'tpm-tis', 'tpm-spapr' ] }
>>> =C2=A0 =C2=A0 ##
>>> =C2=A0 # @query-tpm-models:
>>> @@ -28,7 +29,7 @@
>>> =C2=A0 # Example:
>>> =C2=A0 #
>>> =C2=A0 # -> { "execute": "query-tpm-models" }
>>> -# <- { "return": [ "tpm-tis" ] }
>>> +# <- { "return": [ "tpm-tis", "tpm-spapr" ] }
>>> =C2=A0 #
>>> =C2=A0 ##
>>> =C2=A0 { 'command': 'query-tpm-models', 'returns': ['TpmModel'] }
>>>
>=20
