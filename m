Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB835C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 15:05:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A18BD214DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 15:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K2Eqf2id"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A18BD214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw5wi-0002Hc-Qy
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 10:05:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42606)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iw5vt-0001VR-A9
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 10:04:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iw5vq-0007cO-8y
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 10:04:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34473
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iw5vp-0007at-R5
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 10:04:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580137445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xo5zbZlHZbJ2t2WdV1ju8mBi1UCFiVEluP3IfP0hbug=;
 b=K2Eqf2idQqLby/2jtCoI5YAoHzFPQmmsin8AJgAqJWVUgcFTbKs/hFy9Woz97K022pcuQk
 lUtQsPVIpCHdAb7C1/+j9J9v8H/MqOtGt5r/cdR65ndWSHvKCaAJlARzJGOq47VbnbR1SZ
 njlu2Ov2g3SsBt1EoiMtasmFYf4BWH8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-kBFQ6xCwMwebjrQyEIHIew-1; Mon, 27 Jan 2020 10:04:02 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F7121800D41;
 Mon, 27 Jan 2020 15:04:00 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AE92260BF4;
 Mon, 27 Jan 2020 15:03:53 +0000 (UTC)
Date: Mon, 27 Jan 2020 16:03:52 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Salil Mehta <salil.mehta@huawei.com>
Subject: Re: [Question] Regarding containers
 "unattached/peripheral/anonymous" - their relation with hot(un)plug of
 devices
Message-ID: <20200127160352.54f95875@redhat.com>
In-Reply-To: <b8fccc99d7344b2485c0db76886af9c8@huawei.com>
References: <70446b6cbf5442488a40fe809f38c3c8@huawei.com>
 <20200124145404.1d15209e@redhat.com>
 <77dbc712482545078986adcd72567630@huawei.com>
 <20200124170645.3d794ac6@redhat.com>
 <b8fccc99d7344b2485c0db76886af9c8@huawei.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: kBFQ6xCwMwebjrQyEIHIew-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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
Cc: Andrew Jones <drjones@redhat.com>, gshan@redhat.com,
 "mst@redhat.com" <mst@redhat.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will.deacon@arm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Linuxarm <linuxarm@huawei.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, pbonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 24 Jan 2020 18:44:16 +0000
Salil Mehta <salil.mehta@huawei.com> wrote:

> > From: Igor Mammedov [mailto:imammedo@redhat.com]
> > Sent: Friday, January 24, 2020 4:07 PM
> >=20
> > On Fri, 24 Jan 2020 15:02:10 +0000
> > Salil Mehta <salil.mehta@huawei.com> wrote:
> >  =20
> > > > From: Igor Mammedov [mailto:imammedo@redhat.com]
> > > > Sent: Friday, January 24, 2020 1:54 PM
> > > > To: Salil Mehta <salil.mehta@huawei.com>
> > > >
> > > > On Fri, 24 Jan 2020 11:20:15 +0000
> > > > Salil Mehta <salil.mehta@huawei.com> wrote:
> > > > =20
> > > > > Hello,
> > > > > I am working on vCPU Hotplug feature for ARM64 and I am in mid of=
 understanding
> > > > > some aspect of device_add/device_del interface of the QEMU.
> > > > >
> > > > > Observations:
> > > > > 1. Any object initialised by qmp_device_add() gets into /machine/=
unattached
> > > > > container. I traced the flow to code leg inside  device_set_reali=
zed()
> > > > > 2. I could see the reverse qmp_device_del() expects the device to=
 be in
> > > > > /machine/peripheral container.
> > > > > 3. I could see any object initially added to unattached container=
 did not had
