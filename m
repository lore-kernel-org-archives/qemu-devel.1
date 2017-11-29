Received: from eggs.gnu.org ([2001:4830:134:3::10]:57267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eK1ND-0006aH-3p
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 07:21:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eK1NB-0006WY-Oy
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 07:21:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43346)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eK1NB-0006WJ-H2
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 07:21:53 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vATCLHxZ027785
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 07:21:49 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ehsjahdrt-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 07:21:49 -0500
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 29 Nov 2017 07:21:45 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20171031204330.14803-3-danielhb@linux.vnet.ibm.com>
References: <20171031204330.14803-1-danielhb@linux.vnet.ibm.com>
	<20171031204330.14803-3-danielhb@linux.vnet.ibm.com>
Date: Tue, 28 Nov 2017 19:14:09 -0600
Message-Id: <151191804931.31225.16600246316962557209@sif>
Subject: Re: [Qemu-devel] [PATCH v2 2/4] tests: adding 'set_indicator' RTAS
 call
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, lvivier@redhat.com

Quoting Daniel Henrique Barboza (2017-10-31 15:43:28)
> 'set_indicator' is a RTAS hypercall that is used to change
> the state of both physical and logical devices DRCs by setting
> allocation-state, isolation-state and dr-indicator.
> =

> This patch implements the set_indicator RTAS call in
> tests/libqos/rtas.c, adding its test in tests/rtas-test.c.
> =

> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> ---
>  tests/libqos/rtas.c | 33 ++++++++++++++++++++++++
>  tests/libqos/rtas.h |  2 ++
>  tests/rtas-test.c   | 73 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 108 insertions(+)
> =

> diff --git a/tests/libqos/rtas.c b/tests/libqos/rtas.c
> index fdeab448f7..ade572a84f 100644
> --- a/tests/libqos/rtas.c
> +++ b/tests/libqos/rtas.c
> @@ -151,3 +151,36 @@ int qrtas_check_exception(QGuestAllocator *alloc, ui=
nt32_t mask,
> =

>      return ret[0];
>  }
> +
> +/*
> + * set_indicator as defined by PAPR 2.7+, 7.3.5.4
> + *
> + * nargs =3D 3
> + * nrets =3D 1
> + *
> + * arg[0] =3D the type of the indicator
> + * arg[1] =3D index of the specific indicator
> + * arg[2] =3D desired new state
> + *
> + * Depending on the input, set_indicator will call set_isolation_state,
> + * set_allocation_state or set_dr_indicator in hw/ppc/spapr_drc.c.
> + * These functions allows the guest to control the state of hotplugged
> + * and hot unplugged devices.
> + */
> +int qrtas_set_indicator(QGuestAllocator *alloc, uint32_t type, uint32_t =
idx,
> +                        uint32_t new_state)
> +{
> +    uint32_t args[3], ret[1];
> +    int res;
> +
> +    args[0] =3D type;
> +    args[1] =3D idx;
> +    args[2] =3D new_state;
> +
> +    res =3D qrtas_call(alloc, "set-indicator", 3, args, 1, ret);
> +    if (res !=3D 0) {
> +        return -1;
> +    }
> +
> +    return ret[0];
> +}
> diff --git a/tests/libqos/rtas.h b/tests/libqos/rtas.h
> index 330ecfd397..9dfa18f32b 100644
> --- a/tests/libqos/rtas.h
> +++ b/tests/libqos/rtas.h
> @@ -14,4 +14,6 @@ int qrtas_ibm_write_pci_config(QGuestAllocator *alloc, =
uint64_t buid,
>                                 uint32_t addr, uint32_t size, uint32_t va=
l);
>  int qrtas_check_exception(QGuestAllocator *alloc, uint32_t mask,
>                            uint32_t buf_addr, uint32_t buf_len);
> +int qrtas_set_indicator(QGuestAllocator *alloc, uint32_t type, uint32_t =
idx,
> +                        uint32_t new_state);
>  #endif /* LIBQOS_RTAS_H */
> diff --git a/tests/rtas-test.c b/tests/rtas-test.c
> index c5a6080043..2c34b6e83c 100644
> --- a/tests/rtas-test.c
> +++ b/tests/rtas-test.c
> @@ -8,6 +8,13 @@
>  #define EVENT_MASK_EPOW (1 << 30)
>  #define EVENT_LOG_LEN 2048
> =

