Received: from eggs.gnu.org ([2001:4830:134:3::10]:38581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1ckQSu-0000yH-0E
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 02:20:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1ckQSp-0005Hz-IH
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 02:20:23 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:33726)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dmitry@daynix.com>) id 1ckQSp-0005Hm-7v
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 02:20:19 -0500
Received: by mail-wr0-x244.google.com with SMTP id g10so17918394wrg.0
	for <qemu-devel@nongnu.org>; Sat, 04 Mar 2017 23:20:18 -0800 (PST)
From: Dmitry Fleytman <dmitry@daynix.com>
Message-Id: <C3EA50CA-F26F-4A95-80CB-42F39AB3DF2F@daynix.com>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Date: Sun, 5 Mar 2017 09:20:26 +0200
In-Reply-To: <954f8f71-4a6e-7e75-3c60-91ffbc322331@amsat.org>
References: <1487248176-29602-1-git-send-email-dmitry@daynix.com>
	<1487248176-29602-2-git-send-email-dmitry@daynix.com>
	<954f8f71-4a6e-7e75-3c60-91ffbc322331@amsat.org>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/5] eth: Extend vlan stripping functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Yan Vugenfirer <yan@daynix.com>, Jason Wang <jasowang@redhat.com>, P J P <ppandit@redhat.com>


> On 3 Mar 2017, at 18:52 PM, Philippe Mathieu-Daud=C3=A9 =
<f4bug@amsat.org> wrote:
>=20
> On 02/16/2017 09:29 AM, Dmitry Fleytman wrote:
>> Make VLAN stripping functions return number of bytes
>> copied to given Ethernet header buffer.
>>=20
>> This information should be used to re-compose
>> packet IOV after VLAN stripping.
>>=20
>> Signed-off-by: Dmitry Fleytman <dmitry@daynix.com>
>> ---
>> include/net/eth.h |  4 ++--
>> net/eth.c         | 25 ++++++++++++++-----------
>> 2 files changed, 16 insertions(+), 13 deletions(-)
>>=20
>> diff --git a/include/net/eth.h b/include/net/eth.h
>> index 2013175..afeb45b 100644
>> --- a/include/net/eth.h
>> +++ b/include/net/eth.h
>> @@ -331,12 +331,12 @@ eth_get_pkt_tci(const void *p)
>>     }
>> }
>>=20
>> -bool
>> +size_t
>> eth_strip_vlan(const struct iovec *iov, int iovcnt, size_t iovoff,
>>                uint8_t *new_ehdr_buf,
>>                uint16_t *payload_offset, uint16_t *tci);
>>=20
>> -bool
>> +size_t
>> eth_strip_vlan_ex(const struct iovec *iov, int iovcnt, size_t iovoff,
>>                   uint16_t vet, uint8_t *new_ehdr_buf,
>>                   uint16_t *payload_offset, uint16_t *tci);
>> diff --git a/net/eth.c b/net/eth.c
>> index df81efb..5b9ba26 100644
>> --- a/net/eth.c
>> +++ b/net/eth.c
>> @@ -232,7 +232,7 @@ void eth_get_protocols(const struct iovec *iov, =
int iovcnt,
>>     }
>> }
>>=20
>> -bool
>> +size_t
>> eth_strip_vlan(const struct iovec *iov, int iovcnt, size_t iovoff,
>>                uint8_t *new_ehdr_buf,
>>                uint16_t *payload_offset, uint16_t *tci)
>> @@ -244,7 +244,7 @@ eth_strip_vlan(const struct iovec *iov, int =
iovcnt, size_t iovoff,
>>                                new_ehdr, sizeof(*new_ehdr));
>>=20
>>     if (copied < sizeof(*new_ehdr)) {
>> -        return false;
>> +        return 0;
>>     }
>>=20
>>     switch (be16_to_cpu(new_ehdr->h_proto)) {
>> @@ -254,7 +254,7 @@ eth_strip_vlan(const struct iovec *iov, int =
iovcnt, size_t iovoff,
>>                             &vlan_hdr, sizeof(vlan_hdr));
>>=20
>>         if (copied < sizeof(vlan_hdr)) {
>> -            return false;
>> +            return 0;
>>         }
>>=20
>>         new_ehdr->h_proto =3D vlan_hdr.h_proto;
>> @@ -268,18 +268,21 @@ eth_strip_vlan(const struct iovec *iov, int =
iovcnt, size_t iovoff,
>>                                 PKT_GET_VLAN_HDR(new_ehdr), =
sizeof(vlan_hdr));
>>=20
>>             if (copied < sizeof(vlan_hdr)) {
>> -                return false;
>> +                return 0;
>>             }
>>=20
>>             *payload_offset +=3D sizeof(vlan_hdr);
>> +
>> +            return sizeof(struct eth_header) + sizeof(struct =
vlan_header);
>> +        } else {
>> +            return sizeof(struct eth_header);
>=20
> remove this "else return ..."
>=20
>>         }
>> -        return true;
>=20
> here avoid fall-through with 'return sizeof(struct eth_header);=E2=80=99=



Hi Philippe,

IIUYC there is no functional difference, just a matter of style. Am I =
right?

As for me current code is more explicit so I would leave it as is unless
there is a specific project coding style requirement.

~Dmitry

>=20
>>     default:
>> -        return false;
>> +        return 0;
>>     }
>> }
>>=20
>> -bool
>> +size_t
>> eth_strip_vlan_ex(const struct iovec *iov, int iovcnt, size_t iovoff,
>>                   uint16_t vet, uint8_t *new_ehdr_buf,
>>                   uint16_t *payload_offset, uint16_t *tci)
>> @@ -291,7 +294,7 @@ eth_strip_vlan_ex(const struct iovec *iov, int =
iovcnt, size_t iovoff,
>>                                new_ehdr, sizeof(*new_ehdr));
>>=20
>>     if (copied < sizeof(*new_ehdr)) {
>> -        return false;
>> +        return 0;
>>     }
>>=20
>>     if (be16_to_cpu(new_ehdr->h_proto) =3D=3D vet) {
>> @@ -299,17 +302,17 @@ eth_strip_vlan_ex(const struct iovec *iov, int =
iovcnt, size_t iovoff,
>>                             &vlan_hdr, sizeof(vlan_hdr));
>>=20
>>         if (copied < sizeof(vlan_hdr)) {
>> -            return false;
>> +            return 0;
>>         }
>>=20
>>         new_ehdr->h_proto =3D vlan_hdr.h_proto;
>>=20
>>         *tci =3D be16_to_cpu(vlan_hdr.h_tci);
>>         *payload_offset =3D iovoff + sizeof(*new_ehdr) + =
sizeof(vlan_hdr);
>> -        return true;
>> +        return sizeof(struct eth_header);
>>     }
>>=20
>> -    return false;
>> +    return 0;
>> }
>>=20
>> void
>>=20
>=20
> with changes:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org =
<mailto:f4bug@amsat.org>>
>=20
> Phil.
