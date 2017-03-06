Received: from eggs.gnu.org ([2001:4830:134:3::10]:46588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cksA0-0003dI-JX
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 07:54:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cks9x-0006ml-Gz
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 07:54:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cks9x-0006mb-7j
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 07:54:41 -0500
References: <20170202150530.1025-1-pbonzini@redhat.com>
	<20170203150050.GF642@stefanha-x1.localdomain>
	<55b46fa3-c861-9ba4-da65-25bc392d8900@redhat.com>
	<20170206115659.GC2524@work-vm>
	<58B970DD0200004800140A13@prv-mh.provo.novell.com>
	<20170306090759.GA2394@work-vm>
	<5bac684d-b80d-04cf-4558-dec67e4c246e@cn.fujitsu.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <032603be-44a9-cdc6-7724-c98e0787914b@redhat.com>
Date: Mon, 6 Mar 2017 13:54:36 +0100
MIME-Version: 1.0
In-Reply-To: <5bac684d-b80d-04cf-4558-dec67e4c246e@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] configure: remove
 --enable-replication/--disable-replication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Bruce Rogers <brogers@suse.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org



On 06/03/2017 11:03, Zhang Chen wrote:
>=20
>=20
> On 03/06/2017 05:08 PM, Dr. David Alan Gilbert wrote:
>> * Bruce Rogers (brogers@suse.com) wrote:
>>>>>> On 2/6/2017 at 4:57 AM, <dgilbert@redhat.com> wrote:
>>>> * Paolo Bonzini (pbonzini@redhat.com) wrote:
>>>>>
>>>>> On 03/02/2017 07:00, Stefan Hajnoczi wrote:
>>>>>> On Thu, Feb 02, 2017 at 07:05:30AM =E2=80=910800, Paolo Bonzini wr=
ote:
>>>>>>> The replication feature is a small amount of code, does not
>>>>>>> require any external library and unless used does not add
>>>>>>> anything to the guest's attack surface.  Since any extra
>>>>>>> configure option affects maintainability on the other hand
>>>>>>> and is subject to bit rot, I think there is no need to
>>>>>>> make it configurable.
>>>>>> I think the current state is good: replication is enabled by
>>>>>> default but
>>>>>> can be compiled out if desired.
>>>>>>
>>>>>> Downstreams may not be comfortable supporting this feature yet sin=
ce
>>>>>> it's incomplete.  It's fair to offer an option to disable it,
>>>>>> otherwise
>>>>>> downstreams will have to patch this themselves.
>>>>> I understand=E2=80=91=E2=80=91=E2=80=91I just am not sure where to =
draw the line because
>>>>> there's
>>>>> plenty of other incomplete features, hence the RFC.  For example,
>>>>> record/replay cannot be enabled or disabled on the configure comman=
d
>>>>> line.  That was the case even in the beginning, where it didn't
>>>>> support
>>>>> either block or character device replay.
>>>> The line is certainly fuzzy, but I think it's worth making the
>>>> following
>>>> type of things configurable:
>>>>     Features that have a large chunk of code
>>>>       =E2=80=91 dont lets try and configure tiny things on and off
>>>>     That can be trivially configured
>>>>       =E2=80=91 lets not put big chunks of code around making them c=
onfigurable
>>>> and   that are incomplete
>>>>     or are unused by large chunks of the users
>>>>
>>>> Dave
>>>>
>>>>> =E2=80=91=E2=80=91enable=E2=80=91coroutine=E2=80=91pool is a relic =
of when Windows builds needed
>>>>> it, but
>>>>> all other =E2=80=91=E2=80=91enable=E2=80=91* options require an ext=
ernal library or at least a
>>>>> specific operating system.  See for example this patch:
>>>>>
>>>>>      commit 52b53c04faab9f7a9879c8dc014930649a3e698d
>>>>>      Author: Fam Zheng <famz@redhat.com>
>>>>>      Date:   Wed Sep 10 14:17:51 2014 +0800
>>>>>
>>>>>      block: Always compile virtio=E2=80=91blk dataplane
>>>>>
>>>>>      Dataplane doesn't depend on linux=E2=80=91aio any more, so we =
don't
>>>>> need the
>>>>>      compiling condition now.
>>>>>
>>>>>      Configure options are kept but just print a message.
>>>>>
>>>>>      Signed=E2=80=91off=E2=80=91by: Fam Zheng <famz@redhat.com>
>>>>>      Reviewed=E2=80=91by: Paolo Bonzini <pbonzini@redhat.com>
>>>>>      Message=E2=80=91id: 1410329871=E2=80=9128885=E2=80=914=E2=80=91=
git=E2=80=91send=E2=80=91email=E2=80=91famz@redhat.com
>>>>>      Signed=E2=80=91off=E2=80=91by: Stefan Hajnoczi <stefanha@redha=
t.com>
>>>>>
>>>>>
>>>>> I would actually prefer to remove many of the latter
>>>>> (=E2=80=91=E2=80=91enable=E2=80=91vhost=E2=80=91net, =E2=80=91=E2=80=
=91enable=E2=80=91vhost=E2=80=91scsi, =E2=80=91=E2=80=91enable=E2=80=91vh=
ost=E2=80=91socket) and
>>>>> just use default=E2=80=91configs.  We are already doing it for ivsh=
mem for
>>>>> example:
>>>>>
>>>>>      CONFIG_IVSHMEM=3D$(CONFIG_EVENTFD)
>>>>>
>>>>> Paolo
>>>> =E2=80=91=E2=80=91
>>>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>>> Was there ever a conclusion here? The reason I ask is that I see that
>>> currently
>>> using --disable-replication fails for me as follows:
>>>
>>> # ./configure --disable-replication
>>> ...
>>> # make
>>> ...
>>> make  all-recursive
>>> Making all in pixman
>>> make[3]: Nothing to be done for 'all'.
>>> Making all in demos
>>> make[3]: Nothing to be done for 'all'.
>>> Making all in test
>>> make[3]: Nothing to be done for 'all'.
>>>     CHK version_gen.h
>>>    LINK    aarch64-softmmu/qemu-system-aarch64
>>> ../migration/colo.o: In function `qmp_query_xen_replication_status':
>>> /home/brogers/osr/git/qemu/migration/colo.c:181: undefined reference
>>> to `replication_get_error_all'
>>> ../migration/colo.o: In function `qmp_xen_set_replication':
>>> /home/brogers/osr/git/qemu/migration/colo.c:172: undefined reference
>>> to `replication_stop_all'
>>> /home/brogers/osr/git/qemu/migration/colo.c:172: undefined reference
>>> to `replication_stop_all'
>>> /home/brogers/osr/git/qemu/migration/colo.c:167: undefined reference
>>> to `replication_start_all'
>>> ../migration/colo.o: In function `qmp_xen_colo_do_checkpoint':
>>> /home/brogers/osr/git/qemu/migration/colo.c:196: undefined reference
>>> to `replication_do_checkpoint_all'
>>> collect2: error: ld returned 1 exit status
>>> make[1]: *** [Makefile:208: qemu-system-aarch64] Error 1
>>> make: *** [Makefile:322: subdir-aarch64-softmmu] Error 2
>> We should fix that.
>=20
> COLO needs replication enable.
> So, should I add a new option enable/disable COLO ?
> Then, If you disable replication, colo will be disabled automatically.
> Like that:
> # ./configure --disable-colo

Then I would just define --enable-colo/--disable-colo which includes
replication, the network filter and everything else.

Paolo
