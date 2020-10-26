Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3CFC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 09:51:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC3AB20704
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 09:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cKOXJNjQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC3AB20704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWzAM-0003jm-N3
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 05:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kWz8k-0002oH-MA
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 05:50:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39200)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kWz8i-0000TJ-2c
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 05:50:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603705806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tPRK3qsTu7aENZjyr/nAblbKUmtQ/UgEQABsDTFzZhM=;
 b=cKOXJNjQhBBCMZas4bYkgVPN8Ch2uEJI4bNYg9e9ly3aHtAOGIa2MI4FDcZYMjXIbXW013
 pfgmqI7+QBndW7hLjo3UIO9Bb4oVDEAYc/Ae+nExqyBoiahDcdwiWICym0bKnI5hUVcIrw
 kiW90J6QVLPskJLQDFRf6+tv9gQZ8qg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-tvQ0d31OM22zgvHck479hg-1; Mon, 26 Oct 2020 05:50:04 -0400
X-MC-Unique: tvQ0d31OM22zgvHck479hg-1
Received: by mail-wr1-f69.google.com with SMTP id k14so8125015wrd.6
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 02:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tPRK3qsTu7aENZjyr/nAblbKUmtQ/UgEQABsDTFzZhM=;
 b=iHuIVhU5YB9xke8PJopkm4m+dBEq9jWLHxKhLI2lrMElUOxyREmdofT5V4NTv2OsVu
 j9ZjnOCERSVhn21iKnhTEs6phvFP+tdO+7I6xhpyebypotqAniwC8qtho0PqVIIlcGd0
 cq5pneEilvA5YsID3CZ659BqaunwtDZIEvTqI2jGdNlK+s7A3tR0tB27wCGdnB4oAubM
 g88rbz+VGzukCglEvh2DZwdbplUCoDSreamgsJLzf3A3gpipiDJcxR27pelpOoDl3ZMa
 SokVBeFfAjxZ2b6QuTAfGU6TTzpjQH02aOPahEp/YoXE42GksJSlCBCLCNTu93zd5B8a
 j52g==
X-Gm-Message-State: AOAM532M5BLPLzpcy0MtqwgUNbgivEAZpE0Wwmm5jQzYoXoaMs7/7/+Z
 8caNicF3jTFouy6Qw/jSkSKK0sszLEOycaby1XmvdYS5ikYN0fh4CxtGV61xr9a9H4yXMUwNA/f
 59nvgROPVFz1jKCw=
X-Received: by 2002:adf:ef02:: with SMTP id e2mr16061267wro.381.1603705803513; 
 Mon, 26 Oct 2020 02:50:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJNqe6vFbKo9qeui/l3RUbOgJwYNBGKUFSv7WCvV/tGnlm2THaQy9a7kf0nP5Nu8i5ZwzoIA==
X-Received: by 2002:adf:ef02:: with SMTP id e2mr16061244wro.381.1603705803256; 
 Mon, 26 Oct 2020 02:50:03 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id l6sm23073481wrt.7.2020.10.26.02.50.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2020 02:50:02 -0700 (PDT)
Subject: Re: [PATCH v2 2/6] configure: avoid new clang 11+ warnings
To: Daniele Buono <dbuono@linux.vnet.ibm.com>, qemu-devel@nongnu.org
References: <20201023200645.1055-1-dbuono@linux.vnet.ibm.com>
 <20201023200645.1055-3-dbuono@linux.vnet.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <96d4c76c-dfbb-f985-2718-0892ea1b83d4@redhat.com>
Date: Mon, 26 Oct 2020 10:50:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201023200645.1055-3-dbuono@linux.vnet.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Alexander Bulekov <alxndr@bu.edu>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/10/20 22:06, Daniele Buono wrote:
> 1 error generated.
> 
> The data structure is UASStatus, which must end with a QTAILQ_ENTRY, so
> I believe we cannot have uas_iu at the end. Since this is a gnu
> extension but CLANG supports it, just add
> -Wno-gnu-variable-sized-type-not-at-end

This is potentially a real bug, in this case it works only because
UASStatus's packet is never uas_iu_command (which has the variable sized
type).

The QTAILQ_ENTRY need not be at the end, please rearrange UASStatus's
field so that the "usb_ui status" field is the last.

Thanks,

Paolo


