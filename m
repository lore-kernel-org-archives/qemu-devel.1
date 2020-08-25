Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9458AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 13:02:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5111C20738
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 13:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="alz+9Stf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5111C20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAYag-0001sm-Ew
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 09:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kAYZh-0001Nx-Hy
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 09:01:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21577)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kAYZe-0001dZ-Ko
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 09:01:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598360472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a37JZmxXzU18pGFJuRTcnwTa2D2IklpluHIbnruOCoQ=;
 b=alz+9StfJvDRfYqT/EeXKyeyUwdRN62tcAjK0N1TonnEpBhiMh6D1qGwhKoqeUFByl4bzV
 N8F5v5Ygjz31zzirdaCRSmmdbmb7XyFZghS6p6UEYjbLebqAfOB5pK4BWDAA7278Y7oCxF
 uWTRr+O3ymbWrlcsJVdk3v2oGfBUlUU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-580-QtwoyjWiNlWcrvPPfm6TZQ-1; Tue, 25 Aug 2020 09:01:10 -0400
X-MC-Unique: QtwoyjWiNlWcrvPPfm6TZQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 928DE1006719;
 Tue, 25 Aug 2020 13:01:09 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-113-0.ams2.redhat.com
 [10.36.113.0])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A070019C58;
 Tue, 25 Aug 2020 13:01:08 +0000 (UTC)
Subject: Re: [PATCH v2 4/7] acpi: add aml_land() and aml_break() primitives
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200818122208.1243901-1-imammedo@redhat.com>
 <20200818122208.1243901-5-imammedo@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <d08d5d09-0cc8-42a1-58f5-25db5bd0abc0@redhat.com>
Date: Tue, 25 Aug 2020 15:01:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200818122208.1243901-5-imammedo@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 06:38:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.602, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: boris.ostrovsky@oracle.com, aaron.young@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/18/20 14:22, Igor Mammedov wrote:
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  include/hw/acpi/aml-build.h |  2 ++
>  hw/acpi/aml-build.c         | 16 ++++++++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> index d27da03d64..e213fc554c 100644
> --- a/include/hw/acpi/aml-build.h
> +++ b/include/hw/acpi/aml-build.h
> @@ -291,6 +291,7 @@ Aml *aml_store(Aml *val, Aml *target);
>  Aml *aml_and(Aml *arg1, Aml *arg2, Aml *dst);
>  Aml *aml_or(Aml *arg1, Aml *arg2, Aml *dst);
>  Aml *aml_lor(Aml *arg1, Aml *arg2);
> +Aml *aml_land(Aml *arg1, Aml *arg2);
>  Aml *aml_shiftleft(Aml *arg1, Aml *count);
>  Aml *aml_shiftright(Aml *arg1, Aml *count, Aml *dst);
>  Aml *aml_lless(Aml *arg1, Aml *arg2);
> @@ -300,6 +301,7 @@ Aml *aml_increment(Aml *arg);
>  Aml *aml_decrement(Aml *arg);
>  Aml *aml_index(Aml *arg1, Aml *idx);
>  Aml *aml_notify(Aml *arg1, Aml *arg2);
> +Aml *aml_break(void);
>  Aml *aml_call0(const char *method);
>  Aml *aml_call1(const char *method, Aml *arg1);
>  Aml *aml_call2(const char *method, Aml *arg1, Aml *arg2);
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index f6fbc9b95d..14b41b56f0 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -556,6 +556,15 @@ Aml *aml_or(Aml *arg1, Aml *arg2, Aml *dst)
>      return build_opcode_2arg_dst(0x7D /* OrOp */, arg1, arg2, dst);
>  }
>  
> +/* ACPI 1.0b: 16.2.5.4 Type 2 Opcodes Encoding: DefLAnd */
> +Aml *aml_land(Aml *arg1, Aml *arg2)
> +{
> +    Aml *var = aml_opcode(0x90 /* LandOp */);

(1) Small typo in the comment: in the spec, it is spelled "LAndOp", not
"LandOp" (consistently with "LOrOp" just below -- although "LOrOp" is
not visible in the context, in this email).

> +    aml_append(var, arg1);
> +    aml_append(var, arg2);
> +    return var;
> +}
> +
>  /* ACPI 1.0b: 16.2.5.4 Type 2 Opcodes Encoding: DefLOr */
>  Aml *aml_lor(Aml *arg1, Aml *arg2)
>  {

(2) In the header file, the declaration order is aml_lor(), then
aml_land(). But in the C file, the definitions are in the opposite
order: aml_land(), aml_lor().

Not sure which one is right, but we should be consistent, if we can.

> @@ -629,6 +638,13 @@ Aml *aml_notify(Aml *arg1, Aml *arg2)
>      return var;
>  }
>  
> +/* ACPI 1.0b: 16.2.5.3 Type 1 Opcodes Encoding: DefBreak */
> +Aml *aml_break(void)
> +{
> +    Aml *var = aml_opcode(0xa5 /* BreakOp */);
> +    return var;
> +}
> +
>  /* helper to call method without argument */
>  Aml *aml_call0(const char *method)
>  {
> 

With my trivial comments (1) and (2) fixed:

Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Tested-by: Laszlo Ersek <lersek@redhat.com>

Thanks,
Laszlo


