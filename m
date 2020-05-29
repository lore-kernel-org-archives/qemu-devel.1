Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428A0C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 14:08:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AE6920707
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 14:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hIPO2d4b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE6920707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jefgN-0000sD-3G
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 10:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jefQC-0005o5-JN
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:51:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43657
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jefQB-0002D2-Oa
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:51:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590760298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tGRSF0sCDzwdpkBhh6dhUaSDL4CKpkPURN7TemKY/k0=;
 b=hIPO2d4bzyucWPIWHyn/UcqGD43X7Noww3V7wqtgBw9AK+FGCKvKF71EtQpAHbnp6khiLF
 v+jEnfaeetmhiQTnYHJ/jbOXGzk7AW2pBQ8ilQqCIEIqzvnmYodPO/edDFGs1XtdCYlIEJ
 KeX6GgdpJHo/ggSeQto1jNTKtvN7hf4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-xHh2RGgpO3-k9ectKDmIXg-1; Fri, 29 May 2020 09:51:24 -0400
X-MC-Unique: xHh2RGgpO3-k9ectKDmIXg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E478118FF660;
 Fri, 29 May 2020 13:51:22 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2500C7A8C9;
 Fri, 29 May 2020 13:51:19 +0000 (UTC)
Subject: Re: [PATCH v1 01/12] configure: add --enable-tsan flag + fiber
 annotations for coroutine-ucontext
To: Robert Foley <robert.foley@linaro.org>, qemu-devel@nongnu.org
References: <20200529132341.755-1-robert.foley@linaro.org>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <ee86aad8-5a22-5d5d-54f2-f0cb15c7a8b5@redhat.com>
Date: Fri, 29 May 2020 08:51:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200529132341.755-1-robert.foley@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 23:43:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, cota@braap.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Lingfeng Yang <lfy@google.com>,
 peter.puhov@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/29/20 8:23 AM, Robert Foley wrote:
> From: Lingfeng Yang <lfy@google.com>
> 
> We tried running QEMU under tsan in 2016, but tsan's lack of support for
> longjmp-based fibers was a blocker:
>    https://groups.google.com/forum/#!topic/thread-sanitizer/se0YuzfWazw

[meta-comment]

This message lacked References: and In-Reply-To: headers, making it the 
start of a new thread for patches 1-11.  But I also see you sent a 0/12 
message with Message-Id: <20200529132143.702-1-robert.foley@linaro.org>, 
as well as an unthreaded 12/12 with Message-Id: 
<20200529132438.837-1-robert.foley@linaro.org>.  You may want to figure 
out why your sending workflow is not preserving desired threading.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


