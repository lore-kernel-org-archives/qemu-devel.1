Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E78CC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 12:38:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B7F12073E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 12:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a87KbuKh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B7F12073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqFWo-0007B1-Hv
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 08:38:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43762)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jqFUD-0002tj-QX
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 08:35:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40662
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jqFUB-0004Nu-Em
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 08:35:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593520538;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VjzNX7EVTnOEQ/PGw9QxpAZQTg3JyP8TFTZzqq0sKSw=;
 b=a87KbuKhbqqiBshHQEgcUiadOE8IWfWCgC6EArWAXB3isrsrSkWWh77d9/+dh9o+hSMElG
 XkLrBjWhR358HrxGh/PtvKTmiQVm0zKwH/AEzjvg+ks82iPf1YSj17cHQ/4I4oB8PpNGUR
 MNq0zFZetOZNHmFehA2ZgekSgrI08UU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-Z7jS10tUPj60jDnwXyyLCA-1; Tue, 30 Jun 2020 08:35:27 -0400
X-MC-Unique: Z7jS10tUPj60jDnwXyyLCA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5D9A100CCC2;
 Tue, 30 Jun 2020 12:35:26 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 388CA2B6CF;
 Tue, 30 Jun 2020 12:35:20 +0000 (UTC)
Date: Tue, 30 Jun 2020 13:35:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH] net: tap: check if the file descriptor is valid before
 using it
Message-ID: <20200630123518.GL1370404@redhat.com>
References: <929203d2-20d2-7caf-e487-6bfe5b851974@redhat.com>
 <ea94fa3c-edb5-220e-e0e0-4b7fca7b90e8@redhat.com>
 <b912e24c-8dc5-7022-6ed2-cf10d72ef6e7@redhat.com>
 <20200630092318.GE1370404@redhat.com>
 <20200630093148.GF1370404@redhat.com>
 <247f4aa8-1846-c5ec-4fe3-1d344979ad52@redhat.com>
 <d24b43e9-5a8c-1cc0-9d1c-4ee01a8cbbca@redhat.com>
 <7a110325-0123-53da-604d-8a9374903782@redhat.com>
 <20200630110310.GG1370404@redhat.com>
 <0309d626-f0b6-faa6-cc90-fe0b8cbbb535@redhat.com>
MIME-Version: 1.0
In-Reply-To: <0309d626-f0b6-faa6-cc90-fe0b8cbbb535@redhat.com>
User-Agent: Mutt/1.14.3 (2020-06-14)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 00:34:33
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

