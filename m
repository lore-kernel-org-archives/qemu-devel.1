Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1F1C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:17:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64B8420767
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CFpglkvz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64B8420767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDmIi-0005Er-BQ
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 06:17:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kDmHz-0004gd-US
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 06:16:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37044)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kDmHx-0006iI-To
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 06:16:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599128176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D87tZED7N3BvgJfwC9rZfJ4JaJnklvmWMvUFhVuS3Ng=;
 b=CFpglkvznuXdOXkL7S1s1dq2vjD1OWUkH+tppIdzyc9Sl+hnmt4xV957OyFg6IC46eSiWy
 lVfZvA7JgwTlK3kqqQch2cbZwSzDwt74jbye950GFmMAlq6jVRAKHcUWn54TNH2S0kOhIt
 VwKYyYn4w0pLMew15b8OpXdOK+TDiWU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-Q2l9oTg7MVC3Av7vr7Ibow-1; Thu, 03 Sep 2020 06:16:13 -0400
X-MC-Unique: Q2l9oTg7MVC3Av7vr7Ibow-1
Received: by mail-wr1-f72.google.com with SMTP id k11so891492wrw.16
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 03:16:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=D87tZED7N3BvgJfwC9rZfJ4JaJnklvmWMvUFhVuS3Ng=;
 b=j/0aAVITEYVtuaaYBePnthZ1/eL5U8RoXhOYAJimvmQd+R3Jw2EmQBQEKAj7OwOkqo
 BQt8QVxTH1HbPQTMZRHMH3X/NlQ+QKJmki4fO7WY/Xsoby8ImaDi25UHfsIaAxRK79yq
 /f5ul75oCP69WRffr6skVfkm+cTtKzbzT8q3BKuukLvTndrDi6D5TPGzaWImmvOqsxef
 gBYLbflYpy1cyyl+sqNQmXc7fzmCCfO9HUn3Auek92KPN9odey5KgjMOjTsTZ7lx8UxT
 KdWFZ5vaAfcxOHfCGo2rCcJtbKsw9AdiC72/t+kZT25isY8U33SZYNYmd9GpiWLv/OO1
 aduw==
X-Gm-Message-State: AOAM531Dpn9gCDhKDaDYVnSoQHVh92ZB9TLO6sJ87dHZOXK5dVCvLVpg
 2pxrK5ep2TEprDEjg57j2MNQEvZM87JjTl3XEtvYyGOYTU7k8bztcwk+0aNt0sCkGxn453Ez4H4
 vWno2NSvvmNKeKLo=
X-Received: by 2002:a5d:60d0:: with SMTP id x16mr1648647wrt.196.1599128171929; 
 Thu, 03 Sep 2020 03:16:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxok2TUNp5jzWOxnBupeSekyOMPw2mgreS1LHc/gN6DUwWN/abFXCvgzpfPkQa/kmspVi/6/w==
X-Received: by 2002:a5d:60d0:: with SMTP id x16mr1648623wrt.196.1599128171665; 
 Thu, 03 Sep 2020 03:16:11 -0700 (PDT)
Received: from redhat.com (bzq-79-177-107-202.red.bezeqint.net.
 [79.177.107.202])
 by smtp.gmail.com with ESMTPSA id c205sm3595455wmd.33.2020.09.03.03.16.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 03:16:11 -0700 (PDT)
Date: Thu, 3 Sep 2020 06:16:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <ani@anisinha.ca>
Subject: Re: [PATCH] Fix a gap where acpi_pcihp_find_hotplug_bus() returns a
 non-hotpluggable bus
Message-ID: <20200903061515-mutt-send-email-mst@kernel.org>
References: <20200829081233.10120-1-ani@anisinha.ca>
 <20200903060332-mutt-send-email-mst@kernel.org>
 <CAARzgwwFRUOoq7GOttzJVT8+67+7uNugC529SB8DX242p8A_QQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAARzgwwFRUOoq7GOttzJVT8+67+7uNugC529SB8DX242p8A_QQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 04:23:54
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
Cc: Igor Mammedov <imammedo@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 03, 2020 at 03:41:13PM +0530, Ani Sinha wrote:
> On Sep 3, 2020, 15:35 +0530, Michael S. Tsirkin <mst@redhat.com>, wrote:
> 
>     On Sat, Aug 29, 2020 at 01:42:33PM +0530, Ani Sinha wrote:
> 
>         When ACPI hotplug for the root bus is disabled, the bsel property for
>         that
> 
>         bus is not set. Please see the following commit:
> 
> 
> 
>         3d7e78aa7777f ("Introduce a new flag for i440fx to disable PCI hotplug
>         on the root bus").
> 
> 
> 
>         As a result, when acpi_pcihp_find_hotplug_bus() is called
> 
>         with bsel set to 0, it may return the root bus. This would be wrong
>         since the
> 
>         root bus is not hotpluggable. In general, this can potentially happen
>         to other
> 
>         buses as well.
> 
>         In this patch, we fix the issue in this function by checking if the bus
>         returned
> 
>         by the function is actually hotpluggable. If not, we simply return
>         NULL. This
> 
>         avoids the scenario where we are actually returning a non-hotpluggable
>         bus.
> 
> 
> 
>         Signed-off-by: Ani Sinha <ani@anisinha.ca>
> 
> 
> 
>     What exactly are the consequences though?
> 
> 
> The root bus might get ejected by the user when it should not if the user does
> the following:
> 
> outl 0xae10 0
> outl 0xae08 your_slot
> 
> Please see Julia’s comment:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg734548.html

OK so patch looks good, but please add all this in the commit log.

-- 
MST


