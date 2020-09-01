Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD237C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 21:06:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A44A9206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 21:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UBjBFZ2k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A44A9206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDDUM-0006sE-Rn
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 17:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kDDTL-0005zi-EO
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 17:05:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24697
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kDDTJ-0000pU-RN
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 17:05:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598994341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xORFC1as1KQ6Pol7M21VvQKUC3hR2jQ7vAJIcyMNB4E=;
 b=UBjBFZ2kkuHXotIh+E41GZVdCW1dlXHb5i/r/zbihiV64l8CXxMTndeUK/MhYZ94QR0oi9
 PiBMD3h/VitnB9fDzBkpQo+ZqP3j8qtrANLdFyILRTbSZORA+HV2E1YvOFqRuPb8Y60ruC
 RH7bdlhHmYeYdw8AZ9eAoyMMWXGiirw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-jAPQ7NEOPBiFb6HESx9ZTw-1; Tue, 01 Sep 2020 16:44:05 -0400
X-MC-Unique: jAPQ7NEOPBiFb6HESx9ZTw-1
Received: by mail-qk1-f200.google.com with SMTP id t1so1828148qkh.13
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 13:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=xORFC1as1KQ6Pol7M21VvQKUC3hR2jQ7vAJIcyMNB4E=;
 b=Q87JcZK3KIzVTlnPQ6dEOT2oJpOzqmW+iMTmd6Qr9LzvwFK2L8dZJ/nqb/KNeurpWD
 Mvnw5QepijoyScRQOJGi4/ibP84zRAgfgrKsQ16CD7+augojtyMTRwQSXiUW2kd6sAGo
 nDVHp7kw+BTghjbB0ruapRh78ETDGB9/nzaEyb8/Fmu9UaI7addcaKl93iMe6xNOCb1Q
 5CNPspuNEK5kgV0aYL36hYNwq1HF1te243U1zlBeMsDsVNK1fDe8XkfswZyD5mkJLKmK
 L0HydLmrTI6NJMEoEQoUXpYNqoOAghwlPa3BDW5QYDUdNq0jHmtlcMaMJccV1PIDlzGs
 i9zw==
X-Gm-Message-State: AOAM531L0YGIOSfqH9AsAo+5tS4PAZ7JYVoI8nCMhaRPa/YU4jtWzUj3
 lpNW+U5RkRF0MO1y9sU2STOrZHXGJaFdmssbHtftw8WXy7V4/kuHG0H1vrtEx6oWc6c8W3JG+N5
 X79GU0wr8JSAJ/C0=
X-Received: by 2002:a0c:a342:: with SMTP id u60mr3828780qvu.2.1598993045332;
 Tue, 01 Sep 2020 13:44:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHg3deF/TKGTfey+7WeLuexBLJoOZHUGYC8+GK0f+yuOXPVxjY6HBEhJ5iR04iivaUTqMhiA==
X-Received: by 2002:a0c:a342:: with SMTP id u60mr3828740qvu.2.1598993045014;
 Tue, 01 Sep 2020 13:44:05 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca.
 [70.53.122.15])
 by smtp.gmail.com with ESMTPSA id x49sm3032800qtc.94.2020.09.01.13.44.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 13:44:04 -0700 (PDT)
Date: Tue, 1 Sep 2020 16:44:02 -0400
From: Peter Xu <peterx@redhat.com>
To: Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: [RFC v8 1/5] memory: Rename memory_region_notify_one to
 memory_region_notify_iommu_one
Message-ID: <20200901204402.GC3053@xz-x1>
References: <20200901142608.24481-1-eperezma@redhat.com>
 <20200901142608.24481-2-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200901142608.24481-2-eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 05:11:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org,
 Jason Wang <jasowang@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Avi Kivity <avi@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 01, 2020 at 04:26:04PM +0200, Eugenio Pérez wrote:
> Previous name didn't reflect the iommu operation.
> 
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


