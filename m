Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01998C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 16:37:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C234B206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 16:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ANVu5clT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C234B206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jW0Z5-00051A-SB
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 12:37:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jW0YR-0004TZ-Nd
 for qemu-devel@nongnu.org; Tue, 05 May 2020 12:36:23 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23184
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jW0YP-0002BZ-E1
 for qemu-devel@nongnu.org; Tue, 05 May 2020 12:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588696579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xz5VxpBa3Z5EPnPLXROvxtbcNmYsG2yl8VEg7Pp+h2g=;
 b=ANVu5clTrBpFkQVSuQKIuqP3rA2pVJ8+fDeqXagZomrmAbaAbK7S2QeaTrbTIR2sybjnBq
 vgIn/3/5iww1AJQilh/5IhciOhiQV/6B79W23GlJ6WSE0Itr49AOfgg5U+sworBnhDmHSy
 I3AvsqufFTXF4kqYCZI6S6q/aKY/O/E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-V3qf5sGyODen7U2JS4-UQg-1; Tue, 05 May 2020 12:36:18 -0400
X-MC-Unique: V3qf5sGyODen7U2JS4-UQg-1
Received: by mail-wr1-f70.google.com with SMTP id o6so1503554wrn.0
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 09:36:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xz5VxpBa3Z5EPnPLXROvxtbcNmYsG2yl8VEg7Pp+h2g=;
 b=hp6RCO5KARvB1++4adbM1jmTI0BRynjjdLsd+ubp3MYIgTd5AFDcQQ6nLbznPg6XrC
 ubualspVMyuxscdwQJ/FNUT+aVaU9teIK0rDvl4FHxOMbVU4EXi6RKPVGPGmIys7MR3k
 Dk02RfQ99WdwsJkRFjZtKksz3mYJsYzgM2BlGNDP6D3fDbXeGH03H8ZsvAcyNMHKBoC+
 ZhLF3Py1KM87R3HV6YYJ6WG5d6aIQCF+29l5gRu7HMB8AxUS6odYf+TVELevEgFkdrGN
 gvtKJuGIe2ionHCbDusDX7BvNr2haY4Byes4hQRP4QzhZRFWTYwVdRizKdCx8v20cTzT
 voKA==
X-Gm-Message-State: AGi0Puaor2tUftkdLolPzry/9/tVlThYMN7BePUe6ywkp0r3g/qNYDDw
 YWA0GG6/LrYEocTuaQ0UXf9Ak4X9JrZvjMGs03nBKwXhzC3P0iXfsLp2X/CHenVH0jfjcMGa6iS
 zsFCLqyGkxEKP4Rc=
X-Received: by 2002:a1c:e0c3:: with SMTP id x186mr4202525wmg.146.1588696576422; 
 Tue, 05 May 2020 09:36:16 -0700 (PDT)
X-Google-Smtp-Source: APiQypKKFmT3TxW4J+UzVGbGIRTxybnvm9BuMavc2B2izPX6nBw1osBJQFDL+WyHfS12E6MGLHcgew==
X-Received: by 2002:a1c:e0c3:: with SMTP id x186mr4202515wmg.146.1588696576214; 
 Tue, 05 May 2020 09:36:16 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.132.175])
 by smtp.gmail.com with ESMTPSA id i1sm3952807wrx.22.2020.05.05.09.36.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2020 09:36:15 -0700 (PDT)
Subject: Re: [PATCH v2 04/18] qom: Simplify object_property_get_enum()
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200505152926.18877-1-armbru@redhat.com>
 <20200505152926.18877-5-armbru@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c8b0ce35-e1d8-19ad-b988-18f34a1bd977@redhat.com>
Date: Tue, 5 May 2020 18:36:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200505152926.18877-5-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:40
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
Cc: berrange@redhat.com, ehabkost@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/05/20 17:29, Markus Armbruster wrote:
> Reuse object_property_get_str().  Switches from the string to the
> qobject visitor under the hood.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qom/object.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/qom/object.c b/qom/object.c
> index 3d65658059..b374af302c 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -1521,8 +1521,6 @@ typedef struct EnumProperty {
>  int object_property_get_enum(Object *obj, const char *name,
>                               const char *typename, Error **errp)
>  {
> -    Error *err = NULL;
> -    Visitor *v;
>      char *str;
>      int ret;
>      ObjectProperty *prop = object_property_find(obj, name, errp);
> @@ -1541,15 +1539,10 @@ int object_property_get_enum(Object *obj, const char *name,
>  
>      enumprop = prop->opaque;
>  
> -    v = string_output_visitor_new(false, &str);
> -    object_property_get(obj, v, name, &err);
> -    if (err) {
> -        error_propagate(errp, err);
> -        visit_free(v);
> +    str = object_property_get_str(obj, name, errp);
> +    if (!str) {
>          return 0;
>      }
> -    visit_complete(v, &str);
> -    visit_free(v);
>  
>      ret = qapi_enum_parse(enumprop->lookup, str, -1, errp);
>      g_free(str);
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>


