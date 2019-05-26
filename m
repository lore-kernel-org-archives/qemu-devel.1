Return-Path: <SRS0=5YAC=T2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698DDC282E1
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 06:57:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D4B220815
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 06:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OJTUgRCz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D4B220815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51665 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUn5c-0007Gs-0B
	for qemu-devel@archiver.kernel.org; Sun, 26 May 2019 02:57:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1hUn4h-0006u0-3w
	for qemu-devel@nongnu.org; Sun, 26 May 2019 02:56:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1hUmr5-0007qW-0X
	for qemu-devel@nongnu.org; Sun, 26 May 2019 02:42:04 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40050)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1hUmr4-0007d3-M1
	for qemu-devel@nongnu.org; Sun, 26 May 2019 02:42:02 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x4Q6cxat109062; Sun, 26 May 2019 06:41:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=date : from : to : cc
	: subject : message-id : references : mime-version : content-type :
	content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
	bh=42FX0pZD2DFqUrt+qDK3DoRlnx1leAsbW87GkYs1BWM=;
	b=OJTUgRCzuSrEBqrvGaL30wx+UjqsX2AokrtP/1qHxuTb8pddABCKVhpyrc8wXhMU5kQk
	FadoOmh8w4qayS6cO6iXXp+jgpKQN4VofJU7WDlgxPcNh4R6835Zs3ps1L2LiVDTYko0
	QFr9NaE9Zosvd1pSrErrxzAsK2+RaG4B3w943LX6A40qy65+yJ+tXFqChaX+UdtKWi2I
	gCUp/dP67jATPhJeDgRcREeE7yNlIa0GT9Pa4AlP44Nwv/13N37puYl15pdJ06TKn4BW
	rXNKtjPQdbghiugafgoDdvUiDxxVMkEGbA6SIFqfqboYvDP4OPph1fLwnsBcCpODEiEk
	Ag== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by userp2130.oracle.com with ESMTP id 2spw4t25ju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 26 May 2019 06:41:53 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x4Q6frx4147469; Sun, 26 May 2019 06:41:53 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by userp3020.oracle.com with ESMTP id 2spw1jruj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 26 May 2019 06:41:53 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4Q6fold002024;
	Sun, 26 May 2019 06:41:52 GMT
Received: from lap1 (/77.138.183.59) by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Sun, 26 May 2019 06:41:49 +0000
Date: Sun, 26 May 2019 09:41:45 +0300
From: Yuval Shaia <yuval.shaia@oracle.com>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <20190526064144.GA4309@lap1>
References: <20190505105518.22793-1-yuval.shaia@oracle.com>
	<87a35658-a636-4598-c860-cc73288922e2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87a35658-a636-4598-c860-cc73288922e2@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9268
	signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1905260046
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9268
	signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1905260046
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2130.oracle.com id
	x4Q6cxat109062
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: Re: [Qemu-devel] [PATCH] hw/rdma: Add support for GID state changes
 for non-qmp frameworks
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 24, 2019 at 08:24:30AM +0300, Marcel Apfelbaum wrote:
>=20
> Hi Yuval,
>=20
> On 5/5/19 1:55 PM, Yuval Shaia wrote:
> > Any GID change in guest must be propogate to host. This is already do=
ne
> > by firing QMP event to managment system such as libvirt which in turn
> > will update the host with the relevant change.
>=20
> Agreed, *any* management software can do that.
>=20
> >=20
> > When qemu is executed on non-qmp framework (ex from command-line) we
> > need to update the host instead.
> > Fix it by adding support to update the RoCE device's Ethernet functio=
n
> > IP list from qemu via netlink.
>=20
> I am not sure this is the right approach. I don't think QEMU should act=
ively
> change
> the host network configuration.
> As you pointed out yourself, the management software should make such
> changes.

I know about few deployments that are not using any management software,
they fires their VMs right from command-line.

Currently those deployments cannot use pvrdma.

>=20
> I agree you cannot always assume the QEMU instance is managed by libvir=
t,
> what about adding this functionality to rdma-multiplexer? The multiplex=
er
> may
> register to the same QMP event.

Two reasons prevent us from doing this:
- rdmacm-mux is a specific MAD multiplexer for CM packets, lets do not ad=
d
  management function to it.
- rdmacm-mux might be redundant when MAD multiplexer will be implemented =
in
  kernel. So what then?

>=20
> Even if you think the multiplexer is not the right way to do it, even a
> simple bash script
> disguised=A0 as a systemd service can subscribe to the QMP event and ma=
ke the
> change on the host.
>=20
> What do you think?

Another contrib app? A lightweight management software??


See, i do not have an argument if qemu policy is not allowing qemu proces=
s
to do external configuration (ex network). I'm just looking from a narrow
perspective of easy deployment - people sometimes runs qemu without libvi=
rt
(or any other management software for that matter), if they want to use
pvrdma they are forced to install libvirt just for that.

