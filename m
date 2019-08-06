Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025E6C433FF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 13:02:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB74E20C01
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 13:02:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB74E20C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huz6R-0005if-Pi
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 09:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52482)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <claudio.fontana@suse.com>) id 1huz5b-0005HE-O2
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 09:01:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <claudio.fontana@suse.com>) id 1huz5W-0001rX-T9
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 09:01:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:41370 helo=mx1.suse.de)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <claudio.fontana@suse.com>)
 id 1huz5U-0001mm-Pn
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 09:01:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id EBC8CB048;
 Tue,  6 Aug 2019 13:01:04 +0000 (UTC)
To: Jan Kiszka <jan.kiszka@web.de>
References: <d938a62c-7538-9d2b-cc0a-13b240ab9141@web.de>
From: Claudio Fontana <claudio.fontana@suse.com>
Message-ID: <2587815f-e4eb-1f44-0b2d-5b77e3337553@suse.de>
Date: Tue, 6 Aug 2019 15:01:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <d938a62c-7538-9d2b-cc0a-13b240ab9141@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic]
X-Received-From: 195.135.220.15
Subject: Re: [Qemu-devel] [PATCH v2] ivshmem-server: Clean up shmem on
 shutdown
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/5/19 7:54 AM, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> So far, the server leaves the posix shared memory object behind when
> terminating, requiring the user to explicitly remove it in order to
> start a new instance.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> Changes in v2:
>  - respect use_shm_open
>  - also clean up in ivshmem_server_start error path
> 
>  contrib/ivshmem-server/ivshmem-server.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/contrib/ivshmem-server/ivshmem-server.c b/contrib/ivshmem-server/ivshmem-server.c
> index 77f97b209c..88daee812d 100644
> --- a/contrib/ivshmem-server/ivshmem-server.c
> +++ b/contrib/ivshmem-server/ivshmem-server.c
> @@ -353,6 +353,9 @@ ivshmem_server_start(IvshmemServer *server)
>  err_close_sock:
>      close(sock_fd);
>  err_close_shm:
> +    if (server->use_shm_open) {
> +        shm_unlink(server->shm_path);
> +    }
>      close(shm_fd);
>      return -1;
>  }
> @@ -370,6 +373,9 @@ ivshmem_server_close(IvshmemServer *server)
>      }
> 
>      unlink(server->unix_sock_path);
> +    if (server->use_shm_open) {
> +        shm_unlink(server->shm_path);
> +    }
>      close(server->sock_fd);
>      close(server->shm_fd);
>      server->sock_fd = -1;
> --
> 2.16.4
> 
> 

Reviewed-by: Claudio Fontana <claudio.fontana@suse.com>


