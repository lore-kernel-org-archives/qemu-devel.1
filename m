Received: from eggs.gnu.org ([2001:4830:134:3::10]:56655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fnh7l-0004ph-5j
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 05:20:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fnh7h-0000ot-S7
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 05:20:53 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:45016)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <e.emanuelegiuseppe@gmail.com>)
	id 1fnh7h-0000oB-GP
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 05:20:49 -0400
Received: by mail-ed1-x542.google.com with SMTP id f23-v6so2523839edr.11
	for <qemu-devel@nongnu.org>; Thu, 09 Aug 2018 02:20:49 -0700 (PDT)
References: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
	<e165d2c3-814d-e8b5-3691-af0225ee981d@redhat.com>
From: Emanuele <e.emanuelegiuseppe@gmail.com>
Message-ID: <581443fd-c054-06ad-94d6-7285b2713cd6@gmail.com>
Date: Thu, 9 Aug 2018 11:20:46 +0200
MIME-Version: 1.0
In-Reply-To: <e165d2c3-814d-e8b5-3691-af0225ee981d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 00/34] Qtest driver framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>



On 08/09/2018 10:57 AM, Paolo Bonzini wrote:
> On 06/08/2018 16:33, Emanuele Giuseppe Esposito wrote:
>> qgraph API for the qtest driver framework
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
> Tests are not cleaning up properly.  There are two bugs, both related to
> qtest_end not being called (from main in one case, after
> qos_invalidate_command_line in the other).  I tried this fix but then
> the e1000e tests start failing:
>
> diff --git a/tests/libqtest.h b/tests/libqtest.h
> index ac52872..7a6fa6e 100644
> --- a/tests/libqtest.h
> +++ b/tests/libqtest.h
> @@ -555,6 +555,9 @@ static inline QTestState *qtest_start(const char *args)
>    */
>   static inline void qtest_end(void)
>   {
> +    if (!global_qtest) {
> +        return;
> +    }
>       qtest_quit(global_qtest);
>       global_qtest = NULL;
>   }
> diff --git a/tests/qos-test.c b/tests/qos-test.c
> index 1c3a7fc..a22d176 100644
> --- a/tests/qos-test.c
> +++ b/tests/qos-test.c
> @@ -233,10 +233,7 @@ static void restart_qemu_or_continue(char *path)
>       * new command line
>       */
>       if (g_strcmp0(old_path, path)) {
> -        if (old_path) {
> -            qtest_end();
> -            g_free(old_path);
> -        }
> +        qtest_end();
Why this? Shouldn't it be:

if (g_strcmp0(old_path, path)) {
         qtest_end(); /* handles global_qtest = NULL */
         g_free(old_path); /* handles NULL */
         old_path = path;
         global_qtest = qtest_start(path);
} else ....

>           old_path = path;
>           global_qtest = qtest_start(path);
>       } else { /* if cmd line is the same, reset the guest */
> @@ -247,7 +244,10 @@ static void restart_qemu_or_continue(char *path)
>   
>   void qos_invalidate_command_line(void)
>   {
> -    old_path = NULL;
> +    if (old_path) {
> +        g_free(old_path);
> +        old_path = NULL;
> +    }
>   }
Same here, just

{
     g_free(old_path);
     old_path=NULL;
}

  should be enough I think.
>   
>   /**
> @@ -475,6 +475,7 @@ int main(int argc, char **argv)
>   
>       qos_graph_foreach_test_path(walk_path);
>       g_test_run();
> +    qtest_end();
>       qos_graph_destroy();
>       return 0;
>   }
>
>
> Also, qos-test can be added to check-qtest-generic-y, since it is not
> PCI-specific.
>
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 14f19eb..6012f6e 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -182,6 +182,7 @@ gcov-files-generic-y = monitor.c qapi/qmp-dispatch.c
>   check-qtest-generic-y += tests/device-introspect-test$(EXESUF)
>   gcov-files-generic-y = qdev-monitor.c qmp.c
>   check-qtest-generic-y += tests/cdrom-test$(EXESUF)
> +check-qtest-generic-y += tests/qos-test$(EXESUF)
>   
>   gcov-files-ipack-y += hw/ipack/ipack.c
>   check-qtest-ipack-y += tests/ipoctal232-test$(EXESUF)
> @@ -790,9 +791,6 @@ libqgraph-tests-obj-y += tests/virtio-scsi-test.o
>   check-unit-y += tests/test-qgraph$(EXESUF)
>   tests/test-qgraph$(EXESUF): tests/test-qgraph.o $(libqgraph-obj-y)
>   
> -check-qtest-pci-y += tests/qos-test$(EXESUF)

> -tests/qos-test$(EXESUF): tests/qos-test.o $(libqgraph-tests-obj-y)
Why did you comment this line? To me it does not compile without it.
> -
>   tests/qmp-test$(EXESUF): tests/qmp-test.o
>   tests/device-introspect-test$(EXESUF): tests/device-introspect-test.o
>   tests/rtc-test$(EXESUF): tests/rtc-test.o
>
> Another small bug is that virtio-net-test should also call
> qos_invalidate_command_line, since it is closing the socket that
> is opened in virtio_net_test_setup.
Right, I forgot. Also virtio-blk-test needs to do it.

I tried to apply your changes with my suggested modifications, and 
everything seems to work to me.
>> v2:
>> - added command line arguments caching
>> - converted all virtio tests
>> - converted e1000e test
>> - added two more machines (virt and ppc64)
>> - introduced separation between edge-name (used by get_driver) and
>>    node-name (matched with QMP query result)
>> - edge carries also additional arguments, like the pci address of
>>    destination device
>> - test now can execute a function before and after the command line
>>    is allocated, to allocate various file and sockets needed by command
>>    line and test
>> - better documentation with working example in qgraph.h
>> - removed esplicit creation of interfaces
>>
>> Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
>>
>> Emanuele Giuseppe Esposito (33):
>>    tests: qgraph API for the qtest driver framework
>>    tests/qgraph: rename qpci_init_pc functions
>>    tests/qgraph: pci-pc driver and interface nodes
>>    tests/qgraph: x86_64/pc machine node
>>    tests/qgraph: sdhci driver and interface nodes
>>    tests/qgraph: sdhci test node
>>    tests/qgraph: arm/raspi2 machine node
>>    tests/qgraph: rename qpci_init_spapr functions
>>    tests/qgraph: pci-spapr driver and interface nodes
>>    tests/qgraph: ppc64/pseries machine node
>>    test/qgraph: e1000e driver and interface nodes
>>    test/qgraph: e1000e-test node
>>    test/qgraph: virtio_start_device function
>>    test/qgraph: virtio-pci driver and interface nodes
>>    tests/qgraph: rename qvirtio_mmio_init_device functions
>>    test/qgraph: virtio-mmio driver and interface nodes
>>    test/qgraph: arm/virt machine node
>>    test/qgraph: virtio-serial driver and interface nodes
>>    test/qgraph: virtio-console test node
>>    test/qgraph: virtio-serial test node
>>    test/qgraph: virtio-9p driver and interface nodes
>>    test/qgraph: virtio-9p test node
>>    test/qgraph: virtio-balloon driver and interface nodes
>>    test/qgraph: virtio-balloon test node
>>    test/qgraph: virtio-rng driver and interface nodes
>>    test/qgraph: virtio-rng test node
>>    test/qgraph: virtio-blk driver and interface nodes
>>    test/qgraph: virtio-blk test node
>>    test/qgraph: virtio-net driver and interface nodes
>>    test/qgraph: virtio-net test node
>>    test/qgraph: virtio-scsi driver and interface nodes
>>    test/qgraph: virtio-scsi test node
>>    test/qgraph: temporarly commented vhost-user-test
>>
>> Paolo Bonzini (1):
>>    tests: virtio: separate ccw tests from libqos
>>
>>   configure                            |   2 +-
>>   include/qemu/module.h                |   2 +
>>   tests/Makefile.include               |  79 +--
>>   tests/e1000e-test.c                  | 354 +++----------
>>   tests/i440fx-test.c                  |   2 +-
>>   tests/ide-test.c                     |   2 +-
>>   tests/libqos/ahci.c                  |   2 +-
>>   tests/libqos/e1000e.c                | 262 ++++++++++
>>   tests/libqos/e1000e.h                |  53 ++
>>   tests/libqos/libqos-pc.c             |   2 +-
>>   tests/libqos/libqos-spapr.c          |   2 +-
>>   tests/libqos/pci-pc.c                |  41 +-
>>   tests/libqos/pci-pc.h                |  22 +-
>>   tests/libqos/pci-spapr.c             |  57 ++-
>>   tests/libqos/pci-spapr.h             |  26 +-
>>   tests/libqos/pci.c                   |  48 +-
>>   tests/libqos/pci.h                   |  15 +
>>   tests/libqos/ppc64_pseries-machine.c | 111 +++++
>>   tests/libqos/qgraph.c                | 721 +++++++++++++++++++++++++++
>>   tests/libqos/qgraph.h                | 514 +++++++++++++++++++
>>   tests/libqos/qgraph_extra.h          | 263 ++++++++++
>>   tests/libqos/raspi2-machine.c        |  82 +++
>>   tests/libqos/sdhci.c                 | 163 ++++++
>>   tests/libqos/sdhci.h                 |  69 +++
>>   tests/libqos/virt-machine.c          |  90 ++++
>>   tests/libqos/virtio-9p.c             | 164 ++++++
>>   tests/libqos/virtio-9p.h             |  42 ++
>>   tests/libqos/virtio-balloon.c        | 111 +++++
>>   tests/libqos/virtio-balloon.h        |  39 ++
>>   tests/libqos/virtio-blk.c            | 126 +++++
>>   tests/libqos/virtio-blk.h            |  40 ++
>>   tests/libqos/virtio-mmio.c           |  72 ++-
>>   tests/libqos/virtio-mmio.h           |   6 +-
>>   tests/libqos/virtio-net.c            | 177 +++++++
>>   tests/libqos/virtio-net.h            |  41 ++
>>   tests/libqos/virtio-pci.c            |  80 ++-
>>   tests/libqos/virtio-pci.h            |  12 +
>>   tests/libqos/virtio-rng.c            | 108 ++++
>>   tests/libqos/virtio-rng.h            |  39 ++
>>   tests/libqos/virtio-scsi.c           | 117 +++++
>>   tests/libqos/virtio-scsi.h           |  39 ++
>>   tests/libqos/virtio-serial.c         | 109 ++++
>>   tests/libqos/virtio-serial.h         |  39 ++
>>   tests/libqos/virtio.c                |   9 +
>>   tests/libqos/virtio.h                |   1 +
>>   tests/libqos/x86_64_pc-machine.c     | 110 ++++
>>   tests/q35-test.c                     |   4 +-
>>   tests/qos-test.c                     | 480 ++++++++++++++++++
>>   tests/rtl8139-test.c                 |   2 +-
>>   tests/sdhci-test.c                   | 222 +++------
>>   tests/tco-test.c                     |   2 +-
>>   tests/test-qgraph.c                  | 446 +++++++++++++++++
>>   tests/usb-hcd-ehci-test.c            |   2 +-
>>   tests/vhost-user-test.c              |   7 +-
>>   tests/virtio-9p-test.c               | 221 +++-----
>>   tests/virtio-balloon-test.c          |  22 +-
>>   tests/virtio-blk-test.c              | 473 +++++++-----------
>>   tests/virtio-ccw-test.c              | 121 +++++
>>   tests/virtio-console-test.c          |  30 +-
>>   tests/virtio-net-test.c              | 163 ++----
>>   tests/virtio-rng-test.c              |  25 +-
>>   tests/virtio-scsi-test.c             | 155 +++---
>>   tests/virtio-serial-test.c           |  27 +-
>>   63 files changed, 5624 insertions(+), 1243 deletions(-)
>>   create mode 100644 tests/libqos/e1000e.c
>>   create mode 100644 tests/libqos/e1000e.h
>>   create mode 100644 tests/libqos/ppc64_pseries-machine.c
>>   create mode 100644 tests/libqos/qgraph.c
>>   create mode 100644 tests/libqos/qgraph.h
>>   create mode 100644 tests/libqos/qgraph_extra.h
>>   create mode 100644 tests/libqos/raspi2-machine.c
>>   create mode 100644 tests/libqos/sdhci.c
>>   create mode 100644 tests/libqos/sdhci.h
>>   create mode 100644 tests/libqos/virt-machine.c
>>   create mode 100644 tests/libqos/virtio-9p.c
>>   create mode 100644 tests/libqos/virtio-9p.h
>>   create mode 100644 tests/libqos/virtio-balloon.c
>>   create mode 100644 tests/libqos/virtio-balloon.h
>>   create mode 100644 tests/libqos/virtio-blk.c
>>   create mode 100644 tests/libqos/virtio-blk.h
>>   create mode 100644 tests/libqos/virtio-net.c
>>   create mode 100644 tests/libqos/virtio-net.h
>>   create mode 100644 tests/libqos/virtio-rng.c
>>   create mode 100644 tests/libqos/virtio-rng.h
>>   create mode 100644 tests/libqos/virtio-scsi.c
>>   create mode 100644 tests/libqos/virtio-scsi.h
>>   create mode 100644 tests/libqos/virtio-serial.c
>>   create mode 100644 tests/libqos/virtio-serial.h
>>   create mode 100644 tests/libqos/x86_64_pc-machine.c
>>   create mode 100644 tests/qos-test.c
>>   create mode 100644 tests/test-qgraph.c
>>   create mode 100644 tests/virtio-ccw-test.c
>>
