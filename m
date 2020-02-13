Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F25EC352A3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 19:03:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4289217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 19:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eaATycLw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4289217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Jln-0006bg-4U
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 14:03:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42163)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j2JkY-0005uy-Db
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 14:02:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j2JkW-0005Pl-04
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 14:02:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39428
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j2JkU-0005KA-1E
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 14:02:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581620522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YvKd1i2N/BGH2u+cZDYkgOMCT9Ss6TPjStZFWPH6RSY=;
 b=eaATycLwydEAe/GngoUDoYurMNHzFdLLZGnl7mFCxijwe1pwMBU5aJ/bQ1Pb+058XizLf+
 SgrKz7ZX6ICtCxfUyvdiXO7t9gMLdX4QfxZViiwctcmXp/c80o6nFZpQdeMx2ay5watjzj
 m3fRnMst3DMm3CnCUqfSWNDVmAXkuHY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-c0BOOcdsMAan6HQk0qCy0A-1; Thu, 13 Feb 2020 14:01:57 -0500
Received: by mail-wr1-f70.google.com with SMTP id m15so2722361wrs.22
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 11:01:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=f8DqhHzWDQAigeIdkhO4OEccJg4hJ3VLCoMSIVU+AfM=;
 b=NPbTWVDyH0qIFMqAjGCQZywiZoiH4Hu4FF6cSzD9mBfWhmdNIRjrFtyCllYEpke6/o
 tLQq14VhJJCHkQi9k9ofQEl/4AeK2dYGc/bCISfl1t7MBauwCFVOzmYrQaW8ZChGuWhU
 Cokn4spz6GZJrVL1rm7oaaglGj2DCAq+aspIpmApJfLqKB1GxsX0I7ExxO96inNvqYHk
 5V3gvdLOjtV/BNEmY+7EowrRiFTiTNU90h8CMmHxKTR5GfV/eR3Wc8WOkNvJ78/Qx2NY
 8gupLA6b56A8Go2xkRATBI4oWDxh824g36TwDiP1wjow/i9PAXSJCG7kWoBAL+QjWkSN
 uzzg==
X-Gm-Message-State: APjAAAWZzA1Zjd+CHZX9jjHT6DqkLYkXaZI5r/GVVkQInm74lRWQerLj
 QMHYXce6YPAjMRQh6Ep/73/YHd+ezTostkJGFFiai7q5CFR1FisQgmgjWq7FGUQlVzdpGfIgdqq
 vs8UqCi30s+vGONw=
X-Received: by 2002:a1c:4e03:: with SMTP id g3mr7180674wmh.22.1581620516488;
 Thu, 13 Feb 2020 11:01:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqwOnHV8J9jas0cI87McqnWmhNyyvli8h2nPzaqyo/4kMFmAc8BfssRqF3bboo3anCbS1n62Jw==
X-Received: by 2002:a1c:4e03:: with SMTP id g3mr7180654wmh.22.1581620516283;
 Thu, 13 Feb 2020 11:01:56 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id l6sm3995183wrn.26.2020.02.13.11.01.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2020 11:01:55 -0800 (PST)
Subject: Re: [PATCH v2 20/30] qapi/machine.json: Escape a literal '*' in doc
 comment
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200213175647.17628-1-peter.maydell@linaro.org>
 <20200213175647.17628-21-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d44cc0a3-cda8-df63-7ea6-45515400c8ce@redhat.com>
Date: Thu, 13 Feb 2020 20:01:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200213175647.17628-21-peter.maydell@linaro.org>
Content-Language: en-US
X-MC-Unique: c0BOOcdsMAan6HQk0qCy0A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/13/20 6:56 PM, Peter Maydell wrote:
> For rST, '*' is a kind of inline markup (for emphasis), so
> "*-softmmu" is a syntax error because of the missing closing '*'.
> Escape the '*' with a '\'.
>=20
> The texinfo document generator will leave the '\' in the
> output, which is not ideal, but that generator is going to
> go away in a subsequent commit.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   qapi/machine.json | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 6c11e3cf3a4..58580602524 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -12,7 +12,7 @@
>   #
>   # The comprehensive enumeration of QEMU system emulation ("softmmu")
>   # targets. Run "./configure --help" in the project root directory, and
> -# look for the *-softmmu targets near the "--target-list" option. The
> +# look for the \*-softmmu targets near the "--target-list" option. The
>   # individual target constants are not documented here, for the time
>   # being.
>   #
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


