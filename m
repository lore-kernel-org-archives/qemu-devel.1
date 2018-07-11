Received: from eggs.gnu.org ([2001:4830:134:3::10]:59032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fdLaX-0005Dq-4w
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 16:19:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fdLaU-00045z-0A
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 16:19:49 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:37488)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fdLaT-00045M-Rd
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 16:19:45 -0400
Received: by mail-qt0-x242.google.com with SMTP id a18-v6so22230415qtj.4
	for <qemu-devel@nongnu.org>; Wed, 11 Jul 2018 13:19:45 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180709091136.28849-1-e.emanuelegiuseppe@gmail.com>
	<20180709091136.28849-5-e.emanuelegiuseppe@gmail.com>
	<20180711145946.GO31228@stefanha-x1.localdomain>
	<2df3c7f1-3777-dbe9-80b9-8bf911a6eb60@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <522522c4-8ad5-501d-02a4-e9c7936ea2ef@amsat.org>
Date: Wed, 11 Jul 2018 17:19:41 -0300
MIME-Version: 1.0
In-Reply-To: <2df3c7f1-3777-dbe9-80b9-8bf911a6eb60@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 4/7] tests/qgraph: arm/raspi2 machine node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org

On 07/11/2018 12:30 PM, Paolo Bonzini wrote:
> On 11/07/2018 16:59, Stefan Hajnoczi wrote:
>>> +    machine->obj.get_device = raspi2_get_device;
>>> +    machine->obj.destructor = raspi2_destroy;
>>> +    qos_create_sdhci_mm(&machine->sdhci, 0x3f300000, &(QSDHCIProperties) {
>>> +        .version = 3,
>>> +        .baseclock = 52,
>>> +        .capab.sdma = false,
>>> +        .capab.reg = 0x052134b4
>>> +    });
>>> +    return &machine->obj;
>>> +}
>>> +
>>> +static void raspi2(void)
>>> +{
>>> +    qos_node_create_machine("arm/raspi2", qos_create_machine_arm_raspi2);
>>> +    qos_node_contains("arm/raspi2", "generic-sdhci");
>>> +}
>>> +
>>> +libqos_init(raspi2);
>> Hmm...I didn't realize it would be necessary to manually define each
>> machine type.  I thought qgraph would use qemu-system-x86_64
>> -machine/-device/info qtree to introspect QEMU and instantiate the
>> appropriate drivers.
> 
> That doesn't provide enough information yet.  However, PCI devices are
> already discovered automatically and the next step (next year :)) could
> be to use device tree or ACPI to discover embedded devices.
> 
> Using QOM properties instead of duplicating things like QSDHCIProperties
> is a great idea.  Of course the duplication was already there ("old
> sdhci_t structure" in patch 7), so I don't think it should be a blocker,
> but indeed there's a better way to do it.
> 
>> My concern is that this manual approach of defining machines complicates
>> qtests.  This file will need to be modified by multiple people - each of
>> them will be interested in a specific driver and not interested in the
>> driver that other people have added.
> 
> This is exactly the opposite problem that we have now: when you write a
> test you are interested typically only in one machine, and the
> "if(x86)elseif(arm)" gets in the way.  (Also: it's also difficult to
> split the ifs across files, i.e. it scales worse; and there's lots of
> duplicated code across tests to do "for" loops of g_test_add, because
> the ifs don't lend itself to "automatic" generation of test cases via
> path walk).
> 
> The advantage is that (just like for OS vs. QEMU) the structure of this
> file matches closely the board files in hw/arm/, which is something you
> should already be familiar with if you're adding a new board to QEMU.

Some projects organize their tests alongside the source to be tested.
This is often messy, but might be clearer to see source testing coverage.
That said, I'd rather keep it out of 'source' tree (as of now). Using a
simple script we can notice the same (which device models matches a test).
