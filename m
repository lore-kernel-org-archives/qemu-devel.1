Received: from eggs.gnu.org ([2001:4830:134:3::10]:43351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fivOj-0005s9-CU
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 01:34:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fivOh-00045H-RY
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 01:34:41 -0400
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:52150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1fivOh-00044l-LT
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 01:34:39 -0400
Received: by mail-it0-x244.google.com with SMTP id e14-v6so6036056itf.1
	for <qemu-devel@nongnu.org>; Thu, 26 Jul 2018 22:34:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <VI1PR0501MB2784008D66F24945AB066395B5560@VI1PR0501MB2784.eurprd05.prod.outlook.com>
References: <1528212489-19137-1-git-send-email-lidongchen@tencent.com>
	<1528212489-19137-9-git-send-email-lidongchen@tencent.com>
	<20180627185952.GJ2423@work-vm>
	<CAOGPPbfMZRTdfiXj0ekij1bwL3JgQEF3zHGR4AKuor-MGmQGiw@mail.gmail.com>
	<CAOGPPbcTN55ASX64rJe3iUUNmxQJvuy22Har5Lwk7qsEVBxdow@mail.gmail.com>
	<VI1PR0501MB2784008D66F24945AB066395B5560@VI1PR0501MB2784.eurprd05.prod.outlook.com>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Fri, 27 Jul 2018 13:34:38 +0800
Message-ID: <CAOGPPbf+GimTM0DmmpRx5k7fEjNd_m0HYma3FWSANkpo7pC40Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 08/10] migration: create a dedicated
 thread to release rdma resource
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gal Shachaf <galsha@mellanox.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Aviad Yehezkel <aviadye@mellanox.com>, "zhang.zhanghailiang@huawei.com" <zhang.zhanghailiang@huawei.com>, Juan Quintela <quintela@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Adi Dotan <adido@mellanox.com>, Lidong Chen <lidongchen@tencent.com>

