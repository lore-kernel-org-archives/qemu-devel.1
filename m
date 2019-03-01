Received: from eggs.gnu.org ([209.51.188.92]:56578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzkgN-0004JQ-BC
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:06:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzkgL-00015l-Or
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:06:43 -0500
References: <155144987334.126105.2493613675615671242.stgit@bahia.lan>
From: David Hildenbrand <david@redhat.com>
Message-ID: <3240a5a6-c82c-149d-b823-a0be5c2bea42@redhat.com>
Date: Fri, 1 Mar 2019 17:06:37 +0100
MIME-Version: 1.0
In-Reply-To: <155144987334.126105.2493613675615671242.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] spapr: Explicitly check machine support
 before using EVENT_CLASS_HOT_PLUG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>

On 01.03.19 15:17, Greg Kurz wrote:
> Recent commit b8165118f52c "spapr: support memory unplug for qtest" bro=
ke
> CPU hotplug tests for old machine types:
>=20
> $ QTEST_QEMU_BINARY=3Dppc64-softmmu/qemu-system-ppc64 ./tests/cpu-plug-=
test -m=3Dslow
> /ppc64/cpu-plug/pseries-3.1/device-add/2x3x1&maxcpus=3D6: OK
> /ppc64/cpu-plug/pseries-2.12-sxxm/device-add/2x3x1&maxcpus=3D6: OK
> /ppc64/cpu-plug/pseries-3.0/device-add/2x3x1&maxcpus=3D6: OK
> /ppc64/cpu-plug/pseries-2.10/device-add/2x3x1&maxcpus=3D6: OK
> /ppc64/cpu-plug/pseries-2.11/device-add/2x3x1&maxcpus=3D6: OK
> /ppc64/cpu-plug/pseries-2.12/device-add/2x3x1&maxcpus=3D6: OK
> /ppc64/cpu-plug/pseries-2.9/device-add/2x3x1&maxcpus=3D6: OK
> /ppc64/cpu-plug/pseries-2.7/device-add/2x3x1&maxcpus=3D6: **
> ERROR:/home/thuth/devel/qemu/hw/ppc/spapr_events.c:313:rtas_event_log_t=
o_source: assertion failed: (source->enabled)
> Broken pipe
> /home/thuth/devel/qemu/tests/libqtest.c:143: kill_qemu() detected QEMU =
death from signal 6 (Aborted) (core dumped)
> Aborted (core dumped)
>=20
> The rtas_event_log_to_source() function is supposed to return the event
> source to be used for a given event type. In the case of hotplug, it fi=
rst
> tries EVENT_CLASS_HOT_PLUG and, if the guest doesn't support it, it fal=
ls
> back to EVENT_CLASS_EPOW.
>=20
> This works well for machine types that enable EVENT_CLASS_HOT_PLUG. For
> older machine types, this happened to work because they don't set the
> OV5_HP_EVT bit in spapr->ov5. CAS hence logically keeps the bit cleared
> in spapr->ov5_cas and we avoid the assert.
>=20
> As shown by commit b8165118f52c, the logic is fragile and we need a
> bigger hammer to ensure that rtas_event_log_to_source() doesn't go
> down the EVENT_CLASS_HOT_PLUG path with older machine types.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/ppc/spapr_events.c |   12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index ab9a1f0063d5..1a09dab6857d 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -307,11 +307,13 @@ rtas_event_log_to_source(sPAPRMachineState *spapr=
, int log_type)
> =20
>      switch (log_type) {
>      case RTAS_LOG_TYPE_HOTPLUG:
> -        source =3D spapr_event_sources_get_source(spapr->event_sources=
,
> -                                                EVENT_CLASS_HOT_PLUG);
> -        if (spapr_ovec_test(spapr->ov5_cas, OV5_HP_EVT)) {
> -            g_assert(source->enabled);
> -            break;
> +        if (spapr->use_hotplug_event_source) {
> +            source =3D spapr_event_sources_get_source(spapr->event_sou=
rces,
> +                                                    EVENT_CLASS_HOT_PL=
UG);
> +            if (spapr_ovec_test(spapr->ov5_cas, OV5_HP_EVT)) {
> +                g_assert(source->enabled);
> +                break;
> +            }
>          }
>          /* fall back to epow for legacy hotplug interrupt source */
>      case RTAS_LOG_TYPE_EPOW:
>=20

Thanks a lot for taking care of this, highly appreciated!

--=20

Thanks,

David / dhildenb