>=20
> Thanks,
> Marcel
>=20
> >=20
> > Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> > ---
> >   configure              |  6 ++++
> >   hw/rdma/rdma_backend.c | 74 +++++++++++++++++++++++++++++++++++++++=
++-
> >   2 files changed, 79 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/configure b/configure
> > index 5b183c2e39..1f707b1a62 100755
> > --- a/configure
> > +++ b/configure
> > @@ -3132,6 +3132,8 @@ fi
> >   cat > $TMPC <<EOF &&
> >   #include <sys/mman.h>
> > +#include <libmnl/libmnl.h>
> > +#include <linux/rtnetlink.h>
> >   int
> >   main(void)
> > @@ -3144,10 +3146,13 @@ main(void)
> >   }
> >   EOF
> > +pvrdma_libs=3D"-lmnl"
> > +
> >   if test "$rdma" =3D "yes" ; then
> >       case "$pvrdma" in
> >       "")
> >           if compile_prog "" ""; then
> > +            libs_softmmu=3D"$libs_softmmu $pvrdma_libs"
> >               pvrdma=3D"yes"
> >           else
> >               pvrdma=3D"no"
> > @@ -3156,6 +3161,7 @@ if test "$rdma" =3D "yes" ; then
> >       "yes")
> >           if ! compile_prog "" ""; then
> >               error_exit "PVRDMA is not supported since mremap is not=
 implemented"
> > +                        " or libmnl-devel is not installed"
> >           fi
> >           pvrdma=3D"yes"
> >           ;;
> > diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
> > index 05f6b03221..bc57b1a624 100644
> > --- a/hw/rdma/rdma_backend.c
> > +++ b/hw/rdma/rdma_backend.c
> > @@ -16,6 +16,11 @@
> >   #include "qemu/osdep.h"
> >   #include "qapi/qapi-events-rdma.h"
> > +#include "linux/if_addr.h"
> > +#include "libmnl/libmnl.h"
> > +#include "linux/rtnetlink.h"
> > +#include "net/if.h"
> > +
> >   #include <infiniband/verbs.h>
> >   #include "contrib/rdmacm-mux/rdmacm-mux.h"
> > @@ -47,6 +52,61 @@ static void dummy_comp_handler(void *ctx, struct i=
bv_wc *wc)
> >       rdma_error_report("No completion handler is registered");
> >   }
> > +static int netlink_route_update(const char *ifname, union ibv_gid *g=
id,
> > +                                __u16 type)
> > +{
> > +    char buf[MNL_SOCKET_BUFFER_SIZE];
> > +    struct nlmsghdr *nlh;
> > +    struct ifaddrmsg *ifm;
> > +    struct mnl_socket *nl;
> > +    int ret;
> > +    uint32_t ipv4;
> > +
> > +    nl =3D mnl_socket_open(NETLINK_ROUTE);
> > +    if (!nl) {
> > +        rdma_error_report("Fail to connect to netlink\n");
> > +        return -EIO;
> > +    }
> > +
> > +    ret =3D mnl_socket_bind(nl, 0, MNL_SOCKET_AUTOPID);
> > +    if (ret < 0) {
> > +        rdma_error_report("Fail to bind to netlink\n");
> > +        goto out;
> > +    }
> > +
> > +    nlh =3D mnl_nlmsg_put_header(buf);
> > +    nlh->nlmsg_type =3D type;
> > +    nlh->nlmsg_flags =3D NLM_F_REQUEST | NLM_F_CREATE | NLM_F_EXCL;
> > +    nlh->nlmsg_seq =3D 1;
> > +
> > +    ifm =3D mnl_nlmsg_put_extra_header(nlh, sizeof(*ifm));
> > +    ifm->ifa_index =3D if_nametoindex(ifname);
> > +    if (gid->global.subnet_prefix) {
> > +        ifm->ifa_family =3D AF_INET6;
> > +        ifm->ifa_prefixlen =3D 64;
> > +        ifm->ifa_flags =3D IFA_F_PERMANENT;
> > +        ifm->ifa_scope =3D RT_SCOPE_UNIVERSE;
> > +        mnl_attr_put(nlh, IFA_ADDRESS, sizeof(*gid), gid);
> > +    } else {
> > +        ifm->ifa_family =3D AF_INET;
> > +        ifm->ifa_prefixlen =3D 24;
> > +        memcpy(&ipv4, (char *)&gid->global.interface_id + 4, sizeof(=
ipv4));
> > +        mnl_attr_put(nlh, IFA_LOCAL, 4, &ipv4);
> > +    }
> > +
> > +    ret =3D mnl_socket_sendto(nl, nlh, nlh->nlmsg_len);
> > +    if (ret < 0) {
> > +        rdma_error_report("Fail to send msg to to netlink\n");
> > +        goto out;
> > +    }
> > +
> > +    ret =3D 0;
> > +
> > +out:
> > +    mnl_socket_close(nl);
> > +    return ret;
> > +}
> > +
> >   static inline void complete_work(enum ibv_wc_status status, uint32_=
t vendor_err,
> >                                    void *ctx)
> >   {
> > @@ -1123,7 +1183,13 @@ int rdma_backend_add_gid(RdmaBackendDev *backe=
nd_dev, const char *ifname,
> >                                               gid->global.subnet_pref=
ix,
> >                                               gid->global.interface_i=
d);
> > -    return ret;
> > +    /*
> > +     * We ignore return value since operation might completed sucess=
fully
> > +     * by the QMP consumer
> > +     */
> > +    netlink_route_update(ifname, gid, RTM_NEWADDR);
> > +
> > +    return 0;
> >   }
> >   int rdma_backend_del_gid(RdmaBackendDev *backend_dev, const char *i=
fname,
> > @@ -1149,6 +1215,12 @@ int rdma_backend_del_gid(RdmaBackendDev *backe=
nd_dev, const char *ifname,
> >                                               gid->global.subnet_pref=
ix,
> >                                               gid->global.interface_i=
d);
> > +    /*
> > +     * We ignore return value since operation might completed sucess=
fully
> > +     * by the QMP consumer
> > +     */
> > +    netlink_route_update(ifname, gid, RTM_DELADDR);
> > +
> >       return 0;
> >   }
>=20

