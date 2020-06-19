Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663E9C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 11:51:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 301A720FC3
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 11:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hSgbfWPn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 301A720FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmFXx-0005tD-EZ
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 07:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jmFXB-0004u4-RF
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 07:50:13 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44005
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jmFX9-0004dQ-Ko
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 07:50:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592567411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2d6kYS4YMCQENlyr9kAT1TLtL+1ud1NYaXO56UzHkE8=;
 b=hSgbfWPn/muiP1Ngf/Wmi3GWRzlIILxWkK/SSj1Jr+vh087Gw3mR+ViBRp0TMgnoELKCWf
 tP8VdoZoFIPeuuKrGnX3pzgHSAEyQIT1qq8fosPglKyH7K7IQQN8NCwlpm8OFgSh9cO2/7
 mhEhwaFrjiuRiMiIawv05ukQZQX9Er0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-yW6SwygCOQOyDvSCH61deQ-1; Fri, 19 Jun 2020 07:50:09 -0400
X-MC-Unique: yW6SwygCOQOyDvSCH61deQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF22110059A1;
 Fri, 19 Jun 2020 11:50:07 +0000 (UTC)
Received: from work-vm (ovpn-114-215.ams2.redhat.com [10.36.114.215])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 135065BAD7;
 Fri, 19 Jun 2020 11:49:59 +0000 (UTC)
Date: Fri, 19 Jun 2020 12:49:57 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [Virtio-fs] [PATCH 0/2] virtiofsd: drop Linux capabilities(7)
Message-ID: <20200619114957.GG2690@work-vm>
References: <20200416164907.244868-1-stefanha@redhat.com>
 <20200618190816.GD3814@redhat.com> <20200618191655.GI2769@work-vm>
 <20200618192717.GE3814@redhat.com> <20200619082746.GA2690@work-vm>
 <20200619113914.GI700896@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200619113914.GI700896@redhat.com>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 01:50:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org, Vivek Goyal <vgoyal@redhat.com>,
 Miklos Szeredi <miklos@szeredi.hu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Daniel P. Berrangé (berrange@redhat.com) wrote:
