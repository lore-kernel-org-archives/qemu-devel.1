Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1B1C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 19:21:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0865208E4
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 19:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SxToguuK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0865208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHu2c-0001FI-03
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 15:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kHu1m-0000js-7E
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 15:20:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59106)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kHu1g-0004sf-Ek
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 15:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600111230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8ppPxP+PwS1YG3Xlw4vV7QbAFY9TdDZZ6KdQVQY860I=;
 b=SxToguuKFWbV0Yw+H+sxctXlpyX6H5RoWrhbqdrAgyTLqhPZrUp7/FQPjPx3fUycOZBiww
 DszK2E1FZOAEiaU04INbb0o4Z2XhVrOqrXRiJh19al9YTYxFmlnhqdj/XCD2M0jM2ZvEHK
 0Nc0y87BWusi59GC50KNN7R7rnA2c7w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-576-HHoVJq72Psmj9QVUo4PMQA-1; Mon, 14 Sep 2020 15:20:25 -0400
X-MC-Unique: HHoVJq72Psmj9QVUo4PMQA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0F5818BA282;
 Mon, 14 Sep 2020 19:20:24 +0000 (UTC)
Received: from [10.3.113.68] (ovpn-113-68.phx2.redhat.com [10.3.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 51D267839F;
 Mon, 14 Sep 2020 19:20:21 +0000 (UTC)
Subject: Re: [PATCH 3/3] configure: automatically parse command line for meson
 -D options
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200913100534.22084-1-pbonzini@redhat.com>
 <20200913100534.22084-4-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <a4a800dc-1f7f-da5d-e7e5-ccbacc1f9bf3@redhat.com>
Date: Mon, 14 Sep 2020 14:20:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200913100534.22084-4-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 15:06:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: marcandre.lureau@redhat.com, berrange@redhat.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/13/20 5:05 AM, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   Makefile                                |   6 ++
>   configure                               |  71 +++++--------
>   docs/devel/build-system.rst             |  35 +------
>   meson-buildoptions.json                 | 130 ++++++++++++++++++++++++
>   scripts/configure-parse-buildoptions.py |  94 +++++++++++++++++
>   5 files changed, 258 insertions(+), 78 deletions(-)
>   create mode 100644 meson-buildoptions.json
>   create mode 100644 scripts/configure-parse-buildoptions.py
> 
> diff --git a/Makefile b/Makefile
> index d6c5c9fdef..b22e5b272e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -80,6 +80,12 @@ ifneq ($(MESON),)
>   Makefile.mtest: build.ninja scripts/mtest2make.py
>   	$(MESON) introspect --tests --benchmarks | $(PYTHON) scripts/mtest2make.py > $@
>   -include Makefile.mtest
> +
> +# jq is used to keep the result stable
> +meson-buildoptions.json: meson_options.txt
> +	$(MESON) introspect --buildoptions . | \
> +	    jq 'map(select(.section == "user")) | sort_by(.name)' \
> +	    > $(SRC_PATH)/meson-buildoptions.json

Are we guaranteed to have jq on the system?  This appears to be the 
first use of it in qemu.git.

> @@ -108,6 +78,11 @@ In meson.build::
>     # Summary
>     summary_info += {'SDL image support': sdl_image.found()}
>   
> +The configure script automatically converts command line options to
> +Meson options as long as the `meson-buildoptions.json` file in the
> +root source directory is up-to-date.  You can simply type
> +`make meson-buildoptions.json` to update it; the `jq` program
> +is needed.

Oh, you're using it for an optional step, that most people don't have to 
run, but where a developer needing to regenerate things can be likely to 
understand how to get it.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


