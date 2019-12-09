Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33257C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 23:21:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE54A2068E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 23:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TSagJ5g/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE54A2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieSKp-0008MU-UN
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 18:20:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44902)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gshan@redhat.com>) id 1ieSJw-0007qJ-6T
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 18:20:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gshan@redhat.com>) id 1ieSJr-0005qX-U4
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 18:20:02 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46747)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gshan@redhat.com>) id 1ieSJr-0005pK-PE
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 18:19:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575933598;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ai73ZmWTcdjnwtOz6dA5BAWD5B6RDXOCZIWWmz6lB+U=;
 b=TSagJ5g/Gt9NSQpCTc2DsBw4p4MNncCapPMRzoZT9toeEPtfoIK7wSKxlvKrigaP7m4zTW
 dSyGoEgVyejnV5x6xKny9Cj3X4YyfLAGlKIOV7EgT7yvpugbDmajRnnWO1NTiMYTVOyryf
 vysck9+pQKNxj36+e7Tw6W4Gr/oe4CU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-_duuQW6iO7eyIMJKNl6_qA-1; Mon, 09 Dec 2019 18:19:54 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF27A1005502;
 Mon,  9 Dec 2019 23:19:52 +0000 (UTC)
Received: from localhost.localdomain (vpn2-54-52.bne.redhat.com [10.64.54.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A266E5C21A;
 Mon,  9 Dec 2019 23:19:51 +0000 (UTC)
Subject: Re: [PATCH] hw/core: Fix data type in do_nmi()
To: Greg Kurz <groug@kaod.org>
References: <20191206063642.40942-1-gshan@redhat.com>
 <20191206175031.66f62929@bahia.w3ibm.bluemix.net>
 <8b4e97d1-eddb-b7d2-1069-453ec4a4263a@redhat.com>
 <20191209093645.091c9e4b@bahia.w3ibm.bluemix.net>
 <d4d6efdd-62d4-c5e5-adff-999caca8fe7b@redhat.com>
 <20191209115503.6b7bcf59@bahia.w3ibm.bluemix.net>
From: Gavin Shan <gshan@redhat.com>
Message-ID: <296eda90-f3c2-5ab6-d3a4-9aa0f121e103@redhat.com>
Date: Tue, 10 Dec 2019 10:19:48 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191209115503.6b7bcf59@bahia.w3ibm.bluemix.net>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: _duuQW6iO7eyIMJKNl6_qA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Gavin Shan <gshan@redhat.com>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/9/19 9:55 PM, Greg Kurz wrote:
> On Mon, 9 Dec 2019 20:12:09 +1100
> Gavin Shan <gshan@redhat.com> wrote:
>=20
>> On 12/9/19 7:36 PM, Greg Kurz wrote:
>>> On Sun, 8 Dec 2019 00:14:00 +1100
>>> Gavin Shan <gshan@redhat.com> wrote:
>>>
>>>> On 12/7/19 3:50 AM, Greg Kurz wrote:
>>>>> On Fri,  6 Dec 2019 17:36:42 +1100
>>>>> Gavin Shan <gshan@redhat.com> wrote:
>>>>>
>>>>>> object_dynamic_cast() should return machine (or GPIO) state instad o=
f NMI
>>>>>> state in do_nmi(). So it's wrong to convert it to NMI state uncondit=
ionally.
>>>>>>
>>>>>
>>>>> object_dynamic_cast() returns either its first argument if it can be =
cast
>>>>> to the given typename or NULL. Since the x86, ccw and spapr machines =
and
>>>>> the PowerMac GPIO implement the NMI interface, nothing is wrong here.
>>>>>
>>>>> The do_nmi() function is called for all objects in the QOM tree and s=
imply
>>>>> filters out the ones that don't implement the NMI interface.
>>>>>
>>>>> I do agree that this isn't super obvious though. It would be clearer =
to
>>>>> do the filtering in the foreach() function. Something like:
>>>>>
>>>>> https://patchwork.ozlabs.org/patch/1182232/
>>>>>
>>>>
>>>> Greg, Thanks for the review and comments. I think we're talking about
>>>> different issues. I do agree it's worthy to simplify the code with the
>>>> object_child_foreach_type(), but later.
>>>>
>>>> When we have below parameters to qemu, object_dynamic_cast(o, TYPE_NMI=
)
>>>> returns object of "pc-q35-4.2-machine", which is passed to the subquen=
t
>>>> NMIClass::nmi_monitor_handler(). However, the function expects a NMISt=
ate
>>>> from its prototype as below. This patch changes the prototype to fill =
the
>>>> gap.
>>>>
>>>>       void (*nmi_monitor_handler)(NMIState *n, int cpu_index, Error **=
errp);
>>>>
>>>
>>> Hmm... the "pc-q35-4.2-machine" type inherits from the TYPE_PC_MACHINE,
>>> which in turns inherits from TYPE_X86_MACHINE, which implements the
>>> TYPE_NMI interface. It thus seems okay to pass this object to x86_nmi()=
.
>>>
>>> What are you trying to fix here ?
>>>
>>
>> There is no valid instance associated with interface class. For this spe=
cific
>> case, there is no NMIState instance. I don't understand how we can pass =
a
>> valid NMIState to the function.
>=20
> Ah I get it. Please read the include/qom/object.h to understand what QOM
> interfaces are about. Especially this paragraph:
>=20
>   * # Interfaces #
>   *
>   * Interfaces allow a limited form of multiple inheritance.  Instances a=
re
>   * similar to normal types except for the fact that are only defined by
>   * their classes and never carry any state.  You can dynamically cast an=
 object
>   * to one of its #Interface types and vice versa.
>=20

Thanks, Greg. The statements here clarify the forced conversion (casting) i=
s
allowed, even I don't think it's safe to do so.

>> Furthermore, below code returns "pc-q35-4.2-machine"
>> object instead of NMIState. It's not safe to do the forced conversion he=
re.
>>
>>      /* It returns "pc-q35-4.2-machine" instance */
>>      NMIState *n =3D (NMIState *) object_dynamic_cast(o, TYPE_NMI);
>>        :
>>      nc->nmi_monitor_handler(n, ns->cpu_index, &ns->err);
>=20
> As explained in my previous mail, this _forced conversion_ is the current
> way to implement object_child_foreach_type(). It is ugly and confusing fo=
r
> newcomers but it is safe since the pointer is either TYPE_NMI or NULL, in
> which case the handler isn't called.
>=20

Yes, as above statements said.

>>
>>
>> If "struct NMIState" is declared and the data struct is written in the f=
unction.
>> We will run into data corruption if I'm correct.
>>
>=20
> The 'struct NMIState' isn't defined on purpose, but I agree this isn't do=
cumented
> anywhere except in this changelog:
>=20
> commit 00ed3da9b5c2e66e796a172df3e19545462b9c90
> Author: David Gibson <david@gibson.dropbear.id.au>
> Date:   Tue Sep 24 16:00:33 2019 +1000
>=20
>      xics: Minor fixes for XICSFabric interface
>     =20
>      Interface instances should never be directly dereferenced.  So, the =
common
>      practice is to make them incomplete types to make sure no-one does t=
hat.
>      XICSFrabric, however, had a dummy type which is less safe.
>     =20
>      We were also using OBJECT_CHECK() where we should have been using
>      INTERFACE_CHECK().
>     =20
>      Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>      Reviewed-by: Greg Kurz <groug@kaod.org>
>      Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
>=20
> Maybe the NMIState naming was a poor choice since there's no associated
> state with QOM interfaces. But we do want to keep a typedef though: it
> is more precise and hence safer to pass an NMIState * than an Object *.>=
=20

It's arguable to be correct enough. The NMIClass and the associated callbac=
k
(nmi_monitor_handler()) are attached to the parent class, which is "pc-q35-=
4.2-machine"
in our example. The interface is strongly associated with the parent class.=
 From
this perspective, it also makes sense to pass the parent object.

However, we didn't run into any issue so far. Maybe the code can be revisit=
ed
when it needs to be improved later, or never :)

>> I'm pasting the message I had. Hope this helps for understanding the iss=
ue:
>>
>> --- a/hw/core/nmi.c
>> +++ b/hw/core/nmi.c
>> @@ -42,6 +42,10 @@ static int do_nmi(Object *o, void *opaque)
>>        if (n) {
>>            NMIClass *nc =3D NMI_GET_CLASS(n);
>>   =20
>> +       fprintf(stdout, "%s: o=3D%s, n=3D%s\n",
>> +                __func__, object_get_typename(OBJECT(o)),
>> +                object_get_typename(OBJECT(n)));
>> +
>>
>=20
> object_get_typename() returns the type of the instance, which is either
> a machine or a GPIO in the current code base. This is different from
> object_dynamic_cast() which just tells if a given object can be cast
> to a give type (either regular QOM type or QOM interface).
>=20
> It is up to the various NMIClass::nmi_monitor_handler() to make sure
> they're being passed the right object.
>=20
> macio_gpio_nmi() explicitly does that with MACIO_GPIO(n). The other
> ones only need to access the CPU state and end up checking it is
> valid: s390_nmi() checks S390_CPU(cs), x86_nmi() checks X86_CPU(cs)
> and
>=20
> spapr_nmi()
>   ->async_run_on_cpu()
>     ->spapr_do_system_reset_on_cpu()
>       ->ppc_cpu_do_system_reset() checks POWERPC_CPU(cs)
>=20
> but they could maybe assert(object_dynamic_cast()) as well for
> clarity.
>=20

Yeah, nothing is wrong currently. macio_gpio_nmi() is the only case
where the NMIState is consumed after correct casting is applied.

>>
>> # QEMU 4.1.93 monitor - type 'help' for more information
>> (qemu) nmi
>> do_nmi: o=3Dpc-q35-4.2-machine, n=3Dpc-q35-4.2-machine
>>
>>
>>>>       Changed to:
>>>>
>>>>       void (*nmi_monitor_handler)(Object *parent, int cpu_index, Error=
 **errp);
>>>>
>>>>       ~/sandbox/src/qemu/qemu.main.x86/x86_64-softmmu/qemu-system-x86_=
64              \
>>>>       --enable-kvm -machine type=3Dq35,accel=3Dkvm,kernel-irqchip=3Don=
 -cpu host -smp 2 -m 1G    \
>>>>       -monitor none -serial mon:stdio -nographic -s                   =
                     \
>>>>       -bios ~/sandbox/src/firmware/seabios/out/bios.bin               =
                     \
>>>>       -kernel ~/sandbox/src/linux/linux.main.x86/arch/x86/boot/bzImage=
                     \
>>>>       -initrd ~/sandbox/src/util/buildroot/output/images/rootfs.cpio.x=
z                    \
>>>>       -append "earlyprintk=3DttyS0 console=3DttyS0 debug"             =
                         \
>>>>       -device virtio-net-pci,netdev=3Dunet,mac=3D52:54:00:f1:26:a6    =
                         \
>>>>       -netdev user,id=3Dunet,hostfwd=3Dtcp::50959-:22                 =
                         \
>>>>       -drive file=3D~/sandbox/images/vm.img,if=3Dnone,format=3Draw,id=
=3Dnvme0                      \
>>>>       -device nvme,drive=3Dnvme0,serial=3Dfoo                         =
                         \
>>>>       -drive file=3D~/sandbox/images/vm1.img,if=3Dnone,format=3Draw,id=
=3Dnvme1                     \
>>>>       -device nvme,drive=3Dnvme1,serial=3Dfoo1
>>>>
>>>>>> This changes the prototype of NMIClass::nmi_monitor_handler() to acc=
ept
>>>>>> the parent object of NMI state instead of itself. With this, he pare=
nt object
>>>>>> is passed to the function, to avoid potential data corruption.
>>>>>>
>>>>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>>>>> ---
>>>>>>     hw/core/nmi.c              | 8 ++++----
>>>>>>     hw/i386/x86.c              | 2 +-
>>>>>>     hw/misc/macio/gpio.c       | 6 +++---
>>>>>>     hw/ppc/spapr.c             | 2 +-
>>>>>>     hw/s390x/s390-virtio-ccw.c | 2 +-
>>>>>>     include/hw/nmi.h           | 2 +-
>>>>>>     6 files changed, 11 insertions(+), 11 deletions(-)
>>>>>>
>>>>>> diff --git a/hw/core/nmi.c b/hw/core/nmi.c
>>>>>> index 481c4b3c7e..554708d0db 100644
>>>>>> --- a/hw/core/nmi.c
>>>>>> +++ b/hw/core/nmi.c
>>>>>> @@ -37,13 +37,13 @@ static void nmi_children(Object *o, struct do_nm=
i_s *ns);
>>>>>>     static int do_nmi(Object *o, void *opaque)
>>>>>>     {
>>>>>>         struct do_nmi_s *ns =3D opaque;
>>>>>> -    NMIState *n =3D (NMIState *) object_dynamic_cast(o, TYPE_NMI);
>>>>>> +    Object *parent =3D object_dynamic_cast(o, TYPE_NMI);
>>>>>>    =20
>>>>>> -    if (n) {
>>>>>> -        NMIClass *nc =3D NMI_GET_CLASS(n);
>>>>>> +    if (parent) {
>>>>>> +        NMIClass *nc =3D NMI_GET_CLASS(parent);
>>>>>>    =20
>>>>>>             ns->handled =3D true;
>>>>>> -        nc->nmi_monitor_handler(n, ns->cpu_index, &ns->err);
>>>>>> +        nc->nmi_monitor_handler(parent, ns->cpu_index, &ns->err);
>>>>>>             if (ns->err) {
>>>>>>                 return -1;
>>>>>>             }
>>>>>> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
>>>>>> index 394edc2f72..b98204f104 100644
>>>>>> --- a/hw/i386/x86.c
>>>>>> +++ b/hw/i386/x86.c
>>>>>> @@ -190,7 +190,7 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(M=
achineState *ms)
>>>>>>         return ms->possible_cpus;
>>>>>>     }
>>>>>>    =20
>>>>>> -static void x86_nmi(NMIState *n, int cpu_index, Error **errp)
>>>>>> +static void x86_nmi(Object *parent, int cpu_index, Error **errp)
>>>>>>     {
>>>>>>         /* cpu index isn't used */
>>>>>>         CPUState *cs;
>>>>>> diff --git a/hw/misc/macio/gpio.c b/hw/misc/macio/gpio.c
>>>>>> index 6cca6b27d6..6b4dfcc188 100644
>>>>>> --- a/hw/misc/macio/gpio.c
>>>>>> +++ b/hw/misc/macio/gpio.c
>>>>>> @@ -196,10 +196,10 @@ static void macio_gpio_reset(DeviceState *dev)
>>>>>>         macio_set_gpio(s, 1, true);
>>>>>>     }
>>>>>>    =20
>>>>>> -static void macio_gpio_nmi(NMIState *n, int cpu_index, Error **errp=
)
>>>>>> +static void macio_gpio_nmi(Object *parent, int cpu_index, Error **e=
rrp)
>>>>>>     {
>>>>>> -    macio_set_gpio(MACIO_GPIO(n), 9, true);
>>>>>> -    macio_set_gpio(MACIO_GPIO(n), 9, false);
>>>>>> +    macio_set_gpio(MACIO_GPIO(parent), 9, true);
>>>>>> +    macio_set_gpio(MACIO_GPIO(parent), 9, false);
>>>>>>     }
>>>>>>    =20
>>>>>>     static void macio_gpio_class_init(ObjectClass *oc, void *data)
>>>>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>>>>> index e076f6023c..3b92e4013d 100644
>>>>>> --- a/hw/ppc/spapr.c
>>>>>> +++ b/hw/ppc/spapr.c
>>>>>> @@ -3377,7 +3377,7 @@ void spapr_do_system_reset_on_cpu(CPUState *cs=
, run_on_cpu_data arg)
>>>>>>         ppc_cpu_do_system_reset(cs);
>>>>>>     }
>>>>>>    =20
>>>>>> -static void spapr_nmi(NMIState *n, int cpu_index, Error **errp)
>>>>>> +static void spapr_nmi(Object *parent, int cpu_index, Error **errp)
>>>>>>     {
>>>>>>         CPUState *cs;
>>>>>>    =20
>>>>>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>>>>>> index d3edeef0ad..a49952a8b9 100644
>>>>>> --- a/hw/s390x/s390-virtio-ccw.c
>>>>>> +++ b/hw/s390x/s390-virtio-ccw.c
>>>>>> @@ -431,7 +431,7 @@ static void s390_hot_add_cpu(MachineState *machi=
ne,
>>>>>>         s390x_new_cpu(object_class_get_name(oc), id, errp);
>>>>>>     }
>>>>>>    =20
>>>>>> -static void s390_nmi(NMIState *n, int cpu_index, Error **errp)
>>>>>> +static void s390_nmi(Object *parent, int cpu_index, Error **errp)
>>>>>>     {
>>>>>>         CPUState *cs =3D qemu_get_cpu(cpu_index);
>>>>>>    =20
>>>>>> diff --git a/include/hw/nmi.h b/include/hw/nmi.h
>>>>>> index a1e128724e..75afa67790 100644
>>>>>> --- a/include/hw/nmi.h
>>>>>> +++ b/include/hw/nmi.h
>>>>>> @@ -38,7 +38,7 @@ typedef struct NMIState NMIState;
>>>>>>     typedef struct NMIClass {
>>>>>>         InterfaceClass parent_class;
>>>>>>    =20
>>>>>> -    void (*nmi_monitor_handler)(NMIState *n, int cpu_index, Error *=
*errp);
>>>>>> +    void (*nmi_monitor_handler)(Object *parent, int cpu_index, Erro=
r **errp);
>>>>>>     } NMIClass;
>>>>>>    =20
>>>>>>     void nmi_monitor_handle(int cpu_index, Error **errp);
>>>>>


Regards,
Gavin


