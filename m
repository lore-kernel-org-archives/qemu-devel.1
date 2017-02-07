Received: from eggs.gnu.org ([2001:4830:134:3::10]:60927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cb2L1-0000A7-Gm
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 04:45:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cb2Ky-0004X8-B1
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 04:45:27 -0500
Received: from greensocs.com ([193.104.36.180]:59814)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cb2Kx-0004Wo-Tr
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 04:45:24 -0500
References: <1485424060-12217-1-git-send-email-fred.konrad@greensocs.com>
	<1485424060-12217-4-git-send-email-fred.konrad@greensocs.com>
	<d5dff1bc-7d71-7b5f-133c-c102da108c01@kaod.org>
From: Frederic Konrad <fred.konrad@greensocs.com>
Message-ID: <7a926039-796c-9d00-0895-4b31fa72b8ba@greensocs.com>
Date: Tue, 7 Feb 2017 10:45:20 +0100
MIME-Version: 1.0
In-Reply-To: <d5dff1bc-7d71-7b5f-133c-c102da108c01@kaod.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V2 03/10] qemu-clk: allow to bind two
 clocks together
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-devel@nongnu.org, edgar.iglesias@xilinx.com, peter.maydell@linaro.org, mark.burton@greensocs.com, alistair.francis@xilinx.com

On 02/06/2017 04:58 PM, C=E9dric Le Goater wrote:
> Hello,
>=20
> On 01/26/2017 10:47 AM, fred.konrad@greensocs.com wrote:
>> From: KONRAD Frederic <fred.konrad@greensocs.com>
>>
>> This introduces the clock binding and the update part.
>> When the qemu_clk_rate_update(qemu_clk, int) function is called:
>>   * The clock callback is called on the qemu_clk so it can change the =
rate.
>>   * The qemu_clk_rate_update function is called on all the driven cloc=
k.
>>
>> Signed-off-by: KONRAD Frederic <fred.konrad@greensocs.com>
>>
>> V1 -> V2:
>>   * Rename qemu_clk_on_rate_update_cb to QEMUClkRateUpdateCallback and
>>     move the pointer to the structure instead of having a pointer-to-f=
unction
>>     type.
>> ---
>>  include/qemu/qemu-clock.h | 67 ++++++++++++++++++++++++++++++++++++++=
+++++++++
>>  qemu-clock.c              | 56 ++++++++++++++++++++++++++++++++++++++=
+
>>  2 files changed, 123 insertions(+)
>>
>> diff --git a/include/qemu/qemu-clock.h b/include/qemu/qemu-clock.h
>> index 3e692d3..6d30299 100644
>> --- a/include/qemu/qemu-clock.h
>> +++ b/include/qemu/qemu-clock.h
>> @@ -30,12 +30,25 @@
>>  #define TYPE_CLOCK "qemu-clk"
>>  #define QEMU_CLOCK(obj) OBJECT_CHECK(struct qemu_clk, (obj), TYPE_CLO=
CK)
>> =20
>> +typedef struct ClkList ClkList;
>> +typedef uint64_t QEMUClkRateUpdateCallback(void *opaque, uint64_t rat=
e);
>> +
>>  typedef struct qemu_clk {
>>      /*< private >*/
>>      Object parent_obj;
>>      char *name;            /* name of this clock in the device. */
>> +    uint64_t in_rate;      /* rate of the clock which drive this pin.=
 */
>=20
>=20
> So if this is the reference clock rate, which can be divided by=20
> settings in control registers, I would call the attribute=20
> 'ref_rate' or 'rate_reference'=20
>=20
>> +    uint64_t out_rate;     /* rate of this clock pin. */
>=20
> and this attribute could just be 'rate' and may be if we make=20
> a property out of it, we could get rid of FixedClock in patch
> 7/10.
>   =20
>=20
>> +    void *opaque;
>> +    QEMUClkRateUpdateCallback *cb;
>=20
> If I understand correctly, the need is to be able to refresh
> the rate of a clock object depending on some settings in a=20
> controller. I think we should be using a derived class and=20
> an operation for it. it would look better from a QOM point=20
> of view.=20
>=20
> Here is a possibility,
>=20
> We could make 'rate' a property and use a set property handler=20
> to call the derived class specific operation. This is very=20
> similar to the callback but we would remove the need of =20
> qemu_clk_update_rate() and use the std mechanisms already in
> place  :
>=20
> 	object_property_set_int()=20
>=20
> qemu_clk_refresh() would still be needed to propagate the=20
> changes in the settings of a controller to the target clocks.=20
>=20
> The 'opaque' attribute, which holds the pointer to a controller=20
> object, would have to be passed to the derived clock object
> with=20
> 	object_property_add_const_link()=20
>=20
> and then grabbed with=20
>=20
> 	object_property_get_link()
>=20
> in the realize function of the derived clock object, or whenever=20
> it's needed, in the operation for instance.
>=20
> This clearly means more code than the actual solution, but=20
> that is QOM way I think. =20

Yes, the big issue here is that there are several clock inputs and clock
outputs. We need to be able to bind / unbind them if there is a selector
or some such.

So a device will have more than one clock object internally in it which
are "chained" to form a clock tree.

It seems overkill to me to implement one derived object per clock
"block" in the device to get the callback.

>=20
>> +    QLIST_HEAD(, ClkList) bound;
>>  } *qemu_clk;
>> =20
>> +struct ClkList {
>> +    qemu_clk clk;
>> +    QLIST_ENTRY(ClkList) node;
>> +};
>> +
>=20
> Do we really need this intermediate object ? Can't we just
> put the list_entry attribute under qemu_clk ? I haven't
> tried, may be I am wrong but that would simplify the code.

