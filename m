Received: from eggs.gnu.org ([2001:4830:134:3::10]:33139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eMpkP-0004px-Ql
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 01:33:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eMpkK-0006Xi-Sw
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 01:33:29 -0500
References: <20171108165422.46267-1-pasic@linux.vnet.ibm.com>
	<20171108165422.46267-2-pasic@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e2e2ae84-e04a-df4f-50bb-328768a5464e@redhat.com>
Date: Thu, 7 Dec 2017 07:33:19 +0100
MIME-Version: 1.0
In-Reply-To: <20171108165422.46267-2-pasic@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 1/3] s390x/ccs: add ccw-testdev
 emulated device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: qemu-s390x@nongnu.org, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

 Hi Halil,

just a high-level review since I'm not a CSS expert...

On 08.11.2017 17:54, Halil Pasic wrote:
[...]
> I'm not really happy with the side effects of moving it to hw/misc, whi=
ch
> ain't s390x specific.

Sorry, I'm missing the context - why can't this go into hw/s390x/ ?

> I've pretty much bounced off the build system, so
> I would really appreciate some help here. Currently you have to say you
> want it when you do make or it won't get compiled into your qemu. IMHO
> this device only makes sense for testing and should not be rutinely
> shipped in production builds. That is why I did not touch
> default-configs/s390x-softmmu.mak.

You could at least add a CONFIG_CCW_TESTDEV=3Dn there, but I think the
normal QEMU policy is to enable everything by default to avoid that code
is bit-rotting, so I think "=3Dy" is also OK there (distros can then stil=
l
disable it in downstream if they want).

> I think, I have the most problematic places marked with a  TODO
> comment in the code.
>=20
> Happy reviewing and looking forward to your comments.
> ---
>  hw/misc/Makefile.objs |   1 +
>  hw/misc/ccw-testdev.c | 284 ++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  hw/misc/ccw-testdev.h |  18 ++++
>  3 files changed, 303 insertions(+)
>  create mode 100644 hw/misc/ccw-testdev.c
>  create mode 100644 hw/misc/ccw-testdev.h
>=20
> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> index 19202d90cf..b41314d096 100644
> --- a/hw/misc/Makefile.objs
> +++ b/hw/misc/Makefile.objs
> @@ -61,3 +61,4 @@ obj-$(CONFIG_AUX) +=3D auxbus.o
>  obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_scu.o aspeed_sdmc.o
>  obj-y +=3D mmio_interface.o
>  obj-$(CONFIG_MSF2) +=3D msf2-sysreg.o
> +obj-$(CONFIG_CCW_TESTDEV) +=3D ccw-testdev.o
> diff --git a/hw/misc/ccw-testdev.c b/hw/misc/ccw-testdev.c
> new file mode 100644
> index 0000000000..39cf46e90d
> --- /dev/null
> +++ b/hw/misc/ccw-testdev.c
> @@ -0,0 +1,284 @@

Please add a short description of the device in a comment here.

And don't you also want to add some license statement and/or author
information here?

> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/module.h"
> +#include "ccw-testdev.h"
> +#include "hw/s390x/css.h"
> +#include "hw/s390x/css-bridge.h"
> +#include "hw/s390x/3270-ccw.h"
> +#include "exec/address-spaces.h"
> +#include "hw/s390x/s390-virtio-hcall.h"
> +#include <error.h>
> +
> +typedef struct CcwTestDevDevice {
> +    CcwDevice parent_obj;
> +    uint16_t cu_type;
> +    uint8_t chpid_type;
> +    uint32_t op_mode;
> +    bool op_mode_locked;
> +    struct {
> +        uint32_t ring[4];
> +        unsigned int next;
> +    } fib;
> +} CcwTestDevDevice;
> +
> +typedef struct CcwTestDevClass {
> +    CCWDeviceClass parent_class;
> +    DeviceRealize parent_realize;
> +} CcwTestDevClass;
> +
> +#define TYPE_CCW_TESTDEV "ccw-testdev"
> +
> +#define CCW_TESTDEV(obj) \
> +     OBJECT_CHECK(CcwTestDevDevice, (obj), TYPE_CCW_TESTDEV)
> +#define CCW_TESTDEV_CLASS(klass) \
> +     OBJECT_CLASS_CHECK(CcwTestDevClass, (klass), TYPE_CCW_TESTDEV)
> +#define CCW_TESTDEV_GET_CLASS(obj) \
> +     OBJECT_GET_CLASS(CcwTestDevClass, (obj), TYPE_CCW_TESTDEV)
> +
> +typedef int (*ccw_cb_t)(SubchDev *, CCW1);
> +static ccw_cb_t get_ccw_cb(CcwTestDevOpMode op_mode);
> +
> +/* TODO This is the in-band set mode. We may want to get rid of it. */
> +static int set_mode_ccw(SubchDev *sch)
> +{
> +    CcwTestDevDevice *d =3D sch->driver_data;
> +    const char pattern[] =3D CCW_TST_SET_MODE_INCANTATION;
> +    char buf[sizeof(pattern)];
> +    int ret;
> +    uint32_t tmp;
> +
> +    if (d->op_mode_locked) {
> +        return -EINVAL;
> +    }
> +
> +    ret =3D ccw_dstream_read(&sch->cds, buf);
> +    if (ret) {
> +        return ret;
> +    }
> +    ret =3D strncmp(buf, pattern, sizeof(pattern));
> +    if (ret) {
> +        return 0; /* ignore malformed request -- maybe fuzzing */
> +    }
> +    ret =3D ccw_dstream_read(&sch->cds, tmp);
> +    if (ret) {
> +        return ret;
> +    }
> +    be32_to_cpus(&tmp);
> +    if (tmp >=3D OP_MODE_MAX) {
> +        return -EINVAL;
> +    }
> +    d->op_mode =3D tmp;
> +    sch->ccw_cb =3D get_ccw_cb(d->op_mode);
> +    return ret;
> +}
> +
> +

Please remove one empty line above.

> +static unsigned int abs_to_ring(unsigned int i)

IMHO a short comment above that function would be nice. If I just read
"abs_to_ring(unsigned int i)" I have a hard time to figure out what this
means.

