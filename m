Received: from eggs.gnu.org ([2001:4830:134:3::10]:47741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1duEZ6-00022l-Lg
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 05:11:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1duEZ3-0006YV-F6
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 05:11:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58745
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1duEZ3-0006Xs-9f
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 05:11:33 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8J99aC5089690
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 05:11:32 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2d2xcjymuf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 05:11:32 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Tue, 19 Sep 2017 10:11:30 +0100
References: <20170913115029.47626-1-pasic@linux.vnet.ibm.com>
	<20170913115029.47626-2-pasic@linux.vnet.ibm.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Tue, 19 Sep 2017 11:11:27 +0200
MIME-Version: 1.0
In-Reply-To: <20170913115029.47626-2-pasic@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <63eabac3-0646-92ff-dede-d16391124061@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/4] s390x/css: introduce css data stream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On 13/09/2017 13:50, Halil Pasic wrote:
> This is a preparation for introducing handling for indirect data
> addressing and modified indirect data addressing (CCW). Here we introdu=
ce
> an interface which should make the addressing scheme transparent for th=
e
> client code. Here we implement only the basic scheme (no IDA or MIDA).
>=20
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
>   hw/s390x/css.c         | 55 +++++++++++++++++++++++++++++++++++++++++
>   include/hw/s390x/css.h | 67 +++++++++++++++++++++++++++++++++++++++++=
+++++++++
>   2 files changed, 122 insertions(+)
>=20
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index 901dc6a0f3..e8d2016563 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -783,6 +783,61 @@ static CCW1 copy_ccw_from_guest(hwaddr addr, bool =
fmt1)
>       }
>       return ret;
>   }
> +/**
> + * If out of bounds marks the stream broken. If broken returns -EINVAL=
,
> + * otherwise the requested length (may be zero)
> + */
> +static inline int cds_check_len(CcwDataStream *cds, int len)
> +{
> +    if (cds->at_byte + len > cds->count) {
> +        cds->flags |=3D CDS_F_STREAM_BROKEN;
> +    }
> +    return cds->flags & CDS_F_STREAM_BROKEN ? -EINVAL : len;
> +}
> +
> +static int ccw_dstream_rw_noflags(CcwDataStream *cds, void *buff, int =
len,
> +                                  CcwDataStreamOp op)
> +{
> +    int ret;
> +
> +    ret =3D cds_check_len(cds, len);
> +    if (ret <=3D 0) {
> +        return ret;
> +    }
> +    if (op =3D=3D CDS_OP_A) {
> +        goto incr;
> +    }
> +    ret =3D address_space_rw(&address_space_memory, cds->cda,
> +                           MEMTXATTRS_UNSPECIFIED, buff, len, op);
> +    if (ret !=3D MEMTX_OK) {
> +        cds->flags |=3D CDS_F_STREAM_BROKEN;
> +        return -EINVAL;
> +    }
> +incr:
> +    cds->at_byte +=3D len;
> +    cds->cda +=3D len;
> +    return 0;
> +}
> +
> +void ccw_dstream_init(CcwDataStream *cds, CCW1 const *ccw, ORB const *=
orb)
> +{
> +    /*
> +     * We don't support MIDA (an optional facility) yet and we
> +     * catch this earlier. Just for expressing the precondition.
> +     */
> +    g_assert(!(orb->ctrl1 & ORB_CTRL1_MASK_MIDAW));
> +    cds->flags =3D (orb->ctrl0 & ORB_CTRL0_MASK_I2K ? CDS_F_I2K : 0) |
> +                 (orb->ctrl0 & ORB_CTRL0_MASK_C64 ? CDS_F_C64 : 0) |
> +                 (ccw->flags & CCW_FLAG_IDA ? CDS_F_IDA : 0);
> +    cds->count =3D ccw->count;
> +    cds->cda_orig =3D ccw->cda;
> +    ccw_dstream_rewind(cds);
> +    if (!(cds->flags & CDS_F_IDA)) {
> +        cds->op_handler =3D ccw_dstream_rw_noflags;
> +    } else {
> +        assert(false);
> +    }
> +}
>=20
>   static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
>                                bool suspend_allowed)
> diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
> index 0653d3c9be..79acaf99b7 100644
> --- a/include/hw/s390x/css.h
> +++ b/include/hw/s390x/css.h
> @@ -75,6 +75,29 @@ typedef struct CMBE {
>       uint32_t reserved[7];
>   } QEMU_PACKED CMBE;
>=20
> +typedef enum CcwDataStreamOp {
> +    CDS_OP_R =3D 0,
> +    CDS_OP_W =3D 1,
> +    CDS_OP_A =3D 2
> +} CcwDataStreamOp;
> +
> +/** normal usage is via SuchchDev.cds instead of instantiating */
> +typedef struct CcwDataStream {
> +#define CDS_F_IDA   0x01
> +#define CDS_F_MIDA  0x02
> +#define CDS_F_I2K   0x04
> +#define CDS_F_C64   0x08
> +#define CDS_F_STREAM_BROKEN  0x80
> +    uint8_t flags;
> +    uint8_t at_idaw;
> +    uint16_t at_byte;
> +    uint16_t count;
> +    uint32_t cda_orig;
> +    int (*op_handler)(struct CcwDataStream *cds, void *buff, int len,
> +                      CcwDataStreamOp op);

I would have prefer one handler per operation instead of a operation=20
parameter.

Is it possible to change the name of the "buf" argument to "arg".
I just think of the foollowing:
If one day we do not want to gather all IDAs into a single buffer but=20
keep them split, we can have something like an array of buffers as argume=
nt.



> +    hwaddr cda;
> +} CcwDataStream;
> +
>   typedef struct SubchDev SubchDev;
>   struct SubchDev {
>       /* channel-subsystem related things: */
> @@ -92,6 +115,7 @@ struct SubchDev {
>       uint8_t ccw_no_data_cnt;
>       uint16_t migrated_schid; /* used for missmatch detection */
>       ORB orb;
> +    CcwDataStream cds;
>       /* transport-provided data: */
>       int (*ccw_cb) (SubchDev *, CCW1);
>       void (*disable_cb)(SubchDev *);
> @@ -240,4 +264,47 @@ SubchDev *css_create_sch(CssDevId bus_id, bool is_=
virtual, bool squash_mcss,
>   /** Turn on css migration */
>   void css_register_vmstate(void);
>=20
> +
> +void ccw_dstream_init(CcwDataStream *cds, CCW1 const *ccw, ORB const *=
orb);
> +
> +static inline void ccw_dstream_rewind(CcwDataStream *cds)
> +{
> +    cds->at_byte =3D 0;
> +    cds->at_idaw =3D 0;
> +    cds->cda =3D cds->cda_orig;
> +}
> +
> +static inline bool ccw_dstream_good(CcwDataStream *cds)
> +{
> +    return !(cds->flags & CDS_F_STREAM_BROKEN);
> +}
> +
> +static inline uint16_t ccw_dstream_residual_count(CcwDataStream *cds)
> +{
> +    return cds->count - cds->at_byte;
> +}
> +
> +static inline uint16_t ccw_dstream_avail(CcwDataStream *cds)
> +{
> +    return ccw_dstream_good(cds) ?  ccw_dstream_residual_count(cds) : =
0;
> +}
> +
> +static inline int ccw_dstream_advance(CcwDataStream *cds, int len)
> +{
> +    return cds->op_handler(cds, NULL, len, CDS_OP_A);
> +}
> +
> +static inline int ccw_dstream_write_buf(CcwDataStream *cds, void *buff=
, int len)
> +{
> +    return cds->op_handler(cds, buff, len, CDS_OP_W);
> +}
> +
> +static inline int ccw_dstream_read_buf(CcwDataStream *cds, void *buff,=
 int len)
> +{
> +    return cds->op_handler(cds, buff, len, CDS_OP_R);
> +}
> +
> +#define ccw_dstream_read(cds, v) ccw_dstream_read_buf((cds), &(v), siz=
eof(v))
> +#define ccw_dstream_write(cds, v) ccw_dstream_write_buf((cds), &(v), s=
izeof(v))
> +
>   #endif
>=20

otherwise, LGTM

--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
