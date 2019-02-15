Received: from eggs.gnu.org ([209.51.188.92]:40522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1guUkX-0007uT-LF
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 23:05:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1guUZA-0008HS-NG
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 22:53:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1guUZA-0008Dt-8t
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 22:53:32 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 81EB38E3FF
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 03:53:27 +0000 (UTC)
References: <20190206110044.21662-1-dgilbert@redhat.com>
	<20190206183521-mutt-send-email-mst@kernel.org>
	<91c1bf04-1b85-8d99-4d48-b8ad80d36314@redhat.com>
	<20190214202920.GH2617@work-vm>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e7705c8b-97db-a6bc-9423-6540986fca78@redhat.com>
Date: Fri, 15 Feb 2019 11:53:17 +0800
MIME-Version: 1.0
In-Reply-To: <20190214202920.GH2617@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/9] Network announce changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: germano@redhat.com, qemu-devel@nongnu.org, quintela@redhat.com, armbru@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>


On 2019/2/15 =E4=B8=8A=E5=8D=884:29, Dr. David Alan Gilbert wrote:
> * Jason Wang (jasowang@redhat.com) wrote:
>> On 2019/2/7 =E4=B8=8A=E5=8D=887:35, Michael S. Tsirkin wrote:
>>> On Wed, Feb 06, 2019 at 11:00:35AM +0000, Dr. David Alan Gilbert (git=
) wrote:
>>>> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>>>>
>>>> Hi,
>>>>     This is a reworking of a few sets of patches from 2017
>>>> that were put together by myself, Germano and Vlad that make
>>>> the network announce system more flexible.
>>>>
>>>>     Firstly, it's parameterised, so that you can change the number
>>>> of packets and the gap between them; the number can be set to 0
>>>> to disable announce completely.
>>>>
>>>>     Secondly, you can force an announce by a qmp or hmp command at
>>>> any time.  This is useful if you need the guest to do an announce
>>>> for a different reason; for example if the management layer
>>>> has just juggled some bonding configuration around.
>>> series
>>>
>>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>>
>> Applied.
>>
>> Thanks
> Hi Jason,
>    Can you drop the test patch for now (the last one) - I need to
> tweak the Makefile so it doesn't try and run on things without
> virtio-net.
>
> Dave


Ok. Will drop.

Thanks


>
>>
>>>
>>>
>>>
>>>>     The packet creation and timing also moves to net/ from migration=
/
>>>>
>>>>     The previous set was:
>>>>        https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg0559=
4.html
>>>>
>>>> Dave
>>>>
>>>> v3
>>>>     Fixes from Markus's review: blank lines, and json tweaks
>>>>
>>>> v2
>>>>     Fix the qmp example
>>>>     Typo fixes
>>>>
>>>>
>>>> Dr. David Alan Gilbert (9):
>>>>     net: Introduce announce timer
>>>>     migration: Add announce parameters
>>>>     virtio-net: Switch to using announce timer
>>>>     migration: Switch to using announce timer
>>>>     net: Add a network device specific self-announcement ability
>>>>     virtio-net: Allow qemu_announce_self to trigger virtio announcem=
ents
>>>>     qmp: Add announce-self command
>>>>     hmp: Add hmp_announce_self
>>>>     tests: Add a test for qemu self announcements
>>>>
>>>>    hmp-commands.hx                |  14 ++++
>>>>    hmp.c                          |  33 ++++++++
>>>>    hmp.h                          |   1 +
>>>>    hw/net/trace-events            |   6 ++
>>>>    hw/net/virtio-net.c            |  69 ++++++++++++----
>>>>    include/hw/virtio/virtio-net.h |   4 +-
>>>>    include/migration/misc.h       |  12 +--
>>>>    include/net/announce.h         |  41 ++++++++++
>>>>    include/net/net.h              |   2 +
>>>>    include/qemu/typedefs.h        |   2 +
>>>>    include/sysemu/sysemu.h        |   2 -
>>>>    migration/migration.c          | 103 +++++++++++++++++++++++-
>>>>    migration/migration.h          |   4 +
>>>>    migration/savevm.c             |  72 +----------------
>>>>    migration/trace-events         |   1 -
>>>>    net/Makefile.objs              |   1 +
>>>>    net/announce.c                 | 140 ++++++++++++++++++++++++++++=
+++++
>>>>    net/trace-events               |   3 +
>>>>    qapi/migration.json            |  53 ++++++++++++-
>>>>    qapi/net.json                  |  43 ++++++++++
>>>>    tests/Makefile.include         |   2 +
>>>>    tests/test-announce-self.c     |  83 +++++++++++++++++++
>>>>    tests/test-hmp.c               |   1 +
>>>>    23 files changed, 589 insertions(+), 103 deletions(-)
>>>>    create mode 100644 include/net/announce.h
>>>>    create mode 100644 net/announce.c
>>>>    create mode 100644 tests/test-announce-self.c
>>>>
>>>> --=20
>>>> 2.20.1
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
