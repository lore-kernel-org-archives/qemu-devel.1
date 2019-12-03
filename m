Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595F9C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 13:00:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D78F8206EC
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 13:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="krah/Xu6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D78F8206EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic7nD-0005Mk-IO
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 08:00:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55231)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1ic7cO-0002kq-KG
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 07:49:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1ic7cH-0002AU-4Y
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 07:49:23 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:37202)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1ic7cG-0001vI-JR
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 07:49:21 -0500
Received: from [172.16.11.102] (crumble.bar.greensocs.com [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 7428E96EF0;
 Tue,  3 Dec 2019 12:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1575377355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UBHLWsT+vMJzyBlNb3W9ZOJBhe0pXctBZ7mjHo7XfHo=;
 b=krah/Xu68DxnN2Vd13vb8cV9dG6mCP0nu2w0rB/zqxRskYzdi1Gdlqw7O4pTdAOtK14Chk
 q1DkHsr1tpO2XlAHQLvGsbo5cmabq6aFSyPVh0DikMhmm1ABhFKVHlYDFBS6DR1CCjWLAP
 EgsA414iN6hzV2lGtkzZOEx+CpDczso=
Subject: Re: [PATCH v2 03/14] gdbstub: move str_buf to GDBState and use GString
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191130084602.10818-1-alex.bennee@linaro.org>
 <20191130084602.10818-4-alex.bennee@linaro.org>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <9cff21f7-607a-6244-197c-b87da96762b8@greensocs.com>
Date: Tue, 3 Dec 2019 13:49:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191130084602.10818-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1575377355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UBHLWsT+vMJzyBlNb3W9ZOJBhe0pXctBZ7mjHo7XfHo=;
 b=sTMkcpAPBYZYwVtTVC0s88lbvPaC+Oxt4xIvoH/J/eTJpzU1iYJkdDv1rLQeUVhoHx8UvT
 iPN9yGk501eqv9JbglpDoDPdP9OvbW5DQ7bijzpdfT1DtE00q3XdP1xim/SI92h2MzGc/f
 R5S7sQ7xMDVYYzZq+/DAcUYggciYsNE=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1575377355; a=rsa-sha256; cv=none;
 b=2pyq6XtXTcNv6fav8MMjgN3p6Ul0m58ms7yNqsqUtDpVijbesWdb7FqAFsT0zWSYS09DA9
 SwO3PwAV2PdyJhxqUcmirT1ZvOpWDSAHZAfz9ionhY5psFYS9LV6KPsjmFDYCd4EctadXW
 FjVfy4ZDt4IwJRU8R/1rD3NvZO/sT4U=
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
> Rather than having a static buffer replace str_buf with a GString
> which we know can grow on demand. Convert the internal functions to
> take a GString instead of a char * and length.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>=20
> ---
> v2
>   - fix conflict from status gdbserver_state
>   - add put_strbuf helper
> ---
>  gdbstub.c | 195 +++++++++++++++++++++++++-----------------------------
>  1 file changed, 90 insertions(+), 105 deletions(-)
>=20
> @@ -667,25 +667,28 @@ static int put_packet(const char *buf)

Hi,

I did some tests with my target having lot of registers and was
wondering if we should add an assert there (or even better in
put_packet_binary()). Something like:
       /* FIXME: until bigger packets are supported */
       g_assert(strlen(buf) <=3D MAX_PACKET_LENGTH);

There is a memcpy() in put_packet_binary() that overflows
in that case. With this patch, read_all_registers() can for example
generate binary packet up to 2*MAX_PACKET_LENGTH.

>      return put_packet_binary(buf, strlen(buf), false);
>  }

Apart from this case which don't happen with in-tree targets, it works
fine. So,
Tested-by: Damien Hedde <damien.hedde@greensocs.com>

I'll work on the missing bits for bigger packet support I soon as I have
some spare time.

Regards,
--
Damien