> > > > > their parents until object_add_property_child() was called furthe=
r in the leg.
> > > > > which effectively meant a new property was created and property t=
able
> > > > > populated and child was parented.
> > > > > 4. Generally, container  /machine/peripheral was being used where=
ver
> > > > > DEVICE(dev)->id was present and non-null.
> > > > >
> > > > > Question:
> > > > > 1. Wanted to confirm my understanding about the use of having sep=
arate
> > > > > containers like unattached, peripheral and anonymous. =20
> > > > =20
> > > > > 2. At init time all the vcpus goes under *unattached* container. =
Now,
> > > > > qmp_device_del() cannot be used to unplug them. I am wondering =
=20
> > > >
> > > > device is put into 'unattached' in case it wasn't assigned a parent=
.
> > > > Usually it happens when board creates device directly. =20
> > >
> > >
> > > Sure, but if we decide that certain number(N) of vcpus are hotplugabb=
le
> > > and certain subset of N (say 'n' < 'N') should be allowed to be prese=
nt
> > > or cold-plugged at the init time then I wonder which of the following
> > > is correct approach:
> > >
> > > 1. Bring all of N vcpus at boot time under "peripheral" container
> > >                                    OR
> > > 2. Just bring subset 'n' of 'N' under "peripheral" container and rest
> > >     under "unattached" container? And later as and when rest of the
> > >     vcpus are hotplugged they should be transferred from "unattached"
> > >     container to "peripheral" container? =20
> >=20
> > issue with that is that to put device into "peripheral" container,
> > 'the user' must provide 'id'. (currently QEMU isn't able to do it on it=
s own
> > [1])
> >=20
> > But it doesn't mean that cold-plugged CPUs can't be unpluged.
> > What current users could do is start QEMU like this (simplified version=
):
> >=20
> >  $QEMU -smp 1,maxcpus=3DN -device foo-cpu-type,id=3DCPU00 -device
> > foo-cpu-type,id=3DCPU01 ...
> >=20
> > i.e. 1st CPU is not manageable due to lack if 'id' and is created by bo=
ard code,
> > the rest have 'id' and could be managed. =20
>=20
>=20
> I understand, that we can somehow assign ids from the QMP interface but
> above will not push vcpus into "peripheral" container. They will appear
> in "unattached" container but with specified names and as-far-as I can
> see in the code 'device_del' can only delete objects/devices from the
> 'peripheral' container?

qemu-system-x86_64 -monitor stdio \
    -smp 1,maxcpus=3D3 \
    -device qemu64-x86_64-cpu,id=3Dfoo,socket-id=3D1,core-id=3D0,thread-id=
=3D0 \
    -device qemu64-x86_64-cpu,socket-id=3D2,core-id=3D0,thread-id=3D0

(qemu) info hotpluggable-cpus=20
Hotpluggable CPUs:
  type: "qemu64-x86_64-cpu"
  vcpus_count: "1"
  qom_path: "/machine/peripheral-anon/device[0]"
                      ^^^^^^^^^^^^^^^
  CPUInstance Properties:
    socket-id: "2"
    core-id: "0"
    thread-id: "0"
  type: "qemu64-x86_64-cpu"
  vcpus_count: "1"
  qom_path: "/machine/peripheral/foo"
                      ^^^^^^^^^^

in gist, if device is created with any variant of device_add,
it goes to "peripheral[-anon]" including cold-plugged one.

  CPUInstance Properties:
    socket-id: "1"
    core-id: "0"
    thread-id: "0"
  type: "qemu64-x86_64-cpu"
  vcpus_count: "1"
  qom_path: "/machine/unattached/device[0]"
  CPUInstance Properties:
    socket-id: "0"
    core-id: "0"
    thread-id: "0"





>=20
> Plus, having those many ids specified for over large number of vcpus
> does not looks very practical solution. We need interface like auto
number of IDs is not a problem since it's usually handled by management
software just fine (ex: libvirt does it)

> Generation of ids even at the boot time. I could see from the link you
> have shared that it is already being used by ID_BLOCK subsystem. Can we
> create a new subsystem for cpus under this and do the auto Generation
> of vcpu ids as well?

