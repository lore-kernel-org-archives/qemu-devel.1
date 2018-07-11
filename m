Received: from eggs.gnu.org ([2001:4830:134:3::10]:56553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fdH4m-0002L2-5L
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 11:30:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fdH4i-0004Aw-Sm
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 11:30:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44112 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fdH4i-0004An-N6
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 11:30:40 -0400
References: <20180709091136.28849-1-e.emanuelegiuseppe@gmail.com>
	<20180709091136.28849-5-e.emanuelegiuseppe@gmail.com>
	<20180711145946.GO31228@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2df3c7f1-3777-dbe9-80b9-8bf911a6eb60@redhat.com>
Date: Wed, 11 Jul 2018 17:30:35 +0200
MIME-Version: 1.0
In-Reply-To: <20180711145946.GO31228@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/7] tests/qgraph: arm/raspi2 machine node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Cc: Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

On 11/07/2018 16:59, Stefan Hajnoczi wrote:
>> +    machine->obj.get_device =3D raspi2_get_device;
>> +    machine->obj.destructor =3D raspi2_destroy;
>> +    qos_create_sdhci_mm(&machine->sdhci, 0x3f300000, &(QSDHCIProperti=
es) {
>> +        .version =3D 3,
>> +        .baseclock =3D 52,
>> +        .capab.sdma =3D false,
>> +        .capab.reg =3D 0x052134b4
>> +    });
>> +    return &machine->obj;
>> +}
>> +
>> +static void raspi2(void)
>> +{
>> +    qos_node_create_machine("arm/raspi2", qos_create_machine_arm_rasp=
i2);
>> +    qos_node_contains("arm/raspi2", "generic-sdhci");
>> +}
>> +
>> +libqos_init(raspi2);
> Hmm...I didn't realize it would be necessary to manually define each
> machine type.  I thought qgraph would use qemu-system-x86_64
> -machine/-device/info qtree to introspect QEMU and instantiate the
> appropriate drivers.

That doesn't provide enough information yet.  However, PCI devices are
already discovered automatically and the next step (next year :)) could
be to use device tree or ACPI to discover embedded devices.

Using QOM properties instead of duplicating things like QSDHCIProperties
is a great idea.  Of course the duplication was already there ("old
sdhci_t structure" in patch 7), so I don't think it should be a blocker,
but indeed there's a better way to do it.

> My concern is that this manual approach of defining machines complicate=
s
> qtests.  This file will need to be modified by multiple people - each o=
f
> them will be interested in a specific driver and not interested in the
> driver that other people have added.

This is exactly the opposite problem that we have now: when you write a
test you are interested typically only in one machine, and the
"if(x86)elseif(arm)" gets in the way.  (Also: it's also difficult to
split the ifs across files, i.e. it scales worse; and there's lots of
duplicated code across tests to do "for" loops of g_test_add, because
the ifs don't lend itself to "automatic" generation of test cases via
path walk).

The advantage is that (just like for OS vs. QEMU) the structure of this
file matches closely the board files in hw/arm/, which is something you
should already be familiar with if you're adding a new board to QEMU.

Paolo
