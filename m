Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25775C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 15:31:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7F7220881
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 15:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="saZrTluP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7F7220881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibnfn-0001F2-0C
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 10:31:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46153)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1ibnbD-0005zF-Ux
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 10:26:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1ibnbC-0001pB-Qt
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 10:26:55 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:58364)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1ibnbC-0001oV-Kv
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 10:26:54 -0500
Received: from [172.16.11.102] (crumble.bar.greensocs.com [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 6DFF996EF0;
 Mon,  2 Dec 2019 15:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1575300412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BsAO0TXNx3/Ne29sFkbPePTSRB3HY1L/JUQ7joKU74w=;
 b=saZrTluPqrp4xjct6a8MJe/haNrmVvFId2U7OvvIe002GsXMICnqrWvn95WYA8QPKTGAdL
 DMx9ZvkoWjbzvSkVWOoIxRbpg+tHSqyfLsvdOX1Q/jrsZMNfxaGmXOUr/r6oTkTrLnPYT3
 cqwp+/+CYa/FLW4WVNAp3yh5RbYEoUo=
Subject: Re: [PATCH v2 03/14] gdbstub: move str_buf to GDBState and use GString
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191130084602.10818-1-alex.bennee@linaro.org>
 <20191130084602.10818-4-alex.bennee@linaro.org>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <2950506f-5441-6924-9625-70c631366723@greensocs.com>
Date: Mon, 2 Dec 2019 16:26:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191130084602.10818-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1575300412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BsAO0TXNx3/Ne29sFkbPePTSRB3HY1L/JUQ7joKU74w=;
 b=aPwgX9sfF6L7mCYpy5pbjQXGAafsJn99DZhDWCrRwn0XmZYYhoZhQrYqqRuWB38AJf9lng
 o/suTwtSYqGTYP+KJl2Y3UdS7lu5z/0JSng8pU+2qhH+ZTbxgF9e2lWQHmIXIXqVGwKIo/
 J+rzMYRLQJb/eIoe9/CBL6TivREy6h0=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1575300412; a=rsa-sha256; cv=none;
 b=KjByxLCzu9lZ5BRj0C7li1oRJpAoKJ18SqMbi0R5iQz5S4OLL8myieez4WaoEStXzcHj7c
 peNXkCHDXB/qExs7DEmUYD/bpePWE4/PBf8Ft3G53in0JbWl9jnWvjoURl1YfLPEVR7+ks
 Nx9BdzeAqsqqgJOcKNfkoBESy8FA+zI=
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

Reviewed-by: Damien Hedde <damien.hedde@greensocs.com>

--
Damien

