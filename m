Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6006BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:57:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F44320578
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PskhA306"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F44320578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsiTX-0006xU-D8
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 03:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jsiSz-0006Nv-PR
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:56:37 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58715
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jsiSx-0003JN-KJ
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:56:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594108593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jJ0D+WGztChdkFOWw0OUe19B5bJAmSA/l7KTuXB9tb4=;
 b=PskhA306uOfsnUvRHexVJxM4VGyqqcpXtVjo5cX2a8PAmXZM/OcjK73HVkPhkrqHkUvuwZ
 MB6kPgVRDPi6oh8/+P165Z5sqHRzYEzUwGLIqLsro6S97/gp2UCMPnqgYDGaaDN6uOFUFZ
 5qZeGLcUzJ6e5Ji1E0S9q4ws1XLNvXE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-O5vtAdniP0eZYJ79Zd72wA-1; Tue, 07 Jul 2020 03:56:32 -0400
X-MC-Unique: O5vtAdniP0eZYJ79Zd72wA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C71AA0C00;
 Tue,  7 Jul 2020 07:56:31 +0000 (UTC)
Received: from [10.72.13.254] (ovpn-13-254.pek2.redhat.com [10.72.13.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DBB2071674;
 Tue,  7 Jul 2020 07:56:25 +0000 (UTC)
Subject: Re: [PATCH v3 1/2] net: tap: check if the file descriptor is valid
 before using it
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
References: <20200701193951.36248-1-lvivier@redhat.com>
 <20200701193951.36248-2-lvivier@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c6ad433e-7327-4fcb-180c-e161919c0aa3@redhat.com>
Date: Tue, 7 Jul 2020 15:56:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200701193951.36248-2-lvivier@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:31:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Markus Armbruster <armbru@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/7/2 上午3:39, Laurent Vivier wrote:
> +void qemu_set_nonblock(int fd)
> +{
> +    int f;
> +    f = qemu_try_set_nonblock(fd);
> +    assert(f == 0);
>   }


So we keep this assert which means it can still be triggered from monitor?

I don't check all the callers, but I got:

in tap_init_one() we had:

         if (vhostfdname) {
             vhostfd = monitor_fd_param(cur_mon, vhostfdname, &err);
             if (vhostfd == -1) {
                 if (tap->has_vhostforce && tap->vhostforce) {
                     error_propagate(errp, err);
                 } else {
                     warn_report_err(err);
                 }
                 return;
             }
             qemu_set_nonblock(vhostfd);
         } else {

and in net_init_socket() we had:

     if (sock->has_fd) {
         int fd;

         fd = monitor_fd_param(cur_mon, sock->fd, errp);
         if (fd == -1) {
             return -1;
         }
         qemu_set_nonblock(fd);
         if (!net_socket_fd_init(peer, "socket", name, fd, 1, sock->mcast,
                                 errp)) {
             return -1;
         }
         return 0;
     }

Thanks


