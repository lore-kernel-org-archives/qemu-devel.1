Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0515BC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61D6721655
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="vHCy8fd5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61D6721655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifk9d-0001VI-Ji
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 07:34:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45678)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1ifk6d-0000rp-5Q
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:31:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1ifk6a-0002gV-4f
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:31:38 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:39822)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1ifk6Z-0002cz-Ho
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:31:36 -0500
Received: from [172.16.11.102] (crumble.bar.greensocs.com [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 8D46796EF0;
 Fri, 13 Dec 2019 12:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1576240292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bhc1GIhf3JQETAKPfdzZX+BNcXiUjsCrkpoLJYIxJXU=;
 b=vHCy8fd5hPGS5/oetRrzHcSbJT9z54tYuAU7FCTByX4Ydi5zNkEQ0J2a85GDXRlVgN/13e
 vU/bQtAEgY0rUMdozFU6ZlD6ECn9S+pHkCAbnuwBbc/eqgvoWwkCK/zMzHaNM2nErFamzU
 mD65002OCW3zCHRwfFyiepzAGAQrQNU=
Subject: Re: [PATCH v3 04/20] gdbstub: move mem_buf to GDBState and use
 GByteArray
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191211170520.7747-1-alex.bennee@linaro.org>
 <20191211170520.7747-5-alex.bennee@linaro.org>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <b5cfb77b-b969-f7e8-fb7f-a2eddd394578@greensocs.com>
Date: Fri, 13 Dec 2019 13:31:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191211170520.7747-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1576240293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bhc1GIhf3JQETAKPfdzZX+BNcXiUjsCrkpoLJYIxJXU=;
 b=ouYJZR90ApEgG/mT3wUtRMwy1zEtCj//6OVdt/W+L5oVoC2wKBI64z3qxQu45QFI+ykh4a
 2Hy2HM2tqkoKbPqbrhS4bpquzfeCzsIVfST1w/wn3TcgcdF9LlNgSaT+vPsDt3E9hFaPFC
 X3KZAxMFoEyKbcAsjkubP+13eZQghVM=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1576240293; a=rsa-sha256; cv=none;
 b=GcjBirSbZWx9VVWhRChoFogQeVxXR8lQ/z8ixgJyGaBpSk6op8xdQx0aWW5GfTCOrswRpE
 Y8ok7n7a1tOXqUJtP4TrGczKbJrYxAjHBTeUBKNrAUjnYbc5Ce3xxU07FueETukoNHv6JL
 xppj5jKgffK4RdCRSXeCQW5OLXPNHxw=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.135.226.135
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
Cc: luis.machado@linaro.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, alan.hayward@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 12/11/19 6:05 PM, Alex Benn=C3=A9e wrote:
> This is in preparation for further re-factoring of the register API
> with the rest of the code. Theoretically the read register function
> could overwrite the MAX_PACKET_LENGTH buffer although currently all
> registers are well within the size range.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Damien Hedde <damien.hedde@greensocs.com>
> Tested-by: Damien Hedde <damien.hedde@greensocs.com>
>=20
> ---
> v3
>   - fixed up email on Damien's tags
> ---
>  gdbstub.c | 56 ++++++++++++++++++++++++++++++++++---------------------
>  1 file changed, 35 insertions(+), 21 deletions(-)
>=20

> @@ -2092,11 +2105,12 @@ static void handle_query_rcmd(GdbCmdContext *gd=
b_ctx, void *user_ctx)
>      }
> =20
>      len =3D len / 2;
> -    hextomem(gdb_ctx->mem_buf, gdb_ctx->params[0].data, len);
> -    gdb_ctx->mem_buf[len++] =3D 0;
> -    qemu_chr_be_write(gdbserver_state.mon_chr, gdb_ctx->mem_buf, len);
> +    g_byte_array_set_size(gdbserver_state.mem_buf, len);

Hi Alex,

Just found out that the g_byte_array_set_size() above should be removed.
hextomem() will append data starting at offset [len] instead of [0] and
we end up with an uninitialized prefix in the array.

> +    hextomem(gdbserver_state.mem_buf, gdb_ctx->params[0].data, len);
> +    g_byte_array_append(gdbserver_state.mem_buf, &zero, 1);
> +    qemu_chr_be_write(gdbserver_state.mon_chr, gdbserver_state.mem_buf=
->data,
> +                      gdbserver_state.mem_buf->len);
>      put_packet("OK");
> -
>  }
>  #endif
> =20
>=20

I did double-checked the rest of the patch and it is it the only resize
that passed through v2 review.

Regards,
Damien

