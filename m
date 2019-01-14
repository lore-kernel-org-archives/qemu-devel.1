Received: from eggs.gnu.org ([209.51.188.92]:53587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1gizf8-0002zG-Tf
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:40:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1gizf7-0001a1-PG
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:40:10 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:37203)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1gizf7-0001VC-Fc
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:40:09 -0500
Received: by mail-wm1-x32a.google.com with SMTP id g67so8281268wmd.2
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 02:40:08 -0800 (PST)
MIME-Version: 1.0
References: <cover.1514169758.git.maozy.fnst@cn.fujitsu.com>
	<13419a5985e00c236467916d3b26af89bc2daacd.1514169758.git.maozy.fnst@cn.fujitsu.com>
	<f79013e3-2d7c-0bd2-d61a-6c46568e672b@redhat.com>
In-Reply-To: <f79013e3-2d7c-0bd2-d61a-6c46568e672b@redhat.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Mon, 14 Jan 2019 18:39:55 +0800
Message-ID: <CAK3tnv+TUieFC-TYmD7v04Zb8ercP6D9XvUH=cqayCXYxFqZKQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 2/2] colo: compare the packet based on
 the tcp sequence number
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, qemu-devel@nongnu.org, Li Zhijian <lizhijian@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>, Mao Zhongyi <maozhongyi@cmss.chinamobile.com>

On Mon, Jan 14, 2019, 6:34 PM Thomas Huth <thuth@redhat.com wrote:

> On 2017-12-25 03:54, Mao Zhongyi wrote:
> > Packet size some time different or when network is busy.
> > Based on same payload size, but TCP protocol can not
> > guarantee send the same one packet in the same way,
> [...]
> > Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
> > Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > Reviewed-by: Zhang Chen <zhangckid@gmail.com>
> > Tested-by: Zhang Chen <zhangckid@gmail.com>
> > ---
> >  net/colo-compare.c | 343
> +++++++++++++++++++++++++++++++++++------------------
> >  net/colo.c         |   9 ++
> >  net/colo.h         |  15 +++
> >  net/trace-events   |   2 +-
> >  4 files changed, 250 insertions(+), 119 deletions(-)
> >
> > diff --git a/net/colo-compare.c b/net/colo-compare.c
> > index f39ca02..8622b0b 100644
> > --- a/net/colo-compare.c
> > +++ b/net/colo-compare.c
> [...]
> > @@ -214,104 +254,175 @@ static int colo_compare_packet_payload(Packet
> *ppkt,
> >  }
> >
> >  /*
> > - * Called from the compare thread on the primary
> > - * for compare tcp packet
> > - * compare_tcp copied from Dr. David Alan Gilbert's branch
> > - */
> > -static int colo_packet_compare_tcp(Packet *spkt, Packet *ppkt)
> > + * return true means that the payload is consist and
> > + * need to make the next comparison, false means do
> > + * the checkpoint
> > +*/
> > +static bool colo_mark_tcp_pkt(Packet *ppkt, Packet *spkt,
> > +                              int8_t *mark, uint32_t max_ack)
> >  {
> > -    struct tcphdr *ptcp, *stcp;
> > -    int res;
> > +    *mark = 0;
> > +
> > +    if (ppkt->tcp_seq == spkt->tcp_seq && ppkt->seq_end ==
> spkt->seq_end) {
> > +        if (colo_compare_packet_payload(ppkt, spkt,
> > +                                        ppkt->header_size,
> spkt->header_size,
> > +                                        ppkt->payload_size)) {
> > +            *mark = COLO_COMPARE_FREE_SECONDARY |
> COLO_COMPARE_FREE_PRIMARY;
> > +            return true;
> > +        }
> > +    }
> > +    if (ppkt->tcp_seq == spkt->tcp_seq && ppkt->seq_end ==
> spkt->seq_end) {
> > +        if (colo_compare_packet_payload(ppkt, spkt,
> > +                                        ppkt->header_size,
> spkt->header_size,
> > +                                        ppkt->payload_size)) {
> > +            *mark = COLO_COMPARE_FREE_SECONDARY |
> COLO_COMPARE_FREE_PRIMARY;
> > +            return true;
> > +        }
> > +    }
>
>  Hi,
>
> seems like this patch introduced some duplicated code, see this bug
> ticket here:
>
>  https://bugs.launchpad.net/qemu/+bug/1811499
>
> Is the second if-statement here on purpose? If yes, maybe you could add
> a comment here? If no, could you please send a patch to remove it?
>

I think it is a rebase issue, I will send a patch to remove it.

Thanks
Zhang Chen


>  Thanks,
>   Thomas
>
