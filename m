Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BADC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 10:11:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A12A2074D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 10:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h1xicvkk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A12A2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jebyl-00088Z-Io
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 06:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jebxx-0006pl-CE
 for qemu-devel@nongnu.org; Fri, 29 May 2020 06:10:17 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26873
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jebxw-00029m-Ak
 for qemu-devel@nongnu.org; Fri, 29 May 2020 06:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590747015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CaeojVsBWiIqjQORqwThWY6fz2VvVR39cgTT44Vmiu4=;
 b=h1xicvkk4239Os6Zr9o7BeRMh93NE2OCQe8S/Cieb/pjfl/4scjlqB4zVYhm6U1xMDTrAj
 JIQwKb9vAgbNUhq1l93qzqn+Fnmc5n31/Uo1GMSy4LItR/QgjrSCfqIC/633/9/JRk/OXX
 xTMI/aonlZM569hx6oJ2bC3uulyNjWY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-_-UmC0UNN_-xI1DxGNWYOw-1; Fri, 29 May 2020 06:10:13 -0400
X-MC-Unique: _-UmC0UNN_-xI1DxGNWYOw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72B681855A08
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 10:10:12 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-112-152.ams2.redhat.com
 [10.36.112.152])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3F3E11002389;
 Fri, 29 May 2020 10:10:08 +0000 (UTC)
Subject: Re: [RFC PATCH v7 3/5] softmmu/vl: Allow -fw_cfg 'gen_id' option to
 use the 'etc/' namespace
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200528173141.17495-1-philmd@redhat.com>
 <20200528173141.17495-4-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <60cf5894-4d3b-9ab7-f6da-d3556217fdeb@redhat.com>
Date: Fri, 29 May 2020 12:10:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200528173141.17495-4-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 03:05:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/28/20 19:31, Philippe Mathieu-Daudé wrote:
> User-generated fw_cfg keys should be prefixed with "opt/".

(1) Please formulate this as follows:

'Names of user-provided fw_cfg items are supposed to start with "opt/".'

(Because we're really not "prefixing keys".)

> However FW_CFG_DATA_GENERATOR keys are generated by QEMU,

(2) s/keys/items/

> so allow the "etc/" namespace in this specific case.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> v7: reword commit description and added comment in code
> ---
>  softmmu/vl.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index cdb1d187ed..d5423eaf2b 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -2049,7 +2049,13 @@ static int parse_fw_cfg(void *opaque, QemuOpts *opts, Error **errp)
>                     FW_CFG_MAX_FILE_PATH - 1);
>          return -1;
>      }
> -    if (strncmp(name, "opt/", 4) != 0) {
> +    if (!nonempty_str(gen_id)) {

(3) I think this condition should be inverted. We'd like to suppress the
warning when "gen_id" is specified. In that case, nonempty_str(gen_id)
returns "true".

In other words, please drop the "!" operator.

> +        /*
> +         * In this particular case where the content is populated
> +         * internally, the "etc/" namespace protection is relaxed,
> +         * so do not emit a warning.
> +         */
> +    } else if (strncmp(name, "opt/", 4) != 0) {
>          warn_report("externally provided fw_cfg item names "
>                      "should be prefixed with \"opt/\"");
>      }
>

(4) I think having this in a separate patch is nice; I agree we should
do this. But I'd like to request a small update to
"docs/specs/fw_cfg.txt" as well, in the same patch.

Namely, where the document says:

"""
Use of names not beginning with "opt/" is potentially dangerous and
entirely unsupported.  QEMU will warn if you try.
"""

Please append:

"""
Use of names not beginning with "opt/" is tolerated with 'gen_id' (that
is, the warning is suppressed), but you must know exactly what you're
doing.
"""

Because this highlights that the user (or the management tool) *actively
participates* in connecting the content generated by QEMU with the
fw_cfg filename expected by the firmware.

With (1) through (4) fixed:

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks,
Laszlo


