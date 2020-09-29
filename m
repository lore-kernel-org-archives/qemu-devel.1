Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F17EC4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 14:08:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0E5820848
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 14:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SIBjm7IW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0E5820848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNGIn-0004Gt-IL
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 10:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kNGGp-0002pW-1r
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 10:06:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57244)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kNGGm-0005Hq-H5
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 10:06:18 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601388375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KGcKtj7UWz1alFMLOs/DSs4EGZSl8wEXEZETp07bntY=;
 b=SIBjm7IWj7ZupI9RnUyqum1biiS3SUz+o4SuWNFTO5nOsnTpxRNGhC9/McM6CxIQR52vU4
 W/5AThspkeoZkr8IhdMmkUiBFTd8pi/psAsLw4v+lPXwHmFIjOb0TjpNzn7wrHItXHtMnK
 iQHwdqYwa8cHiOzEjR/sHXtyQGFtKaA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-McKyTkFCNNaF2udGMhfpcg-1; Tue, 29 Sep 2020 10:06:13 -0400
X-MC-Unique: McKyTkFCNNaF2udGMhfpcg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB14A18BA29C
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 14:06:12 +0000 (UTC)
Received: from [10.3.112.208] (ovpn-112-208.phx2.redhat.com [10.3.112.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3FD9E38A;
 Tue, 29 Sep 2020 14:06:09 +0000 (UTC)
Subject: Re: [PATCH] build-sys: fix git version from -version
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
References: <20200929134237.514286-1-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <cce22078-e0b8-fef9-ea62-a25767dfbbc5@redhat.com>
Date: Tue, 29 Sep 2020 09:06:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200929134237.514286-1-marcandre.lureau@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: pbonzini@redhat.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/29/20 8:42 AM, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Typo introduced with the script.
> 
> Fixes: 2c273f32d3 ("meson: generate qemu-version.h")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   scripts/qemu-version.sh | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/qemu-version.sh b/scripts/qemu-version.sh
> index 03128c56a2..430a7fc581 100755
> --- a/scripts/qemu-version.sh
> +++ b/scripts/qemu-version.sh
> @@ -9,7 +9,7 @@ version="$3"
>   if [ -z "$pkgversion" ]; then
>       cd "$dir"
>       if [ -e .git ]; then
> -        pkgversion=$(git describe --match 'v*' --dirty | echo "")

This always produces pkgversion="" (the git describe output is ignored 
when it is piped to echo).

> +        pkgversion=$(git describe --match 'v*' --dirty || echo "")

But this just looks weird. $(echo "") is the same as "".  The REAL goal 
here appears to be that you want 'set -e' to not die if git describe has 
a non-zero exit status.  But that's shorter to write as:

pkgversion=$(git describe --match 'v*' --dirty || :)

or even

pkgversion=$(git describe --match 'v*' --dirty) || :


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


