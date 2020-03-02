Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A78C3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 19:26:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 616CD21775
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 19:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="hrpk7YFv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 616CD21775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8qiB-0006Kf-4g
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 14:26:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55598)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <deller@gmx.de>) id 1j8qf6-0005hA-Rl
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 14:23:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <deller@gmx.de>) id 1j8qf5-0003g0-EL
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 14:23:32 -0500
Received: from mout.gmx.net ([212.227.17.20]:47721)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <deller@gmx.de>) id 1j8qf5-0003ff-5R
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 14:23:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1583177008;
 bh=jOaRiQYE/nIS4SDY2eH5+1z774YSoVNTvenet4JBR+Q=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=hrpk7YFvQZVOlCXyKSBMDABK2z7115PNNSA9VvPlqzBpZZMlMN2mys5lLoARv/zS+
 gliFFScwNnIkald4vDASu1DvAT/apPuNls+jgRkbeCIwGI/sDSd/jiUiwQ3K9J5KUt
 vrr8f7MFcVdztT3vsyujHsWSi0bhaDChAUPS4sOM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.130.108]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MrQEx-1jllyS3GR5-00oWXv; Mon, 02
 Mar 2020 20:23:27 +0100
Subject: Re: [PULL v3 02/11] hppa: Add support for LASI chip with i82596 NIC
To: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20200124232009.12928-1-richard.henderson@linaro.org>
 <20200124232009.12928-3-richard.henderson@linaro.org>
 <CAFEAcA_aA1jNkkgmdxLqUhSbAz7JL2chAU1+s475HSoqKQiukg@mail.gmail.com>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <e0e3cf61-33ef-3b95-4a2b-2458cdcab296@gmx.de>
