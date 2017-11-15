Received: from eggs.gnu.org ([2001:4830:134:3::10]:34168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1eEnjm-0002Hc-I3
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 21:47:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1eEnjl-0004nb-Ou
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 21:47:38 -0500
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:46543)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eswierk@skyportsystems.com>)
	id 1eEnjl-0004mw-Jr
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 21:47:37 -0500
Received: by mail-io0-x242.google.com with SMTP id t11so77023iof.13
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 18:47:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4853b107-0318-b4c0-a028-f104d10869aa@redhat.com>
References: <1510701938-53743-1-git-send-email-eswierk@skyportsystems.com>
	<4853b107-0318-b4c0-a028-f104d10869aa@redhat.com>
From: Ed Swierk <eswierk@skyportsystems.com>
Date: Tue, 14 Nov 2017 18:46:56 -0800
Message-ID: <CAO_EM_=C+Fs2GsssHtJzjeXQ8ZigPn42U624hm4q+Y=tJjVV_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] net: Transmit zero UDP checksum as 0xFFFF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org

On Tue, Nov 14, 2017 at 6:10 PM, Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2017=E5=B9=B411=E6=9C=8815=E6=97=A5 07:25, Ed Swierk wrote:
>>
>> The checksum algorithm used by IPv4, TCP and UDP allows a zero value
>> to be represented by either 0x0000 and 0xFFFF. But per RFC 768, a zero
>> UDP checksum must be transmitted as 0xFFFF, as 0x0000 is a special
>> value meaning no checksum.
>>
>> Substitute 0xFFFF whenever a checksum is computed as zero on a UDP
>> datagram. Doing this on IPv4 packets and TCP segments is unnecessary
>> but legal.
>>
>> (While it is tempting to make the substitution in
>> net_checksum_finish(), that function is also used by receivers to
>> verify checksums, and in that case the expected value is always
>> 0x0000.)
>
>
> Then looks like you'd better have an wrapper for net_checksum_finish() an=
d
> do things there.

I'll do that in v2.

>> index 1019b50..e820132 100644
>> --- a/hw/net/net_rx_pkt.c
>> +++ b/hw/net/net_rx_pkt.c
>> @@ -588,6 +588,9 @@ bool net_rx_pkt_fix_l4_csum(struct NetRxPkt *pkt)
>>         /* Calculate L4 checksum */
>>       csum =3D cpu_to_be16(_net_rx_pkt_calc_l4_csum(pkt));
>> +    if (!csum) {
>> +        csum =3D 0xFFFF; /* For UDP, zero checksum must be sent as 0xFF=
FF
>> */
>> +    }
>
>
> I thought we should only do this for tx?

We need to do this any time we modify the checksum field in a UDP
datagram header for someone else to verify. Normally this happens on
the tx path, and that someone is a remote system. But here
net_rx_pkt_fix_l4_csum() is used to fill in the checksum on packets
received with the NEEDS_CSUM vhdr flag before passing them along to
the guest.

--Ed
