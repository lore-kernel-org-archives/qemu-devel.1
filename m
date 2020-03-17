Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C2AC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 06:14:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE04620663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 06:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IBY1jcXM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE04620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE5Uo-0002Uu-0R
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 02:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58382)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jE5U7-000211-Kq
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 02:13:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1jE5U5-0001GZ-MX
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 02:13:50 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:54582)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1jE5U5-00017R-Fs
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 02:13:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584425628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kT/EwxV/rJNP5D7YE7WGPxJyBBgohYLnoK0qFS4hA9A=;
 b=IBY1jcXMYQQm59NgNV+YPTlKjKewX5+t3wD5CnDfZvHPSfuG+p2nRbqUexJSQRwdIC2Die
 QsEarACHFHPD3kFRNEE+NpiBemksAl9Qty73Cjmx3dbvrgMB1v90VtrBcz7QrOem9JAt5E
 wKt8tBC97lu4z/DxoLUaYQ5pAbnCW9A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-VZ-ExKfbPt-6sXg6cTtVzQ-1; Tue, 17 Mar 2020 02:13:43 -0400
X-MC-Unique: VZ-ExKfbPt-6sXg6cTtVzQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 855A61804547;
 Tue, 17 Mar 2020 06:13:42 +0000 (UTC)
Received: from [10.72.12.89] (ovpn-12-89.pek2.redhat.com [10.72.12.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8E6FB5C1B2;
 Tue, 17 Mar 2020 06:13:40 +0000 (UTC)
Subject: Re: [PATCH] hw/net/i82596.c: Avoid reading off end of buffer in
 i82596_receive()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200312201638.6375-1-peter.maydell@linaro.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a550ff78-f639-4048-ba2b-20cea1915d83@redhat.com>
Date: Tue, 17 Mar 2020 14:13:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200312201638.6375-1-peter.maydell@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Helge Deller <deller@gmx.de>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/3/13 =E4=B8=8A=E5=8D=884:16, Peter Maydell wrote:
> The i82596_receive() function attempts to pass the guest a buffer
> which is effectively the concatenation of the data it is passed and a
> 4 byte CRC value.  However, rather than implementing this as "write
> the data; then write the CRC" it instead bumps the length value of
> the data by 4, and writes 4 extra bytes from beyond the end of the
> buffer, which it then overwrites with the CRC.  It also assumed that
> we could always fit all four bytes of the CRC into the final receive
> buffer, which might not be true if the CRC needs to be split over two
> receive buffers.
>
> Calculate separately how many bytes we need to transfer into the
> guest's receive buffer from the source buffer, and how many we need
> to transfer from the CRC work.
>
> We add a count 'bufsz' of the number of bytes left in the source
> buffer, which we use purely to assert() that we don't overrun.
>
> Spotted by Coverity (CID 1419396) for the specific case when we end
> up using a local array as the source buffer.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I know Helge has some significant rework of this device planned, but
> for 5.0 we need to fix the buffer overrun.
>
> Tested with 'make check' only.
> ---
>   hw/net/i82596.c | 44 +++++++++++++++++++++++++++++++++++---------
>   1 file changed, 35 insertions(+), 9 deletions(-)
>
> diff --git a/hw/net/i82596.c b/hw/net/i82596.c
> index fe9f2390a94..2bd5d310367 100644
> --- a/hw/net/i82596.c
> +++ b/hw/net/i82596.c
> @@ -501,7 +501,8 @@ ssize_t i82596_receive(NetClientState *nc, const uint=
8_t *buf, size_t sz)
>       uint32_t rfd_p;
>       uint32_t rbd;
>       uint16_t is_broadcast =3D 0;
> -    size_t len =3D sz;
> +    size_t len =3D sz; /* length of data for guest (including CRC) */
> +    size_t bufsz =3D sz; /* length of data in buf */
>       uint32_t crc;
>       uint8_t *crc_ptr;
>       uint8_t buf1[MIN_BUF_SIZE + VLAN_HLEN];
> @@ -595,6 +596,7 @@ ssize_t i82596_receive(NetClientState *nc, const uint=
8_t *buf, size_t sz)
>           if (len < MIN_BUF_SIZE) {
>               len =3D MIN_BUF_SIZE;
>           }
> +        bufsz =3D len;
>       }
>  =20
>       /* Calculate the ethernet checksum (4 bytes) */
> @@ -627,6 +629,7 @@ ssize_t i82596_receive(NetClientState *nc, const uint=
8_t *buf, size_t sz)
>           while (len) {
>               uint16_t buffer_size, num;
>               uint32_t rba;
> +            size_t bufcount, crccount;
>  =20
>               /* printf("Receive: rbd is %08x\n", rbd); */
>               buffer_size =3D get_uint16(rbd + 12);
> @@ -639,14 +642,37 @@ ssize_t i82596_receive(NetClientState *nc, const ui=
nt8_t *buf, size_t sz)
>               }
>               rba =3D get_uint32(rbd + 8);
>               /* printf("rba is 0x%x\n", rba); */
> -            address_space_write(&address_space_memory, rba,
> -                                MEMTXATTRS_UNSPECIFIED, buf, num);
> -            rba +=3D num;
> -            buf +=3D num;
> -            len -=3D num;
> -            if (len =3D=3D 0) { /* copy crc */
> -                address_space_write(&address_space_memory, rba - 4,
> -                                    MEMTXATTRS_UNSPECIFIED, crc_ptr, 4);
> +            /*
> +             * Calculate how many bytes we want from buf[] and how many
> +             * from the CRC.
> +             */
> +            if ((len - num) >=3D 4) {
> +                /* The whole guest buffer, we haven't hit the CRC yet */
> +                bufcount =3D num;
> +            } else {
> +                /* All that's left of buf[] */
> +                bufcount =3D len - 4;
> +            }
> +            crccount =3D num - bufcount;
> +
> +            if (bufcount > 0) {
> +                /* Still some of the actual data buffer to transfer */
> +                bufsz -=3D bufcount;
> +                assert(bufsz >=3D 0);
> +                address_space_write(&address_space_memory, rba,
> +                                    MEMTXATTRS_UNSPECIFIED, buf, bufcoun=
t);
> +                rba +=3D bufcount;
> +                buf +=3D bufcount;
> +                len -=3D bufcount;
> +            }
> +
> +            /* Write as much of the CRC as fits */
> +            if (crccount > 0) {
> +                address_space_write(&address_space_memory, rba,
> +                                    MEMTXATTRS_UNSPECIFIED, crc_ptr, crc=
count);
> +                rba +=3D crccount;
> +                crc_ptr +=3D crccount;
> +                len -=3D crccount;
>               }
>  =20
>               num |=3D 0x4000; /* set F BIT */


Applied.

Thanks



