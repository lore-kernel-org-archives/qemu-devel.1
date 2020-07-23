Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E252AC433E4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 18:50:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9558206D8
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 18:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z12q9gc6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9558206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jygIy-0000Wn-0N
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 14:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jygIM-0008Qh-Nn
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 14:50:18 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54238
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jygIL-0004Ae-9p
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 14:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595530216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HnD39yyptQ/J2e8CM3yI4uwn4+wsB/omJnzB6Cv+SrI=;
 b=Z12q9gc6q8lFNp77YBVs047hBf1m8exy40ic2Xawepbag5wfTXs6RUNlzVq+kQV2K9gLsa
 pS/X+fu7P9BGrdKIknZwkhAfvHDsfc0xheDoc6XE5av5yRq3LHlIu1oFXAH0nfzCvpkGKk
 flQZoVYfXLqa9Jv0EGPUbNUtoiZ5Rig=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-HTPccE78NZuOTTc5TCaALg-1; Thu, 23 Jul 2020 14:50:14 -0400
X-MC-Unique: HTPccE78NZuOTTc5TCaALg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2ABC78015F3
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 18:50:13 +0000 (UTC)
Received: from localhost (unknown [10.10.67.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 825521009940;
 Thu, 23 Jul 2020 18:50:07 +0000 (UTC)
Date: Thu, 23 Jul 2020 14:50:06 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH 3/4] crypto: use QOM macros for declaration/definition of
 secret types
Message-ID: <20200723185006.GR1274972@habkost.net>
References: <20200723181410.3145233-1-berrange@redhat.com>
 <20200723181410.3145233-4-berrange@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200723181410.3145233-4-berrange@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:26:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 23, 2020 at 07:14:09PM +0100, Daniel P. Berrangé wrote:
> This introduces the use of the OBJECT_DEFINE and OBJECT_DECLARE macro
> families in the secret types, in order to eliminate boilerplate code.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  crypto/secret.c                 | 24 ++++--------------------
>  crypto/secret_common.c          | 32 +++++++++-----------------------
>  crypto/secret_keyring.c         | 28 +++++++++-------------------
>  include/crypto/secret.h         | 11 ++---------
>  include/crypto/secret_common.h  | 13 ++-----------
>  include/crypto/secret_keyring.h | 18 ++----------------
>  6 files changed, 28 insertions(+), 98 deletions(-)
> 

Beautiful.

I wonder how hard it would be to automate this.  I'm assuming
Coccinelle won't be able to deal with the macro definitions, but
a handwritten conversion script would be really useful for
dealing with our 1226 static TypeInfo structs.

-- 
Eduardo


