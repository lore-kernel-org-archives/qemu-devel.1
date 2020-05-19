Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701B1C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 22:46:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31720205CB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 22:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MfMo15Z9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31720205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbAzt-0005Vy-7N
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 18:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jbAz2-0004vl-DF
 for qemu-devel@nongnu.org; Tue, 19 May 2020 18:45:12 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44492
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jbAz0-00062L-UW
 for qemu-devel@nongnu.org; Tue, 19 May 2020 18:45:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589928309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IOriqA6KVgFYxvSS+/HyvwUFKy+98EVHn5U4pIhTqVg=;
 b=MfMo15Z9HHfqqzb0h3hoTD00xrlAVDgKVdx9SjXo+h8vYyLd7JAkYMA5N+KxzIl/0c86qI
 1pa4gP0H/EwAWighsScNwf1osBn8TKEO4EeomcJVAIAW4yusT1SfbCBQRWmAdnxZg0iDXd
 OW9KooQXKxofd8OhYj8TqvwYWSLXI7s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-7Kk12hmzOo-lPc3kg0QeOw-1; Tue, 19 May 2020 18:45:07 -0400
X-MC-Unique: 7Kk12hmzOo-lPc3kg0QeOw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9328835B41
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 22:45:06 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-114-149.ams2.redhat.com
 [10.36.114.149])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 174595C1BB;
 Tue, 19 May 2020 22:45:01 +0000 (UTC)
Subject: Re: [RFC PATCH v6 3/5] softmmu/vl: Allow -fw_cfg 'blob_id' option to
 set any file pathname
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200519182024.14638-1-philmd@redhat.com>
 <20200519182024.14638-4-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <3225db1c-1dcb-8bec-18a5-0ea7fe890508@redhat.com>
Date: Wed, 20 May 2020 00:45:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200519182024.14638-4-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 23:19:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/19/20 20:20, Philippe Mathieu-Daudé wrote:
> This is to silent:
> 
>   $ qemu-system-x86_64 \
>     -object tls-cipher-suites,id=ciphersuite0,priority=@SYSTEM \
>     -fw_cfg name=etc/edk2/https/ciphers,blob_id=ciphersuite0
>   qemu-system-x86_64: -fw_cfg name=etc/edk2/https/ciphers,blob_id=ciphersuite0: warning: externally provided fw_cfg item names should be prefixed with "opt/"
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  softmmu/vl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index f76c53ad2e..3b77dcc00d 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -2052,7 +2052,7 @@ static int parse_fw_cfg(void *opaque, QemuOpts *opts, Error **errp)
>                     FW_CFG_MAX_FILE_PATH - 1);
>          return -1;
>      }
> -    if (strncmp(name, "opt/", 4) != 0) {
> +    if (!nonempty_str(blob_id) && strncmp(name, "opt/", 4) != 0) {
>          warn_report("externally provided fw_cfg item names "
>                      "should be prefixed with \"opt/\"");
>      }
> 

Hmmm, difficult question! Is "ciphersuite0" now externally provided or not?

Because, ciphersuite0 is populated internally to QEMU alright (and so we
can think it's internal), but its *association with the name* is external.

What if we keep the same "-object" switch, but use a different (bogus)
"name" with "-fw_cfg"? IMO that kind of invalidates "-object" too.

Should the fw_cfg generator interface dictate the fw_cfg filename too?
Because that would eliminate this problem. Put differently, we now have
a possibility to label the "ciphersuite0" object in the fw_cfg file
directory any way we want -- but is that freedom *useful* for anything?

I guess we might want multiple "tls-cipher-suites" objects one day, so
hard-coding the fw_cfg names on that level could cause conflicts. On the
other hand, I wouldn't like "blob_id" to generally circumvent the "etc/"
namespace protection.

I'm leaning towards agreeing with this patch, but I'd appreciate some
convincing arguments.

Thanks
Laszlo


