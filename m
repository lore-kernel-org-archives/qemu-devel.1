Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA49C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 08:38:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 684A220826
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 08:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GawXPQpf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 684A220826
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrHDW-00046I-O0
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 04:38:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jrHCr-0003E2-R1
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 04:38:01 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39178
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jrHCo-00076b-Pt
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 04:38:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593765477;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RsGI1XE4tmsFurs1pv9cfaNLQbcA4+IY+c0l6yIZwJQ=;
 b=GawXPQpfvsh2j8zCRHO/QTZmLbJvPzpjBbKjrqXn0UFO6t0VUCnVAq8sHFfLpIuA/udOG6
 FCQOKJ/PLnnjCjJlol8Gn76RyshtpZqLx4j38mf/VawHjxaaEaUl/RM0GibeYPFLTwfmZz
 QUb6j2wTEpopkBFi9Mkz1YYc5QFt2Vo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-n2qEXaN4NlKk5KZqLb4XEA-1; Fri, 03 Jul 2020 04:37:53 -0400
X-MC-Unique: n2qEXaN4NlKk5KZqLb4XEA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6C4E1940920;
 Fri,  3 Jul 2020 08:37:52 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E3D9C1001268;
 Fri,  3 Jul 2020 08:37:48 +0000 (UTC)
Date: Fri, 3 Jul 2020 09:37:45 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 6/6] migration: support picking vmstate disk in QMP
 snapshot commands
Message-ID: <20200703083745.GB2213227@redhat.com>
References: <20200702175754.2211821-1-berrange@redhat.com>
 <20200702175754.2211821-7-berrange@redhat.com>
 <a4aacccc-3761-591c-637d-1e0110a6c337@redhat.com>
MIME-Version: 1.0
In-Reply-To: <a4aacccc-3761-591c-637d-1e0110a6c337@redhat.com>
User-Agent: Mutt/1.14.3 (2020-06-14)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 03:17:33
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 02, 2020 at 01:19:43PM -0500, Eric Blake wrote:
> On 7/2/20 12:57 PM, Daniel P. Berrangé wrote:
> > This wires up support for a new "vmstate" parameter to the QMP commands
> > for snapshots (savevm, loadvm). This parameter accepts block driver
> > state node name.
> > 
> > One use case for this would be a VM using OVMF firmware where the
> > variables store is the first snapshottable disk image. The vmstate
> > snapshot usually wants to be stored in the primary root disk of the
> > VM, not the firmeware varstore. Thus there needs to be a mechanism
> 
> firmware
> 
> > to override the default choice of disk.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> 
> > +++ b/qapi/migration.json
> > @@ -1630,6 +1630,7 @@
> >   # @tag: name of the snapshot to create. If it already
> >   # exists it will be replaced.
> >   # @exclude: list of block device node names to exclude
> > +# @vmstate: block device node name to save vmstate to
> >   #
> >   # Note that execution of the VM will be paused during the time
> >   # it takes to save the snapshot
> > @@ -1641,6 +1642,7 @@
> >   # -> { "execute": "savevm",
> >   #      "data": {
> >   #         "tag": "my-snap",
> > +#         "vmstate": "disk0",
> >   #         "exclude": ["pflash0-vars"]
> >   #      }
> >   #    }
> > @@ -1650,6 +1652,7 @@
> >   ##
> >   { 'command': 'savevm',
> >     'data': { 'tag': 'str',
> > +            '*vmstate': 'str',
> >               '*exclude': ['str'] } }
> 
> During save, the list of block devices is obvious: everything that is not
> excluded.  But,
> 
> >   ##
> > @@ -1659,6 +1662,7 @@
> >   #
> >   # @tag: name of the snapshot to load.
> >   # @exclude: list of block device node names to exclude
> > +# @vmstate: block device node name to load vmstate from
> >   #
> >   # Returns: nothing
> >   #
> > @@ -1667,6 +1671,7 @@
> >   # -> { "execute": "loadvm",
> >   #      "data": {
> >   #         "tag": "my-snap",
> > +#         "vmstate": "disk0",
> >   #         "exclude": ["pflash0-vars"]
> >   #      }
> >   #    }
> > @@ -1676,6 +1681,7 @@
> >   ##
> >   { 'command': 'loadvm',
> >     'data': { 'tag': 'str',
> > +            '*vmstate': 'str',
> >               '*exclude': ['str'] } }
> 
> ...now that we support exclusion during saving, or even without exclusion
> but when the user has performed hotplug/unplug operations in the meantime
> from when the snapshot was created, isn't load better off listing all
> devices which SHOULD be restored, rather than excluding devices that should
> NOT be restored?  (After all, libvirt knows which disks existed at the time
> of the snapshot, which may be different than the set of disks that exist now
> even though we are throwing out the state now to go back to the state at the
> time of the snapshot)

If the user has hotplugged / unplugged any devices, then I expect the
snapshot load to fail, because the vmstate will be referencing devices
that don't exist, or will be missing devices. Same way migration will
fail unless target QEMU has exact same device setup that was first
serialized into the vmstate

In theory I guess you could have kept device ABI the same, but switched
out disk backends, but I question the sanity of doing that while you have
saved snapshots, unless you're preserving those snapshots in the new
images in which case it will just work.

> Then there's the question of symmetry: if load needs an explicit list of
> blocks to load from (rather than the set of blocks that are currently
> associated with the machine), should save also take its list by positive
> inclusion rather than negative exclusion?

I choose exclusion because the normal case is that you want to snapshot
everything. You sometimes have a small number of exceptions, most notably
the OVMF varstore. IOW if you're currently relying on default behaviour
of snapshotting everything, it is much easier to just exclude one image
and than to switch to explicitly including everything. Essentially I can
just pass a static string associated with the varstore to be excluded,
instead of having to dynamically build up a list of everything.

I wouldn't mind supporting inclusion *and* exclusion, so users have the
choice of which approach to take.

> And why does delvm not need to specify which block is the vmstate? delvm is
> in the same boat as loadvm - the set of blocks involved at the time of the
> snapshot creation may be different than the set of blocks currently
> associated with the guest at the time you run load/delvm.

There's no code in delvm that needs to take any special action wrt
vmstate. It simply deletes snapshots from all the disks present.

> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


