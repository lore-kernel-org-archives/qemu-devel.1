Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F9CC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 07:22:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DCDF20704
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 07:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YrvWjs7m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DCDF20704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdTut-0002cx-IR
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 03:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jdTuG-0002D0-O5
 for qemu-devel@nongnu.org; Tue, 26 May 2020 03:21:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23656
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jdTuE-0004bV-E7
 for qemu-devel@nongnu.org; Tue, 26 May 2020 03:21:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590477704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=atrtuygmT7CWBFOfnRpbZkuZbeGFfmbfPg44QBTQyPo=;
 b=YrvWjs7mKSW8k/7CRbjbpvdkQbl9BJHxEO0gk8TNhKv5u5PtyXhcZ9EulBPNQDVoEri44v
 7p+8D+rqatS/mN4+VSMqmuVwqiuSYRyhE62Bq/eElbvasrW8Gkl7NaCvsjbQx7L7nbLaFM
 tThjf2sw4wD6qkq84s5+BtcWuxIRS+4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-mvzYJ_9kMFOtOB2lcBvwaQ-1; Tue, 26 May 2020 03:21:43 -0400
X-MC-Unique: mvzYJ_9kMFOtOB2lcBvwaQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F9A3800688;
 Tue, 26 May 2020 07:21:42 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-138.ams2.redhat.com [10.36.112.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D475A19D7C;
 Tue, 26 May 2020 07:21:40 +0000 (UTC)
Subject: Re: [PATCH 1/1] util/getauxval: Porting to FreeBSD getauxval feature
To: David CARLIER <devnexen@gmail.com>, qemu-devel@nongnu.org,
 armbru@redhat.com
References: <CA+XhMqyZ9yZjckTcYinCOYqb4ybE6z9vmgcJzue1WEGuZ0NTWA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <4e0f6d35-8aa0-b81d-0902-00b76f44b571@redhat.com>
Date: Tue, 26 May 2020 09:21:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CA+XhMqyZ9yZjckTcYinCOYqb4ybE6z9vmgcJzue1WEGuZ0NTWA@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:19:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/05/2020 14.09, David CARLIER wrote:
> Hi here porting qemu_getauxval to FreeBSD. Thanks. Regards.
> 
> From 5be5e56a59631b28ed7b738d251dda252ba9b03e Mon Sep 17 00:00:00 2001
> From: David Carlier <devnexen@gmail.com>
> Date: Sun, 24 May 2020 13:03:32 +0100
> Subject: [PATCH] util/getauxval: FreeBSD has a similar auxilary vector API
> 
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  configure        | 6 ++++++
>  util/getauxval.c | 6 ++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/configure b/configure
> index 2fc05c4465..545fd2364f 100755
> --- a/configure
> +++ b/configure
> @@ -5824,7 +5824,13 @@ getauxval=no
>  cat > $TMPC << EOF
>  #include <sys/auxv.h>
>  int main(void) {
> +#if defined(__linux__)
>    return getauxval(AT_HWCAP) == 0;
> +#elif defined(__FreeBSD__)
> +  unsigned long a = 0;
> +  return elf_aux_info(AT_HWCAP, &a, sizeof(a)) == 0;
> +#endif
> +  return 1;
>  }
>  EOF
>  if compile_prog "" "" ; then

That configure check looks wrong. On other systems (i.e. non-Linux and
non-FreeBSD), this code snippet will now compile successfully and thus
the configure script sets getauxval=yes. I'd suggest you change it this
way instead:

 int main(void) {
+#if defined(__FreeBSD__)
+  unsigned long a = 0;
+  return elf_aux_info(AT_HWCAP, &a, sizeof(a)) == 0;
+#else
   return getauxval(AT_HWCAP) == 0;
+#endif
 }

... so that it still fails to compile by default on other systems.

 Thomas


