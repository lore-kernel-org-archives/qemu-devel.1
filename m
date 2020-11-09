Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68498C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 14:50:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5DF520853
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 14:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bB96R7AU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5DF520853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc8V6-0003aJ-L7
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 09:50:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kc8TF-0001vC-Oi
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 09:48:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23534)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kc8TD-0007Cj-UY
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 09:48:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604933315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/LI3HylCuUP+xPFl85tb9asfa2LlUywI2YGj898N46w=;
 b=bB96R7AUSxWuSEcU+brLNP/S4UrX9EcX+hC5ll8y9qjG12mWXpJJOrs6YcSraMzBovNkcz
 NZP6CeKg7po3RFbQnGp1JW3c34hAOCe5tw2eeXhbDC+OyFpGtIbBCwmy2esfVm/SSCiIF6
 C2981Izu9DBqFtOsfoVh6WPcSOSoGd4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-kYcTrlG_N-yqbKD70-pbtQ-1; Mon, 09 Nov 2020 09:48:33 -0500
X-MC-Unique: kYcTrlG_N-yqbKD70-pbtQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 859B06D250
 for <qemu-devel@nongnu.org>; Mon,  9 Nov 2020 14:48:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-103.ams2.redhat.com
 [10.36.112.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 92A8D1007628;
 Mon,  9 Nov 2020 14:48:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0DA161132BD6; Mon,  9 Nov 2020 15:48:30 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 1/6] qemu-option: simplify search for end of key
References: <20201109133931.979563-1-pbonzini@redhat.com>
 <20201109133931.979563-2-pbonzini@redhat.com>
Date: Mon, 09 Nov 2020 15:48:30 +0100
In-Reply-To: <20201109133931.979563-2-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Mon, 9 Nov 2020 08:39:26 -0500")
Message-ID: <878sba7fi9.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 01:25:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> Use strcspn to find an equal or comma value, and pass the result directly
> to get_opt_name to avoid another strchr.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  util/qemu-option.c | 35 +++++++++++++----------------------
>  1 file changed, 13 insertions(+), 22 deletions(-)
>
> diff --git a/util/qemu-option.c b/util/qemu-option.c
> index acefbc23fa..ab3b58599e 100644
> --- a/util/qemu-option.c
> +++ b/util/qemu-option.c
> @@ -38,27 +38,19 @@
>  #include "qemu/help_option.h"
>  
>  /*
> - * Extracts the name of an option from the parameter string (p points at the
> + * Extracts the name of an option from the parameter string (@p points at the
>   * first byte of the option name)
>   *
> - * The option name is delimited by delim (usually , or =) or the string end
> - * and is copied into option. The caller is responsible for free'ing option
> - * when no longer required.
> + * The option name is @len characters long and is copied into @option. The
> + * caller is responsible for free'ing @option when no longer required.
>   *
>   * The return value is the position of the delimiter/zero byte after the option
> - * name in p.
> + * name in @p.
>   */
> -static const char *get_opt_name(const char *p, char **option, char delim)
> +static const char *get_opt_name(const char *p, char **option, size_t len)
>  {
> -    char *offset = strchr(p, delim);
> -
> -    if (offset) {
> -        *option = g_strndup(p, offset - p);
> -        return offset;
> -    } else {
> -        *option = g_strdup(p);
> -        return p + strlen(p);
> -    }
> +    *option = g_strndup(p, len);
> +    return p + len;
>  }

Hardly anything left; I believe this can be simplified further.  Not a
reason to delay this series.

>  
>  /*
> @@ -769,12 +761,11 @@ static const char *get_opt_name_value(const char *params,
>                                        const char *firstname,
>                                        char **name, char **value)
>  {
> -    const char *p, *pe, *pc;
> -
> -    pe = strchr(params, '=');
> -    pc = strchr(params, ',');
> +    const char *p;
> +    size_t len;
>  
> -    if (!pe || (pc && pc < pe)) {
> +    len = strcspn(params, "=,");
> +    if (params[len] != '=') {
>          /* found "foo,more" */
>          if (firstname) {
>              /* implicitly named first option */
> @@ -782,7 +773,7 @@ static const char *get_opt_name_value(const char *params,
>              p = get_opt_value(params, value);
>          } else {
>              /* option without value, must be a flag */
> -            p = get_opt_name(params, name, ',');
> +            p = get_opt_name(params, name, len);
>              if (strncmp(*name, "no", 2) == 0) {
>                  memmove(*name, *name + 2, strlen(*name + 2) + 1);
>                  *value = g_strdup("off");
> @@ -792,7 +783,7 @@ static const char *get_opt_name_value(const char *params,
>          }
>      } else {
>          /* found "foo=bar,more" */
> -        p = get_opt_name(params, name, '=');
> +        p = get_opt_name(params, name, len);
>          assert(*p == '=');
>          p++;
>          p = get_opt_value(p, value);

Reviewed-by: Markus Armbruster <armbru@redhat.com>


