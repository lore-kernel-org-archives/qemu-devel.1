Received: from eggs.gnu.org ([208.118.235.92]:50172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fvG2g-00037E-H5
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 02:02:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fvFwq-0005jv-DV
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 01:56:53 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38164)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1fvFwq-0005ji-23
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 01:56:52 -0400
Received: by mail-wr1-x442.google.com with SMTP id w11-v6so6838992wrc.5
	for <qemu-devel@nongnu.org>; Wed, 29 Aug 2018 22:56:51 -0700 (PDT)
MIME-Version: 1.0
References: <20180811205924.4113-1-zhangckid@gmail.com>
	<20180811205924.4113-17-zhangckid@gmail.com>
	<2bd91af8-f11f-ff55-8a02-9bee3361d7ff@redhat.com>
	<CAK3tnvJtAS75zw8-6fgNv+RTqGuizRm8Mb0zAhGqE_njwy1Dpw@mail.gmail.com>
	<03a7e551-6473-ef4f-b149-d132efadd2f9@redhat.com>
	<CAK3tnv+PV0ez2UFG78Gi51+726U4W328C-8vTPAMbQUU2xFy0A@mail.gmail.com>
	<cb79f14a-858c-d311-21cc-851ef3bef2fe@redhat.com>
In-Reply-To: <cb79f14a-858c-d311-21cc-851ef3bef2fe@redhat.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Thu, 30 Aug 2018 13:56:37 +0800
Message-ID: <CAK3tnvJ32uAbAK5Dsf91TvW8JVZWdkpuayat_jXpKL_wHS94Xg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V11 16/20] filter: Add handle_event method
 for NetFilterClass
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jasowang@redhat.com
Cc: zhang.zhanghailiang@huawei.com, lizhijian@cn.fujitsu.com, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Tue, Aug 28, 2018 at 3:19 PM Jason Wang <jasowang@redhat.com> wrote:

