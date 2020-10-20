Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D1EC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 15:35:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19A0D2222D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 15:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="hreoy7lW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19A0D2222D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUtfE-0001oH-Pd
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 11:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kUteO-0001OX-8F
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:34:12 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:41055)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kUteL-0000if-JN
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:34:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=J6gMKf7XOQV00ib7UBa1JfAHyjXYmL1xDfwelyL6kZw=; b=hreoy7lW4rn2kxXthOsDBAZVJJ
 p48rI0HG4oSSbG36vK/MWEHxfpB8A1jvWLcMweFTN8fixFmGPnRCb/f2pILtN5sAMvsN/WRwC80hX
 Y/4T6BO6JlOO7A10/LimOgTeANymNUtoC/HhMFXRzVlJvTCgCsHjci/BcddL+Bxf4FLqOgnv7e6lW
 NtepVEKgeeRgximhPgLt3kZTmZoBTtWl83d0LSaKyIzDT1g54lfZxu5w7uxw0Vssa1jL6StbHEi5X
 vOwVitgvru6KAmudVsCHTgnQPMtoAGcFudIku6/y8nAclK5zbEybJVkH/xrXedo6UCmgLJ9DUqOGw
 1+x5WxkQ==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 1/5] tests/9pfs: Factor out do_fs_version() helper
Date: Tue, 20 Oct 2020 17:34:05 +0200
Message-ID: <3517148.drKrQmItIC@silver>
In-Reply-To: <160320666564.255209.11628044710614310582.stgit@bahia.lan>
References: <160320655763.255209.3890094487013964615.stgit@bahia.lan>
 <160320666564.255209.11628044710614310582.stgit@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 07:54:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Dienstag, 20. Oktober 2020 17:11:05 CEST Greg Kurz wrote:
> fs_version() is a top level test function. Factor out the sugar
> to a separate helper instead of hijacking it in other tests.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  tests/qtest/virtio-9p-test.c |   14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
> index c15908f27b3d..63f91aaf77e6 100644
> --- a/tests/qtest/virtio-9p-test.c
> +++ b/tests/qtest/virtio-9p-test.c
> @@ -567,10 +567,8 @@ static void v9fs_rflush(P9Req *req)
>      v9fs_req_free(req);
>  }
> 
> -static void fs_version(void *obj, void *data, QGuestAllocator *t_alloc)
> +static void do_fs_version(QVirtio9P *v9p)
>  {
> -    QVirtio9P *v9p = obj;
> -    alloc = t_alloc;
>      const char *version = "9P2000.L";
>      uint16_t server_len;
>      char *server_version;
> @@ -585,13 +583,19 @@ static void fs_version(void *obj, void *data,
> QGuestAllocator *t_alloc) g_free(server_version);
>  }

So the naming convention from now on shall be do_fs_*() for non-toplevel 
functions there. Not that I care too much about the precise prefix, but how 
about just do_*() for them instead?

Except of that, your patches look fine to me.

Best regards,
Christian Schoenebeck



