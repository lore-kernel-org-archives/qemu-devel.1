Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D27DC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 13:41:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB0D421741
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 13:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iW0vjsrt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB0D421741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUrsw-0006rB-Sb
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 09:41:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1kUrrd-0005Ne-M0
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 09:39:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26902)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1kUrrc-00025q-1Z
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 09:39:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603201183;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Q5wF88JL0QdclagRgYtwbNc7/5Wm60uvA6tierOxAx0=;
 b=iW0vjsrthjZCxRHreSMPLkP7MNtSd2fwxS/ldpxbMYwVle0EkzzdFIKObg3gzQa9+3k5jG
 sC5f0NR0qP44qjXoR514iotksEUvzSsxdoMh5G8uZHfgsh0l1nf9XUhFqQ4mR3Vdte7wrz
 M77hbn5y9DlSxP4J1pyQM6VIMd0Vakw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-541-LdxOM11AM4Kcz9eWE5hXKw-1; Tue, 20 Oct 2020 09:39:41 -0400
X-MC-Unique: LdxOM11AM4Kcz9eWE5hXKw-1
Received: by mail-wr1-f71.google.com with SMTP id 31so832784wrg.12
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 06:39:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
 :user-agent:reply-to:date:message-id:mime-version;
 bh=Q5wF88JL0QdclagRgYtwbNc7/5Wm60uvA6tierOxAx0=;
 b=RexaOhzl/n60WHZmDIeclUYG1Sz3PSL9LDzqIfsrVzTUE2y/PmAifk5XtfFfRspv+X
 8PxtByGB4fL0XVXfFa5hPpSR5RnFdRvjOXyNS9dfwaUe90rmuoKLjDq3z/9ELEFfbLTe
 gQshreOM75DxlX77Tn4zowmh9DnYXtfqIKWQHlF+Enrb/FB7Ztyb+W8cxqLsLdm1RrpY
 d+U1qXsdMAiTNwg/1+f2xKx0TpFBYPK817Gwe8gLj1liTqMqvQyzjUCKg+bj/l520syJ
 MFmwYWlNp4gAHIeeF6Ucs5zu9qnQMhleUkLMcaZiXUc3KKFkVjdYNJzdbFmm4tTb9lBC
 OpiA==
X-Gm-Message-State: AOAM5316fVZvnEbXie42Y+S3QZSXzsMCpK5xUGXVpS0gpG2OliL4p/3v
 yPFi32wMKTxtc60tF8yz/+9V0R07MYErZtBgNxdeOUixdPjGcGskCOIXEsLU+RzvG73DeT2GALT
 6bxyxFHOBCQgNHrU=
X-Received: by 2002:a1c:b6d5:: with SMTP id g204mr2982192wmf.65.1603201180410; 
 Tue, 20 Oct 2020 06:39:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxKSCkn1DH2hJiSsSPFRlpWYR7I8rQRi7jOVxx10O4cB2vNpI0K/M6q109lDxJnt+iv1PkRg==
X-Received: by 2002:a1c:b6d5:: with SMTP id g204mr2982173wmf.65.1603201180214; 
 Tue, 20 Oct 2020 06:39:40 -0700 (PDT)
Received: from localhost (trasno.trasno.org. [83.165.45.250])
 by smtp.gmail.com with ESMTPSA id e5sm2988171wrw.93.2020.10.20.06.39.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 06:39:39 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Bihong Yu <yubihong@huawei.com>
Subject: Re: [PATCH v3 8/8] migration: Delete redundant spaces
In-Reply-To: <1603163448-27122-9-git-send-email-yubihong@huawei.com> (Bihong
 Yu's message of "Tue, 20 Oct 2020 11:10:48 +0800")
References: <1603163448-27122-1-git-send-email-yubihong@huawei.com>
 <1603163448-27122-9-git-send-email-yubihong@huawei.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Tue, 20 Oct 2020 15:39:38 +0200
Message-ID: <87tuupaued.fsf@secure.mitica>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=quintela@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: quintela@redhat.com
Cc: zhengchuan@huawei.com, qemu-trivial@nongnu.org, armbru@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, alex.chen@huawei.com,
 wanghao232@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Bihong Yu <yubihong@huawei.com> wrote:
> Signed-off-by: Bihong Yu <yubihong@huawei.com>
> Reviewed-by: Chuan Zheng <zhengchuan@huawei.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


