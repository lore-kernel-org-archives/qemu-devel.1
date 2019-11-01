Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3ABECA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 17:10:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 742A3218AC
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 17:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c9aFcNfr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 742A3218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQaR6-0002pL-JS
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 13:10:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40517)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iQaQI-0002Mx-Cz
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 13:09:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iQaQF-0002YJ-75
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 13:09:16 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44912
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iQaQE-0002Wf-Ul
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 13:09:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572628153;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=owFfsAFfbx6xHmd5kz54mM3ND889MjNomTPtv5+jNbo=;
 b=c9aFcNfrw/LxeL4jOrLkHhwjHgbffxGvHQ2FNnSwzPpHjkryqhazA7JVBmj57NhTlZ4GCh
 tku3NZcRPPy7Zbk7rRMOEHhbXcUTsHnSOX1Dr7U2y2IcNq4Q3u2jW2mXqPhCmyeGOXzbDp
 BRl5ugPevQvzbKrrK+saUI5LROtLcH0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-9H84DV5NNGSPGEc7tGhhtg-1; Fri, 01 Nov 2019 13:09:08 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA108107ACC0;
 Fri,  1 Nov 2019 17:09:07 +0000 (UTC)
Received: from redhat.com (ovpn-112-25.ams2.redhat.com [10.36.112.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A479019C58;
 Fri,  1 Nov 2019 17:09:06 +0000 (UTC)
Date: Fri, 1 Nov 2019 18:09:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Subject: Re: Best practices to handle shared objects through qemu upgrades?
Message-ID: <20191101170903.GA13325@redhat.com>
References: <CAATJJ0KDOsA=Y+zLBT=PhcU0Q+gqRPSWkK0VaksisVC9_i5M_g@mail.gmail.com>
 <20191101093403.GE11296@redhat.com>
 <CAATJJ0JrJS108ehZ8VkcYvgeNXEqev8C5vf2a+31J1eJdZ92uA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAATJJ0JrJS108ehZ8VkcYvgeNXEqev8C5vf2a+31J1eJdZ92uA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 9H84DV5NNGSPGEc7tGhhtg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

On Fri, Nov 01, 2019 at 10:55:29AM +0100, Christian Ehrhardt wrote:
> On Fri, Nov 1, 2019 at 10:34 AM Daniel P. Berrang=C3=A9 <berrange@redhat.=
com> wrote:
> >
> > On Fri, Nov 01, 2019 at 08:14:08AM +0100, Christian Ehrhardt wrote:
> > > Hi everyone,
> > > we've got a bug report recently - on handling qemu .so's through
> > > upgrades - that got me wondering how to best handle it.
> > > After checking with Paolo yesterday that there is no obvious solution
> > > that I missed we agreed this should be brought up on the list for
> > > wider discussion.
> > > Maybe there already is a good best practise out there, or if it
> > > doesn't exist we might want to agree upon one going forward.
> > > Let me outline the case and the ideas brought up so far.
> > >
> > > Case
> > > - You have qemu representing a Guest
> > > - Due to other constraints e.g. PT you can't live migrate (which woul=
d
> > > be preferred)
> > > - You haven't used a specific shared object yet - lets say RBD storag=
e
> > > driver as example
> > > - Qemu gets an update, packaging replaces the .so files on disk
> > > - The Qemu process and the .so files on disk now have a mismatch in $=
buildid
> > > - If you hotplug an RBD device it will fail to load the (now new) .so
> >
> > What happens when it fails to load ?  Does the user get a graceful
> > error message or does QEMU abort ? I'd hope the former.
> >
>=20
> It is fortunately a graceful error message, here an example:
>=20
> $ virsh attach-device lateload curldisk.xml
> Reported issue happens on attach:
> root@b:~# virsh attach-device lateload cdrom-curl.xml
> error: Failed to attach device from cdrom-curl.xml
> error: internal error: unable to execute QEMU command 'device_add':
> Property 'virtio-blk-device.drive' can't find value
> 'drive-virtio-disk2'

Ok, that's graceful, but horrifically useless as an error message :-)

I'd like to think there would be a way to do better.

It looks like the 'drive-add' (or whatever we run to add the
backend) is failing, and then we blindly run device_add anyway.

This means either there's some error message printed that we
are missing, or QEMU is not reporting it back to the monitor.
Either way, I think this can be improved so that libvirt can
directly report the message you found hidden in the log:

>=20
> In the qemu output log we can see:
> Failed to initialize module: /usr/lib/x86_64-linux-gnu/qemu/block-curl.so
> Note: only modules from the same build can be loaded.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


