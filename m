Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C193DC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 11:18:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F0AF206EC
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 11:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="kRb7ZBTU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F0AF206EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic6CR-0004dH-Hb
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 06:18:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50786)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1ic65O-0002WI-Pp
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 06:11:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1ic65M-0003ee-23
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 06:11:17 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:34304)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1ic65L-0003Vd-C0
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 06:11:15 -0500
Received: from [172.16.11.102] (crumble.bar.greensocs.com [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 41CF296EF0;
 Tue,  3 Dec 2019 11:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1575371468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JhM5Uq17n49K43hUmBenzUluJwqYIndtOXGat1c+uqE=;
 b=kRb7ZBTU7du+gNFWEkhB27d0V7L2fy7b9RZ8sH9iUpyppoL4gjmcECxCYPlRof1MR1ayTU
 vDd/EkmuCkYG7kGc+Vmd7YwGKQWwYgYzfM1/Ioly5cb81w/+hbMaRavWbhOEPiEka73Rk7
 YFRXbvNyPosCteoME0UG8OEotdAzqWs=
Subject: Re: [PATCH v2 04/14] gdbstub: move mem_buf to GDBState and use
 GByteArray
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191130084602.10818-1-alex.bennee@linaro.org>
 <20191130084602.10818-5-alex.bennee@linaro.org>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <8f9519f0-78f7-707a-007f-71be24339477@greensocs.com>
Date: Tue, 3 Dec 2019 12:11:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191130084602.10818-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1575371468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JhM5Uq17n49K43hUmBenzUluJwqYIndtOXGat1c+uqE=;
 b=jbVCNBxgoYIOWtmPW2XcwlzJgBLuUbDCFYi02X2VWL6/KzPUNKwxlJh11OEiRTV5blAknT
 2ZIiEMPuOb+N+DDsZj1mSEieudiZmNpuYj/60JN/X9CT5Ko+TXD+ZxwwrjOALOiNJxbRbv
 8Os+HguOccNkkcTtFpx+eTJmy2edYDY=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1575371468; a=rsa-sha256; cv=none;
 b=f+cVYP8xyTSyHvDRkXV7KmEoKMCiBLhriTSs23X66rDqnTNTGm475ZiB2fvGhPTXVapq4a
 VIz0cD/6LV3PiCIuEqc1HSiO0EK3xIUrRiVRuWAISMFjstuTuZeyDzqWXE6gdjhaMvh40u
 QrLTqsldWDWV5RZo/jYufjcT8cTF9xg=
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



On 11/30/19 9:45 AM, Alex Benn=C3=A9e wrote:
> This is in preparation for further re-factoring of the register API
> with the rest of the code. Theoretically the read register function
> could overwrite the MAX_PACKET_LENGTH buffer although currently all
> registers are well within the size range.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  gdbstub.c | 62 ++++++++++++++++++++++++++++++++++---------------------
>  1 file changed, 38 insertions(+), 24 deletions(-)
>=20
> @@ -2003,7 +2015,7 @@ static void handle_query_curr_tid(GdbCmdContext *=
gdb_ctx, void *user_ctx)
>      cpu =3D get_first_cpu_in_process(process);
>      g_string_assign(gdbserver_state.str_buf, "QC");
>      gdb_append_thread_id(cpu, gdbserver_state.str_buf);
> -    put_strbuf();;
> +    put_strbuf();
Hi Alex,

The double ';' (and the two other occurrences below) is added by your
previous patch.

>  }
> =20
>  static void handle_query_threads(GdbCmdContext *gdb_ctx, void *user_ct=
x)
> @@ -2015,7 +2027,7 @@ static void handle_query_threads(GdbCmdContext *g=
db_ctx, void *user_ctx)
> =20
>      g_string_assign(gdbserver_state.str_buf, "m");
>      gdb_append_thread_id(gdbserver_state.query_cpu, gdbserver_state.st=
r_buf);
> -    put_strbuf();;
> +    put_strbuf();
>      gdbserver_state.query_cpu =3D gdb_next_attached_cpu(gdbserver_stat=
e.query_cpu);
>  }
> =20
> @@ -2058,7 +2070,7 @@ static void handle_query_thread_extra(GdbCmdConte=
xt *gdb_ctx, void *user_ctx)
>      }
>      trace_gdbstub_op_extra_info(rs->str);
>      memtohex(gdbserver_state.str_buf, (uint8_t *)rs->str, rs->len);
> -    put_strbuf();;
> +    put_strbuf();
>  }
>  =20

With the ";;" fix
Reviewed/Tested-by: Damien Hedde <damien.hedde@greensocs>

--
Damien

