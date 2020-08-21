Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141F2C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:18:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFBDD20732
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F/RHB6su"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFBDD20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k948I-0004xb-5E
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 06:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k947X-0003yL-Ni
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:18:03 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40751
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k947W-0000pp-2S
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598005081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P9GqXSEvgE0z1JOq223lc+cT9thQLUTznRXVkGoP1LY=;
 b=F/RHB6sulez16Ny++Jo4N42K67/PyDU2nn0wZW4lX0+4jmzV0sMi5KRx5xeTmaZWNswH1M
 cPDUaZxEAZ4xD75QT3uliM2RJ06qqcnSfIgkELG9Y3gZqJt4LwH9VvO1mb0bLGj7g+UV9W
 OOHuBmqb8YoZMUqHM1QR5izxAnZv4JU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-gjli30cANsiybDYGHOnlOA-1; Fri, 21 Aug 2020 06:17:57 -0400
X-MC-Unique: gjli30cANsiybDYGHOnlOA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E532425D5;
 Fri, 21 Aug 2020 10:17:56 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-251.ams2.redhat.com [10.36.113.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3692B10098AE;
 Fri, 21 Aug 2020 10:17:55 +0000 (UTC)
Date: Fri, 21 Aug 2020 12:17:53 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v2] configure: add support for pseudo-"in source tree"
 builds
Message-ID: <20200821101753.GC5153@linux.fritz.box>
References: <20200820173124.243984-1-berrange@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200820173124.243984-1-berrange@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 01:00:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 20.08.2020 um 19:31 hat Daniel P. Berrangé geschrieben:
> Meson requires the build dir to be separate from the source tree. Many
> people are used to just running "./configure && make" though and the
> meson conversion breaks that.
> 
> This introduces some backcompat support to make it appear as if an
> "in source tree" build is being done, but with the the results in the
> "build/" directory. This allows "./configure && make" to work as it
> did historically, albeit with the output binaries staying under build/.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
> 
> This is a simple integration of Eric's proposal from
> 
>   https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg07290.html
> 
> with a bit of configure magic. It is enough to enable
> 
>    ./configure
>    make
>    make check
> 
> I've not tested it beyond that. Note it blows away the "build/"
> dir each time ./configure is run so it is pristine each time.

I guess "make install" is the only other one that normal users would
care about. We shoud make sure that it works (I don't see why it
wouldn't, but worth testing anyway).

Kevin