I'm not sure that auto ids was actually merged.
(I thought it wasn't)

Anyway auto IDs are not directly related to enabling CPU hotplug for ARM,
if you feel they should be generated you can try to propose patches.

> > Question is:
> >   why you are looking into 'what container' is used for CPUs? =20
>=20
>=20
> Idea is to be able to use 'device_del' interface to unplug vcpus
> both for the cold-plugged and hot-plugged cases using the standard
> 'device_add' interface.

As far as CPU devices in QEMU are created with help of -device/device_add
with 'id' provided it should work with current code.

=20
> Plus, there is another unique requirement specifically for realizing
> vcpu hotplug for ARM64.
>=20
> Summary:
> Right now ARM architecture does not allows reinitializing the GIC
> after VM has booted. Therefore, we are planning to pre-size the GIC
> interfaces at init time by initializing all of the possible vcpus
> and keep them in 'realized' but 'unavailable' state to the Guest
> VM. They shall be made available as-and-when vcpus are hot-plugged
> later-on. Therefore, current efforts are to be able to plug and
> unplug from the qemu QOM without destroying the existing state of
> the devices/objects representing vcpus. These all possible vcpus
> shall be created once at the boot time of the VM. The vcpus which
> are not available to the Guest VM can be Parked.=20
>
> Once the vcpus are hot-(un)plug'ged only the (pre-)plug/unplug(-request)
> interfaces are used to convey this even information to the Guest
> VM.
>=20
> I have tested this solution and it works but I wanted to make sure
> that I am not doing anything which breaks any of the existing Qemu
> QOM interfaces and basic fundamental idea behind being able to attach
> and detach from the Qemu QOM is okay?
>=20
> Any suggestion are welcome in this regard?

From discussion with Drew [CCed], I got that kvm/arm isn't designed
to support vCPU hotplug (and it would require heavy refactoring to
separate GIC and VCPUs, which probably won't be welcomed by maintainers).

But that's only KVM side of the equation. Assuming that we don't
touch KVM much, the only QEMU side is left.

Further lets call
 * vCPU - a kvm's part of CPU
 * CPU - QEMU object which is linked to vCPU via file descriptor.

In QEMU we have CPU devices which optionally might create vCPUs
during device realize time (if QEMU runs with KVM accelerator).

So from design point of view, I'd suggest to dynamically
create/remove CPU devices on demand using existing
 -device/device_add/device_del interface
like we do for other architectures.

But in case of running with KVM accelerator, to accommodate
current non dynamic ARM/KVM, I'd move vCPU creation to "kvm_init()"
time or board init time, so it would pre-create vCPUs in
KVM early in parked state and put them in 'kvm_parked_vcpus' list
but won't create CPU devices for them.

Then later when management adds CPU device either with
'-device' or 'device_add', a new CPU device will pick up
pre-created parked vCPU file descriptor and re-use it.

Parked vCPU infrastructure is already exists in QEMU as we use it
for hot-unplugged CPUs for the same reasons (it needs too much
refactoring on KVM side to really remove vCPU).

So when CPU is hot-unplugged, we put linked vCPU file descriptor
into kvm_parked_vcpus (see: kvm_destroy_vcpu) and completely delete
CPU device on QEMU side. Then when the same CPU is hot-plugged again,
we reuse previously parked vCPU file descriptor (see: kvm_get_vcpu).


> NOTE: I plan to share the patches with the community which includes
> both the changes of the Linux Kernel and the QEMU in near future.
>=20
>=20
>=20
> > 1) here is what I could find on IDs topic
> >    https://lists.gnu.org/archive/html/qemu-block/2015-09/msg00011.html
> >  =20
> > > > >    if all the hotplug devices need to go under the *peripheral* c=
ontainer while
> > > > > they are hotplugged and during object init time as well? =20
> > > >
> > > > theoretically device_del may use QOM path (the later users can get =
with
> > > > query-hotpluggable-cpus),
> > > > but I think it's mostly debugging feature. =20
> > >
> > >
> > > Sure.
> > >
> > > =20
> > > > users are supposed to specify 'id' during -device/device_add if the=
y are going
> > > > to manage that device.
> > > > afterwards (like unplugging it). Then they could use that 'id' in o=
ther commands
> > > > (including device_del)
> > > >
> > > > So 'id'-ed devices end up in 'peripheral' container. =20
> > >
> > >
> > > Sure, what if hotplugged device is removed and then added again? It l=
ooks
> > > qmp_device_add() interface will again end up calling the device_set_r=
ealized()
> > > which eventually would put hotplugged devices under "unattached" cont=
ainer? =20
> >=20
> > it won't, see call chain:
> >=20
> >   qmp_device_add() =20
> >       -> qdev_device_add()
> >           -> qdev_set_id() =20
>=20
> Ok, sure. I did see the qdev_set_id() interface. Infact, earlier I was ac=
tually
> trying to play with it by making it more generic and adding even the 'una=
ttached'
> container handling to it(which is missing right now) and calling it insid=
e the
> device_set_realized()  instead of below code:
>=20
>         if (!obj->parent) {
>             gchar *name =3D g_strdup_printf("device[%d]", unattached_coun=
t++);
>=20
>             object_property_add_child(container_get(qdev_get_machine(),
>                                                     "/unattached"),
>                                       name, obj, &error_abort);
>             unattached_parent =3D true;
>             g_free(name);
>         }
>=20
> Idea of above dabbling was to have common interface for 'unattached' cont=
ainer
> and call it from virt.c from machvirt_init() where possible vcpus are bei=
ng
> created. Force them to be located either inside 'unttached' or 'periphera=
l'
> container akin to the example you had given.
>=20
> If we look at qdev_device_add() function, after setting dev->id using
> qdev_set_id() (which would also result in parenting of an object under
> 'peripheral' container), it calls the function to 'realize' the device/ob=
ject
> which would end up in hitting above shared code excerpt and now because
> it will have the parent already set, the object won't go into 'unattached=
'
> container.
>=20
> Currently, later cannot be controlled for the cold-lugged vcpus. Therefor=
e,
> before this discussion my initial thought process was to either make
> qdev_set_id() universal (i.e. include handling for all type of containers
> unattached/peripheral/anonymous in qdev_set_id()). Then call it from
> machvirt_init() just before the vcpus have been 'realized' so that
> cold-plugged cpus could get into 'peripheral' container. This would help
> in hot-unplugging using the standard 'device_del' interface.

I think we understand cold-plugged vcpus differently.
From QEMU point of view there are 2 kinds of cold-plugged CPU devices.

Ones that are currently created by board directly following pattern

 object_new()
 set properties
 relalize

these are created (lets call them builtin) in amount specified by -smp X
and are not manageable by external applications.

The second kind of cold-plugged CPUs are the ones created on command
line with help of:

 -device cpu-type-foo

these are created by management applications and could be hot-removed
if management supplied 'id'. For example libvirt starts qemu with 1
built-in cpu in paused mode (-s) QEMU, then it hotplugs via QMP N cpus
and lets VM run (it's essentially the same as using -device on CLI).
This way it can remove all CPUs except of 1st one which is good enough
in almost all the cases.

> Earlier, I was not sure if there was any special significance to the
> 'unattached' container - which by the discussion it looks there is not
> any and we could actually choose to place all of the cold-plugged vpus
> as well in the 'peripheral' container. Please correct me here if I
> have mis-understood anything here?
>=20
> Now, assuming we are allowed to push all of the vcpus in the 'peripheral'
> container then I could simply call unmodified qdev_set_id() just before
> the 'realization' of the cold-plugged vcpus. And maybe we could generate
> the cpus-ids using auto generate function which has been mentioned in the
> link you shared and just like it is being done for the block devices.

In ARM case, I'd consider to implementing -device/device_add support first.
So it would be on par with other architectures in QEMU that support cpu hot=
plug.

Then try to implement id auto-generation on top and discuss if making
built-in CPUs hot-removable is worthwhile, as it's a separate issues
and could be done later.

Separating feature on distinct self-sufficient chunks usually makes
reviews/merging easier comparing to trying to do everything at once.

> Thoughts?
>=20
>=20
> > > > > 3. I could not see any device being place under *anonymous* conta=
iner during =20
> > > > init time. What is the use of this container?
> > > >
> > > > if I recall it right, devices created with help of device_add but w=
ithout =20
> > 'id' =20
> > > > go to this container =20
> > >
> > >
> > > Any examples on top of your head where such an interface might be of =
use? =20
> >=20
> > ex:
> > one could use -device/device_add without any ids if such devices aren't=
 planned
> > to be unplugged during runtime or for unpluggable devices =20
>=20
> Ok. Thanks!
>=20
>=20
> Best Regards
> Salil
>=20