On Mon, Jul 23, 2018 at 10:54 PM, Gal Shachaf <galsha@mellanox.com> wrote:
> On Thu, Jul 5, 2018 at 10:26 PM, 858585 jemmy <jemmy858585@gmail.com> wro=
te:
>> On Thu, Jun 28, 2018 at 2:59 AM, Dr. David Alan Gilbert
>> <dgilbert@redhat.com> wrote:
>>> * Lidong Chen (jemmy858585@gmail.com) wrote:
>>>> ibv_dereg_mr wait for a long time for big memory size virtual server.
>>>>
>>>> The test result is:
>>>>   10GB  326ms
>>>>   20GB  699ms
>>>>   30GB  1021ms
>>>>   40GB  1387ms
>>>>   50GB  1712ms
>>>>   60GB  2034ms
>>>>   70GB  2457ms
>>>>   80GB  2807ms
>>>>   90GB  3107ms
>>>>   100GB 3474ms
>>>>   110GB 3735ms
>>>>   120GB 4064ms
>>>>   130GB 4567ms
>>>>   140GB 4886ms
>>>>
>>>> this will cause the guest os hang for a while when migration finished.
>>>> So create a dedicated thread to release rdma resource.
>>>>
>>>> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
>>>> ---
>>>>  migration/rdma.c | 43 +++++++++++++++++++++++++++----------------
>>>>  1 file changed, 27 insertions(+), 16 deletions(-)
>>>>
>>>> diff --git a/migration/rdma.c b/migration/rdma.c index
>>>> dfa4f77..f12e8d5 100644
>>>> --- a/migration/rdma.c
>>>> +++ b/migration/rdma.c
>>>> @@ -2979,35 +2979,46 @@ static void qio_channel_rdma_set_aio_fd_handle=
r(QIOChannel *ioc,
>>>>      }
>>>>  }
>>>>
>>>> -static int qio_channel_rdma_close(QIOChannel *ioc,
>>>> -                                  Error **errp)
>>>> +static void *qio_channel_rdma_close_thread(void *arg)
>>>>  {
>>>> -    QIOChannelRDMA *rioc =3D QIO_CHANNEL_RDMA(ioc);
>>>> -    RDMAContext *rdmain, *rdmaout;
>>>> -    trace_qemu_rdma_close();
>>>> +    RDMAContext **rdma =3D arg;
>>>> +    RDMAContext *rdmain =3D rdma[0];
>>>> +    RDMAContext *rdmaout =3D rdma[1];
>>>>
>>>> -    rdmain =3D rioc->rdmain;
>>>> -    if (rdmain) {
>>>> -        atomic_rcu_set(&rioc->rdmain, NULL);
>>>> -    }
>>>> -
>>>> -    rdmaout =3D rioc->rdmaout;
>>>> -    if (rdmaout) {
>>>> -        atomic_rcu_set(&rioc->rdmaout, NULL);
>>>> -    }
>>>> +    rcu_register_thread();
>>>>
>>>>      synchronize_rcu();
>>>
>>> * see below
>>>
>>>> -
>>>>      if (rdmain) {
>>>>          qemu_rdma_cleanup(rdmain);
>>>>      }
>>>> -
>>>>      if (rdmaout) {
>>>>          qemu_rdma_cleanup(rdmaout);
>>>>      }
>>>>
>>>>      g_free(rdmain);
>>>>      g_free(rdmaout);
>>>> +    g_free(rdma);
>>>> +
>>>> +    rcu_unregister_thread();
>>>> +    return NULL;
>>>> +}
>>>> +
>>>> +static int qio_channel_rdma_close(QIOChannel *ioc,
>>>> +                                  Error **errp) {
>>>> +    QemuThread t;
>>>> +    QIOChannelRDMA *rioc =3D QIO_CHANNEL_RDMA(ioc);
>>>> +    RDMAContext **rdma =3D g_new0(RDMAContext*, 2);
>>>> +
>>>> +    trace_qemu_rdma_close();
>>>> +    if (rioc->rdmain || rioc->rdmaout) {
>>>> +        rdma[0] =3D  rioc->rdmain;
>>>> +        rdma[1] =3D  rioc->rdmaout;
>>>> +        qemu_thread_create(&t, "rdma cleanup", qio_channel_rdma_close=
_thread,
>>>> +                           rdma, QEMU_THREAD_DETACHED);
>>>> +        atomic_rcu_set(&rioc->rdmain, NULL);
>>>> +        atomic_rcu_set(&rioc->rdmaout, NULL);
>>>
>>> I'm not sure this pair is ordered with the synchronise_rcu above;
>>> Doesn't that mean, on a bad day, that you could get:
>>>
>>>
>>>     main-thread          rdma_cleanup     another-thread
>>>     qmu_thread_create
>>>                       synchronise_rcu
>>>                                         reads rioc->rdmain
>>>                                         starts doing something with rdm=
ain
>>>     atomic_rcu_set
>>>                       rdma_cleanup
>>>
>>>
>>> so the another-thread is using it during the cleanup?
>>> Would just moving the atomic_rcu_sets before the qemu_thread_create
>>> fix that?
>> yes, I will fix it.
>>
>>>
>>> However, I've got other worries as well:
>>>    a) qemu_rdma_cleanup does:
>>>        migrate_get_current()->state =3D=3D MIGRATION_STATUS_CANCELLING
>>>
>>>       which worries me a little if someone immediately tries to restart
>>>       the migration.
>
> Because the current qemu version don't wait for RDMA_CM_EVENT_DISCONNECTE=
D event after rdma_disconnect, so I think it's not necessary to send RDMA_C=
ONTROL_ERROR.
>
> compare to send RDMA_CONTROL_ERROR, I think use cm event to notify peer q=
emu is better.
> maybe the rdma is already in error_state, and RDMA_CONTROL_ERROR cannot s=
end successfully.
>
> For peer qemu, in qemu_rdma_wait_comp_channel function, it's should not o=
nly poll rdma->comp_channel->fd, it's should also poll  rdma->channel->fd.
> [GS] I agree that we should poll on CM events in addition to CQ events.
>
> for the source qemu, it's fixed by this patch.
> migration: poll the cm event while wait RDMA work request completion
>
> and for destination qemu, it's need a new patch to fix it.
>
> so I prefer to remove MIGRATION_STATUS_CANCELLING in qemu_rdma_cleanup fu=
nction.
>
> [GS] The intention of this patch is to move the costly ibv_dereg_mr to a =
separate thread, so we do not actually need to also move the RDMA_CONTROL_E=
RROR  and rdma_disconnect, that come beforehand in qemu_rdma_cleanup,  to a=
 thread. I suggest that we move them out of qemu_rdma_cleanup to a new func=
tion "qemu_rdma_disconnect" and call it on each RDMAcontext before the qemu=
_thread_create.

Hi Dave, Gal:
I find the reason why we send RDMA_CONTROL_ERROR  while
MIGRATION_STATUS_CANCELLING is to fix this issue.
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D32bce196344772df8d68ab40e=
2dd1dd57be1aa7c

The current qemu version don't wait for RDMA_CM_EVENT_DISCONNECTED
event after rdma_disconnect, so I think it's not necessary to send
RDMA_CONTROL_ERROR while MIGRATION_STATUS_CANCELLING.

and I was confused about the purpose of RDMA_CONTROL_ERROR.
It seems to notify something error on one side, but it's only invoked
in qemu_rdma_cleanup.
and rdma_disconnect is enough to notify peer qemu.
and Gal told me that DREQ drop just the same as the DREP, so we cannot
guarantee that the destination will receive the
RDMA_CM_EVENT_DISCONNECTED
event.
but we also cannot guarantee the destination will receive the
RDMA_CONTROL_ERROR when rdma in is error state.

So I prefer to also remove send RDMA_CONTROL_ERROR in qemu_rdma_cleanup.

Any suggestion?

Thanks.

>>>
>>>    b) I don't understand what happens if someone does try and restart
>>>       the migration after that, but in the ~5s it takes the ibv cleanup
>>>       to happen.
>
> I prefer to add a new variable in current_migration.  if the rdma cleanup=
 thread has not exited. it's should not start a new migration.
> [GS] I support this suggestion.
>
>>
>> yes, I will try to fix it.
>>
>>>
>>> Dave
>>>
>>>
>>>> +    }
>>>>
>>>>      return 0;
>>>>  }
>>>> --
>>>> 1.8.3.1
>>>>
>>> --
>>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
