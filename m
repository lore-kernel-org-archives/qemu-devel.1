Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9A6C433E6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:00:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C614207EA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WtzuZ0yU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C614207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDNge-0000WX-Uq
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 04:00:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1kDNfy-0008Hp-Iy
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 03:59:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36277)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1kDNfx-0000VF-2L
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 03:59:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599033564;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YV3NQUQAY0GZvYY7CxxjxslcuZmbu0ufWYt10L2O9Mc=;
 b=WtzuZ0yUcdQsfGzpCvGvqmGC5ocp3N5uXkkJZ6ZuNopkxq+9jA3Fi9bIrhl7TZNyhtbEtP
 5qfV0Ew7+PgPYzzRdWdbr3Qnbrv00nayhWWkeTT6ftG/Ea08oPFldOQ2S7ZkyVHYYJyDmf
 OFG7g6I36AwZMDvOmVNekHjHUHRRXDA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-KbCmlxNmNK-lWVFZyHr6dw-1; Wed, 02 Sep 2020 03:59:20 -0400
X-MC-Unique: KbCmlxNmNK-lWVFZyHr6dw-1
Received: by mail-wr1-f69.google.com with SMTP id n15so1617067wrv.23
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 00:59:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
 :user-agent:reply-to:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YV3NQUQAY0GZvYY7CxxjxslcuZmbu0ufWYt10L2O9Mc=;
 b=KVXB4/NNz6dWYDIH2Se7FzpC37I/zM0OE99+FFIgFQ42fInHhJo2JvH65EzmGo4W5y
 m7THwfknWboyjFeTmgJC9jRVJXMTZHDQrcO/qRdnKsFQLm6qXRFYbmAHgTARHP18Q4IU
 bUXIyOK8ttW8hkf+PxTRt6roEGNa5b5t501HxgDWv+xTg1TEAdMtiP3zcKyQApi2W0hV
 aBHYpmJmYDxr9HZcUVs5zooowcUaKYqF5XsMn+0PI2iakrANo1KLendVKpZkrK/MItwY
 xGz8i6DDo2NMiho5ukQ//Iyyd+mn9O6x3pIjsFe1ohNyMjtfg4MibKbQf7XHhdqp5SJ2
 wNOw==
X-Gm-Message-State: AOAM532iUV1n9xVGukHPD3jgK6D/HVfHwN7yMcfTFSkJNVg5N9Z2+yk5
 eBKCtsnL4d3sGhYNrUlRilcgZD8lRR9X0kNrO+eW8xHQvF1sG9bfeeKKvmIcnA7BM9KuP9djymQ
 YaO5rCYrsbSG6Npk=
X-Received: by 2002:a05:6000:ce:: with SMTP id
 q14mr5773088wrx.112.1599033559796; 
 Wed, 02 Sep 2020 00:59:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxrTMvwVhPTm+kzo9PMrz9BWVz8bDIrvl4/tf5JGhTWMLhPdmCv/WWYs3NpqUfIOp1seRSDng==
X-Received: by 2002:a05:6000:ce:: with SMTP id
 q14mr5773056wrx.112.1599033559614; 
 Wed, 02 Sep 2020 00:59:19 -0700 (PDT)
Received: from localhost (trasno.trasno.org. [83.165.45.250])
 by smtp.gmail.com with ESMTPSA id e18sm6660832wra.36.2020.09.02.00.59.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2020 00:59:18 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Eugenio =?utf-8?Q?P=C3=A9rez?= <eperezma@redhat.com>
Subject: Re: [RFC v8 5/5] memory: Skip bad range assertion if notifier is
 DEVIOTLB type
In-Reply-To: <20200901142608.24481-6-eperezma@redhat.com> ("Eugenio
 =?utf-8?Q?P=C3=A9rez=22's?=
 message of "Tue, 1 Sep 2020 16:26:08 +0200")
References: <20200901142608.24481-1-eperezma@redhat.com>
 <20200901142608.24481-6-eperezma@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Wed, 02 Sep 2020 09:59:18 +0200
Message-ID: <871rjkr4mh.fsf@secure.mitica>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=quintela@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 01:13:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, =?utf-8?Q?Herv=C3=A9?= Poussineau <hpoussin@reactos.org>,
 Avi Kivity <avi@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eugenio P=C3=A9rez <eperezma@redhat.com> wrote:
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


