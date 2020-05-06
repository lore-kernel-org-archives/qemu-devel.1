Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BA0C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 14:52:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99E9A208D5
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 14:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gD0Nmxtm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E9A208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWLPt-0001ze-ON
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 10:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jWLPF-0001Sf-KF
 for qemu-devel@nongnu.org; Wed, 06 May 2020 10:52:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30035
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jWLPE-0007vg-Tq
 for qemu-devel@nongnu.org; Wed, 06 May 2020 10:52:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588776735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DxCdfoP6walpu2c95CR2opcTKivFRTpvGSc1hLEN5vw=;
 b=gD0Nmxtmul3zUhBLdJCi74XEpgCPrIXR7BRaK+szp7qy8FQEJKE8rn6qaf5LTcyP9cvV2q
 t0TXUuiPynlvWg9Sx6ViqXs/JakVi1KCR3PIQLdq5jdeErz0xPIBY8o8X10UCZXLj7fXuS
 k+AW9airczeAlArP6D+Gi5jB0WXO5Yg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258--KBD-Z0bNJ-sRC78dkPLzQ-1; Wed, 06 May 2020 10:52:14 -0400
X-MC-Unique: -KBD-Z0bNJ-sRC78dkPLzQ-1
Received: by mail-qt1-f198.google.com with SMTP id d8so32304qtq.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2020 07:52:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=15n+JDmbL9v6E9kdJssm0UrDxyQLVa/JQChEeJ9+QtY=;
 b=hMzQUif9QW8KyXP3pQL2li+tJRMJxqIw11wRWbA0iLzIUNyN+rXlYPeKHlnWheo6eT
 ManiAqIKl5gjxVYZXN5H2T4K+CxWxj1nujAbvZ30vBsbvQJbFPR9EDw83VKkpmWWx2ZA
 u9oFG7HZcP3gP+w8GBmJ0lxQDU8zC354rpkJ3rqTtQGPiYsuDmFJlTavBh0gmMaUUScH
 d+flzmVZ5J4deHZAJvBWYpKpgnA+oX51tZyX+UK3NJ4MnDicomH4t98n8Fir9mNko+lD
 6ykSW7xobTCSXKe1NNznaijOdvhw3nvuVzjQJJwWkgkOReaWiImOhwqvbMdMfeyw9MML
 J9Jw==
X-Gm-Message-State: AGi0PuYEKXZlu7Ame5rueCAOXpVZNmtQGSIQgjrb7cMMpFRjCZEhz3Bd
 tlZX0nl27BDIMd4dzSvIZKfi0I5oeUPICWO+pPa+xu6WjoTfSK9MdtbPctxLPqmNjpGpUfbVxiQ
 B7R4o5NpAuqUm2/s=
X-Received: by 2002:a05:620a:556:: with SMTP id
 o22mr6597697qko.434.1588776733812; 
 Wed, 06 May 2020 07:52:13 -0700 (PDT)
X-Google-Smtp-Source: APiQypIjeEOekEJ0cLyjTIqZg+/Lypnyw7g80yJaTbcpdMpnk4XYwoNTmAKjmYcOLw/1jrStCK402A==
X-Received: by 2002:a05:620a:556:: with SMTP id
 o22mr6597664qko.434.1588776733490; 
 Wed, 06 May 2020 07:52:13 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id u190sm1768924qkb.102.2020.05.06.07.52.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2020 07:52:12 -0700 (PDT)
Date: Wed, 6 May 2020 10:52:11 -0400
From: Peter Xu <peterx@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH RFC 2/4] migration: Introduce migrate_is_precopy()
Message-ID: <20200506145211.GK6299@xz-x1>
References: <20200428194219.10963-1-peterx@redhat.com>
 <20200428194219.10963-3-peterx@redhat.com>
 <20200506100549.GF2743@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200506100549.GF2743@work-vm>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 04:02:22
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tian Kevin <kevin.tian@intel.com>,
 qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 06, 2020 at 11:05:49AM +0100, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > Export a helper globally to check whether we're during a precopy.
> >=20
> > Signed-off-by: Peter Xu <peterx@redhat.com>
>=20
> Can you change this to 'migration_in_precopy' to match the existing
> 'migration_in_postcopy'.

Sure.

--=20
Peter Xu


