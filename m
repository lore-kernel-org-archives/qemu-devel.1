Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E9CC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 09:48:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BAF22223C
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 09:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hMuSigQ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BAF22223C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUoG2-0005XH-0o
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 05:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kUoDB-00049H-Vh
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 05:45:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51519)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kUoD9-00018H-V8
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 05:45:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603187143;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SMnjcSR/hVtsmjw8DGks+e23jmxxDvTi8RZk6dDtMLA=;
 b=hMuSigQ9eJv8cfHX8klYb5sATOtL36LJ+pWo4GrSkhYNk9xpXywYelSKf3P5lhm+gZ9cE3
 VX6w3oAyJn5vJB9eVC6ECSEOcqCVrp/01fi3+Uid9XmmDkshqnIyXqIqNv50lArgJKM+UB
 fWbICX9eykIG0QG9pj5m73m+QtuCRwE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-qwLFi-bZMOuVaC5yb3ZaSQ-1; Tue, 20 Oct 2020 05:45:41 -0400
X-MC-Unique: qwLFi-bZMOuVaC5yb3ZaSQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F62318A0760
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 09:45:40 +0000 (UTC)
Received: from redhat.com (ovpn-114-206.ams2.redhat.com [10.36.114.206])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F3EBB5D9D2;
 Tue, 20 Oct 2020 09:45:35 +0000 (UTC)
Date: Tue, 20 Oct 2020 10:45:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] scripts/tracetool: silence SystemTap dtrace(1) long long
 warnings
Message-ID: <20201020094533.GG287149@redhat.com>
References: <20201020094043.159935-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201020094043.159935-1-stefanha@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 20, 2020 at 10:40:43AM +0100, Stefan Hajnoczi wrote:
> SystemTap's dtrace(1) prints the following warning when it encounters
> long long arguments:
> 
>   Warning: /usr/bin/dtrace:trace/trace-dtrace-hw_virtio.dtrace:76: syntax error near:
>   probe vhost_vdpa_dev_start
> 
>   Warning: Proceeding as if --no-pyparsing was given.
> 
> Use the uint64_t and int64_t types, respectively. This works with all
> host CPU 32- and 64-bit data models (ILP32, LP64, and LLP64) that QEMU
> supports.
> 
> Reported-by: Markus Armbruster <armbru@redhat.com>
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  scripts/tracetool/format/d.py | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/scripts/tracetool/format/d.py b/scripts/tracetool/format/d.py
> index 353722f89c..ebfb714200 100644
> --- a/scripts/tracetool/format/d.py
> +++ b/scripts/tracetool/format/d.py
> @@ -57,6 +57,12 @@ def generate(events, backend, group):
>                  # Avoid it by changing probe type to signed char * beforehand.
>                  if type_ == 'int8_t *':
>                      type_ = 'signed char *'
> +
> +            # SystemTap dtrace(1) emits a warning when long long is used
> +            type_ = type_.replace('unsigned long long', 'uint64_t')
> +            type_ = type_.replace('signed long long', 'int64_t')
> +            type_ = type_.replace('long long', 'int64_t')
> +
>              if name in RESERVED_WORDS:
>                  name += '_'
>              args.append(type_ + ' ' + name)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


