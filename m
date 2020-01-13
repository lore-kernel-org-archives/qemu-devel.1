Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7A1C33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 18:14:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAD5E207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 18:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JfnOonuC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAD5E207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir4Dv-0001Tp-2e
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 13:13:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50061)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ir4DH-00013h-2k
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 13:13:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ir4DE-0005Gp-NC
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 13:13:17 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48735
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ir4DE-0005F1-82
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 13:13:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578939195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vt7EEFitKJpBgcKJdOQnUgwubOQ26xYoCDqT4gSqALk=;
 b=JfnOonuCj/75pOJhzNRU+wE9S6ouRzjQ4UsWoEY0LxJ4BWuizFesxug85gZcjEXqUdrYmW
 hLgBWZ5RAGIIwDLJf/b/8YuNI5TJm/bMkLcE19U6S5EfFm4ZgadPpWM3uCqpocsj1x0CIt
 pFlfns/fFcMA+oaFAKrowEQnLFtmOUk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-MjlW6_xhOXizTNwC78NjMw-1; Mon, 13 Jan 2020 13:13:13 -0500
Received: by mail-wr1-f71.google.com with SMTP id f15so5390342wrr.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 10:13:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vt7EEFitKJpBgcKJdOQnUgwubOQ26xYoCDqT4gSqALk=;
 b=A+Jn5higJSBmBmzZxVyD5BokwDi8Yj0+MqbIdl9eUm1yEpt9oItj1HWYGPnoKluwjY
 g/GL6GvQcZ+rgZjXfxdWkfzmccWA2TxNbLE/k9Y2IiojUrx3iO9WuBuypdbEelgnUgPU
 jBtUdADXSbL4MjnkTBcpRBn49DSzBOLRGAJBoZ/piIPSb6wMSIB7GZaKlPH/yi+bzLCm
 avQt84zF2Aguag1DIzngUrzE5l5JppFvqeRrlnSNhgBlsAFNXmjOT9RfEggzYseSrONG
 RICkS2+xsbrpo9JFDBh+hlQnXu8+5tNMeH9bebIgR+PcJ34eYB+QxBwcmsc4+TmRQPQU
 RiJQ==
X-Gm-Message-State: APjAAAUOAol2YL+rFGmpe04pYJQPurMt5u21l2RVkvGVkKs6bYijPJgF
 /0uTEJ+bms916IlGEoDDwfZwXLyPkDDWFqahgOYJCV8xb5vDlK6DoGYg/mwgd9hz2gVkgsKL9E1
 L+A3eGLK7C0F+HLA=
X-Received: by 2002:a05:600c:54b:: with SMTP id
 k11mr21417659wmc.63.1578939192022; 
 Mon, 13 Jan 2020 10:13:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqzpbm5GODpewLVmWDDQ4+M6M6ofNPnFsXSmnyNOw2wGgUc6mHBuwVwRzgb6x0ZKfnZABxsoOQ==
X-Received: by 2002:a05:600c:54b:: with SMTP id
 k11mr21417633wmc.63.1578939191815; 
 Mon, 13 Jan 2020 10:13:11 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:1475:5c37:e2e2:68ea?
 ([2001:b07:6468:f312:1475:5c37:e2e2:68ea])
 by smtp.gmail.com with ESMTPSA id h2sm16718347wrt.45.2020.01.13.10.13.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jan 2020 10:13:11 -0800 (PST)
Subject: Re: [PATCH v2 0/3] exclude hyperv synic sections from vhost
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, vkuznets@redhat.com, mst@redhat.com,
 jasowang@redhat.com
References: <20200113173647.84842-1-dgilbert@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1bab529a-8655-ee28-f137-0311fb7839ff@redhat.com>
Date: Mon, 13 Jan 2020 19:13:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200113173647.84842-1-dgilbert@redhat.com>
Content-Language: en-US
X-MC-Unique: MjlW6_xhOXizTNwC78NjMw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

On 13/01/20 18:36, Dr. David Alan Gilbert (git) wrote:
> 
> Hyperv's synic (that we emulate) is a feature that allows the guest
> to place some magic (4k) pages of RAM anywhere it likes in GPA.
> This confuses vhost's RAM section merging when these pages
> land over the top of hugepages.

Can you explain what is the confusion like?  The memory API should just
tell vhost to treat it as three sections (RAM before synIC, synIC
region, RAM after synIC) and it's not clear to me why postcopy breaks
either.

Paolo

> Since they're not normal RAM, and they shouldn't have vhost DMAing
> into them, exclude them from the vhost set.


