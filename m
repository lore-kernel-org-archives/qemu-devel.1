Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34B4C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 08:49:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C17120707
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 08:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cWuL8+SD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C17120707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joNZk-0007LS-Tu
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 04:49:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1joNYy-0006iY-13
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 04:48:52 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50645
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1joNYu-00053f-Li
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 04:48:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593074926;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=CmlO7666TNnFLC5KxTo9YBS2mHUYsvnS8/RiKZpoENo=;
 b=cWuL8+SD6IkvXE4Ish+zk9zQ/6B87tlKmm336e54P/7b4MQ1esZPyIOn/5abmo+78sVDpd
 PyrZuOHszrc9bl82d+VIwnqjLs2q6S+B0aEoF5B8OmSq1/Ic+bEjmqsXjgRxlH1h/QKXQ+
 XMNcX/vP5PBId/mBbh0+UFqC8ZHrWMw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-jL57gyvfNkmaQ3qj7HTmUw-1; Thu, 25 Jun 2020 04:48:44 -0400
X-MC-Unique: jL57gyvfNkmaQ3qj7HTmUw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F06C108BD1B;
 Thu, 25 Jun 2020 08:48:43 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.27])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 80E375BAC0;
 Thu, 25 Jun 2020 08:48:38 +0000 (UTC)
Date: Thu, 25 Jun 2020 09:48:35 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH] net: tap: check if the file descriptor is valid before
 using it
Message-ID: <20200625084835.GB1009994@redhat.com>
References: <20200624190009.300069-1-lvivier@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200624190009.300069-1-lvivier@redhat.com>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 00:45:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Stefan Weil <sw@weilnetz.de>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 24, 2020 at 09:00:09PM +0200, Laurent Vivier wrote:
> qemu_set_nonblock() checks that the file descriptor can be used and, if
> not, crashes QEMU. An assert() is used for that. The use of assert() is
> used to detect programming error and the coredump will allow to debug
> the problem.
> 
> But in the case of the tap device, this assert() can be triggered by
> a misconfiguration by the user. At startup, it's not a real problem, but it
> can also happen during the hot-plug of a new device, and here it's a
> problem because we can crash a perfectly healthy system.

If the user/mgmt app is not correctly passing FDs, then there's a whole
pile of bad stuff that can happen. Checking whether the FD is valid is
only going to catch a small subset. eg consider if fd=9 refers to the
FD that is associated with the root disk QEMU has open. We'll fail to
setup the TAP device and close this FD, breaking the healthy system
again. 

I'm not saying we can't check if the FD is valid, but lets be clear that
this is not offering very much protection against a broken mgmt apps
passing bad FDs.

> For instance:
>  # ip link add link virbr0 name macvtap0 type macvtap mode bridge
>  # ip link set macvtap0 up
>  # TAP=/dev/tap$(ip -o link show macvtap0 | cut -d: -f1)
>  # qemu-system-x86_64 -machine q35 -device pcie-root-port,id=pcie-root-port-0 -monitor stdio 9<> $TAP
>  (qemu) netdev_add type=tap,id=hostnet0,vhost=on,fd=9
>  (qemu) device_add driver=virtio-net-pci,netdev=hostnet0,id=net0,bus=pcie-root-port-0
>  (qemu) device_del net0
>  (qemu) netdev_del hostnet0
>  (qemu) netdev_add type=tap,id=hostnet1,vhost=on,fd=9
>  qemu-system-x86_64: .../util/oslib-posix.c:247: qemu_set_nonblock: Assertion `f != -1' failed.
>  Aborted (core dumped)
> 
> To avoid that, check the file descriptor is valid before passing it to qemu_set_non_block() for
> "fd=" and "fds=" parameters.
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  include/qemu/sockets.h |  1 +
>  net/tap.c              | 13 +++++++++++++
>  util/oslib-posix.c     |  5 +++++
>  util/oslib-win32.c     |  6 ++++++
>  4 files changed, 25 insertions(+)
> 
> diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
> index 57cd049d6edd..5b0c2d77ddad 100644
> --- a/include/qemu/sockets.h
> +++ b/include/qemu/sockets.h
> @@ -17,6 +17,7 @@ int qemu_socket(int domain, int type, int protocol);
>  int qemu_accept(int s, struct sockaddr *addr, socklen_t *addrlen);
>  int socket_set_cork(int fd, int v);
>  int socket_set_nodelay(int fd);
> +bool qemu_fd_is_valid(int fd);
>  void qemu_set_block(int fd);
>  void qemu_set_nonblock(int fd);
>  int socket_set_fast_reuse(int fd);
> diff --git a/net/tap.c b/net/tap.c
> index 6207f61f84ab..f65966aaccd8 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -795,6 +795,12 @@ int net_init_tap(const Netdev *netdev, const char *name,
>              return -1;
>          }
>  
> +        /* Check if fd is valid */
> +        if (!qemu_fd_is_valid(fd)) {
> +            error_setg(errp, "Invalid file descriptor %d", fd);
> +            return -1;
> +        }
> +
>          qemu_set_nonblock(fd);
>  
>          vnet_hdr = tap_probe_vnet_hdr(fd);
> @@ -843,6 +849,13 @@ int net_init_tap(const Netdev *netdev, const char *name,
>                  goto free_fail;
>              }
>  
> +            /* Check if fd is valid */
> +            if (!qemu_fd_is_valid(fd)) {
> +                error_setg(errp, "Invalid file descriptor %d", fd);
> +                ret = -1;
> +                goto free_fail;
> +            }
> +
>              qemu_set_nonblock(fd);
>  
>              if (i == 0) {
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index 916f1be2243a..8d5705f598d3 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -244,6 +244,11 @@ void qemu_anon_ram_free(void *ptr, size_t size)
>      qemu_ram_munmap(-1, ptr, size);
>  }
>  
> +bool qemu_fd_is_valid(int fd)
> +{
> +    return fcntl(fd, F_GETFL) != -1;
> +}
> +
>  void qemu_set_block(int fd)
>  {
>      int f;
> diff --git a/util/oslib-win32.c b/util/oslib-win32.c
> index e9b14ab17847..a6be9445cfdb 100644
> --- a/util/oslib-win32.c
> +++ b/util/oslib-win32.c
> @@ -132,6 +132,12 @@ struct tm *localtime_r(const time_t *timep, struct tm *result)
>  }
>  #endif /* CONFIG_LOCALTIME_R */
>  
> +bool qemu_fd_is_valid(int fd)
> +{
> +    /* FIXME: how to check if fd is valid? */
> +    return true;
> +}
> +
>  void qemu_set_block(int fd)
>  {
>      unsigned long opt = 0;
> -- 
> 2.26.2
> 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


