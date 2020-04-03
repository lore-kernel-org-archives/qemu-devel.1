Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46844C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 18:56:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EB7A206F5
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 18:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QhU2Hbq3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EB7A206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKRUd-0005D0-8D
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 14:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58133)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jKRTr-0004V8-C0
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 14:55:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jKRTq-0003yK-7l
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 14:55:51 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33911)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jKRTq-0003vW-1A
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 14:55:50 -0400
Received: by mail-wr1-x442.google.com with SMTP id 65so9778516wrl.1
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 11:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=YrZuv/fP4V8o8BXw8fOp44l+E8zVpeCMnhla5F9/jck=;
 b=QhU2Hbq3qxamAw6UA7T5K7IE2MzVywc0oDY3JY2F0wGACTrB1psxEKnPS8PH2+jNzD
 FjAlw4KQ1z2Rum5fDgRSrY9csniqxRAkmpMlRi+m6EiKy8IH8cF6uihDnKX1O6CFgj6k
 oKQt+UUDHis2CsWTdU3BaeUBu/4bUDseSJ4veXLcUFEbh1mdt90G6huNbs3r4/U11Xk3
 cJTdap05nFKf9i9CSVp82GFTkieX/Ox2YRXwlqL4fXxcGnvhjF0GRLua553MLRHE/Axq
 dJeqUzsHY+SsRxbKpwNcBpJrrWECvViVUGoUO2gWr79z06HggBCdaUc2ZzZqZQ9ypI4I
 3FtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=YrZuv/fP4V8o8BXw8fOp44l+E8zVpeCMnhla5F9/jck=;
 b=ixryS6AGdE4Z93gycnyTosrSh9saDF9NnCCnkD/osRDTzIL9WonbJQOMv1rrAsKCGN
 xgYngXMeRN4kxXrxqN0+DEdHIHE6KHnhxTvktXx4jC0htDxREfpaA1P1r5AjNcgGLgBc
 w74C2LLAwpnciiyOOAq18q+F8NfTJB+HN69/Qz7rAiDPqA0C1iQj0a1xLoytHBvm7J7+
 wBSdz8JVe7QaJ3pW+SXdghTZ7WZQnFXQQVPEzb7E5ygK7nEVwiR5UGPAkui6H2V5pnjq
 Nb0XK6oi0porVqoTyk0N4gMvaHXMxBEPIdI7SK+o0mq2eTbMXQy3cugHv/l4Lv/1PG2P
 qlcw==
X-Gm-Message-State: AGi0PuYR6UVofP1ycOQObNHKW+VwZRdFTc7TeBXU6triRE1dB61sd+jk
 KJFovXZjUcjo4k/UzoIwQxw6Tw==
X-Google-Smtp-Source: APiQypIfj0C5T289KgkFzhIEzjXzh1Xo10RJXfpHlAgMXg5rdpKgR+Z4vSkgnXbIuVscJiVJxbhKCA==
X-Received: by 2002:adf:cf09:: with SMTP id o9mr10169805wrj.74.1585940148324; 
 Fri, 03 Apr 2020 11:55:48 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g127sm12664072wmf.10.2020.04.03.11.55.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 11:55:47 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4CFF31FF7E;
 Fri,  3 Apr 2020 19:55:46 +0100 (BST)
References: <BL0PR2101MB1026AF0CA590021284C39D1BD60C0@BL0PR2101MB1026.namprd21.prod.outlook.com>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Henry <robhenry@microsoft.com>
Subject: Re: plugin interface function qemu_plugin_mem_size_shift
In-reply-to: <BL0PR2101MB1026AF0CA590021284C39D1BD60C0@BL0PR2101MB1026.namprd21.prod.outlook.com>
Date: Fri, 03 Apr 2020 19:55:46 +0100
Message-ID: <875zege6vh.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Henry <robhenry@microsoft.com> writes:

> I don't understand what
>   unsigned int qemu_plugin_mem_size_shift(qemu_plugin_meminfo_t info);
> does.   The documentation in qemu-plugin.h is silent on this matter.
>   It appears to expose more of the guts of qemu that I don't yet know.

It's the size as a power of 2, so:

0 =3D byte
1 =3D 16 bit
2 =3D 32 bit
3 =3D 64 bit
4 =3D 128 bit

and so on. Currently I think our largest memory accesses are around 256
bytes but we can go larger is required.

How about:

--8<---------------cut here---------------start------------->8---
plugins: document the meaning of size_shift

We describe memory accesses in powers of 2.

Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

1 file changed, 3 insertions(+)
include/qemu/qemu-plugin.h | 3 +++

modified   include/qemu/qemu-plugin.h
@@ -301,6 +301,9 @@ void *qemu_plugin_insn_haddr(const struct qemu_plugin_i=
nsn *insn);
  * The anonymous qemu_plugin_meminfo_t and qemu_plugin_hwaddr types
  * can be used in queries to QEMU to get more information about a
  * given memory access.
+ *
+ * The size_shift is the scale of access, e.g. << 3 is a 64 bit wide
+ * access.
  */
 typedef uint32_t qemu_plugin_meminfo_t;
 struct qemu_plugin_hwaddr;
--8<---------------cut here---------------end--------------->8---


--=20
Alex Benn=C3=A9e

