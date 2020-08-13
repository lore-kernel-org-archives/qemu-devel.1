Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695E0C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 20:21:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C2DA20791
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 20:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FnzmlAtz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C2DA20791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6JjJ-0006LO-DZ
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 16:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1k6Jik-0005uN-PW
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 16:21:06 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41518
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1k6Jig-0005VB-Kr
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 16:21:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597350060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UdQ4Ia0Wo56ZLfwSBE8QPPvralKE1hTBqrk9VtSWYkM=;
 b=FnzmlAtzMelQWAynSvSCsTZVoKkUgEsJdUonP7m7daP5ZFOpgvLnFS05nKD4Fav85IWfyt
 gWpcXnk4kmYH+oeLwA8TY+6zjv1E4p0smu6FVANJdHO48IFwFLsfW5yKf5Ul8jYGqFIhMy
 h0bpg8QfM1dbJA4NE9j7FRnmCOmD/fM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-iimAmIv5MAG7heeORJ-YOA-1; Thu, 13 Aug 2020 16:20:59 -0400
X-MC-Unique: iimAmIv5MAG7heeORJ-YOA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E04401DDE8;
 Thu, 13 Aug 2020 20:20:57 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-112-166.ams2.redhat.com
 [10.36.112.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 836EB5D9D2;
 Thu, 13 Aug 2020 20:20:49 +0000 (UTC)
Subject: Re: [PATCH] hw: virtio-gpu: remove duplicated 'virtqueue_pop'
To: Li Qiang <liq3ea@163.com>, mst@redhat.com, kraxel@redhat.com
References: <20200813153614.39917-1-liq3ea@163.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <47b9f12f-2874-1e1c-2fc1-7ea1a81cc401@redhat.com>
Date: Thu, 13 Aug 2020 22:20:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200813153614.39917-1-liq3ea@163.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 02:03:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: liq3ea@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/13/20 17:36, Li Qiang wrote:
> Just use 'while (true)' to avoid duplicated.
> No function change.
> 
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>  hw/display/virtio-gpu.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 5f0dd7c150..9cef313f5e 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -869,13 +869,15 @@ static void virtio_gpu_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
>      }
>  #endif
>  
> -    cmd = virtqueue_pop(vq, sizeof(struct virtio_gpu_ctrl_command));
> -    while (cmd) {
> +    while (true) {
> +        cmd = virtqueue_pop(vq, sizeof(struct virtio_gpu_ctrl_command));
> +        if (!cmd) {
> +            break;
> +        }
>          cmd->vq = vq;
>          cmd->error = 0;
>          cmd->finished = false;
>          QTAILQ_INSERT_TAIL(&g->cmdq, cmd, next);
> -        cmd = virtqueue_pop(vq, sizeof(struct virtio_gpu_ctrl_command));
>      }
>  
>      virtio_gpu_process_cmdq(g);
> 

There are (at least) three styles:

(1)

    thing = get_next();
    while (is_valid(thing)) {
        ...
        thing = get_next();
    }

(2)

    while (true) {
        thing = get_next();
        if (!is_valid(thing)) {
            break;
        }
        ...
     }

(3)

    while (is_valid(thing = get_next())) {
        ...
    }

My opinion:

- If the get_next() invocation is simple, then style (1) is perfectly fine.

- Style (2) is the worst of all.

- If style (1) is not appropriate for whatever reason, then style (3) is frequently a good replacement. Style (3) is sometimes rejected by coding style documents though. Style (3) is not usable if is_valid() is a function-like macro that does not evaluate its argument exactly once. Frequently, is_valid() is simply open-coded with C operators (using extra parens), for example:

    while ((cmd = virtqueue_pop(vq, sizeof(struct virtio_gpu_ctrl_command)))) {

or more verbosely

    while ((cmd = virtqueue_pop(vq, sizeof(struct virtio_gpu_ctrl_command))) !=
           NULL) {

If we really dislike style (1), then I'd propose style (3). I think the present patch (style (2)) is a step back.

Just my opinion of course; I don't feel too strongly about this.

Laszlo