Date: Mon, 2 Mar 2020 20:23:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_aA1jNkkgmdxLqUhSbAz7JL2chAU1+s475HSoqKQiukg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NB0IkFIhVMVBENmzI/UWKxZPzt13iI9FnYGtxR2giOAq04ZmuDm
 NbLGT1kxHgSDpFeOuzkGxWPeszUKBlJcRKqoFnm6rUM4OBgcb6VSOv8v8J1q+gRQvqczzsf
 /v98ZWBpebCDYuK89GehG4w45iTmjx/b7SuwS9FYy08kub/RhpSrUD6YMoSbxQgyR5kKSzP
 iOlm4Hmaljav/f6kuSGpQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Bn95kOdvPGo=:N1QXmhsNz5FL68njCXCSxw
 qMmyqSYx0oa7ojtD5uguvscpKWBB7Eb1jaKyUmihIm2ZC5F0o+gDD9BcpKEM2ZO0ig+9PsPYs
 q2IfhKLweei0HEV+l+jl/r+MRppV3wUdIP6bAY1Jz6eJk6SR8Q22vTDFE/Axe2ALrxYNDxaMx
 OZj6sWDlK9bjpdhvAP0DqT7mmp8L3lE/swXpXqSi+gWn9Jv4fwCvHiEN3dTozxqT35Rl+tzsm
 xqLOJ2S632nN3+VmyzHIL43tp6srlTQiXQRB+2K1Xk8WfIwyhGQLPleh/PnPlaiVNMXwWGYIj
 N814KLGcVqfqJAF8Jh0anvyHI98xTpuEjFGPZeTkySbAFK5U/gs6S4zBGMZ78Wkt8Msknurvl
 c2Bo4h/wuYEo+fCovMdsRx6gGG4GVHhuM4LDOJ0XVI2UY58SEJSm5icDlma9NkHFXT20Rp/14
 TR+kGFtTdFvH/3kCLdbQTi0zcScun36ot20VnBS4SE5jjyWarbdBhe89rRdUCu5IbOlAAM98P
 i+plVNmhD1Lp+hbje/Gby0aPxyhwk+ZGTg49xgG647z9pUNR6IkQAb/mKJhdKPuVYtAujRC/G
 jzb8EAJJ7BtB9d4FdoM2cxnKjp316lL/gYWxQ6I4C9OGjbTlL8Pb6kqMDM97i4TPzKWIXPOS5
 VbdIasiSJodaGGIys/anjUq1Wv9kUw/07Yl4LkksvpoDemw8XSfDx4SDJn1jo5GiTHN2VBR4f
 KaOYXPTFfiGmPXJLMaWRmMHtDBiZFBpx7dWqbT+uXku/AJchH1FjUP9VYZelshNQ4+uLDd3TU
 sjRFhfCkD0bDpySUuWyrowxqFY+NrV92DLX6GxxeX+nb/uRBZTwPaIwFzUXVWOnCM3cJBllNK
 5+ukT6WTkUta0bG1l7i0krNciOG65YmV4SQQfKT96As3u/ZPu1NRq0gFI2glYcwOfGr7oRCX2
 WanDvqHjeqrWQA1vnHnp62ncyOcTcxLrj0ufK6plO98QcAdIbmQn9G//E8JaP2r8fbvGl3f7M
 ws0t+Y22y8FtWs/qOTQvZa8csGNuRer9c6eISs1D5jxSa3sPKMsEyV8q2yeYP2bBm1NZlDyvj
 FZ/5RO6AIX3CXTHXg/rBegDQ6TOhjLc3s/AgkkdDldnQ67jLMVQaXgGmnQb4+heFCfPt2TheY
 uRsTXPdBY5hZrrMJPL9axrmJHM9Vz9gNMC216nm7bxT53U8r0rTXTOnSe86eGsH/L/saCtj6S
 aNLc9c/fR7TmpalJ3
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.20
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
Cc: Sven Schnelle <svens@stackframe.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17.02.20 18:56, Peter Maydell wrote:
> On Fri, 24 Jan 2020 at 23:20, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> From: Helge Deller <deller@gmx.de>
>>
>> LASI is a built-in multi-I/O chip which supports serial, parallel,
>> network (Intel i82596 Apricot), sound and other functionalities.
>> LASI has been used in many HP PARISC machines.
>> This patch adds the necessary parts to allow Linux and HP-UX to detect
>> LASI and the network card.
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> Signed-off-by: Sven Schnelle <svens@stackframe.org>
>> Message-Id: <20191220211512.3289-3-svens@stackframe.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>
> Hi; Coverity has an issue with this code (CID 1419396):
>
>
>> +#define ETHER_TYPE_LEN 2
>> +#define VLAN_TCI_LEN 2
>> +#define VLAN_HLEN (ETHER_TYPE_LEN + VLAN_TCI_LEN)
>
>
>> +#define MIN_BUF_SIZE 60
>> +
>> +ssize_t i82596_receive(NetClientState *nc, const uint8_t *buf, size_t =
sz)
>> +{
>> +    I82596State *s =3D qemu_get_nic_opaque(nc);
>> +    uint32_t rfd_p;
>> +    uint32_t rbd;
>> +    uint16_t is_broadcast =3D 0;
>> +    size_t len =3D sz;
>> +    uint32_t crc;
>> +    uint8_t *crc_ptr;
>> +    uint8_t buf1[MIN_BUF_SIZE + VLAN_HLEN];
>
> This buffer is 60 + 2 + 2 =3D=3D 64 bytes large...
>
>> +    /* if too small buffer, then expand it */
>> +    if (len < MIN_BUF_SIZE + VLAN_HLEN) {
>> +        memcpy(buf1, buf, len);
>> +        memset(buf1 + len, 0, MIN_BUF_SIZE + VLAN_HLEN - len);
>> +        buf =3D buf1;
>> +        if (len < MIN_BUF_SIZE) {
>> +            len =3D MIN_BUF_SIZE;
>> +        }
>
> ...here if we're using the buf1[] buffer then len must
> be >=3D MIN_BUF_SIZE (60) and < MIN_BUF_SIZE + VLAN_HLEN (64),
> so it's in the range 60 to 63...
>
>> +    }
>> +
>> +    /* Calculate the ethernet checksum (4 bytes) */
>> +    len +=3D 4;
>> +    crc =3D cpu_to_be32(crc32(~0, buf, sz));
>> +    crc_ptr =3D (uint8_t *) &crc;
>
> ...but then we add 4 to len here, so it's now 64 to 67...
>
>> +    while (len) {
>
>
>
>> +            num =3D buffer_size & SIZE_MASK;
>> +            if (num > len) {
>> +                num =3D len;
>> +            }
>
> ...before using len as the cap on how many bytes we write...
>
>> +            rba =3D get_uint32(rbd + 8);
>> +            /* printf("rba is 0x%x\n", rba); */
>> +            address_space_rw(&address_space_memory, rba,
>> +                MEMTXATTRS_UNSPECIFIED, (void *)buf, num, 1);
>
> ...from the buffer into guest memory here.
>
> So we could be reading off the end of the buffer.
>
> I don't know whether the buffer should be 4 bytes
> larger to allow for the checksum, or if the len calculation
> is wrong.

I'm working on a bigger patch which will improve this driver.
It still has some issues with the emulation in Linux and HP-UX.
With the patch I will take try to fix those out-of-bounds
accesses too.
It will take some time though, until I will send the patch.

> PS: I think calling address_space_write() with a constant
> final argument is confusing;
> "address_space_rw(as, addr, attrs, buf, len, 1)"
> is equivalent to
> "address_space_write(as, addr, attrs, buf, len)",
> except that it's more obvious that it's a write rather
> than a read, and it avoids an extra layer of function
> call. We do seem to have a surprisingly large number of
> places in the codebase that call address_space_rw() with a
> constant final argument, though...

Thanks for cleaning this up in the meantime!

Helge

