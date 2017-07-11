Received: from eggs.gnu.org ([2001:4830:134:3::10]:58360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dUvpu-000630-2U
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:08:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dUvpp-00019m-26
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:08:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58240)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dUvpo-00017h-Q4
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:08:16 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1DBBE5AFD9
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 14:08:15 +0000 (UTC)
Date: Tue, 11 Jul 2017 15:08:12 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170711140812.GA26934@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <cover.1496132443.git.mprivozn@redhat.com>
	<f8c84196122adc32f9067680e54a9de32a571756.1496132443.git.mprivozn@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f8c84196122adc32f9067680e54a9de32a571756.1496132443.git.mprivozn@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] qemu-bridge-helper: Take ACL file gid
 into account
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal Privoznik <mprivozn@redhat.com>
Cc: qemu-devel@nongnu.org

On Tue, May 30, 2017 at 10:23:35AM +0200, Michal Privoznik wrote:
> There's a problem with the way we currently parse ACL files. The
> problem is, the bridge helper has usually SUID flag set and thus
> runs as root in which case all the ACL files are parsed
> (/etc/qemu/bridge.conf and all other files it includes).
> Therefore, if there's say bob.conf owned by root:bob and I run
> the bridge helper, it doesn't really matter whether I'm in the
> bob group or not. Everything that is allowed to bob group is
> allowed to me too.

Ok so the ACL feature relies on the qemu-bridge-helper not having
privileges to read the files included from the master bridge.conf
file.

The easy way for this to work is if the qemu-bridge-helper binary
is given a filesystem capability eg

   setcap cap_net_admin=ep qemu-bridge-helper

in this mode, the bridge helper always runs with uid=500, gid=500,
so does not have permission to read included files which are group
owned by a different user.

If using SUID mode, the bridge helper would be given a custom
group and SUID privs

   chown root.qemu qemu-bridge-helper
   chmod ug+s qemu-bridge-helper

when it runs, it initially has effective uid=0 and effective gid=qemu

It then uses libcapng to drop privileges and change user ID, so that
it ends up with only cap_net_admin, and effective uid=500 and
effective gid=500 again.

So once again, it will be unable to read the included files which
are group owned by a different user.

IOW, I think everything is working normally.

The only scenario in which you can run SUID, and permissions do
not work would be if you compiled QEMU with libcapng support
disabled.

It would be wise to change the bridge helper to refuse to read
any included files with uid != 0 or gid != 0, if libcapng
support is disabled, so make it clear that permission checking
is inoperative.

Or better yet, just make libcapng mandatory when using the
bridge helper.

> The way this problem is fixed is whenever an ACL file is parsed,
> the group owner of the file is stored among with the rules so
> that it can be compared when evaluating.
> 
> There is one exception though. If an ACL file is owned by root
> group the rules within apply to all groups. This is because
> that's the usual setup currently (the bridge.conf is usually
> owned by root:root) and anybody from root group can plug the
> interface themselves anyway.
> 
> This idea of groups was introduced in bdef79a2994d6f0383 but got
> broken by ditros setting SUID onto the binary.

I don't believe it did, unless distros left out libcapng support
when building it.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