> On Fri, Jun 19, 2020 at 09:27:46AM +0100, Dr. David Alan Gilbert wrote:
> > * Vivek Goyal (vgoyal@redhat.com) wrote:
> > > On Thu, Jun 18, 2020 at 08:16:55PM +0100, Dr. David Alan Gilbert wrote:
> > > > * Vivek Goyal (vgoyal@redhat.com) wrote:
> > > > > On Thu, Apr 16, 2020 at 05:49:05PM +0100, Stefan Hajnoczi wrote:
> > > > > > virtiofsd doesn't need of all Linux capabilities(7) available to root.  Keep a
> > > > > > whitelisted set of capabilities that we require.  This improves security in
> > > > > > case virtiofsd is compromised by making it hard for an attacker to gain further
> > > > > > access to the system.
> > > > > 
> > > > > Hi Stefan,
> > > > > 
> > > > > I just noticed that this patch set breaks overlayfs on top of virtiofs.
> > > > > 
> > > > > overlayfs sets "trusted.overlay.*" and xattrs in trusted domain
> > > > > need CAP_SYS_ADMIN.
> > > > > 
> > > > > man xattr says.
> > > > > 
> > > > >    Trusted extended attributes
> > > > >        Trusted  extended  attributes  are  visible and accessible only to pro‐
> > > > >        cesses that have the  CAP_SYS_ADMIN  capability.   Attributes  in  this
> > > > >        class are used to implement mechanisms in user space (i.e., outside the
> > > > >        kernel) which keep information in extended attributes to which ordinary
> > > > >        processes should not have access.
> > > > > 
> > > > > There is a chance that overlay moves away from trusted xattr in future.
> > > > > But for now we need to make it work. This is an important use case for
> > > > > kata docker in docker build.
> > > > > 
> > > > > May be we can add an option to virtiofsd say "--add-cap <capability>" and
> > > > > ask user to pass in "--add-cap cap_sys_admin" if they need to run daemon
> > > > > with this capaibility.
> > > > 
> > > > I'll admit I don't like the idea of giving it cap_sys_admin.
> > > > Can you explain:
> > > >   a) What overlayfs uses trusted for?
> > > 
> > > overlayfs stores bunch of metadata and uses "trusted" xattrs for it.
> > 
> > Tell me more about this metadata.
> > Taking a juicy looking one, what does OVL_XATTR_REDIRECT do?
> > Or what happens if I was to write random numbers into OVL_XATTR_NLINK?
> > 
> > > >   b) If something nasty was to write junk into the trusted attributes,
> > > >     what would happen?
> > > 
> > > This directory is owned by guest. So it should be able to write
> > > anything it wants, as long as process in guest has CAP_SYS_ADMIN, right?
> > 
> > Well, we shouldn't be able to break/crash/escape into the host; how
> > much does overlayfs validate trusted.* it uses?
> > 
> > > >   c) I see overlayfs has a fallback check if xattr isn't supported at
> > > > all - what is the consequence?
> > > 
> > > It falls back to I think read only mode. 
> > 
> > It looks like the fallback is more subtle to me:
> >         /*
> >          * Check if upper/work fs supports trusted.overlay.* xattr
> >          */
> >         err = ovl_do_setxattr(ofs->workdir, OVL_XATTR_OPAQUE, "0", 1, 0);
> >         if (err) {
> >                 ofs->noxattr = true;
> >                 ofs->config.index = false;
> >                 ofs->config.metacopy = false;
> >                 pr_warn("upper fs does not support xattr, falling back to index=off and metacopy=off.\n");
> > 
> > but I don't know what index and metacopy are.
> > 
> > > For a moment forget about overlayfs. Say a user process in guest with
> > > CAP_SYS_ADMIN is writing trusted.foo. Should that succeed? Is a
> > > passthrough filesystem, so it should go through. But currently it
> > > wont.
> > 
> > As long as any effects of what it writes are contained to the area of
> > the filesystem exposed to the guest, yes - however it worries me what
> > the consequences of broken trusted metadata is.  If it's delicate enough
> > that it's guarded by CAP_SYS_ADMIN someone must have worried about it.
> 
> The CAP_SYS_ADMIN requirement for 'trusted.' xattrs is simply a useful
> mechanism for applications to control access. The host kernel doesn'
> tuse this namespace itself. Linux has four namespaces for xattrs:
> 
>  -  user - for userspace apps. accessible based on read/write permissions
>  -  trusted - for userspace apps. accessible by CAP_SYS_ADMIN processes only
>  -  system - for kernel only. used by ACLs
>  -  security - for kernel only. used by SELinux
> 
> The use case for "trusted" xattrs is thus where a privileged management
> application or service wants to store metadata against the file, but
> also needs to grant an unprivileged process access to write to this file
> while not allowing that unprivileged process the ability to change the
> metadata. This is mentioned in the man page:
> 
> [man xattr(7)]
>    Trusted extended attributes
>        Trusted  extended attributes are visible and accessible only to pro‐
>        cesses that have the CAP_SYS_ADMIN capability.  Attributes  in  this
>        class  are used to implement mechanisms in user space (i.e., outside
>        the kernel) which keep information in extended attributes  to  which
>        ordinary processes should not have access.

overlayfs inside the kernel is using trusted though which is the case
Vivek ran into.

>    User extended attributes
>        User  extended  attributes  may be assigned to files and directories
>        for storing arbitrary additional information such as the mime  type,
>        character  set  or  encoding  of a file.  The access permissions for
>        user attributes are defined by the file permission bits:  read  per‐
>        mission is required to retrieve the attribute value, and writer per‐
>        mission is required to change it.
> [/man]
> 
> Libvirtd uses the "trusted." xattr namespace to record information against
> disk images for QEMU, because we need to grant QEMU access to read/write
> the disk iamges, but don't want QEMU to be able to alter our xattrs.
> 
> It is unfortunate that this namespace is tied to the CAP_SYS_ADMIN cap.
> It really ought to have had its own dedicated capability :-( Such is
> life with anything that uses CAP_SYS_ADMIN...
> 
> With this in mind we really should have both trusted. & user. xattrs
> allowed to the guest by default.
> 
> Conversely, we'll need to block usage of the security. and system.
> namespaces.
> 
> Unfortuntely this implies allowing CAP_SYS_ADMIN by default. We could
> have a "--trusted-xattrs=on|off" flag to allow people to run in a more
> locked down state if they knowingly want to block trusted xattrs.

Does the trick described by Chirantan work for you, where the clients
'trusted' view is different from the host?

Dave

> Regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


