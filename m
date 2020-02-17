Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2D2C34021
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 18:15:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A56E2070B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 18:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T9rXifZg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A56E2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3kvC-0003z7-Is
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 13:15:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41402)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j3kdD-0001Ue-UT
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:56:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j3kdC-0008Qb-Gn
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:56:31 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:34953)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j3kdB-0008QC-WE
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:56:30 -0500
Received: by mail-ot1-x344.google.com with SMTP id r16so16938886otd.2
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 09:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qDrzRZnk5NjGIil5wI536NQxw+YDxT3rcIE25TjvA48=;
 b=T9rXifZgTYun1CCczkjabx8AUrBVCOq4uSj+DQyhmilWSkaACbRmOMKtVJLUPFmQ7H
 4kn6/HI8rfYgncubjcrvAOg6JN/fHPL9TKrzon0jn3rVsujcei41ZOCymXqjNaypNM7/
 OFZSpF1+dzG/c6qIaGdKO4+JN5SrJb2nqAxiFK5j+I7FOwhUVEQS3poB+3gU00pRp9nj
 2P46MNY30RVFKwCNsp7t2B3wf5yvK17PBni5C/5jMErcI17MIY5au6rTcCdEOWSxzmdn
 9qeqPsZXS18wqbbALDZNG+vb/htIQdJnpknLGuqBbB0Kd9YUdU0djW/UtZg+ZEukk+uT
 /+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qDrzRZnk5NjGIil5wI536NQxw+YDxT3rcIE25TjvA48=;
 b=GCf0YD3q1h9z267a7wFz0CZjcybyCVvkC8VCbL7RD4rEbb/yMxUo0yjNmIQEFusB7i
 WrCqRqMhvtUmC9Vxk52ku59GXTTGLdepEtbmkkmOopsRO8FrydvrRI0/KlX2bwoshFnp
 YusxwjrsqGeo9WF1km6HpvgWZTysJ5i5p27NTgK15eJPScdk16+A1bm7vgS4rxbal6Hq
 uOmVJPBJ00kYW1szIPyA2QiFoouz6OoH0Ugwc5qGgm7Oe32qmQYakwU0CGHoY3z5OIPf
 T6p7PTWiIq0mzKWIXbnkadDxmyR26hOdfhHoKC/gRoHrkAGBU42EadfeT+asH/z2dPe9
 5t9w==
X-Gm-Message-State: APjAAAV+r31/vI6FHSlTjezNzrrG/1lDmFpzybdRgXttL+/Yk74Fo456
 tnjzw9HpR7J7GZYzIck6lI7c/R+W1/Q/Pw8z6/HYWQ==
X-Google-Smtp-Source: APXvYqxc3LHx6s0x5FigHquRo1Q8WsIoc9tf0f3x8EMvniBDaOv6P8Do2+KgymCORDRWX1bwWnsGG5GMlQ5bvyDLlGA=
X-Received: by 2002:a05:6830:1184:: with SMTP id
 u4mr12425516otq.221.1581962189067; 
 Mon, 17 Feb 2020 09:56:29 -0800 (PST)
MIME-Version: 1.0
References: <20200124232009.12928-1-richard.henderson@linaro.org>
 <20200124232009.12928-3-richard.henderson@linaro.org>
In-Reply-To: <20200124232009.12928-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Feb 2020 17:56:18 +0000
Message-ID: <CAFEAcA_aA1jNkkgmdxLqUhSbAz7JL2chAU1+s475HSoqKQiukg@mail.gmail.com>
Subject: Re: [PULL v3 02/11] hppa: Add support for LASI chip with i82596 NIC
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Helge Deller <deller@gmx.de>, Sven Schnelle <svens@stackframe.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 24 Jan 2020 at 23:20, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> From: Helge Deller <deller@gmx.de>
>
> LASI is a built-in multi-I/O chip which supports serial, parallel,
> network (Intel i82596 Apricot), sound and other functionalities.
> LASI has been used in many HP PARISC machines.
> This patch adds the necessary parts to allow Linux and HP-UX to detect
> LASI and the network card.
>
> Signed-off-by: Helge Deller <deller@gmx.de>
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> Message-Id: <20191220211512.3289-3-svens@stackframe.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Hi; Coverity has an issue with this code (CID 1419396):


> +#define ETHER_TYPE_LEN 2
> +#define VLAN_TCI_LEN 2
> +#define VLAN_HLEN (ETHER_TYPE_LEN + VLAN_TCI_LEN)


> +#define MIN_BUF_SIZE 60
> +
> +ssize_t i82596_receive(NetClientState *nc, const uint8_t *buf, size_t sz)
> +{
> +    I82596State *s = qemu_get_nic_opaque(nc);
> +    uint32_t rfd_p;
> +    uint32_t rbd;
> +    uint16_t is_broadcast = 0;
> +    size_t len = sz;
> +    uint32_t crc;
> +    uint8_t *crc_ptr;
> +    uint8_t buf1[MIN_BUF_SIZE + VLAN_HLEN];

This buffer is 60 + 2 + 2 == 64 bytes large...

> +    /* if too small buffer, then expand it */
> +    if (len < MIN_BUF_SIZE + VLAN_HLEN) {
> +        memcpy(buf1, buf, len);
> +        memset(buf1 + len, 0, MIN_BUF_SIZE + VLAN_HLEN - len);
> +        buf = buf1;
> +        if (len < MIN_BUF_SIZE) {
> +            len = MIN_BUF_SIZE;
> +        }

...here if we're using the buf1[] buffer then len must
be >= MIN_BUF_SIZE (60) and < MIN_BUF_SIZE + VLAN_HLEN (64),
so it's in the range 60 to 63...

> +    }
> +
> +    /* Calculate the ethernet checksum (4 bytes) */
> +    len += 4;
> +    crc = cpu_to_be32(crc32(~0, buf, sz));
> +    crc_ptr = (uint8_t *) &crc;

...but then we add 4 to len here, so it's now 64 to 67...

> +    while (len) {



> +            num = buffer_size & SIZE_MASK;
> +            if (num > len) {
> +                num = len;
> +            }

...before using len as the cap on how many bytes we write...

> +            rba = get_uint32(rbd + 8);
> +            /* printf("rba is 0x%x\n", rba); */
> +            address_space_rw(&address_space_memory, rba,
> +                MEMTXATTRS_UNSPECIFIED, (void *)buf, num, 1);

...from the buffer into guest memory here.

So we could be reading off the end of the buffer.

I don't know whether the buffer should be 4 bytes
larger to allow for the checksum, or if the len calculation
is wrong.

PS: I think calling address_space_write() with a constant
final argument is confusing;
"address_space_rw(as, addr, attrs, buf, len, 1)"
is equivalent to
"address_space_write(as, addr, attrs, buf, len)",
except that it's more obvious that it's a write rather
than a read, and it avoids an extra layer of function
call. We do seem to have a surprisingly large number of
places in the codebase that call address_space_rw() with a
constant final argument, though...

thanks
-- PMM

