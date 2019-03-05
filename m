Received: from eggs.gnu.org ([209.51.188.92]:47093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h1ESq-0001Dp-35
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:06:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h1ESo-0002FG-6O
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:06:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1h1ESm-0002A9-7B
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:06:48 -0500
Date: Tue, 5 Mar 2019 18:06:35 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190305180635.GA3803@work-vm>
References: <20190215174548.2630-1-yury-kotov@yandex-team.ru>
	<20190305140536.GD9811@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190305140536.GD9811@work-vm>
Subject: Re: [Qemu-devel] [PATCH v3 0/5] Add ignore-external migration
 capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yury Kotov <yury-kotov@yandex-team.ru>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Juan Quintela <quintela@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, wrfsh@yandex-team.ru, jiangshanlai@gmail.com, qemu-devel@lists.ewheeler.net, peter.maydell@linaro.org

* Dr. David Alan Gilbert (dgilbert@redhat.com) wrote:
> * Yury Kotov (yury-kotov@yandex-team.ru) wrote:
> > Hi,
> > 
> > The series adds a migration capability, which allows to skip shared RAM blocks
> > during the migration. It's useful for fast local migration. E.g. to update QEMU
> > for the running guests.
> 
> Queued

Hi Yury,
  The test is failing badly on aarch64 tcg for me (i.e. aarch64 tcg on
x86);  I'm going to keep it merged but keep the test disabled for now.
Can you have a look to see if you can see what's going wrong?

Dave

> > 
> > Usage example:
> > 1. Start source VM:
> >    qemu-system-x86 \
> >      -m 4G \
> >      -object memory-backend-file,id=mem0,size=4G,share=on,mem-path=/dev/shm/mem0 \
> >      -numa node,memdev=mem0 \
> >      -qmp unix:/tmp/qemu-qmp-1.sock,server,nowait \
> > 
> > 2. Start target VM:
> >    qemu-system-x86 \
> >      -m 4G \
> >      -object memory-backend-file,id=mem0,size=4G,share=on,mem-path=/dev/shm/mem0 \
> >      -numa node,memdev=mem0 \
> >      -qmp unix:/tmp/qemu-qmp-2.sock,server,nowait \
> >      -incoming defer
> > 
> > 3. Enable ignore-shared capability on both VMs:
> >    { "execute": "migrate-set-capabilities" , "arguments":
> >      { "capabilities": [ { "capability": "x-ignore-shared", "state": true } ] } }
> > 
> > 4. Start migration.
> > 
> > Another use case I keep in mind is to migrate to file. Usage is very similar.
> > 
> > V2 to V3:
> > * Split "migration: Introduce ignore-shared capability"
> > * Serialize the capabilities as strings rather than as indexes
> > * Don't allow to enable postcopy and ignore-shared together
> > * Skip the test for OSs which don't have /dev/shm
> > * Add a check whether shared RAM has been really skipped
> > 
> > V1 to V2:
> > * Keep migration stream compatibility
> > * Reuse the existing code to ignore unwanted RAMBlocks
> > * Add capability validation feature
> > * ignore-external -> ignore-shared
> > 
> > Regards,
> > Yury
> > 
> > Yury Kotov (5):
> >   exec: Change RAMBlockIterFunc definition
> >   migration: Introduce ignore-shared capability
> >   migration: Add an ability to ignore shared RAM blocks
> >   tests/migration-test: Add a test for ignore-shared capability
> >   migration: Add capabilities validation
> > 
> >  exec.c                    |  38 +++++------
> >  include/exec/cpu-common.h |   7 +-
> >  migration/migration.c     |  14 ++++
> >  migration/migration.h     |   5 +-
> >  migration/postcopy-ram.c  |  48 +++++++------
> >  migration/ram.c           | 110 ++++++++++++++++++++++--------
> >  migration/rdma.c          |   9 ++-
> >  migration/savevm.c        | 137 ++++++++++++++++++++++++++++++++++++++
> >  qapi/migration.json       |   5 +-
> >  stubs/ram-block.c         |  15 +++++
> >  tests/migration-test.c    | 131 +++++++++++++++++++++++++++++-------
> >  util/vfio-helpers.c       |   6 +-
> >  12 files changed, 420 insertions(+), 105 deletions(-)
> > 
> > -- 
> > 2.20.1
> > 
> > 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
