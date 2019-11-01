Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87EACA9ED0
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 09:36:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8798E218AC
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 09:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IRj39rwk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8798E218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQTLg-0003Ot-Ct
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 05:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35856)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iQTK2-0002Wx-Dz
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 05:34:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iQTJy-0002b4-Hl
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 05:34:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31188
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iQTJy-0002Mx-5M
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 05:34:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572600854;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZSsFrCUF0k++AHPqPC9Xue0/dre3Y8SNz6MsQf1dCsY=;
 b=IRj39rwkkOwU6LBZtbsxHQnTMdzCMawcZADoAcmBxZGfsNs4z1eXqQxGnE+ifKA+OgjvfB
 dxjPa2JX2U0r1b86zqNL9bWB1dLW+EDobpMP9Hokcwr1zRJVwv68oQtVPVW1X/mrlm11oc
 LEyCXnonO2zwj/7hypkl7LTdphYbYAo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-rj1w2tA2MUigO2ehv5ML7w-1; Fri, 01 Nov 2019 05:34:10 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD047801E7E;
 Fri,  1 Nov 2019 09:34:09 +0000 (UTC)
Received: from redhat.com (ovpn-112-45.ams2.redhat.com [10.36.112.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9924F1001281;
 Fri,  1 Nov 2019 09:34:06 +0000 (UTC)
Date: Fri, 1 Nov 2019 10:34:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Subject: Re: Best practices to handle shared objects through qemu upgrades?
Message-ID: <20191101093403.GE11296@redhat.com>
References: <CAATJJ0KDOsA=Y+zLBT=PhcU0Q+gqRPSWkK0VaksisVC9_i5M_g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAATJJ0KDOsA=Y+zLBT=PhcU0Q+gqRPSWkK0VaksisVC9_i5M_g@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: rj1w2tA2MUigO2ehv5ML7w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 01, 2019 at 08:14:08AM +0100, Christian Ehrhardt wrote:
> Hi everyone,
> we've got a bug report recently - on handling qemu .so's through
> upgrades - that got me wondering how to best handle it.
> After checking with Paolo yesterday that there is no obvious solution
> that I missed we agreed this should be brought up on the list for
> wider discussion.
> Maybe there already is a good best practise out there, or if it
> doesn't exist we might want to agree upon one going forward.
> Let me outline the case and the ideas brought up so far.
>=20
> Case
> - You have qemu representing a Guest
> - Due to other constraints e.g. PT you can't live migrate (which would
> be preferred)
> - You haven't used a specific shared object yet - lets say RBD storage
> driver as example
> - Qemu gets an update, packaging replaces the .so files on disk
> - The Qemu process and the .so files on disk now have a mismatch in $buil=
did
> - If you hotplug an RBD device it will fail to load the (now new) .so

What happens when it fails to load ?  Does the user get a graceful
error message or does QEMU abort ? I'd hope the former.

>=20
> On almost any other service than "qemu representing a VM" the answer
> is "restart it", some even re-exec in place to keep things up and
> running.
>=20
> Ideas so far:
> a) Modules are checked by build-id, so keep them in a per build-id dir on=
 disk
>   - qemu could be made looking preferred in -$buildid dir first
>   - do not remove the packages with .so's on upgrades
>   - needs a not-too-complex way to detect which buildids running qemu pro=
cesses
>     have for packaging to be able to "autoclean later"
>   - Needs some dependency juggling for Distro packaging but IMHO can be m=
ade
>     to work if above simple "probing buildid of running qemu" would exist

So this needs a bunch of special QEMU hacks in package mgmt tools
to prevent the package upgrade & cleanup later. This does not look
like a viable strategy to me.

>=20
> b) Preload the modules before upgrade
>   - One could load the .so files before upgrade
>   - The open file reference will keep the content around even with the
> on disk file gone
>   - lacking a 'load-module' command that would require fake hotplugs
> which seems wrong
>   - Required additional upgrade pre-planning
>   - kills most benefits of modular code without an actual need for it
> being loaded

Well there's two benefits to modular approach

 - Allow a single build to be selectively installed on a host or container
   image, such that the install disk footprint is reduced
 - Allow a faster startup such that huge RBD libraries dont slow down
   startup of VMs not using RBD disks.

Preloading the modules before upgrade doesn't have to the second benefit.
We just have to make sure the pre loading doesn't impact the VM startup
performance.

IOW, register a SIGUSR2 handler which preloads all modules it finds on
disk. Have a pre-uninstall option on the .so package that sends SIGUSR2
to all QEMU processes. The challenge of course is that signals are
async. You might suggest a QMP command, but only 1 process can have the
QMP monitor open at any time and that's libvirt. Adding a second QMP
monitor instance is possible but kind of gross for this purpose.

Another option would be to pre-load the modules during startup, but
do it asynchronously, so that its not blocking overall VM startup.
eg just before starting the mainloop, spawn a background thread to
load all remaining modules.

This will potentially degrade performance of the guest CPUs a bit,
but avoids the latency spike from being synchronous in the startup
path.


> c) go back to non modular build
>   - No :-)
>=20
> d) anything else out there?

e) Don't do upgrades on a host with running VMs :-)

   Upgrades can break the running VM even ignoring this particular
   QEMU module scenario.=20

f) Simply document that if you upgrade with running VMs that some
   features like hotplug of RBD will become unavialable. Users can
   then avoid upgrades if that matters to them.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


