Received: from eggs.gnu.org ([2001:4830:134:3::10]:58365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffTLM-0006yc-4S
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 13:00:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffTLJ-0003Zc-14
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 13:00:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48892 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ffTLI-0003Yx-Ps
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 13:00:52 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0FF1F40122B3
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 17:00:52 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <eb90a7b9-5a02-b9f7-c989-f646a272c4f3@redhat.com> (Thomas Huth's
	message of "Tue, 17 Jul 2018 14:18:12 +0200")
References: <20180717120414.5852-1-quintela@redhat.com>
	<eb90a7b9-5a02-b9f7-c989-f646a272c4f3@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 17 Jul 2018 19:00:48 +0200
Message-ID: <87601dztj3.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC 00/14] More patches to disable stuff
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

Thomas Huth <thuth@redhat.com> wrote:
> On 17.07.2018 14:04, Juan Quintela wrote:
>> Hi
>> 
>> Notice that this is an RFC because they don't work.  As said on my
>> previous submmision, we need <foo>-softmmu/config-devices.h to make
>> this work.  This series just allow us to disable the devices, but not
>> to enable it back O:-)
>> 
>> Notice:
>> 
>> - scsi stuff: we are testing they in cdrom-test.c, so we need to be
>>   able to config them out.  Notice also that #ifdefs only go in tests/<...>
>> 
>> - virtio stuff: see how we need to also change hw/virtio/virtio-pci.c
>>   to disable it.  The problem appears in the device-instropect-test.c.
>>   As they are defined in the binary, but not complied in.  We can
>>   change for a registration appreach, but that is more work that what
>>   I intended for this series.
>> 
>> What do you think?
>
> I think this is the wrong way to go. If you add #ifdefs to the sources,
> you have to make the binaries target-specific. Currently each test
> binary can work for each target architecture. With #ifdefs, that's not
> possible anymore. So please don't do that.

As the system goes now, you have something enabled if it is enabled for
any _configuration_, that is what config-all-devices.mak is supposed to
do.

> If you want to make the tests more flexible for configuration, please
> use QOM instead to check whether the devices are available or not.

QOM is the problem, not the solution (TM).  Uninteresting bits deleted.

tests/device-instrospect-test.c

static void test_device_intro_concrete(void)
{
    ...
    types = device_type_list(false);
    ...
}

static QList *device_type_list(bool abstract)
{
    return qom_list_types("device", abstract);
}

static QList *qom_list_types(const char *implements, bool abstract)
{
    QDict *resp;
    QList *ret;
    QDict *args = qdict_new();

    qdict_put_bool(args, "abstract", abstract);
    if (implements) {
        qdict_put_str(args, "implements", implements);
    }
    resp = qmp("{'execute': 'qom-list-types',"
               " 'arguments': %p }", args);
    g_assert(qdict_haskey(resp, "return"));
    ret = qdict_get_qlist(resp, "return");
    qobject_ref(ret);
    qobject_unref(resp);
    return ret;
}

If I disable CONFIG_VIRTIO_RNG, then I don't compile
common-obj-$(CONFIG_VIRTIO_RNG) += virtio-rng.o

So far so good, but look at virtio-pci.c:

static void virtio_rng_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
{
   ...
}

static void virtio_rng_pci_class_init(ObjectClass *klass, void *data)
{
   ....
}

static void virtio_rng_initfn(Object *obj)
{
   ...
}

static const TypeInfo virtio_rng_pci_info = {
    .name          = TYPE_VIRTIO_RNG_PCI,
    .parent        = TYPE_VIRTIO_PCI,
    .instance_size = sizeof(VirtIORngPCI),
    .instance_init = virtio_rng_initfn,
    .class_init    = virtio_rng_pci_class_init,
};

static void virtio_pci_register_types(void)
{
    type_register_static(&virtio_rng_pci_info);
...
}

See, we have defined the device "virtio-rng-pci", but there is no
implementation.  WHen I run device-intronspection-test on that qemu with
CONFIG_VIRTIO_RNG, it fails to run.  If we can agree that something is
wrong, then we can search for a solution.  I send this patches as an RFC
to ask for what people think is the best solution, or if we should even
bother in fix that.

Later, JUan.
