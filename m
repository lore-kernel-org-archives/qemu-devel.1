Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48952C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:28:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C00C520709
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VWZiVMYW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C00C520709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHnam-0001SF-Qn
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 08:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kHnZW-000071-BC
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:27:02 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48639
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kHnZT-0007m5-4S
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:27:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600086418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iucBFllIdbVQAaXJm9ty7DHJerNaXWF863wTtPe1a9Q=;
 b=VWZiVMYWe9jOpWRz+EEMuNcxEljlx8ejNKY9IHVzT1xAbdK6xBjl07lGy3pl9xVNMMLrQ0
 ikNoxjJeeKidkUYeE8lpVlPg+YmhI6cNk+/PN371BFbHjXgRw5pmzqXHjthGYUQghjgGEC
 ewZ3H6Lq3+y/8CJq345+yUpB2aGTPw8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-YJtmjeZPNRmq55hHQoa7kQ-1; Mon, 14 Sep 2020 08:26:55 -0400
X-MC-Unique: YJtmjeZPNRmq55hHQoa7kQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76D3DE9020;
 Mon, 14 Sep 2020 12:26:49 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-134.ams2.redhat.com [10.36.112.134])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 684477E404;
 Mon, 14 Sep 2020 12:26:48 +0000 (UTC)
Subject: Re: [PATCH] iotests: Work around failing readlink -f
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200914113809.63640-1-mreitz@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <abaa48c8-c947-4a50-6342-a094b7d0f532@redhat.com>
Date: Mon, 14 Sep 2020 14:26:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200914113809.63640-1-mreitz@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 00:11:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/09/2020 13.38, Max Reitz wrote:
> On macOS, (out of the box) readlink does not have -f.  If the recent
> "readlink -f" call introduced by b1cbc33a397 fails, just fall back to
> the old behavior (which means you can run the iotests only from the
> build tree, but that worked fine for six years, so it should be fine
> still).
> 
> Keep any potential error message on stderr.  If users want to run the
> iotests from outside the build tree, this may point them to what's wrong
> (with their system).
> 
> Fixes: b1cbc33a3971b6bb005d5ac3569feae35a71de0f
>        ("iotests: Allow running from different directory")
> Reported-by: Claudio Fontana <cfontana@suse.de>
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
> Hi Thomas,
> 
> I thought this would be quicker than writing a witty response on whether
> you or me should write this patch. O:)
> ---
>  tests/qemu-iotests/check | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> index e14a1f354d..75675e1a18 100755
> --- a/tests/qemu-iotests/check
> +++ b/tests/qemu-iotests/check
> @@ -45,6 +45,10 @@ then
>      fi
>      source_iotests=$(cd "$source_iotests"; pwd) || _init_error "failed to enter source tree"
>      build_iotests=$(readlink -f $(dirname "$0"))
> +    if [ "$?" -ne 0 ]; then
> +        # Perhaps -f is unsupported, revert to pre-b1cbc33a397 behavior
> +        build_iotests=$PWD
> +    fi
>  else
>      # called from the source tree
>      source_iotests=$PWD

Thanks, the macOS build seems to work again:

 https://cirrus-ci.com/task/5431828267925504?command=main#L7033

Tested-by: Thomas Huth <thuth@redhat.com>