> +#define RTAS_SENSOR_TYPE_ISOLATION_STATE 9001
> +#define RTAS_SENSOR_TYPE_ALLOCATION_STATE 9003
> +#define SPAPR_DR_ISOLATION_STATE_ISOLATED 0
> +#define SPAPR_DR_ALLOCATION_STATE_UNUSABLE 0
> +#define SPAPR_DR_ALLOCATION_STATE_USABLE  1
> +#define SPAPR_DR_ISOLATION_STATE_UNISOLATED 1
> +
>  static void test_rtas_get_time_of_day(void)
>  {
>      QOSState *qs;
> @@ -97,6 +104,71 @@ static void test_rtas_check_exception_hotplug_event(v=
oid)
>      qtest_shutdown(qs);
>  }
> =

> +/*
> + * To test the 'set-indicator' RTAS call we will hotplug a device
> + * (in this case a CPU) and then make its DRC state go from
> + * the starting state UNUSABLE(1) to UNISOLATE(3). These DRC
> + * states transitions are described in further detail in
> + * PAPR 2.7+ 13.4.
> + */
> +static void test_rtas_set_indicator(void)
> +{
> +    QOSState *qs;
> +    uint64_t ret;
> +    uintptr_t guest_buf_addr;
> +    uint32_t drc_index;
> +    uint8_t *buf =3D g_malloc0(EVENT_LOG_LEN);
> +
> +    qs =3D qtest_spapr_boot("-machine pseries -cpu POWER8_v2.0 "
> +                          "-smp 1,sockets=3D4,cores=3D1,threads=3D1,maxc=
pus=3D4");
> +
> +    guest_buf_addr =3D guest_alloc(qs->alloc, EVENT_LOG_LEN * sizeof(uin=
t8_t));
> +    qtest_qmp_device_add("power8_v2.0-spapr-cpu-core", "id-1",
> +                         "'core-id':'1'");
> +
> +    ret =3D qrtas_check_exception(qs->alloc, EVENT_MASK_EPOW,
> +                                guest_buf_addr, EVENT_LOG_LEN);
> +
> +    memread(guest_buf_addr, buf, EVENT_LOG_LEN);
> +    guest_free(qs->alloc, guest_buf_addr);
> +
> +    g_assert_cmpint(ret, =3D=3D, 0);
> +
> +    /*
> +     * This time we can't ignore the event log written in the
> +     * check_exception call - we need the DRC index of the
> +     * recently added CPU to make the state changes using set_indicator.
> +     *
> +     * A bit of magic to go straight to the DRC index by checking the
> +     * error log format in hw/ppc/spapr_events.c:
> +     *
> +     * - rtas_error_log size =3D 8 bytes
> +     * - all other structures until the hotplug event log =3D 88 bytes
> +     * - inside the hotplug event log, skip 8 + 4 bytes to get to
> +     *   the drc_id union.
> +     *
> +     * This gives us a 108 bytes skip to get the drc info, which is
> +     * written in be32.
> +     */
> +    drc_index =3D be32toh(*((uint32_t *)(buf + 108)));

Definitely agree some helpers to parse/validate the event log structure wou=
ld
be helpful here. I think you can pretty much cast to a struct epow_extended=
_log
if you break out some of the definitions in spapr_events.c.

> +    g_free(buf);
> +
> +    /*
> +     * According to the DRC state diagram, the guest first sets a device
> +     * to USABLE (2), then UNISOLATED (3). Both should return
> +     * RTAS_OUT_SUCCESS(0).
> +     */
> +    ret =3D qrtas_set_indicator(qs->alloc, RTAS_SENSOR_TYPE_ALLOCATION_S=
TATE,
> +                              drc_index, SPAPR_DR_ALLOCATION_STATE_USABL=
E);
> +    g_assert_cmpint(ret, =3D=3D, 0);
> +
> +    ret =3D qrtas_set_indicator(qs->alloc, RTAS_SENSOR_TYPE_ISOLATION_ST=
ATE,
> +                              drc_index, SPAPR_DR_ISOLATION_STATE_UNISOL=
ATED);
> +    g_assert_cmpint(ret, =3D=3D, 0);

Would be good to also validate handling for some of the invalid transitions
too, like unisolating a device that's in an unusable state, eventually
at least.

> +
> +    qtest_shutdown(qs);
> +}
> +
>  int main(int argc, char *argv[])
>  {
>      const char *arch =3D qtest_get_arch();
> @@ -112,6 +184,7 @@ int main(int argc, char *argv[])
>                     test_rtas_check_exception_no_events);
>      qtest_add_func("rtas/rtas-check-exception-hotplug-event",
>                     test_rtas_check_exception_hotplug_event);
> +    qtest_add_func("rtas/test_rtas_set_indicator", test_rtas_set_indicat=
or);
> =

>      return g_test_run();
>  }
> -- =

> 2.13.6
>=20
