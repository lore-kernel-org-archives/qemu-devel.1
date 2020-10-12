Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170E2C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 13:49:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D61D20678
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 13:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JxX5b/ol"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D61D20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRyCg-0000ui-Gb
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 09:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kRy8V-0005zl-EO
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 09:45:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47871)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kRy8S-00007G-0J
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 09:45:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602510305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fOefzMy1BDsq2KlMUkuY8d0EYifJ5JTTwdRTwXuLgV8=;
 b=JxX5b/olmxbioiJsFBaIUaFoNT+1KhDEb8PqkKMLsFTTGi+97eDao+mPGzWEbb9Nkpj1oY
 55vBJ42Y2UPl8iNPZdze347DLKr115ONmhxtSZZVFw2HRY4X4HrrOfSxUiWuIIHWqrySz0
 2n2I3c8oZlITkd7bi6UzC2UbiGUDWhc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-ERrvkMu1PuOIxthyNyTPfw-1; Mon, 12 Oct 2020 09:45:01 -0400
X-MC-Unique: ERrvkMu1PuOIxthyNyTPfw-1
Received: by mail-wr1-f70.google.com with SMTP id b6so9286337wrn.17
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 06:45:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fOefzMy1BDsq2KlMUkuY8d0EYifJ5JTTwdRTwXuLgV8=;
 b=HrpeA3gZ2OBvIVX9fUgh3NA5y5aJH6CILaloflb03FZQh2eW3OzQZSCuwsJTaErDWg
 WWp4RP1wgCJ3+J74Ion+YH6C8eHxWjj37OmW2tU0z+rV2exBrMWCyEl4yp0JKUn6ls1Q
 QDfZevkc0Fi5sCJVMHaveo3VxhLPUOAj1rGRfpBpK0EuwwnIdEmMan39T8qRhAOSlg3e
 25UpfBhddcez6XAsQKogQOWzhJ4VPsyKrC9YBflDbKqgA1nha5xC30MNQwIx8gOdKWdw
 G0dXEulstsW3YX5hh89vXFBaPAATy+vKXhVq9GCTNbrdtV8YesBdBqjMtBr2cAnVyhVj
 RC9Q==
X-Gm-Message-State: AOAM533jWsVJBL6krLnklvOfgxgbHkqF5nkyQwr5tgDG4kFDP+PYSPMP
 mgQnyCdgx49tNGF79qjPddboe4bLex2o+Q/qGPWQOyyazK/H6DHF2gexjcqHjMQvmM5lZc7+p/F
 0SvwUc2XTsoS2pVI=
X-Received: by 2002:adf:c3cd:: with SMTP id d13mr4306584wrg.15.1602510299693; 
 Mon, 12 Oct 2020 06:44:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxK2oZhKbfelocLEVt0Nm4s7meurcokG+YKDleXlVDtaUCblfv+RG0F8QpYmpSYlHwO58jWUQ==
X-Received: by 2002:adf:c3cd:: with SMTP id d13mr4306574wrg.15.1602510299510; 
 Mon, 12 Oct 2020 06:44:59 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7ffb:1107:73ba:dbcf?
 ([2001:b07:6468:f312:7ffb:1107:73ba:dbcf])
 by smtp.gmail.com with ESMTPSA id n3sm23520646wmn.28.2020.10.12.06.44.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2020 06:44:59 -0700 (PDT)
Subject: Re: [PATCH] hw/net: move allocation to the heap due to very large
 stack frame
To: Thomas Huth <thuth@redhat.com>, David Gibson
 <david@gibson.dropbear.id.au>, Elena Afanasova <eafanasova@gmail.com>
References: <8f07132478469b35fb50a4706691e2b56b10a67b.camel@gmail.com>
 <20201010060745.GK1025389@yekko.fritz.box>
 <f505c80b88ee665a62883a69bed9d614f6ba2a66.camel@gmail.com>
 <20201012053001.GD4787@yekko.fritz.box>
 <38d5993e-8a10-0fb1-5263-6531a356fefd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ca54ec71-11b4-70c5-6d48-4e58fb90a545@redhat.com>
Date: Mon, 12 Oct 2020 15:45:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <38d5993e-8a10-0fb1-5263-6531a356fefd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 23:52:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, jasowang@redhat.com, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/10/20 12:44, Thomas Huth wrote:
> I think this is one of the tasks from:
> 
>  https://wiki.qemu.org/Contribute/BiteSizedTasks#Compiler-driven_cleanups
> 
> It has been added by Paolo in 2016:
> 
>  https://wiki.qemu.org/index.php?title=Contribute/BiteSizedTasks&diff=5368&oldid=5367
> 
> ... so maybe Paolo can comment on the size that has been chosen here...?

I used 16K, mostly because it is a nice round number.  8k is too small
due to PATH_MAX-sized variables.  16k seemed to be plenty and triggered
in few-enough places that the cleanup is viable.

Paolo


