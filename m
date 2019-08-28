Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3DBC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 13:39:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE00120828
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 13:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQO6PRVD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE00120828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2yB1-0002NU-27
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 09:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40348)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chmeeedalf@gmail.com>) id 1i2y9q-0001i1-1i
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 09:38:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chmeeedalf@gmail.com>) id 1i2y9p-0007DK-2q
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 09:38:41 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:39656)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chmeeedalf@gmail.com>)
 id 1i2y9o-0007Cy-Sd
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 09:38:41 -0400
Received: by mail-io1-xd43.google.com with SMTP id l7so5899216ioj.6
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 06:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=azcl882/GAyeOD6HVhSHzybbPZYHtCGBSzH49KriDQk=;
 b=bQO6PRVDUPppOerAeKfsPV2WtQ+BPxc9hvzTD91otx/8YWmu7x3PPaWuywiVmggNay
 RFPYRBo+j60PbRDK783Oqa2KuFAiqgsAyyYvMkjdw6/u5YJHx8vvkh3b2eubDp056dV+
 mYWIPHw75cF9FVmOAhsiHQdrruILwIWtJ/2Imw5+bGpsjp03QhLna8EdIDwrccfDehT/
 /rK2UDQxwPAncz2NeHs6zDlfsSmu53MxR6e2AfOhX4wg+CiwD0kATzyoTqz8Wp1XzC3M
 teGWYRZ7xqjx4CUkH7vm4yirYmasdP5c670A1lBZdVK9eNAFUNLJ1kDIbMm1ocGBu3GZ
 GvSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=azcl882/GAyeOD6HVhSHzybbPZYHtCGBSzH49KriDQk=;
 b=q5V0tPy37X0l5F23h6utHQIvIIYOM/6/+6/BfJIBTGMZXILMoMaBMP1BswPQd2kZB1
 rwtSxFKJiqJ5tOzqd5wF8RwUkQX+TbyApnNQrACPZPOp9t6mJ+YUMizbXQuzF5YGLjsb
 pXL70y1tgTKIPRAPdA6L1eFZzd++ZtmlIKeaJOMZ9faZUSyKW/hGoI5avT4zIIzNoHI4
 y5NkpOqxff4d/FB15aa/WMnBwtFJLv3oc946wgEabRmPow2BRbQUpyikkgowsuAkOvNu
 NmoWFXedGEm5/+lXVDEnEorUXhGZEVEjyJS2POrqLMyggsKEFuE5ztHE3WZ6DWIf0Ki6
 ws/A==
X-Gm-Message-State: APjAAAV57VJ15tAeHckvMa15+xoJcaI7WKjuXdaQ8nco0FhFqlIPmLqp
 FKZsM0z1eL1iP/Y2hkD7gWI=
X-Google-Smtp-Source: APXvYqyRzJaJFyjySzrXi2LT0OSs3S+3RAF77B3em9aF2mJiv2e+tgi08kixztphP9otAFQjvUxfig==
X-Received: by 2002:a05:6638:3af:: with SMTP id
 z15mr4376797jap.39.1566999519929; 
 Wed, 28 Aug 2019 06:38:39 -0700 (PDT)
Received: from ralga.knownspace (173-25-245-129.client.mchsi.com.
 [173.25.245.129])
 by smtp.gmail.com with ESMTPSA id q3sm2081013ios.70.2019.08.28.06.38.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 06:38:39 -0700 (PDT)
Date: Wed, 28 Aug 2019 08:38:34 -0500
From: Justin Hibbits <chmeeedalf@gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20190828083834.09e01232@ralga.knownspace>
In-Reply-To: <20190821082546.5252-1-laurent@vivier.eu>
References: <20190821082546.5252-1-laurent@vivier.eu>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; powerpc64-portbld-freebsd13.0)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
Subject: Re: [Qemu-devel] [PATCH 0/1] Fix cacheline detection on
 FreeBSD/powerpc
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 21 Aug 2019 10:25:45 +0200
Laurent Vivier <laurent@vivier.eu> wrote:

> This is the patch originally sent by Justin, modified
> to change the parameter size on FreeBSD only.
> 
> Justin, could you review and test on FreeBSD?
> Peter, could you run "make check" on your MacOS X host?
> 
> Thanks,
> Laurent
> 
> Justin Hibbits (1):
>   Fix cacheline detection on FreeBSD/powerpc.
> 
>  util/cacheinfo.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 

Hi Laurent,

I applied the patch against the FreeBSD emulators/qemu-devel (qemu
3.1.0) port, and it was successful.

All good on this end!

- Justin

