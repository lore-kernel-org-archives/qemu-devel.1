Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF45C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 08:00:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 818DF2071E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 08:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GTHaqwvm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 818DF2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAqMR-0005X1-PF
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 04:00:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1kAqLn-00054H-ME
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 04:00:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24255
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1kAqLl-0003lW-0W
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 04:00:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598428803;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=N4T0rD7FLGEd7DCEpFX/xo0xsyGyFv7O4AnZ00sej04=;
 b=GTHaqwvmJyankST/gkXZqv3Nr3UZO4jZ1TdTfFbWg+ID6vW2pIVDB+DxEzA4CY8Gy7rA2K
 iI/U6ogdmjgNBhSx2LdMUIrVBqXlEgFxgBlrYsV18uXmzY/xtWT0x/Yatnomym00NOFLip
 3G1VzKu8lJ5LcwX/9CyIdOigOibO/ew=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-G3Qa6CN_Mq-Vrs-aRHkdUw-1; Wed, 26 Aug 2020 04:00:01 -0400
X-MC-Unique: G3Qa6CN_Mq-Vrs-aRHkdUw-1
Received: by mail-wr1-f72.google.com with SMTP id f14so219368wrm.22
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 01:00:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
 :user-agent:reply-to:date:message-id:mime-version;
 bh=N4T0rD7FLGEd7DCEpFX/xo0xsyGyFv7O4AnZ00sej04=;
 b=MKb5A5T7nYfaA9hF98Aws0sTfnLFXvSNKiqPrk8HRiu4dMf3ht0fOSVLALpfP2WSHs
 krRX3RMBg2BueHOwmIVU/kP8kwQivX4XADUdz/7hxSf+Ama8GegaG7U5+dUjcNv2AmLM
 icZ7rkfUZS0vVTBJzCeM/ljH3uzEKk01W5rW/FwS3JQ9E1xQ5WT+cJ5KD4901uiWNRmx
 MtmZtmdTjy1h0lefP2PPp8PaEejV0FnsyqxLuiVSZTetBX6sliSmLt6xhaSBhl301sLD
 8CjUcta97DrhhBULX33tnlUPqN4X/FLBJ3X5qJd8GjvhWXhYlWnbSPSNfDKoPw7roS2Z
 h2XA==
X-Gm-Message-State: AOAM531FlZBP3dCMZtbxxkVo/k0Eau+8lyz2fkehesMFMRxdGyKeIYxL
 3NvGBm9R+FNzH4QbuJ00j6donCZ1mqWueqcMmGPRzLg6T9X8d+pt04Rbto5LTpWlrhdSebX6LO8
 Bn8uIT1PSzgLB+F4=
X-Received: by 2002:a1c:c906:: with SMTP id f6mr6050330wmb.5.1598428800347;
 Wed, 26 Aug 2020 01:00:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwoaLh31ASNfzR907L2WydSKufcgMZe0iaYX2mTIn5ki/5ToLYb988gFA1izz8ss3CeERhZyw==
X-Received: by 2002:a1c:c906:: with SMTP id f6mr6050307wmb.5.1598428800156;
 Wed, 26 Aug 2020 01:00:00 -0700 (PDT)
Received: from localhost (trasno.trasno.org. [83.165.45.250])
 by smtp.gmail.com with ESMTPSA id c10sm3639975wrn.24.2020.08.26.00.59.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2020 00:59:59 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH v3 50/74] migration: Rename class type checking macros
In-Reply-To: <20200825192110.3528606-51-ehabkost@redhat.com> (Eduardo
 Habkost's message of "Tue, 25 Aug 2020 15:20:46 -0400")
References: <20200825192110.3528606-1-ehabkost@redhat.com>
 <20200825192110.3528606-51-ehabkost@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Wed, 26 Aug 2020 09:59:58 +0200
Message-ID: <874kopzvk1.fsf@secure.mitica>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=quintela@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.120; envelope-from=quintela@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 03:56:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Reply-To: quintela@redhat.com
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eduardo Habkost <ehabkost@redhat.com> wrote:
> Rename the macros to make them consistent with the MIGRATION_OBJ
> macro name.
>
> This will make future conversion to OBJECT_DECLARE* easier.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Changes series v2 -> v3: new patch added to series v3
>
> ---
> Cc: Juan Quintela <quintela@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: qemu-devel@nongnu.org

not used anywhere, so if it makes your life easier.

Reviewed-by: Juan Quintela <quintela@redhat.com>


