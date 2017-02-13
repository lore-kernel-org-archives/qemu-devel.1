Received: from eggs.gnu.org ([2001:4830:134:3::10]:53055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cd8px-0003VD-Fo
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 00:06:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cd8pu-0006gR-Ak
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 00:06:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cd8pu-0006fy-5I
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 00:06:02 -0500
References: <1486693159-29029-1-git-send-email-liqiang6-s@360.cn>
	<45B33FB3-E4F3-4BAD-974D-B914B234E97C@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c82ec3f6-a7a2-931a-2ae5-8b38996213da@redhat.com>
Date: Mon, 13 Feb 2017 13:05:53 +0800
MIME-Version: 1.0
In-Reply-To: <45B33FB3-E4F3-4BAD-974D-B914B234E97C@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] net: e1000e: fix an infinite loop issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dmitry Fleytman <dmitry@daynix.com>, Li Qiang <liq3ea@gmail.com>
Cc: qemu-devel@nongnu.org, Li Qiang <liqiang6-s@360.cn>



On 2017=E5=B9=B402=E6=9C=8812=E6=97=A5 19:38, Dmitry Fleytman wrote:
> Reviewed-by: Dmitry Fleytman <dmitry@daynix.com=20
> <mailto:dmitry@daynix.com>>
>

Applied.

Thanks

>> On 10 Feb 2017, at 04:19 AM, Li Qiang <liq3ea@gmail.com=20
>> <mailto:liq3ea@gmail.com>> wrote:
>>
>> This issue is like the issue in e1000 network card addressed in
>> this commit:
>> e1000: eliminate infinite loops on out-of-bounds transfer start.
>>
>> Signed-off-by: Li Qiang <liqiang6-s@360.cn <mailto:liqiang6-s@360.cn>>
>> ---
>>
>> Change since v2:
>> fix error in e1000e_ring_empty
>> eliminate unnecessory detect code in loop
>>
>> Changes since v1:
>> make wraparound detect in e1000e_ring_empty
>>
>> hw/net/e1000e_core.c | 7 ++++++-
>> 1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
>> index 2b11499..dc94188 100644
>> --- a/hw/net/e1000e_core.c
>> +++ b/hw/net/e1000e_core.c
>> @@ -806,7 +806,8 @@ typedef struct E1000E_RingInfo_st {
>> static inline bool
>> e1000e_ring_empty(E1000ECore *core, const E1000E_RingInfo *r)
>> {
>> -    return core->mac[r->dh] =3D=3D core->mac[r->dt];
>> +    return core->mac[r->dh] =3D=3D core->mac[r->dt] ||
>> +                core->mac[r->dt] >=3D core->mac[r->dlen] /=20
>> E1000_RING_DESC_LEN;
>> }
>>
>> static inline uint64_t
>> @@ -1522,6 +1523,10 @@ e1000e_write_packet_to_guest(E1000ECore *core,=20
>> struct NetRxPkt *pkt,
>>             desc_size =3D core->rx_desc_buf_size;
>>         }
>>
>> +        if (e1000e_ring_empty(core, rxi)) {
>> +            return;
>> +        }
>> +
>>         base =3D e1000e_ring_head_descr(core, rxi);
>>
>>         pci_dma_read(d, base, &desc, core->rx_desc_len);
>> --=20
>> 1.8.3.1
>>
>
