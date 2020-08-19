Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FC9C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 17:54:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F17A2067C
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 17:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="doLrdGg8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F17A2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8SI6-000771-8Q
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 13:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k8SGo-0005mz-UZ
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 13:53:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33060)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k8SGl-0005T5-W3
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 13:53:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597859582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jg7Yv7lFqJYSD9HRAZ0MrDEHbHUtPKjCBrfhZnhhLW4=;
 b=doLrdGg81Omjy5ohTeo8MO+LJDBcMRclpUhlkFJJGH9khnRpTVrniRXCgTn+cJCSlU6+w4
 NgyJIsiXXJxbBGW8MWLTAjK0q7W3MyBIISgWAdN10MLXQRhV8lEKGo9YHkFe8W6A5ZtIwO
 EaawrsgVpZ3bvWBdG6rMxczLK/NCV4A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-PsMWIMFWNWCKdFUBwv6hZA-1; Wed, 19 Aug 2020 13:52:58 -0400
X-MC-Unique: PsMWIMFWNWCKdFUBwv6hZA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E8E21885D82;
 Wed, 19 Aug 2020 17:52:57 +0000 (UTC)
Received: from [10.3.112.136] (ovpn-112-136.phx2.redhat.com [10.3.112.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C6A97E337;
 Wed, 19 Aug 2020 17:52:56 +0000 (UTC)
Subject: Re: [PATCH v3] block/nbd: use non-blocking connect: fix vm hang on
 connect()
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200812145237.4396-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <8e5f317f-e9f5-10a1-839f-27e2a083c933@redhat.com>
Date: Wed, 19 Aug 2020 12:52:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200812145237.4396-1-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 06:57:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/12/20 9:52 AM, Vladimir Sementsov-Ogievskiy wrote:
> This make nbd connection_co to yield during reconnects, so that
> reconnect doesn't hang up the main thread. This is very important in
> case of unavailable nbd server host: connect() call may take a long
> time, blocking the main thread (and due to reconnect, it will hang
> again and again with small gaps of working time during pauses between
> connection attempts).
> 

> How to reproduce the bug, fixed with this commit:
> 
> 1. Create an image on node1:
>     qemu-img create -f qcow2 xx 100M
> 
> 2. Start NBD server on node1:
>     qemu-nbd xx
> 
> 3. Start vm with second nbd disk on node2, like this:
> 
>    ./x86_64-softmmu/qemu-system-x86_64 -nodefaults -drive \
>      file=/work/images/cent7.qcow2 -drive file=nbd+tcp://192.168.100.2 \
>      -vnc :0 -qmp stdio -m 2G -enable-kvm -vga std

Where is the configuration to set up retry on the nbd connection?  I 
wonder if you have a non-upstream patch that turns it on by default in 
your builds; for upstream, I would have expected something more along 
the lines of -blockdev 
driver=nbd,reconnect-delay=20,server.type=inet,server.data.hostname=192.168.100.2,server.data.port=10809 
(typing off the top of my head, rather than actually tested).

> 
> 4. Access the vm through vnc (or some other way?), and check that NBD
>     drive works:
> 
>     dd if=/dev/sdb of=/dev/null bs=1M count=10
> 
>     - the command should succeed.
> 
> 5. Now, let's trigger nbd-reconnect loop in Qemu process. For this:
> 
> 5.1 Kill NBD server on node1
> 
> 5.2 run "dd if=/dev/sdb of=/dev/null bs=1M count=10" in the guest
>      again. The command should fail and a lot of error messages about
>      failing disk may appear as well.

Why does the guest access fail when the server goes away?  Shouldn't the 
pending guest requests merely be queued for retry (where the guest has 
not seen a failure yet, but may do so if timeouts are reached), rather 
than being instant errors?

> 
>      Now NBD client driver in Qemu tries to reconnect.
>      Still, VM works well.
> 
> 6. Make node1 unavailable on NBD port, so connect() from node2 will
>     last for a long time:
> 
>     On node1 (Note, that 10809 is just a default NBD port):
> 
>     sudo iptables -A INPUT -p tcp --dport 10809 -j DROP
> 
>     After some time the guest hangs, and you may check in gdb that Qemu
>     hangs in connect() call, issued from the main thread. This is the
>     BUG.
> 
> 7. Don't forget to drop iptables rule from your node1:
> 
>     sudo iptables -D INPUT -p tcp --dport 10809 -j DROP
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