Yes I think it is needed. Actually I didn't find anything which
does this differently.

>=20
>>  /**
>>   * qemu_clk_device_add_clock:
>>   * @dev: the device on which the clock needs to be added.
>> @@ -59,4 +72,58 @@ void qemu_clk_device_add_clock(DeviceState *dev, qe=
mu_clk clk,
>>   */
>>  qemu_clk qemu_clk_device_get_clock(DeviceState *dev, const char *name=
);
>> =20
>> +/**
>> + * qemu_clk_bind_clock:
>> + * @out: the clock output.
>> + * @in: the clock input.
>> + *
>> + * Connect the clock together. This is unidirectional so a
>> + * qemu_clk_update_rate will go from @out to @in.
>> + *
>> + */
>> +void qemu_clk_bind_clock(qemu_clk out, qemu_clk in);
>=20
> maybe remove the  _clock suffix. It feels redundant.

Ok.

Thanks,
Fred

>=20
> Thanks,
>=20
> C.=20
>=20
>> +
>> +/**
>> + * qemu_clk_unbind:
>> + * @out: the clock output.
>> + * @in: the clock input.
>> + *
>> + * Disconnect the clocks if they were bound together.
>> + *
>> + */
>> +void qemu_clk_unbind(qemu_clk out, qemu_clk in);
>> +
>> +/**
>> + * qemu_clk_update_rate:
>> + * @clk: the clock to update.
>> + * @rate: the new rate in Hz.
>> + *
>> + * Update the @clk to the new @rate.
>> + *
>> + */
>> +void qemu_clk_update_rate(qemu_clk clk, uint64_t rate);
>> +
>> +/**
>> + * qemu_clk_refresh:
>> + * @clk: the clock to be refreshed.
>> + *
>> + * If a model alters the topology of a clock tree, it must call this =
function on
>> + * the clock source to refresh the clock tree.
>> + *
>> + */
>> +void qemu_clk_refresh(qemu_clk clk);
>>
>> +
>> +/**
>> + * qemu_clk_set_callback:
>> + * @clk: the clock associated to the callback.
>> + * @cb: the function which is called when a refresh happen on the clo=
ck @clk.
>> + * @opaque: the opaque data passed to the callback.
>> + *
>> + * Set the callback @cb which will be called when the clock @clk is u=
pdated.
>> + *
>> + */
>> +void qemu_clk_set_callback(qemu_clk clk,
>> +                           QEMUClkRateUpdateCallback *cb,
>> +                           void *opaque);
>> +
>>  #endif /* QEMU_CLOCK_H */
>> diff --git a/qemu-clock.c b/qemu-clock.c
>> index 803deb3..8c12368 100644
>> --- a/qemu-clock.c
>> +++ b/qemu-clock.c
>> @@ -37,6 +37,62 @@
>>      }                                                                =
        \
>>  } while (0);
>> =20
>> +void qemu_clk_refresh(qemu_clk clk)
>> +{
>> +    qemu_clk_update_rate(clk, clk->in_rate);
>> +}
>> +
>> +void qemu_clk_update_rate(qemu_clk clk, uint64_t rate)
>> +{
>> +    ClkList *child;
>> +
>> +    clk->in_rate =3D rate;
>> +    clk->out_rate =3D rate;
>> +
>> +    if (clk->cb) {
>> +        clk->out_rate =3D clk->cb(clk->opaque, rate);
>> +    }
>> +
>> +    DPRINTF("%s output rate updated to %" PRIu64 "\n",
>> +            object_get_canonical_path(OBJECT(clk)),
>> +            clk->out_rate);
>> +
>> +    QLIST_FOREACH(child, &clk->bound, node) {
>> +        qemu_clk_update_rate(child->clk, clk->out_rate);
>> +    }
>> +}
>> +
>> +void qemu_clk_bind_clock(qemu_clk out, qemu_clk in)
>> +{
>> +    ClkList *child;
>> +
>> +    child =3D g_malloc(sizeof(child));
>> +    assert(child);
>> +    child->clk =3D in;
>> +    QLIST_INSERT_HEAD(&out->bound, child, node);
>> +    qemu_clk_update_rate(in, out->out_rate);
>> +}
>> +
>> +void qemu_clk_unbind(qemu_clk out, qemu_clk in)
>> +{
>> +    ClkList *child, *next;
>> +
>> +    QLIST_FOREACH_SAFE(child, &out->bound, node, next) {
>> +        if (child->clk =3D=3D in) {
>> +            QLIST_REMOVE(child, node);
>> +            g_free(child);
>> +        }
>> +    }
>> +}
>> +
>> +void qemu_clk_set_callback(qemu_clk clk,
>> +                           QEMUClkRateUpdateCallback *cb,
>> +                           void *opaque)
>> +{
>> +    clk->cb =3D cb;
>> +    clk->opaque =3D opaque;
>> +}
>> +
>>  void qemu_clk_device_add_clock(DeviceState *dev, qemu_clk clk,
>>                                 const char *name)
>>  {
>>
>=20
>=20
