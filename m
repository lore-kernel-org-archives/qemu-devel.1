Received: from eggs.gnu.org ([2001:4830:134:3::10]:47932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fpv53-0004HR-A3
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 08:39:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fpv51-0004s8-UC
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 08:39:17 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180813101453.10200-1-e.emanuelegiuseppe@gmail.com>
Date: Wed, 15 Aug 2018 14:38:58 +0200
In-Reply-To: <20180813101453.10200-1-e.emanuelegiuseppe@gmail.com> (Emanuele
	Giuseppe Esposito's message of "Mon, 13 Aug 2018 12:14:20 +0200")
Message-ID: <87wosrkdnh.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 00/33] Qtest driver framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Amit Shah <amit@kernel.org>, Alexander Graf <agraf@suse.de>, Philippe =?utf-8?Q?M?= =?utf-8?Q?athieu-Daud=C3=A9?= <f4bug@amsat.org>, Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com> writes:

> Qgraph API for the qtest driver framework
>
> This series of patches introduce a different qtest driver
> organization, viewing machines, drivers and tests as node in a
> graph, each having one or multiple edges relations.
>
> The idea is to have a framework where each test asks for a specific
> driver, and the framework takes care of allocating the proper devices
> required and passing the correct command line arguments to QEMU.
>
> A node can be of four types:
> - MACHINE:   for example "arm/raspi2"
> - DRIVER:    for example "generic-sdhci"
> - INTERFACE: for example "sdhci" (interface for all "-sdhci" drivers)
> - TEST:      for example "sdhci-test", consumes an interface and tests
>              the functions provided
>
> An edge relation between two nodes (drivers or machines) X and Y can be:
> - X CONSUMES Y: Y can be plugged into X
> - X PRODUCES Y: X provides the interface Y
> - X CONTAINS Y: Y is part of X component
>
> Basic framework steps are the following:
> - All nodes and edges are created in their respective machine/driver/test files
> - The framework starts QEMU and asks for a list of available devices
>   and machines
> - The framework walks the graph starting from the available machines and
>   performs a Depth First Search for tests
> - Once a test is found, the path is walked again and all drivers are
>   allocated accordingly and the final interface is passed to the test
> - The test is executed
> - Unused objects are cleaned and the path discovery is continued
>
> Depending on the QEMU binary used, only some drivers/machines will be available
> and only test that are reached by them will be executed.
>
> This work is being done as Google Summer of Code 2018 project for QEMU,
> my mentors are Paolo Bonzini and Laurent Vivier.
> Additional infos on the project can be found at:
> https://wiki.qemu.org/Features/qtest_driver_framework

You've likely answered this question somewhere already, but it should be
answered right here: what does this framework buy us?

I figure the main benefit is running tests in all possible contexts,
with automated context setup.  Instead, you feed the framework
declarations of how things are related (the graph stuff described
above).

Taking a step back: your cover letter describes a solution at a high
level.  That's good.  But it should *first* describe the problem you're
trying to solve.

> v3:
> - Minor fixes regarding memory leaks and naming
>
> Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
