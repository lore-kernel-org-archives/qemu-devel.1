Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB74C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 16:44:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6977206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 16:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JWwKbhz4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6977206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jW0fr-0003Ou-VO
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 12:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jW0eP-0001Is-Tn
 for qemu-devel@nongnu.org; Tue, 05 May 2020 12:42:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41746
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jW0eO-0005ia-6F
 for qemu-devel@nongnu.org; Tue, 05 May 2020 12:42:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588696951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HdxysmLt6RfsYE8cEc7Kqfo7Njgp1XaZ2ijVO7BPlVQ=;
 b=JWwKbhz4ZSzn1v426dqICEfujDlbREjYzaKwww8D2hXt5UdkFuc+R2Mvf6nSj1htkrnXTw
 1OXLobIjPU7u6MScSv5p1hNOB3JrrutGAdxqMAAIGjiCfPUPLJfarHVAsgeODlpl4MOYAy
 6/rIW+RnA4vNJSmdSU3uviWWL42gddA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-bP168u_CNtGZjqHdPVqsVg-1; Tue, 05 May 2020 12:42:26 -0400
X-MC-Unique: bP168u_CNtGZjqHdPVqsVg-1
Received: by mail-wr1-f69.google.com with SMTP id v17so1494584wrq.8
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 09:42:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HdxysmLt6RfsYE8cEc7Kqfo7Njgp1XaZ2ijVO7BPlVQ=;
 b=aJZtDWD+pqTAr33Q1SvyOh4c8N3EEoaLvrZdOOt9myzXE3rxwx5/Q5zT/cKJ/22c2Y
 tTAB+zBHw59udBYuxTfxWG1AA/xvUREMpItoHleQiWAmEhwIHtj0+BZIQrvoBUjIkllO
 ki+9eD1eQ2i/WwWc4/jQV5I08IUAKNOZV5pkNX3YA0Gg4//CviBwIgm0yU0cIHZpbnOy
 bI8CkM7wx9qIRqLv9FHjyOui7AXwvf8bFImqHdL+z2Qa3PlU3nn+LYOEzC5MocPpqOHd
 1RuKQIeYzNhsL53Nj0UqCTtb9ujtvEB9vGnmjqnH7EL0bnfG9TI7NwN3juMQsByoNVnb
 6uaQ==
X-Gm-Message-State: AGi0Puar4z7PK60zN0rH3MGJv6vpAS37rNwGiPBX7oyCTS4PvZmqD9SQ
 qt09Hyq/QjBJ45kHyW8uBycX83XCUoYMhWCUpem8KLw1H/N0o5Dj+1ffb+JeY8ZRhp6yWD651Y5
 MjH3ObGovQlJn/lU=
X-Received: by 2002:adf:ea06:: with SMTP id q6mr3180884wrm.143.1588696945626; 
 Tue, 05 May 2020 09:42:25 -0700 (PDT)
X-Google-Smtp-Source: APiQypKWizLhGWPUgBEW0btMGm/Fu+lcg4MpHRpcGrIe4VyNJlFSE6iq/AvBXhfRrnytmX23RxkS9A==
X-Received: by 2002:adf:ea06:: with SMTP id q6mr3180871wrm.143.1588696945421; 
 Tue, 05 May 2020 09:42:25 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.132.175])
 by smtp.gmail.com with ESMTPSA id a187sm4769751wmh.40.2020.05.05.09.42.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2020 09:42:24 -0700 (PDT)
Subject: Re: [PATCH v2 05/18] qom: Drop convenience method
 object_property_get_uint16List()
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200505152926.18877-1-armbru@redhat.com>
 <20200505152926.18877-6-armbru@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9e7d4512-db46-d6fa-327d-994c401d233f@redhat.com>
Date: Tue, 5 May 2020 18:42:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200505152926.18877-6-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 03:48:16
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
> qom/object.c provides object_property_get_TYPE() and
> object_property_set_TYPE() for a number of common types.  These are
> all convenience wrappers around object_property_get_qobject() and
> object_property_set_qobject().
> 
> Except for object_property_get_uint16List(), which is unusual in two ways:
> 
> * It bypasses object_property_get_qobject().  Fixable; the previous
>   commit did it for object_property_get_enum())
> 
> * It stores the value through a parameter.  Its contract claims it
>   returns the value, like the other functions do.  Also fixable.
> 
> Fixing is not worthwhile, though: object_property_get_uint16List() has
> seen exactly one user in six years.
> 
> Convert the lone user to do its job with the generic
> object_property_get_qobject(), and drop object_property_get_qobject().

Typo, otherwise

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo

> Signed-off-by: Markus Armbruster <armbru@redhat.com>


