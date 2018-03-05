Received: from eggs.gnu.org ([2001:4830:134:3::10]:50738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1esmib-0003qi-Tp
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 04:47:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1esmib-0000Y5-1h
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 04:47:41 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:36801)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1esmia-0000Ww-R5
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 04:47:40 -0500
Received: by mail-ot0-x243.google.com with SMTP id 108so14337756otv.3
	for <qemu-devel@nongnu.org>; Mon, 05 Mar 2018 01:47:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA80iGW6850=8kKeCZT4ZipproJ478yorjMn9-M=0T=C_w@mail.gmail.com>
References: <20180209190340.19516-1-marcandre.lureau@redhat.com>
	<CAFEAcA80iGW6850=8kKeCZT4ZipproJ478yorjMn9-M=0T=C_w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Mar 2018 09:47:19 +0000
Message-ID: <CAFEAcA-D=8mWzRTLfsky-3UqvPX20tGg=3zPTn8y5ngWSZe-Vg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] net: fix misaligned member access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>

On 2 March 2018 at 17:22, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 9 February 2018 at 19:03, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
>> Fixes the following ASAN warnings:
>>
>> /home/elmarco/src/qemu/hw/net/net_tx_pkt.c:201:27: runtime error: member=
 access within misaligned address 0x631000028846 for type 'struct ip_header=
', which requires 4 byte alignment
>> 0x631000028846: note: pointer points here
>>  01 00 00 00 45 00  01 a9 01 00 00 00 40 11  78 45 00 00 00 00 ff ff  ff=
 ff 00 00 00 00 00 00  00 00
>>              ^
>> /home/elmarco/src/qemu/hw/net/net_tx_pkt.c:208:63: runtime error: member=
 access within misaligned address 0x631000028846 for type 'struct ip_header=
', which requires 4 byte alignment
>> 0x631000028846: note: pointer points here
>>  01 00 00 00 45 00  01 a9 01 00 00 00 40 11  78 45 00 00 00 00 ff ff  ff=
 ff 00 00 00 00 00 00  00 00
>>              ^
>> /home/elmarco/src/qemu/hw/net/net_tx_pkt.c:210:13: runtime error: member=
 access within misaligned address 0x631000028846 for type 'struct ip_header=
', which requires 4 byte alignment
>> 0x631000028846: note: pointer points here
>>  01 00 00 00 45 00  01 a9 01 00 00 00 40 11  78 45 00 00 00 00 ff ff  ff=
 ff 00 00 00 00 00 00  00 00
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  include/net/eth.h   | 4 +++-
>>  hw/net/net_tx_pkt.c | 2 +-
>>  2 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/net/eth.h b/include/net/eth.h
>> index 09054a506d..e6dc8a7ba0 100644
>> --- a/include/net/eth.h
>> +++ b/include/net/eth.h
>> @@ -194,7 +194,9 @@ struct tcp_hdr {
>>  #define PKT_GET_IP_HDR(p)         \
>>      ((struct ip_header *)(((uint8_t *)(p)) + eth_get_l2_hdr_length(p)))
>>  #define IP_HDR_GET_LEN(p)         \
>> -    ((((struct ip_header *)(p))->ip_ver_len & 0x0F) << 2)
>> +    ((ldub_p(p + offsetof(struct ip_header, ip_ver_len)) & 0x0F) << 2)
>> +#define IP_HDR_GET_P(p)                                           \
>> +    (ldub_p(p + offsetof(struct ip_header, ip_p)))
>>  #define PKT_GET_IP_HDR_LEN(p)     \
>>      (IP_HDR_GET_LEN(PKT_GET_IP_HDR(p)))
>>  #define PKT_GET_IP6_HDR(p)        \
>> diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
>> index e29c881bc2..162f802dd7 100644
>> --- a/hw/net/net_tx_pkt.c
>> +++ b/hw/net/net_tx_pkt.c
>> @@ -205,7 +205,7 @@ static bool net_tx_pkt_parse_headers(struct NetTxPkt=
 *pkt)
>>              return false;
>>          }
>>
>> -        pkt->l4proto =3D ((struct ip_header *) l3_hdr->iov_base)->ip_p;
>> +        pkt->l4proto =3D IP_HDR_GET_P(l3_hdr->iov_base);
>>
>>          if (IP_HDR_GET_LEN(l3_hdr->iov_base) !=3D sizeof(struct ip_head=
er)) {
>>              /* copy optional IPv4 header data if any*/
>> --
>> 2.16.1.73.g5832b7e9f2
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>
> and I'm going to apply this to master, because I'm fed up of the warnings
> in my build system logs.

Now applied to master, thanks.

-- PMM
