Received: from eggs.gnu.org ([2001:4830:134:3::10]:38029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1ckQNy-0008Vn-7A
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 02:15:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1ckQNt-000453-NW
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 02:15:18 -0500
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:35719)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dmitry@daynix.com>) id 1ckQNt-000449-Cn
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 02:15:13 -0500
Received: by mail-wm0-x236.google.com with SMTP id v186so42243415wmd.0
	for <qemu-devel@nongnu.org>; Sat, 04 Mar 2017 23:15:11 -0800 (PST)
From: Dmitry Fleytman <dmitry@daynix.com>
Message-Id: <8A54246F-59C1-4600-9FF5-D3DA7D1D7CBE@daynix.com>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Date: Sun, 5 Mar 2017 09:15:18 +0200
In-Reply-To: <4fd7a104-e49e-1f3f-c4a9-1572e6db9372@amsat.org>
References: <1487248176-29602-1-git-send-email-dmitry@daynix.com>
	<1487248176-29602-5-git-send-email-dmitry@daynix.com>
	<4fd7a104-e49e-1f3f-c4a9-1572e6db9372@amsat.org>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/5] NetRxPkt: Account buffer with ETH
 header in IOV length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Yan Vugenfirer <yan@daynix.com>, Jason Wang <jasowang@redhat.com>, P J P <ppandit@redhat.com>


> On 3 Mar 2017, at 18:39 PM, Philippe Mathieu-Daud=C3=A9 =
<f4bug@amsat.org> wrote:
>=20
> Hi Dmitry,
>=20
> On 02/16/2017 09:29 AM, Dmitry Fleytman wrote:
>> In case of VLAN stripping ETH header is stored in a
>> separate chunk and length of IOV should take this into
>> account.
>>=20
>> This patch fixes checksum validation for RX packets
>> with VLAN header.
>>=20
>> Devices affected by this problem: e1000e and vmxnet3.
>>=20
>> Signed-off-by: Dmitry Fleytman <dmitry@daynix.com>
>> ---
>> hw/net/net_rx_pkt.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/hw/net/net_rx_pkt.c b/hw/net/net_rx_pkt.c
>> index d38babe..c7ae33d 100644
>> --- a/hw/net/net_rx_pkt.c
>> +++ b/hw/net/net_rx_pkt.c
>> @@ -97,7 +97,7 @@ net_rx_pkt_pull_data(struct NetRxPkt *pkt,
>>         pkt->tot_len =3D iov_size(iov, iovcnt) - ploff + =
pkt->ehdr_buf_len;
>>         pkt->vec_len =3D iov_copy(pkt->vec + 1, pkt->vec_len_total - =
1,
>>                                 iov, iovcnt, ploff,
>> -                                pkt->tot_len - pkt->ehdr_buf_len);
>> +                                pkt->tot_len - pkt->ehdr_buf_len) + =
1;
>=20
> I can not understand the trailing '1', shouldn't it be 'sizeof(struct =
vlan_header)' instead? (=3D4)
> This should be easily unit-testable.

Hi Philippe,

Please pay attention that iov_copy returns number of items in target =
IOV,
pkt->vec_len is number of items as well, so +1 is perfectly fine here.

~Dmitry

>=20
>>     } else {
>>         net_rx_pkt_iovec_realloc(pkt, iovcnt);
