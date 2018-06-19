Received: from eggs.gnu.org ([2001:4830:134:3::10]:52464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fVG7T-0004rH-Sh
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 08:52:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fVG7S-0005Fk-T2
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 08:52:23 -0400
Date: Tue, 19 Jun 2018 13:52:12 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180619125212.GU20929@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180615155103.11924-1-berrange@redhat.com>
	<20180615155103.11924-7-berrange@redhat.com>
	<20180619123138.GD2368@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180619123138.GD2368@work-vm>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 6/6] monitor: deprecate acl_show, acl_reset,
 acl_policy, acl_add, acl_remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>

On Tue, Jun 19, 2018 at 01:31:40PM +0100, Dr. David Alan Gilbert wrote:
> * Daniel P. Berrang=C3=A9 (berrange@redhat.com) wrote:
> > The various ACL related commands are obsolete now that the QAuthZ
> > framework for authorization is fully integrated throughout QEMU netwo=
rk
> > services. Mark it as deprecated with no replacement to be provided.
> >=20
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>=20
> OK, so I can do all these by using object_add/object_del with the right
> type and parameters?

It is a different paradigm for the way you manage it, but the end result
allows the same thing to be achieved, in a more flexible way.

With the old way, we precreated an ACL object for VNC, and then you
had to use these commands to add/remove individual  match rules and
or change the policy, etc. You could never create/delete the ACL itself.

With the new way, we have 4 different ACL implementations (so far)
and you can choose which to use. So you create the entire ACL with
all its rules populated atomically with object_add. There's no
create/delete of individual rules within the ACL, so if you want to
change rules you just delete the entire ACL & create it again. It
has failsafe to reject in case a client connects between the time
you delete and recreate.

One of the ACL impls allows storing the rules in a standalone text
file which we monitor with inotify. So in fact using that you can
update rules on the fly without needing QEMU interaction - just
change the content whenever needed.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
