Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80A6C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 07:55:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76BB9207DD
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 07:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AtWzWgQ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76BB9207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWxqg-0004cq-NM
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 03:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jWxq2-0003lB-K7
 for qemu-devel@nongnu.org; Fri, 08 May 2020 03:54:30 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47413
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jWxq1-00076n-TM
 for qemu-devel@nongnu.org; Fri, 08 May 2020 03:54:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588924468;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NAMjKbRYdNAAToWeCEuKhA+ysXUvirXEE5By8fh7nAA=;
 b=AtWzWgQ65brpRuki7fwaXbZR4y6HtbILaISsQn2XRyMLgKBGh37ak7mIGn4j2G6wmJLZ9O
 DLxCU9+6IwmcY5gKfbTOBNz9+Sqf5abAKj/kw3h60Vtu/NMwbKSuiJqPm/0zQsVSeZnSJm
 iTsjYp6Y69mFdhSfhFIU1k+oPA0giLg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-1TA8Dw9tP32COY8aTq-EDA-1; Fri, 08 May 2020 03:54:26 -0400
X-MC-Unique: 1TA8Dw9tP32COY8aTq-EDA-1
Received: by mail-wm1-f69.google.com with SMTP id q77so156288wme.4
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 00:54:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
 :user-agent:reply-to:date:message-id:mime-version;
 bh=AZmvY8Fr1vZNmvLuliRjyUqYjS7EnO4RknuwiMbGnzk=;
 b=FTwed6nma72kf3CcT1moeas/nfCknCtkC0HBQbAxKI+iUs7oKMa8dwZzpGlft7V2Z7
 S5VoybEox8BHMB1VL/pu0gIHZx55FiVAyJ9hQ+lShHmh+lWC92RrPQgQ8pCVL6ANLR8T
 WOfPO6kmYRxfIH/sF+5z2ruEOGwOG/JLoJKuLYm/Yjiv+aBcbrHrw5EaKc60ki4bkkZf
 +fmbvRvV2psEydScbeYQdRm+w6RlA7nGmEe6r2D/HobSMvl6a/QBHdMoQzd43eHRS7zR
 x7EcGB2HrBNVBPvzzzGHXHM4O+ROmURblp911ssnHKXxjAB1BSvGm605FWF45a/+QOXe
 HmKw==
X-Gm-Message-State: AGi0PuaOfyz0OcGYGBiVRCWqrBac6u5buNBE7yRYICBWC8hfKbZWCvSx
 DZ7WHLOKNuIrOx9b0UIYRB7HoxdbrhYrIYurRQGOas8BjE0Y1V7nsuBsOmbI2U7W4Lx/PHBd7/r
 l5IkZGg46qaEtRpc=
X-Received: by 2002:a1c:9ad4:: with SMTP id
 c203mr14237742wme.126.1588924464890; 
 Fri, 08 May 2020 00:54:24 -0700 (PDT)
X-Google-Smtp-Source: APiQypJS68TvpAbDNl03YWrhRhzL2n1EDtrXyQyUAtacFcTB3t3YqhxbVH4b59V+B43OQao0RLu+bg==
X-Received: by 2002:a1c:9ad4:: with SMTP id
 c203mr14237720wme.126.1588924464664; 
 Fri, 08 May 2020 00:54:24 -0700 (PDT)
Received: from localhost (trasno.trasno.org. [83.165.45.250])
 by smtp.gmail.com with ESMTPSA id w18sm1668379wro.33.2020.05.08.00.54.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 00:54:24 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Pan Nengyuan <pannengyuan@huawei.com>
Subject: Re: [PATCH 2/2] migration/rdma: cleanup rdma context before g_free to
 avoid memleaks
In-Reply-To: <20200508100755.7875-3-pannengyuan@huawei.com> (Pan Nengyuan's
 message of "Fri, 8 May 2020 06:07:55 -0400")
References: <20200508100755.7875-1-pannengyuan@huawei.com>
 <20200508100755.7875-3-pannengyuan@huawei.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Fri, 08 May 2020 09:54:23 +0200
Message-ID: <874ksqhnf4.fsf@secure.mitica>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 02:25:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
> When error happen in initializing 'rdma_return_path', we should cleanup r=
dma context
> before g_free(rdma) to avoid some memleaks. This patch fix that.
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

Another good catch.


