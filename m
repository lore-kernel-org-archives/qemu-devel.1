Received: from eggs.gnu.org ([2001:4830:134:3::10]:33914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fqMpH-0007pE-0Y
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 14:16:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fqMpG-0003By-0m
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 14:16:50 -0400
References: <20180813101453.10200-1-e.emanuelegiuseppe@gmail.com>
	<87wosrkdnh.fsf@dusky.pond.sub.org>
From: Emanuele <e.emanuelegiuseppe@gmail.com>
Message-ID: <7cfe877a-b90c-9828-001e-081ff83fcbe7@gmail.com>
Date: Thu, 16 Aug 2018 20:16:38 +0200
MIME-Version: 1.0
In-Reply-To: <87wosrkdnh.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 00/33] Qtest driver framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Amit Shah <amit@kernel.org>, Alexander Graf <agraf@suse.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On 15/08/2018 14:38, Markus Armbruster wrote:
> Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com> writes:
>
>> Qgraph API for the qtest driver framework
>>
>> This series of patches introduce a different qtest driver
>> organization, viewing machines, drivers and tests as node in a
>> graph, each having one or multiple edges relations.
>>
>> The idea is to have a framework where each test asks for a specific
>> driver, and the framework takes care of allocating the proper devices
>> required and passing the correct command line arguments to QEMU.
>>
>> A node can be of four types:
>> - MACHINE:   for example "arm/raspi2"
>> - DRIVER:    for example "generic-sdhci"
>> - INTERFACE: for example "sdhci" (interface for all "-sdhci" drivers)
>> - TEST:      for example "sdhci-test", consumes an interface and tests
>>               the functions provided
>>
>> An edge relation between two nodes (drivers or machines) X and Y can be:
>> - X CONSUMES Y: Y can be plugged into X
>> - X PRODUCES Y: X provides the interface Y
>> - X CONTAINS Y: Y is part of X component
>>
>> Basic framework steps are the following:
>> - All nodes and edges are created in their respective machine/driver/test files
>> - The framework starts QEMU and asks for a list of available devices
>>    and machines
>> - The framework walks the graph starting from the available machines and
>>    performs a Depth First Search for tests
>> - Once a test is found, the path is walked again and all drivers are
>>    allocated accordingly and the final interface is passed to the test
>> - The test is executed
>> - Unused objects are cleaned and the path discovery is continued
>>
>> Depending on the QEMU binary used, only some drivers/machines will be available
>> and only test that are reached by them will be executed.
>>
>> This work is being done as Google Summer of Code 2018 project for QEMU,
>> my mentors are Paolo Bonzini and Laurent Vivier.
>> Additional infos on the project can be found at:
>> https://wiki.qemu.org/Features/qtest_driver_framework
> You've likely answered this question somewhere already, but it should be
> answered right here: what does this framework buy us?
>
> I figure the main benefit is running tests in all possible contexts,
> with automated context setup.  Instead, you feed the framework
> declarations of how things are related (the graph stuff described
> above).
You're right, that is the main benefit: running tests in all possible 
contexts, with automated context setup.
Before, tests where basically hard-coded to run on a single 
architecture, or even a single machine type.
Now, qgraph allows this kind of higher level view of the devices and 
their relationships, where tests generally consume an interface that 
hides the underneath implementation (for example, for sdhci-pci device, 
it consumes a "pci-bus", without knowing that the bus can be a pci-pc or 
pci-spapr).

This allows developers to add test without knowing or forcing the 
machine/architecture/additional required devices, they just need to know 
what interface the test can consume (and if not present, implement a 
node representing the device they want to test).
For example, if you look at virtio-9p-test, you can see that the old 
test was just testing "virtio-9p-pci", while using the qgraph I was able 
to add "virtio-9p-device" too, without any additional change to the 
test, improving test coverage.

The other benefit is the automated context setup: as Paolo said once, 
every test basically re-invented the wheel in its own way. Every test 
had a main function, a section where qemu was started with proper 
devices, and a section where everything was cleaned up and shut down. 
Qgraph handles all these operations automatically, so the developer does 
not need to care about that. Just add the test function to the graph, 
and it will take care of running the test with the proper setup.

Of course this requires a minimal knowledge of the graph and the 
relationships you are going to use, since each test will receive 
structures representing device from the other nodes in the graph.
> Taking a step back: your cover letter describes a solution at a high
> level.  That's good.  But it should *first* describe the problem you're
> trying to solve.
Do you think this explanation of the problem is fine?

I am not very experienced with patches, so in case it is, should I 
re-write the cover letter adding the above explanations or is fine like 
this? In case I should do it, should I submit the whole series again?
>> v3:
>> - Minor fixes regarding memory leaks and naming
>>
>> Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
