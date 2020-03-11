Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAD7C10F25
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:07:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28E5E208C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i+8DkJg1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28E5E208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBuWh-0007vA-9t
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 02:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46523)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jBuVv-000707-6o
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:06:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jBuVu-0007OY-6d
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:06:43 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:37996)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jBuVt-0007Le-Vg
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:06:42 -0400
Received: by mail-pf1-x443.google.com with SMTP id z5so690618pfn.5
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 23:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=okAzjBLzfCAaoaDQmsHa0if6HEYySgyRwmd3/BbTFEg=;
 b=i+8DkJg1/4wLZVZ6sx4I8R5Rc8+vL0T0PUyjEgDc/bhZX77dPPYnQKTLOoiqYitsDQ
 m5TInRdugdq7nk8LQ8bFYpE0CCoypT7bc1OP+CZwSVpWxVX0qI++tByCkgFZQgwevxWj
 pTsorf5ZRQmh8zD86KKRmyBXlbM4L2mggiv7V0+d3FNliWsI0jEopXT7cjIIAxw6uDp7
 SOYKo4zKz1TD+nD7a6nCXXr/XpxLm9zKpxaUZKPVe4odfSWIy2Jh/diBhFejc6fpt97y
 er7b26PH38xVlQoXUHXxxty0Jn7U16gSGMHld5cbD/IlIAzOs6z8qU32ACEqsH5x4yqd
 YmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=okAzjBLzfCAaoaDQmsHa0if6HEYySgyRwmd3/BbTFEg=;
 b=WYnwigRqPb4MvNra1fAvMmOGVikBms/+r1+BQtwXX+STFwNuXFYpsJf7VlJzZldqgb
 C3HWIbl4JMkgfl2gfp5t7eQaWVI83JhX/o0eHlONx6edJxVwU+pZsDW1icTEiklKlpXS
 zjsyhnpdXyQE5JrzmuH6xKkqVGXKfUvUq5Vi3ke2G6Pw3EcMiew6f6lTB0NZs1K7owEm
 Y9Cxo7Bu5tQD55pn+QE2+SdSeUDauYFLOQZaprsn29moue8x5Sef0nN3k3Bvs275zyTQ
 PY0p9+tUBpQI+JkbDDDEuw9QbrYbLQ9SCbGfIQOd+SCrOkugD2q2syTeR9nhJam+k5vi
 VHzQ==
X-Gm-Message-State: ANhLgQ2B65m4UAU35aCutIEC4E2hDp9gAL5HQGwGShrIDuJA+NPoBE2o
 9QfiJciyjZGWdUOL2YYNRChfqw==
X-Google-Smtp-Source: ADFU+vtZYxPkKqcl5OOY6Jp0w1D+Lbc0G7bteFO84Nmp2NwzR05nvDBjhCzR/6aQck6zmmyzVLsKzw==
X-Received: by 2002:a63:ce05:: with SMTP id y5mr1285592pgf.155.1583906800984; 
 Tue, 10 Mar 2020 23:06:40 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 p9sm4097705pjo.28.2020.03.10.23.06.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2020 23:06:40 -0700 (PDT)
Subject: Re: [PATCH v4 02/18] qapi/qapi-schema.json: Put headers in their own
 doc-comment blocks
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200309154405.13548-1-peter.maydell@linaro.org>
 <20200309154405.13548-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <811e7f66-96bf-81ab-5139-d1fdd72f549d@linaro.org>
Date: Tue, 10 Mar 2020 23:06:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200309154405.13548-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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

On 3/9/20 8:43 AM, Peter Maydell wrote:
> Our current QAPI doc-comment markup allows section headers
> (introduced with a leading '=' or '==') anywhere in any documentation
> comment.  This works for texinfo because the texi generator simply
> prints a texinfo heading directive at that point in the output
> stream.  For rST generation, since we're assembling a tree of
> docutils nodes, this is awkward because a new section implies
> starting a new section node at the top level of the tree and
> generating text into there.
> 
> New section headings in the middle of the documentation of a command
> or event would be pretty nonsensical, and in fact we only ever output
> new headings using 'freeform' doc comment blocks whose only content
> is the single line of the heading, with two exceptions, which are in
> the introductory freeform-doc-block at the top of
> qapi/qapi-schema.json.
> 
> Split that doc-comment up so that the heading lines are in their own
> doc-comment.  This will allow us to tighten the specification to
> insist that heading lines are always standalone, rather than
> requiring the rST document generator to look at every line in a doc
> comment block and handle headings in odd places.
> 
> This change makes no difference to the generated texi.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  qapi/qapi-schema.json | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

