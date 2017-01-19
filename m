Received: from eggs.gnu.org ([2001:4830:134:3::10]:46966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cUDP5-0000Uo-Gi
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:09:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cUDP2-0004hy-Qu
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:09:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35836)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cUDP2-0004hE-I5
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:09:24 -0500
Date: Thu, 19 Jan 2017 15:09:17 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170119150917.570be659@nial.brq.redhat.com>
In-Reply-To: <20170119094511.GE10906@redhat.com>
References: <1484759609-264075-1-git-send-email-imammedo@redhat.com>
	<20170119094511.GE10906@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 00/13] numa: add '-numa cpu' option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Dou Liyang <douly.fnst@cn.fujitsu.com>, Andrew Jones <drjones@redhat.com>, ehabkost@redhat.com, peter.maydell@linaro.org, fanc.fnst@cn.fujitsu.com, Thomas Huth <thuth@redhat.com>, caoj.fnst@cn.fujitsu.com, stefanha@redhat.com, izumi.taku@jp.fujitsu.com, vilanova@ac.upc.edu, David Gibson <david@gibson.dropbear.id.au>

On Thu, 19 Jan 2017 09:45:11 +0000
"Daniel P. Berrange" <berrange@redhat.com> wrote:

> On Wed, Jan 18, 2017 at 06:13:16PM +0100, Igor Mammedov wrote:
> > 
> > Series introduces a new CLI option to allow mapping cpus to numa
> > nodes using public properties [socket|core|thread]-ids instead of
> > internal cpu-index and moving cpu<->node mapping from global bitmaps
> > to PCMachineState struct.  
> 
> What is the benefit of this change to apps ? Obviously libvirt uses
> the current syntax, but I'm not aware of what problems that has - why
> would libvirt want to use this new syntax instead ?
current syntax -numa cpus=1,2,3... depends on cpu-index which is
internal to QEMU. External users wouldn't actually know which cpu
is associated with which cpu-index without re-implementing cpu-index
assignment which is qemu-version/target/machine/topology dependent.

New '-numa cpu' provides mapping of cpus to numa nodes in
CPU terms that are used with device_add/-device commands.
For management there is query-hotpluggble-cpus command that allows
to get a list of possible cpus with their socket-id/core-id/thread-id
property values.
for example without numa mapping CLI could look like:
  $QEMU -M pc -smp 1,sockets=3,maxcpus=3 \
      -device qemu64-x86_64-cpu,socket-id=1,core-id=0,thread-id=0

(qemu) info hotpluggable-cpus 
Hotpluggable CPUs:
  type: "qemu64-x86_64-cpu"
  vcpus_count: "1"
  CPUInstance Properties:
    socket-id: "2"
    core-id: "0"
    thread-id: "0"
  type: "qemu64-x86_64-cpu"
  vcpus_count: "1"
  qom_path: "/machine/peripheral-anon/device[0]"
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


based on that list the one could extend CLI with numa mapping:

  $QEMU -M pc -smp 1,sockets=3,maxcpus=3 \
      -device qemu64-x86_64-cpu,socket-id=1,core-id=0,thread-id=0 \
      -numa cpu,socket-id=0,core-id=0,thread-id=0,node-id=0 \
      -numa cpu,socket-id=1,core-id=0,thread-id=0,node-id=1 \
      -numa cpu,socket-id=2,core-id=0,thread-id=0,node-id=2 

(qemu) info hotpluggable-cpus 
Hotpluggable CPUs:
  type: "qemu64-x86_64-cpu"
  vcpus_count: "1"
  CPUInstance Properties:
    node-id: "2"
    socket-id: "2"
    core-id: "0"
    thread-id: "0"
  type: "qemu64-x86_64-cpu"
  vcpus_count: "1"
  qom_path: "/machine/peripheral-anon/device[0]"
  CPUInstance Properties:
    node-id: "1"
    socket-id: "1"
    core-id: "0"
    thread-id: "0"
  type: "qemu64-x86_64-cpu"
  vcpus_count: "1"
  qom_path: "/machine/unattached/device[0]"
  CPUInstance Properties:
    node-id: "0"
    socket-id: "0"
    core-id: "0"
    thread-id: "0"

As it's been discussed previous times, there is chicken/egg
issue where management has to get query-hotpluggble-cpus result
for a specific combination of machine type and -smp option.
It would need to be done at most one time when creating
a configuration and then CLI numa mapping could be used
for starting VM without doing query-hotpluggable-cpus.
'-numa cpu' CLI option is also needed for setting known
mapping on target side of migration.

Previous consensus has been that the only way to avoid 2 stage
discovery/configuration is starting QEMU in paused mode and
than do query + mapping at runtime via QMP before allowing
guest run with 'continue' command.
But this part hasn't been implemented in this series yet.

> 
> 
> Regards,
> Daniel
