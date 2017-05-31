Received: from eggs.gnu.org ([2001:4830:134:3::10]:39693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dG3Wl-0008PF-6p
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:19:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dG3Wf-0006kg-Nv
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:19:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37176)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dG3Wf-0006kS-FS
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:19:01 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170509173559.31598-1-marcandre.lureau@redhat.com>
	<20170509173559.31598-12-marcandre.lureau@redhat.com>
	<87inkz50n3.fsf@dusky.pond.sub.org>
	<CAJ+F1CK5OgaH6SRcPnhPxrHOWHq3YE28o3y_+tPwJsYkT5PsSQ@mail.gmail.com>
Date: Wed, 31 May 2017 15:18:58 +0200
In-Reply-To: <CAJ+F1CK5OgaH6SRcPnhPxrHOWHq3YE28o3y_+tPwJsYkT5PsSQ@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 30 May 2017
	13:58:09 +0000")
Message-ID: <87inkh88ql.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 11/17] object: use more specific property
 type names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Wed, May 17, 2017 at 12:50 PM Markus Armbruster <armbru@redhat.com>
> wrote:
>
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>
>> > Use the actual unsigned integer type name (this should't break since
>> > property type aren't directly accessed from outside it seems).
>>
>> I'm not sure I understand the parenthesis.  Do you mean changing the
>> type names is safe because they're used only in a certain way?  Which
>> way?
>>
>
> It looks like prop->type is only used internally by qom/object.c and not
> exposed to QMP or other internal APIs, it would be nice if someone more
> familiar with it could confirm.

I see.  I can have a look once I'm done catching up with your replies.

>> How did you find the names that need fixing?
>
> Mostly by grepping and reviewing the code, I don't have a better approach=
..

Can't think of a better way offhand.  If something comes to me, I'll let
you know.  Thanks for going the extra mile!

>> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> > ---
>> >  backends/cryptodev.c |  2 +-
>> >  hw/pci-host/piix.c   |  8 ++++----
>> >  hw/pci-host/q35.c    | 10 +++++-----
>> >  hw/ppc/pnv.c         |  2 +-
>> >  net/dump.c           |  2 +-
>> >  net/filter-buffer.c  |  2 +-
>> >  6 files changed, 13 insertions(+), 13 deletions(-)
>> >
>> > diff --git a/backends/cryptodev.c b/backends/cryptodev.c
>> > index 832f056266..1764c179fe 100644
>> > --- a/backends/cryptodev.c
>> > +++ b/backends/cryptodev.c
>> > @@ -222,7 +222,7 @@ cryptodev_backend_can_be_deleted(UserCreatable *uc=
, Error **errp)
>> >
>> >  static void cryptodev_backend_instance_init(Object *obj)
>> >  {
>> > -    object_property_add(obj, "queues", "int",
>> > +    object_property_add(obj, "queues", "uint32",
>> >                            cryptodev_backend_get_queues,
>> >                            cryptodev_backend_set_queues,
>> >                            NULL, NULL, NULL);
>>
>> Correct, because the callbacks access struct CryptoDevBackendPeers
>> member queues, which is uint32_t.
>>
>> The callbacks pass a local variable instead of the struct member to the
>> visitor.  Problematic, because it weakens the type checking we get from
>> the compiler.  Let's tighten it up:
>>
>>    static void
>>    cryptodev_backend_get_queues(Object *obj, Visitor *v, const char *nam=
e,
>>                                 void *opaque, Error **errp)
>>    {
>>        CryptoDevBackend *backend =3D CRYPTODEV_BACKEND(obj);
>>   -    uint32_t value =3D backend->conf.peers.queues;
>>
>>   -    visit_type_uint32(v, name, &value, errp);
>>   +    visit_type_uint32(v, name, &backend->conf.peers.queues, errp);
>>    }
>>
>>    static void
>>    cryptodev_backend_set_queues(Object *obj, Visitor *v, const char *nam=
e,
>>                                 void *opaque, Error **errp)
>>    {
>>        CryptoDevBackend *backend =3D CRYPTODEV_BACKEND(obj);
>>        Error *local_err =3D NULL;
>>   -    uint32_t value;
>>
>>   -    visit_type_uint32(v, name, &value, &local_err);
>>   +    visit_type_uint32(v, name, &backend->conf.peers.queues, &local_er=
r);
>>        if (local_err) {
>>            goto out;
>>        }
>>   -    if (!value) {
>>   +    if (!backend->conf.peers.queues) {
>>            error_setg(&local_err, "Property '%s.%s' doesn't take value '=
%"
>>   -                   PRIu32 "'", object_get_typename(obj), name, value);
>>   +                   PRIu32 "'", object_get_typename(obj), name,
>>   +                   backend->conf.peers.queues);
>>   -        goto out;
>>        }
>>   -    backend->conf.peers.queues =3D value;
>>   -out:
>>        error_propagate(errp, local_err);
>>    }
>>
>> If we need to preserve backend->conf.peers.queue on an attempt to set it
>> to zero, things get a bit more complicated.  But having the compiler
>> enforce the visitor matches the member type exactly is worth it, in my
>> opinion.
>>
>> Separate patch, not necessarily in this series.
>>
>> > diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
>> > index f9218aa952..9aed6225bf 100644
>> > --- a/hw/pci-host/piix.c
>> > +++ b/hw/pci-host/piix.c
>> > @@ -279,19 +279,19 @@ static void i440fx_pcihost_initfn(Object *obj)
>> >      memory_region_init_io(&s->data_mem, obj, &pci_host_data_le_ops, s,
>> >                            "pci-conf-data", 4);
>> >
>> > -    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_START, "int",
>> > +    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_START, "uint32",
>> >                          i440fx_pcihost_get_pci_hole_start,
>> >                          NULL, NULL, NULL, NULL);
>> >
>> > -    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_END, "int",
>> > +    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_END, "uint32",
>> >                          i440fx_pcihost_get_pci_hole_end,
>> >                          NULL, NULL, NULL, NULL);
>> >
>> > -    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE64_START, "int",
>> > +    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE64_START, "uint64",
>> >                          i440fx_pcihost_get_pci_hole64_start,
>> >                          NULL, NULL, NULL, NULL);
>> >
>> > -    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE64_END, "int",
>> > +    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE64_END, "uint64",
>> >                          i440fx_pcihost_get_pci_hole64_end,
>> >                          NULL, NULL, NULL, NULL);
>> >  }
>>
>> These look good.  The underlying values are 64 bits, but the 32 bit
>> callbacks assert they fit into 32.
>>
>> > diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
>> > index 344f77b10c..5438be8253 100644
>> > --- a/hw/pci-host/q35.c
>> > +++ b/hw/pci-host/q35.c
>> > @@ -176,23 +176,23 @@ static void q35_host_initfn(Object *obj)
>> >      qdev_prop_set_uint32(DEVICE(&s->mch), "addr", PCI_DEVFN(0, 0));
>> >      qdev_prop_set_bit(DEVICE(&s->mch), "multifunction", false);
>> >
>> > -    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_START, "int",
>> > +    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_START, "uint32",
>> >                          q35_host_get_pci_hole_start,
>> >                          NULL, NULL, NULL, NULL);
>> >
>> > -    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_END, "int",
>> > +    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_END, "uint32",
>> >                          q35_host_get_pci_hole_end,
>> >                          NULL, NULL, NULL, NULL);
>> >
>> > -    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE64_START, "int",
>> > +    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE64_START, "uint64",
>> >                          q35_host_get_pci_hole64_start,
>> >                          NULL, NULL, NULL, NULL);
>> >
>> > -    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE64_END, "int",
>> > +    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE64_END, "uint64",
>> >                          q35_host_get_pci_hole64_end,
>> >                          NULL, NULL, NULL, NULL);
>>
>> Likewise.
>>
>> >
>> > -    object_property_add(obj, PCIE_HOST_MCFG_SIZE, "int",
>> > +    object_property_add(obj, PCIE_HOST_MCFG_SIZE, "uint32",
>> >                          q35_host_get_mmcfg_size,
>> >                          NULL, NULL, NULL, NULL);
>>
>> This one leads to a bug, I think:
>>
>>    static void q35_host_get_mmcfg_size(Object *obj, Visitor *v, const ch=
ar
>> *name,
>>                                        void *opaque, Error **errp)
>>    {
>>        PCIExpressHost *e =3D PCIE_HOST_BRIDGE(obj);
>>        uint32_t value =3D e->size;
>>
>>        visit_type_uint32(v, name, &value, errp);
>>    }
>>
>> e->size is hwaddr, i.e. uint64_t.  We silently truncate.
>>
>> Demonstrates that the detour through a separate variable breeds bugs and
>> should be avoided.
>>
>> Suggested fix:
>>
>>    static void q35_host_get_mmcfg_size(Object *obj, Visitor *v, const ch=
ar
>> *name,
>>                                        void *opaque, Error **errp)
>>    {
>>        PCIExpressHost *e =3D PCIE_HOST_BRIDGE(obj);
>>   -    uint32_t value =3D e->size;
>>
>>   -    visit_type_uint64(v, name, &value, errp);
>>   +    visit_type_uint64(v, name, &e->size, errp);
>>    }
>>
>> You then have to change the type name to "uint64" instead of "uint32",
>> of course.
>>
>
> Ok, although this bug exist before the type name change, right? I'll make
> it a seperate patch

Yes, please.

[...]
