Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0185EC43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 14:52:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 297A621973
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 14:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dRSDNWtO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 297A621973
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJHki-0002Bf-Vl
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 10:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kJHjT-0001dq-Ha
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 10:51:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44660)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kJHjN-00053a-HU
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 10:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600440680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HVJrLM4iPJvQpKsuJIwSq+X7vQzxM0Qhxuif4uCbAFE=;
 b=dRSDNWtOWBPX+IMzdoTLL6Gd12p+qwJP70ofiBliRu4qHFl0XN6Y1WeVaXRzCd7hkOOfbr
 DAPs2Uj0gO6KIu9oJe4kA7EPjb2JzaQxQ4eI+0WwFECDuZBsCT9t4gIboWFGFC86LsVyil
 qcMC9FqZXWKYDjJ/u6970wkc9Xq5ivU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-tuLJ-yCWOfO3I5P78QGzKg-1; Fri, 18 Sep 2020 10:51:13 -0400
X-MC-Unique: tuLJ-yCWOfO3I5P78QGzKg-1
Received: by mail-wm1-f70.google.com with SMTP id w3so2152293wmg.4
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 07:51:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=xMdPu6HXSYE5JKzuz+Yi72t4VlETr8fODa3A0GdpDLM=;
 b=P7TY07W48HqUQaVbL5Nt8+5lCt+qYj5Y7o0uVNro5kuIEOLBYlAdcaY27YLgYok9p0
 uiwOfrTMtycFtOOfu3N8F8fI1iZcDKX1z/5AMqvh9PB2yHFZLWm65t6ORT8jjVzxZk7s
 ZeUBUM2Ujcg7+JgybwvFItK/lTo/zwuEFIMwNaGHYjtIuF1azZ1k8WGhKTwDT+jvoWxO
 OjgyY/sMgKSu7sdnQgSyWDyl2KBmU8ezxHfaWPeuUZPtucVjQBMxzJiXr4T7mdZ1200y
 yx9njIqToNh3JpSqjMabo04eLVQDfr4TNOsbwYlVuXMOoRHgADw2Kqotlk0D8iJpK1T5
 6mOQ==
X-Gm-Message-State: AOAM531nRWMo04uwJnSjqH3iBAke6LFPNg3gTlAakuNCuZNtu0wOd8Ct
 brDqAY3dpqlnq7lbJXF7wYDz58nXsjh8plOj1zNDXl3g22+MFSpAY0tZprGTjUu+zYX3PijoCk4
 35Jyyp+WQXZyPUKk=
X-Received: by 2002:a05:600c:2742:: with SMTP id
 2mr15398153wmw.136.1600440672385; 
 Fri, 18 Sep 2020 07:51:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwblMd55aq/lUZX+vJGgnXBLyEYc1TtoDdmCSrx+afXf8VaQFY4ffl3x7NoYXbr+GBvN0i/A==
X-Received: by 2002:a05:600c:2742:: with SMTP id
 2mr15398129wmw.136.1600440672186; 
 Fri, 18 Sep 2020 07:51:12 -0700 (PDT)
Received: from redhat.com (bzq-109-65-116-225.red.bezeqint.net.
 [109.65.116.225])
 by smtp.gmail.com with ESMTPSA id f16sm5527363wrp.47.2020.09.18.07.51.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 07:51:11 -0700 (PDT)
Date: Fri, 18 Sep 2020 10:51:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v10 00/13] i440fx/acpi: addition of feature and bug fixes.
Message-ID: <20200918105036-mutt-send-email-mst@kernel.org>
References: <20200918084111.15339-1-ani@anisinha.ca>
 <2fe7283a-6d5b-c62f-52cb-35dc6d94bad5@redhat.com>
MIME-Version: 1.0
In-Reply-To: <2fe7283a-6d5b-c62f-52cb-35dc6d94bad5@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 00:20:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, jusual@redhat.com,
 qemu-devel@nongnu.org, Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 18, 2020 at 11:55:54AM +0200, Philippe Mathieu-Daudé wrote:
> On 9/18/20 10:40 AM, Ani Sinha wrote:
> > Final patch series with all the patches reviewed or ack'd and marked as such.
> > Thanks Julia and Igor for the reviews. Hope this series gets pulled in soon.
> 
> FYI there is no need to collect tags on the final version.

Right but if a new version is posted then yes you want to
include tags.

> Tools already do that for you, see:
> https://patchew.org/QEMU/20200918072325.9933-1-ani@anisinha.ca/
> 
> The maintainer can import the patches with the proper Message-Id /
> Reviewed-by / Acked-by / Tested-by tags added using:
> https://patchew.org/QEMU/20200918072325.9933-1-ani@anisinha.ca/mbox
> 
> Regards,
> 
> Phil.


