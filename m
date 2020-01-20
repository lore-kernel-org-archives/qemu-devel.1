Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED4EC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 13:01:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2886120678
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 13:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bX4XaQYD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2886120678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itWge-00043p-9F
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 08:01:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57201)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1itWfk-0003Uh-MD
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 08:00:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1itWfj-0003js-HA
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 08:00:52 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:41015)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1itWfh-0003hV-VD
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 08:00:50 -0500
Received: by mail-ot1-x342.google.com with SMTP id r27so28554216otc.8
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 05:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=enEzIYGOJ3Z9BcpMWQn0M59KHHmkVRX4jfdLkG5CuCk=;
 b=bX4XaQYDs43MyIIESYHeI8kkQ/pwbnQSNPMjHiF4P5Za1GD8YduN/DSGcEL0Hvge6Y
 8LRks6GSVgt4jnH9Jk6XfTZUmxKMbtRpDcmx2797dyffQ3lyUqijBsGYoswec3N1vAGP
 cta9GInwB8/jAyRdXCkddjf65qN0Rao9VrvIzF3z3P2ieA5yer6O4xG/So1Nz2eX6UnP
 5+x0GOGxCLwMWdOzpbrCIHTEGDYuiUfCr21KqVSESPxRMzHakzuAIXEbdLM5EP7DtfZG
 8kg5BACFwa5U/q1S+5RDuE1uv2G/foA/5D8mFA8aRfaxj8r5Ui1qOprvHQ5cNmAGJUQ7
 TW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=enEzIYGOJ3Z9BcpMWQn0M59KHHmkVRX4jfdLkG5CuCk=;
 b=Q2JYaqVucXnEqyNIk21BDYEB9sUL+WPcFqivv+uFecyc1Jlxx+XMKUY70K4ZP+vwtp
 Mi0bBc4oWAOi5lhg8cr6Ky5CsukJOT66xQ0WzSq8SBtriwZlxQqjNzNYnjXmKqq+Z1nJ
 7GmHsv8n7Kc3GRqy5MaGveHRMduTBptkm1rMaxORfpoDu6lOBPdnE4w5c88mQf+t3roK
 Jjl8EWzox6DySO2P5fWAFBaUsDqUjBx2dw5rmjmpuEETqIgBjZVbai6clOQodSkixisn
 q+3vIWfD4r99voDk4341ZMk/PB/U65xEj/yTv47kdJwpm5SLNooCndrHRhU2UcLMt/ei
 ebvA==
X-Gm-Message-State: APjAAAU/OXUK6xxK2zIJTqt4Jjqj61Utt1/u97E9GY/HVYR5Du1SI6iu
 X+zbM/QLlI1KNPpZvb/Y4NIhT7Y5hohW+7vDWD0GVQ==
X-Google-Smtp-Source: APXvYqxYrXh+bs0hosTD/hzmdQkN1G90/b647zIel/Jl7hKZbVY6pkzUQgTI+fIWHmnErEf5W84Du3nysbF+feMrkrE=
X-Received: by 2002:a05:6830:13da:: with SMTP id
 e26mr14993763otq.97.1579525248039; 
 Mon, 20 Jan 2020 05:00:48 -0800 (PST)
MIME-Version: 1.0
References: <20200114105918.2366370-1-clement.deschamps@greensocs.com>
 <03110090-dd50-b124-e60a-9cf136e8f7fd@redhat.com>
In-Reply-To: <03110090-dd50-b124-e60a-9cf136e8f7fd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Jan 2020 13:00:37 +0000
Message-ID: <CAFEAcA92pO3j+d8wS2PHhUKTjViLS3GbrmT4ocaDUYKFZLWgAg@mail.gmail.com>
Subject: Re: [PATCH] target/arm: add PMU feature to cortex-r5 and cortex-r5f
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Clement Deschamps <clement.deschamps@greensocs.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 14 Jan 2020 at 12:44, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> On 1/14/20 11:59 AM, Clement Deschamps wrote:
>
> Maybe describe here:
>
> The PMU is not optional on cortex-r5 and cortex-r5f (see
> the "Features" chapter of the Technical Reference Manual).
>
> > Signed-off-by: Clement Deschamps <clement.deschamps@greensocs.com>
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>



Applied to target-arm.next, thanks (with the suggested
improvement to the commit message).

-- PMM

