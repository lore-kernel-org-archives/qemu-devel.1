Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EBEC3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 09:20:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DD7B208CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 09:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSj2AX28"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DD7B208CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9mgb-0002mC-80
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 04:20:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57674)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dmitry.fleytman@gmail.com>) id 1j9mcz-00079u-QN
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 04:17:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dmitry.fleytman@gmail.com>) id 1j9mcy-0006Df-Lm
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 04:17:13 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40808)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dmitry.fleytman@gmail.com>)
 id 1j9mcy-0006Ch-G4
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 04:17:12 -0500
Received: by mail-wr1-x443.google.com with SMTP id r17so6036732wrj.7
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 01:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=BvJxwyOI8uik0URECAGvUP4QRtGk2x8dSqMPwAl54og=;
 b=gSj2AX28TSN0r9+YiCKkBBUS1XuB4zQhM3px86AvDXkageS4LV4ucSodKG+9OgweAQ
 eGQ0+5Bi4YNlkmz8jf6QeMijmwZs2N5IDkeEgJrBuWu/MPRwi0a+truQ8Jm2PocPchzt
 +VbL5rk7PsibQB+GMuvefgGN2ww9u02FBM56Bdz/qQJ3iMO7AgrG8MRaT9uNPlX4MfyO
 01NGqOP2cNiqEgYVT6SIsc5pHnt5w2TSxeFCAFHIj9X3DI179aSDD3KhIQL/cGE+8YXW
 aUUidwbRDQvPrxdklloxdWnn2R8XDdeNpEBIK7FqImGSEFDDKk8oN269m4+65kOIkbEs
 YUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=BvJxwyOI8uik0URECAGvUP4QRtGk2x8dSqMPwAl54og=;
 b=TmSMVl6PykB5gSRVA+1pq4MLSYaGXkNrW4LCgfqKyvQlVs5A1ME/84pgWWtZ20D9sU
 t+NpFi2oQgegjv75s4r6PeYPimZ+xd1n0bjJwzk8K6NflYyfx1O6gBm6LaQR0H9u7q9z
 zWpVij0mfYPRSf5ZaLwaMGEmouVCRoTrbdkwmJD58QFme3S3nEa55bB+6/tIuF6e+SyW
 Ut0nApOngITNv8nsrxel2X6z1DkUhNIuK8u3HvOKEEsUX0WemUtHwDJ/GSDg2bFlH8oS
 X7RXhf1iz/QMl2DIVqFN2RT9JudQ4HlHURCdfVx9+1rW1WCaNQjG98amP4Ux8H+X7Xs7
 ngVQ==
X-Gm-Message-State: ANhLgQ0iD9DVuR8wijLwVHvNPi76PU+X6Z9x5RmZZ4banpFQPY97Gta0
 L0m6MX7SIR0B6L6T+tqtrHk=
X-Google-Smtp-Source: ADFU+vsscXf0KBnOHdn79iJRUlozu1uxnYZMCd2WsgMp8yk4ztyqvhrsMwCrCABanHLrmGCjKJpWzg==
X-Received: by 2002:adf:82ee:: with SMTP id 101mr3541243wrc.7.1583399831304;
 Thu, 05 Mar 2020 01:17:11 -0800 (PST)
Received: from [10.0.1.16] ([141.226.29.227])
 by smtp.gmail.com with ESMTPSA id a7sm7897520wmj.12.2020.03.05.01.17.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 05 Mar 2020 01:17:10 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH v2] Fixed integer overflow in e1000e
From: Dmitry Fleytman <dmitry.fleytman@gmail.com>
In-Reply-To: <20200304142058.52458-1-andrew@daynix.com>
Date: Thu, 5 Mar 2020 11:17:09 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <92C546EB-320E-43D8-8D9D-E2964E910324@gmail.com>
References: <20200304142058.52458-1-andrew@daynix.com>
To: andrew@daynix.com
X-Mailer: Apple Mail (2.3608.60.0.2.5)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 4 Mar 2020, at 16:20, andrew@daynix.com wrote:
>=20
> From: Andrew Melnychenko <andrew@daynix.com>
>=20
> Fixes: 6f3fbe4ed06
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1737400
> Fixed setting max_queue_num if there are no peers in NICConf. =
qemu_new_nic() creates NICState with 1 NetClientState(index 0) without =
peers, set max_queue_num to 0 - It prevents undefined behavior and =
possible crashes, especially during pcie hotplug.
>=20
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>

Reviewed-by: Dmitry Fleytman <dmitry.fleytman@gmail.com>

> ---
> hw/net/e1000e.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
> index a91dbdca3c..f2cc1552c5 100644
> --- a/hw/net/e1000e.c
> +++ b/hw/net/e1000e.c
> @@ -328,7 +328,7 @@ e1000e_init_net_peer(E1000EState *s, PCIDevice =
*pci_dev, uint8_t *macaddr)
>     s->nic =3D qemu_new_nic(&net_e1000e_info, &s->conf,
>         object_get_typename(OBJECT(s)), dev->id, s);
>=20
> -    s->core.max_queue_num =3D s->conf.peers.queues - 1;
> +    s->core.max_queue_num =3D s->conf.peers.queues ? =
s->conf.peers.queues - 1 : 0;
>=20
>     trace_e1000e_mac_set_permanent(MAC_ARG(macaddr));
>     memcpy(s->core.permanent_mac, macaddr, =
sizeof(s->core.permanent_mac));
> --=20
> 2.24.1
>=20