> +{
> +    return i & 0x3;
> +}
> +
> +static int  ccw_testdev_write_fib(SubchDev *sch)
> +{
> +    CcwTestDevDevice *d =3D sch->driver_data;
> +    bool is_fib =3D true;
> +    uint32_t tmp;
> +    int ret =3D 0;
> +
> +    d->fib.next =3D 0;
> +    while (ccw_dstream_avail(&sch->cds) > 0) {
> +        ret =3D ccw_dstream_read(&sch->cds, tmp);
> +        if (ret) {
> +            error(0, -ret, "fib");

Where does this error() function come from? I failed to spot its location=
...

> +            break;
> +        }
> +        d->fib.ring[abs_to_ring(d->fib.next)] =3D cpu_to_be32(tmp);
> +        if (d->fib.next > 2) {
> +            tmp =3D (d->fib.ring[abs_to_ring(d->fib.next - 1)]
> +                  + d->fib.ring[abs_to_ring(d->fib.next - 2)]);
> +            is_fib =3D tmp =3D=3D  d->fib.ring[abs_to_ring(d->fib.next=
)];
> +            if (!is_fib) {
> +                break;
> +            }
> +        }
> +        ++(d->fib.next);

I'd prefer to do this without braces, e.g.:

	   d->fib.next++;

> +    }
> +    if (!is_fib) {
> +        sch->curr_status.scsw.ctrl &=3D ~SCSW_ACTL_START_PEND;
> +        sch->curr_status.scsw.ctrl |=3D SCSW_STCTL_PRIMARY |
> +                                      SCSW_STCTL_SECONDARY |
> +                                      SCSW_STCTL_ALERT |
> +                                      SCSW_STCTL_STATUS_PEND;
> +        sch->curr_status.scsw.count =3D ccw_dstream_residual_count(&sc=
h->cds);
> +        sch->curr_status.scsw.cpa =3D sch->channel_prog + 8;
> +        sch->curr_status.scsw.dstat =3D  SCSW_DSTAT_UNIT_EXCEP;
> +        return -EIO;
> +    }
> +    return ret;
> +}
> +
> +static int  ccw_testdev_read_fib(SubchDev *sch)
> +{
> +    uint32_t l =3D 0, m =3D 1, n =3D 0;
> +    int ret =3D 0;
> +
> +    while (ccw_dstream_avail(&sch->cds) > 0) {
> +        n =3D m + l;
> +        l =3D m;
> +        m =3D n;
> +        ret =3D ccw_dstream_read(&sch->cds, n);
> +    }
> +    return ret;
> +}
> +
> +static int ccw_testdev_ccw_cb_mode_fib(SubchDev *sch, CCW1 ccw)
> +{
> +    switch (ccw.cmd_code) {
> +    case CCW_CMD_READ:
> +        ccw_testdev_read_fib(sch);
> +        break;
> +    case CCW_CMD_WRITE:
> +        return ccw_testdev_write_fib(sch);
> +    case CCW_CMD_CTL_MODE:
> +        return set_mode_ccw(sch);
> +    default:
> +        return -EINVAL;
> +    }
> +    return 0;
> +}
> +
> +static int ccw_testdev_ccw_cb_mode_nop(SubchDev *sch, CCW1 ccw)
> +{
> +    CcwTestDevDevice *d =3D sch->driver_data;
> +
> +    if (!d->op_mode_locked && ccw.cmd_code =3D=3D CCW_CMD_CTL_MODE) {
> +        return set_mode_ccw(sch);
> +    }
> +    return 0;
> +}
> +
> +static ccw_cb_t get_ccw_cb(CcwTestDevOpMode op_mode)
> +{
> +    switch (op_mode) {
> +    case OP_MODE_FIB:
> +        return ccw_testdev_ccw_cb_mode_fib;
> +    case OP_MODE_NOP:
> +    default:
> +        return ccw_testdev_ccw_cb_mode_nop;

Do we really want to use "nop" for unknown modes? Or should there rather
be a ccw_testdev_ccw_cb_mode_error instead, too?

> +    }
> +}
> +
> +static void ccw_testdev_realize(DeviceState *ds, Error **errp)
> +{
> +    uint16_t chpid;
> +    CcwTestDevDevice *dev =3D CCW_TESTDEV(ds);
> +    CcwTestDevClass *ctc =3D CCW_TESTDEV_GET_CLASS(dev);
> +    CcwDevice *cdev =3D CCW_DEVICE(ds);
> +    BusState *qbus =3D qdev_get_parent_bus(ds);
> +    VirtualCssBus *cbus =3D VIRTUAL_CSS_BUS(qbus);
> +    SubchDev *sch;
> +    Error *err =3D NULL;
> +
> +    sch =3D css_create_sch(cdev->devno, true, cbus->squash_mcss, errp)=
;
> +    if (!sch) {
> +        return;
> +    }
> +
> +    sch->driver_data =3D dev;
> +    cdev->sch =3D sch;
> +    chpid =3D css_find_free_chpid(sch->cssid);
> +
> +    if (chpid > MAX_CHPID) {
> +        error_setg(&err, "No available chpid to use.");
> +        goto out_err;
> +    }
> +
> +    sch->id.reserved =3D 0xff;
> +    sch->id.cu_type =3D dev->cu_type;
> +    css_sch_build_virtual_schib(sch, (uint8_t)chpid,
> +                                dev->chpid_type);
> +    sch->ccw_cb =3D get_ccw_cb(dev->op_mode);
> +    sch->do_subchannel_work =3D do_subchannel_work_virtual;
> +
> +

Please remove superfluous empty line.

> +    ctc->parent_realize(ds, &err);
> +    if (err) {
> +        goto out_err;
> +    }
> +
> +    css_generate_sch_crws(sch->cssid, sch->ssid, sch->schid,
> +                          ds->hotplugged, 1);
> +    return;
> +
> +out_err:
> +    error_propagate(errp, err);
> +    css_subch_assign(sch->cssid, sch->ssid, sch->schid, sch->devno, NU=
LL);
> +    cdev->sch =3D NULL;
> +    g_free(sch);
> +}
> +
> +static Property ccw_testdev_properties[] =3D {
> +    DEFINE_PROP_UINT16("cu_type", CcwTestDevDevice, cu_type,
> +                        0xfffe), /* only numbers used for real HW */
> +    DEFINE_PROP_UINT8("chpid_type", CcwTestDevDevice, chpid_type,
> +                       0x25), /* took FC, TODO discuss */
> +    DEFINE_PROP_UINT32("op_mode", CcwTestDevDevice, op_mode,
> +                       0), /* TODO discuss */
> +    DEFINE_PROP_BOOL("op_mode_locked", CcwTestDevDevice, op_mode_locke=
d,
> +                       false), /* TODO discuss */
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +/* TODO This is the out-of-band variant. We may want to get rid of it =
*/

I agree, this should rather go away in the final version.

> +static int set_mode_diag(const uint64_t *args)
> +{
> +    uint64_t subch_id =3D args[0];
> +    uint64_t op_mode =3D args[1];
> +    SubchDev *sch;
> +    CcwTestDevDevice *dev;
> +    int cssid, ssid, schid, m;
> +
> +    if (ioinst_disassemble_sch_ident(subch_id, &m, &cssid, &ssid, &sch=
id)) {
> +        return -EINVAL;
> +    }
> +    sch =3D css_find_subch(m, cssid, ssid, schid);
> +    if (!sch || !css_subch_visible(sch)) {
> +        return -EINVAL;
> +    }
> +    dev =3D CCW_TESTDEV(sch->driver_data);
> +    if (dev->op_mode_locked) {
> +        return op_mode =3D=3D dev->op_mode ? 0 : -EINVAL;
> +    }
> +    dev->op_mode =3D op_mode;
> +    sch->ccw_cb =3D get_ccw_cb(dev->op_mode);
> +    return 0;
> +}
> +
> +static void ccw_testdev_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    CcwTestDevClass *ctc =3D CCW_TESTDEV_CLASS(klass);
> +
> +    dc->props =3D ccw_testdev_properties;
> +    dc->bus_type =3D TYPE_VIRTUAL_CSS_BUS;
> +    ctc->parent_realize =3D dc->realize;
> +    dc->realize =3D ccw_testdev_realize;
> +    dc->hotpluggable =3D false;
> +
> +    s390_register_virtio_hypercall(CCW_TST_DIAG_500_SUB, set_mode_diag=
);
> +}
> +
> +static const TypeInfo ccw_testdev_info =3D {
> +    .name =3D TYPE_CCW_TESTDEV,
> +    .parent =3D TYPE_CCW_DEVICE,
> +    .instance_size =3D sizeof(CcwTestDevDevice),
> +    .class_init =3D ccw_testdev_class_init,
> +    .class_size =3D sizeof(CcwTestDevClass),
> +};
> +
> +static void ccw_testdev_register(void)
> +{
> +    type_register_static(&ccw_testdev_info);
> +}
> +
> +type_init(ccw_testdev_register)
> diff --git a/hw/misc/ccw-testdev.h b/hw/misc/ccw-testdev.h
> new file mode 100644
> index 0000000000..f4d4570f5e
> --- /dev/null
> +++ b/hw/misc/ccw-testdev.h
> @@ -0,0 +1,18 @@

Add some license statement and/or author information here?

> +#ifndef HW_s390X_CCW_TESTDEV_H
> +#define HW_s390X_CCW_TESTDEV_H
> +
> +typedef enum CcwTestDevOpMode {
> +    OP_MODE_NOP =3D 0,
> +    OP_MODE_FIB =3D 1,
> +    OP_MODE_MAX /* extremal element */
> +} CcwTestDevOpMode;
> +
> +#define CCW_CMD_READ 0x01U
> +#define CCW_CMD_WRITE 0x02U
> +
> +#define CCW_CMD_CTL_MODE 0x07U
> +#define CCW_TST_SET_MODE_INCANTATION "SET MODE=3D"
> +/* Subcode for diagnose 500 (virtio hypercall). */
> +#define CCW_TST_DIAG_500_SUB 254
> +
> +#endif

 Thomas
