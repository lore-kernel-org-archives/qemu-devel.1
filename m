Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFC8C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 11:03:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC0C424684
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 11:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K0LLwGRB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC0C424684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwOet-0002Mu-2s
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 06:03:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54937)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iwOdH-0000vj-U0
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 06:02:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iwOdG-0002oj-27
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 06:02:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47083
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iwOdF-0002nP-Ua
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 06:02:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580209329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZHaLcdtUw5DUQxzc3CgyK6RsrZ6vUrQ5rTqJ7ofs78I=;
 b=K0LLwGRBvYPR6Whu5g90XhaWCOQH20+gH9NEQW1MMD7n325Gy/L2eOjr3tpqSxUzKeCp6A
 DAk/sS+GPEBk7Gw1CxgGu2Bnee5KagfGcDn97UbtwYVdbNv7oijxtoxCzauzIMuaMdLgXa
 B1DnIrmPbvIYM0LwmLoi8IrwqLrogAc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-zhPUGnogN6mvhabyWrKFIQ-1; Tue, 28 Jan 2020 06:02:05 -0500
Received: by mail-wm1-f70.google.com with SMTP id t17so785782wmi.7
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 03:02:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dYefnlGFSFFsBNuCLyjC3aLwje/zLThNGkDhFWpAZsY=;
 b=c/mE+k4Us0upx2EVUbqv9yqKxCyjmUZ2sbGL+es6Yp9e7ZvKjyINFGbbrIbWNZ+aqX
 NaSRTNxWcTQJukVIzpNXXqoe7vAE0+7sjWJucXZjlNbJxMjrTndsztZV1Koalk2SRfc9
 0zrGl2WAfSYGX1Z+puhpBjP7lA13oNx3btpNPj9q7NRNIdFRe48q4l6ptAEHZZ/4W4tI
 vqjLcq4SEnzwOiVsK3OyWOiswRVSHew0xmlqm6t4TUwoSk5QcVvchB0ut3ZmQmOcBE8E
 j2gf+fZFNLUMPgD+NLLuick5fvY+/GlTkHSEDeSgiJZAPh/BW/h7J2AZz2BCt8i/PsML
 8yFg==
X-Gm-Message-State: APjAAAWt6/APDvzOHiTCi+iSITnFZd7tvOL+a2RmXxy3Jf/u0sEOWi+x
 iPsA/vx8bP5JbIjXjo9hIH2zUo58WfKI5CZKGD8ck8auvOPotfV7ipAMCzb44wxFAzMQE67NJ3N
 6rCl7NPmkXu7JDNU=
X-Received: by 2002:a05:600c:224a:: with SMTP id
 a10mr4378255wmm.143.1580209323552; 
 Tue, 28 Jan 2020 03:02:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqwOtDYhgg0Y6RlIrqm39rEhqtsGcYRH4RtUjh1SZ1TxuGUS6o2V3VrOTORXsx9tQpEzLbwm9w==
X-Received: by 2002:a05:600c:224a:: with SMTP id
 a10mr4378227wmm.143.1580209323207; 
 Tue, 28 Jan 2020 03:02:03 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id w13sm25834763wru.38.2020.01.28.03.02.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2020 03:02:02 -0800 (PST)
Subject: Re: [PATCH v3 10/14] dp8393x: Pad frames to word or long word boundary
To: Finn Thain <fthain@telegraphics.com.au>, Jason Wang
 <jasowang@redhat.com>, qemu-devel@nongnu.org
References: <cover.1579474761.git.fthain@telegraphics.com.au>
 <49ee52289db03344afc627dd49706ae81eb7d165.1579474761.git.fthain@telegraphics.com.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0fc958f0-b602-ea63-9076-79a0f5112ed3@redhat.com>
