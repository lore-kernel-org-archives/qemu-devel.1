Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B5BC433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 05:46:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E47102088E
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 05:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aEcCD6t0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E47102088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrxUK-0004qg-6C
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 01:46:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jrxTd-0004Qi-CX
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 01:46:09 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29669
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jrxTb-00084S-PP
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 01:46:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593927966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PlLnPVlxH0wwXrI3YRsNiM3RJTRfJgSHtnNBJbfiTpg=;
 b=aEcCD6t0+R3A9L+UL3nmFCVCYnGGkJ1rP6m9eMQlSxgNpQe367UnsJfcej6y1QBT5O8pT+
 k8ORiTIBzZQQf7N3B5eb4Et8q7zaeGOdHPZZNibxAuhnysGT2G+OxLTyF7KhD6lKfxPnki
 J8FTHhkosaGpR0meGmMRcaAe2GtxJl4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-yDhRlC6iONWiLPZmiMBl7A-1; Sun, 05 Jul 2020 01:46:04 -0400
X-MC-Unique: yDhRlC6iONWiLPZmiMBl7A-1
Received: by mail-wr1-f70.google.com with SMTP id i14so37538642wru.17
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 22:46:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PlLnPVlxH0wwXrI3YRsNiM3RJTRfJgSHtnNBJbfiTpg=;
 b=tiIyf85thacks7CbyCbeC9RIdh/+jQXQybdQfpy5aeYZkQ/FB85zXlHhR0ibwuL8zL
 B7/XCYSg59ou2rOuiDBVRjDfNrMoRhRRJbu1R5duER8f+BMwAdwL22vOowadV1D1/rgN
 +7ZYaI3CKC8yi3Y7yXAJEtBp5Ofyi3ODvYGtL7+WYIcSMMiKNmV6tdUWpZIwS5yOWzId
 f/yKpwU9aeK1pQH9awD7ntz6WNkXgkjfbE+O3OOO8mdfpBRMAXDdI85iGdWrTd3ZoDVO
 /8/uzpfRq/8V6ntrnAiX305XJd5PySmFc8QB+xsLv4wVOuGpWGJaVIjxWCL4h7l/GeLX
 QSwA==
X-Gm-Message-State: AOAM533PfYiVNyEGsHxZAXLk04W4k7d7Gi5KPu9oc58Urq6SvQhb5dzy
 m8kOCEie8BpaMkqcUAjC4vy9QHkpBpNA4m1oZlCkG3QNKeMalPn9V6ZQdsddTpWyKDJqOpY/nmf
 TXvbLWrbTva3KsyM=
X-Received: by 2002:a1c:7e87:: with SMTP id z129mr4802805wmc.45.1593927963511; 
 Sat, 04 Jul 2020 22:46:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpvEPk5pJBT3IFQzQiB6NGGu5gQkrGfJIsnzCGjy071JGN3RmFDkzYzriPHlvrdMsWqpU/pA==
X-Received: by 2002:a1c:7e87:: with SMTP id z129mr4802798wmc.45.1593927963288; 
 Sat, 04 Jul 2020 22:46:03 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:adf2:29a0:7689:d40c?
 ([2001:b07:6468:f312:adf2:29a0:7689:d40c])
 by smtp.gmail.com with ESMTPSA id m16sm14505996wro.0.2020.07.04.22.46.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jul 2020 22:46:02 -0700 (PDT)
Subject: Re: [PATCH] hw/core/qdev: Increase qdev_realize() kindness
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
References: <20200620153837.14222-1-f4bug@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c0366cb5-fcb0-ff62-8ab5-92722a47d4e7@redhat.com>
Date: Sun, 5 Jul 2020 07:46:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200620153837.14222-1-f4bug@amsat.org>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/05 01:46:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/06/20 17:38, Philippe Mathieu-Daudé wrote:
> -    } else {
> -        assert(!DEVICE_GET_CLASS(dev)->bus_type);
> +    } else if (DEVICE_GET_CLASS(dev)->bus_type) {
> +        error_report("%s: Unexpected bus '%s' for device '%s'",
> +                     __func__, DEVICE_GET_CLASS(dev)->bus_type,
> +                     object_get_typename(OBJECT(dev)));
> +        abort();
>      }
>  

Since there is an errp, should we use it and be even kinder?

Paolo


