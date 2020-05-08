Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D32DC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 07:53:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E89A9206D6
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 07:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AktNmhsL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E89A9206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWxpE-0002kv-6V
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 03:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jWxoV-0001uE-2f
 for qemu-devel@nongnu.org; Fri, 08 May 2020 03:52:55 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56818
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jWxoT-0002xE-U1
 for qemu-devel@nongnu.org; Fri, 08 May 2020 03:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588924372;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e5rttwtc7QPbcgx3LldJ/eNEER2Dh0Qgc5U/vdYxk7w=;
 b=AktNmhsLgay2/XbfMlX0EPjyN2b82vQcgUdpkJsSViExPqoER2AUR+B+1CmWbNE+faFP3Y
 tMAGEGFgqlonMOjmIeUBBBpP2P1fS5h9whpn+9WJ4lePPbyz+GbKrW8RmAVMu3lNiHQQPp
 Xn7ky07iBLZdjSX/DILOUDp5DjBMjvo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-YjJtQzDiMmaLTTDFx1RnlA-1; Fri, 08 May 2020 03:52:50 -0400
X-MC-Unique: YjJtQzDiMmaLTTDFx1RnlA-1
Received: by mail-wm1-f72.google.com with SMTP id q5so4789563wmc.9
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 00:52:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
 :user-agent:reply-to:date:message-id:mime-version;
 bh=bH8VtUpZCkOolqd91suCkPfFrJGGQ2ojZYhUKdJDNiU=;
 b=D3fSyjZV401uRnHC55K3Q2OSVATfBq+U0bpO3pDffffr09+TfQPmHWVds8m3It1qAL
 RmwIMt7H528oeC0I2ATJmw4TAxoOJjd80ZBuCr1yDZa9UqidkHAUFZ1/6SMj3vBeuU2J
 B3O0tOk792NuurIpAtNB33sZHhK6xoj7b1rmtg0T0QCssCN0xGVhWpxIkfmFxNqcIHfV
 qzrf/UfljcPPnc8XBuJxgMYV7rtrYWQUYk3Cu855Bij5hXpnwTHHOzM1TTjgInxZ2i1o
 Nsl7W6DI6Hryaa8ly7PQ0bTuYnV4MZEH18DjXrOMpW+ltRfxc5myzCQsJqxp11cE0c7I
 cGaw==
X-Gm-Message-State: AGi0PuYszfkYxSKHZErTAsImKukyP+QYnaccIjuaj+8GjH2uLiyhbjG0
 fy/omvRkBgYLMO2/iZEFRmfAwYgCR2R1cOwid3uMdnj6cKw1IgImRWSgvTi9IVWcN63/6Ciiksf
 qaFD6Nzk6D48FWMI=
X-Received: by 2002:a05:600c:230f:: with SMTP id
 15mr11753252wmo.101.1588924369377; 
 Fri, 08 May 2020 00:52:49 -0700 (PDT)
X-Google-Smtp-Source: APiQypIOIMmnglmoEBtjpuGND0FHTTux16pfGr8iOW7Zu5ZsmHTm/pp83L+p8zCGed64ztZhcBuM4Q==
X-Received: by 2002:a05:600c:230f:: with SMTP id
 15mr11753221wmo.101.1588924369046; 
 Fri, 08 May 2020 00:52:49 -0700 (PDT)
Received: from localhost (trasno.trasno.org. [83.165.45.250])
 by smtp.gmail.com with ESMTPSA id q2sm29097wrx.60.2020.05.08.00.52.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 00:52:48 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Pan Nengyuan <pannengyuan@huawei.com>
Subject: Re: [PATCH 1/2] migration/rdma: fix potential nullptr access in
 rdma_start_incoming_migration
In-Reply-To: <20200508100755.7875-2-pannengyuan@huawei.com> (Pan Nengyuan's
 message of "Fri, 8 May 2020 06:07:54 -0400")
References: <20200508100755.7875-1-pannengyuan@huawei.com>
 <20200508100755.7875-2-pannengyuan@huawei.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Fri, 08 May 2020 09:52:46 +0200
Message-ID: <878si2hnht.fsf@secure.mitica>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 01:34:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: zhang.zhanghailiang@huawei.com, euler.robot@huawei.com, dgilbert@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pan Nengyuan <pannengyuan@huawei.com> wrote:
> 'rdma' is NULL when taking the first error branch in rdma_start_incoming_=
migration.
> And it will cause a null pointer access in label 'err'. Fix that.
>
> Fixes: 59c59c67ee6b0327ae932deb303caa47919aeb1e
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

good catch.