Date: Tue, 28 Jan 2020 12:02:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <49ee52289db03344afc627dd49706ae81eb7d165.1579474761.git.fthain@telegraphics.com.au>
Content-Language: en-US
X-MC-Unique: zhPUGnogN6mvhabyWrKFIQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/19/20 11:59 PM, Finn Thain wrote:
> The existing code has a bug where the Remaining Buffer Word Count (RBWC)
> is calculated with a truncating division, which gives the wrong result
> for odd-sized packets.
>=20
> Section 1.4.1 of the datasheet says,
>=20
>      Once the end of the packet has been reached, the serializer will
>      fill out the last word (16-bit mode) or long word (32-bit mode)
>      if the last byte did not end on a word or long word boundary
>      respectively. The fill byte will be 0FFh.
>=20
> Implement buffer padding so that buffer limits are correctly enforced.
>=20
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> Tested-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   hw/net/dp8393x.c | 39 ++++++++++++++++++++++++++++-----------
>   1 file changed, 28 insertions(+), 11 deletions(-)
>=20
> diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
> index b052e2c854..13513986f0 100644
> --- a/hw/net/dp8393x.c
> +++ b/hw/net/dp8393x.c
> @@ -766,16 +766,23 @@ static ssize_t dp8393x_receive(NetClientState *nc, =
const uint8_t * buf,
>       dp8393xState *s =3D qemu_get_nic_opaque(nc);
>       int packet_type;
>       uint32_t available, address;
> -    int width, rx_len =3D pkt_size;
> +    int width, rx_len, padded_len;
>       uint32_t checksum;
>       int size;
>  =20
> -    width =3D (s->regs[SONIC_DCR] & SONIC_DCR_DW) ? 2 : 1;
> -
>       s->regs[SONIC_RCR] &=3D ~(SONIC_RCR_PRX | SONIC_RCR_LBK | SONIC_RCR=
_FAER |
>           SONIC_RCR_CRCR | SONIC_RCR_LPKT | SONIC_RCR_BC | SONIC_RCR_MC);
>  =20
> -    if (pkt_size + 4 > dp8393x_rbwc(s) * 2) {
> +    rx_len =3D pkt_size + sizeof(checksum);
> +    if (s->regs[SONIC_DCR] & SONIC_DCR_DW) {
> +        width =3D 2;
> +        padded_len =3D ((rx_len - 1) | 3) + 1;
> +    } else {
> +        width =3D 1;
> +        padded_len =3D ((rx_len - 1) | 1) + 1;
> +    }
> +
> +    if (padded_len > dp8393x_rbwc(s) * 2) {
>           DPRINTF("oversize packet, pkt_size is %d\n", pkt_size);
>           s->regs[SONIC_ISR] |=3D SONIC_ISR_RBAE;
>           dp8393x_update_irq(s);
> @@ -810,22 +817,32 @@ static ssize_t dp8393x_receive(NetClientState *nc, =
const uint8_t * buf,
>       s->regs[SONIC_TRBA0] =3D s->regs[SONIC_CRBA0];
>  =20
>       /* Calculate the ethernet checksum */
> -    checksum =3D cpu_to_le32(crc32(0, buf, rx_len));
> +    checksum =3D cpu_to_le32(crc32(0, buf, pkt_size));
>  =20
>       /* Put packet into RBA */
>       DPRINTF("Receive packet at %08x\n", dp8393x_crba(s));
>       address =3D dp8393x_crba(s);
>       address_space_rw(&s->as, address,
> -        MEMTXATTRS_UNSPECIFIED, (uint8_t *)buf, rx_len, 1);
> -    address +=3D rx_len;
> +        MEMTXATTRS_UNSPECIFIED, (uint8_t *)buf, pkt_size, 1);
> +    address +=3D pkt_size;
> +
> +    /* Put frame checksum into RBA */
>       address_space_rw(&s->as, address,
> -        MEMTXATTRS_UNSPECIFIED, (uint8_t *)&checksum, 4, 1);
> -    address +=3D 4;
> -    rx_len +=3D 4;
> +        MEMTXATTRS_UNSPECIFIED, (uint8_t *)&checksum, sizeof(checksum), =
1);
> +    address +=3D sizeof(checksum);
> +
> +    /* Pad short packets to keep pointers aligned */
> +    if (rx_len < padded_len) {
> +        size =3D padded_len - rx_len;
> +        address_space_rw(&s->as, address, MEMTXATTRS_UNSPECIFIED,
> +            (uint8_t *)"\xFF\xFF\xFF", size, 1);
> +        address +=3D size;
> +    }
> +
>       s->regs[SONIC_CRBA1] =3D address >> 16;
>       s->regs[SONIC_CRBA0] =3D address & 0xffff;
>       available =3D dp8393x_rbwc(s);
> -    available -=3D rx_len / 2;
> +    available -=3D padded_len >> 1;
>       s->regs[SONIC_RBWC1] =3D available >> 16;
>       s->regs[SONIC_RBWC0] =3D available & 0xffff;
>  =20
>=20

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


