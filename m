Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE04C43215
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 14:38:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59B9720833
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 14:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="Zhd6LOvt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59B9720833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibmqT-0002Cp-DL
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 09:38:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39127)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1ibmn8-0008Hp-Dg
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 09:35:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1ibmn7-0008Db-3J
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 09:35:09 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:56748)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1ibmn6-0008D5-Kd
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 09:35:09 -0500
Received: from [172.16.11.102] (crumble.bar.greensocs.com [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPSA id F3D6D96EF0;
 Mon,  2 Dec 2019 14:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1575297306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1sRT7+oVu3fi0DBceWyBHEfzyWKgU+hh2CjY/eZiGlU=;
 b=Zhd6LOvteMEVQVKxnrWfVCeZVn01iWCBTfEJdZn1jI7OkGKqCb9fsGkwL5bK/IRbWbmscv
 Sf1syJJRd7ZHeaKa/cn2PG4xpHc95E9MN3W6i5EGJIz74UZc5zKL4e252UWk56WhFzA/cr
 39NnfXZsn4EN63qKfpn5ZdlOIA4qmWk=
Subject: Re: [PATCH v2 01/14] gdbstub: make GDBState static and have common
 init function
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191130084602.10818-1-alex.bennee@linaro.org>
 <20191130084602.10818-2-alex.bennee@linaro.org>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <dcb45c47-9a0c-748f-3b2f-4b0ab2f93524@greensocs.com>
Date: Mon, 2 Dec 2019 15:35:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191130084602.10818-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1575297306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1sRT7+oVu3fi0DBceWyBHEfzyWKgU+hh2CjY/eZiGlU=;
 b=tpex+VOPasz/BfApDvIBgsmerVTA2BnSYqC72Y0R5lxMGp+Dr1gSq+u/57wzavB4YjjwIn
 2OLcUW3C/F8P+dJB62i0OxmQ8N+DZrgoK8LcFqngEJ5MhhDB89ONNkmtm5r23KwhjbL2tq
 AzKtr1WyN2TPdfVjm5BBI9eSch1Rebg=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1575297306; a=rsa-sha256; cv=none;
 b=SLuf8Pch7owRRFHvo1S9vLkV5HPaEumYNHgMVw7c5PePaVegR9zHGl/y4zfnFr16Wl4ZYr
 GqFDAckBTuBzIEwxw1/HXvQPaWeMmPpdW4UZNV2aogw7iQ2T0UXXnhCkHL0D+38rIVdVCR
 T3nfVJ2Gsb1psz4ahiSlPAaPE/kRyVg=
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
> Instead of allocating make this entirely static. We shall reduce the
> size of the structure in later commits and dynamically allocate parts
> of it. We introduce an init and reset helper function to keep all the
> manipulation in one place.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Damien Hedde <damien.hedde@greensocs.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
>=20
> ---
> v2
>   - made entirely static, dropped dh/rth r-b tags due to changes

Modulo Richard's remark about unnecessary memset,
Reviewed-by: Damien Hedde <damien.hedde@greensocs.com>


