Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7AFC2BB85
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 17:23:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAA45206C0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 17:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iA3gP3RC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAA45206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLrwF-0001hf-Pw
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 13:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59152)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wrampazz@redhat.com>) id 1jLrvc-00018t-Ph
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 13:22:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wrampazz@redhat.com>) id 1jLrvY-0001Fq-H0
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 13:22:24 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30222
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wrampazz@redhat.com>) id 1jLrvY-0001FM-Db
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 13:22:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586280139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+QHFISUFMZioHvbAh2EkJvxAWXgMmM/5OfSPbNFz+os=;
 b=iA3gP3RCTphuHigBcfdz+jwJJ4VnOcIsbVRK+LPesAb3cY4ZgFE7CNEedSoVTIxp08VyIF
 xChisB0BWdaioqfQ07KBN9Yl3xgXJoRlGCh/H6qnnsm9HA9mfxSLWiEwfKo63FqJy+lwnO
 qg7ecQRzW58X/B14aPGTFqz1GCrFbGI=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-yEuHGIgQPZeqkqAsDgqovg-1; Tue, 07 Apr 2020 13:22:17 -0400
X-MC-Unique: yEuHGIgQPZeqkqAsDgqovg-1
Received: by mail-ua1-f70.google.com with SMTP id 42so1510087uar.1
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 10:22:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BCwXd7FZr0OvckV+dnQE4FNqK7NKIbAioaAtM6VT0dY=;
 b=K88lHGgjimd1EwStP1Vel3poJHQugOJ+41xmocOlmSR+ZfYkv8j8v9ixelwa1/F6zp
 qlu7o0h+LwNcsh6Urh4zD8X5I3yYlo0gqKB3aU8bC1QRue33AulCFC+gHaKc8UTI8RFI
 zJO7eBLVI1pO5yDaC1L4fzCaVoTuvU+VDww6BvKH1DHr1VA5yWUNZVHskvx0FrbTjsOk
 +ZBtrkc01UpieTPF5XV2ro1Q1pJVwtUIAXb70tSn/Tqb+dqhCPWnFALVUyluHzNhImXq
 nfvWrihmw9jOoqCTWMWvbylGAcyEU4GGHHgpkKMbA47LVmq5+FRd7dOjCPJXAFnnfuJ0
 mfJw==
X-Gm-Message-State: AGi0PuZpFcuZxEtBvX77ITb/qG+rR5lQuEiNZSAFemPmi0d+McgrzZ2R
 mQ17Qvm46nQHDKGvSTYK2ixqTSsEtOJCxtNDxOZzt1hxMPY2VA9GmhxC85diN15pIn7MRtW+rVd
 ay/sakq9SmGc5uhocW/Xp9pxWfNc/cWk=
X-Received: by 2002:a1f:eb04:: with SMTP id j4mr2412726vkh.16.1586280137110;
 Tue, 07 Apr 2020 10:22:17 -0700 (PDT)
X-Google-Smtp-Source: APiQypIUdeIv/VHxlOBjv5xlUGloJ6Vi5nb9pN33BZK9U2Zfa1mRCuDVI9DoltSwVcBxIP0zdBuQ55QzcicGw2Z1wJU=
X-Received: by 2002:a1f:eb04:: with SMTP id j4mr2412698vkh.16.1586280136697;
 Tue, 07 Apr 2020 10:22:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200407155642.10716-1-ovoshcha@redhat.com>
 <20200407155642.10716-3-ovoshcha@redhat.com>
In-Reply-To: <20200407155642.10716-3-ovoshcha@redhat.com>
From: Willian Rampazzo <wrampazz@redhat.com>
Date: Tue, 7 Apr 2020 14:22:05 -0300
Message-ID: <CAKJDGDZ+1GF4SQoGRXFqzi_+Bd=rfbPeXfhxiM35NY2xOHtCQQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] Acceptance test: provides new functions
To: Oksana Vohchana <ovoshcha@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Philippe Mathieu Daude <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Wainer Moschetta <wainersm@redhat.com>,
 Cleber Rosa Junior <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Apr 7, 2020 at 1:07 PM Oksana Vohchana <ovoshcha@redhat.com> wrote:
>
> Provides new functions related to the rdma migration test
> Adds functions to check if service RDMA is enabled and gets
> the ip address on the interface where it was configured
>
> Signed-off-by: Oksana Vohchana <ovoshcha@redhat.com>
> ---
>  tests/acceptance/migration.py | 45 +++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>
> diff --git a/tests/acceptance/migration.py b/tests/acceptance/migration.p=
y
> index e4c39b85a1..1c3a684395 100644
> --- a/tests/acceptance/migration.py
> +++ b/tests/acceptance/migration.py
> @@ -11,12 +11,57 @@
>
>
>  import tempfile
> +import json
>  from avocado_qemu import Test
>  from avocado import skipUnless
>
>  from avocado.utils import network
>  from avocado.utils import wait
>  from avocado.utils.path import find_command
> +from avocado.utils.network.interfaces import NetworkInterface
> +from avocado.utils.network.hosts import LocalHost
> +from avocado.utils import service
> +from avocado.utils import process
> +
> +
> +def get_rdma_status():
> +    """Verify the status of RDMA service.
> +
> +    return: True if rdma service is enabled, False otherwise.
> +    """
> +    rdma_stat =3D service.ServiceManager()
> +    return bool(rdma_stat.status('rdma'))
> +
> +def get_interface_rdma():
> +    """Get the interface name where RDMA is configured.
> +
> +    return: The interface name or False if none is found
> +    """
> +    cmd =3D 'rdma link show -j'
> +    out =3D json.loads(process.getoutput(cmd))
> +    try:
> +        for i in out:
> +            if i['state'] =3D=3D 'ACTIVE':
> +                return i['netdev']
> +    except KeyError:
> +        pass
> +    return False
> +
> +def get_ip_rdma(interface):
> +    """Get the IP address on a specific interface.
> +
> +    :param interface: Network interface name
> +    :return: IP addresses as a list, otherwise will return False
> +    """
> +    local =3D LocalHost()
> +    network_in =3D NetworkInterface(interface, local)
> +    try:
> +        ip =3D network_in.get_ipaddrs()
> +        if ip:
> +            return ip
> +    except:
> +        pass
> +    return False
>
>
>  class Migration(Test):
> --
> 2.21.1
>
>

Reviewed-by: Willian Rampazzo <willianr@redhat.com>


