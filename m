Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429A3C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 16:48:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AE5D2065F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 16:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bC9O5DYi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE5D2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbRtj-000681-8M
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 12:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbRs9-0004PT-LI
 for qemu-devel@nongnu.org; Wed, 20 May 2020 12:47:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25343
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbRs8-0004lq-HJ
 for qemu-devel@nongnu.org; Wed, 20 May 2020 12:47:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589993231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1dCxNM5aQpvPAMmM5ZeA8Q1T7lJAqJtv/6P2721uxow=;
 b=bC9O5DYihRhc4T1IEcIgBPoG9dE/f+jt2zA4Wz7z9AU8b+Vtz5+pjpNXdVSNmLt5mkZXgA
 l4CbwxoFJK0EyXPYMH+AyUxU1q+jn0XBybPHdhDEhSPoP+GPe6qRI929kx5A8Yan4KAeRR
 4yIpbvoPwz2JJKRWFRZk3AFluU0Z8qg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-HfezXM2DM8aFJj2eWGwWmg-1; Wed, 20 May 2020 12:47:08 -0400
X-MC-Unique: HfezXM2DM8aFJj2eWGwWmg-1
Received: by mail-ej1-f71.google.com with SMTP id t26so1572364ejs.19
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 09:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1dCxNM5aQpvPAMmM5ZeA8Q1T7lJAqJtv/6P2721uxow=;
 b=Sbh+FPRXuNiaSZaYjcF01swr7aM4Mpem/2bpIsyzJ6Cw8DlPE/Ubrl7yfO5tinPmXU
 m8pgt8v5SVGOtbi5k/uzP1bEzvB9fzPBEpw3pNC6k6sbzDgc1UPGOeo/gBmxzHrWYJ90
 bBXa3tBNPxHd0EP+jpLNMky3I1n7FYir4Ujl8eB0qiAEVPKPcNA1N1gi8lPoqpcFT9N3
 J0zUp5DCajXtdUBBiGDKYPukAm0l7m4ceTLR+tOa2RGnk4kSwYLkqPC1PxkD9ys3WdW0
 BUtfgMtF23gQMXjIiBH0hy7bh6y2TkrXPSX3A4K9VsJMVTu+uSc1rpTXcM5vgZ1CHkwT
 oJ6w==
X-Gm-Message-State: AOAM532ZplZzpAWGjEWA8mheG50s3dOv0MDIpoaSxCMb1D09qZ0ET9fv
 eihR78ApwpPmFoxVk2W64dW4br+lD1rlIR+9/M2d8gTAcmWLxAWOfWKDiU+qotsbH2wbrYbgjM0
 ebxa7A8JK0fCZVxw=
X-Received: by 2002:aa7:ce17:: with SMTP id d23mr4317072edv.387.1589993227750; 
 Wed, 20 May 2020 09:47:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3m1HF71DnLpT0cMFrNH3tbSU4trArN7xOmOGSP0jIEtqpAsRxyJiy6/d/acAQw+50AL3r5Q==
X-Received: by 2002:aa7:ce17:: with SMTP id d23mr4317045edv.387.1589993227503; 
 Wed, 20 May 2020 09:47:07 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id dk11sm2138923edb.67.2020.05.20.09.47.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2020 09:47:06 -0700 (PDT)
Subject: Re: [PATCH 2/2] hmp: Simplify qom_set
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, armbru@redhat.com
References: <20200520151108.160598-1-dgilbert@redhat.com>
 <20200520151108.160598-3-dgilbert@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1f627a6b-9c5f-09b3-8f75-64e95a4f5d02@redhat.com>
Date: Wed, 20 May 2020 18:47:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200520151108.160598-3-dgilbert@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 01:34:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: berrange@redhat.com, clg@kaod.org, afaerber@suse.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/20/20 5:11 PM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Simplify qom_set by making it use qmp_qom_set and the JSON parser.
> 
> Note that qom-set likes JSON strings quoted with ' not ", e.g.:
> 
> (qemu) qom-get /machine smm
> "auto"
> (qemu) qom-set /machine smm 'auto'

Will I get this output using "?

(qemu) qom-set /machine smm "auto"
Error: Expecting a JSON value

> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>   qom/qom-hmp-cmds.c | 16 +++++-----------
>   1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/qom/qom-hmp-cmds.c b/qom/qom-hmp-cmds.c
> index a8b0a080c7..f704b6949a 100644
> --- a/qom/qom-hmp-cmds.c
> +++ b/qom/qom-hmp-cmds.c
> @@ -48,19 +48,13 @@ void hmp_qom_set(Monitor *mon, const QDict *qdict)
>       const char *property = qdict_get_str(qdict, "property");
>       const char *value = qdict_get_str(qdict, "value");
>       Error *err = NULL;
> -    bool ambiguous = false;
> -    Object *obj;
> +    QObject *obj;
>   
> -    obj = object_resolve_path(path, &ambiguous);
> -    if (obj == NULL) {
> -        error_set(&err, ERROR_CLASS_DEVICE_NOT_FOUND,
> -                  "Device '%s' not found", path);
> -    } else {
> -        if (ambiguous) {
> -            monitor_printf(mon, "Warning: Path '%s' is ambiguous\n", path);
> -        }
> -        object_property_parse(obj, value, property, &err);
> +    obj = qobject_from_json(value, &err);
> +    if (err == NULL) {
> +        qmp_qom_set(path, property, obj, &err);
>       }
> +
>       hmp_handle_error(mon, err);
>   }
>   
> 


