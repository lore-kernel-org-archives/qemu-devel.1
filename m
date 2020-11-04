Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1F8C388F9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:50:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF58D206DB
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OJteehWh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF58D206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaLzr-0001um-Q5
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 11:50:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kaLy3-0008MB-Br
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 11:49:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40613)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kaLy1-00032v-BT
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 11:49:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604508539;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=oOBBjOJbRzpNdrN7W7dL6v1phJT5u9k+w6PXLN/K3v8=;
 b=OJteehWhpX6WRlJUEoa2LHBTGLK15eatsNgEBirXPepQ1k1o4P7e9CuJk4EsZFVUj0Bmsb
 5fo2bHFyDbOYyjC5D4g8ejCAxEc6uqDFl5KBMNr8T2Z816LTC/Prqs8prami8GEt8I6kHO
 bXdBxL8MXVdvy+yhnlR8ni2VZcc43Dk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-oAEMGbFYOn-NZVH_U0afQA-1; Wed, 04 Nov 2020 11:48:57 -0500
X-MC-Unique: oAEMGbFYOn-NZVH_U0afQA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB8D787951B;
 Wed,  4 Nov 2020 16:48:56 +0000 (UTC)
Received: from redhat.com (ovpn-112-222.ams2.redhat.com [10.36.112.222])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B71F19D6C;
 Wed,  4 Nov 2020 16:48:55 +0000 (UTC)
Date: Wed, 4 Nov 2020 16:48:53 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Masayoshi Mizuma <msys.mizuma@gmail.com>
Subject: Re: locking option doesn't work as expected
Message-ID: <20201104164853.GM565323@redhat.com>
References: <20201104163556.ifevmhkj4bw6iuc2@gabell>
MIME-Version: 1.0
In-Reply-To: <20201104163556.ifevmhkj4bw6iuc2@gabell>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 04, 2020 at 11:35:56AM -0500, Masayoshi Mizuma wrote:
> Hello,
> 
> It seems that locking option doesn't work as expected.
> When I run qemu as following options, then I got an error and failed to
> boot the guest:
> 
>   qemu-system-x86_64 \
>     -machine pc \
>     -enable-kvm \
>     -cpu host \
>     -smp 1 -m 4G \
>     -nographic \
>     -serial telnet::1235,server,nowait \
>     -blockdev driver=qcow2,node-name=disk,file.driver=file,file.filename=/mnt/guest.qcow2,file.locking=auto \
>     -device virtio-blk-pci,scsi=off,drive=disk,id=virtio-disk0,bootindex=1
> 
>   qemu-system-x86_64: -blockdev driver=qcow2,node-name=disk,file.driver=file,file.filename=/mnt/guest.qcow2,file.locking=auto: Failed to lock byte 100
> 
> The error happens when the filesystem doesn't support OFD lock.
> qemu_probe_lock_ops() judges whether qemu can use OFD lock or not with doing
> fcntl(F_OFD_GETLK) to /dev/null, so the error happens if /dev/null supports OFD lock,
> but the filesystem doesn't support the lock.
> 
> I'm thinking how to fix the error. My idea is to add locking=posix option to use posix
> lock to the file, but I'm not sure the idea is good way to fix the error...
> 
> I would appreciate it if you could give me some advises to fix the error.

Ideally we would not attempt to probe it on /dev/null at all. Instead just
attempt to lock the actual file using F_OFD_SETLK and if that fails, then
falback to F_SETLK.  We can do similar when checking whether the lock
currently exists. AFAIK, the locking code isn't so performance critical
that the extra syscall would hurt us in the case where OFD doesn't exist
or isn't supported by the FS.

> 
> BTW, locking=off may be useful for the workaround so far, however, locking=off
> doesn't work on the splitting blockdev configs as followings...
> I split the blockdev option as libvirt doing.
> 
>    -blockdev driver=file,filename=/mnt/guest.qcow2,node-name=storage,auto-read-only=on,locking=off \
>    -blockdev node-name=format,read-only=off,driver=qcow2,file=storage \
> 
> Thanks,
> Masa
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