>
>
> On 2018=E5=B9=B408=E6=9C=8824=E6=97=A5 13:57, Zhang Chen wrote:
> > On Wed, Aug 22, 2018 at 4:22 PM Jason Wang<jasowang@redhat.com>  wrote:
> >
> >> On 2018=E5=B9=B408=E6=9C=8821=E6=97=A5 17:25, Zhang Chen wrote:
> >>> On Tue, Aug 21, 2018 at 11:30 AM Jason Wang<jasowang@redhat.com>
> wrote:
> >>>
> >>>> On 2018=E5=B9=B408=E6=9C=8812=E6=97=A5 04:59, Zhang Chen wrote:
> >>>>> Filter needs to process the event of checkpoint/failover or
> >>>>> other event passed by COLO frame.
> >>>>>
> >>>>> Signed-off-by: zhanghailiang<zhang.zhanghailiang@huawei.com>
> >>>>> ---
> >>>>>     include/net/filter.h |  5 +++++
> >>>>>     net/filter.c         | 17 +++++++++++++++++
> >>>>>     net/net.c            | 28 ++++++++++++++++++++++++++++
> >>>>>     3 files changed, 50 insertions(+)
> >>>>>
> >>>>> diff --git a/include/net/filter.h b/include/net/filter.h
> >>>>> index 435acd6f82..49da666ac0 100644
> >>>>> --- a/include/net/filter.h
> >>>>> +++ b/include/net/filter.h
> >>>>> @@ -38,6 +38,8 @@ typedef ssize_t (FilterReceiveIOV)(NetFilterState
> >> *nc,
> >>>>>     typedef void (FilterStatusChanged) (NetFilterState *nf, Error
> >> **errp);
> >>>>> +typedef void (FilterHandleEvent) (NetFilterState *nf, int event,
> Error
> >>>> **errp);
> >>>>> +
> >>>>>     typedef struct NetFilterClass {
> >>>>>         ObjectClass parent_class;
> >>>>>
> >>>>> @@ -45,6 +47,7 @@ typedef struct NetFilterClass {
> >>>>>         FilterSetup *setup;
> >>>>>         FilterCleanup *cleanup;
> >>>>>         FilterStatusChanged *status_changed;
> >>>>> +    FilterHandleEvent *handle_event;
> >>>>>         /* mandatory */
> >>>>>         FilterReceiveIOV *receive_iov;
> >>>>>     } NetFilterClass;
> >>>>> @@ -77,4 +80,6 @@ ssize_t qemu_netfilter_pass_to_next(NetClientStat=
e
> >>>> *sender,
> >>>>>                                         int iovcnt,
> >>>>>                                         void *opaque);
> >>>>>
> >>>>> +void colo_notify_filters_event(int event, Error **errp);
> >>>>> +
> >>>>>     #endif /* QEMU_NET_FILTER_H */
> >>>>> diff --git a/net/filter.c b/net/filter.c
> >>>>> index 2fd7d7d663..0f17eba143 100644
> >>>>> --- a/net/filter.c
> >>>>> +++ b/net/filter.c
> >>>>> @@ -17,6 +17,8 @@
> >>>>>     #include "net/vhost_net.h"
> >>>>>     #include "qom/object_interfaces.h"
> >>>>>     #include "qemu/iov.h"
> >>>>> +#include "net/colo.h"
> >>>>> +#include "migration/colo.h"
> >>>>>
> >>>>>     static inline bool qemu_can_skip_netfilter(NetFilterState *nf)
> >>>>>     {
> >>>>> @@ -245,11 +247,26 @@ static void netfilter_finalize(Object *obj)
> >>>>>         g_free(nf->netdev_id);
> >>>>>     }
> >>>>>
> >>>>> +static void dummy_handle_event(NetFilterState *nf, int event, Erro=
r
> >>>> **errp)
> >>>>> +{
> >>>> It's in fact not a "dummy" handler, Maybe it's better to rename it a=
s
> >>>> "default".
> >>>>
> >>> OK, I will rename it in next version.
> >>>
> >>>
> >>>>> +    switch (event) {
> >>>>> +    case COLO_EVENT_CHECKPOINT:
> >>>>> +        break;
> >>>>> +    case COLO_EVENT_FAILOVER:
> >>>>> +        object_property_set_str(OBJECT(nf), "off", "status", errp)=
;
> >>>> I think filter is a generic infrastructure, so it's better not have
> COLO
> >>>> specific things like this. You can either add a generic name or have=
 a
> >>>> dedicated helper to just disable all net filters.
> >>>>
> >>> Maybe we can rename it to "EVENT_CHECKPOINT" and "EVENT_FAILOVER" loo=
ks
> >>> better?
> >>>
> >> I think registering notifier to COLO is better. For disabling filter, =
we
> >> can have a generic dedicated helpers to do this.
> >>
> > If we registering notifier to COLO (in migration/colo.c), filter-rewrit=
er
> > can not get the notify immediately when checkout occur.
> > filter-reweiter didn't know when checkpoint happened,
>
> I may miss something, isn't COLO which triggers the checkpoint even?
>

Yes, in detail, we have two way to trigger the checkpoint:
case 1. COLO compare trigger.
case 2. periodic checkpoint mechanism trigger.

But we both solve the same problem that how to notify filter-rewriter do
checkpoint in secondary node.
Currently we do this job in that way:

case 1. primary node COLO compare(net/colo-compare.c)  ----> primary node
COLO frame(migration/colo.c) ------> secondary node COLO frame
-----------------> secondary node filter-rewriter.
case 2. primary node COLO frame(migration/colo.c) ------> secondary node
COLO frame -----------------> secondary node filter-rewriter.

So, this patch just focus on "secondary node COLO frame ----------------->
secondary node filter-rewriter".
In filter-rewriter hard to get the checkpoint message from COLO frame.


Thanks
Zhang Chen


>
> >   and I think loop to
> > check the COLO event in filter-rewriter is a bad choice.
>
> Well, anyway you need a loop somewhere to iterate all notifiers?
>
> Thanks
>
> > Any thing I misunderstand?
> >
> >
> >
>
>
