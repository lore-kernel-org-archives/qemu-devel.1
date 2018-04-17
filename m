Received: from eggs.gnu.org ([2001:4830:134:3::10]:39358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f8RMe-0004uP-DZ
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 10:13:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f8RMb-0006ry-0d
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 10:13:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51768 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1f8RMa-0006rd-Qu
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 10:13:40 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1520860275-101576-1-git-send-email-imammedo@redhat.com>
Date: Tue, 17 Apr 2018 16:13:34 +0200
In-Reply-To: <1520860275-101576-1-git-send-email-imammedo@redhat.com> (Igor
	Mammedov's message of "Mon, 12 Mar 2018 14:11:06 +0100")
Message-ID: <87zi21apkh.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 0/9] enable numa configuration before
 machine_init() from QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, pkrempa@redhat.com, ehabkost@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au

Igor Mammedov <imammedo@redhat.com> writes:

[...]
> Series allows to configure NUMA mapping at runtime using QMP
> interface. For that to happen it introduces a new '-preconfig' CLI option
> which allows to pause QEMU before machine_init() is run and
> adds new set-numa-node QMP command which in conjunction with
> query-hotpluggable-cpus allows to configure NUMA mapping for cpus.
>
> Later we can modify other commands to run early, for example device_add.
> I recall SPAPR had problem when libvirt started QEMU with -S and, while it's
> paused, added CPUs with device_add. Intent was to coldplug CPUs (but at that
> stage it's considered hotplug already), so SPAPR had to work around the issue.

That instance is just stupidity / laziness, I think: we consider any
plug after machine creation a hot plug.  Real machines remain cold until
you press the power button.  Our virtual machines should remain cold
until they start running, i.e. with -S until the first "cont".

I vaguely remember me asking this before, but your answer didn't make it
into this cover letter, which gives me a pretext to ask again instead of
looking it up in the archives: what exactly prevents us from keeping the
machine cold enough for numa configuration until the first "cont"?

>
> Example of configuration session:
> $QEMU -smp 2 -preconfig ...
>
> QMP:
> # get CPUs layout for current target/machine/CLI
> -> {'execute': 'query-hotpluggable-cpus' }  
> <- {'return': [
>        {'props': {'core-id': 0, 'thread-id': 0, 'socket-id': 1}, ... },
>        {'props': {'core-id': 0, 'thread-id': 0, 'socket-id': 0}, ... }
>    ]}
>
> # configure 1st node
> -> {'execute': 'set-numa-node', 'arguments': { 'type': 'node', 'nodeid': 0 } }  
> <- {'return': {}}
> -> {'execute': 'set-numa-node', 'arguments': { 'type': 'cpu',   
>        'node-id': 0, 'core-id': 0, 'thread-id': 0, 'socket-id': 1, }
>    }
> <- {'return': {}}
>
> # configure 2nd node
> -> {'execute': 'set-numa-node', 'arguments': { 'type': 'node', 'nodeid': 1 } }
> -> {'execute': 'set-numa-node', 'arguments': { 'type': 'cpu',  
>        'node-id': 1, 'core-id': 0, 'thread-id': 0, 'socket-id': 0 }
>    }
> <- {'return': {}}
>
> # [optional] verify configuration
> -> {'execute': 'query-hotpluggable-cpus' }  
> <- {'return': [
>        {'props': {'core-id': 0, 'thread-id': 0, 'node-id': 0, 'socket-id': 1}, ... },
>        {'props': {'core-id': 0, 'thread-id': 0, 'node-id': 1, 'socket-id': 0}, ... }
>    ]}
>
>
> Git tree:
>     https://github.com/imammedo/qemu.git qmp_preconfig_v3
>
> Ref to v1:
>     https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg03583.html
>     Message-Id: <1508170976-96869-1-git-send-email-imammedo@redhat.com>
