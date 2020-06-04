Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B31FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 12:05:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 430A4206E6
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 12:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jz1kPRL/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 430A4206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgocz-0006LI-I8
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 08:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jgocA-0005H7-E2
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 08:04:54 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20056
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jgoc8-0001eW-TK
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 08:04:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591272292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rl9+ikFJu0dGcOEeYN9Oj49ZutrG0D584XEtaFNMN54=;
 b=Jz1kPRL/DuazLmLuRVE5fVexcBkuKVC1Xhl0aI2rle6/XRLckUv9iPmcnDy29iFEPun8Fi
 kbf3bCzVjAeG8xQjoBZFKFCFV2M5X3jg7nIH/C55BNltYqzODDGl13Zr16RNxL4WicEoVf
 G0wdZJxSuuI5xg1mATL7jdkdMKaLpxo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-kZGKD6RINO-Eu5Sdo7RMoQ-1; Thu, 04 Jun 2020 08:04:48 -0400
X-MC-Unique: kZGKD6RINO-Eu5Sdo7RMoQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64F051005512;
 Thu,  4 Jun 2020 12:04:46 +0000 (UTC)
Received: from [10.3.113.22] (ovpn-113-22.phx2.redhat.com [10.3.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 74B4E60BF4;
 Thu,  4 Jun 2020 12:04:40 +0000 (UTC)
Subject: Re: [PATCH] iotests: 194: wait migration completion on target too
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200604083341.26978-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <c6bbfbd1-4a57-15ea-bf80-0ea5a1d81c64@redhat.com>
Date: Thu, 4 Jun 2020 07:04:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200604083341.26978-1-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:31:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: kwolf@redhat.com, fam@euphon.net, thuth@redhat.com, quintela@redhat.com,
 alex.bennee@linaro.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org, jsnow@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/4/20 3:33 AM, Vladimir Sementsov-Ogievskiy wrote:
> It is possible, that shutdown on target occurs earlier than migration
> finish. In this case we crash in bdrv_release_dirty_bitmap_locked()
> on assertion "assert(!bdrv_dirty_bitmap_busy(bitmap));" as we do have
> busy bitmap, as bitmap migration is ongoing.
> 
> We'll fix bitmap migration to gracefully cancel on early shutdown soon.
> Now let's fix iotest 194 to wait migration completion before shutdown.
> 
> Note that in this test dest_vm.shutdown() is called implicitly, as vms
> used as context-providers, see __exit__() method of QEMUMachine class.
> 
> Actually, not waiting migration finish is a wrong thing, but the test
> started to crash after commit ae00aa239847682
> "iotests: 194: test also migration of dirty bitmap", which added dirty
> bitmaps here. So, Fixes: tag won't hurt.
> 
> Fixes: ae00aa2398476824f0eca80461da215e7cdc1c3b
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   tests/qemu-iotests/194     | 10 ++++++++++
>   tests/qemu-iotests/194.out |  5 +++++
>   2 files changed, 15 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

Will queue through my NBD tree.

> 
> diff --git a/tests/qemu-iotests/194 b/tests/qemu-iotests/194
> index 3fad7c6c1a..6dc2bc94d7 100755
> --- a/tests/qemu-iotests/194
> +++ b/tests/qemu-iotests/194
> @@ -87,4 +87,14 @@ with iotests.FilePath('source.img') as source_img_path, \
>               iotests.log(dest_vm.qmp('nbd-server-stop'))
>               break
>   
> +    iotests.log('Wait migration completion on target...')

Do you mind if I s/Wait/Wait for/ here and in the .out?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


