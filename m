Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A34C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 10:37:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C6CA2087D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 10:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OJr33ZpS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C6CA2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIrIa-0002KJ-3i
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 06:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kIrHq-0001mN-9d
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 06:37:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21333)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kIrHn-0006mW-J9
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 06:37:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600339026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hoLZGR9TEoygTdKPlqpQ83qofcoDnUalDufesSIyG/E=;
 b=OJr33ZpSxtEAXj4D2O9LcbT/VYN3N+gPc/3Dk86ikpOKuS2qgUFozJV/+bstURlLc8uidO
 9rF9CeywxeD+3GWcC7jz8pfwCplMcO78CgSjrhw2ZcOK2/HtTLT/YYR6Lepg8eCx+6SV46
 iSILPz+wz3WIGTeOm8CM5Lt6R/2o8Ik=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-vB7Vcl-1MZymgwg2K-44GA-1; Thu, 17 Sep 2020 06:36:21 -0400
X-MC-Unique: vB7Vcl-1MZymgwg2K-44GA-1
Received: by mail-wr1-f69.google.com with SMTP id r16so706385wrm.18
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 03:36:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hoLZGR9TEoygTdKPlqpQ83qofcoDnUalDufesSIyG/E=;
 b=Cfetm4ME7Seb5dKJFLRh9N7Lx/I+CLU//LHLKMPv6F8IcXsu+i1YbGUM/vPJ//w2WH
 qEbKBp7EB2nCWBhSmhYw1euMehrhGqATz5E+AXTceX9zDrpSl5gkNuUICkp6WuhZEAaU
 oCmJG298fRpb3xJDrqcKrq7IqQmb38vhrwe3jZY+N5MMEC4pgA1go37bVV+8gOg7umbd
 xC9FlBGo6Z0CIZEThq8VXdypMuc53/Hb5P530Z+rR+gZ2npmB9fIlzO6S7RwSR9R5fVG
 GsKETZ9vbVd5dnECsXzhFRJxICIbrhyZJdUtDo23hylpTXuR396kERicgnc3qVjQb2O+
 +Hdg==
X-Gm-Message-State: AOAM532Z+CgzO53YOBfhZQaZnO8RSfD8vxEaeiD9DuyaPCT2XqxLhZQo
 IzJ4AbjC6YDvqJVEZRsUgx6Ni7Hv24w7vrT9FaDwGrArGZmj7ymPTS0Ty2Trby1uUTRcfY/mK0q
 02A52kauE4rEgBAY=
X-Received: by 2002:a5d:43cf:: with SMTP id v15mr34135628wrr.149.1600338980507; 
 Thu, 17 Sep 2020 03:36:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNhEEDCZPMotgxTC+X2ofDqUJZM0WFXerieYLubwx4Hg7kqqXAGZWk+kLvMONFDvSf5HFNLw==
X-Received: by 2002:a5d:43cf:: with SMTP id v15mr34135604wrr.149.1600338980221; 
 Thu, 17 Sep 2020 03:36:20 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d003:b94f:6314:4839?
 ([2001:b07:6468:f312:d003:b94f:6314:4839])
 by smtp.gmail.com with ESMTPSA id p1sm15023524wma.0.2020.09.17.03.36.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2020 03:36:19 -0700 (PDT)
Subject: Re: [PATCH 0/2] meson: move libmpathpersist test
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200916162621.100141-1-pbonzini@redhat.com>
 <879a2c0f-7015-2865-9488-b0d5cb6d07aa@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7b40a118-4524-817c-ae7c-814c0b6bb9e4@redhat.com>
Date: Thu, 17 Sep 2020 12:36:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <879a2c0f-7015-2865-9488-b0d5cb6d07aa@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 20:51:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.062, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/09/20 11:59, Thomas Huth wrote:
> On 16/09/2020 18.26, Paolo Bonzini wrote:
>> Move the libmpathpersist test, as well as its dependency
>> libudev, to meson.  This should fix or help debugging
>> https://travis-ci.com/github/huth/qemu/jobs/385737549#L4528
> 
> Thanks, this indeed decreased the amount of linker errors after I
> applied the patches, but there are still two errors left:
> 
>  https://travis-ci.com/github/huth/qemu/jobs/385871016#L7839

libmultipath has a libdevmapper dependency, but the cc.links() test does
not use the library enough to find the problem.

There are more dependencies reported by ldd (liburcu, libaio,
libsystemd, libgcrypt, libpcre2) so if this breaks again it's probably
best to exclude scsi/qemu-pr-helper from statically-linked builds.  In
the meanwhile I'll prepare a v2.

Paolo