On Tue, Jun 30, 2020 at 02:00:06PM +0200, Laurent Vivier wrote:
> On 30/06/2020 13:03, Daniel P. Berrangé wrote:
> > On Tue, Jun 30, 2020 at 12:35:46PM +0200, Laurent Vivier wrote:
> >> On 30/06/2020 12:03, Jason Wang wrote:
> >>>
> >>> On 2020/6/30 下午5:45, Laurent Vivier wrote:
> >>>> On 30/06/2020 11:31, Daniel P. Berrangé wrote:
> >>>>> On Tue, Jun 30, 2020 at 10:23:18AM +0100, Daniel P. Berrangé wrote:
> >>>>>> On Tue, Jun 30, 2020 at 05:21:49PM +0800, Jason Wang wrote:
> >>>>>>> On 2020/6/30 上午3:30, Laurent Vivier wrote:
> >>>>>>>> On 28/06/2020 08:31, Jason Wang wrote:
> >>>>>>>>> On 2020/6/25 下午7:56, Laurent Vivier wrote:
> >>>>>>>>>> On 25/06/2020 10:48, Daniel P. Berrangé wrote:
> >>>>>>>>>>> On Wed, Jun 24, 2020 at 09:00:09PM +0200, Laurent Vivier wrote:
> >>>>>>>>>>>> qemu_set_nonblock() checks that the file descriptor can be
> >>>>>>>>>>>> used and, if
> >>>>>>>>>>>> not, crashes QEMU. An assert() is used for that. The use of
> >>>>>>>>>>>> assert() is
> >>>>>>>>>>>> used to detect programming error and the coredump will allow
> >>>>>>>>>>>> to debug
> >>>>>>>>>>>> the problem.
> >>>>>>>>>>>>
> >>>>>>>>>>>> But in the case of the tap device, this assert() can be
> >>>>>>>>>>>> triggered by
> >>>>>>>>>>>> a misconfiguration by the user. At startup, it's not a real
> >>>>>>>>>>>> problem,
> >>>>>>>>>>>> but it
> >>>>>>>>>>>> can also happen during the hot-plug of a new device, and here
> >>>>>>>>>>>> it's a
> >>>>>>>>>>>> problem because we can crash a perfectly healthy system.
> >>>>>>>>>>> If the user/mgmt app is not correctly passing FDs, then there's
> >>>>>>>>>>> a whole
> >>>>>>>>>>> pile of bad stuff that can happen. Checking whether the FD is
> >>>>>>>>>>> valid is
> >>>>>>>>>>> only going to catch a small subset. eg consider if fd=9 refers
> >>>>>>>>>>> to the
> >>>>>>>>>>> FD that is associated with the root disk QEMU has open. We'll
> >>>>>>>>>>> fail to
> >>>>>>>>>>> setup the TAP device and close this FD, breaking the healthy
> >>>>>>>>>>> system
> >>>>>>>>>>> again.
> >>>>>>>>>>>
> >>>>>>>>>>> I'm not saying we can't check if the FD is valid, but lets be
> >>>>>>>>>>> clear that
> >>>>>>>>>>> this is not offering very much protection against a broken mgmt
> >>>>>>>>>>> apps
> >>>>>>>>>>> passing bad FDs.
> >>>>>>>>>>>
> >>>>>>>>>> I agree with you, but my only goal here is to avoid the crash in
> >>>>>>>>>> this
> >>>>>>>>>> particular case.
> >>>>>>>>>>
> >>>>>>>>>> The punishment should fit the crime.
> >>>>>>>>>>
> >>>>>>>>>> The user can think the netdev_del doesn't close the fd, and he
> >>>>>>>>>> can try
> >>>>>>>>>> to reuse it. Sending back an error is better than crashing his
> >>>>>>>>>> system.
> >>>>>>>>>> After that, if the system crashes, it will be for the good
> >>>>>>>>>> reasons, not
> >>>>>>>>>> because of an assert.
> >>>>>>>>> Yes. And on top of this we may try to validate the TAP via st_dev
> >>>>>>>>> through fstat[1].
> >>>>>>>> I agree, but the problem I have is to know which major(st_dev) we can
> >>>>>>>> allow to use.
> >>>>>>>>
> >>>>>>>> Do we allow only macvtap major number?
> >>>>>>>
> >>>>>>> Macvtap and tuntap.
> >>>>>>>
> >>>>>>>
> >>>>>>>> How to know the macvtap major number at user level?
> >>>>>>>> [it is allocated dynamically: do we need to parse /proc/devices?]
> >>>>>>>
> >>>>>>> I think we can get them through fstat for /dev/net/tun and
> >>>>>>> /dev/macvtapX.
> >>>>>> Don't assume QEMU has any permission to access to these device nodes,
> >>>>>> only the pre-opened FDs it is given by libvirt.
> >>>>> Actually permissions are the least of the problem - the device nodes
> >>>>> won't even exist, because QEMU's almost certainly running in a private
> >>>>> mount namespace with a minimal /dev populated
> >>>>>
> >>>> I'm working on a solution using /proc/devices.
> >>>
> >>>
> >>> Similar issue with /dev. There's no guarantee that qemu can access
> >>> /proc/devices or it may not exist (CONFIG_PROCFS).
> >>
> >> There is a lot of things that will not work without /proc (several tools
> >> rely on /proc, like ps, top, lsof, mount, ...). Some information are
> >> only available from /proc, and if /proc is there, I think /proc/devices
> >> is always readable by everyone. Moreover /proc is already used by qemu
> >> in several places.
> >>
> >> It can also a best effort check.
> >>
> >> The problem with fstat() on /dev files is to guess the /dev/macvtapX as
> >> X varies (the same with /dev/tapY)..
> >>
> >>>
> >>>> macvtap has its own major number, but tuntap use "misc" (10) major
> >>>> number.
> >>
> >> Another question: it is possible to use the "fd=" parameter with macvtap
> >> as macvtap creates a /dev/tapY device, but how to do that with tuntap
> >> that does not create a /dev/tapY device?
> > 
> > 
> > I think we should step back and ask why we need to check this at all.
> > 
> > IMHO, if the passed-in FD works with the syscalls that tap-linux.c
> > is executing, then that shows the FD is suitable for QEMU. The problem
> > is that many of the tap APIs don't use "Error **errp" parameters to
> > report errors, so we can't catch the failures. IOW, instead of checking
> > the FD major/minor number, we should make the existing code be better
> > at reporting errors, so they can be fed back to the QMP console
> > gracefully.
> 
> The problem here is the very first operation of net_init_tap() is a
> qemu_set_nonblock() that has an assert() and crashes QEMU.
> 
> It's why I was only checking for the validity of the file descriptor,
> not if it is a tap device or not.

Yep, checking that it is really a FD is sufficient to avoid the
assert in nonblock.

As for whether it is really a tap device, I think we just need to
improve error reporting of the functions that come later, instead
of doing a literal "is it a tap" check.

That's what I'd tried in my old patch from a few years back

   https://patchwork.kernel.org/patch/10029443/

I can't remember why we didn't merge this back then

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


