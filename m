Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEEAC4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:04:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01E892076B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QphenA4r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01E892076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY8Xn-00029P-VR
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 10:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kY8W9-0001Xr-Ex
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 10:03:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24478)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kY8W7-0002lw-9z
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 10:03:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603980180;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eQzNBOY8ilO/44EOmvQhkM9HfkI7hZ2Cgl4ksgNihJE=;
 b=QphenA4rO5eQ74Si3cv44ohasmiPM4V7ETCGsBRitr+vYNZ3emet2DwhgWc2hW1VQBt/Eb
 GRUC0f2NA0Mz3X0YY7nFv0a0rRNhHN7aex30/MZ3ajtMQQC0BiGza4YjQF5cC0as0jPi6X
 Slnpv/HTLIBmdXgOQF6NPK6hi64mgQU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-FEyLwYx3NSm1WKkORoziig-1; Thu, 29 Oct 2020 10:02:51 -0400
X-MC-Unique: FEyLwYx3NSm1WKkORoziig-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2B17107B47C;
 Thu, 29 Oct 2020 14:02:50 +0000 (UTC)
Received: from redhat.com (ovpn-115-62.ams2.redhat.com [10.36.115.62])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D897D5D9EF;
 Thu, 29 Oct 2020 14:02:45 +0000 (UTC)
Date: Thu, 29 Oct 2020 14:02:42 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: Our abstract UNIX domain socket support is a mess
Message-ID: <20201029140242.GE27369@redhat.com>
References: <87o8kmwmjh.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87o8kmwmjh.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 01:47:28
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
Cc: xiaoqiang zhao <zxq_yx_007@163.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 28, 2020 at 01:41:06PM +0100, Markus Armbruster wrote:
> Commit 776b97d360 "qemu-sockets: add abstract UNIX domain socket
> support" (v5.1) has made a mess.
> 
> First, what are abstract UNIX domain sockets?  They use a separate
> "abstract" namespace which is independent of the filesystem.  This is a
> non-portable Linux extension.  See unix(7).
> 
> Traditional pathname sockets have a zero-terminated string in
> sockaddr_un member sun_path.  Abstract sockets have a binary blob
> starting with a 0 byte.  Works, because the empty string is not a valid
> pathname.
> 
> This interface is a hack.  The leading 0 byte is ugly.  The size of the
> blob is given by the socklen_t argument passed with the struct
> sockaddr_un.  People use strings, then forget to either cut the length
> to the size of the string, or pad to the blob to sizeof(sockaddr_un),
> and do it consistently.
> 
> QEMU's interface is differently messy.
> 
> Our equivalent to struct sockaddr_un is QAPI type UnixSocketAddress:
> 
>     { 'struct': 'UnixSocketAddress',
>       'data': {
>         'path': 'str' }
> 
> @path corresponds to sockaddr_un member sun_path.  sun_family = AF_UNIX
> and socklen_t sizeof(sockaddr_un) are implied.
> 
> We didn't repurpose @path for abstract sockets like the Linux kernel did
> with sun_path.  Instead, we added a flag @abstract (default false).
> When it's on, we make a binary blob by prefixing @path with a 0 byte,
> and pad it with more 0 bytes.
> 
> We added a second flag @tight (default true) to optionally cut the
> socklen_t to the end of the string (the terminating 0 byte is not
> included).
> 
> Six revisions were posted, and the QAPI maintainers were cc'ed on none
> of them.  I spotted @tight in the pull request by chance, and found it
> odd.  I inquired, and Daniel explained:
> 
>     In the abstract namespace the length of the socket is critical
>     information. ie
> 
>        "\0foo" (length == 4,  tight=true)
> 
>     is a completely different socket from
> 
>        "\0foo\0..repeated...\0" (length == sizeof(sun_path), tight=false)
> 
>     In theory you can have any length in between those extremes,
>     each being a different socket, but in practice no one is that
>     insane. Apps either use the full length, or the minimal
>     length. The "tight" terminology is copied from "socat" which
>     uses this same option name
> 
>     Message-ID: <87imgqr8g9.fsf@dusky.pond.sub.org>
>     https://lists.nongnu.org/archive/html/qemu-devel/2020-05/msg05812.html
> 
> I did not press further, or dig deeper.  I should have.  I did only when
> Kevin reported @tight's default is backward in QMP.  I'm not liking what
> I found.
> 
> 
> Issue#1: our interface is differently ugly, for no good reason
> 
> Like the Linux kernel, we also appropriate existing @path for abstract
> sockets.  With less excuse, though; we could have created a neater
> interface, easily.
> 
> Unlike the Linux kernel, we don't do blobs.  In other words, our variant
> of the hack is not general.

The Linux kernel interface is low level and not the way any userspace
application exposes the use of abstract sockets. No one wants to
specify an abstract socket by listing all 108 characters with many
trailing nuls. It would be insane to do this.

There are two ways userspace apps expose abstract socket config.

Either using a leading "@" as a magic substitute for NUL and not
supporting a coibfigurable way to distinguish truncated vs full
length, just define the desired behaviour for their app. THis is
what dbus does to denote its abstract socket paths.

Or, just or by having  explicit flags "abstract" and "tight" to
control the behaviour.  The latter is what 'socat' does to allow
use of abstract sockets.

For QEMU the former approach gives broad interoperabiltiy with
userspace applications, so made more sense than using magic "@".


> Elsewhere in QMP, we use base64 for blobs.
> 
> Aside: QMP can do embedded 0 bytes.  It represents them as overlong
> UTF-8 “\xC0\x80", though.
> 
> Not sure the interface is worth fixing now.  Abstract sockets are niche.
> In my opinion, we should've said no.

The interface doesn't need fixing - the way it is represented in
QEMU is much saner than the low level struct sockaddr_un representation
used to talk to the kernel, and is common with other userspace apps.

The use case is to enable interoperability with other apps that use
an abstract socket.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


