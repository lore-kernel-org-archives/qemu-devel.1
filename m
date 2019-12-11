Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C637C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 19:02:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 082E820836
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 19:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F2lapHSV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 082E820836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if7Ft-00068Y-2r
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 14:02:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42485)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1if7Cf-0003LW-J0
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 13:59:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1if7Ce-0002A8-3Q
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 13:59:17 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41487)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1if7Cd-00027O-QF
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 13:59:16 -0500
Received: by mail-wr1-x441.google.com with SMTP id c9so25273179wrw.8
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 10:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=q+PjkbmHB5Am03hg5uZBGVZni8npeWt12g4PoXi51Vw=;
 b=F2lapHSVqUh5pOqkolrjPZqJ9Ouz3ccHHdWd1Kqw0ngF+AZQnIEmWxWryYJqPwbb0b
 BQAsYsLCwTEqMjk9veJYeUv368oI6rswLSqS7LKytvUAK2yERYfsRWMVhCHhvbydv5MA
 IJWmYN+97wUpTzLu3uZuFFibRyzHIzPiU6Gsenvj8abhebWDCQ8B+1AMhntS98/QARxs
 myWGY6CFn1y8p776qVrVptyEU9RBaQw9X5VCYRdBxMNczIB+MmwYK9EXwrXIezn7snEr
 JNrjV8n3udv++tTXjfPrDrIPoVadbqZTzxWRLW5xCEiHtXgYJJqaOMcsEa6O3kxfYX5W
 LmGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=q+PjkbmHB5Am03hg5uZBGVZni8npeWt12g4PoXi51Vw=;
 b=uUroOyVwZk5Kqx7Xoi/kRIfVtH+ROXhvud6pYeJYx81PGupOqXVu5/fOR2LiUPf5Tf
 13BY+dqrTuuvcYm1d5gyTMyk+xXC3lyXUakQpWnZqqj+Ud5JMTRAQ/JVRucDXUW09Ky5
 69Ug7KfLj+Kt0eFVEeBFufHqm2BAL8epycjT3hgncfR4UhTDUNeom/F7NLWh1YIVt4hb
 Qv0SsCbzlPK9MXMGsJ6QqjrQG76SYNg6g4r9rmTi2cMPvMqvYaJHkIPM57zo5GsWgSqt
 yMgjjmBXLmpznwSoLVprfRSUjZkGvNGf7Iu8hTL0sckmHBdcoE2pzJcs21mT7UyM0BnZ
 Qbew==
X-Gm-Message-State: APjAAAWQmqDQNhgjSXzrtZeIdVslAoEYHvDdZMrMDXBDIfG2bpen4lcP
 s2JI+3Y1vmLSHDqsLf40oDzkYA==
X-Google-Smtp-Source: APXvYqxPz9SVpksj+sZcD1srfdipGmMGFOvqXVxiOf9Vc8WiiZsK5DM0v9hvaBfpeWTfSVfRbTujkw==
X-Received: by 2002:adf:ebc1:: with SMTP id v1mr1341493wrn.351.1576090754299; 
 Wed, 11 Dec 2019 10:59:14 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x6sm3759339wmi.44.2019.12.11.10.59.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2019 10:59:13 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 54FAB1FF87;
 Wed, 11 Dec 2019 18:59:12 +0000 (GMT)
References: <20191211160514.58373-1-damien.hedde@greensocs.com>
 <20191211160514.58373-3-damien.hedde@greensocs.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Damien Hedde <damien.hedde@greensocs.com>
Subject: Re: [PATCH v2 2/2] gdbstub: do not split gdb_monitor_write payload
In-reply-to: <20191211160514.58373-3-damien.hedde@greensocs.com>
Date: Wed, 11 Dec 2019 18:59:12 +0000
Message-ID: <871rta3czj.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: philmd@redhat.com, qemu-devel@nongnu.org, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Damien Hedde <damien.hedde@greensocs.com> writes:

> Since we can now send packets of arbitrary length:
> simplify gdb_monitor_write() and send the whole payload
> in one packet.

Do we know gdb won't barf on us. Does the negotiated max packet size
only apply to data sent to the gdbserver?

>
> Suggested-by: Luc Michel <luc.michel@greensocs.com>
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> ---
>  gdbstub.c | 23 +++--------------------
>  1 file changed, 3 insertions(+), 20 deletions(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index 93b26f1b86..ef999abee2 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -3200,28 +3200,11 @@ static void gdb_chr_event(void *opaque, int event)
>      }
>  }
>=20=20
> -static void gdb_monitor_output(GDBState *s, const char *msg, int len)
> -{
> -    g_autoptr(GString) buf =3D g_string_new("O");
> -    memtohex(buf, (uint8_t *)msg, len);
> -    put_packet(buf->str);
> -}
> -
>  static int gdb_monitor_write(Chardev *chr, const uint8_t *buf, int len)
>  {
> -    const char *p =3D (const char *)buf;
> -    int max_sz;
> -
> -    max_sz =3D (MAX_PACKET_LENGTH / 2) + 1;
> -    for (;;) {
> -        if (len <=3D max_sz) {
> -            gdb_monitor_output(&gdbserver_state, p, len);
> -            break;
> -        }
> -        gdb_monitor_output(&gdbserver_state, p, max_sz);
> -        p +=3D max_sz;
> -        len -=3D max_sz;
> -    }
> +    g_autoptr(GString) hex_buf =3D g_string_new("O");
> +    memtohex(hex_buf, buf, len);
> +    put_packet(hex_buf->str);
>      return len;
>  }


--=20
Alex Benn=C3=A9e

