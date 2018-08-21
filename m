Received: from eggs.gnu.org ([2001:4830:134:3::10]:41477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fs30m-0001IX-Rw
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 05:31:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fs2w6-00088M-Kx
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 05:26:51 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:41097)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1fs2w4-00084Y-Tu
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 05:26:49 -0400
Received: by mail-wr1-x42c.google.com with SMTP id z96-v6so6585301wrb.8
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 02:26:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180811205924.4113-1-zhangckid@gmail.com>
	<20180811205924.4113-16-zhangckid@gmail.com>
	<f5b85e98-29ed-86e0-4497-7a63b61a663b@redhat.com>
In-Reply-To: <f5b85e98-29ed-86e0-4497-7a63b61a663b@redhat.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Tue, 21 Aug 2018 17:26:35 +0800
Message-ID: <CAK3tnv+CPvV5F09PWx5B2bQp6xYNmyJ--x_qy4mS7XZ6K1=W_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V11 15/20] net/net.c: Add net client type
 check function for COLO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, zhang.zhanghailiang@huawei.com, lizhijian@cn.fujitsu.com, Zhang Chen <chen.zhang@intel.com>

On Tue, Aug 21, 2018 at 11:27 AM Jason Wang <jasowang@redhat.com> wrote:

>
>
> On 2018=E5=B9=B408=E6=9C=8812=E6=97=A5 04:59, Zhang Chen wrote:
> > From: Zhang Chen <chen.zhang@intel.com>
> >
> > We add is_colo_support_client_type() to check the net client type for
> > COLO-compare. Currently we just support TAP.
> > Suggested by Jason.
> >
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> > ---
>
> This needs more works:
>
> - Forbid vhost
> - Deal with hotplug
>
> Looks not a must for this series, so to speed up the process, you may do
> it on top.
>
>
Do you mean this patch we can stay this status currently?

Thanks
Zhang Chen


> Thanks
>
> >   include/net/net.h  |  1 +
> >   net/colo-compare.c |  5 +++++
> >   net/net.c          | 14 ++++++++++++++
> >   3 files changed, 20 insertions(+)
> >
> > diff --git a/include/net/net.h b/include/net/net.h
> > index 1425960f76..dcbc7ba9c0 100644
> > --- a/include/net/net.h
> > +++ b/include/net/net.h
> > @@ -212,6 +212,7 @@ void hmp_host_net_add(Monitor *mon, const QDict
> *qdict);
> >   void hmp_host_net_remove(Monitor *mon, const QDict *qdict);
> >   void netdev_add(QemuOpts *opts, Error **errp);
> >   void qmp_netdev_add(QDict *qdict, QObject **ret, Error **errp);
> > +bool is_colo_support_client_type(void);
> >
> >   int net_hub_id_for_client(NetClientState *nc, int *id);
> >   NetClientState *net_hub_port_find(int hub_id);
> > diff --git a/net/colo-compare.c b/net/colo-compare.c
> > index 426eab5973..b8c0240725 100644
> > --- a/net/colo-compare.c
> > +++ b/net/colo-compare.c
> > @@ -996,6 +996,11 @@ static void colo_compare_complete(UserCreatable
> *uc, Error **errp)
> >           return;
> >       }
> >
> > +    if (!is_colo_support_client_type()) {
> > +        error_setg(errp, "COLO-compare: Net client type is not
> supported");
> > +        return;
> > +    }
> > +
> >       net_socket_rs_init(&s->pri_rs, compare_pri_rs_finalize,
> s->vnet_hdr);
> >       net_socket_rs_init(&s->sec_rs, compare_sec_rs_finalize,
> s->vnet_hdr);
> >
> > diff --git a/net/net.c b/net/net.c
> > index 2a3133990c..a77ea88fff 100644
> > --- a/net/net.c
> > +++ b/net/net.c
> > @@ -1733,3 +1733,17 @@ int net_fill_rstate(SocketReadState *rs, const
> uint8_t *buf, int size)
> >       assert(size =3D=3D 0);
> >       return 0;
> >   }
> > +
> > +/* Currently, COLO just support TAP */
> > +bool is_colo_support_client_type(void)
> > +{
> > +    NetClientState *nc;
> > +
> > +    QTAILQ_FOREACH(nc, &net_clients, next) {
> > +        if (nc->info->type !=3D NET_CLIENT_DRIVER_TAP) {
> > +            return false;
> > +        }
> > +    }
> > +
> > +    return true;
> > +}
>
>
