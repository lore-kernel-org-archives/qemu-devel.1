Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C572C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 16:07:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C566B206A4
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 16:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D1qDWHUf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C566B206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jW06b-0006nY-W1
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 12:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jW00G-0000lg-Uy
 for qemu-devel@nongnu.org; Tue, 05 May 2020 12:01:09 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44998
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jW00G-0006EG-1i
 for qemu-devel@nongnu.org; Tue, 05 May 2020 12:01:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588694462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/8GiUID/iAiT1ND7RFWOtQDWx7vJxczv9G0qMFuBqRo=;
 b=D1qDWHUfYVlQtTJ35GvN7xfGqLWHBn5UbFGnpU7nl7RT3Cgsfv3T8Mavr/a6To0LAOPQBs
 wNobJ1GLaQbL5Dfukqq+ZFLzQQtY5A2jJDqSCQ8iX/68qXPp88Iig/8Jn0owxrCZhAByqc
 Q7Iink4TtxqQtSMf7BpyC4+oBLFzszc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-G9ibJU5UNCykjKA1embo1Q-1; Tue, 05 May 2020 12:01:01 -0400
X-MC-Unique: G9ibJU5UNCykjKA1embo1Q-1
Received: by mail-wr1-f72.google.com with SMTP id o6so1447716wrn.0
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 09:01:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rJm2K3dyqcZbblejvaaVc0gKJ3s5kSVmjEA7iP59Yuo=;
 b=K3j7zjBwwCrhS5b4lRzB7e+8vaoCYlum+YreBicYCzlpUE+2KeJ5ZcPaDwC0DDAzWr
 hR/shnpSB0G8TYtmwtDyaAkzIi6eeK7QgtQUYC44fLroxEoboBrO74gWWF2Yv5M8PJSW
 cVDFfDCZThj4T74XVUAyjUcMnU/1tyoinTXR5ScekNd9p7FAwI2EIsoV3/fczbaJU5G+
 LsUsHszaQS+aw74dG6xV8/P7YdGrL2pihiMPJ80mXeOofWMy//Cv2ebTLgJ8TAVdxYuf
 Vhzw1ZO0DJ2aVIqUlAVIDbUvZ4Z6vFlTzHACAKOiaMIIuPlvk1zRNE9sVvOtNi2wErj+
 MGnA==
X-Gm-Message-State: AGi0PuZAEpuuavG1y5WNgXUDM+6pqv9MqKM7SbpegyH4mKeF8Q7peWTk
 HuZy2Y3EUGaeo3/DbcVL9SAgrBDHAN0UV9hH1eShmjLCKDSDtX5G0LsQgqkKlwdMz4Kr/b+2sxV
 HSXOjLE/wjzmro/Y=
X-Received: by 2002:a05:600c:414b:: with SMTP id
 h11mr4016884wmm.9.1588694460073; 
 Tue, 05 May 2020 09:01:00 -0700 (PDT)
X-Google-Smtp-Source: APiQypLhsxhqADJylEpBUzDA2OgFFtaFRwdHNkeyWqEZEXOCdPvmUWkNOn1FA6rxyg3tJERzfloCqw==
X-Received: by 2002:a05:600c:414b:: with SMTP id
 h11mr4016866wmm.9.1588694459906; 
 Tue, 05 May 2020 09:00:59 -0700 (PDT)
Received: from [192.168.1.38] (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id r3sm3936901wrx.72.2020.05.05.09.00.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2020 09:00:59 -0700 (PDT)
Subject: Re: [PATCH v2 18/18] qom: Drop @errp parameter of
 object_property_del()
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200505152926.18877-1-armbru@redhat.com>
 <20200505152926.18877-19-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <57055a2a-8ae3-f5e2-54fd-26ce4f3060a6@redhat.com>
Date: Tue, 5 May 2020 18:00:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200505152926.18877-19-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:19
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/5/20 5:29 PM, Markus Armbruster wrote:
> Same story as for object_property_add(): the only way
> object_property_del() can fail is when the property with this name
> does not exist.  Since our property names are all hardcoded, failure
> is a programming error, and the appropriate way to handle it is
> passing &error_abort.  Most callers do that, the commit before
> previous fixed one that didn't (and got the error handling wrong), and
> the two remaining exceptions ignore errors.
>=20
> Drop the @errp parameter.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/qom/object.h       | 2 +-
>   hw/core/qdev.c             | 2 +-
>   hw/i386/pc_sysfw.c         | 2 +-
>   hw/ppc/spapr_drc.c         | 4 ++--
>   qom/object.c               | 7 +------
>   qom/object_interfaces.c    | 3 +--
>   tests/check-qom-proplist.c | 2 +-
>   7 files changed, 8 insertions(+), 14 deletions(-)

Nice :)

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


