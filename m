Received: from eggs.gnu.org ([2001:4830:134:3::10]:59907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dp3L1-0002iY-Tg
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 22:11:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dp3Kx-0007aT-0y
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 22:11:39 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:60105
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dp3Kw-0007VH-Dj
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 22:11:34 -0400
References: <1504505688-32455-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1504505688-32455-2-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <6e950754-7be8-1e9e-1fb8-3fffbdff44e2@cn.fujitsu.com>
Date: Tue, 5 Sep 2017 10:11:07 +0800
MIME-Version: 1.0
In-Reply-To: <1504505688-32455-2-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V5 1/3] net/colo-compare.c: Optimize
 unpredictable tcp options comparison
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>

Hi Chen,

At 09/04/2017 02:14 PM, Zhang Chen wrote:
> When network is busy, some tcp options(like sack) will unpredictable
> occur in primary side or secondary side. it will make packet size
> not same, but the two packet's payload is identical. colo just
> care about packet payload, so we skip the option field.
>
> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> ---
>  net/colo-compare.c | 40 ++++++++++++++++++++++++++++------------
>  1 file changed, 28 insertions(+), 12 deletions(-)
>
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index ca67c68..18a9ebf 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -186,7 +186,10 @@ static int packet_enqueue(CompareState *s, int mode)
>   * return:    0  means packet same
>   *            > 0 || < 0 means packet different
>   */
> -static int colo_packet_compare_common(Packet *ppkt, Packet *spkt, int offset)
> +static int colo_packet_compare_common(Packet *ppkt,
> +                                      Packet *spkt,
> +                                      int poffset,
> +                                      int soffset)
>  {
>      if (trace_event_get_state(TRACE_COLO_COMPARE_MISCOMPARE)) {
>          char pri_ip_src[20], pri_ip_dst[20], sec_ip_src[20], sec_ip_dst[20];
> @@ -201,12 +204,14 @@ static int colo_packet_compare_common(Packet *ppkt, Packet *spkt, int offset)
>                                     sec_ip_src, sec_ip_dst);
>      }
>
> -    offset = ppkt->vnet_hdr_len + offset;
> +    poffset = ppkt->vnet_hdr_len + poffset;
> +    soffset = ppkt->vnet_hdr_len + soffset;
>
> -    if (ppkt->size == spkt->size) {
> -        return memcmp(ppkt->data + offset,
> -                      spkt->data + offset,
> -                      spkt->size - offset);
> +    if (ppkt->size == spkt->size ||
> +        ppkt->size - poffset == spkt->size - soffset) {

This logic has a problem:

ppkt->data
    |-----------|---------rangeP---------|
                |                    \   |
            poffset                 ppkt->size
                  \    equal range     \
spkt->data        \                    \
    |---------------|------rangeS--------|
                    |                    |
                 soffset            spkt->size

See the above picture, (ppkt->size == spkt->size) is true,
if  [soffset, spkt->size] == [poffset, poffset+(spkt->size- soffset) is
also ture, the code will return 0, but actually, they are not equal.

Please use following code instead,

if (ppkt->size - poffset == spkt->size - soffset)

I am a new boy in COLO, let's see what we actually want to compare,
If I am wrong, please correct me. :-)

ppkt->data
    |-----------|---------rangeP---------|
                |                        |
            poffset                 ppkt->size

spkt->data
    |----|----------rangeS---------|
         |                         |
      soffset                 spkt->size

The data in rangeP and rangeS is what we want to compare.
So, we just need care about the rangeX's size and head pointer,
not the whole size.


Thanks,
	dou.
